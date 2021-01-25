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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C9DC433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C9D722B3B
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbhAYSAF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731258AbhAYR4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:56:25 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B390C061221
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:33 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id y187so74074wmd.3
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=itRwluwYkYmkHZlSCa6+txpiwJvR8IeJetvlxdAepUA=;
        b=MLtVWJc0Az9ltfuc+XIk+6WHtMS8nyD/9MIOIIYVFVJqVXyY3vRlSWWLMsHB8rM9eK
         gRygMB461EsBh3rzHjFNW1koD9dJkujzE3lUiynvBfo/6SzPyu5FPhya6OXVLAHAKzcV
         C8nRtCQIwag9vbLVoFff9TuHRVscPeJoSO7q4RS3tUjAlQ8ZTGm2kh6Y5JgC1nqkGK5v
         /S04TEI0tmnnn6I1WHnWiOXnwQmHWE08J8ePeieYaDNtKN3OEIXiCWKxys/A14lH6HkZ
         yBMz+x5PjOPzrDXCaVFqWHkqmWmjGoSv5jDuQwlSvn38mThFE3Az/vgqzjBwBrBQOAF3
         WP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=itRwluwYkYmkHZlSCa6+txpiwJvR8IeJetvlxdAepUA=;
        b=gT74wLGdhMaF1Bd4/v+bSBVb/JVpcNIreTKY62X8F/4FGf982/jnuk43AqFfW6twjv
         WW3Po840HkdEmwCL+ffOxUcj4eEi0LvQXfvmzU7CavsyVSF8kmC7IabTAbbNfMLELqz6
         vfnnfTpcmxi971BktQh9NHyagEoGjNXJ1XxB0BEgI99PxAHGF3jdlJEulU9JA+3Zivv+
         0WBoc15F8e1pXD6zXWwBxBO/S3HKHmsWDb26uQ1e/clbxEMMjUdap5CepwqeXGFDiyD0
         CYyONe4ied7ZlyjH71xe9pqORNEnEKpNY3JsDP2kqtbNmowvysNmgbnfAVKlwcyfxEof
         395g==
X-Gm-Message-State: AOAM533KCDYmMsCc1LbBjMBPj7KFZLVcRWqXPyJ6QXm7qh9G1fs7o3G1
        0PBczOijUP/5MwMEJhYJ9U2ptawGfhw=
X-Google-Smtp-Source: ABdhPJySg+KBmMNUE5zsg+imFym9r3HNKj/ML8exLIseZfCjWGi12PV+QZPG0G10FUZw5Lt74l8BnQ==
X-Received: by 2002:a05:600c:618:: with SMTP id o24mr1203300wmm.82.1611596551641;
        Mon, 25 Jan 2021 09:42:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x81sm5265wmg.40.2021.01.25.09.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:31 -0800 (PST)
Message-Id: <30e36850fd5f429e81cdb6fe89576acf7eb74571.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:42:04 +0000
Subject: [PATCH 18/27] status: use sparse-index throughout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, peff@peff.net,
        jrnieder@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

By testing 'git -c core.fsmonitor= status -uno', we can check for the
simplest index operations that can be made sparse-aware. The necessary
implementation details are already integrated with sparse-checkout, so
modify command_requires_full_index to be zero for cmd_status().

By running the debugger for 'git status -uno' after that change, we find
two instances of ensure_full_index() that were added for extra safety,
but can be removed without issue.

In refresh_index(), we loop through the index entries. The
refresh_cache_ent() method copies the sparse directories into the
refreshed index without issue.

The loop within run_diff_files() skips things that are in stage 0 and
have skip-worktree enabled, so seems safe to disable ensure_full_index()
here.

While this change avoids calling ensure_full_index(), it actually slows
'git status' because we do not have the cache-tree extension to help us.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit.c                         |  3 +++
 diff-lib.c                               |  2 --
 read-cache.c                             |  1 -
 t/t1092-sparse-checkout-compatibility.sh | 10 +++++++---
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 505fe60956d..543aa0caeae 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1400,6 +1400,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_status_usage, builtin_status_options);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	status_init_config(&s, git_status_config);
 	argc = parse_options(argc, argv, prefix,
 			     builtin_status_options,
diff --git a/diff-lib.c b/diff-lib.c
index 3743e4463b4..b73cc1859a4 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -96,8 +96,6 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 	uint64_t start = getnanotime();
 	struct index_state *istate = revs->diffopt.repo->index;
 
-	ensure_full_index(istate);
-
 	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
 
 	refresh_fsmonitor(istate);
diff --git a/read-cache.c b/read-cache.c
index ab0c2b86ec0..78910d8f1b7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1561,7 +1561,6 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	 */
 	preload_index(istate, pathspec, 0);
 
-	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new_entry;
 		int cache_errno = 0;
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index c6b7e8b8891..a3521cdc310 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -382,12 +382,16 @@ test_expect_success 'sparse-index is expanded and converted back' '
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
 		git -C sparse-index -c core.fsmonitor="" reset --hard &&
 	test_region index convert_to_sparse trace2.txt &&
-	test_region index ensure_full_index trace2.txt &&
+	test_region index ensure_full_index trace2.txt
+'
 
-	rm trace2.txt &&
+test_expect_success 'sparse-index is not expanded' '
+	init_repos &&
+
+	rm -f trace2.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
 		git -C sparse-index -c core.fsmonitor="" status -uno &&
-	test_region index ensure_full_index trace2.txt
+	test_region ! index ensure_full_index trace2.txt
 '
 
 test_done
-- 
gitgitgadget

