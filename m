Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9986020248
	for <e@80x24.org>; Thu,  7 Mar 2019 15:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfCGPoU (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 10:44:20 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36029 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfCGPoT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 10:44:19 -0500
Received: by mail-qt1-f194.google.com with SMTP id p25so17586513qtb.3
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 07:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NYAhDRaLNPVPSYw7ijHE1++ZC3NAQJQWLkbbb3tau08=;
        b=EVO8VOaOTZ11pk6TcwHRFLc9mYoeBJ4Cha+Uf7mie2oSsnqG3uy4afHl69rNYHTTJU
         XfMND3Ks6f2shtPamyBy9g6lk+HvpSXNExNhWrHEGVC+dmd7VsToKrtmFsD3KplWlBYo
         +G2ReYhVvW/TBggEKrsBXWbT/Es9T0rtbcm7KU7ClVTsHU4+ZpdTB+KJ/qtsUFb2CUz8
         GY4v+XWFla5O9y1sLmmWs7VrdiCdbpCgUb7Am6rhQEXK3LFhVlJ3nTtED2MWDZnMrDO+
         Le0pOAV3e+SgdpkbA8Yf4VZztyuTeLh7FTuEQwHN3dodB2xGhWvoYEVJU55lbOZjKqAS
         62YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NYAhDRaLNPVPSYw7ijHE1++ZC3NAQJQWLkbbb3tau08=;
        b=WQIfcYL2vplSOa+U/vP2PiJoKye8+hDi4/YeapO79EqZS0tTsVwRQ0Acr1/6IE+nqw
         8xstlCmpQ9n65g8GhTIvPk0MVRAhbdTO39uheYypO8h813gPMm7xn6sNj3QQNPXzg7dO
         K0HDMeHuxb39BXv5LYj3/VEEqfLRVJn5q7+Bw3chwJLWMPJwW+aoF4UkGa/fka2VGHjF
         ZinwrDVGaSu9zitgEatLRcpm1cAAx6FeuOSP0alrMCo4NtihsM8jAiGPjeRUXmlRVdIL
         FOciQZUt+60PuXtwbNnlV1Z7wMjzeEdF/g+o/XWVaEIsxNZKe9btYes1BZCDA5XMqtqP
         k7Ig==
X-Gm-Message-State: APjAAAXXCAyg815KGLVs4IbLFe/z3TOsgZbZF83+qAaPwApUPI0mFg5g
        0pQ7FsucvHAF3hErUKMk2ltW7vntW0A=
X-Google-Smtp-Source: APXvYqwnBuGXkVI4B4cVaTinV3YZbT1LJDr+o6+qKzPxwsVjpJ0mjs440MqfLSxlBu+oMKuBva1Kuw==
X-Received: by 2002:a0c:b297:: with SMTP id r23mr11191665qve.167.1551973457873;
        Thu, 07 Mar 2019 07:44:17 -0800 (PST)
Received: from localhost.localdomain (fctnnbsc38w-142-162-41-118.dhcp-dynamic.fibreop.nb.bellaliant.net. [142.162.41.118])
        by smtp.gmail.com with ESMTPSA id r44sm3107384qtb.53.2019.03.07.07.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 07:44:16 -0800 (PST)
From:   Brandon Richardson <brandon1024.br@gmail.com>
To:     git@vger.kernel.org
Cc:     rybak.a.v@gmail.com, pclouds@gmail.com, peff@peff.net,
        sunshine@sunshineco.com, gitster@pobox.com,
        Brandon Richardson <brandon1024.br@gmail.com>
Subject: [PATCH v5] commit-tree: utilize parse-options api
Date:   Thu,  7 Mar 2019 11:44:09 -0400
Message-Id: <20190307154409.14808-1-brandon1024.br@gmail.com>
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

Also update the documentation to better describe that mixing
`-m` and `-F` options will correctly compose commit log messages in the
order in which the options are given.

In the process, mark various strings for translation.

Signed-off-by: Brandon Richardson <brandon1024.br@gmail.com>
---

Notes:
    GitHub Pull Request: https://github.com/brandon1024/git/pull/5
    Travis CI Build: https://travis-ci.com/brandon1024/git/builds/103551319

 Documentation/git-commit-tree.txt |   9 +-
 builtin/commit-tree.c             | 158 ++++++++++++++++--------------
 parse-options.h                   |  11 +++
 3 files changed, 104 insertions(+), 74 deletions(-)

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 002dae625e..4b90b9c12a 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -23,6 +23,10 @@ Creates a new commit object based on the provided tree object and
 emits the new commit object id on stdout. The log message is read
 from the standard input, unless `-m` or `-F` options are given.
 
+The `-m` and `-F` options can be given any number of times, in any
+order. The commit log message will be composed in the order in which
+the options are given.
+
 A commit object may have any number of parents. With exactly one
 parent, it is an ordinary commit. Having more than one parent makes
 the commit a merge between several lines of history. Initial (root)
@@ -41,7 +45,7 @@ state was.
 OPTIONS
 -------
 <tree>::
-	An existing tree object
+	An existing tree object.
 
 -p <parent>::
 	Each `-p` indicates the id of a parent commit object.
@@ -52,7 +56,8 @@ OPTIONS
 
 -F <file>::
 	Read the commit log message from the given file. Use `-` to read
-	from the standard input.
+	from the standard input. This can be given more than once and the
+	content of each file becomes its own paragraph.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 12cc403bd7..b866d83951 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -12,8 +12,13 @@
 #include "builtin.h"
 #include "utf8.h"
 #include "gpg-interface.h"
+#include "parse-options.h"
 
-static const char commit_tree_usage[] = "git commit-tree [(-p <sha1>)...] [-S[<keyid>]] [-m <message>] [-F <file>] <sha1>";
+static const char * const commit_tree_usage[] = {
+	N_("git commit-tree [(-p <parent>)...] [-S[<keyid>]] [(-m <message>)...] "
+		"[(-F <file>)...] <tree>"),
+	NULL
+};
 
 static const char *sign_commit;
 
@@ -23,7 +28,7 @@ static void new_parent(struct commit *parent, struct commit_list **parents_p)
 	struct commit_list *parents;
 	for (parents = *parents_p; parents; parents = parents->next) {
 		if (parents->item == parent) {
-			error("duplicate parent %s ignored", oid_to_hex(oid));
+			error(_("duplicate parent %s ignored"), oid_to_hex(oid));
 			return;
 		}
 		parents_p = &parents->next;
@@ -39,91 +44,100 @@ static int commit_tree_config(const char *var, const char *value, void *cb)
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

