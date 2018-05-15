Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAFEE1F406
	for <e@80x24.org>; Tue, 15 May 2018 20:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbeEOUA6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 16:00:58 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46291 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752731AbeEOUAl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 16:00:41 -0400
Received: by mail-pf0-f196.google.com with SMTP id p12-v6so560175pff.13
        for <git@vger.kernel.org>; Tue, 15 May 2018 13:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dMRL6dWFZoh1NB3Y7dxmdbOj7Z9dxiK+0i56LOVWLrU=;
        b=UXwWZbD3eu3bU0jtnBr/yay/q68Uuf9VcAaPkLMyuHpXsKPCeo16PvFCkhza1dYBpu
         5vhE8Q3ciFuWwN4mHOlDWGVZ/wkGBx//wsShYd7sZz8GLOhBSl8vJR1Tio0kDxbizS8X
         XnAwNF6azaW6tk/gQc6G7BgZKgKsw/mQc9kavfbEVZyZqrMpD/DL72J2zm1p7ihsqL1C
         RdMoq+7OhTwQyDvv/vHM0yjPKubv/0vvsLRHGmt8vsM4AJU6+MmP84/WX5/wjK+o0F/U
         Wv7CnY+GBNPmadwqOwrn6+S5MYylbvhVLHkiYSQHAXnJEx8QS8F9xdP0iy6yUV9/OW4F
         SWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dMRL6dWFZoh1NB3Y7dxmdbOj7Z9dxiK+0i56LOVWLrU=;
        b=qd4Ncv2XfKGUU+ysu6Dp5FC73hYtGEhUhlcHWaOJP300yDRh410hwEquADRJLZ/zek
         bGsnJP3Ur2n5lTMkf7nn+ZYv3V5TtDCN1NFH0jo++bQAKi2zLJnA0YRPr8a/1b5Gv7xj
         DYgNQd7hn/NBCzwvfuVB7A376r1AzLWN8LyJtlnwxHEUYragxh0/bpVebccj4+JcHOie
         n2ezZ8FsJbLHz0LZHQ/6aF7omN09Cty8NTGG4slM238jMtQdvn/SR3W+UHC7KTt9QL7b
         7QG5KtiV9oqnOcEdYro5yIiL98rAkZju2zLaY6zg4uXSMsft/CqLu6cfDqlylyPZy73H
         lUYg==
X-Gm-Message-State: ALKqPwehXvBzZQkuKus0rfBMXSuIfmhyzKyb/Ko0yoOCOPhDEI72CJ/H
        yu4DApUHK488idOn8a6DNg16MrY7NZM=
X-Google-Smtp-Source: AB8JxZq+Y/hEkdABbsqv6H19lcQK1tUa8Q9OxCQUkOzTtysddd/QIhi280dcbCxmtqvYXhHTo9qnZw==
X-Received: by 2002:a62:6105:: with SMTP id v5-v6mr16464753pfb.197.1526414440518;
        Tue, 15 May 2018 13:00:40 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 65-v6sm858989pgj.22.2018.05.15.13.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 13:00:39 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, leif.middelschulte@gmail.com
Cc:     gitster@pobox.com, newren@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] submodule.c: move submodule merging to merge-recursive.c
Date:   Tue, 15 May 2018 13:00:28 -0700
Message-Id: <20180515200030.88731-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180515200030.88731-1-sbeller@google.com>
References: <20180515200030.88731-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we want to improve submodule merging by using the output()
function in merge-recursive.c for submodule merges to deliver a consistent
UI to users.

To do so we could either make the output() function globally available
so we can use it in submodule.c#merge_submodule(), or we could integrate
the submodule merging into the merging code. Choose the later as we
generally want to move submodules closer into the core.

Therefore we move any function related to merging submodules
(merge_submodule(), find_first_merges() and print_commit) to
merge-recursive.c.  We'll keep add_submodule_odb() in submodule.c as it
is used by other submodule functions. While at it, add a TODO note that
we do not really like the function add_submodule_odb().

This commit is best viewed with --color-moved.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 merge-recursive.c | 166 +++++++++++++++++++++++++++++++++++++++++++++
 submodule.c       | 168 +---------------------------------------------
 submodule.h       |   6 +-
 3 files changed, 170 insertions(+), 170 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 0c0d48624da..700ba15bf88 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -23,6 +23,7 @@
 #include "merge-recursive.h"
 #include "dir.h"
 #include "submodule.h"
