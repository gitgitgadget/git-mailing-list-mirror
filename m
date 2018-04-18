Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B574E1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 22:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbeDRWsf (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 18:48:35 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:42670 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbeDRWse (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 18:48:34 -0400
Received: by mail-wr0-f179.google.com with SMTP id s18-v6so8913638wrg.9
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 15:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:user-agent:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ZucSm6gdINNucrfBAHhQCCJJ1kpqAW/wVIjBZqr+xs=;
        b=pZajtuwFFIKV6qiabv2TfLUZM6X8EULphJ40v843KJKc5leHNDnR5Wq6HH++iQLwS6
         gKkifO+bdU3t+cKdar1VwPHUNshmxjy7oAInnk/C1i+j2dqzoXa7c7EA8krefP8fKlsF
         RWp1WdvC9eeIFuXfB8jdwySN1JDFMjGol4ZuhMMYG2BM5oPu/mwposD6mxXhSFneZ17k
         MViT+dPiePYTMy1jLHwYrx8agGjuW2p00uN7Enfz4JRNg0/QTbqXNVxvEMnkginK9HWk
         vTqNbxb74pVZ9sYcBxwwvVDXBVp7e/mqSXWNGBKsheTyNCg9hRnXHdD9JvATcASBBPE2
         sL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:user-agent:date:message-id
         :mime-version:content-transfer-encoding;
        bh=9ZucSm6gdINNucrfBAHhQCCJJ1kpqAW/wVIjBZqr+xs=;
        b=evtXGr4GdbmzDq/nth6SNGieeEtCvyXS3H+qMu/oREM54Shvx5/3c/96Kz65c84jTp
         D2JVRSxjzjE13974HwZZ9HzB8dWL/6wIJr9ctGk8r9EHQUGngHckimuvQ0rUxP/xAq0F
         OvPMNY2j7tOaYLGxpMiujPpWkiFPLYWkx4u1x8Zzc5UsXyUcHX5gY/jVz7QYH0t66EdT
         nBSiA9lb1mWMcS7f14QEA9DUp1zxPGEc61Gd0qk/fVF2LEdtB05RCRT25+dg173Be9gU
         NAazEllGopz62AXZhBB53bIKt8QcpQ3iLowvafP7O0CoayhLyVQ9vd6IUirJUH0r7Tpj
         Tn5w==
X-Gm-Message-State: ALQs6tB5mwr5AZELraT95AXXxjDMX6YIN+32M65IFv0vBKRv7jeXYbvl
        k5FbB0jADIa7LLFrO8Ka/9j5XmVV
X-Google-Smtp-Source: AIpwx49T2Fn+TYF7qHRKLJvbV1eX6dtHTciAHxPIw3AEigNnmVbymw0l6b/tIwKsl4WLc7Tto45APA==
X-Received: by 10.28.6.149 with SMTP id 143mr2968467wmg.61.1524091712659;
        Wed, 18 Apr 2018 15:48:32 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id m62sm4357225wmc.41.2018.04.18.15.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 15:48:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     "Jeff King" <peff@peff.net>, Junio C Hamano <junio@pobox.com>,
        demerphq <demerphq@gmail.com>
Subject: [RFC WIP PATCH] merge: implement -s theirs -X N
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
Date:   Thu, 19 Apr 2018 00:48:30 +0200
Message-ID: <87sh7sdtc1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a -s ours, but not a -s theirs. This is a WIP patch to implement
that. It works, but I haven't dealt with this part of the internal API
before, comments most welcome.

The purpose of this is that I'm working with a rollout tool that is
capable of doing hotfixes on top of old commits on "master".

It does this by cherry-picking a commit from origin/master, and then
merges it with origin/master & pushes it back, before finally reset
--hard to the cherry-pick & rolling out.

The reason it's doing this is to maintain the guarantee that all rolled
out commits are reachable from "master", and to handle the more general
case where original work is made during a hotfix, we don't want to then
do a subsequent "normal" rollout and miss the fix.

In cases where I detect (by looking at patch-id's) that the only commits
that are being hotfixed are those cherry-picked from upstream, I want to
fully resolve the merge in favor of @{u}, i.e. end up with the same tree
SHA-1. This is the inverse of -s ours, but we have no -s theirs, this
implements that.

The `-s recursive -X theirs strategy` won't do, because that will just
resolve conflicts in favor of @{u}, but will screw up the well-known
cases where a merge produces bad results with no conflicts, due to edge
cases where patches apply cleanly but produce broken programs.

So this can be used as `-s theirs -X 2 @{u}` to implement that. The `-s
ours` strategy is then equivalent ot `-s theirs -X 1` (1st commit), and
we can do any value of `-X N` for octopus merges.

As noted `-s theirs` should be the same as supplying it with `-X 2`, but
I haven't implemented that yet.

Questions:

 1. Should I be calling read-tree here with run_command_v_opt(), or is
    there some internal API I should be using?

 2. Currently merge-ours is just a no-op since we take the current HEAD,
    but maybe it would be cleaner to implement it in terms of this
    thing, also to get immediate test coverage for all the -s ours
    stuff. We'd be reading the tree redundantly into the index, but
    maybe it's worth it for the coverage...

 3. Is there a better name for this than -s theirs? Maybe `-s nth -X N`?

diff --git a/.gitignore b/.gitignore
index 833ef3b0b7..65d62b191f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -93,6 +93,7 @@
 /git-merge-recursive
 /git-merge-resolve
 /git-merge-subtree
+/git-merge-theirs
 /git-mergetool
 /git-mergetool--lib
 /git-mktag
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 4a58aad4b8..a84482aafc 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -117,6 +117,12 @@ ours::
 	branches.  Note that this is different from the -Xours option to
 	the 'recursive' merge strategy.

+theirs::
+	This resolves any number of heads, but the resulting tree of
+	the merge is always that of the Nth branch head specified via
+	`-X n`. If it's not specified it'll default ot `-X 2`,
+	supplying `-X 1` makes this equivalent to the `ours` strategy.
+
 subtree::
 	This is a modified recursive strategy. When merging trees A and
 	B, if B corresponds to a subtree of A, B is first adjusted to
diff --git a/Makefile b/Makefile
index f181687250..00ded0c37c 100644
--- a/Makefile
+++ b/Makefile
@@ -998,6 +998,7 @@ BUILTIN_OBJS += builtin/merge-file.o
 BUILTIN_OBJS += builtin/merge-index.o
 BUILTIN_OBJS += builtin/merge-ours.o
 BUILTIN_OBJS += builtin/merge-recursive.o
+BUILTIN_OBJS += builtin/merge-theirs.o
 BUILTIN_OBJS += builtin/merge-tree.o
 BUILTIN_OBJS += builtin/mktag.o
 BUILTIN_OBJS += builtin/mktree.o
@@ -2815,6 +2816,7 @@ check-docs::
 		case "$$v" in \
 		git-merge-octopus | git-merge-ours | git-merge-recursive | \
 		git-merge-resolve | git-merge-subtree | \
+		git-merge-theirs \
 		git-fsck-objects | git-init-db | \
 		git-remote-* | git-stage | \
 		git-?*--?* ) continue ;; \
diff --git a/builtin.h b/builtin.h
index 42378f3aa4..a48eaf3a67 100644
--- a/builtin.h
+++ b/builtin.h
@@ -187,6 +187,7 @@ extern int cmd_merge_index(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
+extern int cmd_merge_theirs(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_mktag(int argc, const char **argv, const char *prefix);
 extern int cmd_mktree(int argc, const char **argv, const char *prefix);
diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index c84c6e05e9..da5ba0b370 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -18,7 +18,6 @@ int cmd_merge_ours(int argc, const char **argv, const char *prefix)
 {
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(builtin_merge_ours_usage);
-
 	/*
 	 * The contents of the current index becomes the tree we
 	 * commit.  The index must match HEAD, or this merge cannot go
diff --git a/builtin/merge-theirs.c b/builtin/merge-theirs.c
new file mode 100644
index 0000000000..545680ebc6
--- /dev/null
+++ b/builtin/merge-theirs.c
@@ -0,0 +1,72 @@
+/*
+ * Copyright (c) 2018 Ævar Arnfjörð Bjarmason
+ *
+ * Resolve the merge by picking the Nth (per -X) parent's tree is our
+ * new tree.
+ */
+#include "git-compat-util.h"
+#include "builtin.h"
+#include "run-command.h"
+#include "diff.h"
+
+static const char builtin_merge_theirs_usage[] =
+	"git merge-theirs <base>... -- HEAD <remote>...";
+
+static void read_tree_hex_oid(const char *hex_oid)
+{
+	int i = 0;
+	const char *args[4];
+
+	args[i++] = "read-tree";
+	args[i++] = hex_oid;
+	args[i] = NULL;
+
+	if (run_command_v_opt(args, RUN_GIT_CMD))
+		die(_("read-tree failed"));
+}
+
+int cmd_merge_theirs(int argc, const char **argv, const char *prefix)
+{
+	const char *mainline_str;
+	const int argc_offset = 3;
+	char *end;
+	int mainline;
+	const char *branch;
+	struct object_id commit;
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage(builtin_merge_theirs_usage);
+	if (argc < 6)
+		usage(builtin_merge_theirs_usage);
+
+	/*
+	 * Parse the --N part of `git merge-theirs --N base -- HEAD
+	 * other-branch [other-branch-2 ...]`.
+	 *
+	 * TODO: Handle no -X argument being equivalent to -X 2.
+	 */
+	mainline_str = argv[1];
+	if (!mainline_str[2])
+		usage(builtin_merge_theirs_usage);
+	mainline = strtol(mainline_str + 2, &end, 10);
+	if (*end || mainline <= 0)
+		die(_("'-s theirs -X N' expects a number greater than zero"));
+	if (mainline >= (argc - argc_offset))
+		die(_("'-s theirs -X N' must come with a corresponding Nth commit to merge!"));
+
+	/* Have the branch name */
+	branch = argv[argc_offset + mainline];
+	if (get_oid(branch, &commit))
+		die(_("could not resolve ref '%s'"), branch);
+
+	/* Final sanity checks, copied from merge-ours.c */
+	if (read_cache() < 0)
+		die_errno("read_cache failed");
+	if (index_differs_from("HEAD", NULL, 0))
+		exit(2);
+
+	/* Read the Nth tree */
+	read_tree_hex_oid(oid_to_hex(&commit));
+
+	exit(0);
+}
diff --git a/builtin/merge.c b/builtin/merge.c
index 9db5a2cf16..dd623530d8 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -81,6 +81,7 @@ static struct strategy all_strategy[] = {
 	{ "octopus",    DEFAULT_OCTOPUS },
 	{ "resolve",    0 },
 	{ "ours",       NO_FAST_FORWARD | NO_TRIVIAL },
+	{ "theirs",     NO_FAST_FORWARD | NO_TRIVIAL },
 	{ "subtree",    NO_FAST_FORWARD | NO_TRIVIAL },
 };

diff --git a/git.c b/git.c
index 3a89893712..8e87accbb9 100644
--- a/git.c
+++ b/git.c
@@ -434,6 +434,7 @@ static struct cmd_struct commands[] = {
 	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "merge-theirs", cmd_merge_theirs, RUN_SETUP | NO_PARSEOPT },
 	{ "merge-tree", cmd_merge_tree, RUN_SETUP | NO_PARSEOPT },
 	{ "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
 	{ "mktree", cmd_mktree, RUN_SETUP },
