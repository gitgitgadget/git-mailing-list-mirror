Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 965581F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbeHMS6g (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:58:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33133 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730010AbeHMS6f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:58:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id s12-v6so13044452ljj.0
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TJcqbkpdCLbfMFg8kGyG7Rz7c4JI+6MybeMbnGeNXyM=;
        b=Bv/CyM2IQomfUeualUBSy772NO0VR19xk2ee10Psr4k008nSkozkrtq5vmsYkVKnBh
         w6j/ay0L/oR1mYKGxnCu1Wj3noeGClrc2/aW2f9c54CgprU5lTNFMueq/PNKIwoMBXSo
         CB4NWUdZ2Z8F1zO/pBb048AaWX1zlH01VkR4HtCIky4stPhBmsUxYhqBK8qeQXG6DiUz
         bVDD8EsgPe9qe4zTHn9d3Ra5vYDk7fRX/wGr2SYispVvQGJ+2UahaJfAale9/37TwY2i
         bKUgN9ZYnC3Kb+xZ/G7vTeT1Kls6rWIjePpfGW/5By2ArFE8qbGCxiaAVgYFuousI2mB
         kBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TJcqbkpdCLbfMFg8kGyG7Rz7c4JI+6MybeMbnGeNXyM=;
        b=qTw3ZOZVUHPKT3na93U2xxbM6Ntuz2JdC8+dqEgxB8fnnjoMxWCWT/qw9x4LUfI0Ru
         y2gFQkLgahtoczdN9FLMkbjWvYgrrIwjE7nNputSp7f5wOkCJ8xFMvo649X8+ESmr3jB
         AMBkXLJw87oBW0nWMg0qF07VzyDWvB7BYP7Egvw61Ouk4825Jx1aHkc9y2iew3bMX9YG
         CJBzrtUr1dxWhtaAlFJLrLFbbLgdSIFVo1OoxBhXDw3Th08elZRJfsuDjIFZxnzak153
         9+9y+OmeHccgZUN68wKMxCPC4/NsBEml9+5iV5mJ1fvxEwH/ogkvAsHF0YqU5JvoxweH
         SMng==
X-Gm-Message-State: AOUpUlGyMG06Q3OorFCld1J03O/7l3WDNGp+2jPq9a5HaGnYPwa6wANu
        oc1Uc1xy24CpDJsZTHaFn1TOvIvS
X-Google-Smtp-Source: AA+uWPx/4kDI5sTkmuu0oMGXd1qPiS7sXycQg37w1BhH8tsfsrHEnPcN0lPhU4QB+Kk0VnU2O40dlg==
X-Received: by 2002:a2e:5687:: with SMTP id k7-v6mr13258738lje.105.1534176939671;
        Mon, 13 Aug 2018 09:15:39 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3066031ljc.56.2018.08.13.09.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:15:38 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 18/24] archive.c: avoid access to the_index
Date:   Mon, 13 Aug 2018 18:14:35 +0200
Message-Id: <20180813161441.16824-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180813161441.16824-1-pclouds@gmail.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 archive.c                | 45 ++++++++++++++++++++++++++--------------
 archive.h                | 16 +++++++++++---
 builtin/archive.c        |  2 +-
 builtin/upload-archive.c |  3 ++-
 4 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/archive.c b/archive.c