+#include "revision.h"
 
 struct path_hashmap_entry {
 	struct hashmap_entry e;
@@ -977,6 +978,171 @@ static int merge_3way(struct merge_options *o,
 	return merge_status;
 }
 
+static int find_first_merges(struct object_array *result, const char *path,
+		struct commit *a, struct commit *b)
+{
+	int i, j;
+	struct object_array merges = OBJECT_ARRAY_INIT;
+	struct commit *commit;
+	int contains_another;
+
+	char merged_revision[42];
+	const char *rev_args[] = { "rev-list", "--merges", "--ancestry-path",
+				   "--all", merged_revision, NULL };
+	struct rev_info revs;
+	struct setup_revision_opt rev_opts;
+
+	memset(result, 0, sizeof(struct object_array));
+	memset(&rev_opts, 0, sizeof(rev_opts));
+
+	/* get all revisions that merge commit a */
+	xsnprintf(merged_revision, sizeof(merged_revision), "^%s",
+			oid_to_hex(&a->object.oid));
+	init_revisions(&revs, NULL);
+	rev_opts.submodule = path;
+	/* FIXME: can't handle linked worktrees in submodules yet */
+	revs.single_worktree = path != NULL;
+	setup_revisions(ARRAY_SIZE(rev_args)-1, rev_args, &revs, &rev_opts);
+
+	/* save all revisions from the above list that contain b */
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
+	while ((commit = get_revision(&revs)) != NULL) {
+		struct object *o = &(commit->object);
+		if (in_merge_bases(b, commit))
+			add_object_array(o, NULL, &merges);
+	}
+	reset_revision_walk();
+
+	/* Now we've got all merges that contain a and b. Prune all
+	 * merges that contain another found merge and save them in
+	 * result.
+	 */
+	for (i = 0; i < merges.nr; i++) {
+		struct commit *m1 = (struct commit *) merges.objects[i].item;
+
+		contains_another = 0;
+		for (j = 0; j < merges.nr; j++) {
+			struct commit *m2 = (struct commit *) merges.objects[j].item;
+			if (i != j && in_merge_bases(m2, m1)) {
+				contains_another = 1;
+				break;
+			}
+		}
+
+		if (!contains_another)
+			add_object_array(merges.objects[i].item, NULL, result);
+	}
+
+	object_array_clear(&merges);
+	return result->nr;
+}
+
+static void print_commit(struct commit *commit)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct pretty_print_context ctx = {0};
+	ctx.date_mode.type = DATE_NORMAL;
+	format_commit_message(commit, " %h: %m %s", &sb, &ctx);
+	fprintf(stderr, "%s\n", sb.buf);
+	strbuf_release(&sb);
+}
+
+#define MERGE_WARNING(path, msg) \
+	warning("Failed to merge submodule %s (%s)", path, msg);
+
+static int merge_submodule(struct object_id *result, const char *path,
+			   const struct object_id *base, const struct object_id *a,
+			   const struct object_id *b, int search)
+{
+	struct commit *commit_base, *commit_a, *commit_b;
+	int parent_count;
+	struct object_array merges;
+
+	int i;
+
+	/* store a in result in case we fail */
+	oidcpy(result, a);
+
+	/* we can not handle deletion conflicts */
+	if (is_null_oid(base))
+		return 0;
+	if (is_null_oid(a))
+		return 0;
+	if (is_null_oid(b))
+		return 0;
+
+	if (add_submodule_odb(path)) {
+		MERGE_WARNING(path, "not checked out");
+		return 0;
+	}
+
+	if (!(commit_base = lookup_commit_reference(base)) ||
+	    !(commit_a = lookup_commit_reference(a)) ||
+	    !(commit_b = lookup_commit_reference(b))) {
+		MERGE_WARNING(path, "commits not present");
+		return 0;
+	}
+
+	/* check whether both changes are forward */
+	if (!in_merge_bases(commit_base, commit_a) ||
+	    !in_merge_bases(commit_base, commit_b)) {
+		MERGE_WARNING(path, "commits don't follow merge-base");
+		return 0;
+	}
+
+	/* Case #1: a is contained in b or vice versa */
+	if (in_merge_bases(commit_a, commit_b)) {
+		oidcpy(result, b);
+		return 1;
+	}
+	if (in_merge_bases(commit_b, commit_a)) {
+		oidcpy(result, a);
+		return 1;
+	}
+
+	/*
+	 * Case #2: There are one or more merges that contain a and b in
+	 * the submodule. If there is only one, then present it as a
+	 * suggestion to the user, but leave it marked unmerged so the
+	 * user needs to confirm the resolution.
+	 */
+
+	/* Skip the search if makes no sense to the calling context.  */
+	if (!search)
+		return 0;
+
+	/* find commit which merges them */
+	parent_count = find_first_merges(&merges, path, commit_a, commit_b);
+	switch (parent_count) {
+	case 0:
+		MERGE_WARNING(path, "merge following commits not found");
+		break;
+
+	case 1:
+		MERGE_WARNING(path, "not fast-forward");
+		fprintf(stderr, "Found a possible merge resolution "
+				"for the submodule:\n");
+		print_commit((struct commit *) merges.objects[0].item);
+		fprintf(stderr,
+			"If this is correct simply add it to the index "
+			"for example\n"
+			"by using:\n\n"
+			"  git update-index --cacheinfo 160000 %s \"%s\"\n\n"
+			"which will accept this suggestion.\n",
+			oid_to_hex(&merges.objects[0].item->oid), path);
+		break;
+
+	default:
+		MERGE_WARNING(path, "multiple merges found");
+		for (i = 0; i < merges.nr; i++)
+			print_commit((struct commit *) merges.objects[i].item);
+	}
+
+	object_array_clear(&merges);
+	return 0;
+}
+
 static int merge_file_1(struct merge_options *o,
 					   const struct diff_filespec *one,
 					   const struct diff_filespec *a,
diff --git a/submodule.c b/submodule.c
index 74d35b25779..654089b3647 100644
--- a/submodule.c
+++ b/submodule.c
@@ -153,7 +153,8 @@ void stage_updated_gitmodules(struct index_state *istate)
 		die(_("staging updated .gitmodules failed"));
 }
 
