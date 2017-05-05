Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17670207D6
	for <e@80x24.org>; Fri,  5 May 2017 05:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755286AbdEEF1u (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 01:27:50 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33398 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754740AbdEEF1q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 01:27:46 -0400
Received: by mail-io0-f196.google.com with SMTP id l196so8641075ioe.0
        for <git@vger.kernel.org>; Thu, 04 May 2017 22:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4I466IpmzgdVmse2cvvaChPCV2Sbc7ykR6K/MuOUxm8=;
        b=Ty1kvqBdqGL1PlXYd20IgyT5RXJ9O+Ic0R/J/SJ1kpvUzce/K6R34W5yRHMfDrNLlI
         84D5T3C9jr58gvI4v3tVdZg0YeYb2sxhjCppRhswUcGYnh7q8P2Nt/QdDVYwKXl7890p
         kdTLGWOTIfWgH7tb3fiqJWV0PHFKr/FBg5Sj3xjUhKVDW/GDwv2vYBXuWLBerNquCEso
         11/L9GvLj9EISvPC9to+DCbJ9Ykm94UaShRUSSPk5K3nLqoPQQHqKEZY2KcUxSLfPugP
         s5KQ16kPjtSr4fRlCjTlPC44gTuHODEkuSsMVeD9zto74PVnRd7QLRR4rwG49gvA9Yg0
         u7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4I466IpmzgdVmse2cvvaChPCV2Sbc7ykR6K/MuOUxm8=;
        b=kJmCQuZcUSfrO9vxDf/bZ034glBcIOQ7qsOwcp3ETBvoYh3OCulXCbVJYlafEyYhUq
         FN3y2p6AnnKfHpKMzfsdcgcQ3MjGTcn4YRq94vMFSIXuPe0J7cICC4Ole67FUmQJoo89
         V9GqzAPoXLfZssQoX3aCphR+4tj8T7eD6WDqWSopnErvnNMRA5PkUM/it7/fh7R2aISG
         sFBiSwaIQGbp9W5FZvTayVmrPjr2md1GAmadVcf991C02hN7cZz2MFHK7Qbqr34V96uc
         qZX8WWJkxmam+rO5ISnDxIh1FyXLatjX8kNlmwtbQdJ2XnrlRbKLscEEHc/CsT36/e4P
         51BQ==
X-Gm-Message-State: AN3rC/4gVT4AAMbM+BUo3v8Sb0J7mZoWRn1Sc6aprCix53Me+yLr9VEk
        yEk6kIsd8wSkAs21cLH0aQ==
X-Received: by 10.157.14.236 with SMTP id 99mr7915686otj.164.1493962065496;
        Thu, 04 May 2017 22:27:45 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 2sm2179586ota.46.2017.05.04.22.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 22:27:44 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH 09/10] Break out scoreboard init and setup
Date:   Fri,  5 May 2017 00:27:28 -0500
Message-Id: <20170505052729.7576-10-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170505052729.7576-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 264 +++++++++++++++++++++++++++++---------------------------
 scoreboard.h    |   1 +
 2 files changed, 140 insertions(+), 125 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 0af99e3..3bde5a6 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -731,14 +731,8 @@ static struct commit *find_single_final(struct rev_info *revs,
 	return found;
 }
 
-static char *prepare_final(struct scoreboard *sb)
-{
-	const char *name;
-	sb->final = find_single_final(sb->revs, &name);
-	return xstrdup_or_null(name);
-}
-
-static const char *dwim_reverse_initial(struct scoreboard *sb)
+static struct commit *dwim_reverse_initial(struct rev_info *revs,
+					   const char **name_p)
 {
 	/*
 	 * DWIM "git blame --reverse ONE -- PATH" as
@@ -749,11 +743,11 @@ static const char *dwim_reverse_initial(struct scoreboard *sb)
 	struct commit *head_commit;
 	unsigned char head_sha1[20];
 
-	if (sb->revs->pending.nr != 1)
+	if (revs->pending.nr != 1)
 		return NULL;
 
 	/* Is that sole rev a committish? */
-	obj = sb->revs->pending.objects[0].item;
+	obj = revs->pending.objects[0].item;
 	obj = deref_tag(obj, NULL, 0);
 	if (obj->type != OBJ_COMMIT)
 		return NULL;
@@ -767,17 +761,19 @@ static const char *dwim_reverse_initial(struct scoreboard *sb)
 
 	/* Turn "ONE" into "ONE..HEAD" then */
 	obj->flags |= UNINTERESTING;
-	add_pending_object(sb->revs, &head_commit->object, "HEAD");
+	add_pending_object(revs, &head_commit->object, "HEAD");
 
-	sb->final = (struct commit *)obj;
-	return sb->revs->pending.objects[0].name;
+	if (name_p)
+		*name_p = revs->pending.objects[0].name;
+	return (struct commit *)obj;
 }
 
