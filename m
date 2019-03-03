Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82B7720248
	for <e@80x24.org>; Sun,  3 Mar 2019 20:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfCCUCp (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 15:02:45 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36614 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbfCCUCo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 15:02:44 -0500
Received: by mail-io1-f67.google.com with SMTP id r136so2373405iod.3
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 12:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3eWqwBas66t61TwloVP0oA0tYLgwTGE32iGILKmBhP0=;
        b=H6bxJflM6KERUwCY+V/00/td//xmstbwrhXkslhRA+Abd5+k/lbtsfVgsTz2d8Etyv
         HxRz9my5fPo6fMKWEluT7YKP52I4u79Ih8sRLQ5s33tQlQsKFKCyK6EqDJwZCWU7XFny
         gK8BIdt9D1YKLQkIQnPA44jCF1QIzxerrNGT4AN997g6hAfkPNdP/BpEzP1GowFAmG+G
         8smpEK5fyfBujduufLlz+XACdbVHKXb+pr2EXlI1oOvXAZyH3kWOxPeEkwm0qIs3jFej
         rFOQ5vOUW5HS1MKWRcjr2XJRVNDfiVxLtAa1QIwkMGWIj6nItDAnQ+7bx24wvrSBp33W
         qoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3eWqwBas66t61TwloVP0oA0tYLgwTGE32iGILKmBhP0=;
        b=jRgrJ4M0ST2800F/YXRTFPXis9EEZ8MXebnmv0ZSbMSQvlNyNPkr7VY8Uq3QHjMQNd
         qiGa8a1YhtdjDP4YeXUdC8jdbzXC+ZtdvCW0SmUKYb8oL0rj+VDqJH9c3Y31TEGK7URs
         ftK94fzrLFiY1i80AbVvL828a7sEmDI3T+gw5YrstAUc1kWt9bsYmNCxo3Hagr7qA0wO
         WxLiSw7S4QP5Rv5YtfB5HJRWcYjOfXlnFezAUQBJ2w2AnacxpGumnfGFCgQxRKQPLxMN
         dRxxKC9AOIzVP87JzVs354r5DImd/0QvvoTDU6kwGfNoTXDZbxIYRGO2ELkhqJtyehNK
         CCdA==
X-Gm-Message-State: APjAAAV/gugCk/3ndrhM5o5mKqPnA12PW9g9M8T7FjpZP6Isra1/VSAE
        /nzqv/YcVmQ4UCdvIgm5HpVOA4EAw0k=
X-Google-Smtp-Source: APXvYqz9g+0KxsfqnuvyU6xI4YKjdmmibbrgpLgfECKRlJ0hnnsw0pGFneZGdYGScEEhI8NFe3yG7g==
X-Received: by 2002:a5d:8494:: with SMTP id t20mr8414729iom.232.1551643362753;
        Sun, 03 Mar 2019 12:02:42 -0800 (PST)
Received: from localhost.localdomain ([38.64.181.27])
        by smtp.gmail.com with ESMTPSA id m69sm2152139itm.22.2019.03.03.12.02.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 Mar 2019 12:02:42 -0800 (PST)
From:   Brandon Richardson <brandon1024.br@gmail.com>
To:     git@vger.kernel.org
Cc:     rybak.a.v@gmail.com, pclouds@gmail.com, peff@peff.net,
        sunshine@sunshineco.com,
        Brandon Richardson <brandon1024.br@gmail.com>
Subject: [PATCH v3] commit-tree: utilize parse-options api
Date:   Sun,  3 Mar 2019 15:02:20 -0500
Message-Id: <20190303200220.30009-1-brandon1024.br@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than parse options manually, which is both difficult to
read and error prone, parse options supplied to commit-tree
using the parse-options api.

It was discovered that the --no-gpg-sign option was documented
but not implemented in commit 70ddbd7767 (commit-tree: add missing
--gpg-sign flag, 2019-01-19), and the existing implementation
would attempt to translate the option as a tree oid. It was also
suggested earlier in commit 55ca3f99ae (commit-tree: add and document
--no-gpg-sign, 2013-12-13) that commit-tree should be migrated to
utilize the parse-options api, which could help prevent mistakes
like this in the future. Hence this change.

Signed-off-by: Brandon Richardson <brandon1024.br@gmail.com>
---

Notes:
    GitHub Pull Request: https://github.com/brandon1024/git/pull/3
    Travis CI Build: https://travis-ci.com/brandon1024/git/builds/102953064

 Documentation/git-commit-tree.txt |   8 +-
 builtin/commit-tree.c             | 159 ++++++++++++++++--------------
 parse-options.h                   |  11 +++
 3 files changed, 104 insertions(+), 74 deletions(-)

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 002dae625e..f4e20b62a0 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -23,6 +23,9 @@ Creates a new commit object based on the provided tree object and
 emits the new commit object id on stdout. The log message is read
 from the standard input, unless `-m` or `-F` options are given.
 
+When mixing `-m` and `-F` options, the commit log message will be
+composed in the order in which the options are given.
+
 A commit object may have any number of parents. With exactly one
 parent, it is an ordinary commit. Having more than one parent makes
 the commit a merge between several lines of history. Initial (root)
@@ -41,7 +44,7 @@ state was.
 OPTIONS
 -------
 <tree>::
-	An existing tree object
+	An existing tree object.
 
 -p <parent>::
 	Each `-p` indicates the id of a parent commit object.
@@ -52,7 +55,8 @@ OPTIONS
 
 -F <file>::
 	Read the commit log message from the given file. Use `-` to read
-	from the standard input.
+	from the standard input. This can be given more than once and the
+	content of each file becomes its own paragraph.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 12cc403bd7..d4a911acf5 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -12,8 +12,14 @@
 #include "builtin.h"
 #include "utf8.h"
 #include "gpg-interface.h"
+#include "parse-options.h"
+#include "string-list.h"
 
-static const char commit_tree_usage[] = "git commit-tree [(-p <sha1>)...] [-S[<keyid>]] [-m <message>] [-F <file>] <sha1>";
+static const char * const commit_tree_usage[] = {
+	N_("git commit-tree [(-p <parent>)...] [-S[<keyid>]] [(-m <message>)...] "
+		"[(-F <file>)...] <tree>"),
+	NULL
+};
 
 static const char *sign_commit;
 
@@ -23,7 +29,7 @@ static void new_parent(struct commit *parent, struct commit_list **parents_p)
 	struct commit_list *parents;
 	for (parents = *parents_p; parents; parents = parents->next) {
 		if (parents->item == parent) {
-			error("duplicate parent %s ignored", oid_to_hex(oid));
+			error(_("duplicate parent %s ignored"), oid_to_hex(oid));
 			return;
 		}
 		parents_p = &parents->next;
@@ -39,91 +45,100 @@ static int commit_tree_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+static int parse_parent_arg_callback(const struct option *opt,
+		const char *arg, int unset)
+{
+	struct object_id oid;
+	struct commit_list **parents = opt->value;
+
+	BUG_ON_OPT_NEG_NOARG(unset, arg);
+
+	if (get_oid_commit(arg, &oid))
+		die(_("not a valid object name %s"), arg);
+
+	assert_oid_type(&oid, OBJ_COMMIT);
+	new_parent(lookup_commit(the_repository, &oid), parents);
+	return 0;
+}
+
+static int parse_message_arg_callback(const struct option *opt,
+		const char *arg, int unset)
+{
+	struct strbuf *buf = opt->value;
+
+	BUG_ON_OPT_NEG_NOARG(unset, arg);
+
+	if (buf->len)
+		strbuf_addch(buf, '\n');
+	strbuf_addstr(buf, arg);
+	strbuf_complete_line(buf);
+
+	return 0;
+}
+
+static int parse_file_arg_callback(const struct option *opt,
+		const char *arg, int unset)
+{
+	int fd;
+	struct strbuf *buf = opt->value;
+
+	BUG_ON_OPT_NEG_NOARG(unset, arg);
+
+	if (buf->len)
+		strbuf_addch(buf, '\n');
+	if (!strcmp(arg, "-"))
+		fd = 0;
+	else {
+		fd = open(arg, O_RDONLY);
+		if (fd < 0)
+			die_errno(_("git commit-tree: failed to open '%s'"), arg);
+	}
+	if (strbuf_read(buf, fd, 0) < 0)
+		die_errno(_("git commit-tree: failed to read '%s'"), arg);
+	if (fd && close(fd))
+		die_errno(_("git commit-tree: failed to close '%s'"), arg);
+
+	return 0;
+}
+
 int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 {
-	int i, got_tree = 0;
+	static struct strbuf buffer = STRBUF_INIT;
 	struct commit_list *parents = NULL;
 	struct object_id tree_oid;
 	struct object_id commit_oid;
-	struct strbuf buffer = STRBUF_INIT;
+
+	struct option options[] = {
+		{ OPTION_CALLBACK, 'p', NULL, &parents, N_("parent"),
+			N_("id of a parent commit object"), PARSE_OPT_NONEG,
+			parse_parent_arg_callback },
+		{ OPTION_CALLBACK, 'm', NULL, &buffer, N_("message"),
+			N_("commit message"), PARSE_OPT_NONEG,
+			parse_message_arg_callback },
+		{ OPTION_CALLBACK, 'F', NULL, &buffer, N_("file"),
+			N_("read commit log message from file"), PARSE_OPT_NONEG,
+			parse_file_arg_callback },
+		{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
+			N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		OPT_END()
+	};
 
 	git_config(commit_tree_config, NULL);
 
 	if (argc < 2 || !strcmp(argv[1], "-h"))
-		usage(commit_tree_usage);
-
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		if (!strcmp(arg, "-p")) {
-			struct object_id oid;
-			if (argc <= ++i)
-				usage(commit_tree_usage);
-			if (get_oid_commit(argv[i], &oid))
-				die("Not a valid object name %s", argv[i]);
-			assert_oid_type(&oid, OBJ_COMMIT);
-			new_parent(lookup_commit(the_repository, &oid),
-						 &parents);
-			continue;
-		}
+		usage_with_options(commit_tree_usage, options);
 
-		if (!strcmp(arg, "--gpg-sign")) {
-		    sign_commit = "";
-		    continue;
-		}
+	argc = parse_options(argc, argv, prefix, options, commit_tree_usage, 0);
 
-		if (skip_prefix(arg, "-S", &sign_commit) ||
-			skip_prefix(arg, "--gpg-sign=", &sign_commit))
-			continue;
+	if (argc != 1)
+		die(_("must give exactly one tree"));
 
-		if (!strcmp(arg, "--no-gpg-sign")) {
-			sign_commit = NULL;
-			continue;
-		}
-
-		if (!strcmp(arg, "-m")) {
-			if (argc <= ++i)
-				usage(commit_tree_usage);
-			if (buffer.len)
-				strbuf_addch(&buffer, '\n');
-			strbuf_addstr(&buffer, argv[i]);
-			strbuf_complete_line(&buffer);
-			continue;
-		}
-
-		if (!strcmp(arg, "-F")) {
-			int fd;
-
-			if (argc <= ++i)
-				usage(commit_tree_usage);
-			if (buffer.len)
-				strbuf_addch(&buffer, '\n');
-			if (!strcmp(argv[i], "-"))
-				fd = 0;
-			else {
-				fd = open(argv[i], O_RDONLY);
-				if (fd < 0)
-					die_errno("git commit-tree: failed to open '%s'",
-						  argv[i]);
-			}
-			if (strbuf_read(&buffer, fd, 0) < 0)
-				die_errno("git commit-tree: failed to read '%s'",
-					  argv[i]);
-			if (fd && close(fd))
-				die_errno("git commit-tree: failed to close '%s'",
-					  argv[i]);
-			continue;
-		}
-
-		if (get_oid_tree(arg, &tree_oid))
-			die("Not a valid object name %s", arg);
-		if (got_tree)
-			die("Cannot give more than one trees");
-		got_tree = 1;
-	}
+	if (get_oid_tree(argv[0], &tree_oid))
+		die(_("not a valid object name %s"), argv[0]);
 
 	if (!buffer.len) {
 		if (strbuf_read(&buffer, 0, 0) < 0)
-			die_errno("git commit-tree: failed to read");
+			die_errno(_("git commit-tree: failed to read"));
 	}
 
 	if (commit_tree(buffer.buf, buffer.len, &tree_oid, parents, &commit_oid,
diff --git a/parse-options.h b/parse-options.h
index 14fe32428e..3a442eee26 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -202,6 +202,17 @@ const char *optname(const struct option *opt, int flags);
 		BUG("option callback does not expect an argument"); \
 } while (0)
 
+/*
+ * Similar to the assertions above, but checks that "arg" is always non-NULL.
+ * This assertion also implies BUG_ON_OPT_NEG(), letting you declare both
+ * assertions in a single line.
+ */
+#define BUG_ON_OPT_NEG_NOARG(unset, arg) do { \
+	BUG_ON_OPT_NEG(unset); \
+	if(!(arg)) \
+		BUG("option callback expects an argument"); \
+} while(0)
+
 /*----- incremental advanced APIs -----*/
 
 enum {
-- 
2.21.0

