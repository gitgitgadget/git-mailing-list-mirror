Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CC1C43334
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 03:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiFSD0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 23:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbiFSD0X (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 23:26:23 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C26BEE36
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 20:26:20 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id b10so45383plg.4
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 20:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9lYNZ9mw0Rsmsb9RYrpFEuwwroPEAOy3nqzqzm0sONg=;
        b=GnkTGi5QbMMNypdiSySDiaB2BqhSFfZY3/ATWAp42u+M++guT6UZpqrC9Ndij5wFUG
         ZXbT13UQd57wKNCMrvld4T+OX0KB0LdYb4r95UqKwQQUj0N66KohwWZpDLX3aOVwphpw
         UzXyP4nnhgabsXnYpgJRJ39x/aqcLBqMLyuavkkogYqEIOQYTPRsU9lZt9AO+nmvdK8g
         fkqmbvXefYwZsEh6N6+pwldqiW8m5RTbpJDXEeyPb9eg9VtzFfJhvSsjPMGs7R5YKIY7
         Gv7/2NVsfMzEnlNK2YfuZuDNCCf6bOgQXtFL5I1S25tfXFb3VINEwR6Y8S2gs7WT0hN9
         H4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9lYNZ9mw0Rsmsb9RYrpFEuwwroPEAOy3nqzqzm0sONg=;
        b=mmuCzU4g+dOOEpqGwtp33bd5GqZzs72wHAo7pXfgesynBbv/hynoqfKD6ws09wRsl3
         xshlaYZJG5mMEHcPJznbEDAY7/6O7vy8eB5tgX9p30w4a3sPxLB6XBvR6xcEebg/J5tB
         AnFT72aXMoWythsZ9Fg8OG0nWusLm/EZf39fbD79WosxgSo6BeAHvicrwiNiPLgeG2/r
         r5JAt2oMXllJf7j5CqkmaitIav27WsDR5mi17vPfpSqSpUBqKhrm/LRZc+OYR+az1asy
         JujGtsXYZbHDxQA+glhTHny2rUxtIWLK3VhYovOepYEjbYayYMmrDB6daPazREwFJp64
         38kw==
X-Gm-Message-State: AJIora8cSHLyvu7pNxR2z+uHaWe4nO0ApHE1x+xl550LS9WgevtNODbS
        djC4ujZva+e9zlRG2F9Iri0=
X-Google-Smtp-Source: AGRyM1sDv6e5GlbuutDjcz7KAzt1JAFcPG0wzWMHrq0tLf3KS0IHURkMGVcDBmnZ5v8nVbTLkCLCuA==
X-Received: by 2002:a17:902:8b8b:b0:167:4e55:2dac with SMTP id ay11-20020a1709028b8b00b001674e552dacmr17529712plb.132.1655609179815;
        Sat, 18 Jun 2022 20:26:19 -0700 (PDT)
Received: from ffyuanda.localdomain ([112.195.147.33])
        by smtp.gmail.com with ESMTPSA id u1-20020a170903124100b0016188a4005asm5990650plh.122.2022.06.18.20.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 20:26:19 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        vdye@github.com, newren@gmail.com
Subject: [WIP v3 6/7] mv: add check_dir_in_index() and solve general dir check issue
Date:   Sun, 19 Jun 2022 11:25:48 +0800
Message-Id: <20220619032549.156335-7-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, moving a <source> directory which is not on-disk due
to its existence outside of sparse-checkout cone, "giv mv" command
errors out with "bad source".

Add a helper check_dir_in_index() function to see if a directory
name exists in the index. Also add a SKIP_WORKTREE_DIR bit to mark
such directories.

Change the checking logic, so that such <source> directory makes
"giv mv" command warns with "advise_on_updating_sparse_paths()"
instead of "bad source"; also user now can supply a "--sparse" flag so
this operation can be carried out successfully.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c                  | 49 +++++++++++++++++++++++++++++++----
 t/t7002-mv-sparse-checkout.sh |  4 +--
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 7ce7992d6c..cb3441c7cb 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -123,6 +123,37 @@ static int index_range_of_same_dir(const char *src, int length,
 	return last - first;
 }
 
+/*
+ * Check if an out-of-cone directory should be in the index. Imagine this case
+ * that all the files under a directory are marked with 'CE_SKIP_WORKTREE' bit
+ * and thus the directory is sparsified.
+ *
+ * Return 0 if such directory exist (i.e. with any of its contained files not
+ * marked with CE_SKIP_WORKTREE, the directory would be present in working tree).
+ * Return 1 otherwise.
+ */
+static int check_dir_in_index(const char *name, int namelen)
+{
+	int ret = 1;
+	const char *with_slash = add_slash(name);
+	int length = namelen + 1;
+
+	int pos = cache_name_pos(with_slash, length);
+	const struct cache_entry *ce;
+
+	if (pos < 0) {
+		pos = -pos - 1;
+		if (pos >= the_index.cache_nr)
+			return ret;
+		ce = active_cache[pos];
+		if (strncmp(with_slash, ce->name, length))
+			return ret;
+		if (ce_skip_worktree(ce))
+			return ret = 0;
+	}
+	return ret;
+}
+
 int cmd_mv(int argc, const char **argv, const char *prefix)
 {
 	int i, flags, gitmodules_modified = 0;
@@ -184,7 +215,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	/* Checking */
 	for (i = 0; i < argc; i++) {
 		const char *src = source[i], *dst = destination[i];
-		int length, src_is_dir;
+		int length;
 		const char *bad = NULL;
 		int skip_sparse = 0;
 
@@ -198,12 +229,17 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 			pos = cache_name_pos(src, length);
 			if (pos < 0) {
+				const char *src_w_slash = add_slash(src);
+				if (!check_dir_in_index(src, length) &&
+					!path_in_sparse_checkout(src_w_slash, &the_index)) {
+					modes[i] |= SKIP_WORKTREE_DIR;
+					goto dir_check;
+				}
 				/* only error if existence is expected. */
 				if (!(modes[i] & SPARSE))
 					bad = _("bad source");
 				goto act_on_entry;
 			}
-
 			ce = active_cache[pos];
 			if (!ce_skip_worktree(ce)) {
 				bad = _("bad source");
@@ -230,14 +266,17 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			bad = _("can not move directory into itself");
 			goto act_on_entry;
 		}
-		if ((src_is_dir = S_ISDIR(st.st_mode))
+		if (S_ISDIR(st.st_mode)
 		    && lstat(dst, &st) == 0) {
 			bad = _("cannot move directory over file");
 			goto act_on_entry;
 		}
-		if (src_is_dir) {
+
+dir_check:
+		if (S_ISDIR(st.st_mode)) {
 			int j, dst_len, n;
-			int first = cache_name_pos(src, length), last;
+			int first, last;
+			first = cache_name_pos(src, length);
 
 			if (first >= 0) {
 				prepare_move_submodule(src, first,
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 5b61fbad5f..30e13b9979 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -219,7 +219,7 @@ test_expect_success 'refuse to move file to non-skip-worktree sparse path' '
 	test_cmp expect stderr
 '
 
-test_expect_failure 'refuse to move out-of-cone directory without --sparse' '
+test_expect_success 'refuse to move out-of-cone directory without --sparse' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 
@@ -230,7 +230,7 @@ test_expect_failure 'refuse to move out-of-cone directory without --sparse' '
 	test_cmp expect stderr
 '
 
-test_expect_failure 'can move out-of-cone directory with --sparse' '
+test_expect_success 'can move out-of-cone directory with --sparse' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 
-- 
2.35.1

