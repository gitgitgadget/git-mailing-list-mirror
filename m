Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8EE920A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeLOAK3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:10:29 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:46123 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730078AbeLOAK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:10:29 -0500
Received: by mail-yw1-f74.google.com with SMTP id 201so4301656ywp.13
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=h911hwbgt4R2XVW9i2h1mw8pGQbidqFcJxAaPVbO7vs=;
        b=DfZ7pIJI0hEWRG9Yt7HrYqffkhAT/7FZnXzLaDFvEjsDX4jr3fLtxlSt3A5vkhbMzW
         jcMHJvQLiE/hpsBjtwvQ2AgrHMp58K03h21wGklKSbnoMxCA+3eN339SvanQmA3IcJMS
         UE/mQqzOfh5of7/TV6icAjW+rjU3vDmf/zXuVECuuSsfL/uYS5yZaDNsguzoDAJdMvYu
         n9f+bkNSz56hJvfPQf0iP+CWn6iLIgL64XYp7prbPDM0sJVwWr4XxaML29+WoY/l3IXd
         p3bVdlzCAgkhf9K4d67ogcxXGdHzr+yUfcplvzv6wSBgga6OKrK3MpUyLou2ngh89CiS
         IAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=h911hwbgt4R2XVW9i2h1mw8pGQbidqFcJxAaPVbO7vs=;
        b=Kef8fLRL5zKB4B4Kr8sBlKIBCNfK18U2eg4k3miKGNvM0CwNPbTEcOI6JgRqCmWzzu
         giRJm+g2V8EDaQcU+7PrLKjLuuSAerqDbZbrytdJaYD9WIIJv7UfmuF+wOl0+oMWv93z
         GmjBRgNORL3X0YMOca5v+QPNJaaxldPaVBQRdQ7Sl6/jUi9sikS/tEHwjSkLgxDjCoeh
         AwCZa6Z9nnaYq1xWj0As4/sHU+iTGJ6FtVvtLHB7RqG20cQ3oxuPFlFCf+vlOq9hQ66f
         eGkFl+1Vxzx2skUGoP4fXBxVrd+ViJqZxvvGqItEpeQDxWbP1jA60GhgzauTq/biAVXX
         jXhQ==
X-Gm-Message-State: AA+aEWbLXaja8UFNCezTV9/89IKR3T8thr+/xTxdicokhRoerouq3HBl
        i7HFsc/ci37BtlQb66uQvRRWbnvN3m2iDBDde2TiDMzt3KjE9t3xS6EXgFH+Ob9l1GPbfcmB1I0
        IIlzzckimKwoOgrnALdgGoIvujt5jYJNf5/VDfwKjsDTaTZYLxWcnw498i1Lt
X-Google-Smtp-Source: AFSGD/V0o8HRXKKzhoY0qkZUIGFC/Yzn3cVciTpB64EtYaJmJCqJeyMQzn44VKVyFz+lWl1BcZTwVIeJcJcx
X-Received: by 2002:a25:e656:: with SMTP id d83mr2964448ybh.37.1544832628155;
 Fri, 14 Dec 2018 16:10:28 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:09:37 -0800
In-Reply-To: <20181215000942.46033-1-sbeller@google.com>
Message-Id: <20181215000942.46033-19-sbeller@google.com>
Mime-Version: 1.0
References: <20181215000942.46033-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 18/23] submodule: use submodule repos for object lookup
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This converts the 'show_submodule_header' function to use
the repository API properly, such that the submodule objects
are not added to the main object store.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c | 75 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 60 insertions(+), 15 deletions(-)

diff --git a/submodule.c b/submodule.c
index d9d3046689..4486ff664b 100644
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
@@ -481,14 +482,46 @@ void prepare_submodule_repo_env(struct argv_array *out)
 			 DEFAULT_GIT_DIR_ENVIRONMENT);
 }
 
-/* Helper function to display the submodule header line prior to the full
- * summary output. If it can locate the submodule objects directory it will
- * attempt to lookup both the left and right commits and put them into the
- * left and right pointers.
+/*
+ * Initialize a repository struct for a submodule based on the provided 'path'.
+ *
+ * Unlike repo_submodule_init, this tolerates submodules not present
+ * in .gitmodules. This function exists only to preserve historical behavior,
+ *
+ * Returns the repository struct on success,
+ * NULL when the submodule is not present.
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
+	/* Mark it as a submodule */
+	out->submodule_prefix = xstrdup(path);
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
@@ -507,7 +540,7 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 	else if (is_null_oid(two))
 		message = "(submodule deleted)";
 
-	if (add_submodule_odb(path)) {
+	if (!sub) {
 		if (!message)
 			message = "(commits not present)";
 		goto output_header;
@@ -517,8 +550,8 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 	 * Attempt to lookup the commit references, and determine if this is
 	 * a fast forward or fast backwards update.
 	 */
-	*left = lookup_commit_reference(the_repository, one);
-	*right = lookup_commit_reference(the_repository, two);
+	*left = lookup_commit_reference(sub, one);
+	*right = lookup_commit_reference(sub, two);
 
 	/*
 	 * Warn about missing commits in the submodule project, but only if
@@ -528,7 +561,7 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 	     (!is_null_oid(two) && !*right))
 		message = "(commits not present)";
 
-	*merge_bases = get_merge_bases(*left, *right);
+	*merge_bases = repo_get_merge_bases(sub, *left, *right);
 	if (*merge_bases) {
 		if ((*merge_bases)->item == *left)
 			fast_forward = 1;
@@ -562,16 +595,18 @@ void show_submodule_summary(struct diff_options *o, const char *path,
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
@@ -580,13 +615,17 @@ void show_submodule_summary(struct diff_options *o, const char *path,
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
@@ -598,9 +637,11 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
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
@@ -661,6 +702,10 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
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
2.20.0.405.gbc1bbc6f85-goog

