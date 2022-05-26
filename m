Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32650C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 00:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243842AbiEZA1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 20:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243117AbiEZA1R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 20:27:17 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD79628992
        for <git@vger.kernel.org>; Wed, 25 May 2022 17:27:15 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g20so3388560edj.10
        for <git@vger.kernel.org>; Wed, 25 May 2022 17:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=oUVOrxAGZL+h9YPpMRJcV1HJItLIYgSLIJRH+4c11Nw=;
        b=WsDUFyWRI1CJA4T2bTqSomfM4BFuTMqBFn8XittBIuBJ8SKZHcFNN2N7huQPllMIJh
         XFTh4a4UXyKZGL8AzDUcZc8EaVFnKDchlvaoccIk7k+iVHd1nTw2i/8Mdqd4xjYV+ym+
         492p9qzS/NSgyYHHzuH1QC+Fd2LXhYxZo68J6wWogcfYKkWLG4gifOY0+TVuhQ0JnbYX
         R4gGUiNTNTmKLCiwd29EcBqznAQTyr1K9dPis3s4dsv3d+dWozzkN18S7sS3BuZqP9AM
         0nBNHaEBIIpcAbsgzHfG9XaEX581zrK1ZQG8EGeXPx1EfQcLzQP5XbgiE0KWt10PR1UZ
         2CDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=oUVOrxAGZL+h9YPpMRJcV1HJItLIYgSLIJRH+4c11Nw=;
        b=qYwlo45Gnvy4+Mc5eKCfLXQuSPqSGOm3MXjFj8ijyKbzfogpUJ1BfUqkb/Q8Np6DCr
         5aw9gGvKP5AjCsq+IbxCd/0KSKOtbI/IHV6PJDLTlK72jWUnOsBcVjX1K3jZz+MC75Yz
         BUsSQSJpZEOZDdAN7xN22+bS/AjXmSDwqOQ3viruYPcLL9Fe8jDlbqZ2xBGb/KWL2hJ3
         SigyeTY0m/2LFX4gAqAkMa632H8N+T/3I9f+HOigue/fb2MSM3YbqHcOIN6Xe+TZpPez
         hVhT5XC/J131uWSSciRfesbW7v1bs+u7leYFv9o0NRy0G76DlCH2nZSWeutjZ8LQv0Ww
         uM9Q==
X-Gm-Message-State: AOAM532Q5j3hHRHWw9LDm9KL3uu6SFPpIhqN7mblzqgWTg+TBuUBRenW
        NfhtBL10XlTq+eIWvFGh7eCRu4cli0ISDQ==
X-Google-Smtp-Source: ABdhPJzKRHpo2uaSRdUFNU2Gq2iGmOKQKFvtTnTEPg1nwyP9lgguTYJ8FeJMpOmCCkJ1ycxxWT33Xw==
X-Received: by 2002:aa7:de8a:0:b0:42a:b51a:554c with SMTP id j10-20020aa7de8a000000b0042ab51a554cmr37994221edv.318.1653524834302;
        Wed, 25 May 2022 17:27:14 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id z19-20020a170906715300b006f3ef214e0esm28152ejj.116.2022.05.25.17.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 17:27:13 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nu1LN-0007iV-7D;
        Thu, 26 May 2022 02:27:13 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Makefile: build 'gitweb' in the default target
Date:   Thu, 26 May 2022 02:14:33 +0200
References: <20220525205651.825669-1-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220525205651.825669-1-szeder.dev@gmail.com>
Message-ID: <220526.86k0a96sv2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 25 2022, SZEDER G=C3=A1bor wrote:

