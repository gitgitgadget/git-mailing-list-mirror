Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1CEC433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 16:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiEFQ6c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 12:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443975AbiEFQ6a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 12:58:30 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDFC6D4E4
        for <git@vger.kernel.org>; Fri,  6 May 2022 09:54:46 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id i186so7733642vsc.9
        for <git@vger.kernel.org>; Fri, 06 May 2022 09:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ViK5okudcjxTyaldo2hTGhjNYEB5YuJVHBSuhRTAztk=;
        b=o9uMdhISXavJJppQobsdKOTwb2YEUlPb1VhsPkqzzVxFeMfPOP13DR/zy/s28pRfpY
         vVblRSCFFruP904OkR5LZ8Q31GkjpNEblTpaqE06Dg4VZ9EGANxJqMqZChPHPTUpcGOv
         2pIOosx/qJpF7nrUMSvo2avBrjwvvjVsSOZozRPvi1ZtsEkF6HX0c06DihcJxggzJaEX
         XC0Vxn5eFL0PtiDINHfm+aLFh6op4i8wIQQiwXioYiqNqY/ZJEXgszVJfP7zBOqOCbTt
         yzH0xFNbgWXBOsdSmLHcgPHw7HVLmejp/zaD01jD0G3O56VnPDjMUqbtEnrmqPx9zFZZ
         gWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ViK5okudcjxTyaldo2hTGhjNYEB5YuJVHBSuhRTAztk=;
        b=kjo1iUUVdLThzvI02CIUjV1fpyA/A50QZ2gXFyfl2GVZdHxvkFKD5VDA97iM8ekjDV
         fwjCkaO2uzvvb8zvUggeWAkVe/Dd05sRLhYw8ojYmaxJ7ZRkRIzJNj4z+NVjQtG/vgo3
         BVXynq123ce2rg+x0SKXluo+Cb0A+kPA59phPDnMZxfqoDOT3nZH0BAqhpyJOp+55t1i
         FmiRlYGzpNCn/I4CQ4lRbxluvGNGJuchK2yD2Gh3Otwz7MYTxKoWVcemvBCnvgPm4M81
         1vdFOoLVzSaEd0iA+6TAuev/93v/AwwcxgZcYc3p+lysUzHM2Y60/hKaJvxeuBf9TlO1
         Z/fA==
X-Gm-Message-State: AOAM530JIYWiABKWImnLW7xMF24ykE6Kr07kgcFISzlyIxNdoPfND/yq
        2GIzLiN0lVGDRB7hwlMo32gEc+GIKr4FqvBWlWrs8D5nPqw=
X-Google-Smtp-Source: ABdhPJyE4OW9FIDUgfm+KSE2fxPdnIcPQ0CcRfDfVdJj6+Fe09nlhuy3hLVPcetqaLK2yeA7PbpYc5zXPp2bjyUDR8c=
X-Received: by 2002:a67:c905:0:b0:32c:69bd:18a3 with SMTP id
 w5-20020a67c905000000b0032c69bd18a3mr1540967vsk.5.1651856085936; Fri, 06 May
 2022 09:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220428105852.94449-1-carenas@gmail.com> <20220503065442.95699-1-carenas@gmail.com>
 <20220503065442.95699-4-carenas@gmail.com> <af4dd56d-f301-9c3d-2fc3-929a24596e82@gmail.com>
In-Reply-To: <af4dd56d-f301-9c3d-2fc3-929a24596e82@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 6 May 2022 09:54:32 -0700
Message-ID: <CAPUEspjjapB1u=_obNFE1gvrsCjFN3oVfPV=7mBG+aGDqnPR1Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] t0034: enhance framework to allow testing more
 commands under sudo
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, gitster@pobox.com, bagasdotme@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 3, 2022 at 7:12 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> > diff --git a/t/lib-sudo.sh b/t/lib-sudo.sh
> > new file mode 100644
> > index 00000000000..9ebb30fc82b
> > --- /dev/null
> > +++ b/t/lib-sudo.sh
> > @@ -0,0 +1,13 @@
> > +# Helpers for running git commands under sudo.
> > +
> > +# Runs a scriplet passed through stdin under sudo.
> > +run_with_sudo () {
> > +     local ret
> > +     local SH=${1-"$TEST_SHELL_PATH"}
>
> What use do you envisage for this? It would be simpler just to use
> $TEST_SHELL_PATH directly below

Since this function is a ripoff of write_script which has this feature
(except I changed the shell used), I thought it might come handy later
and that getting the first version with a hardcoded value wasn't
elegant enough, but you are right it is not needed, so is gone in the
next RFC.

> > +     local RUN="$HOME/$$.sh"
>
> Can we use a fixed name for the script? That would make things simpler
> especially debugging as one would know what file to look for. Also using
> $TEST_DIRECTORY rather than $HOME would make it clear where the file
> ends up.

Frankly (and speaking by experience because this broke a lot for me),
debugging is painful enough already that having to find the shell
script would be the least of your concerns.

The main reason why it is not hardcoded to a known name is that by
adding a slightly more random name, it makes it slightly more
difficult for someone to try to trick us into running something else
they prepared instead, and the fact that it will be run as root makes
it much more enticing.

Sorry about not using TEST_DIRECTORY to begin with, they are set to
the same value and thought HOME was clearer and shorter, but has been
fixed in the next RFC.

> > +     write_script "$RUN" "$SH"
> > +     sudo "$SH" -c "\"$RUN\""
>
> I think using write_script means we can just do 'sudo "$RUN"'

We could, but by doing it this way we ensure:
* we specifically require sudo to allow running a shell, and that
shell is the one we want it to run (a strict sudo wouldn't do that)
* we obscure a little bit what sudo is running from it and rely more
in the shell, so it won't try to be helpful and block it (running
shell scripts is something a strict sudo might not allow as well)

On that last point I am still debating if the prerequisite should be
enhanced to detect that case and fail, but since it is restrictive
enough already it might not be worth doing now.

> > -# this MUST be always the last test, if used more than once, the next
> > -# test should do a full setup again.
>
> Why is the comment being changed? If you want the shorter version at the
> end of this patch can't we just use that wording in patch 1?

It was my failed attempt to document better how they are used, since
they are tricky enough to use already, but it is no longer needed and
is gone in the next RFC.

> > +test_expect_success SUDO 'cannot access with sudo' '
> > +     (
> > +             # TODO: test_must_fail needs additional functionality
> > +             # 6a67c759489 blocks its use with sudo
> > +             cd root/p &&
> > +             ! sudo git status
> > +     )
> > +'
>
> I think Junio suggested that this should work and showed it was simple
> to make it work. It seems funny that if sudo is started as root it does
> not work.

It is not when sudo is started as root, but when the user runs `sudo
-s` to get a shell and then LATER tries to use git with that shell.

I make a better attempt to explain it in a different thread[1], and is
tied to the documentation patch which might need further improvements
to make clear (hopefully not as extensive as my attempts to do so)

I am instead marking it as a known bug for the next RFC

Carlo

[1] https://lore.kernel.org/git/20220429012438.37o4uaxsrfdu2b6x@carlos-mbp.lan/
