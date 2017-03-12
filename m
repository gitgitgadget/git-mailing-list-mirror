Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F8C01FC43
	for <e@80x24.org>; Sun, 12 Mar 2017 07:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933261AbdCLHyr (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 03:54:47 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33765 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933178AbdCLHyp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 03:54:45 -0400
Received: by mail-qt0-f196.google.com with SMTP id r45so3062878qte.0
        for <git@vger.kernel.org>; Sat, 11 Mar 2017 23:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C89ul9f7yC0qah8cUDu13PpAbaJMlmczSy4vOaKLWms=;
        b=UKeg+JUNEI7L4Ykji1ePt12BDetqGSKgSLg/rjJmlVO1XST0C+loOqq7UJsfyVT1r9
         PNi2hRDfSDTekfjqnzG+QUHrGQOU4KGZ5sh1L1XIJ4rTSF4ZlvS6jcXQtfuG2nicw744
         fzms7i4haKlm0j8KSAnEborxvgkNjKQuN4V/sYh+651X/FqHZRvtUVyGCt+5TCxoR6IW
         Y+qlHjYzfu6H5dMdv28F2JqF7/0Oo4Yb/7L9k3TauHfEkjMfM5LrvIIm0Gxu4nrnA+X0
         z2l9RKZjv/uF8Xl+5jbxUEcFNr8YCCx5ih5zEDcmfyvJmgUsQKH4QT0agg7vYgkCfZGJ
         BEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C89ul9f7yC0qah8cUDu13PpAbaJMlmczSy4vOaKLWms=;
        b=XyZV+cCNHH5zYWqpurbPLAax/x12Rj963Vuja8i9kJTNGeG3IgMfiuSujjFsMPJkbH
         sA0SfveJckJTEwhhrYb7Y04zsWSPjIZDNAi2L1PJrlkTIZ+jGcmWoS2/0L3CbbuKX0rv
         eY5RQ4xT9B0/piHfhDS79AU5VrklliNe61LA2kTcFh2s0UhKtX4InIcYviUGmHIg8QZ6
         TvjuYLShp302YjzFMmTsSfOcNmZwLu0xJMFEL/OSHKTl5sO1285TuQxznD+SU/NYHQPp
         IETmDPH3ZshiX39W9cGldPQuvoPQ8Mr5c7W77LHnmhsSz5l2Q9FxEg69TsJqaOroGLce
         vohg==
X-Gm-Message-State: AMke39kZllXIO5gk7FOv4zU9xphMA6Djt/lc6pCU+6dKSB6WgmxRd2LjjM4TLbYli+Cx1w==
X-Received: by 10.237.35.231 with SMTP id k36mr28024542qtc.192.1489305283809;
        Sat, 11 Mar 2017 23:54:43 -0800 (PST)
Received: from bonobo.com (cpe-184-152-21-78.nyc.res.rr.com. [184.152.21.78])
        by smtp.gmail.com with ESMTPSA id 143sm9824171qki.59.2017.03.11.23.54.42
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 11 Mar 2017 23:54:43 -0800 (PST)
From:   Nikhil Benesch <nikhil.benesch@gmail.com>
To:     git@vger.kernel.org
Cc:     Lars Hjemli <hjemli@gmail.com>,
        Nikhil Benesch <nikhil.benesch@gmail.com>
Subject: [PATCH 1/1] archive: learn to include submodules in output archive
Date:   Sun, 12 Mar 2017 03:54:04 -0400
Message-Id: <20170312075404.23951-2-nikhil.benesch@gmail.com>
X-Mailer: git-send-email 2.12.0.244.g625568cd8.dirty
In-Reply-To: <20170312075404.23951-1-nikhil.benesch@gmail.com>
References: <20170312075404.23951-1-nikhil.benesch@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit is a revival of Lars Hjemli's 2009 patch to provide an
option to include submodules in the output of `git archive`.

The `--recurse-submodules` option (named consistently with fetch, clone,
and ls-files) will recursively traverse submodules in the repository and
consider their contents for inclusion in the output archive, subject to
any pathspec filters. Like other commands that have learned
`--recurse-submodules`, submodules that have not been checked out will
not be traversed.

Signed-off-by: Nikhil Benesch <nikhil.benesch@gmail.com>
---
 Documentation/git-archive.txt |   8 ++-
 archive.c                     |  22 +++++----
 archive.h                     |   1 +
 submodule.c                   |   2 +-
 submodule.h                   |   1 +
 t/t5005-archive-submodules.sh | 112 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 133 insertions(+), 13 deletions(-)
 create mode 100755 t/t5005-archive-submodules.sh

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index cfa1e4ebe..f223f9e05 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -11,8 +11,8 @@ SYNOPSIS
 [verse]
 'git archive' [--format=<fmt>] [--list] [--prefix=<prefix>/] [<extra>]
 	      [-o <file> | --output=<file>] [--worktree-attributes]
-	      [--remote=<repo> [--exec=<git-upload-archive>]] <tree-ish>
-	      [<path>...]
+	      [--recurse-submodules] [--remote=<repo> [--exec=<git-upload-archive>]]
+	      <tree-ish> [<path>...]
 
 DESCRIPTION
 -----------
@@ -59,6 +59,10 @@ OPTIONS
 	Look for attributes in .gitattributes files in the working tree
 	as well (see <<ATTRIBUTES>>).
 
+--recurse-submodules::
+	Recursively include the contents of any checked-out submodules in
+	the archive.
+
 <extra>::
 	This can be any options that the archiver backend understands.
 	See next section.
diff --git a/archive.c b/archive.c
index 60b889198..8d060bad3 100644
--- a/archive.c
+++ b/archive.c
@@ -7,6 +7,7 @@
 #include "parse-options.h"
 #include "unpack-trees.h"
 #include "dir.h"
+#include "submodule.h"
 
 static char const * const archive_usage[] = {
 	N_("git archive [<options>] <tree-ish> [<path>...]"),
@@ -132,18 +133,15 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 		args->convert = ATTR_TRUE(check->items[1].value);
 	}
 
-	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
-		if (args->verbose)
-			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
-		err = write_entry(args, sha1, path.buf, path.len, mode);
-		if (err)
-			return err;
-		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
-	}
-
 	if (args->verbose)
 		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
