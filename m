Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3683D1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932842AbeFGODt (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:03:49 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45586 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932767AbeFGODr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:03:47 -0400
Received: by mail-qt0-f193.google.com with SMTP id i18-v6so9911836qtp.12
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=krH9JwmpI420Ank0jAnMXBa2DcAlPCPglTEmhBdBqEY=;
        b=Wot/vGSZv+O7j8P0yeawOI3kHeEnQtI2WND8cQr7BfmXMTcIRCkkJq+fWwhv45oDeM
         4BtQqBShHhLVQCc8NwEuA41DTL1tudkHhFIAuihTHY7dJUN+Y68hwZAif0sFimfoittn
         43eQWJiQw/N8EULImbliZGUCuDjgmdPKr6psD9X2AQLl3gocsCMA9exJF2h2be/nF/MO
         te/Js3lZsFBHa46jOr1QWmnx0s3bKuhb1fshzGm74rntMIuS/ad0te2s4vPx3jMhvfob
         mf+v0Q0SQltqj5UN/MYYZMMGpH/H1hS+vhMVgYr0QXXzLgWAbi2nZCgENInoFD6r/e/X
         XOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=krH9JwmpI420Ank0jAnMXBa2DcAlPCPglTEmhBdBqEY=;
        b=c9QSQgUNCigTo9G2UJyK+Gtce7OQ0V0jN0AzW8q57t0ILss0alEmXHJSXs/5izVwy0
         a0RsLiwQcc/+1idgtTC/kw05hmzVD8AXmiy0iW3dFv0hht7GiuuzIjHGsenawZnPCyXl
         KHMOx3KWq4St3PDGDGr++4t82j2sbTT04tsEW7vXx1cCb7PJ8hPSs/L9bnFEbOL14ROa
         pXGCE3hOmz1Mh1hdhqAmZPT9pC3WqtI8G967AmpWohIg9gCogO1DdUyNwEpaM2wohRQT
         NiwcMdhhYoe0IIA1Tnb0sq4w5CD92FeVYIicie2c2xqkWDme2LYNGCOQLqW60YXcovXv
         de+w==
X-Gm-Message-State: APt69E1n1z52jkjnMMDagJfOAV5uSvXWFiQx4kSKZTVptjG3+eV5OJxM
        wFDJJCDCEDtKizXFSf1Nftgaenaq
X-Google-Smtp-Source: ADUXVKL23RuMtItPTwjepYqCXt/wJ0cbXQz4PL9tMRITTqWD4OK9QJBunh9xrh/wZCCt//gu9POKFw==
X-Received: by 2002:a0c:d276:: with SMTP id o51-v6mr1765894qvh.182.1528380226038;
        Thu, 07 Jun 2018 07:03:46 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u74-v6sm12532763qku.55.2018.06.07.07.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:03:45 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: [PATCH 03/23] midx: add midx builtin
Date:   Thu,  7 Jun 2018 10:03:18 -0400
Message-Id: <20180607140338.32440-4-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607140338.32440-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new 'git midx' builtin will be the plumbing access for writing,
reading, and checking multi-pack-index (MIDX) files. The initial
implementation is a no-op.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 .gitignore                 |  1 +
 Documentation/git-midx.txt | 29 +++++++++++++++++++++++++++++
 Makefile                   |  1 +
 builtin.h                  |  1 +
 builtin/midx.c             | 38 ++++++++++++++++++++++++++++++++++++++
 command-list.txt           |  1 +
 git.c                      |  1 +
 7 files changed, 72 insertions(+)
 create mode 100644 Documentation/git-midx.txt
 create mode 100644 builtin/midx.c

diff --git a/.gitignore b/.gitignore
index 388cc4beee..e309644d6b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -97,6 +97,7 @@
 /git-merge-subtree
 /git-mergetool
 /git-mergetool--lib
+/git-midx
 /git-mktag
 /git-mktree
 /git-name-rev
diff --git a/Documentation/git-midx.txt b/Documentation/git-midx.txt
new file mode 100644
index 0000000000..2bd886f1a2
--- /dev/null
+++ b/Documentation/git-midx.txt
@@ -0,0 +1,29 @@
+git-midx(1)
+============
+
+NAME
+----
+git-midx - Write and verify multi-pack-indexes (MIDX files).
+
+
+SYNOPSIS
+--------
+[verse]
+'git midx' [--object-dir <dir>]
+
+DESCRIPTION
+-----------
+Write or verify a MIDX file.
+
+OPTIONS
+-------
+
+--object-dir <dir>::
+	Use given directory for the location of Git objects. We check
+	<dir>/packs/multi-pack-index for the current MIDX file, and
+	<dir>/packs for the pack-files to index.
+
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 1d27f36365..88958c7b42 100644
--- a/Makefile
+++ b/Makefile
@@ -1045,6 +1045,7 @@ BUILTIN_OBJS += builtin/merge-index.o
 BUILTIN_OBJS += builtin/merge-ours.o
 BUILTIN_OBJS += builtin/merge-recursive.o
 BUILTIN_OBJS += builtin/merge-tree.o
+BUILTIN_OBJS += builtin/midx.o
 BUILTIN_OBJS += builtin/mktag.o
 BUILTIN_OBJS += builtin/mktree.o
 BUILTIN_OBJS += builtin/mv.o
diff --git a/builtin.h b/builtin.h
index 4e0f64723e..7b5bd46c7d 100644
--- a/builtin.h
+++ b/builtin.h
@@ -189,6 +189,7 @@ extern int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_midx(int argc, const char **argv, const char *prefix);
 extern int cmd_mktag(int argc, const char **argv, const char *prefix);
 extern int cmd_mktree(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
diff --git a/builtin/midx.c b/builtin/midx.c
new file mode 100644
index 0000000000..59ea92178f
--- /dev/null
+++ b/builtin/midx.c
@@ -0,0 +1,38 @@
+#include "builtin.h"
+#include "cache.h"
+#include "config.h"
+#include "git-compat-util.h"
+#include "parse-options.h"
+
+static char const * const builtin_midx_usage[] ={
+	N_("git midx [--object-dir <dir>]"),
+	NULL
+};
+
+static struct opts_midx {
+	const char *object_dir;
+} opts;
+
+int cmd_midx(int argc, const char **argv, const char *prefix)
+{
+	static struct option builtin_midx_options[] = {
+		{ OPTION_STRING, 0, "object-dir", &opts.object_dir,
+		  N_("dir"),
+		  N_("The object directory containing set of packfile and pack-index pairs.") },
+		OPT_END(),
+	};
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_midx_usage, builtin_midx_options);
+
+	git_config(git_default_config, NULL);
+
+	argc = parse_options(argc, argv, prefix,
+			     builtin_midx_options,
+			     builtin_midx_usage, 0);
+
+	if (!opts.object_dir)
+		opts.object_dir = get_object_directory();
+
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index e1c26c1bb7..a21bd7470e 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -123,6 +123,7 @@ git-merge-index                         plumbingmanipulators
 git-merge-one-file                      purehelpers
 git-mergetool                           ancillarymanipulators           complete
 git-merge-tree                          ancillaryinterrogators
+git-midx                                plumbingmanipulators
 git-mktag                               plumbingmanipulators
 git-mktree                              plumbingmanipulators
 git-mv                                  mainporcelain           worktree
diff --git a/git.c b/git.c
index c2f48d53dd..400fadd677 100644
--- a/git.c
+++ b/git.c
@@ -503,6 +503,7 @@ static struct cmd_struct commands[] = {
 	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-tree", cmd_merge_tree, RUN_SETUP | NO_PARSEOPT },
+	{ "midx", cmd_midx, RUN_SETUP },
 	{ "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
 	{ "mktree", cmd_mktree, RUN_SETUP },
 	{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
-- 
2.18.0.rc1

