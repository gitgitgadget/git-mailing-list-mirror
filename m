Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C3EC433F5
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 06:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239015AbhL2Gs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 01:48:57 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:43662 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbhL2Gs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 01:48:56 -0500
Received: by mail-pg1-f179.google.com with SMTP id 8so17769064pgc.10
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 22:48:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yXHgLCDjdPyAsD/JFFff9VMh8TTt+o+l68kNdrBg5q0=;
        b=gIwW3ABJ7a3cKzvCwOFZJVJdp8/Cf8hir/DZF/hGHzphvaq/QrsZLgbmQu3kfWpkaR
         GuqlAoQH4H+AwDK9cKwzdD86iknaKoUZhTp8R+aJWvA0np/TCPgwbYgPJLloO1PZhJQS
         04biDNNWcxP+rUnXlQB+/GLyCnW9XRu0a1+SUzRRz/7o2+w2dLSov+tJQgJ95PWnIJYt
         zJ8SgY96wb+vcABs4rLzq13Dn21rbs/bC8M0pM6n9JeIhUMSkrJnKhMP00IaDDPD2i+E
         J22AlpK7F4e4xjkhPVk6H3oxg1lEN/HBSO5jSPZcri+2Cy4HyDm9QQPPNNZV3zlJNmrx
         VCwg==
X-Gm-Message-State: AOAM531ZzHNL84DP35ypuyoynSYmmwnEwdm/lWvKP75yhloKjBph26f1
        M24ogZuvs30Aj90jid0wn510+qfqkHuoMnLPicE=
X-Google-Smtp-Source: ABdhPJzbybxqO2InngLFEZs1YMayqsoDX8iYw3vMAyEbghQuU3QQlexpUw0nh25Q5x9r5CHpf3A0htzM7qpEpw8MH5E=
X-Received: by 2002:a63:3e41:: with SMTP id l62mr17669621pga.139.1640760536400;
 Tue, 28 Dec 2021 22:48:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
 <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com> <e2a0a458115a26cfb855f7040f15e5198072b3a5.1640727143.git.gitgitgadget@gmail.com>
In-Reply-To: <e2a0a458115a26cfb855f7040f15e5198072b3a5.1640727143.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 29 Dec 2021 01:48:45 -0500
Message-ID: <CAPig+cRO4CZj4VQSwsNqDEeUFxnCyER31VRdU9B8CQw_hayEgg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] worktree: add 'init-worktree-config' subcommand
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 28, 2021 at 4:32 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> [...]
> To help resolve this transition, create the 'git worktree
> init-worktree-config' helper. This new subcommand does the following:
> [...]

Like my not-a-proper-review of [6/6], this also is not a proper review...

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -1031,6 +1032,85 @@ static int repair(int ac, const char **av, const char *prefix)
> +static int init_worktree_config(int ac, const char **av, const char *prefix)
> +{
> +       struct config_set cs = { 0 };

On macOS with "Apple LLVM version 10.0.0 (clang-1000.10.44.4)" and
DEVELOPER=1, the above code breaks the build:

    builtin/worktree.c:1093:27: error: suggest braces around
    initialization of subobject [-Werror,-Wmissing-braces]
    struct config_set cs = { 0 };

It wants extra braces in the initializer. This fixes it:

    struct config_set cs = { { 0 } };
