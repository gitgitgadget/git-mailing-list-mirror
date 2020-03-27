Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B17C2D0EE
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F07206E6
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DunIPbsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgC0At0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:49:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54082 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbgC0AtP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 20:49:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id b12so9809701wmj.3
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 17:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Po/t2SpEj8V7Cmf0oy4tXZLbrv+hONGPyxyRP/bfk54=;
        b=DunIPbsGv+tYHsoPLlqCDolSfbE/U0IaxhmpXRuH4c30P27ido2Q3Y0yzpBTB2HR0l
         SsnKRy6YM0snTc9Q5SoYrvut3wj7f6D2tAbBzLfvUtzwEAjO3E3l5ZnVUJADkODAEY7d
         xJn43a1of6N2fJRCApkEEs5CK5PGgfUTGKhSTy9qUC4PHKYBA4/WesmDfVUs3We1fVsL
         S3DZHTCaz3L03TPr+5ik3e9we0MPCgWu+62/N2nOm5o969inV0XVnLS5W6Tc//hLzd92
         RFRjb5fNsAsCDaLkjj52wqgZTmtbbB5SorQjIWleQCMJf8TNQzQsh2GyRY+OgtS3lqkd
         urvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Po/t2SpEj8V7Cmf0oy4tXZLbrv+hONGPyxyRP/bfk54=;
        b=BOwLoymtZNqmt8ivKRIwlr2fiHi8lmEOgBt/DSkrWlD8tSpYE7hgdSaPUNEkjDC31H
         VDds/b7ooYLPO/8hXrbhkEs4Mp41qAD/RT/qVvJawVMw+loIXn2/SLS3j8wxyD4agNFZ
         Zoe5r1pSjey9ZvPbujrp1+1oms4q78hRbW+NZGy3GnvBtbZ5laA8PXCQRzN0zFGBG3Rl
         sJaksUPJAto5B+SQP5ciNbx8KFZUzjNY8X1c7lfleuTDCRbMFvWwjfaXqrxj1ScrHTJ3
         0r7muXCwlmAziWU5u58H95/9RGIIaCcQEiVTwsmSJOe6zGpdDliVDwOrpqLRFjI1V2We
         IgVQ==
X-Gm-Message-State: ANhLgQ34DrGm0AcbStHsNGXQ3QCYTQAchusIpO/uMXqfmmj/CYu7kJQv
        kMfJZ996Q/b6lhvUJmgqUDWn0IaL
X-Google-Smtp-Source: ADFU+vv8M/Wyw7ONBElaV7Vb3zYnbTSx9hoKKq2rvlEhl7lY58ichLQsgODSUZ/ID2/+haWnwg2OWQ==
X-Received: by 2002:a1c:7e43:: with SMTP id z64mr2541935wmc.45.1585270153954;
        Thu, 26 Mar 2020 17:49:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v21sm5498445wmj.8.2020.03.26.17.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 17:49:13 -0700 (PDT)
Message-Id: <5676e890f65d3b804e2642c7c57532cbcc1d6673.1585270142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
References: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
        <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Mar 2020 00:48:57 +0000
Subject: [PATCH v3 14/18] unpack-trees: split display_error_msgs() into two
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

display_error_msgs() is never called to show messages of both ERROR_*
and WARNING_* types at the same time; it is instead called multiple
times, separately for each type.  Since we want to display these types
differently, make two slightly different versions of this function.

A subsequent commit will further modify unpack_trees() and how it calls
the new display_warning_msgs().

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1091-sparse-checkout-builtin.sh |  4 +--
 unpack-trees.c                     | 50 +++++++++++++++++++++++++-----
 unpack-trees.h                     |  8 +++--
 3 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 9bc65d32f07..ed5e9059969 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -328,10 +328,10 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with dirty status'
 	echo dirty >dirty/folder1/a &&
 
 	git -C dirty sparse-checkout init 2>err &&
-	test_i18ngrep "error.*Cannot update sparse checkout" err &&
+	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
 
 	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* 2>err &&
-	test_i18ngrep "error.*Cannot update sparse checkout" err &&
+	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
 	test_path_is_file dirty/folder1/a &&
 
 	git -C dirty sparse-checkout disable 2>err &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 2a2306c5c28..f9a5626a670 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -24,7 +24,7 @@
  * situation better.  See how "git checkout" and "git merge" replaces
  * them using setup_unpack_trees_porcelain(), for example.
  */
