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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773DAC433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 11:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25C3823899
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 11:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbhAULGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 06:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730055AbhAULFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 06:05:25 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C02C061575
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 03:04:24 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id x137so465229oix.11
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 03:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O+Xb8XfYLBY+q2gjVoxrXjNYTsXkPIxAR/NplZM1Ong=;
        b=bmWbEmljW52rSbOiIgIJ/fcAnNtREI2gdmbzw4WF5+Tvli/5FmDx7bMlbM5BIbPQhd
         fkqpOzaCONG0twO5+VXHJ7nJIj48ijhR5XEpPX8cAik6ZdW39ASHp+XCt42py64jZOsv
         XC0kgA9XAD7Jf9aLhpJwCDk3JI5eT8Vyp0y1PZGnxMNVvwaqn9SaswHmB+14vrL0Vk9S
         5IdnQKTz5CNLsa2v6wUMa53rP3fefdEp0hPlS8c0eimvjP5gjWbuNIiiNoClZbz5lhBw
         dJIGUSKBM1hwfK7lKgU7vbAKLYc3MnA3Vq3Ed8bbRqeziGMyRPBl8JlGnjk5s/vJ9cM0
         fX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O+Xb8XfYLBY+q2gjVoxrXjNYTsXkPIxAR/NplZM1Ong=;
        b=pfUUi9hlYMi4LDMrryOGPYdke2Q/gixfXwkqn8GqfcUFLGEdipJGza7fLtSXQ57AW7
         l9gmCyP7gmzGEwgJgZkU5hqttgrVyjf5S9rZvfrNlFgROEXvGSSzAic+AymcIL+9DflR
         nRJ9KelBrkb17CZJpA0uR7XK9kEdqGmS2b7WCvuzYUpFOiC28HBHGi562p99oeDT/oOZ
         JZT5DN8dm1e5s9wjGmArOF7UnnLzboJwYel7crWSzYvSM+ZmegJHGv9Qd+d+elm5NQfK
         aq68IVupATobshF7NfltWtBqOsWAvE0JcsSgM0bf9yhKuIjXumdG0l2mei8uafbvGxul
         7ZHA==
X-Gm-Message-State: AOAM532vFR1iJqr3dqgNfQwOns9HrgKWkXNFtfteS/YzsLkjcxC55E2Z
        hxAW1J/25EIb9LYQazki0RHCiiM2AxTK527oa8k=
X-Google-Smtp-Source: ABdhPJxWBx8AYTBBdfMysSzI77wihi1uJABkUPSOfeGequcB/Fseo2zXx68RMc2UOuFXs3vwhGTZZL5PHQTS4eNG1ZY=
X-Received: by 2002:aca:1a17:: with SMTP id a23mr5579839oia.120.1611227064003;
 Thu, 21 Jan 2021 03:04:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
 <pull.832.v5.git.1611037846.gitgitgadget@gmail.com> <802ff802be884349b4a63c0ae6e4b783e6c7aedb.1611037846.git.gitgitgadget@gmail.com>
 <xmqqczxzfj5v.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqczxzfj5v.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Thu, 21 Jan 2021 19:05:57 +0800
Message-ID: <CAOLTT8Rv76ivN5HcocYmqak0c5+Dezm7F35uoLWKrHYp0NobTw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] ls_files.c: consolidate two for loops into one
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=8821=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=884:27=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Refactor the two for loops into one,skip showing the ce if it
> > has the same name as the previously shown one, only when doing so
> > won't lose information.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >  builtin/ls-files.c | 70 +++++++++++++++++++---------------------------
> >  1 file changed, 29 insertions(+), 41 deletions(-)
>
> This one needs a bit more work, but I like the basic structure of
> the rewritten loop.
>
> > diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> > index f1617260064..1454ab1ae6f 100644
> > --- a/builtin/ls-files.c
> > +++ b/builtin/ls-files.c
> > @@ -312,51 +312,39 @@ static void show_files(struct repository *repo, s=
truct dir_struct *dir)
> >               if (show_killed)
> >                       show_killed_files(repo->index, dir);
> >       }
> > -     if (show_cached || show_stage) {
> > -             for (i =3D 0; i < repo->index->cache_nr; i++) {
> > -                     const struct cache_entry *ce =3D repo->index->cac=
he[i];
> > +     if (! (show_cached || show_stage || show_deleted || show_modified=
))
> > +             return;
>
> If none of these four are given, nothing will be given after this
> point, so returning early is good.
>
I understand.
> > +     for (i =3D 0; i < repo->index->cache_nr; i++) {
> > +             const struct cache_entry *ce =3D repo->index->cache[i];
> > +             struct stat st;
> > +             int err;
> >
> > +             construct_fullname(&fullname, repo, ce);
> >
> > +             if ((dir->flags & DIR_SHOW_IGNORED) &&
> > +                     !ce_excluded(dir, repo->index, fullname.buf, ce))
> > +                     continue;
> > +             if (ce->ce_flags & CE_UPDATE)
> > +                     continue;
>
> The above two are common between the original two codepaths, and
> merging them is good.
>
> > +             if (show_cached || show_stage) {
> > +                     if (!show_unmerged || ce_stage(ce))
> > +                             show_ce(repo, dir, ce, fullname.buf,
> > +                                     ce_stage(ce) ? tag_unmerged :
> > +                                     (ce_skip_worktree(ce) ? tag_skip_=
worktree :
> > +                                             tag_cached));
> >               }
>
> We would want to reduce the indentation level of the show_ce() by
> consolidating the nested if/if to
>
>                 if ((show_cached || show_stage) &&
>                     (!show_unmerged || ce_stage(ce)))
>                         show_ce(...);
>
>
The reason for this may be I gave
"if(show_cached || show_stage)" in 3/3
Added some logic.
> Everything below from this point should be skipped (especially, the
> call to lstat()) unless show_modified and/or show_deleted was asked
> by the caller, i.e.  we want to insert
>
>                 if (!(show_deleted || show_modified))
>                         continue;
>
I agree.
> here, before we call ce_skip_worktree(), I think.
>
> > +             if (ce_skip_worktree(ce))
> > +                     continue;
> > +             err =3D lstat(fullname.buf, &st);
> > +             if (err) {
> > +                     if (errno !=3D ENOENT && errno !=3D ENOTDIR)
> > +                             error_errno("cannot lstat '%s'", fullname=
.buf);
> > +                     if (show_deleted)
> > +                             show_ce(repo, dir, ce, fullname.buf, tag_=
removed);
> > +                     if (show_modified)
> >                               show_ce(repo, dir, ce, fullname.buf, tag_=
modified);
> > -             }
> > +             } else if (show_modified && ie_modified(repo->index, ce, =
&st, 0))
> > +                     show_ce(repo, dir, ce, fullname.buf, tag_modified=
);
> >       }
>
> And this part would look somewhat different if we take my earlier
> suggestion for [1/3].
>
Fine.
> Thanks.