index aca9179d03..0a07b140fe 100644
--- a/archive.c
+++ b/archive.c
@@ -79,7 +79,7 @@ void *object_file_to_archive(const struct archiver_args *args,
 		size_t size = 0;
 
 		strbuf_attach(&buf, buffer, *sizep, *sizep + 1);
-		convert_to_working_tree(&the_index, path, buf.buf, buf.len, &buf);
+		convert_to_working_tree(args->repo->index, path, buf.buf, buf.len, &buf);
 		if (commit)
 			format_subst(commit, buf.buf, buf.len, &buf);
 		buffer = strbuf_detach(&buf, &size);
@@ -104,12 +104,13 @@ struct archiver_context {
 	struct directory *bottom;
 };
 
-static const struct attr_check *get_archive_attrs(const char *path)
+static const struct attr_check *get_archive_attrs(struct index_state *istate,
+						  const char *path)
 {
 	static struct attr_check *check;
 	if (!check)
 		check = attr_check_initl("export-ignore", "export-subst", NULL);
-	return git_check_attr(&the_index, path, check) ? NULL : check;
+	return git_check_attr(istate, path, check) ? NULL : check;
 }
 
 static int check_attr_export_ignore(const struct attr_check *check)
@@ -145,7 +146,7 @@ static int write_archive_entry(const struct object_id *oid, const char *base,
 
 	if (!S_ISDIR(mode)) {
 		const struct attr_check *check;
-		check = get_archive_attrs(path_without_prefix);
+		check = get_archive_attrs(args->repo->index, path_without_prefix);
 		if (check_attr_export_ignore(check))
 			return 0;
 		args->convert = check_attr_export_subst(check);
@@ -220,7 +221,7 @@ static int queue_or_write_archive_entry(const struct object_id *oid,
 		/* Borrow base, but restore its original value when done. */
 		strbuf_addstr(base, filename);
 		strbuf_addch(base, '/');
-		check = get_archive_attrs(base->buf);
+		check = get_archive_attrs(c->args->repo->index, base->buf);
 		strbuf_setlen(base, baselen);
 
 		if (check_attr_export_ignore(check))
@@ -268,8 +269,8 @@ int write_archive_entries(struct archiver_args *args,
 		memset(&opts, 0, sizeof(opts));
 		opts.index_only = 1;
 		opts.head_idx = -1;
-		opts.src_index = &the_index;
-		opts.dst_index = &the_index;
+		opts.src_index = args->repo->index;
+		opts.dst_index = args->repo->index;
 		opts.fn = oneway_merge;
 		init_tree_desc(&t, args->tree->buffer, args->tree->size);
 		if (unpack_trees(1, &t, &opts))
@@ -304,33 +305,43 @@ static const struct archiver *lookup_archiver(const char *name)
 	return NULL;
 }
 
+struct path_exists_context {
+	struct pathspec pathspec;
+	struct archiver_args *args;
+};
+
 static int reject_entry(const struct object_id *oid, struct strbuf *base,
 			const char *filename, unsigned mode,
 			int stage, void *context)
 {
 	int ret = -1;
+	struct path_exists_context *ctx = context;
+
 	if (S_ISDIR(mode)) {
 		struct strbuf sb = STRBUF_INIT;
 		strbuf_addbuf(&sb, base);
 		strbuf_addstr(&sb, filename);
-		if (!match_pathspec(&the_index, context, sb.buf, sb.len, 0, NULL, 1))
+		if (!match_pathspec(ctx->args->repo->index,
+				    &ctx->pathspec,
+				    sb.buf, sb.len, 0, NULL, 1))
 			ret = READ_TREE_RECURSIVE;
 		strbuf_release(&sb);
 	}
 	return ret;
 }
 
-static int path_exists(struct tree *tree, const char *path)
+static int path_exists(struct archiver_args *args, const char *path)
 {
 	const char *paths[] = { path, NULL };
-	struct pathspec pathspec;
+	struct path_exists_context ctx;
 	int ret;
 
-	parse_pathspec(&pathspec, 0, 0, "", paths);
-	pathspec.recursive = 1;
-	ret = read_tree_recursive(tree, "", 0, 0, &pathspec,
-				  reject_entry, &pathspec);
-	clear_pathspec(&pathspec);
+	ctx.args = args;
+	parse_pathspec(&ctx.pathspec, 0, 0, "", paths);
+	ctx.pathspec.recursive = 1;
+	ret = read_tree_recursive(args->tree, "", 0, 0, &ctx.pathspec,
+				  reject_entry, &ctx);
+	clear_pathspec(&ctx.pathspec);
 	return ret != 0;
 }
 
@@ -348,7 +359,7 @@ static void parse_pathspec_arg(const char **pathspec,
 	ar_args->pathspec.recursive = 1;
 	if (pathspec) {
 		while (*pathspec) {
-			if (**pathspec && !path_exists(ar_args->tree, *pathspec))
+			if (**pathspec && !path_exists(ar_args, *pathspec))
 				die(_("pathspec '%s' did not match any files"), *pathspec);
 			pathspec++;
 		}
@@ -510,6 +521,7 @@ static int parse_archive_args(int argc, const char **argv,
 }
 
 int write_archive(int argc, const char **argv, const char *prefix,
+		  struct repository *repo,
 		  const char *name_hint, int remote)
 {
 	const struct archiver *ar = NULL;
@@ -521,6 +533,7 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	init_tar_archiver();
 	init_zip_archiver();
 
+	args.repo = repo;
 	argc = parse_archive_args(argc, argv, &ar, &args, name_hint, remote);
 	if (!startup_info->have_repository) {
 		/*
diff --git a/archive.h b/archive.h
index 1f9954f7cd..75b9a86066 100644
--- a/archive.h
+++ b/archive.h
@@ -3,7 +3,10 @@
 
 #include "pathspec.h"
 
+struct repository;
+
 struct archiver_args {
+	struct repository *repo;
 	const char *base;
 	size_t baselen;
 	struct tree *tree;
@@ -17,6 +20,16 @@ struct archiver_args {
 	int compression_level;
 };
 
+/* main api */
+
+extern int write_archive(int argc, const char **argv, const char *prefix,
+			 struct repository *repo,
+			 const char *name_hint, int remote);
+
+const char *archive_format_from_filename(const char *filename);
+
+/* archive backend stuff */
+
 #define ARCHIVER_WANT_COMPRESSION_LEVELS 1
 #define ARCHIVER_REMOTE 2
 struct archiver {
@@ -36,9 +49,6 @@ typedef int (*write_archive_entry_fn_t)(struct archiver_args *args,
 					unsigned int mode);
 
 extern int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
-extern int write_archive(int argc, const char **argv, const char *prefix, const char *name_hint, int remote);
-
-const char *archive_format_from_filename(const char *filename);
 extern void *object_file_to_archive(const struct archiver_args *args,
 				    const char *path, const struct object_id *oid,
 				    unsigned int mode, enum object_type *type,
diff --git a/builtin/archive.c b/builtin/archive.c
index 73971d0dd2..e74f675390 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -105,5 +105,5 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 
 	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
 
-	return write_archive(argc, argv, prefix, output, 0);
+	return write_archive(argc, argv, prefix, the_repository, output, 0);
 }
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 84532ae9a9..25d9116356 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -43,7 +43,8 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 	}
 
 	/* parse all options sent by the client */
-	return write_archive(sent_argv.argc, sent_argv.argv, prefix, NULL, 1);
+	return write_archive(sent_argv.argc, sent_argv.argv, prefix,
+			     the_repository, NULL, 1);
 }
 
 __attribute__((format (printf, 1, 2)))
-- 
2.18.0.1004.g6639190530