-	return write_entry(args, sha1, path.buf, path.len, mode);
+	err = write_entry(args, sha1, path.buf, path.len, mode);
+	if (err)
+		return err;
+	if (S_ISDIR(mode) || (S_ISGITLINK(mode) && args->recurse_submodules &&
+			      !add_submodule_odb(path_without_prefix)))
+		return READ_TREE_RECURSIVE;
+	return 0;
 }
 
 static int write_archive_entry_buf(const unsigned char *sha1, struct strbuf *base,
@@ -411,6 +409,7 @@ static int parse_archive_args(int argc, const char **argv,
 	int verbose = 0;
 	int i;
 	int list = 0;
+	int recurse_submodules = 0;
 	int worktree_attributes = 0;
 	struct option opts[] = {
 		OPT_GROUP(""),
@@ -419,6 +418,8 @@ static int parse_archive_args(int argc, const char **argv,
 			N_("prepend prefix to each pathname in the archive")),
 		OPT_STRING('o', "output", &output, N_("file"),
 			N_("write the archive to this file")),
+		OPT_BOOL(0, "recurse-submodules", &recurse_submodules,
+			N_("recurse through submodules")),
 		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
 			N_("read .gitattributes in working directory")),
 		OPT__VERBOSE(&verbose, N_("report archived files on stderr")),
@@ -484,6 +485,7 @@ static int parse_archive_args(int argc, const char **argv,
 		}
 	}
 	args->verbose = verbose;
+	args->recurse_submodules = recurse_submodules;
 	args->base = base;
 	args->baselen = strlen(base);
 	args->worktree_attributes = worktree_attributes;
diff --git a/archive.h b/archive.h
index 415e0152e..96e217ac5 100644
--- a/archive.h
+++ b/archive.h
@@ -12,6 +12,7 @@ struct archiver_args {
 	time_t time;
 	struct pathspec pathspec;
 	unsigned int verbose : 1;
+	unsigned int recurse_submodules : 1;
 	unsigned int worktree_attributes : 1;
 	unsigned int convert : 1;
 	int compression_level;
diff --git a/submodule.c b/submodule.c
index 3b98766a6..5fe5a3a8e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -121,7 +121,7 @@ void stage_updated_gitmodules(void)
 		die(_("staging updated .gitmodules failed"));
 }
 
-static int add_submodule_odb(const char *path)
+int add_submodule_odb(const char *path)
 {
 	struct strbuf objects_directory = STRBUF_INIT;
 	int ret = 0;
diff --git a/submodule.h b/submodule.h
index 05ab674f0..d59fd2537 100644
--- a/submodule.h
+++ b/submodule.h
@@ -35,6 +35,7 @@ extern int is_staging_gitmodules_ok(void);
 extern int update_path_in_gitmodules(const char *oldpath, const char *newpath);
 extern int remove_path_from_gitmodules(const char *path);
 extern void stage_updated_gitmodules(void);
+extern int add_submodule_odb(const char *path);
 extern void set_diffopt_flags_from_submodule_config(struct diff_options *,
 		const char *path);
 extern int submodule_config(const char *var, const char *value, void *cb);
diff --git a/t/t5005-archive-submodules.sh b/t/t5005-archive-submodules.sh
new file mode 100755
index 000000000..747e38627
--- /dev/null
+++ b/t/t5005-archive-submodules.sh
@@ -0,0 +1,112 @@
+#!/bin/sh
+
+test_description='git archive can include submodule content'
+
+. ./test-lib.sh
+
+add_file()
+{
+	git add $1 &&
+	git commit -m "added $1"
+}
+
+add_submodule()
+{
+	mkdir $1 && (
+		cd $1 &&
+		git init &&
+		echo "File $2" >$2 &&
+		add_file $2
+	) &&
+	add_file $1
+}
+
+test_expect_success 'by default, submodules are not included' '
+	echo "File 1" >1 &&
+	add_file 1 &&
+	add_submodule 2 3 &&
+	add_submodule 4 5 &&
+	cat <<EOF >expected &&
+1
+2/
+4/
+EOF
+	git archive HEAD >normal.tar &&
+	tar -tf normal.tar >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with --recurse-submodules, checked out submodules are included' '
+	cat <<EOF >expected &&
+1
+2/
+2/3
+4/
+4/5
+EOF
+	git archive --recurse-submodules HEAD >full.tar &&
+	tar -tf full.tar >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'submodules in submodules are supported' '
+	(cd 4 && add_submodule 6 7) &&
+	add_file 4 &&
+	cat <<EOF >expected &&
+1
+2/
+2/3
+4/
+4/5
+4/6/
+4/6/7
+EOF
+	git archive --recurse-submodules HEAD >recursive.tar &&
+	tar -tf recursive.tar >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'packed submodules are supported' '
+	msg=$(cd 2 && git repack -ad && git count-objects) &&
+	test "$msg" = "0 objects, 0 kilobytes" &&
+	git archive --recurse-submodules HEAD >packed.tar &&
+	tar -tf packed.tar >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'pathspecs supported' '
+	cat <<EOF >expected &&
+2/3
+4/6/7
+EOF
+	git archive --recurse-submodules HEAD >recursive.tar &&
+	tar -tf recursive.tar 4/6/7 2/3 >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'missing submodule packs triggers an error' '
+	mv 2/.git/objects/pack .git/packdir2 &&
+	test_must_fail git archive --recurse-submodules HEAD
+'
+
+test_expect_success '--recurse-submodules skips non-checked out submodules' '
+	cat <<EOF >expected &&
+1
+2/
+4/
+4/5
+4/6/
+4/6/7
+EOF
+	rm -rf 2/.git &&
+	git archive --recurse-submodules HEAD >partial.tar &&
+	tar -tf partial.tar >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'missing objects in a submodule triggers an error' '
+	find 4/.git/objects -type f | xargs rm &&
+	test_must_fail git archive --recurse-submodules HEAD
+'
+
+test_done
-- 
2.12.0.244.g625568cd8.dirty