-static int add_submodule_odb(const char *path)
+/* TODO: remove this function, use repo_submodule_init instead. */
+int add_submodule_odb(const char *path)
 {
 	struct strbuf objects_directory = STRBUF_INIT;
 	int ret = 0;
@@ -1701,171 +1702,6 @@ int submodule_move_head(const char *path,
 	return ret;
 }
 
-static int find_first_merges(struct object_array *result, const char *path,
-		struct commit *a, struct commit *b)
-{
-	int i, j;
-	struct object_array merges = OBJECT_ARRAY_INIT;
-	struct commit *commit;
-	int contains_another;
-
-	char merged_revision[42];
-	const char *rev_args[] = { "rev-list", "--merges", "--ancestry-path",
-				   "--all", merged_revision, NULL };
-	struct rev_info revs;
-	struct setup_revision_opt rev_opts;
-
-	memset(result, 0, sizeof(struct object_array));
-	memset(&rev_opts, 0, sizeof(rev_opts));
-
-	/* get all revisions that merge commit a */
-	xsnprintf(merged_revision, sizeof(merged_revision), "^%s",
-			oid_to_hex(&a->object.oid));
-	init_revisions(&revs, NULL);
-	rev_opts.submodule = path;
-	/* FIXME: can't handle linked worktrees in submodules yet */
-	revs.single_worktree = path != NULL;
-	setup_revisions(ARRAY_SIZE(rev_args)-1, rev_args, &revs, &rev_opts);
-
-	/* save all revisions from the above list that contain b */
-	if (prepare_revision_walk(&revs))
-		die("revision walk setup failed");
-	while ((commit = get_revision(&revs)) != NULL) {
-		struct object *o = &(commit->object);
-		if (in_merge_bases(b, commit))
-			add_object_array(o, NULL, &merges);
-	}
-	reset_revision_walk();
-
-	/* Now we've got all merges that contain a and b. Prune all
-	 * merges that contain another found merge and save them in
-	 * result.
-	 */
-	for (i = 0; i < merges.nr; i++) {
-		struct commit *m1 = (struct commit *) merges.objects[i].item;
-
-		contains_another = 0;
-		for (j = 0; j < merges.nr; j++) {
-			struct commit *m2 = (struct commit *) merges.objects[j].item;
-			if (i != j && in_merge_bases(m2, m1)) {
-				contains_another = 1;
-				break;
-			}
-		}
-
-		if (!contains_another)
-			add_object_array(merges.objects[i].item, NULL, result);
-	}
-
-	object_array_clear(&merges);
-	return result->nr;
-}
-
-static void print_commit(struct commit *commit)
-{
-	struct strbuf sb = STRBUF_INIT;
-	struct pretty_print_context ctx = {0};
-	ctx.date_mode.type = DATE_NORMAL;
-	format_commit_message(commit, " %h: %m %s", &sb, &ctx);
-	fprintf(stderr, "%s\n", sb.buf);
-	strbuf_release(&sb);
-}
-
-#define MERGE_WARNING(path, msg) \
-	warning("Failed to merge submodule %s (%s)", path, msg);
-
-int merge_submodule(struct object_id *result, const char *path,
-		    const struct object_id *base, const struct object_id *a,
-		    const struct object_id *b, int search)
-{
-	struct commit *commit_base, *commit_a, *commit_b;
-	int parent_count;
-	struct object_array merges;
-
-	int i;
-
-	/* store a in result in case we fail */
-	oidcpy(result, a);
-
-	/* we can not handle deletion conflicts */
-	if (is_null_oid(base))
-		return 0;
-	if (is_null_oid(a))
-		return 0;
-	if (is_null_oid(b))
-		return 0;
-
-	if (add_submodule_odb(path)) {
-		MERGE_WARNING(path, "not checked out");
-		return 0;
-	}
-
-	if (!(commit_base = lookup_commit_reference(base)) ||
-	    !(commit_a = lookup_commit_reference(a)) ||
-	    !(commit_b = lookup_commit_reference(b))) {
-		MERGE_WARNING(path, "commits not present");
-		return 0;
-	}
-
-	/* check whether both changes are forward */
-	if (!in_merge_bases(commit_base, commit_a) ||
-	    !in_merge_bases(commit_base, commit_b)) {
-		MERGE_WARNING(path, "commits don't follow merge-base");
-		return 0;
-	}
-
-	/* Case #1: a is contained in b or vice versa */
-	if (in_merge_bases(commit_a, commit_b)) {
-		oidcpy(result, b);
-		return 1;
-	}
-	if (in_merge_bases(commit_b, commit_a)) {
-		oidcpy(result, a);
-		return 1;
-	}
-
-	/*
-	 * Case #2: There are one or more merges that contain a and b in
-	 * the submodule. If there is only one, then present it as a
-	 * suggestion to the user, but leave it marked unmerged so the
-	 * user needs to confirm the resolution.
-	 */
-
-	/* Skip the search if makes no sense to the calling context.  */
-	if (!search)
-		return 0;
-
-	/* find commit which merges them */
-	parent_count = find_first_merges(&merges, path, commit_a, commit_b);
-	switch (parent_count) {
-	case 0:
-		MERGE_WARNING(path, "merge following commits not found");
-		break;
-
-	case 1:
-		MERGE_WARNING(path, "not fast-forward");
-		fprintf(stderr, "Found a possible merge resolution "
-				"for the submodule:\n");
-		print_commit((struct commit *) merges.objects[0].item);
-		fprintf(stderr,
-			"If this is correct simply add it to the index "
-			"for example\n"
-			"by using:\n\n"
-			"  git update-index --cacheinfo 160000 %s \"%s\"\n\n"
-			"which will accept this suggestion.\n",
-			oid_to_hex(&merges.objects[0].item->oid), path);
-		break;
-
-	default:
-		MERGE_WARNING(path, "multiple merges found");
-		for (i = 0; i < merges.nr; i++)
-			print_commit((struct commit *) merges.objects[i].item);
-	}
-
-	object_array_clear(&merges);
-	return 0;
-}
-
 /*
  * Embeds a single submodules git directory into the superprojects git dir,
  * non recursively.
diff --git a/submodule.h b/submodule.h
index e5526f6aaab..b96689ac0db 100644
--- a/submodule.h
+++ b/submodule.h
@@ -89,10 +89,8 @@ extern int submodule_uses_gitfile(const char *path);
 #define SUBMODULE_REMOVAL_IGNORE_UNTRACKED (1<<1)
 #define SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED (1<<2)
 extern int bad_to_remove_submodule(const char *path, unsigned flags);
-extern int merge_submodule(struct object_id *result, const char *path,
-			   const struct object_id *base,
-			   const struct object_id *a,
-			   const struct object_id *b, int search);
+
+int add_submodule_odb(const char *path);
 
 /* Checks if there are submodule changes in a..b. */
 extern int submodule_touches_in_range(struct object_id *a,
-- 
2.17.0.582.gccdcbd54c44.dirty

