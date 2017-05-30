Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 211CD2027C
	for <e@80x24.org>; Tue, 30 May 2017 17:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbdE3Rbt (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:31:49 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34504 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbdE3Rbr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:47 -0400
Received: by mail-pf0-f172.google.com with SMTP id 9so78322574pfj.1
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xrh6sjb6Y0P5SAzkHJ3sTDsX7HUFUDCWsI6nyRzsXCE=;
        b=pX/1NhUmceNHOcpluGbDtFS1XIe4DEUQzhHGI5Y29Gt+XMRgLpv6D4EquBkPQZeSfn
         iMRVuQPKwxj8Qcv0J/OCI9JKJP64juqr0O3YeNpX5PrnHk4Z2lZ50le78rK6VFdVOklu
         CaQtfwjntmRO1+7tClI89rAbjtKIgK7eyVIz2udTiXC9gC5gW2+xjoW9++IZYXHnnJaX
         NtB77Q5d7ZoOz4eC1a6aLpzKpcxqSAmnVyeIBs9UwSL7EvUDsvTPWhKhBw4SVbThvuz4
         nSeSJjqY9SJQ+upY8nm3jyqsTaADa0jgJSRMPY7sPclkgn39yiG+5TRZYDuqaOxjgELh
         VtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xrh6sjb6Y0P5SAzkHJ3sTDsX7HUFUDCWsI6nyRzsXCE=;
        b=PFLKhELknRJyjDneOZbBLPJ9IpJzjLSbQRdNLFdMOoFi4kQG1u9jy0o5w/vKahULz5
         eejQNTal1FgC/VazLoGitXihlNwIY8m8VLpI9C07b6U+b6wF7uTdP2sAmqwv3Dc+nT3t
         nKHJJ46EoynooneJBKImRWAbFG41GpoIk61eQ/Q+7Nbw21EjgqsBY1co7mEeL4pXT28+
         T/X7rylF2v5ejJSzzmy93/HkSb2dr9dWbhx4byc+0HD/qH6BBHUMYoAJQXwNyDFuwdhk
         zdpCyyoxpWhyly5m/zZ9T65w28selUZCdIEakMC9vYvXZOWC24/qWXQWJSaDGd/UOiWs
         0GzA==
X-Gm-Message-State: AODbwcA14rOSNEvaOc71ZNWeq0AkAYwtwr7sLuVD3MLkpu5OgJ7yunzq
        Lu0ohz//Hma0geZXobDrVA==
X-Received: by 10.98.236.150 with SMTP id e22mr24880146pfm.48.1496165495861;
        Tue, 30 May 2017 10:31:35 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:34 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 14/33] diff: convert fill_filespec to struct object_id
Date:   Tue, 30 May 2017 10:30:50 -0700
Message-Id: <20170530173109.54904-15-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/blame.c   |  2 +-
 builtin/diff.c    |  4 ++--
 combine-diff.c    |  4 ++--
 diff-lib.c        |  2 +-
 diff-no-index.c   |  2 +-
 diff.c            | 16 ++++++++--------
 diffcore-rename.c |  2 +-
 diffcore.h        |  2 +-
 grep.c            |  2 +-
 line-log.c        |  6 +++---
 10 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 1043e5376..5ad435380 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -163,7 +163,7 @@ int textconv_object(const char *path,
 	struct userdiff_driver *textconv;
 
 	df = alloc_filespec(path);
-	fill_filespec(df, oid->hash, oid_valid, mode);
+	fill_filespec(df, oid, oid_valid, mode);
 	textconv = get_textconv(df);
 	if (!textconv) {
 		free_filespec(df);
diff --git a/builtin/diff.c b/builtin/diff.c
index 8c03ddaf5..b2d7c32cd 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -57,8 +57,8 @@ static void stuff_change(struct diff_options *opt,
 
 	one = alloc_filespec(old_name);
 	two = alloc_filespec(new_name);
-	fill_filespec(one, old_oid->hash, old_oid_valid, old_mode);
-	fill_filespec(two, new_oid->hash, new_oid_valid, new_mode);
+	fill_filespec(one, old_oid, old_oid_valid, old_mode);
+	fill_filespec(two, new_oid, new_oid_valid, new_mode);
 
 	diff_queue(&diff_queued_diff, one, two);
 }
diff --git a/combine-diff.c b/combine-diff.c
index 2848034fe..ad063ecb1 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -302,7 +302,7 @@ static char *grab_blob(const struct object_id *oid, unsigned int mode,
 		return xcalloc(1, 1);
 	} else if (textconv) {
 		struct diff_filespec *df = alloc_filespec(path);
-		fill_filespec(df, oid->hash, 1, mode);
+		fill_filespec(df, oid, 1, mode);
 		*size = fill_textconv(textconv, df, &blob);
 		free_filespec(df);
 	} else {
@@ -1022,7 +1022,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 						   &result_size, NULL, NULL);
 		} else if (textconv) {
 			struct diff_filespec *df = alloc_filespec(elem->path);
-			fill_filespec(df, null_sha1, 0, st.st_mode);
+			fill_filespec(df, &null_oid, 0, st.st_mode);
 			result_size = fill_textconv(textconv, df, &result);
 			free_filespec(df);
 		} else if (0 <= (fd = open(elem->path, O_RDONLY))) {
diff --git a/diff-lib.c b/diff-lib.c
index 1e8215df5..9e076a488 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -409,7 +409,7 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 		struct diff_filepair *pair;
 		pair = diff_unmerge(&revs->diffopt, idx->name);
 		if (tree)
-			fill_filespec(pair->one, tree->oid.hash, 1,
+			fill_filespec(pair->one, &tree->oid, 1,
 				      tree->ce_mode);
 		return;
 	}
diff --git a/diff-no-index.c b/diff-no-index.c
index 79229382b..80ff17d46 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -82,7 +82,7 @@ static struct diff_filespec *noindex_filespec(const char *name, int mode)
 	if (!name)
 		name = "/dev/null";
 	s = alloc_filespec(name);
-	fill_filespec(s, null_sha1, 0, mode);
+	fill_filespec(s, &null_oid, 0, mode);
 	if (name == file_from_standard_input)
 		populate_from_stdin(s);
 	return s;
diff --git a/diff.c b/diff.c
index b9bb3f6ca..e0c179f5f 100644
--- a/diff.c
+++ b/diff.c
@@ -2702,13 +2702,13 @@ void free_filespec(struct diff_filespec *spec)
 	}
 }
 
