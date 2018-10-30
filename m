Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D6051F453
	for <e@80x24.org>; Tue, 30 Oct 2018 22:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeJaHEf (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:04:35 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:57179 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbeJaHEe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:04:34 -0400
Received: by mail-io1-f74.google.com with SMTP id x12-v6so12071119iob.23
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tBH/nMpD/A+qFk1i7otVxC5dn/xz25wAO2NOMDggQmg=;
        b=mvGUIZB1QmxO/qUj0Op/y7L4b9ZFSHLVbxm9k06CHgLMiIRXmutsYxWo196QNKf4/Q
         5ClvaThM3XYl5/hQzMpGxibMzQrmwYSXP6vEfZ8wxnDdnTqhFcGJmV4r0k/zXZFga1bh
         tnxJE9E1wKfLtmmb7rZqwuJT+pGh252PgNL7F+p39GV+rgQXOe1+9DI6tAuiuiluuLWC
         EDgSYTTWx9eYUDCYKedCk/+Og00wXyyNzBS/CT4vnXZ7gwcGZHr1GL8hrl05dbk0cq1V
         c2UBd0NDE4mcoaV5QwA4Aq9DCL9zBuYAWqzRlgomkCaA9hV4Cc7DzVTBx/zQUJTm4vYx
         Avpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tBH/nMpD/A+qFk1i7otVxC5dn/xz25wAO2NOMDggQmg=;
        b=TocrK87V9yhwguOJLTnYvLfNkslbercDhpE5gCmhYINc+C2SxmX8xd3BFIeacDLup7
         aGVQYS6FbUo1fe4V3WS6Tq8Dn03CTkPuNeIizEX5PZylE6kgVR3+CCZ1ibpX8fhB2f3s
         bHCxada4DNbqHpdF4vvlXdfA2x9YW7Ufo1I+nVnXvXjOa4GoABCBNHCf43V5lz8j1lXP
         uMaap9X0RwPqBJ6NrFdNa9a9dWubZevUugK1uIKZArxrpCBCtosDBOzC1r7GEdgE2Tr7
         BR2Tl3Uy9dclxtCAOZSvigqbL4usuuglvtfV4TKQRtyCG8IcFWyT3n6hEwD7MltZzKZv
         IwHg==
X-Gm-Message-State: AGRZ1gLkWdyKUnan1ln1Zrdc8tJ5F7/5b7ttuIzvVHGudUrTlLKHpKQn
        pxTi9IlRl3l5/AB3AQr+kIEgwLlfM0lUMDm4cP7H8PLOienJXsPyksWnvIF8IjkOJwdWMSWses4
        1KpHhxs66TbzGH7E1LbdZJixuZ82bYIuzdRMQP8bCfBQbVmzepVomD81ONPUE
X-Google-Smtp-Source: AJdET5ePnvTPKUBRGlHx4WZWMCmZabcxvlOX/lJcXmDGjL+ZfBpfza67T0PGjDO+sMRy/IukCEvRSAHfevCJ
X-Received: by 2002:a24:2bd3:: with SMTP id h202-v6mr301216ita.21.1540937358896;
 Tue, 30 Oct 2018 15:09:18 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:08:12 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-20-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 19/24] submodule: use submodule repos for object lookup
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
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
 submodule.c | 76 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 61 insertions(+), 15 deletions(-)

diff --git a/submodule.c b/submodule.c
index d9d3046689..0fdda45252 100644
--- a/submodule.c
+++ b/submodule.c
@@ -443,7 +443,7 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
 	return prepare_revision_walk(rev);
 }
 
