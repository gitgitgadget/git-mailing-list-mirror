Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4806C4332B
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE0F64F30
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhCQVWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhCQVW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:22:27 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040A8C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:22:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e9so3292572wrw.10
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6KNXDGoitQ2WAL8RoqTvOtQjxMDXBXamGfnXIhIf474=;
        b=ofUY9RZ0jiSCQd8E9l3LUmGgA7IdejYv5/OJ5yQrJDEUBl5ELXRGiK/1SigwbARjpp
         cRuJL+ezgqVHnf+1s4OaVghBe50N8WTI/wWoEwTrHR1y6yd4h/bNCCfDd1OC78geTb0f
         T6Dma7P9emLOPccX1/yNFo4zfqq7rS0wa7wQZYh/bfV6sGsGSl8AlBEBVHAbgxzc5/os
         tTjv/7FTIkkqFMLlLFZ1dppAo8cg2Xg4Y1+qFrflZol9pNvHeperH0+f5uRN+sPaV/av
         lMkct9On/Aaf7h5mW0ndABWrNySL6TpsuBdnc0nEHfnqSYjUKM6LVmu7WdS6KwgvTo+d
         y19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6KNXDGoitQ2WAL8RoqTvOtQjxMDXBXamGfnXIhIf474=;
        b=dXMAw/724H8rvTCLc4dkypLEWynsPELw5mBP+7P45xZlWfVfDvP4agfZV/7N2+zZeP
         hxgOKtfaSGDn6rl9beAoYPA2FI3uE7Bx9K0rP6DisIZRBxOOAx9y/n6PMZNAsAaFddjx
         r9scNz1uGOSyS5JQoXum7kTLCq42UKLUlNXu4ZBr+ZTsxtJRLuUbzaLDjvw+s6qzBTRu
         BnWBjgGmRhZElfUcSQuHLyX9L+GF6GheCLITFSrWNyPdNd3o32Yr0JOwFOqg9JWp5JFm
         DXu6xaWsvCp9Dnyw6+Qz+EQJJxOn6iSIDUY1ZWh3aTDNmW2f9dGhlOVpadvfbAArsvcP
         WZ1A==
X-Gm-Message-State: AOAM531xpV4CjGGB6EiDlklGSBeuVmrVW4Z8xVdgDfybEnMZn4I3R4rm
        jSnniD0JhrJljb0KDKfAHGFnUAlGoaE=
X-Google-Smtp-Source: ABdhPJz9C5PFMEfz+16ZXK3wVh6O/K6tCW0SEBcG8EN6TB0hvVl9Dvhhy2Su+DtE0UDqVJ0dwyG5TQ==
X-Received: by 2002:a5d:6587:: with SMTP id q7mr6238007wru.282.1616016145797;
        Wed, 17 Mar 2021 14:22:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm222656wrp.12.2021.03.17.14.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 14:22:25 -0700 (PDT)
Message-Id: <afd326c5011b09d89b6354817c1913d85142c335.1616016143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.903.v2.git.1616016143.gitgitgadget@gmail.com>
References: <pull.903.git.1615760258.gitgitgadget@gmail.com>
        <pull.903.v2.git.1616016143.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 21:22:22 +0000
Subject: [PATCH v2 2/3] fsmonitor: add assertion that fsmonitor is valid to
 check_removed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

Validate that fsmonitor is valid to futureproof against bugs where
check_removed might be called from places that haven't refreshed.

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 diff-lib.c  | 18 +++++++++++-------
 fsmonitor.h | 11 +++++++++++
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 3fb538ad18e9..e5a58c9259cf 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -28,8 +28,9 @@
  * exists for ce that is a submodule -- it is a submodule that is not
  * checked out).  Return negative for an error.
  */
-static int check_removed(const struct cache_entry *ce, struct stat *st)
+static int check_removed(const struct index_state *istate, const struct cache_entry *ce, struct stat *st)
 {
+	assert(is_fsmonitor_refreshed(istate));
 	if (!(ce->ce_flags & CE_FSMONITOR_VALID) && lstat(ce->name, st) < 0) {
 		if (!is_missing_file_error(errno))
 			return -1;
@@ -136,7 +137,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			memset(&(dpath->parent[0]), 0,
 			       sizeof(struct combine_diff_parent)*5);
 
-			changed = check_removed(ce, &st);
+			changed = check_removed(istate, ce, &st);
 			if (!changed)
 				wt_mode = ce_mode_from_stat(ce, st.st_mode);
 			else {
@@ -216,7 +217,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		} else {
 			struct stat st;
 
-			changed = check_removed(ce, &st);
+			changed = check_removed(istate, ce, &st);
 			if (changed) {
 				if (changed < 0) {
 					perror(ce->name);
@@ -278,7 +279,8 @@ static void diff_index_show_file(struct rev_info *revs,
 		       oid, oid_valid, ce->name, dirty_submodule);
 }
 
-static int get_stat_data(const struct cache_entry *ce,
+static int get_stat_data(const struct index_state *istate,
+			 const struct cache_entry *ce,
 			 const struct object_id **oidp,
 			 unsigned int *modep,
 			 int cached, int match_missing,
@@ -290,7 +292,7 @@ static int get_stat_data(const struct cache_entry *ce,
 	if (!cached && !ce_uptodate(ce)) {
 		int changed;
 		struct stat st;
-		changed = check_removed(ce, &st);
+		changed = check_removed(istate, ce, &st);
 		if (changed < 0)
 			return -1;
 		else if (changed) {
@@ -321,12 +323,13 @@ static void show_new_file(struct rev_info *revs,
 	const struct object_id *oid;
 	unsigned int mode;
 	unsigned dirty_submodule = 0;
+	struct index_state *istate = revs->diffopt.repo->index;
 
 	/*
 	 * New file in the index: it might actually be different in
 	 * the working tree.
 	 */
-	if (get_stat_data(new_file, &oid, &mode, cached, match_missing,
+	if (get_stat_data(istate, new_file, &oid, &mode, cached, match_missing,
 	    &dirty_submodule, &revs->diffopt) < 0)
 		return;
 
@@ -342,8 +345,9 @@ static int show_modified(struct rev_info *revs,
 	unsigned int mode, oldmode;
 	const struct object_id *oid;
 	unsigned dirty_submodule = 0;
+	struct index_state *istate = revs->diffopt.repo->index;
 
-	if (get_stat_data(new_entry, &oid, &mode, cached, match_missing,
+	if (get_stat_data(istate, new_entry, &oid, &mode, cached, match_missing,
 			  &dirty_submodule, &revs->diffopt) < 0) {
 		if (report_missing)
 			diff_index_show_file(revs, "-", old_entry,
diff --git a/fsmonitor.h b/fsmonitor.h
index 7f1794b90b00..f20d72631d76 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -49,6 +49,17 @@ void refresh_fsmonitor(struct index_state *istate);
  */
 int fsmonitor_is_trivial_response(const struct strbuf *query_result);
 
+/*
+ * Check if refresh_fsmonitor has been called at least once.
+ * refresh_fsmonitor is idempotent. Returns true if fsmonitor is
+ * not enabled (since the state will be "fresh" w/ CE_FSMONITOR_VALID unset)
+ * This version is useful for assertions
+ */
+static inline int is_fsmonitor_refreshed(const struct index_state *istate)
+{
+	return !core_fsmonitor || istate->fsmonitor_has_run_once;
+}
+
 /*
  * Set the given cache entries CE_FSMONITOR_VALID bit. This should be
  * called any time the cache entry has been updated to reflect the
-- 
gitgitgadget