-static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
+static const char *unpack_plumbing_errors[NB_UNPACK_TREES_WARNING_TYPES] = {
 	/* ERROR_WOULD_OVERWRITE */
 	"Entry '%s' would be overwritten by merge. Cannot merge.",
 
@@ -46,6 +46,9 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	/* ERROR_WOULD_LOSE_SUBMODULE */
 	"Submodule '%s' cannot checkout new HEAD.",
 
+	/* NB_UNPACK_TREES_ERROR_TYPES; just a meta value */
+	"",
+
 	/* WARNING_SPARSE_NOT_UPTODATE_FILE */
 	"Entry '%s' not uptodate. Cannot update sparse checkout.",
 
@@ -222,7 +225,7 @@ static int add_rejected_path(struct unpack_trees_options *o,
 
 	/*
 	 * Otherwise, insert in a list for future display by
-	 * display_error_msgs()
+	 * display_(error|warning)_msgs()
 	 */
 	string_list_append(&o->unpack_rejects[e], path);
 	return -1;
@@ -233,13 +236,16 @@ static int add_rejected_path(struct unpack_trees_options *o,
  */
 static void display_error_msgs(struct unpack_trees_options *o)
 {
-	int e, i;
-	int something_displayed = 0;
+	int e;
+	unsigned error_displayed = 0;
 	for (e = 0; e < NB_UNPACK_TREES_ERROR_TYPES; e++) {
 		struct string_list *rejects = &o->unpack_rejects[e];
+
 		if (rejects->nr > 0) {
+			int i;
 			struct strbuf path = STRBUF_INIT;
-			something_displayed = 1;
+
+			error_displayed = 1;
 			for (i = 0; i < rejects->nr; i++)
 				strbuf_addf(&path, "\t%s\n", rejects->items[i].string);
 			error(ERRORMSG(o, e), super_prefixed(path.buf));
@@ -247,10 +253,36 @@ static void display_error_msgs(struct unpack_trees_options *o)
 		}
 		string_list_clear(rejects, 0);
 	}
-	if (something_displayed)
+	if (error_displayed)
 		fprintf(stderr, _("Aborting\n"));
 }
 
+/*
+ * display all the warning messages stored in a nice way
+ */
+static void display_warning_msgs(struct unpack_trees_options *o)
+{
+	int e;
+	unsigned warning_displayed = 0;
+	for (e = NB_UNPACK_TREES_ERROR_TYPES + 1;
+	     e < NB_UNPACK_TREES_WARNING_TYPES; e++) {
+		struct string_list *rejects = &o->unpack_rejects[e];
+
+		if (rejects->nr > 0) {
+			int i;
+			struct strbuf path = STRBUF_INIT;
+
+			warning_displayed = 1;
+			for (i = 0; i < rejects->nr; i++)
+				strbuf_addf(&path, "\t%s\n", rejects->items[i].string);
+			warning(ERRORMSG(o, e), super_prefixed(path.buf));
+			strbuf_release(&path);
+		}
+		string_list_clear(rejects, 0);
+	}
+	if (warning_displayed)
+		fprintf(stderr, _("After fixing the above paths, you may want to run `git sparse-checkout reapply`.\n"));
+}
 static int check_submodule_move_head(const struct cache_entry *ce,
 				     const char *old_id,
 				     const char *new_id,
@@ -1705,8 +1737,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	return ret;
 
 return_failed:
-	if (o->show_all_errors)
+	if (o->show_all_errors) {
 		display_error_msgs(o);
+		display_warning_msgs(o);
+	}
 	mark_all_ce_unused(o->src_index);
 	ret = unpack_failed(o, NULL);
 	if (o->exiting_early)
@@ -1783,7 +1817,7 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
 		ret = UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES;
 
 done:
-	display_error_msgs(o);
+	display_warning_msgs(o);
 	o->show_all_errors = old_show_all_errors;
 	if (free_pattern_list)
 		clear_pattern_list(&pl);
diff --git a/unpack-trees.h b/unpack-trees.h
index aac1ad4b014..dae948205f9 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -24,10 +24,12 @@ enum unpack_trees_error_types {
 	ERROR_BIND_OVERLAP,
 	ERROR_WOULD_LOSE_SUBMODULE,
 
+	NB_UNPACK_TREES_ERROR_TYPES,
+
 	WARNING_SPARSE_NOT_UPTODATE_FILE,
 	WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN,
 
-	NB_UNPACK_TREES_ERROR_TYPES,
+	NB_UNPACK_TREES_WARNING_TYPES,
 };
 
 /*
@@ -66,13 +68,13 @@ struct unpack_trees_options {
 	struct dir_struct *dir;
 	struct pathspec *pathspec;
 	merge_fn_t fn;
-	const char *msgs[NB_UNPACK_TREES_ERROR_TYPES];
+	const char *msgs[NB_UNPACK_TREES_WARNING_TYPES];
 	struct argv_array msgs_to_free;
 	/*
 	 * Store error messages in an array, each case
 	 * corresponding to a error message type
 	 */
-	struct string_list unpack_rejects[NB_UNPACK_TREES_ERROR_TYPES];
+	struct string_list unpack_rejects[NB_UNPACK_TREES_WARNING_TYPES];
 
 	int head_idx;
 	int merge_size;
-- 
gitgitgadget

