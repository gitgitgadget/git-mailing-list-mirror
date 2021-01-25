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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5C2C433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 06:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B428622C9F
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 06:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbhAYGF3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 01:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbhAYGEP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 01:04:15 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AC3C061573
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 22:03:35 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id r189so13628020oih.4
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 22:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kVVFGLwUUIsXUIHmh6tCNHUTP1cP5bN0w9W8vdYTpos=;
        b=FnstiLnKkqHh6HH1FX1Y1oK9IjFbWdQ7+7yiL82IJCQHUm4BpgRDPRSDi8CDG1uNE1
         LfknYcmN9y9TnM0gXYMvAiOs0NJE5JPp/vsDLfjDTqf3sk5OmvHHwsbA+0ikpbRMekCF
         VmSZ49N6rYHte/2MYggL682BJN73mKu2xa6OSWQdBQ33Y6KzD2q9nKixXEVBHZXz6nEY
         Y0ZpfmBpPv1ywaAWVIY11gnmowsSRdbCOXA78YqW2iY+II6ezJFZBjumtFCy1Y7CZusC
         ifXDo9VzndiV7pAZY+523wbBJybVD0WvgzEBz3+92V8hC7y6sqf16WgYZsjxKx+6d9EJ
         IFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kVVFGLwUUIsXUIHmh6tCNHUTP1cP5bN0w9W8vdYTpos=;
        b=cTXPz/Ft6srkMwmR99JFE3UNYuTWLyewndW1Si9yQt5WbcLWETKFSP0df9oj1M/RiB
         oRFydYzn//B9mRg4Tirps1mubTGUGHNkHCQERCf6YEBOwNEjF4WsR1PkjtLUJ4C5aApw
         9TjvOSAMlHqgOBb9fvtC23UNDeXDtbODS98j2Q68LHrWXPGdAPqd4FAQYM/x86vAucve
         PCOCdQFuveudi3QD70gyTkXjpppsRWSPIF96euzHrkqxnaj66V47VVGSNcPMp9xnI+A2
         C8XE6M5fRaaZHoFz3mHqOi9HxFd24xW0/MsfbTbFi30DKrSj+HdZE2bxxB8b45ztrd5O
         pg6g==
X-Gm-Message-State: AOAM5317Dq/IPz/F2Iu3yhWrVT2khKavfa5BlpaL7Zwu+UEv4ehBHt8g
        YQywOUjAmQI8QaUVwUWzi5sW0TyhEAvcG7xPlr4=
X-Google-Smtp-Source: ABdhPJwgWxvZkemqZywzsUOIV58p4cQKYm0ywu+1FMi7tZd0SF17q6NP7xMgBAcO5WvD4CL6O1Lo9PcNB9+dSjqKeWk=
X-Received: by 2002:aca:5290:: with SMTP id g138mr483875oib.44.1611554614529;
 Sun, 24 Jan 2021 22:03:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.832.v6.git.1611397210.gitgitgadget@gmail.com>
 <pull.832.v7.git.1611485667.gitgitgadget@gmail.com> <8b02367a359e62d7721b9078ac8393a467d83724.1611485667.git.gitgitgadget@gmail.com>
 <xmqqo8heyoti.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8heyoti.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Mon, 25 Jan 2021 14:05:06 +0800
Message-ID: <CAOLTT8QgDeWmcX7y3QmQ7jyunziw4qn==L3BiJ81weMZtq8Obw@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] ls_files.c: bugfix for --deleted and --modified
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OK,I didn=E2=80=99t notice any formatting changes before.

Am I free from this patch now?I should probably
look for other issues.

Junio, thank you for all your patient help.
I may often make some low-level mistakes.
I am grateful.