-static void print_submodule_summary(struct rev_info *rev, struct diff_options *o)
+static void print_submodule_summary(struct repository *r, struct rev_info *rev, struct diff_options *o)
 {
 	static const char format[] = "  %m %s";
 	struct strbuf sb = STRBUF_INIT;
@@ -454,7 +454,8 @@ static void print_submodule_summary(struct rev_info *rev, struct diff_options *o
 		ctx.date_mode = rev->date_mode;
 		ctx.output_encoding = get_log_output_encoding();
 		strbuf_setlen(&sb, 0);
-		format_commit_message(commit, format, &sb, &ctx);
+		repo_format_commit_message(r, commit, format, &sb,
+				      &ctx);
 		strbuf_addch(&sb, '\n');
 		if (commit->object.flags & SYMMETRIC_LEFT)
 			diff_emit_submodule_del(o, sb.buf);
@@ -481,14 +482,47 @@ void prepare_submodule_repo_env(struct argv_array *out)
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
  */
-static void show_submodule_header(struct diff_options *o, const char *path,
+static struct repository *open_submodule(const char *path)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct repository *out = xmalloc(sizeof(*out));
+
+	if (submodule_to_gitdir(&sb, path) || repo_init(out, sb.buf, NULL)) {
+		strbuf_release(&sb);
+		free(out);
+		return NULL;
+	}
+
+	out->submodule_prefix = xstrfmt("%s%s/",
+					the_repository->submodule_prefix ?
+					the_repository->submodule_prefix :
+					"", path);
+
+	strbuf_release(&sb);
+	return out;
+}
+
+/*
+ * Helper function to display the submodule header line prior to the full
+ * summary output.
+ *
+ * If it can locate the submodule git directory it will create a repository
+ * handle for the submodule and lookup both the left and right commits and
+ * put them into the left and right pointers.
+ */
+static void show_submodule_header(struct diff_options *o,
+		const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule,
+		struct repository *sub,
 		struct commit **left, struct commit **right,
 		struct commit_list **merge_bases)
 {
@@ -507,7 +541,7 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 	else if (is_null_oid(two))
 		message = "(submodule deleted)";
 
-	if (add_submodule_odb(path)) {
+	if (!sub) {
 		if (!message)
 			message = "(commits not present)";
 		goto output_header;
@@ -517,8 +551,8 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 	 * Attempt to lookup the commit references, and determine if this is
 	 * a fast forward or fast backwards update.
 	 */
-	*left = lookup_commit_reference(the_repository, one);
-	*right = lookup_commit_reference(the_repository, two);
+	*left = lookup_commit_reference(sub, one);
+	*right = lookup_commit_reference(sub, two);
 
 	/*
 	 * Warn about missing commits in the submodule project, but only if
@@ -528,7 +562,7 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 	     (!is_null_oid(two) && !*right))
 		message = "(commits not present)";
 
-	*merge_bases = get_merge_bases(*left, *right);
+	*merge_bases = repo_get_merge_bases(sub, *left, *right);
 	if (*merge_bases) {
 		if ((*merge_bases)->item == *left)
 			fast_forward = 1;
@@ -562,16 +596,18 @@ void show_submodule_summary(struct diff_options *o, const char *path,
 	struct rev_info rev;
 	struct commit *left = NULL, *right = NULL;
 	struct commit_list *merge_bases = NULL;
+	struct repository *sub;
 
+	sub = open_submodule(path);
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
@@ -580,13 +616,17 @@ void show_submodule_summary(struct diff_options *o, const char *path,
 		goto out;
 	}
 
-	print_submodule_summary(&rev, o);
+	print_submodule_summary(sub, &rev, o);
 
 out:
 	if (merge_bases)
 		free_commit_list(merge_bases);
 	clear_commit_marks(left, ~0);
 	clear_commit_marks(right, ~0);
+	if (sub) {
+		repo_clear(sub);
+		free(sub);
+	}
 }
 
 void show_submodule_inline_diff(struct diff_options *o, const char *path,
@@ -598,9 +638,11 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 	struct commit_list *merge_bases = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf sb = STRBUF_INIT;
+	struct repository *sub;
 
+	sub = open_submodule(path);
 	show_submodule_header(o, path, one, two, dirty_submodule,
-			      &left, &right, &merge_bases);
+			      sub, &left, &right, &merge_bases);
 
 	/* We need a valid left and right commit to display a difference */
 	if (!(left || is_null_oid(one)) ||
@@ -661,6 +703,10 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 		clear_commit_marks(left, ~0);
 	if (right)
 		clear_commit_marks(right, ~0);
+	if (sub) {
+		repo_clear(sub);
+		free(sub);
+	}
 }
 
 int should_update_submodules(void)
-- 
2.19.1.930.g4563a0d9d0-goog

