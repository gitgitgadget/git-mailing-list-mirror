Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3AC61F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeJQH3X (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:29:23 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:54721 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJQH3X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:29:23 -0400
Received: by mail-qk1-f201.google.com with SMTP id q20-v6so25530898qke.21
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cqXoTb0n8I2f3M/ULsxlF5lrFrX1VIClbDcV5hntEm8=;
        b=Vg9BbEyHvP8ahNZewWX7ztCP45oGc9qk4fBXDymXDE4aclWqha06U8exxoMvqo1IXq
         4XvW/NusM4+xMu395ZaPYo5ALlMPMG2I++iVjZvmooBL6RhIrZBRUerKmw0h+J18BaL8
         ntoyp01sE+ZEqSVwBFzlYU7lI0aPJLZ2wpRfwgAyTQX+3BjMF5x8WOq/no5mbIDdaqGt
         /EtikjXFdzDeHZGp/nLqFKoP4kXE1qtWdiHZzEB7amKglswqOKhKK3BvTEs0V63Ta1Oc
         6EKRjOvzdNCFrcm8qMHNgcf99L5NHLrXJrtbE2SD6gXqQGXKO0Z1DyVyYrUyzgUkqvX2
         dTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cqXoTb0n8I2f3M/ULsxlF5lrFrX1VIClbDcV5hntEm8=;
        b=D8UkyhVRJTfDRK8VqtaCEtVwbt+SCSK1cEm5hTeSDCDGnx5lFvPLNJibPdDZAFp8PT
         9hKx0J4T5FkZfQsLwNHnf7s8XC/d6wOLDCdgTPh9ljCZRyyKrW0VAEJhVBwGEnN7C3up
         8OxyGobzHqyUrKK+OIx02LXXAoXi/reRRZWMhTKlFZzNB6skHvmqAhWyEbfrqBADhyFm
         Sz83R3i94GgbyWtEusPHcaCQBe+fdilUFy1yRrLDa6m1a23DN3rK40tHVYURFTowO6P4
         Rokwu6EI+2GKfamYYNMophIRFmddi1uP0RgWJHyraNzcighb6j4+zlYurx+lPY2YlAve
         nTcw==
X-Gm-Message-State: ABuFfohJ2wFx4F6oGW96cBfI5PkrkJnsa7/uzDQfbsrHEH/YXnaGXocO
        NHowFNiUcqbIGQ7r7AqD19cHJfG6vOHddU2/uLwwKzheXBr5p9dPTM8JX/wyR6aC5qoA9i3k5Cr
        Xy9ZpnReNXLPv5je/jlH84nRkoP71HIPQlTqOygvZpk2i7uVd6to2ysQia4Ft
X-Google-Smtp-Source: ACcGV61LMac7sbzIHL/BdCWJ17+UqWWuCh72nVQrx3jYiBoVPO03TWHTbvFlFyg9idIwjIDlSf9fD30SLeQ/
X-Received: by 2002:ac8:22ce:: with SMTP id g14-v6mr19635407qta.49.1539732997393;
 Tue, 16 Oct 2018 16:36:37 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:35:49 -0700
In-Reply-To: <20181016233550.251311-1-sbeller@google.com>
Message-Id: <20181016233550.251311-19-sbeller@google.com>
Mime-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 18/19] submodule: use submodule repos for object lookup
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This converts the 'show_submodule_header' function to use
the repository API properly, such that the submodule objects
are not added to the main object store.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 75 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 60 insertions(+), 15 deletions(-)

diff --git a/submodule.c b/submodule.c
index 4ee69cc014..7305ae2e10 100644
--- a/submodule.c
+++ b/submodule.c
@@ -444,7 +444,7 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
 	return prepare_revision_walk(rev);
 }
 
-static void print_submodule_summary(struct rev_info *rev, struct diff_options *o)
+static void print_submodule_summary(struct repository *r, struct rev_info *rev, struct diff_options *o)
 {
 	static const char format[] = "  %m %s";
 	struct strbuf sb = STRBUF_INIT;
@@ -455,7 +455,8 @@ static void print_submodule_summary(struct rev_info *rev, struct diff_options *o
 		ctx.date_mode = rev->date_mode;
 		ctx.output_encoding = get_log_output_encoding();
 		strbuf_setlen(&sb, 0);
-		format_commit_message(commit, format, &sb, &ctx);
+		repo_format_commit_message(r, commit, format, &sb,
+				      &ctx);
 		strbuf_addch(&sb, '\n');
 		if (commit->object.flags & SYMMETRIC_LEFT)
 			diff_emit_submodule_del(o, sb.buf);
@@ -482,14 +483,46 @@ void prepare_submodule_repo_env(struct argv_array *out)
 			 DEFAULT_GIT_DIR_ENVIRONMENT);
 }
 
