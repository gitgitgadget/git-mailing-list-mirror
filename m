Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40B181F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 21:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeJLErm (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 00:47:42 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:51985 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJLErm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 00:47:42 -0400
Received: by mail-it1-f202.google.com with SMTP id u2-v6so10776737ith.1
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0L9yyL6/ctK0N33OCpWLxP2yvQk/1Xh40CMdkyPYXPo=;
        b=Kv657acac5/YBgPaTBULJ4HD6IZ2kBaFsm6ypzJYPMMNFqAuGDWmqiBtXGhZblF9Vb
         My0AFY9hBMuuL+W6Al0s6QaC7xWnOkYcI/dwtDl8ssqaIAVmLJb3EoOOBpY3QreJHe5u
         Q/QeUb9moba12kDJ8cd04d7Wuv+RQTNuyAH+ZqU7ZJ1ivPXptRix0KYPlxcdGE2W9Iro
         TFgJlw4NeT9MBUYpFGhxwkFDSuNix/x+41yLafQo+XpHDOSM8QuawtpNNs0oLgUzvTkd
         vWtPX0G8N+oEX+tb2/XQJEN/MtJEPo2zU+1RsjT9toYTF1pRRaOD9Y/2hBMWQIzStJ9R
         hZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0L9yyL6/ctK0N33OCpWLxP2yvQk/1Xh40CMdkyPYXPo=;
        b=Tw6/ZdgWKNOLXxmjy83tCu2MfeiRGMvxVWiPOQK8jxE9Vu9CFwRYDqOetWeYvYiPXB
         WpAtOnaPP1Gci+AYHThI9TXg9u4xodPh3egu/iHgldt2kVlMjn9cEkQ/T8GZ09sNgyVK
         cr35ANEK2psfEvp/E89v59+YIDBVzpl58RjBt3ppBX3gD5t+OOSa7gZln3E0OliNBSn0
         6K//EhItbfLtb+d9mStHyRkgBIvuL+NBRWHVNuphOxMB3Mnecs9LXxQL+4nN4IedVl7Y
         u08mT1gzS7+BG+NafvwiqSkjU3WKS/inPX16zIopiaQF6oJgaATSv7Sl5C/rgmrAMS++
         wxtg==
X-Gm-Message-State: ABuFfoiZ/OwA18ECBWPcpgLGi3+v4iRPQQtHsTTIVq2pQnqWnLP/pRiP
        8m6EH41q1rvX70cjqXr0S3Jo9MBHEbdUalv69AySm9rSX9OTU1WikeVHK6HFVj0Xxq2B1DnVwFN
        wdEJYMxomLtE4ztR71/I/nP2Zn/kIp8vc3DeS1U3E8xdBEJpGcQ+6j/6i526J
X-Google-Smtp-Source: ACcGV63JbmH07lpLl2nbIXUNLEc68PpAAKSIJWNfiLxEmBcerVAbWpGPNQ6gyTur3jOFgs++s5g13UhJ+CTy
X-Received: by 2002:a24:dd45:: with SMTP id t66-v6mr5904923itf.5.1539292717023;
 Thu, 11 Oct 2018 14:18:37 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:17:52 -0700
In-Reply-To: <20181011211754.31369-1-sbeller@google.com>
Message-Id: <20181011211754.31369-18-sbeller@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 17/19] submodule: use submodule repos for object lookup
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
 submodule.c | 48 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index 442229bb49..5e1a6c0b7c 100644
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
@@ -481,12 +482,37 @@ void prepare_submodule_repo_env(struct argv_array *out)
 			 DEFAULT_GIT_DIR_ENVIRONMENT);
 }
 
+/*
+ * Initialize 'out' based on the provided submodule path.
+ *
+ * Unlike repo_submodule_init, this tolerates submodules not present
+ * in .gitmodules. NEEDSWORK: The repo_submodule_init behavior is
+ * preferrable. This function exists only to preserve historical behavior.
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
+
+	strbuf_release(&sb);
+	return 0;
+}
+
 /* Helper function to display the submodule header line prior to the full
  * summary output. If it can locate the submodule objects directory it will
  * attempt to lookup both the left and right commits and put them into the
  * left and right pointers.
  */
-static void show_submodule_header(struct diff_options *o, const char *path,
+static void show_submodule_header(struct diff_options *o, struct repository *sub,
+		const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule,
 		struct commit **left, struct commit **right,
@@ -507,7 +533,7 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 	else if (is_null_oid(two))
 		message = "(submodule deleted)";
 
-	if (add_submodule_odb(path)) {
+	if (open_submodule(sub, path) < 0) {
 		if (!message)
 			message = "(commits not present)";
 		goto output_header;
@@ -517,8 +543,8 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 	 * Attempt to lookup the commit references, and determine if this is
 	 * a fast forward or fast backwards update.
 	 */
-	*left = lookup_commit_reference(the_repository, one);
-	*right = lookup_commit_reference(the_repository, two);
+	*left = lookup_commit_reference(sub, one);
+	*right = lookup_commit_reference(sub, two);
 
 	/*
 	 * Warn about missing commits in the submodule project, but only if
@@ -528,7 +554,7 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 	     (!is_null_oid(two) && !*right))
 		message = "(commits not present)";
 
-	*merge_bases = get_merge_bases(*left, *right);
+	*merge_bases = repo_get_merge_bases(sub, *left, *right);
 	if (*merge_bases) {
 		if ((*merge_bases)->item == *left)
 			fast_forward = 1;
@@ -562,8 +588,9 @@ void show_submodule_summary(struct diff_options *o, const char *path,
 	struct rev_info rev;
 	struct commit *left = NULL, *right = NULL;
 	struct commit_list *merge_bases = NULL;
+	struct repository sub;
 
-	show_submodule_header(o, path, one, two, dirty_submodule,
+	show_submodule_header(o, &sub, path, one, two, dirty_submodule,
 			      &left, &right, &merge_bases);
 
 	/*
@@ -580,7 +607,7 @@ void show_submodule_summary(struct diff_options *o, const char *path,
 		goto out;
 	}
 
-	print_submodule_summary(&rev, o);
+	print_submodule_summary(&sub, &rev, o);
 
 out:
 	if (merge_bases)
@@ -598,8 +625,9 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 	struct commit_list *merge_bases = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf sb = STRBUF_INIT;
+	struct repository sub;
 
-	show_submodule_header(o, path, one, two, dirty_submodule,
+	show_submodule_header(o, &sub, path, one, two, dirty_submodule,
 			      &left, &right, &merge_bases);
 
 	/* We need a valid left and right commit to display a difference */
-- 
2.19.0

