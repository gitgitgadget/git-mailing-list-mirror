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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C435C433E6
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 22:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3631264E77
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 22:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhCNWRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 18:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhCNWRm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 18:17:42 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B984EC061574
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 15:17:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b9so4772124wrt.8
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 15:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w11hh3M80MmjnO7LUjMtDjtaGxocqE7NunSOyGe7LU4=;
        b=HUCtNBOQeuNUN45xPsz8kduBSPUmgo2GygJlsoUmfsBbeYc/9dijXfyfSegvgbXdWA
         RsgNiiAwWCKI7I6le+b9ozxYYTnwSI7rhKXunCIUZmXcZOVDvGQJLC6X6AYjrylDVkEI
         Z4gqg+6GZe9Qn5Qe4NiK60d+875ijA4vZ7tb4tARh/C78M3IVwuKHqwMNrWLFsI+6jVw
         wZtZaG09Wtix87tFZN1OelpubjH/eVJjdrDQBDTg70DGqIPZ0i/yLAfM3wx5t+76mjzX
         Y5KdCZyJavCP2WdCrVRG8bwKYzssz/tiq3+SvRR7WBgxT/U303t192iRusYu3oLvST6C
         r14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=w11hh3M80MmjnO7LUjMtDjtaGxocqE7NunSOyGe7LU4=;
        b=CBz/mNPsCI+XaQk6TJUq05EAhJpH5vKK6PrMGSgd9iAHYf//+2dKdL7BXuFtS1TV4l
         1QX++1NEz1gy6FHOyMIo6fKzLNFOw1JMaxm8MIVICOXAdqKTbU43sps3eF4Y3B1WwpQx
         LScXRhyC3KpvalEDzHGfhuEB7H8G1AIWV2DR+gC3492B9RlF3tLqwO8RulcyJB0AqQzX
         eHgFDjRhzPQQoAwCzfNX1RRykY00t075QrIG9WVW1u/qzbSy504tyFSXpq9HXVVd2zof
         LWu0bPuOSwn7BKxJ9zinOa9LtPnYLLt40U/jfYpl1Qh3Zw2Iyr+DTGSybQhHE0pZhAU0
         sb4A==
X-Gm-Message-State: AOAM533kix2a1dXNuZclZnB0yyljXbSuOVnBSo2QFfGDFIeq990pDt1G
        FzSZEhp9r5556qpY/SQq10VGj7+UO0Q=
X-Google-Smtp-Source: ABdhPJx/nWU28QQE/PA1y3QPClEsdwrfIQFDWmGqhmXnfBo7dNoIOsGfpH3lVQc6IsF207oBdDE0/Q==
X-Received: by 2002:a5d:550b:: with SMTP id b11mr24999244wrv.313.1615760260453;
        Sun, 14 Mar 2021 15:17:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm10297192wmc.48.2021.03.14.15.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 15:17:40 -0700 (PDT)
Message-Id: <dda5b537a3f0706ebf933e2b2efd996267e9d9b1.1615760258.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.903.git.1615760258.gitgitgadget@gmail.com>
References: <pull.903.git.1615760258.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Mar 2021 22:17:36 +0000
Subject: [PATCH 2/3] fsmonitor: add assertion that fsmonitor is valid to
 check_removed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>,
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
index 7f1794b90b00..c12f10117544 100644
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
+    return !core_fsmonitor || istate->fsmonitor_has_run_once;
+}
+
 /*
  * Set the given cache entries CE_FSMONITOR_VALID bit. This should be
  * called any time the cache entry has been updated to reflect the
-- 
gitgitgadget

