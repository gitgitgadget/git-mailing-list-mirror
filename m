Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AC1C433EF
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 00:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbhLWA6b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 19:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239931AbhLWA6a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 19:58:30 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43478C061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 16:58:30 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id m12so6431999ljj.6
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 16:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZzLC1t9YMMEvsr3NZNbkQR/KAMeR5ITkDpZoOIx8wps=;
        b=mXAZ6ifD7azdviLoYomIREpGAO2I/z9y+jWJ/0f7EdK8u2FUMRfnSH0nY5YLY18MBQ
         bUktLM28yA0VDMml6OPW8IdgtcloMo1xMe+2iemHszN3oB9dQD/DOADxHKKsGrmiZ1cF
         /zJqakyyuTsFYbe40ZH7kkr2pbc9rwBNyJIZnlVXVgr0r8jrifWku2Qo42uZh3p9pjzU
         P93LgtFTE9PAhIHvKYBdDz1dbzjY41pFidND2PjuPl/GrO+2ouwh2w5LD1bMrF0BlAP+
         rVIRjy+r3TxnF0c2RKDVuQkX9UvSetMwpQPgVhPV/GNktulKBrXhjhil4kgLRZoW/8vR
         EjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZzLC1t9YMMEvsr3NZNbkQR/KAMeR5ITkDpZoOIx8wps=;
        b=3Z3tysWfNbgDNI9qSCJEzg00X/1xc9XL//0xvpsq8gQGKwsJK5wVbD1GlGMlhpXGd9
         ysKCppyh7+4HEVmH/G6nDRa98cf3QV/Cv2pdbTcg6SCoWWi4WspuCiz5+NaejEmPYdhQ
         SRj62nw4GP3LkP50pORs8DHoPwMKfJuHSGsWN/Hq8sSXTyFR1ownMqy5zbhCbHA+JYnM
         kMOnmjUvHk+1M2WEH5XNdj150hP3CMmH3c/d7QhTXVLu0ehgXMyj1u9Z8rn8Synvyikm
         kGaPZRhwboje4rb+tXqBnCfgnDLRTUuzsqgex7M6TRczRGBQUVQqhpg3sIT+nVnIps+a
         0mXg==
X-Gm-Message-State: AOAM5309bkn0iET+ZY8ArMUw48QjXC3uAfdXY0c9Xg9Jo/L2X2ffeOeD
        JBarHLrlNYJvFYSJAB1STqsp32f4R7GMLHjyfug=
X-Google-Smtp-Source: ABdhPJzr4r2YEL/jW3HP+GLhCJr3ivUcUqqeeVdClvrJ2yhzCi+1qg5I06YQpaXo2nOVZ1S6t54PrvI7+6r/9HjeNRk=
X-Received: by 2002:a2e:6e15:: with SMTP id j21mr79526ljc.195.1640221108539;
 Wed, 22 Dec 2021 16:58:28 -0800 (PST)
MIME-Version: 1.0
References: <20211201221547.1796213-1-andersk@mit.edu> <20211201221547.1796213-9-andersk@mit.edu>
In-Reply-To: <20211201221547.1796213-9-andersk@mit.edu>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 23 Dec 2021 08:58:17 +0800
Message-ID: <CANYiYbHBjM-1oezX_1Z+te+wvQpdj=rwggHHCLPepos_Njwqvw@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] branch: protect branches checked out in all worktrees
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 2, 2021 at 6:16 AM Anders Kaseorg <andersk@mit.edu> wrote:
>
> Refuse to force-move a branch over the currently checked out branch of
> any working tree, not just the current one.
>
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---
>  branch.c          | 13 +++++++++----
>  t/t3200-branch.sh |  7 +++++++
>  2 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index c66b222abd..2cfe496d24 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -199,7 +199,8 @@ int validate_branchname(const char *name, struct strbuf *ref)
>   */
>  int validate_new_branchname(const char *name, struct strbuf *ref, int force)
>  {
> -       const char *head;
> +       struct worktree **worktrees;
> +       const struct worktree *wt;
>
>         if (!validate_branchname(name, ref))
>                 return 0;
> @@ -208,9 +209,13 @@ int validate_new_branchname(const char *name, struct strbuf *ref, int force)
>                 die(_("a branch named '%s' already exists"),
>                     ref->buf + strlen("refs/heads/"));
>
> -       head = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
> -       if (!is_bare_repository() && head && !strcmp(head, ref->buf))
> -               die(_("cannot force update the current branch"));
> +       worktrees = get_worktrees();
> +       wt = find_shared_symref(worktrees, "HEAD", ref->buf);
> +       if (wt && !wt->is_bare)
> +               die(_("cannot force update the branch '%s'"
> +                     "checked out at '%s'"),

There is no space between "'%s'" and "checkout". Found this from [1],
sorry for reporting this is a bit late.

[1] https://github.com/git-l10n/git-po/blob/pot/master/2021-12-22.diff#L315
