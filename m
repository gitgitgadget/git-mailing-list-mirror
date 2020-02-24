Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA62C35673
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 01:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE3820675
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 01:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgBXBmp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 20:42:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40453 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgBXBmp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 20:42:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id t3so8421705wru.7
        for <git@vger.kernel.org>; Sun, 23 Feb 2020 17:42:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UjSp3lcB8wJG6coUi9ZA4sY5V3NTPvmuMOJwpZg6ReE=;
        b=cyvBITPQMUkBRi93P1p9OLrYsVrruVnlQPfHWtQrv6ZmdYhaGwK8ZdtCkCWUlxIH50
         wuFVKDpa//up0JzcQLNQMAvTQxagPmNUii+XZN4UbtJsg3ybtFxsXAL6a53nT+gtiihs
         7+ySfrk8n57VgR5lgkkdThjO21M2mbHmj04irePRDNyH3rMGEhcA4u/O0A1PDjuupoWp
         GjaC2di4BFQPgDeS+SR9Zwg2Y9M2KuGbuQKOp6nEuoURykDi53YyrfoJbM7KUyRuq582
         LLGyEy0bYNLKNzIBmutAYDDUlJCqlVP5cMwZZ2mEPWYqCSHvqEz7aJpp/EBgcHaa8XpD
         P9qA==
X-Gm-Message-State: APjAAAUGihRUavtcuYibyEP+iJrEtv0YDP2I40Ea193BOGXDNo18X8qR
        9EU1/aBFDtL8OrK4hwVYJmxgR23UwXVZoQjgj3qomitI
X-Google-Smtp-Source: APXvYqzkW/VseMknGFXpkGaUbOXU11Fual7/b5kJ0KcPHvzitXI1I1YCEfsG5d9+95jrSZ0SzCITN0c8XStKAwB85NA=
X-Received: by 2002:a5d:5752:: with SMTP id q18mr65955747wrw.277.1582508563464;
 Sun, 23 Feb 2020 17:42:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.535.v2.git.1582410908.gitgitgadget@gmail.com>
 <pull.535.v3.git.1582484231.gitgitgadget@gmail.com> <8718facbc951614f19407afa6ca8d6110507483d.1582484231.git.gitgitgadget@gmail.com>
In-Reply-To: <8718facbc951614f19407afa6ca8d6110507483d.1582484231.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 23 Feb 2020 20:42:32 -0500
Message-ID: <CAPig+cTh-uu-obh9aeDOV9ptbVwRmkujgucbu9ei1Qa3qSNG_A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] get_main_worktree(): allow it to be called in the
 Git directory
To:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 23, 2020 at 1:57 PM Hariom Verma via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> get_main_worktree(): allow it to be called in the Git directory

This title is a bit too generic; it fails to explain what this patch
is really fixing. Perhaps:

    get_main_worktree: correctly normalize worktree path when in .git dir

or something.

> When called in the Git directory of a non-bare repository, this function
> would not return the directory of the main worktree, but of the Git
> directory instead.

"Git directory" is imprecise. As a reader, I can't tell if this means
the main worktree into which the project is checked out or the `.git`
directory itself. Please write it instead as "`.git` directory".

> The reason: when the Git directory is the current working directory, the
> absolute path of the common directory will be reported with a trailing
> `/.git/.`, which the code of `get_main_worktree()` does not handle
> correctly.
>
> Signed-off-by: Hariom Verma <hariom18599@gmail.com>
> ---
> diff --git a/worktree.c b/worktree.c
> @@ -51,6 +51,7 @@ static struct worktree *get_main_worktree(void)
>         strbuf_add_absolute_path(&worktree_path, get_git_common_dir());
> +       strbuf_strip_suffix(&worktree_path, "/.");
>         if (!strbuf_strip_suffix(&worktree_path, "/.git"))
>                 strbuf_strip_suffix(&worktree_path, "/.");

This change makes the code unnecessarily confusing and effectively
turns the final line into dead code. I would much rather see the three
cases spelled out explicitly, perhaps like this:

    if (!strbuf_strip_suffix(&worktree_path, "/.git/.") && /* in .git dir */
        !strbuf_strip_suffix(&worktree_path, "/.git/")) /* in worktree */
            strbuf_strip_suffix(&worktree_path, "/."); /* in bare repo */

Also, please add a test to ensure that this behavior doesn't regress
in the future. You can probably test it via the "git worktree list"
command, so perhaps add the test to t/t2402-worktree-list.sh.
