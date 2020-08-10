Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B656C433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 10:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5791D20709
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 10:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lufia-org.20150623.gappssmtp.com header.i=@lufia-org.20150623.gappssmtp.com header.b="qWLtayAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgHJKyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 06:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgHJKx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 06:53:58 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD32C061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 03:53:58 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d188so5013170pfd.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 03:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lufia-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HW0wAbU6DPLizxm9rPQAv95MjXjZPte3Aq+RTrX4q60=;
        b=qWLtayAzPK+3wTPGpygV1O4hxNJAc0jUK+DmRd4hSkQt4YltujF9outUNczvzbyXcT
         e+AqT5Katgp9KfXZSh4DGpXHsUxOs2ZedHrmU9fwrbd+oQsIAou12bBctQq5qafVzX8e
         392Ci8Mjkylf6PCPLeOEyWjQzvPIXl+G5yMxp3u8aW4tqhc+SCUK3/ba+/3lPgYC0R5N
         0kT3JhBRFp2hCYX022WGmrIKpYYtfopu0BSWoDRJizKGoQNyFTbBp05s1ZJZuPpgT6a9
         hvkSIPflFZKqzyLS8zj3YWdMa0jnOldehJwJjroAlTKKU1nLc9FlZWhehFTyjIGp8hEb
         vgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HW0wAbU6DPLizxm9rPQAv95MjXjZPte3Aq+RTrX4q60=;
        b=Uo9WVuSWpqYRN3ft+Ne6oTbIIJP2a5KzdJGyXE04GVnR9zIF2DerjxGTezBq7RGGHl
         UNFldpv9kfeyoBGMNu9LzX9Gpe/KcxubfxVucdFH1RjhZ4rc7ddB28t85M3J3Pw+Qlnv
         /7j3SlVWnu+OsNO+t2SySdqyVIXg+vh82c4NKrxt7X49Ne67s1FPwoYiaz3NplQJhRpo
         QVu7P3adYRYHGR09kRfUquJmZ8swan8ovT6rLbvVZrJ9St6LrK9lff7jly64KAuB8nNh
         CBHbr6d4q4wqJiYKz7sgrmbXNnQ6JGUxzdg1eXCk9l66AujgWYjdwaAiH5bcGVJcoF10
         WWLQ==
X-Gm-Message-State: AOAM530XM0BzNEv/MnC8lwgPDzEYyIEOxqJwMHniJBP7rU0XaOdCnFlc
        KVtsj7pwDlh0bCVGy0+DofLjYFIEZy8PtUQ1Ce9XdQ==
X-Google-Smtp-Source: ABdhPJxqmUGruf7XGEG7j2VmO0Ip+/D5yewyKcd3a6ZsxrLafG4L8FZYp8o34pIdVpkhPR+ZAV6LiJ7czJZwPyLdXDY=
X-Received: by 2002:aa7:9f1b:: with SMTP id g27mr283802pfr.215.1597056837701;
 Mon, 10 Aug 2020 03:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.694.git.1596675905.gitgitgadget@gmail.com>
 <d15ed626de65c51ef2ba31020eeb2111fb8e091f.1596675905.git.gitgitgadget@gmail.com>
 <20200806020407.GR6540@camp.crustytoothpaste.net> <xmqq5z9vlk5q.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq5z9vlk5q.fsf@gitster.c.googlers.com>
From:   Kyohei Kadota <lufia@lufia.org>
Date:   Mon, 10 Aug 2020 19:53:46 +0900
Message-ID: <CAFMepckAe9r1O8xrQemytHoZKeyLSjEpfdH=yP=+SzKPoCOf8w@mail.gmail.com>
Subject: Re: [PATCH 3/4] Fit to Plan 9's ANSI/POSIX compatibility layer
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        lufia via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > I will note that usually the project prefers to have a human's personal
> > name here and in the commit metadata instead of a username.  Junio may
> > chime in here with an opinion.
>
> Thanks, I just did.
>
> >>  command_list () {
> >> -    eval "grep -ve '^#' $exclude_programs" <"$1"
> >> +    eval "grep -v -e '^#' $exclude_programs" <"$1"
> >
> > Is it really the case that Plan 9's grep cannot deal with bundled short
> > options?  That seems to be a significant departure from POSIX and Unix
> > behavior.  Regardless, this should be explained in the commit message.
>
> I am not interested in this ball of wax, but there are some pieces
> that are worth salvaging.  This is one of those good bits.
>
> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index 9db2f4feab..a7cc01caf9 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -26,7 +26,7 @@ else
>         VN="$DEF_VER"
>  fi
>
> -VN=$(expr "$VN" : v*'\(.*\)')
> +VN=${VN#v}
>
>  if test -r $GVF
>  then
>
> BUT.
>
> Dealing with "grep" that cannot take "-ve" and forces developers to
> spell it as "-v -e" is not one of them.  So is forbidding use of
> "cut".

I see. I will rewrite Plan 9's ape/grep to handle bundled options well.

> >>  get_categories () {
> >> -    tr ' ' '\n'|
> >> +    tr ' ' '\012'|
> >
> > Okay, I guess.  Is this something we need to handle elsewhere as well?
> > The commit message should tell us why this is necessary, and what Plan 9
> > does and doesn't support.
>
> Yeah, POSIX does want you to understand '\n' and others, but this is
> within reason for portability that I think we could swallow.

I'm happy, thanks.

> >> +if test -z "$(echo -n)"
> >> +then
> >> +    alias print='echo -n'
> >> +else
> >> +    alias print='printf %s'
> >> +fi
> >
> > Let's avoid an alias here (especially with a common builtin name) and
> > instead use a shell function.  Maybe like this (not tab-indented):
> >
> >   print_nonl () {
> >     if command -v printf >/dev/null 2>&1
> >     then
> >       printf "%s" "$@"
> >     else
> >       echo -n "$@"
> >     fi
> >   }
>
> I'd rather not to see this done; "echo -n" and "echo '...\c'" are
> not portable and we do want people to use 'printf'.  This directly
> goes against it.
>
> > This is also going to need some patching in the testsuite, since we use
> > printf extensively (more than 1300 times).  I do hope you have perl
> > available.
>
> Eh, so what would Plan9 people do with Perl?  Write a single-liner
> 'printf' script and put it in a directory on their $PATH?
>
> I am not sure if it is worth crippling the toolset our developers
> are allowed to choose from and use in our scripts and tests like
> this patch tries to do.

Like other topics, I decide to implement printf(1).
These new POSIX tools will be installed to Plan 9 systems
from other repo or patches before building git.

> If this were Windows, it might have been a different story, but what
> we are talking about is Plan 9, which had the last "fourth edition"
> in 2002, right?  During the 18 years since then, none of its users
> and developers work on porting many OSS packages, whose primary user
> base are on POSIXy systems, to it and we need to apply patches like
> these to each and every OSS packages of interest?  I would have
> expected that any exotic-minority-but-thriving-platform would be
> able to tell its users "here are ports of POSIXy programs---install
> them and it can become usable by those who only know Linux"?
>
> So, I dunno.

Final official distribution from Bell labs was released in Jan 2015.
Now, There are some distributions that forked from official Plan 9 and
are maintained by that community,
such as 9legacy, 9front or others.

I will try to implement POSIX toolsets if it is needed because POSIX
is a large spec.
Thanks for your advice.