Cheers.

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=886:04=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > This situation may occur in the original code: lstat() failed
> > but we use `&st` to feed ie_modified() later.
> >
> > Therefore, we can directly execute show_ce without the judgment of
> > ie_modified() when lstat() has failed.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > [jc: fixed misindented code]
>
> I noticed that you reverted my fix in this version, when this is
> compared with the one I sent last night.
>
> Comparing the result of applying all three with what I sent last
> night, this v7 looks worse (see below).  Let's discard this round
> and declare victory with what is already on 'seen'.
>
> Thanks.
>
>
> ---
>
> comparison between what these three patches would produce (preimage)
> and what is on 'seen' (postimage)is shown here.
>
> diff --git w/builtin/ls-files.c c/builtin/ls-files.c
> index fb9cf50d76..f6f9e483b2 100644
> --- w/builtin/ls-files.c
> +++ c/builtin/ls-files.c
> @@ -313,7 +313,8 @@ static void show_files(struct repository *repo, struc=
t dir_struct *dir)
>                 if (show_killed)
>                         show_killed_files(repo->index, dir);
>         }
> -       if (! (show_cached || show_stage || show_deleted || show_modified=
))
> +
> +       if (!(show_cached || show_stage || show_deleted || show_modified)=
)
>                 return;
>         for (i =3D 0; i < repo->index->cache_nr; i++) {
>                 const struct cache_entry *ce =3D repo->index->cache[i];
> @@ -328,15 +329,16 @@ static void show_files(struct repository *repo, str=
uct dir_struct *dir)
>                 if (ce->ce_flags & CE_UPDATE)
>                         continue;
>                 if ((show_cached || show_stage) &&
> -                       (!show_unmerged || ce_stage(ce))) {
> -                               show_ce(repo, dir, ce, fullname.buf,
> -                                       ce_stage(ce) ? tag_unmerged :
> -                                       (ce_skip_worktree(ce) ? tag_skip_=
worktree :
> -                                               tag_cached));
> +                   (!show_unmerged || ce_stage(ce))) {
> +                       show_ce(repo, dir, ce, fullname.buf,
> +                               ce_stage(ce) ? tag_unmerged :
> +                               (ce_skip_worktree(ce) ? tag_skip_worktree=
 :
> +                                tag_cached));
>                         if (skipping_duplicates)
>                                 goto skip_to_next_name;
>                 }
> -               if (!show_deleted && !show_modified)
> +
> +               if (!(show_deleted || show_modified))
>                         continue;
>                 if (ce_skip_worktree(ce))
>                         continue;
> @@ -349,12 +351,13 @@ static void show_files(struct repository *repo, str=
uct dir_struct *dir)
>                                 goto skip_to_next_name;
>                 }
>                 if (show_modified &&
> -                       (stat_err || ie_modified(repo->index, ce, &st, 0)=
)) {
> -                               show_ce(repo, dir, ce, fullname.buf, tag_=
modified);
> +                   (stat_err || ie_modified(repo->index, ce, &st, 0))) {
> +                       show_ce(repo, dir, ce, fullname.buf, tag_modified=
);
>                         if (skipping_duplicates)
>                                 goto skip_to_next_name;
>                 }
>                 continue;
> +
>  skip_to_next_name:
>                 {
>                         int j;
> @@ -362,7 +365,7 @@ static void show_files(struct repository *repo, struc=
t dir_struct *dir)
>                         for (j =3D i + 1; j < repo->index->cache_nr; j++)
>                                 if (strcmp(ce->name, cache[j]->name))
>                                         break;
> -                       i =3D j - 1; /* compensate for outer for loop */
> +                       i =3D j - 1; /* compensate for the for loop */
>                 }
>         }
>
> @@ -590,7 +593,8 @@ int cmd_ls_files(int argc, const char **argv, const c=
har *cmd_prefix)
>                         N_("pretend that paths removed since <tree-ish> a=
re still present")),
>                 OPT__ABBREV(&abbrev),
>                 OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data=
")),
> -               OPT_BOOL(0,"deduplicate",&skipping_duplicates,N_("suppres=
s duplicate entries")),
> +               OPT_BOOL(0, "deduplicate", &skipping_duplicates,
> +                        N_("suppress duplicate entries")),
>                 OPT_END()
>         };
>