-static char *prepare_initial(struct scoreboard *sb)
+static struct commit *find_single_initial(struct rev_info *revs,
+					  const char **name_p)
 {
 	int i;
-	const char *final_commit_name = NULL;
-	struct rev_info *revs = sb->revs;
+	struct commit *found = NULL;
+	const char *name = NULL;
 
 	/*
 	 * There must be one and only one negative commit, and it must be
@@ -790,19 +786,127 @@ static char *prepare_initial(struct scoreboard *sb)
 		obj = deref_tag(obj, NULL, 0);
 		if (obj->type != OBJ_COMMIT)
 			die("Non commit %s?", revs->pending.objects[i].name);
-		if (sb->final)
+		if (found)
 			die("More than one commit to dig up from, %s and %s?",
-			    revs->pending.objects[i].name,
-			    final_commit_name);
-		sb->final = (struct commit *) obj;
-		final_commit_name = revs->pending.objects[i].name;
+			    revs->pending.objects[i].name, name);
+		found = (struct commit *) obj;
+		name = revs->pending.objects[i].name;
 	}
 
-	if (!final_commit_name)
-		final_commit_name = dwim_reverse_initial(sb);
-	if (!final_commit_name)
+	if (!name)
+		found = dwim_reverse_initial(revs, &name);
+	if (!name)
 		die("No commit to dig up from?");
-	return xstrdup(final_commit_name);
+
+	if (name_p)
+		*name_p = name;
+	return found;
+}
+
+void init_scoreboard(struct scoreboard *sb)
+{
+	memset(sb, 0, sizeof(struct scoreboard));
+	sb->blame_move_score = BLAME_DEFAULT_MOVE_SCORE;
+	sb->blame_copy_score = BLAME_DEFAULT_COPY_SCORE;
+}
+
+void setup_scoreboard(struct scoreboard *sb, const char *path, struct origin **orig)
+{
+	const char *final_commit_name = NULL;
+	struct origin *o;
+	struct commit *final_commit = NULL;
+	enum object_type type;
+
+	if (sb->reverse && sb->contents_from)
+		die(_("--contents and --reverse do not blend well."));
+
+	if (!sb->reverse) {
+		sb->final = find_single_final(sb->revs, &final_commit_name);
+		sb->commits.compare = compare_commits_by_commit_date;
+	} else {
+		sb->final = find_single_initial(sb->revs, &final_commit_name);
+		sb->commits.compare = compare_commits_by_reverse_commit_date;
+	}
+
+	if (sb->final && sb->contents_from)
+		die(_("cannot use --contents with final commit object name"));
+
+	if (sb->reverse && sb->revs->first_parent_only)
+		sb->revs->children.name = NULL;
+
+	if (!sb->final) {
+		/*
+		 * "--not A B -- path" without anything positive;
+		 * do not default to HEAD, but use the working tree
+		 * or "--contents".
+		 */
+		setup_work_tree();
+		sb->final = fake_working_tree_commit(&sb->revs->diffopt,
+						     path, sb->contents_from);
+		add_pending_object(sb->revs, &(sb->final->object), ":");
+	}
+
+	if (sb->reverse && sb->revs->first_parent_only) {
+		final_commit = find_single_final(sb->revs, NULL);
+		if (!final_commit)
+			die(_("--reverse and --first-parent together require specified latest commit"));
+	}
+
+	/*
+	 * If we have bottom, this will mark the ancestors of the
+	 * bottom commits we would reach while traversing as
+	 * uninteresting.
+	 */
+	if (prepare_revision_walk(sb->revs))
+		die(_("revision walk setup failed"));
+
+	if (sb->reverse && sb->revs->first_parent_only) {
+		struct commit *c = final_commit;
+
+		sb->revs->children.name = "children";
+		while (c->parents &&
+		       oidcmp(&c->object.oid, &sb->final->object.oid)) {
+			struct commit_list *l = xcalloc(1, sizeof(*l));
+
+			l->item = c;
+			if (add_decoration(&sb->revs->children,
+					   &c->parents->item->object, l))
+				die("BUG: not unique item in first-parent chain");
+			c = c->parents->item;
+		}
+
+		if (oidcmp(&c->object.oid, &sb->final->object.oid))
+			die(_("--reverse --first-parent together require range along first-parent chain"));
+	}
+
+	if (is_null_oid(&sb->final->object.oid)) {
+		o = sb->final->util;
+		sb->final_buf = xmemdupz(o->file.ptr, o->file.size);
+		sb->final_buf_size = o->file.size;
+	}
+	else {
+		o = get_origin(sb->final, path);
+		if (fill_blob_sha1_and_mode(o))
+			die(_("no such path %s in %s"), path, final_commit_name);
+
+		if (DIFF_OPT_TST(&sb->revs->diffopt, ALLOW_TEXTCONV) &&
+		    textconv_object(path, o->mode, &o->blob_oid, 1, (char **) &sb->final_buf,
+				    &sb->final_buf_size))
+			;
+		else
+			sb->final_buf = read_sha1_file(o->blob_oid.hash, &type,
+						       &sb->final_buf_size);
+
+		if (!sb->final_buf)
+			die(_("cannot read blob %s for path %s"),
+			    oid_to_hex(&o->blob_oid),
+			    path);
+	}
+	sb->num_read_blob++;
+	prepare_lines(sb);
+
+	if (orig)
+		*orig = o;
 }
 
 static int blame_copy_callback(const struct option *option, const char *arg, int unset)
