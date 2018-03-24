Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4920A1F404
	for <e@80x24.org>; Sat, 24 Mar 2018 18:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbeCXSYP (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 14:24:15 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43639 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbeCXSYO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 14:24:14 -0400
Received: by mail-wr0-f195.google.com with SMTP id p53so7556128wrc.10
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 11:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oKfh0pG3ak5durWYvBqSBcHNZMk6tbzQio4qJMHC4TQ=;
        b=lWPskzFQNyR//sDfptR4AUMPQ5FcxqICFxGPhf3vxAN+WNUc45YNWXGOvHvMQHQuh+
         RVx5qNqiQRyFUcX0bjRcGS6V9QmsAm+b0YgDQJXMiHxD8pGF7jetLgcCZX31fwMZDqRC
         LhEbU3I81IDySLRqDHeTynfhfAozFYHyuSegfOdu3wVHNysIHwbfXS7TbT5bqDsG6S8/
         84rUoDU3zAPODDdSzwXQgEfiqdVe8cRJ7tVGhQaVAsZxM+xzSoeuBSqiCvzAI/jd1Sqd
         WU/JbBDImgTmAu52u8z+daGfL7T1vSQwiuhG1X33YgGQWZ4AlM7gNPOA3qLCO5Gt5woP
         GoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oKfh0pG3ak5durWYvBqSBcHNZMk6tbzQio4qJMHC4TQ=;
        b=bk03gXlcIshPEzu4P7nMI0djPzIZ5p03JJxE2kZ5WU8G1zSsdtaiyyBGPjViJU1Dok
         jy2JpMvmQMUD7rPOCqJnlPRXQwf8mfe5m3kx6i8Xdl8m6jsTSLi5zw2dkCAt0rfr6dgV
         cqVURGqQKBtJh+4sv3A5Snebl4e7uYMY5wnzLdb7+0Rw0nj0N/4GqRDMRun+9f3I+nlt
         oUhUAJcQiwR4Y5PcL+Mp1nt3hbHnScj360WTiDrgfoWnf+cXHSn2k/DO5UIyxT+V9vfq
         SVOdWRMsZSZj6AeVbNbpsULrSE6e7IR5nyNmBuGA8ae2JAqJ8HD8TSPWkFqW9aCZklFg
         VUzQ==
X-Gm-Message-State: AElRT7FVhBFCOVLstF3l7Nl/Ooc+2PWsRLnTD58u6Cn3rSbnD6SVGh9l
        BvpQwikUa7wo9w1ylkpow8vo2g==
X-Google-Smtp-Source: AG47ELvnlpzgn9VN2esQl2DXA6AZCrL1/vRUxW7iQyoxUZDhn65f85v8K74RDdIf4UvBEYKkM55h7A==
X-Received: by 10.223.196.212 with SMTP id o20mr26038263wrf.144.1521915852733;
        Sat, 24 Mar 2018 11:24:12 -0700 (PDT)
Received: from localhost.localdomain ([92.55.154.10])
        by smtp.gmail.com with ESMTPSA id r126sm15540885wmb.10.2018.03.24.11.24.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 11:24:11 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: [RFC][PATCH] git-stash: convert git stash list to C builtin
Date:   Sat, 24 Mar 2018 20:23:13 +0200
Message-Id: <20180324182313.13705-1-ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.16.2.647.gb9d10dde1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, because git stash is not fully converted to C, I
introduced a new helper that will hold the converted commands.
---
 Makefile                |  1 +
 builtin.h               |  1 +
 builtin/stash--helper.c | 52 +++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            |  7 +-----
 git.c                   |  1 +
 5 files changed, 56 insertions(+), 6 deletions(-)
 create mode 100644 builtin/stash--helper.c

diff --git a/Makefile b/Makefile
index a1d8775ad..8ca361c57 100644
--- a/Makefile
+++ b/Makefile
@@ -1020,6 +1020,7 @@ BUILTIN_OBJS += builtin/send-pack.o
 BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-ref.o
+BUILTIN_OBJS += builtin/stash--helper.o
 BUILTIN_OBJS += builtin/stripspace.o
 BUILTIN_OBJS += builtin/submodule--helper.o
 BUILTIN_OBJS += builtin/symbolic-ref.o
diff --git a/builtin.h b/builtin.h
index 42378f3aa..2ddb4bd5c 100644
--- a/builtin.h
+++ b/builtin.h
@@ -220,6 +220,7 @@ extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
+extern int cmd_stash__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_tag(int argc, const char **argv, const char *prefix);
diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
new file mode 100644
index 000000000..61fd5390d
--- /dev/null
+++ b/builtin/stash--helper.c
@@ -0,0 +1,52 @@
+#include "builtin.h"
+#include "cache.h"
+#include "parse-options.h"
+#include "argv-array.h"
+
+enum {
+	LIST_STASH = 1
+};
+
+static const char * ref_stash = "refs/stash";
+
+static const char * const git_stash__helper_usage[] = {
+	N_("git stash--helper --list [<options>]"),
+	NULL
+};
+
+static int list_stash(int argc, const char **argv, const char *prefix)
+{
+	struct object_id obj;
+	struct argv_array args = ARGV_ARRAY_INIT;
+
+	if (get_oid(ref_stash, &obj))
+		return 0;
+
+	argv_array_pushl(&args, "log", "--format=%gd: %gs", "-g", "--first-parent", "-m", NULL);
+	argv_array_pushv(&args, argv);
+	argv_array_push(&args, ref_stash);
+	return !!cmd_log(args.argc, args.argv, prefix);
+}
+
+int cmd_stash__helper(int argc, const char **argv, const char *prefix)
+{
+	int cmdmode = 0;
+
+	struct option options[] = {
+		OPT_CMDMODE(0, "list", &cmdmode,
+			 N_("list stash entries"), LIST_STASH),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash__helper_usage, PARSE_OPT_KEEP_UNKNOWN);
+
+	if (!cmdmode)
+		usage_with_options(git_stash__helper_usage, options);
+
+	switch (cmdmode) {
+		case LIST_STASH:
+			return list_stash(argc, argv, prefix);
+	}
+	return 0;
+}
diff --git a/git-stash.sh b/git-stash.sh
index fc8f8ae64..a5b9f5fb6 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -380,11 +380,6 @@ have_stash () {
 	git rev-parse --verify --quiet $ref_stash >/dev/null
 }
 
-list_stash () {
-	have_stash || return 0
-	git log --format="%gd: %gs" -g --first-parent -m "$@" $ref_stash --
-}
-
 show_stash () {
 	ALLOW_UNKNOWN_FLAGS=t
 	assert_stash_like "$@"
@@ -695,7 +690,7 @@ test -n "$seen_non_option" || set "push" "$@"
 case "$1" in
 list)
 	shift
-	list_stash "$@"
+	git stash--helper --list "$@"
 	;;
 show)
 	shift
diff --git a/git.c b/git.c
index 96cd734f1..6fd2ccd9a 100644
--- a/git.c
+++ b/git.c
@@ -466,6 +466,7 @@ static struct cmd_struct commands[] = {
 	{ "show-branch", cmd_show_branch, RUN_SETUP },
 	{ "show-ref", cmd_show_ref, RUN_SETUP },
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+	{ "stash--helper", cmd_stash__helper, RUN_SETUP },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
 	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX},
-- 
2.16.2.647.gb9d10dde1

