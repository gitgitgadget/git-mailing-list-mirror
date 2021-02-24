Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274B3C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF3D064D9A
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhBXEG5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 23:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbhBXEGp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 23:06:45 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4474DC06178C
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 20:05:33 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id z190so996658qka.9
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 20:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jM8kxQZu46SsXYjeE9POAehmUnoju7dDCoG7KquSiiU=;
        b=rXpp9oxTzD33Q8vWHLDBlNmJpXSKUgMYbeZst0tZZ3/ZnmPtuf5yfv/6UngXk5fLCG
         GDBnk8Qzo+NEfJcQ5dctB++B1lSW6T1sjdBZEj7NO4ZRqBDF4stb/FWUxN2KQ2I8YJBE
         UVgci3x8mDyUFPzcA7ROE/wC4ePWDki5K81eMlO+34n+QABW3hiDF9XtSo8PaZl5SApZ
         WQHNZUp0Ky0Z1KSlsloqgfO17NkUCNse/tT5VDzAerES4YbxFAbS1iZmYIKRSTcDTN+v
         I15l/UVY1C+HY8FRcrRF6ZEDKBTZoGVmA6h0mR3fq0MF1BY6kM90j5cB34zmTHhNAQdD
         jMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jM8kxQZu46SsXYjeE9POAehmUnoju7dDCoG7KquSiiU=;
        b=Vj+N/W8okXtWXN8ZebYL4Cqe2+JCGGw1O0MxJUTWrnwcgCxBc/vioSC1YsbuSn6lFa
         dOZLeKX4UVgiw5+/GrPg2MXxMrLUWJgYEkA8N5/X+lVaXo9d9ZBUdKMkiGSD+qC21AIf
         vNM5qk4SAthpAOTtT2a+rYCGg9Ed/NYtlq+JI+bwkUJ31oZLrmC2gMCht49BDzroTb56
         kklbH2zw0zYK6QJ4IsVz8Fg2KaDYDuNlibN2ufdSTxsOvLyS6RhY33Z5KYREPuvrIFdr
         P+zUeI1SCZmaLrs1ywIJ9njA3byQpcLTyMFlkC/7l8w/na7GSE8nixqLE+vC/SzsSObo
         Ju1g==
X-Gm-Message-State: AOAM531vQuIhe2RehBkVp60TtyQvHCdN7QQuC1a36qlVT/sMjTZR7yvN
        Dr/memJyQG6BXuqvVkiS09+AiAbf8lTW7w==
X-Google-Smtp-Source: ABdhPJzg/pdoxLz2FFhXa7JGaTEfdln4BPeLZXVijqnmshCfrx3ILClVjQiM8WuI2rqo94ndOId4Mg==
X-Received: by 2002:a05:620a:7d5:: with SMTP id 21mr25861499qkb.152.1614139532049;
        Tue, 23 Feb 2021 20:05:32 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id z65sm547878qtd.15.2021.02.23.20.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 20:05:31 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, stolee@gmail.com
Subject: [PATCH v2 5/7] refresh_index(): add REFRESH_DONT_MARK_SPARSE_MATCHES flag
Date:   Wed, 24 Feb 2021 01:05:10 -0300
Message-Id: <d65b214dd1d83a2e8710a9bbf98477c1929f0d5e.1614138107.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1614138107.git.matheus.bernardino@usp.br>
References: <cover.1614138107.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

refresh_index() optionally takes a seen[] array to mark the pathspec
items that had matches in the index. This is used by `git add --refresh`
to find out if there were any pathspec without matches, and display an
error accordingly.

In the following patch, `git add` will also learn to warn about
pathspecs that only match sparse entries (which are not updated). But
for that, we will need a seen[] array marked exclusively with matches
from dense entries. To avoid having to call ce_path_match() again for
these entries after refresh_index() returns, add a flag that implements
this restriction inside the function itself.

Note that refresh_index() does not update sparse entries, regardless of
passing the flag or not. The flag only controls whether matches with
these entries should appear in the seen[] array.

While we are here, also realign the REFRESH_* flags and convert the hex
values to the more natural bit shift format, which makes it easier to
spot holes.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 cache.h      | 15 ++++++++-------
 read-cache.c |  5 ++++-
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index d928149614..eec864921a 100644
--- a/cache.h
+++ b/cache.h
@@ -879,13 +879,14 @@ int match_stat_data_racy(const struct index_state *istate,
 
 void fill_stat_cache_info(struct index_state *istate, struct cache_entry *ce, struct stat *st);
 
-#define REFRESH_REALLY		0x0001	/* ignore_valid */
-#define REFRESH_UNMERGED	0x0002	/* allow unmerged */
-#define REFRESH_QUIET		0x0004	/* be quiet about it */
-#define REFRESH_IGNORE_MISSING	0x0008	/* ignore non-existent */
-#define REFRESH_IGNORE_SUBMODULES	0x0010	/* ignore submodules */
-#define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs update" */
-#define REFRESH_PROGRESS	0x0040  /* show progress bar if stderr is tty */
+#define REFRESH_REALLY                   (1 << 0) /* ignore_valid */
+#define REFRESH_UNMERGED                 (1 << 1) /* allow unmerged */
+#define REFRESH_QUIET                    (1 << 2) /* be quiet about it */
+#define REFRESH_IGNORE_MISSING           (1 << 3) /* ignore non-existent */
+#define REFRESH_IGNORE_SUBMODULES        (1 << 4) /* ignore submodules */
+#define REFRESH_IN_PORCELAIN             (1 << 5) /* user friendly output, not "needs update" */
+#define REFRESH_PROGRESS                 (1 << 6) /* show progress bar if stderr is tty */
+#define REFRESH_DONT_MARK_SPARSE_MATCHES (1 << 7) /* don't mark sparse entries' matches on seen[] */
 int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
 /*
  * Refresh the index and write it to disk.
diff --git a/read-cache.c b/read-cache.c
index 29144cf879..485510845c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1508,6 +1508,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	int quiet = (flags & REFRESH_QUIET) != 0;
 	int not_new = (flags & REFRESH_IGNORE_MISSING) != 0;
 	int ignore_submodules = (flags & REFRESH_IGNORE_SUBMODULES) != 0;
+	int no_sparse_on_seen = (flags & REFRESH_DONT_MARK_SPARSE_MATCHES) != 0;
 	int first = 1;
 	int in_porcelain = (flags & REFRESH_IN_PORCELAIN);
 	unsigned int options = (CE_MATCH_REFRESH |
@@ -1541,12 +1542,14 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		int cache_errno = 0;
 		int changed = 0;
 		int filtered = 0;
+		char *cur_seen;
 
 		ce = istate->cache[i];
 		if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		if (pathspec && !ce_path_match(istate, ce, pathspec, seen))
+		cur_seen = no_sparse_on_seen && ce_skip_worktree(ce) ? NULL : seen;
+		if (pathspec && !ce_path_match(istate, ce, pathspec, cur_seen))
 			filtered = 1;
 
 		if (ce_stage(ce)) {
-- 
2.30.1