@@ -846,9 +950,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	struct origin *o;
 	struct blame_entry *ent = NULL;
 	long dashdash_pos, lno;
-	char *final_commit_name = NULL;
-	enum object_type type;
-	struct commit *final_commit = NULL;
 	struct progress_info pi = { NULL, 0 };
 
 	struct string_list range_list = STRING_LIST_INIT_NODUP;
@@ -996,11 +1097,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		opt |= (PICKAXE_BLAME_COPY | PICKAXE_BLAME_MOVE |
 			PICKAXE_BLAME_COPY_HARDER);
 
-	if (!blame_move_score)
-		blame_move_score = BLAME_DEFAULT_MOVE_SCORE;
-	if (!blame_copy_score)
-		blame_copy_score = BLAME_DEFAULT_COPY_SCORE;
-
 	/*
 	 * We have collected options unknown to us in argv[1..unk]
 	 * which are to be passed to revision machinery if we are
@@ -1053,94 +1149,14 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	revs.disable_stdin = 1;
 	setup_revisions(argc, argv, &revs, NULL);
-	memset(&sb, 0, sizeof(sb));
 
+	init_scoreboard(&sb);
 	sb.revs = &revs;
-	if (!reverse) {
-		final_commit_name = prepare_final(&sb);
-		sb.commits.compare = compare_commits_by_commit_date;
-	}
-	else if (contents_from)
-		die(_("--contents and --reverse do not blend well."));
-	else {
-		final_commit_name = prepare_initial(&sb);
-		sb.commits.compare = compare_commits_by_reverse_commit_date;
-		if (revs.first_parent_only)
-			revs.children.name = NULL;
-	}
-
-	if (!sb.final) {
-		/*
-		 * "--not A B -- path" without anything positive;
-		 * do not default to HEAD, but use the working tree
-		 * or "--contents".
-		 */
-		setup_work_tree();
-		sb.final = fake_working_tree_commit(&sb.revs->diffopt,
-						    path, contents_from);
-		add_pending_object(&revs, &(sb.final->object), ":");
-	}
-	else if (contents_from)
-		die(_("cannot use --contents with final commit object name"));
-
-	if (reverse && revs.first_parent_only) {
-		final_commit = find_single_final(sb.revs, NULL);
-		if (!final_commit)
-			die(_("--reverse and --first-parent together require specified latest commit"));
-	}
-
-	/*
-	 * If we have bottom, this will mark the ancestors of the
-	 * bottom commits we would reach while traversing as
-	 * uninteresting.
-	 */
-	if (prepare_revision_walk(&revs))
-		die(_("revision walk setup failed"));
-
-	if (reverse && revs.first_parent_only) {
-		struct commit *c = final_commit;
-
-		sb.revs->children.name = "children";
-		while (c->parents &&
-		       oidcmp(&c->object.oid, &sb.final->object.oid)) {
-			struct commit_list *l = xcalloc(1, sizeof(*l));
-
-			l->item = c;
-			if (add_decoration(&sb.revs->children,
-					   &c->parents->item->object, l))
-				die("BUG: not unique item in first-parent chain");
-			c = c->parents->item;
-		}
-
-		if (oidcmp(&c->object.oid, &sb.final->object.oid))
-			die(_("--reverse --first-parent together require range along first-parent chain"));
-	}
-
-	if (is_null_oid(&sb.final->object.oid)) {
-		o = sb.final->util;
-		sb.final_buf = xmemdupz(o->file.ptr, o->file.size);
-		sb.final_buf_size = o->file.size;
-	}
-	else {
-		o = get_origin(sb.final, path);
-		if (fill_blob_sha1_and_mode(o))
-			die(_("no such path %s in %s"), path, final_commit_name);
+	sb.reverse = reverse;
+	sb.contents_from = contents_from;
+	setup_scoreboard(&sb, path, &o);
 
-		if (DIFF_OPT_TST(&sb.revs->diffopt, ALLOW_TEXTCONV) &&
-		    textconv_object(path, o->mode, &o->blob_oid, 1, (char **) &sb.final_buf,
-				    &sb.final_buf_size))
-			;
-		else
-			sb.final_buf = read_sha1_file(o->blob_oid.hash, &type,
-						      &sb.final_buf_size);
-
-		if (!sb.final_buf)
-			die(_("cannot read blob %s for path %s"),
-			    oid_to_hex(&o->blob_oid),
-			    path);
-	}
-	sb.num_read_blob++;
-	lno = prepare_lines(&sb);
+	lno = sb.num_lines;
 
 	if (lno && !range_list.nr)
 		string_list_append(&range_list, "1");
