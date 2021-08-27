Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26487C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 020D760F58
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhH0VOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 17:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhH0VOH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 17:14:07 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925B7C0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 14:13:18 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id s16so2923784qvt.13
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 14:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tOJ2HAt0NDqnAR2UvsetwSdZJ+dfqqQIQ8ZMeRzEI3A=;
        b=SOSoRRmIcuhB8+A4Rm4YR5swrGPVvJ8s7Kmrvm2g6ugSkW55YeYkSC+ClHM5QgkreH
         2TF4wvH5fvb44skrlOkYA3Lrq/xUXNw7UXYLqReKo6N9MIKbGgIhTTzvW7w1U90l1CZz
         9+7+M7h3zHjO9yb9i/scgAayHDaN1kPYMYSCLfLLHV8ILJNAJA/pkgzEJSWI4m/awE5S
         H9GcvMj2SYdE4Y/YJfbkgFRPsTLNsEnWCr9a7Y7dD+hK55Lsu5P0PglUuTJfqk77YUpv
         0MlfONzejvX0UtB9kEKzRFXWjzvut5/eCVXN/1OItvDiskNHWtayXcwF5Tnhb02wnqIl
         xdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOJ2HAt0NDqnAR2UvsetwSdZJ+dfqqQIQ8ZMeRzEI3A=;
        b=YmamqxZdbsKbzvF1iQ5D5tzMDILreToBZuiQGTHkVabRhK1x1kPIa+ITAODzJ3NSHr
         /z8v3suA1HLRuz/qqqfXL/79NobNkFHVs5jlKo9Vd4ftk866uWImIng3GvM6fNJZowyO
         Ww7HQNONLbEu6ZfVMzRP3IklIFhHCcOM4dtmqlsWsIxH9Ptk0FflY5B50UhQeJP3TeZy
         e4EBoB5+UnRAoVgOnCtM7/ekxCQrojpg7AxNM16fV37YeViK58l/tRIEnVTvLwGQ/8cT
         ZEcEVBqVljnP49BxJNet/Ej2cRr0VPs2S68jBM6RGzIiz2iqvAWg5HFctUEdQbaRkeXW
         I6zQ==
X-Gm-Message-State: AOAM532vo0dewXWU/RqbUjKEXqBH+LK8GZB8sh3eY8krPbgvtJZkLKXb
        Pd7IUPOYtkSK+VeTczOufefACw==
X-Google-Smtp-Source: ABdhPJztIRZnRf6oKVP9io85jA2hS/5NYWjGLQ9CYIj+pKnQ6SRr+T+u1BRWem+VOaSWLL6p6N4BUg==
X-Received: by 2002:a05:6214:2b4:: with SMTP id m20mr4154806qvv.35.1630098797768;
        Fri, 27 Aug 2021 14:13:17 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.116.19])
        by smtp.gmail.com with ESMTPSA id y19sm4118468qtv.21.2021.08.27.14.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 14:13:17 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitgitgadget@gmail.com
Cc:     derrickstolee@github.com, dstolee@microsoft.com,
        git@vger.kernel.org, gitster@pobox.com, matheus.bernardino@usp.br,
        newren@gmail.com, stolee@gmail.com
Subject: Re: [PATCH 06/13] add: skip paths that are outside sparse-checkout cone
Date:   Fri, 27 Aug 2021 18:13:10 -0300
Message-Id: <20210827211310.108999-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <eeba97ad492307302637faf33f6bf6ae8965faa3.1629842085.git.gitgitgadget@gmail.com>
References: <eeba97ad492307302637faf33f6bf6ae8965faa3.1629842085.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 6:54 PM Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com> wrote:
>
> Subject: [PATCH 06/13] add: skip paths that are outside sparse-checkout cone

Perhaps this could be "skip _tracked_ paths that ..." (to help
differentiate the end goal of this patch from the previous one).

> diff --git a/pathspec.c b/pathspec.c
> index 44306fdaca2..0e6e60fdc5a 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -39,7 +39,8 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
>                 return;
>         for (i = 0; i < istate->cache_nr; i++) {
>                 const struct cache_entry *ce = istate->cache[i];
> -               if (sw_action == PS_IGNORE_SKIP_WORKTREE && ce_skip_worktree(ce))
> +               if (sw_action == PS_IGNORE_SKIP_WORKTREE &&
> +                   (ce_skip_worktree(ce) || !path_in_sparse_checkout(ce->name, istate)))

Hmm, even though we skip the sparse paths here, cmd_add() will call
add_files_to_cache() at the end and still update these paths in the
index. I think there are two ways to fix this. We could either change
run_diff_files() to skip these paths (but I don't know how other callers
of this functions want to handle this, so maybe this needs to hide
behind an option flag):

diff --git a/diff-lib.c b/diff-lib.c
index f9eadc4fc1..4245d7ead5 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -198,7 +198,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				continue;
 		}
 
-		if (ce_uptodate(ce) || ce_skip_worktree(ce))
+		if (ce_uptodate(ce) || ce_skip_worktree(ce) ||
+		    !path_in_sparse_checkout(ce->name, istate))
 			continue;
 
 		/*

Or we could change the callback in add itself:

diff --git a/builtin/add.c b/builtin/add.c
index f675bdeae4..3d7762aac2 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -94,6 +94,10 @@ static void update_callback(struct diff_queue_struct *q,
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		const char *path = p->one->path;
+
+		if (!path_in_sparse_checkout(path, &the_index))
+			continue;
+
 		switch (fix_unmerged_status(p, data)) {
 		default:
 			die(_("unexpected diff status %c"), p->status);

I believe we also need to update a few other places to use the
`(ce_skip_worktree(ce) || !path_in_sparse_checkout())` logic in order to
avoid updating tracked sparse paths: chmod_pathspec() for add's --chmod
option, renormalize_tracked_files() for --renormalize, and
read-cache.c:refresh_index() for --refresh.

>                         continue;
>                 ce_path_match(istate, ce, pathspec, seen);
>         }

Hmm, don't we also want to update
find_pathspecs_matching_skip_worktree() in this patch to use
path_in_sparse_checkout()? I see you did that in patch 8, but I think
this should be together with this current patch as, without it, we stop
adding tracked sparse paths but we print no error/advice message about
it.
