Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A8801F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 18:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfADSiq (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 13:38:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54800 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfADSip (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 13:38:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so1947743wmh.4
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 10:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=yuPfsohzF09l3d/G9SCZWPF4Ps5oGG0UloTkrzg29GY=;
        b=lXv6OozsQZCXHeBJGIwWr01udaNJ5blZwh9uduTdeEy8aDW7ntYqAi7zWjr19JHPfo
         kXbZ8TWQfcrVWS0/hkUgKmHW1dLOOLq3IxkacsDaZvNQN8xTT36BB9ClsVG0yDLmLGyN
         LL5RH6NrWkJzwxfa9sL0yOpPhBNa7JzB1+gOUaOZNuUgBkwvqqEkwhRZjElss1+AGumJ
         VfRYa4Zf0COTW0cnOELX/JuvzkEsCE1sfsoJHLAwimJbpyrYixIY48YAH2P6b1s0wa0i
         n7OmB0lwz96MC8u6SFqLtQd79rg2wTw+BjnAsIhA33g7KxagM5EGym/bJsJ9hXsZGqb1
         NB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=yuPfsohzF09l3d/G9SCZWPF4Ps5oGG0UloTkrzg29GY=;
        b=krbLCCN9GCqEsNVJtJXg2Y/yCYqLgI/amczMBJu6ttLtKYV3/aMg9Byo1bUpV0aFJ+
         T9/cHOAQFRJ+oPjewpt1ZsEZ7nwl40RC0C4QsWeRoYzq9h0tpbGFp9Ghieqwmo+bFoin
         Q/P9FLKf+xFm0r08SfVskjzjNIJmTMCs4K5Cn8kEeTgCh79XQ3ZLgvQQ/T9CmLMcat4E
         +M6xpNIHRc5lcXjPi5b7CcVbAuIyZsOeRD3/ToIuQBvMmAUKsIIAZ6r2S/XAjqxs1RUJ
         CliFy6hLMKZ2ZJ+VyztL3cbo4pjpNxZbQViumJeUbXi8AYCzgrjOTHzTFIDzKcQr35+j
         PtFg==
X-Gm-Message-State: AJcUukc6LqATr3zGrudk0AS0h8VtIR6C4SZaFnK/np96qJxmhQHSTqpI
        7IMM5XKkW97EFs3fdDKPs+o=
X-Google-Smtp-Source: ALg8bN69c0CDsVGyyO4Zjib1N76NFEEzjJohrqv8HEcpUts6lUUFNn5q+OFcuKLCR8WdFprNt+rBwQ==
X-Received: by 2002:a1c:2d4b:: with SMTP id t72mr1971565wmt.99.1546627123129;
        Fri, 04 Jan 2019 10:38:43 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t5sm1143200wmg.43.2019.01.04.10.38.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 10:38:42 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/4] rebase: teach `reset_head()` to optionally skip the worktree
References: <pull.24.git.gitgitgadget@gmail.com>
        <21939140e00d96cf6f76e4c994638fecd3a95639.1545398254.git.gitgitgadget@gmail.com>
Date:   Fri, 04 Jan 2019 10:38:42 -0800
Message-ID: <xmqqpntcclot.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This is what the legacy (scripted) rebase does in
> `move_to_original_branch`, and we will need this functionality in the
> next commit.

The move-to-original-branch helper does:

    - point $head_name to the commit pointed at by HEAD
    - point HEAD symref to $head_name

without touching the index or the working tree files.  It's not
exactly "reset --soft" but more like "switch-branch --soft" ;-)

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/rebase.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 768bea0da8..303175fdf1 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -337,6 +337,7 @@ static void add_var(struct strbuf *buf, const char *name, const char *value)
>  
>  #define RESET_HEAD_DETACH (1<<0)
>  #define RESET_HEAD_HARD (1<<1)
> +#define RESET_HEAD_REFS_ONLY (1<<2)

In the future codebase in 'pu', we have 1<<2 already taken by
another topic, so I'll tell my rerere database that the bit
assignment needs to be adjusted.

>  static int reset_head(struct object_id *oid, const char *action,
>  		      const char *switch_to_branch, unsigned flags,
> @@ -344,6 +345,7 @@ static int reset_head(struct object_id *oid, const char *action,
>  {
>  	unsigned detach_head = flags & RESET_HEAD_DETACH;
>  	unsigned reset_hard = flags & RESET_HEAD_HARD;
> +	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
>  	struct object_id head_oid;
>  	struct tree_desc desc[2] = { { NULL }, { NULL } };
>  	struct lock_file lock = LOCK_INIT;
> @@ -359,7 +361,7 @@ static int reset_head(struct object_id *oid, const char *action,
>  	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
>  		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
>  
> -	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
> +	if (!refs_only && hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
>  		ret = -1;
>  		goto leave_reset_head;
>  	}

Not touching the index, so no need to lock the index.  Makes sense.

> @@ -372,6 +374,9 @@ static int reset_head(struct object_id *oid, const char *action,
>  	if (!oid)
>  		oid = &head_oid;
>  
> +	if (flags & RESET_HEAD_REFS_ONLY)
> +		goto reset_head_refs;
> +

Why not "refs_only" that we already prepared above???  Are we
munging that secondary variable before control comes here?

In any case, not touching the index nor the working tree, so no need
to call into the unpack_trees machinery.  Makes sense.

>  	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
>  	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
>  	unpack_tree_opts.head_idx = 1;
> @@ -412,6 +417,7 @@ static int reset_head(struct object_id *oid, const char *action,
>  		goto leave_reset_head;
>  	}
>  
> +reset_head_refs:
>  	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);

And the control continues from the point we update the reflog.
Makes sense.

>  	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : "rebase");
>  	prefix_len = msg.len;

This helper is touched by two other topics in flight, and that was
one of the reason why it took a bit longer than usual for me to
merge this topic.  Please sanity-check the result of the conflict
resolution at the tip of 'pu' branch.

Thanks.