-void fill_filespec(struct diff_filespec *spec, const unsigned char *sha1,
-		   int sha1_valid, unsigned short mode)
+void fill_filespec(struct diff_filespec *spec, const struct object_id *oid,
+		   int oid_valid, unsigned short mode)
 {
 	if (mode) {
 		spec->mode = canon_mode(mode);
-		hashcpy(spec->oid.hash, sha1);
-		spec->oid_valid = sha1_valid;
+		oidcpy(&spec->oid, oid);
+		spec->oid_valid = oid_valid;
 	}
 }
 
@@ -5114,9 +5114,9 @@ void diff_addremove(struct diff_options *options,
 	two = alloc_filespec(concatpath);
 
 	if (addremove != '+')
-		fill_filespec(one, oid->hash, oid_valid, mode);
+		fill_filespec(one, oid, oid_valid, mode);
 	if (addremove != '-') {
-		fill_filespec(two, oid->hash, oid_valid, mode);
+		fill_filespec(two, oid, oid_valid, mode);
 		two->dirty_submodule = dirty_submodule;
 	}
 
@@ -5153,8 +5153,8 @@ void diff_change(struct diff_options *options,
 
 	one = alloc_filespec(concatpath);
 	two = alloc_filespec(concatpath);
-	fill_filespec(one, old_oid->hash, old_oid_valid, old_mode);
-	fill_filespec(two, new_oid->hash, new_oid_valid, new_mode);
+	fill_filespec(one, old_oid, old_oid_valid, old_mode);
+	fill_filespec(two, new_oid, new_oid_valid, new_mode);
 	one->dirty_submodule = old_dirty_submodule;
 	two->dirty_submodule = new_dirty_submodule;
 	p = diff_queue(&diff_queued_diff, one, two);
diff --git a/diffcore-rename.c b/diffcore-rename.c
index f7444c86b..3d9719dad 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -60,7 +60,7 @@ static int add_rename_dst(struct diff_filespec *two)
 		memmove(rename_dst + first + 1, rename_dst + first,
 			(rename_dst_nr - first - 1) * sizeof(*rename_dst));
 	rename_dst[first].two = alloc_filespec(two->path);
-	fill_filespec(rename_dst[first].two, two->oid.hash, two->oid_valid,
+	fill_filespec(rename_dst[first].two, &two->oid, two->oid_valid,
 		      two->mode);
 	rename_dst[first].pair = NULL;
 	return 0;
diff --git a/diffcore.h b/diffcore.h
index 623024135..a30da161d 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -52,7 +52,7 @@ struct diff_filespec {
 
 extern struct diff_filespec *alloc_filespec(const char *);
 extern void free_filespec(struct diff_filespec *);
-extern void fill_filespec(struct diff_filespec *, const unsigned char *,
+extern void fill_filespec(struct diff_filespec *, const struct object_id *,
 			  int, unsigned short);
 
 #define CHECK_SIZE_ONLY 1
diff --git a/grep.c b/grep.c
index a240b4cdb..3e21c92b9 100644
--- a/grep.c
+++ b/grep.c
@@ -1407,7 +1407,7 @@ static int fill_textconv_grep(struct userdiff_driver *driver,
 		fill_filespec(df, gs->identifier, 1, 0100644);
 		break;
 	case GREP_SOURCE_FILE:
-		fill_filespec(df, null_sha1, 0, 0100644);
+		fill_filespec(df, &null_oid, 0, 0100644);
 		break;
 	default:
 		die("BUG: attempt to textconv something without a path?");
diff --git a/line-log.c b/line-log.c
index b9087814b..a3bd2f2d5 100644
--- a/line-log.c
+++ b/line-log.c
@@ -500,12 +500,12 @@ static struct commit *check_single_commit(struct rev_info *revs)
 static void fill_blob_sha1(struct commit *commit, struct diff_filespec *spec)
 {
 	unsigned mode;
-	unsigned char sha1[20];
+	struct object_id oid;
 
 	if (get_tree_entry(commit->object.oid.hash, spec->path,
-			   sha1, &mode))
+			   oid.hash, &mode))
 		die("There is no path %s in the commit", spec->path);
-	fill_filespec(spec, sha1, 1, mode);
+	fill_filespec(spec, &oid, 1, mode);
 
 	return;
 }
-- 
2.13.0.219.gdb65acc882-goog