> Our Makefile's default target used to build 'gitweb', though
> indirectly: the 'all' target depended on 'git-instaweb', which in turn
> depended on 'gitweb'.  Then e25c7cc146 (Makefile: drop dependency
> between git-instaweb and gitweb, 2015-05-29) removed the latter
> dependency, and for good reasons (quoting its commit message):
>
>   "1. git-instaweb has no build-time dependency on gitweb; it
>       is a run-time dependency
>
>    2. gitweb is a directory that we want to recursively make
>       in. As a result, its recipe is marked .PHONY, which
>       causes "make" to rebuild git-instaweb every time it is
>       run."
>
> Since then a simple 'make' doesn't build 'gitweb'.
>
> Luckily, installing 'gitweb' is not broken: although 'make install'
> doesn't depend on the 'gitweb' target, it runs 'make -C gitweb
> install' unconditionally, which does generate all the necessary files
> for 'gitweb' and installs them.  However, if someone runs 'make &&
> sudo make install', then those files in the 'gitweb' directory will be
> generated and owned by root, which is not nice.
>
> List 'gitweb' as a direct dependency of the default target, so a plain
> 'make' will build it.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index f8bccfab5e..ee74892b33 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2188,6 +2188,8 @@ ifneq (,$X)
>  	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMAN=
DS_TO_INSTALL) git$X)), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
>  endif
>=20=20
> +all:: gitweb
> +
>  all::
>  ifndef NO_TCLTK
>  	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) gitexecdir=3D'$(gitexec_instdi=
r_SQ)' all

In various recent patches & some upcoming ones I plan to submit I've
been trying to get the runtime of a noop "make" runs down, which really
helps e.g. with "git rebase -x make ..." running faster on a large
series.

While you're right that this wasn't intentional to begin with, we have
lacked the "gitweb" as part of the default target since v2.4.5 now, and
adding it back is a major performance regression on noop "make" runs:
=09
	$ git hyperfine -L rev HEAD~1,HEAD~0 -L t Y, -s 'make' 'make NO_TCLTK=3D{t=
}' --warmup 1 -r 5
	Benchmark 1: make NO_TCLTK=3DY' in 'HEAD~1
	  Time (mean =C2=B1 =CF=83):     103.6 ms =C2=B1   1.1 ms    [User: 83.8 m=
s, System: 32.1 ms]
	  Range (min =E2=80=A6 max):   102.2 ms =E2=80=A6 105.2 ms    5 runs
=09=20
	Benchmark 2: make NO_TCLTK=3DY' in 'HEAD~0
	  Time (mean =C2=B1 =CF=83):     191.4 ms =C2=B1   1.6 ms    [User: 151.0 =
ms, System: 60.5 ms]
	  Range (min =E2=80=A6 max):   189.2 ms =E2=80=A6 193.3 ms    5 runs
=09=20
	Benchmark 3: make NO_TCLTK=3D' in 'HEAD~1
	  Time (mean =C2=B1 =CF=83):     272.0 ms =C2=B1   5.0 ms    [User: 206.3 =
ms, System: 83.3 ms]
	  Range (min =E2=80=A6 max):   266.7 ms =E2=80=A6 277.3 ms    5 runs
=09=20
	Benchmark 4: make NO_TCLTK=3D' in 'HEAD~0
	  Time (mean =C2=B1 =CF=83):     358.3 ms =C2=B1   1.4 ms    [User: 282.7 =
ms, System: 104.0 ms]
	  Range (min =E2=80=A6 max):   356.6 ms =E2=80=A6 360.0 ms    5 runs
=09=20
	Summary
	  'make NO_TCLTK=3DY' in 'HEAD~1' ran
	    1.85 =C2=B1 0.02 times faster than 'make NO_TCLTK=3DY' in 'HEAD~0'
	    2.63 =C2=B1 0.06 times faster than 'make NO_TCLTK=3D' in 'HEAD~1'
	    3.46 =C2=B1 0.04 times faster than 'make NO_TCLTK=3D' in 'HEAD~0'

I.e. this is with your patch here applied as HEAD~0 and HEAD~1 being
'master'.

I think given that that a better solution would be to just declare this
as a feature at this point, especially as gitweb/INSTALL notes that the
way to install it is:

        $ make prefix=3D/usr gitweb                            ;# as yourse=
lf
        # make gitwebdir=3D/var/www/cgi-bin install-gitweb     ;# as root

Or we could just fold gitweb/Makefile into the main Makefile, unlike
gitk and git-gui it's not externally maintained, and most of it is
shimmying to work around not being part of the main Makefile (which it
strongly inter-depends on anyway).
