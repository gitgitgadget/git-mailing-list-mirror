Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B58AC4743C
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 21:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05748613EA
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 21:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFDVOG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 17:14:06 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:40838 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFDVOF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 17:14:05 -0400
Received: by mail-ed1-f48.google.com with SMTP id t3so12645151edc.7
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 14:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Lsk3hVLBKpK2IAl970lSEXKpOQJp24OjH+LNaXiRquc=;
        b=jl9wIaYnhiIicxE7JleX5B+VlWUpWRsrmZGF1Dz8IyzHVvEsJDKgkV+Vo6XIHDm2Xi
         /F9Eqi2JI2mhOv9o1S6UYRkRrNXoAN/KMFFO8WAn5wkpeBOKK8bv4hw/BRLd/SrGGVGc
         sDgdp6uKLMOOCeZqYX4Odb457JCFWEd029rHOkFNtI46/N6urEvCfWVr5LZd34kYaiWJ
         j/yytQI6xQJcOnPdN7emdLIr5Ax/c8cSSo4KG2T0+zGGBX7wWL2+cuj1dkHcpK5fNCTn
         kcFTuWDi28VQvc5qveueyS81uLctWbBkuJq3DzGo9puxzmaSweXCsZ8xqO65xKSG6pJc
         ksCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Lsk3hVLBKpK2IAl970lSEXKpOQJp24OjH+LNaXiRquc=;
        b=WkFpjuutqx6UE3hManea9eRUPdSHN6ucssUm5YBpgwfyOTBjk8sDGpNkmokCEys2Zb
         P/09BVOaquGVF/J8OxA3Qr37/fRInAk/Df6t9bWYlILxhrIWzyPE/naxLWzhmEl0373Y
         vZPBl6L7p1rPv7dU/vr35hV5RGRgCz1o3X2PPAs0uPex5nU/4U0+l+0ielhZnpugmDO3
         owjdPOtmJrVqTCQhKRGLA5bXB/xEdrwTctHyVqPatvqkPUpjez/a5GjNRaxw1cQNNTNU
         ZOFY3Vz8/jfzoHnhhvNIes6uMK6UrDB8FDBIXtv3fT4M/2MaVl61vu8YAL/UxbeWHyFt
         57NA==
X-Gm-Message-State: AOAM532UjjVF3bNDYFPq18reU1oCbiYZWGzD1G0EHBi/itz+L44ipYlP
        ZB0qYsI+UfjXclKCEy/0pqI=
X-Google-Smtp-Source: ABdhPJzYwRV0yw229EnKDz7BQVxvmS9z2URSa2atjbIXRSzBd0EDMwzNOz4sHGP6od7Q30CfuWhrNQ==
X-Received: by 2002:a50:8dc6:: with SMTP id s6mr6909664edh.50.1622841077829;
        Fri, 04 Jun 2021 14:11:17 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n18sm3258578ejx.41.2021.06.04.14.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 14:11:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org
Subject: Re: [PATCH] t: use portable wrapper for readlink(1)
Date:   Fri, 04 Jun 2021 23:09:28 +0200
References: <20170720232040.GA159617@aiede.mtv.corp.google.com>
 <d0da02a8b6f0272fa70ae3b1dc80fee6c6ee8d18.1501111803.git.mhagger@alum.mit.edu>
 <87y2bv0yvl.fsf@evledraar.gmail.com>
 <YLkwCTcRT/9s8+5R@coredump.intra.peff.net>
 <YLk0Zm2J6VOA/lks@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YLk0Zm2J6VOA/lks@coredump.intra.peff.net>
Message-ID: <87r1hh5o97.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 03 2021, Jeff King wrote:

> On Thu, Jun 03, 2021 at 03:39:53PM -0400, Jeff King wrote:
>
>> > FWIW this broke tests on AIX because we can't assume readlink(1) exists
>> > at all. See d2addc3b96 (t7800: readlink may not be available,
>> > 2016-05-31) for a workaround.
>>=20
>> Hmm. So obviously we can use a fix similar to the one in t7800 (though
>> it's sufficiently complicated that I'd be tempted to wrap it in a helper
>> function). There are a few other calls that could be changed, too.
>
> Here's a patch to do that. Can you confirm that it fixes your test
> failure?

It does, thanks, t3210*.sh is broken on current master on AIX, fixed
with this patch. I don't have p4 on that machine (or any box I hack on),
so I can't test t9802*.sh.

> -- >8 --
> Subject: [PATCH] t: use portable wrapper for readlink(1)
>
> Not all systems have a readlink program available for use by the shell.
> This causes t3210 to fail on at least AIX. Let's provide a perl
> one-liner to do the same thing, and use it there.
>
> I also updated calls in t9802. Nobody reported failure there, but it's
> the same issue. Presumably nobody actually tests with p4 on AIX in the
> first place (if it is even available there).
>
> I left the use of readlink in the "--valgrind" setup in test-lib.sh, as
> valgrind isn't available on exotic platforms anyway (and I didn't want
> to increase dependencies between test-lib.sh and test-lib-functions.sh).
>
> There's one other curious case. Commit d2addc3b96 (t7800: readlink may
> not be available, 2016-05-31) fixed a similar case. We can't use our
> wrapper function there, though, as it's inside a sub-script triggered by
> Git. It uses a slightly different technique ("ls" piped to "sed"). I
> chose not to use that here as it gives confusing "ls -l" output if the
> file is unexpectedly not a symlink (which is OK for its limited use, but
> potentially confusing for general use within the test suite). The perl
> version emits the empty string.
>
> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t3210-pack-refs.sh       | 2 +-
>  t/t9802-git-p4-filetype.sh | 4 ++--
>  t/test-lib-functions.sh    | 6 ++++++
>  3 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
> index 3b7cdc56ec..577f32dc71 100755
> --- a/t/t3210-pack-refs.sh
> +++ b/t/t3210-pack-refs.sh
> @@ -253,7 +253,7 @@ test_expect_success SYMLINKS 'pack symlinked packed-r=
efs' '
>  	git for-each-ref >all-refs-packed &&
>  	test_cmp all-refs-before all-refs-packed &&
>  	test -h .git/packed-refs &&
> -	test "$(readlink .git/packed-refs)" =3D "my-deviant-packed-refs"
> +	test "$(test_readlink .git/packed-refs)" =3D "my-deviant-packed-refs"
>  '
>=20=20
>  test_done
> diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
> index 94edebe272..19073c6e9f 100755
> --- a/t/t9802-git-p4-filetype.sh
> +++ b/t/t9802-git-p4-filetype.sh
> @@ -263,7 +263,7 @@ test_expect_success SYMLINKS 'ensure p4 symlink parse=
d correctly' '
>  	(
>  		cd "$git" &&
>  		test -L symlink &&
> -		test $(readlink symlink) =3D symlink-target
> +		test $(test_readlink symlink) =3D symlink-target
>  	)
>  '
>=20=20
> @@ -329,7 +329,7 @@ test_expect_success SYMLINKS 'empty symlink target' '
>  	git p4 clone --dest=3D"$git" //depot@all &&
>  	(
>  		cd "$git" &&
> -		test $(readlink empty-symlink) =3D target2
> +		test $(test_readlink empty-symlink) =3D target2
>  	)
>  '
>=20=20
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index b823c14027..661f376077 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1692,3 +1692,9 @@ test_region () {
>=20=20
>  	return 0
>  }
> +
> +# Print the destination of symlink(s) provided as arguments. Basically
> +# the same as the readlink command, but it's not available everywhere.
> +test_readlink () {
> +	perl -le 'print readlink($_) for @ARGV' "$@"
> +}

