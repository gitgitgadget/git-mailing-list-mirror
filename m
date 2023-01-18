Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F2DC004D4
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 05:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjARFod (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 00:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjARFo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 00:44:29 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C0F54121
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 21:44:28 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id j130so27819972oif.4
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 21:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmZHjoZ3OithC+6g/q+NAL+YdNtLI4kJm1Lzpwhf59M=;
        b=LKvmDUghA/Ey8VRnIppJiadTwTFhCho67MoczCZvfeF9719RMuMJshxX8AgNSSWcwx
         4q+QKFh87GrAIjGv3UkrLnWFZpGlGLcoBPzLVj2oc2YiRz2ZvvhtxUHUtE5y+A5tRHDI
         69d5VmQcebcqc0wHkDHyrHoE7RfLxku+qzfN3hRNkyFoUVwaysYOO1LMDMdzJgAdH6mS
         SzAp5JTuzqN+szVDMsud678U5S5uj2u6C/jXiQRSMjwDeBY2H1U4eixSJ6CCqsoPXkAK
         Lk1dXl8Kav0TLgghwdYEYU27jrq5ihiq943JW+WWn7IWclFtmTZhizWT7aic2T22MZtN
         r2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmZHjoZ3OithC+6g/q+NAL+YdNtLI4kJm1Lzpwhf59M=;
        b=lX3P+ZB/XJXYvxjJK5PGe8bkFf08OiE5OxqXR7c/JiTNHJG9vXZYFyo29BEFhnahey
         3yWpc2YdLb9jZzB3wwWAzECYjnWHKTcxelRVYYLwX/1SpY/+2iSAyLpjyYDtMpFrfWrE
         VyanhBcq2KGRoYq/ELE2IF/+gdNLKCT0Zo2lumCkDRNMzkHcdUIdlsEwyW4EjKpAGQ+8
         8bjbshZB2WQbCzWSMsvUBlspj7bUdjcRSfvMzHjoe0xgQKZKr0HobYbHzdEqAEFRBehG
         Unoa356UNue1jwHueGiuFzVEKIrVFG2A5a9eipOc/Wnmy5uzwWyCxKskn1U0SehdLs5d
         9o2A==
X-Gm-Message-State: AFqh2koBcoTcfha7DxJ3A/BmUwuN47YhxRIcrfTbiGpvL0HlatF3HKim
        /GEXltkvEid8+rdrrelof73h8+jVjjyKQNH0Wfw6esDUOp4=
X-Google-Smtp-Source: AMrXdXv1mRpsKKwAbC0XWrdasrL+Vj188sZIBVWYsxIY88dvGnVW69P+FDAfotyNmdTz6NGp9SJUTgn0VBPRNEMndzc=
X-Received: by 2002:a05:6808:13d4:b0:359:f10b:5477 with SMTP id
 d20-20020a05680813d400b00359f10b5477mr331884oiw.277.1674020667237; Tue, 17
 Jan 2023 21:44:27 -0800 (PST)
MIME-Version: 1.0
References: <20230116172824.93218-1-carenas@gmail.com> <45cb1b38-1284-ddc9-a2d8-0a45f10abafb@gmail.com>
In-Reply-To: <45cb1b38-1284-ddc9-a2d8-0a45f10abafb@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 17 Jan 2023 21:44:16 -0800
Message-ID: <CAPUEsphrbPVZtZi_GV9=8OqOqjk+SZ1JJf1bU_HWpUnT1H6YzA@mail.gmail.com>
Subject: Re: [PATCH] builtin/checkout: check the branch used in -B with worktrees
To:     =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Cc:     git@vger.kernel.org, vustthat@gmail.com, sunshine@sunshineco.com,
        pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 16, 2023 at 4:53 PM Rub=C3=A9n Justo <rjusto@gmail.com> wrote:
> On 16/1/23 18:28, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>
> > @@ -1533,13 +1534,12 @@ static int checkout_branch(struct checkout_opts=
 *opts,
> >       if (!opts->can_switch_when_in_progress)
> >               die_if_some_operation_in_progress();
> >
> > -     if (new_branch_info->path && !opts->force_detach && !opts->new_br=
anch &&
> > -         !opts->ignore_other_worktrees) {
> > +     if (check_branch_info->path && !opts->force_detach && !opts->igno=
re_other_worktrees) {
> >               int flag;
> >               char *head_ref =3D resolve_refdup("HEAD", 0, NULL, &flag)=
;
> >               if (head_ref &&
> > -                 (!(flag & REF_ISSYMREF) || strcmp(head_ref, new_branc=
h_info->path)))
> > -                     die_if_checked_out(new_branch_info->path, 1);
> > +                 (!(flag & REF_ISSYMREF) || strcmp(head_ref, check_bra=
nch_info->path)))
> > +                     die_if_checked_out(check_branch_info->path, 1);
>
> What we are doing here, if I understand it correctly, is dying if the
> branch is _not checked out in the current worktree_ and _checked out in
> any other worktree_.  Which is OK for normal checkout/switch.

I think the exception was added to `checkout` only, where it is
definitely needed, but switch probably should be more strict as it is
not "plumbing" and as you pointed out there is already a UI option to
override its safety.

> But IMHO with "checkout -B" we have to die if the branch is checked out
> in any other worktree, regardless of whether or not it is checked out in
> the current working tree.

I have to admit, I thought about that too, but then avoided making a
change as checkout behaviour affects a lot of other places, but in
retrospect I think that in this case it might be worth the change of
behaviour, since it is connected with the bugfix.

Before, the operation was allowed and the logic never tried to prevent
it (which is why in my first look, I thought it might have been
intentional), but once Eric pointed out it was a bug, then the obvious
conclusion would be to prevent it with the extended logic, as you
pointed out.

> Perhaps the scenario where the user has the same branch checked out in
> multiple worktrees and tries to reset in one of them, is one of those
> where we could use the "if it hurts, don't do it". But we are providing
> the "--ignore-other-worktrees" modifier, so I think we should disallow
> the "-B" if the branch is checked out in any other worktree, and let
> the user use "--ignore-other-worktrees" if he wants to go wild.

v2 includes this and AFAIK nothing is broken yet.

Carlo

PS. As explained before, tightening `switch` might be a good idea, but
it is obviously punted for this change and will be addressed later.
