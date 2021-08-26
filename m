Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBE2C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 06:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FD2610A1
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 06:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239440AbhHZG3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 02:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239046AbhHZG3f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 02:29:35 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1937BC061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 23:28:49 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id j18so2324426ioj.8
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 23:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XZh10Xwzl6Aci1TcvcpnEGY9AEyzzgVykg39IRxaqHc=;
        b=WNa+g3AABTMWlArqektFWhw39jue04sFJARZ0HJDfqcM9rKWYeehfD4n7mDtWMGr2F
         O1Hr/9HrbsoeVxk222vew8Sz6gEAz60E7It86dslUOMuZ5S5/cZpWO/0spezqB91Di7o
         ior+nlJelI9Ja9nm2p9I0rvDoyxKrS96WItClhziQjlEzl5aF+wBuNbqTvhXrC74OXqU
         0aU9a+EIqWd2ghCvdlWj3fEn2UrDr/54LEix56dFrO2EP76ch2Y/jLPqOjK8d4xmhxIC
         lFl7TnVKjKkS2ntCuyJi7dlvRjFCEHdnhLi8KkdAGlLBA6JxJ2H1hZPodZRy8/oEF1MT
         P45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XZh10Xwzl6Aci1TcvcpnEGY9AEyzzgVykg39IRxaqHc=;
        b=NIHH9j3ZAgBmO9dgOC68l6wTymakOo64wFmx5i/bjWuRzhmNcPWbROgxF1AUWgFA9n
         cctqjicVWz9wBM9rFYHi7TbREWLKBn1Sup0XAMQ56haO4UUV6DAup64zcp6LlG/PBMU5
         1WlgTdpcOhoXX71qq9+WQYyVfLk2UTvg6qb/kcJOXAHXzft0Q+gPnOCTVWXAELQ0NSHo
         a2xymRjdaOBr1ZBgvicF3SBG7dGItfMbLNqY8VsLRsODOhjxj0VWNKRYKEtHVrkW379T
         ehMQOCtxjKBj6fLGHSgPaggZKY2d5ElfRuTEhS8rGHJcP+rOeQzAmqUD5bZNPeJufYHZ
         a94g==
X-Gm-Message-State: AOAM531FFOPLmaIFkwSxOkIeNO+5dl7J0JGIrjFqL279AO25sSJw1UCC
        NeQ24fhdL2qYqNpdAFnISsQnQGGRdxUYEhk10bhA0sJAxZx2x0KQS1A=
X-Google-Smtp-Source: ABdhPJymBQSW+oZy6vwMuuerwo0Cz0W0qMyfs8lhxCFSIQv85O4Y/uEINVrK+dzbDzX5ah6UzZn0pDdSUnyXnKz+Epk=
X-Received: by 2002:a6b:6603:: with SMTP id a3mr1870555ioc.68.1629959328515;
 Wed, 25 Aug 2021 23:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <eda317b080a2e75a170c051c339a76115cce5ad7.camel@yandex.ru>
In-Reply-To: <eda317b080a2e75a170c051c339a76115cce5ad7.camel@yandex.ru>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 26 Aug 2021 14:28:37 +0800
Message-ID: <CAOLTT8QdbUOkacYEa812Qtam2Uc2Ug2cHR_iK=gLtsHTghZWZQ@mail.gmail.com>
Subject: Re: How to interactively rebase-and-reword nth commit?
To:     Konstantin Kharlamov <hi-angel@yandex.ru>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Kharlamov <hi-angel@yandex.ru> =E4=BA=8E2021=E5=B9=B48=E6=9C=882=
5=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:08=E5=86=99=E9=81=93=EF=
=BC=9A
>
> I think, one of the most frequent git features used is `rebase -i`. There=
's a common
> workflow I think everyone knows: you have commits 1, 2, 3, then you decid=
e "Nah, 2nd
> commit needs a change", so you do `git rebase -i HEAD~2`, then in popped =
up editor
> you modify the `pick` on the first line to become `edit`, then you do the=
 change,
> then `git rebase --continue`.
>
> The boilerplate part here: even though you know that you want to edit HEA=
D~2, there
> is no way to tell git that right away. Every time you have to launch edit=
or, edit the
> line manually, then save it, close it.
>
> I have seen here some discussions about improving that, someone even post=
ed patches,
> but I'm not aware if it went anywhere. So I created 2 years ago a shell w=
rapper
> `rebase-at`=C2=B9, which upon called as `rebase-at e HEAD~2`, does the th=
ing described
> above automatically. Under the hood I simply substitute EDITOR with `sed`=
 command
> that replaces `pick` on the first line (the HEAD~2 commit) with `e`. If u=
sed with
> shell autocompletion, it is now practically instantaneous.
>
> I'm almost happy with `rebase-at`, except I don't know of any way to make=
 it work
> with `reword` git action. You see, "rewording a commit" requires to run E=
DITOR twice:
> first to substitute `pick` with `reword`, and then to actually edit the c=
ommit
> message. But since EDITOR was substituted with sed, the 2nd run won't giv=
e you an
> actual editor to change the commit message.
>
> Any ideas, how can I tell `git` that I want to "reword" nth commit right =
away? Sure,
> I am not the first one to stumble upon it, am I? Any ideas?
>
> 1: https://github.com/Hi-Angel/dotfiles/blob/0b9418224e4ce7c9783dbc2d9473=
fd1991b9b0b2/.zshrc#L148-L160
>
>

Ha, this is simply a dream feature for me.
