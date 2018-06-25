Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DC461F516
	for <e@80x24.org>; Mon, 25 Jun 2018 14:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934450AbeFYOfG (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 10:35:06 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:44919 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934420AbeFYOey (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 10:34:54 -0400
Received: by mail-qk0-f196.google.com with SMTP id 185-v6so7589207qkk.11
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 07:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3dpSAKo43xmwcpCevwgzh5p5tfFE5JQX/5YBTRNWTOo=;
        b=pZSJrA+AJAL6YmRd4qSOmjh+I89n0AInYuDeR6sMVUmcPN3/L/fBTzJhsPFgwQXrSO
         A7ZAEZKyVeKqAhCBH2Blc080TwYIpngBav0BFam0FVJ7iB7BZItnwKTrpI2JvuOgIG3M
         pR2kVlnK3kAkru2Jon5ijIigPu/asX+rO//tlbmkiErnmyfX2BleV+2HNJbvVKCIBO3D
         6B5j4NzHAcxuK0+JRoUpH7EL60Fzloo/r+9AWlGilTIS03xWJYKirpjegzs2zl1EDoa3
         q2BojSx8TfCNihaK7WkrvE+lWUxa2iYC5toD0tahgXSnCy7jh4lzF5o07zeamlLurNac
         Mefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3dpSAKo43xmwcpCevwgzh5p5tfFE5JQX/5YBTRNWTOo=;
        b=jk3LoAMqlKaHQaN0nIvTmNZEIPHlDXDJUpEDd6pyeOKtWryR+OZWKk1lNrZSDFMVpf
         p81w9SM1FenKElDbNQvSiPCAr10NDtD2mfmdUF5C7Q2KFzoJaS68mvuLoSo3HYf7N5PB
         v0nrNO2Bt3CxVuDKZ2CHSCJ+iHrjwDms5Xxl+UCAQ3o73n5nhb04qhh+OUZd/qEDirHz
         e8fWWau4PUUSEOGXaY3GgwX+EHnAcpI5dZTD+zbcl/6DvovdkSZKUZcnBhbphI3R7YjH
         mG2eqLbp4oFzNN9KML6SamRHU/+ndmWBRL1jmKUNO0bAaG+M/AfKlABY9ROt/w6IsfU8
         feTA==
X-Gm-Message-State: APt69E0bRaDSto89skTEWXMp8eR3WAIgbH3qpf8ZJ4e0T2Znr538Zdq/
        7XyW29YvxVsLoS5X1EI6G5OqtATm
X-Google-Smtp-Source: AAOMgpcHfKjWdGEbRrOEPXAwFfuFWBOkRVtn91oARTrErof0YY9V8Avfodyw66dtT5fBC0K17Ik2tg==
X-Received: by 2002:ae9:dd06:: with SMTP id r6-v6mr10617541qkf.417.1529937293466;
        Mon, 25 Jun 2018 07:34:53 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id w46-v6sm12821713qtw.55.2018.06.25.07.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:34:52 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 03/24] multi-pack-index: add builtin
Date:   Mon, 25 Jun 2018 10:34:13 -0400
Message-Id: <20180625143434.89044-4-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180625143434.89044-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180625143434.89044-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new 'git multi-pack-index' builtin will be the plumbing access
for writing, reading, and checking multi-pack-index files. The
initial implementation is a no-op.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 .gitignore                             |  3 +-
 Documentation/git-multi-pack-index.txt | 36 ++++++++++++++++++++++++
 Makefile                               |  1 +
 builtin.h                              |  1 +
 builtin/multi-pack-index.c             | 38 ++++++++++++++++++++++++++
 command-list.txt                       |  1 +
 git.c                                  |  1 +
 7 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/git-multi-pack-index.txt
 create mode 100644 builtin/multi-pack-index.c

diff --git a/.gitignore b/.gitignore
index 388cc4beee..25633bc515 100644
--- a/.gitignore
+++ b/.gitignore
@@ -99,8 +99,9 @@
 /git-mergetool--lib
 /git-mktag
 /git-mktree
-/git-name-rev
+/git-multi-pack-index
 /git-mv
+/git-name-rev
 /git-notes
 /git-p4
 /git-pack-redundant
diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
new file mode 100644
index 0000000000..9877f9c441
--- /dev/null
+++ b/Documentation/git-multi-pack-index.txt
@@ -0,0 +1,36 @@
+git-multi-pack-index(1)
+======================
+
+NAME
+----
+git-multi-pack-index - Write and verify multi-pack-indexes
+
+
+SYNOPSIS
+--------
+[verse]
+'git multi-pack-index' [--object-dir <dir>]
+
+DESCRIPTION
+-----------
+Write or verify a multi-pack-index (MIDX) file.
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
+SEE ALSO
+--------
+See link:technical/multi-pack-index.html[The Multi-Pack-Index Design
+Document] and link:technical/pack-format.html[The Multi-Pack-Index
+Format] for more information on the multi-pack-index feature.
+
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index e4b503d259..54610875ec 100644
--- a/Makefile
+++ b/Makefile
@@ -1047,6 +1047,7 @@ BUILTIN_OBJS += builtin/merge-recursive.o
 BUILTIN_OBJS += builtin/merge-tree.o
 BUILTIN_OBJS += builtin/mktag.o
 BUILTIN_OBJS += builtin/mktree.o
+BUILTIN_OBJS += builtin/multi-pack-index.o
 BUILTIN_OBJS += builtin/mv.o
 BUILTIN_OBJS += builtin/name-rev.o
 BUILTIN_OBJS += builtin/notes.o
diff --git a/builtin.h b/builtin.h
index 4e0f64723e..70997d7ace 100644
--- a/builtin.h
+++ b/builtin.h
@@ -191,6 +191,7 @@ extern int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_mktag(int argc, const char **argv, const char *prefix);
 extern int cmd_mktree(int argc, const char **argv, const char *prefix);
+extern int cmd_multi_pack_index(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_notes(int argc, const char **argv, const char *prefix);
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
new file mode 100644
index 0000000000..f101873525
--- /dev/null
+++ b/builtin/multi-pack-index.c
@@ -0,0 +1,38 @@
+#include "builtin.h"
+#include "cache.h"
+#include "config.h"
+#include "parse-options.h"
+
+static char const * const builtin_multi_pack_index_usage[] ={
+	N_("git multi-pack-index [--object-dir <dir>]"),
+	NULL
+};
+
+static struct opts_multi_pack_index {
+	const char *object_dir;
+} opts;
+
+int cmd_multi_pack_index(int argc, const char **argv,
+			 const char *prefix)
+{
+	static struct option builtin_multi_pack_index_options[] = {
+		OPT_FILENAME(0, "object-dir", &opts.object_dir,
+		  N_("The object directory containing set of packfile and pack-index pairs")),
+		OPT_END(),
+	};
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_multi_pack_index_usage,
+				   builtin_multi_pack_index_options);
+
+	git_config(git_default_config, NULL);
+
+	argc = parse_options(argc, argv, prefix,
+			     builtin_multi_pack_index_options,
+			     builtin_multi_pack_index_usage, 0);
+
+	if (!opts.object_dir)
+		opts.object_dir = get_object_directory();
+
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index e1c26c1bb7..61071f8fa2 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -123,6 +123,7 @@ git-merge-index                         plumbingmanipulators
 git-merge-one-file                      purehelpers
 git-mergetool                           ancillarymanipulators           complete
 git-merge-tree                          ancillaryinterrogators
+git-multi-pack-index                    plumbingmanipulators
 git-mktag                               plumbingmanipulators
 git-mktree                              plumbingmanipulators
 git-mv                                  mainporcelain           worktree
diff --git a/git.c b/git.c
index c2f48d53dd..a7509fa5f7 100644
--- a/git.c
+++ b/git.c
@@ -505,6 +505,7 @@ static struct cmd_struct commands[] = {
 	{ "merge-tree", cmd_merge_tree, RUN_SETUP | NO_PARSEOPT },
 	{ "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
 	{ "mktree", cmd_mktree, RUN_SETUP },
+	{ "multi-pack-index", cmd_multi_pack_index, RUN_SETUP_GENTLY },
 	{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 	{ "name-rev", cmd_name_rev, RUN_SETUP },
 	{ "notes", cmd_notes, RUN_SETUP },
-- 
2.18.0.24.g1b579a2ee9