-/* Helper function to display the submodule header line prior to the full
- * summary output. If it can locate the submodule objects directory it will
- * attempt to lookup both the left and right commits and put them into the
- * left and right pointers.
+/*
+ * Initialize 'out' based on the provided submodule path.
+ *
+ * Unlike repo_submodule_init, this tolerates submodules not present
+ * in .gitmodules. This function exists only to preserve historical behavior,
+ *
+ * Returns 0 on success, -1 when the submodule is not present.
+ */
+static int open_submodule(struct repository *out, const char *path)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	if (submodule_to_gitdir(&sb, path) || repo_init(out, sb.buf, NULL)) {
+		strbuf_release(&sb);
+		return -1;
+	}
+
+	out->submodule_prefix = xstrdup(path);
+	out->submodule_prefix = xstrfmt("%s%s/",
+					the_repository->submodule_prefix ?
+					the_repository->submodule_prefix :
+					"", path);
+
+	strbuf_release(&sb);
+	return 0;
+}
+
+/*
+ * Helper function to display the submodule header line prior to the full
+ * summary output.
+ *
+ * If it can locate the submodule git directory it will create a repository
+ * handle for the submodule and lookup both the left and right commits and
+ * put them into the left and right pointers.
  */
-static void show_submodule_header(struct diff_options *o, const char *path,
+static void show_submodule_header(struct diff_options *o,
+		const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule,
+		struct repository *sub,
 		struct commit **left, struct commit **right,
 		struct commit_list **merge_bases)
 {
@@ -508,7 +541,7 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 	else if (is_null_oid(two))
 		message = "(submodule deleted)";
 
-	if (add_submodule_odb(path)) {
+	if (!sub) {
 		if (!message)
 			message = "(commits not present)";
 		goto output_header;
@@ -518,8 +551,8 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 	 * Attempt to lookup the commit references, and determine if this is
 	 * a fast forward or fast backwards update.
 	 */
-	*left = lookup_commit_reference(the_repository, one);
-	*right = lookup_commit_reference(the_repository, two);
+	*left = lookup_commit_reference(sub, one);
+	*right = lookup_commit_reference(sub, two);
 
 	/*
 	 * Warn about missing commits in the submodule project, but only if
@@ -529,7 +562,7 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 	     (!is_null_oid(two) && !*right))
 		message = "(commits not present)";
 
-	*merge_bases = get_merge_bases(*left, *right);
+	*merge_bases = repo_get_merge_bases(sub, *left, *right);
 	if (*merge_bases) {
 		if ((*merge_bases)->item == *left)
 			fast_forward = 1;
@@ -563,16 +596,20 @@ void show_submodule_summary(struct diff_options *o, const char *path,
 	struct rev_info rev;
 	struct commit *left = NULL, *right = NULL;
 	struct commit_list *merge_bases = NULL;
+	struct repository subrepo, *sub = &subrepo;
+
+	if (open_submodule(&subrepo, path) < 0)
+		sub = NULL;
 
 	show_submodule_header(o, path, one, two, dirty_submodule,
-			      &left, &right, &merge_bases);
+			      sub, &left, &right, &merge_bases);
 
 	/*
 	 * If we don't have both a left and a right pointer, there is no
 	 * reason to try and display a summary. The header line should contain
 	 * all the information the user needs.
 	 */
-	if (!left || !right)
+	if (!left || !right || !sub)
 		goto out;
 
 	/* Treat revision walker failure the same as missing commits */
@@ -581,13 +618,15 @@ void show_submodule_summary(struct diff_options *o, const char *path,
 		goto out;
 	}
 
-	print_submodule_summary(&rev, o);
+	print_submodule_summary(sub, &rev, o);
 
 out:
 	if (merge_bases)
 		free_commit_list(merge_bases);
 	clear_commit_marks(left, ~0);
 	clear_commit_marks(right, ~0);
+	if (sub)
+		repo_clear(sub);
 }
 
 void show_submodule_inline_diff(struct diff_options *o, const char *path,
@@ -599,9 +638,13 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 	struct commit_list *merge_bases = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf sb = STRBUF_INIT;
+	struct repository subrepo, *sub = &subrepo;
+
+	if (open_submodule(&subrepo, path) < 0)
+		sub = NULL;
 
 	show_submodule_header(o, path, one, two, dirty_submodule,
-			      &left, &right, &merge_bases);
+			      sub, &left, &right, &merge_bases);
 
 	/* We need a valid left and right commit to display a difference */
 	if (!(left || is_null_oid(one)) ||
@@ -662,6 +705,8 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 		clear_commit_marks(left, ~0);
 	if (right)
 		clear_commit_marks(right, ~0);
+	if (sub)
+		repo_clear(sub);
 }
 
 int should_update_submodules(void)
-- 
2.19.0