@@ -1192,13 +1208,14 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	sb.ent = NULL;
 	sb.path = path;
 
-	sb.blame_move_score = blame_move_score;
-	sb.blame_copy_score = blame_copy_score;
+	if (blame_move_score)
+		sb.blame_move_score = blame_move_score;
+	if (blame_copy_score)
+		sb.blame_copy_score = blame_copy_score;
 
 	sb.sanity_check = DEBUG ? &sanity_check_refcnt : NULL;
 
 	sb.show_root = show_root;
-	sb.reverse = reverse;
 	sb.xdl_opts = xdl_opts;
 	sb.no_whole_file_rename = no_whole_file_rename;
 
@@ -1216,10 +1233,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	if (!incremental)
 		setup_pager();
-
-	free(final_commit_name);
-
-	if (incremental)
+	else
 		return 0;
 
 	blame_sort_final(&sb);
diff --git a/scoreboard.h b/scoreboard.h
index 7e9e313..42d9aac 100644
--- a/scoreboard.h
+++ b/scoreboard.h
@@ -24,6 +24,7 @@ struct scoreboard {
 	struct prio_queue commits;
 	struct rev_info *revs;
 	const char *path;
+	const char *contents_from;
 
 	/*
 	 * The contents in the final image.
-- 
2.9.3

