Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDE0F20288
	for <e@80x24.org>; Wed, 24 May 2017 05:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969180AbdEXFRJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:17:09 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36397 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969138AbdEXFQt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:49 -0400
Received: by mail-oi0-f66.google.com with SMTP id w138so31034697oiw.3
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ILzwwBzmstVEBKWO5/+KZuUqeT5q1DiOBvibVZhCLcw=;
        b=oBiQdeCNk/g+vvBwz56HYORo3F03FFDMRuY7xZUvTF+gz1aSlyJxeO2Ov5ejNSfSIt
         FU9epb225T8nCfB38o9IXCscv+3ySPULY02zJPg850lHB9aVp1sfMqziHG1WT07ah3GO
         L9VLowhf3lc9bYkHJ8WttWAuT5lffxPh/bwYXlroP2zYq+Iqg0aJMclbJeVJkaMn8uzY
         MgiGoS4Fzk2Jyz5Ldllu0Ru8peGHBU6SDuzLa36hLFdApKFGCSruf/T4T5Uqql2yW76r
         dROoaTGshsw5dKURcY5S3nSFhkGucBUBbwiLhjgPJ3LvafsK7LKsf1uI4LdT14tmDgii
         qGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ILzwwBzmstVEBKWO5/+KZuUqeT5q1DiOBvibVZhCLcw=;
        b=TFfPD/WzFwJs/y08P6KLVccoSvbz9bu2XN/jA1oCjO/fjUd2uwc6vfqfRFmKTr2Htp
         FWI+6bGEosClQIOcz9d9+XuRfyoQKULEKb5PeB5QECPugWCRBFyEX5omj3VafvF6EUMJ
         VZOXK3TutYTiOGFbo8YEcahUqTwIj3JmuhoH4MAoHmiV3VZns1dyrsLh1i6QptvDiVEo
         qg2T2FVLpYhjB2QU1af3f6n9JPyWXWC9Rp/83EoQGdNvGJKNanMbMrdrkfgudCGmc/Bp
         Ubx6jYsaV3SVE2AyNZyPjPhz/uF6rYnl9cyl5wTGqu4rGGyGkzdMGfbqlUW2Us52kQaV
         7vpw==
X-Gm-Message-State: AODbwcBEILeNaE58hYxfG/4yG34s36/jxpT6Yuvt8fAcrKOFzmx3tR4V
        38+Rhsf6dw9VeX86w2c=
X-Received: by 10.202.80.150 with SMTP id e144mr16475222oib.216.1495603008425;
        Tue, 23 May 2017 22:16:48 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:47 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 22/29] blame: create scoreboard setup function
Date:   Wed, 24 May 2017 00:15:30 -0500
Message-Id: <20170524051537.29978-23-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create function that completes setting up blame_scoreboard structure.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 190 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 101 insertions(+), 89 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index f839571..fd41551 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2544,6 +2544,105 @@ void init_scoreboard(struct blame_scoreboard *sb)
 	sb->copy_score = BLAME_DEFAULT_COPY_SCORE;
 }
 
+void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blame_origin **orig)
+{
+	const char *final_commit_name = NULL;
+	struct blame_origin *o;
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
+}
+
 int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -2552,9 +2651,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	struct blame_origin *o;
 	struct blame_entry *ent = NULL;
 	long dashdash_pos, lno;
-	const char *final_commit_name = NULL;
-	enum object_type type;
-	struct commit *final_commit = NULL;
 	struct progress_info pi = { NULL, 0 };
 
 	struct string_list range_list = STRING_LIST_INIT_NODUP;
@@ -2759,92 +2855,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	sb.revs = &revs;
 	sb.contents_from = contents_from;
 	sb.reverse = reverse;
-
-	if (!reverse) {
-		sb.final = find_single_final(&revs, &final_commit_name);
-		sb.commits.compare = compare_commits_by_commit_date;
-	}
-	else if (contents_from)
-		die(_("--contents and --reverse do not blend well."));
-	else {
-		sb.final = find_single_initial(&revs, &final_commit_name);
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
-
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
+	setup_scoreboard(&sb, path, &o);
+	lno = sb.num_lines;
 
 	if (lno && !range_list.nr)
 		string_list_append(&range_list, "1");
-- 
2.9.3

