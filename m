Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A274C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 04:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24DA261428
	for <git@archiver.kernel.org>; Thu, 13 May 2021 04:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhEMEym (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 00:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhEMEym (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 00:54:42 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114E9C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 21:53:32 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id z3so23094196oib.5
        for <git@vger.kernel.org>; Wed, 12 May 2021 21:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQ5sHHcUqE7AxQlhal6zB8vt/VHfDH7Gt2T5ZALpExo=;
        b=sFyxgIEyNfsAebsJV5q2sr64vt9fy7BiS7IGwa1qhezdV1GbSxYhamXrmbzOr0C4fJ
         fVFm0RN6BGgPaPe36R2BcVKmbk3Kmt8Ec5v6faVd1qrVYM9h0XvZgZJyl4jUmOIk4jpo
         eH+tw6drqK1vSVHGL2iIf6ZZqdL3CBt/NaWrHNdQNQCYe2lmviHbkEVMfMEKWPkAPS6o
         hIgKeXhII5Dgp8dFgnTJ8OIMKNkAovSLPm/8fkXtn1e8VRoYoKqwlO3iBAUKjANeFMMu
         lw6gpJ12R1JDA+J6WkdCzb29WOuEg2cbdGEvF025xDIjDGBclRDju/PhSnKRLwj3vbZ9
         9+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQ5sHHcUqE7AxQlhal6zB8vt/VHfDH7Gt2T5ZALpExo=;
        b=Plap5C0mZwtvamaeQ1R8Bkltp1rLe+iKyu9GDRzCr/czE1opw2hrZ5XsGTlIMnv/Y9
         WTvakVaBuEaRAJ2jZt2Q6HOAbNKCKMSfwGDr/LcFfX8rgfG4anrv/3pTwetw6dXAyIBe
         S/1i/bf5YFdM2w1MkKr7iOCmyQR+VNHtX2UJzYkgYQieFurxznzm/dmI8FGwiwBRF3d8
         qsMyhGlIY9dAoV3a+v8px+fmoTpPF5D7QV3ST6sY5NZ4eLpReAdEZFnnrQLMWeaSXjKQ
         V3Jfgwj73hxN3C7ji8d6K1S5YIB+5ZJ6vVLYvGqHkzQ2MJxhq8Y/iKy9DOMnwjXSmh+K
         Y8Sg==
X-Gm-Message-State: AOAM531sh/F2HwiIvJf1JLb7VvAy+3NpdAoItFfXFvFG1yEkPwZXnF4r
        l7x2ms/+gw+i1i0XBozjbM2GumfRyIbcjEmchSdmBuPMpTg=
X-Google-Smtp-Source: ABdhPJx1j/TEzvw2EABlfKTf35Ji1N3cdedmO0Y9iwzOf6zxmtZKiM20DblP5iRF5lLZ8MsWuVL2n0RfOqSqv8HazBk=
X-Received: by 2002:aca:30cd:: with SMTP id w196mr1551801oiw.167.1620881611505;
 Wed, 12 May 2021 21:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <f1fc174b10ca5bc8b54ede513bc79e3864d8e014.camel@scientia.net>
 <xmqq4kf7cmaj.fsf@gitster.g> <xmqqzgwzb7ad.fsf@gitster.g>
In-Reply-To: <xmqqzgwzb7ad.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 12 May 2021 21:53:20 -0700
Message-ID: <CABPp-BGERNLKbLA_r7i7+r+v7YK6xT00_5n9ebESb2SzLhC0Cg@mail.gmail.com>
Subject: Re: git-sh-prompt: bash: GIT_PS1_COMPRESSSPARSESTATE: unbound variable
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christoph Anton Mitterer <calestyo@scientia.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 12, 2021 at 9:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Christoph Anton Mitterer <calestyo@scientia.net> writes:
> >
> >> Could it be that git-sh-prompt no longer works properly?
> >>
> >> With git 2.31.1:
> >> $ . /usr/lib/git-core/git-sh-prompt
> >> $ PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
> >> $ cd someGitRepo
> >> bash: GIT_PS1_COMPRESSSPARSESTATE: unbound variable
> >> $
> >
> > Would
> >
> >     $ set +u
> >
> > fix it, I have to wonder?
>
> Assuming that the answer is yes,...
>
> I do not know who maintains this contrib/ script, but here is what
>
> $ git grep -e '\$GIT_PS1_' -e '\${GIT_PS1_[^}-]*}' contrib/completion
>
> gave me a handful candidates for fixes.  Randomly picking Elijah from
> the output of
>
>     $ git shortlog --no-merges -sn --since=18.months  \
>         contrib/completion/git-prompt.sh |
>       head -n 1
>
> for ideas.

Yeah, I accidentally was relying on undefined-translates-to-empty,
which breaks under set -u.  I can duplicate the precise error, and
your fix below is exactly how I fixed it too, before seeing you posted
the same fix.

I'll post a patch with you as author...and some questions on what to
do with the rest of the commit message and attribution tags.

> Thanks.
>
>  contrib/completion/git-prompt.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git i/contrib/completion/git-prompt.sh w/contrib/completion/git-prompt.sh
> index 4640a1535d..b9485f4016 100644
> --- i/contrib/completion/git-prompt.sh
> +++ w/contrib/completion/git-prompt.sh
> @@ -139,7 +139,7 @@ __git_ps1_show_upstream ()
>
>         # parse configuration values
>         local option
> -       for option in ${GIT_PS1_SHOWUPSTREAM}; do
> +       for option in ${GIT_PS1_SHOWUPSTREAM-}; do
>                 case "$option" in
>                 git|svn) upstream="$option" ;;
>                 verbose) verbose=1 ;;
> @@ -433,8 +433,8 @@ __git_ps1 ()
>         fi
>
>         local sparse=""
> -       if [ -z "${GIT_PS1_COMPRESSSPARSESTATE}" ] &&
> -          [ -z "${GIT_PS1_OMITSPARSESTATE}" ] &&
> +       if [ -z "${GIT_PS1_COMPRESSSPARSESTATE-}" ] &&
> +          [ -z "${GIT_PS1_OMITSPARSESTATE-}" ] &&
>            [ "$(git config --bool core.sparseCheckout)" = "true" ]; then
>                 sparse="|SPARSE"
>         fi
> @@ -543,7 +543,7 @@ __git_ps1 ()
>                         u="%${ZSH_VERSION+%}"
>                 fi
>
> -               if [ -n "${GIT_PS1_COMPRESSSPARSESTATE}" ] &&
> +               if [ -n "${GIT_PS1_COMPRESSSPARSESTATE-}" ] &&
>                    [ "$(git config --bool core.sparseCheckout)" = "true" ]; then
>                         h="?"
>                 fi
