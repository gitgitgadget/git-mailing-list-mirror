Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7752CC2B9F4
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 00:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59689611CE
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 00:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFWA4Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 20:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhFWA4P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 20:56:15 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AECC061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 17:53:58 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id g4so1051745qkl.1
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 17:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j92v1l5E7PFAg5zI7h4JE/OY+BqAZbb6lEK93IKJlak=;
        b=LDcVdr9UxBllDFRZ9N2839eiHqY/LWRoem2lnzNIN/LjlAAkFJvdCozg7lDW8lI+VG
         K/MQ/BZQCu0hAIjZ/uso27bauhglBnn3O49LyDExx8Pqgb0vHt/1YwS2ME+JbyDwarrM
         5kfP4bqQsoYgDTLFSLEjdIpU/hNvWTm0wJc07cGaO+MajOjZ9rimsAuBvzBsM3519ER9
         WKN9z35juemLLH6WG8RCHgPYn4GcVd/Ji5Be+aH8j1RHuFtd0a4pcXWe/0YqGfYmNI2M
         Ecvz2DGgPI1t+kNOSvxjyvZnauiY6qGRRqtG037/5u+Ih/3YqKtSpex5fAYTlHB+KfZd
         XinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j92v1l5E7PFAg5zI7h4JE/OY+BqAZbb6lEK93IKJlak=;
        b=BWvSh+4q7/In6QlP2Z7Tbot3g9GtOL/ZhKOdxA71yv8Ty59G6SzsJCbXUAwZ+SBsIJ
         +ADLQbdf7IOcuBJh/aYZvjdsKWVtUoJ+OkicjbU0ZyVTcrqglXLyVQhR2TKjjqs7DM+i
         kPGtlEKnFJiKmxePjcON+TPtvR2JlnEFSa2USO4y+hw2b9J5onCoMwqcdcgZ6wwOvW/R
         oB5BOr/JANGIDo1o+Lgt2JVLI3kPZ6hdIqJdWKybYeF5Dm08FOOAeP7cvoza3lwyr+cN
         04Bcgk3mQt/wr60g1ayAkb1/bSLPxEIMkF7Girba/nW4T/+kNyxAsxhylst6cHA7HCUA
         A7gQ==
X-Gm-Message-State: AOAM532xiywY2lRnIr2NId34Quvv99DQE8D9uSYMOukyVqgsh9n2xt5E
        fLZP9+f+UHm8kwUeYecUJLPFQOciPiJgLi/T/Io=
X-Google-Smtp-Source: ABdhPJxK6/zaJJVexljPt+czqnkQ8AJPaEzkMXljcSMamrrCBA7MVBKLCABhlS7Q4K+lnEDvgWrN4mqbJM2FFNRqTlc=
X-Received: by 2002:a25:25c5:: with SMTP id l188mr8313725ybl.41.1624409637577;
 Tue, 22 Jun 2021 17:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210617124331.17888-1-zhiyou.jx@alibaba-inc.com> <878s313krl.fsf@evledraar.gmail.com>
In-Reply-To: <878s313krl.fsf@evledraar.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 23 Jun 2021 08:53:46 +0800
Message-ID: <CANYiYbGCOJvVqVhWkSfAStwCF8D-U7_H=kVa6hK-oRqtmPg_dg@mail.gmail.com>
Subject: Re: [PATCH 1/2] test-lib-functions: test_create_repo learns --bare
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=E5=
=B9=B46=E6=9C=8823=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8812:51=E5=86=
=99=E9=81=93=EF=BC=9A
>
>
> On Thu, Jun 17 2021, Jiang Xin wrote:
>
> > "test_create_repo" learns --bare option to create bare repository.
> >
> > Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> > ---
> >  t/test-lib-functions.sh | 22 +++++++++++++++++++---
> >  1 file changed, 19 insertions(+), 3 deletions(-)
> >
> > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> > index b823c14027..f6d1afe295 100644
> > --- a/t/test-lib-functions.sh
> > +++ b/t/test-lib-functions.sh
> > @@ -1216,8 +1216,21 @@ test_atexit () {
> >  }
> >
> >  # Most tests can use the created repository, but some may need to crea=
te more.
> > -# Usage: test_create_repo <directory>
> > +# Usage: test_create_repo [--bare] <directory>
> >  test_create_repo () {
> > +     bare=3D &&
> > +     while test $# -gt 0
> > +     do
> > +             case "$1" in
> > +             --bare)
> > +                     bare=3Dyes
> > +                     ;;
> > +             *)
> > +                     break
> > +                     ;;
> > +             esac
> > +             shift
> > +     done &&
> >       test "$#" =3D 1 ||
> >       BUG "not 1 parameter to test-create-repo"
> >       repo=3D"$1"
> > @@ -1226,10 +1239,13 @@ test_create_repo () {
> >               cd "$repo" || error "Cannot setup test environment"
> >               "${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" -c \
> >                       init.defaultBranch=3D"${GIT_TEST_DEFAULT_INITIAL_=
BRANCH_NAME-master}" \
> > -                     init \
> > +                     init ${bare:+--bare} \
> >                       "--template=3D$GIT_BUILD_DIR/templates/blt/" >&3 =
2>&4 ||
> >               error "cannot run git init -- have you built things yet?"
> > -             mv .git/hooks .git/hooks-disabled
> > +             if test -z "$bare"
> > +             then
> > +                     mv .git/hooks .git/hooks-disabled
> > +             fi
> >       ) || exit
> >  }
>
> It looks like you authored this before, but sent this after f0d4d398e28
> (test-lib: split up and deprecate test_create_repo(), 2021-05-10) was
> merged down.
>
> Your 2/2 here looks like it's not needed after my 97c8aac9c5f (test-lib:
> do not show advice about init.defaultBranch under --verbose, 2021-05-10)
> either.

Thanks =C3=86var for reminding this.
