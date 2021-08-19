Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE0EC4320A
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 01:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA4D610A1
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 01:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbhHSBzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 21:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbhHSBzu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 21:55:50 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701DBC061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 18:55:15 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id a13so5595285iol.5
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 18:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L8fIBM7HsyUAqr+5dQSSuQ/NGcbNZQUYaC50vKOnP48=;
        b=GWTIo6oEJo3xfr30tmPGyA2Y3hN66bAKNEDkjliobUxwMdJCKGFcGeAwk/kUd6Gb5A
         6j9gCp7hnH0HOme8EmfzCNVsqxQpJDSjSzNS/KJSUQhL8BiNmqf3GmlP4X742Vu8RfB7
         l5X3AudBvCa6jezDxbYgvnnxpAJcxJ7KSR1BPAVCqFpcWz3lVZfymun0YX6zKldqi1y9
         yrDw1m3rnACxgCbMTwLNh5/bx2OhWoGTcBfwvc3GtfnfaTvf7P5eyOVUhuUEQQQpQ/XJ
         YEq8cFO+bgNEPhq6QQLhCEje+xO4KhOlwZNfW9ibVjvobQ4F842ON2l/03AjDnZp51nz
         UKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L8fIBM7HsyUAqr+5dQSSuQ/NGcbNZQUYaC50vKOnP48=;
        b=JASGHWra3DexlReomraMCA2SJ3eKyj0x8p6Sw4qoO8jGrW0DEFjBQ/HiuNgJIUsyZ/
         6MJm4aLDQqCIDgmKWC5BmMm7evHM4MvSFRvT9seZbxyuVotPKmT12sNOSiSLlXeoQJz5
         80LyszkpNgjeFLr/HN+4PP4ZWbY5JZuS6UwXrYPBqWx74/Cpn6+jfoXQTL0kt+SKexr4
         YsbW7pnlrNZlzfEBCHZu5kbk/6E4U+yBjrAztJxwQK19CwYKZlRDl/HKAco1gkuPqLRB
         YdKjGShhrBbmF6qjy/LWoRYYL3iYKM+jueeviuW64k8YJ+7Rywna62gXUKJLvO6FRhkd
         yh8Q==
X-Gm-Message-State: AOAM5318RX3nVYumIs1jazl3z0q8oqiv0S+3IbIvpoMyBBIlxNzHHUFW
        veJQDBl8cTLyC4GiZbmFMTE/6U/0kzDxPl9vrds=
X-Google-Smtp-Source: ABdhPJwkSlV3/eJqhKVP0JvWr0AHA2OhIlS7MYoHle2g058M/W3Tl4DjimHYIYlJ3eNo432mOTSsJeXDxvAoxUlLpI8=
X-Received: by 2002:a5d:9c53:: with SMTP id 19mr9811188iof.192.1629338114835;
 Wed, 18 Aug 2021 18:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1010.v4.git.1628936863733.gitgitgadget@gmail.com>
 <pull.1010.v5.git.1629075306706.gitgitgadget@gmail.com> <dcccd4af-e8b1-31e2-f271-4161ec4853d0@gmail.com>
In-Reply-To: <dcccd4af-e8b1-31e2-f271-4161ec4853d0@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 19 Aug 2021 09:55:03 +0800
Message-ID: <CAOLTT8T0A5_5sSxpJBSLgbbCWW61q6tVSesAAzf5SrhDxf1bcA@mail.gmail.com>
Subject: Re: [PATCH v5] [GSOC] cherry-pick: use better advice message
To:     phillip.wood@dunelm.org.uk
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8818=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:51=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Thanks for making the revert advice better as well
>

Thanks for reviewing too.

> >               else
> >                       advise(_("after resolving the conflicts, mark the=
 corrected paths\n"
> >                                "with 'git add <paths>' or 'git rm <path=
s>'\n"
>
> I think this last else arm should probably be a bug now as anything
> other than cherry-pick or revert should be setting GIT_CHERRY_PICK_HELP
>
>         else
>                 BUG("unexpected pick action in print_advice()");
>

Maybe you are right, If no one else will touch it, it may be
reasonable to set it as BUG().

> > diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick=
.sh
> > index 9d100cd1884..6766aed7282 100755
> > --- a/t/t3501-revert-cherry-pick.sh
> > +++ b/t/t3501-revert-cherry-pick.sh
> > @@ -158,4 +158,24 @@ test_expect_success 'cherry-pick works with dirty =
renamed file' '
> >       grep -q "^modified$" renamed
> >   '
> >
> > +test_expect_success 'advice from failed revert' '
> > +     echo dream >dream &&
> > +     git add dream &&
> > +     git commit -m "add dream" &&
>
> A minor comment: you can condense these three lines by using test_commit
> (see test-lib-functions.sh for the documentation)
>
>         test_commit "add dream" dream dream
>

Thanks, I may also need a --no-tag option, because "add dream" is not a val=
id
tag name.

> > +     dream_oid=3D$(git rev-parse --short HEAD) &&
> > +     cat <<-EOF >expected &&
> > +     error: could not revert $dream_oid... add dream
> > +     hint: Resolve all conflicts manually, mark them as resolved with
> > +     hint: "git add/rm <conflicted_files>", then run
> > +     hint: "git revert --continue".
> > +     hint: You can instead skip this commit: run "git revert --skip".
> > +     hint: To abort and get back to the state before "git revert",
> > +     hint: run "git revert --abort".
> > +     EOF
> > +     echo dream >>dream &&
> > +     git add dream &&
> > +     git commit -m "double-add dream" &&
>
> test_commit can also append to a file
>
>         test_commit --append "double-add dream" dream dream
>

Same too, test_commit --append --no-tag "double-add dream" dream dream

> This is looking very close to being ready now I think
>
> Thanks
>
> Phillip
>

Thanks.
--
ZheNing Hu
