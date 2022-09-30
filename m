Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6277C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiI3SMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiI3SLN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:11:13 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E16733CC
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:10:01 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b4so1036198wrs.1
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=EKnTsLEc/uaNXySNZ3J7G+TM5kbkjhSxex3uL7U+vZY=;
        b=QwXPWkHEWuoTUUY22KXUGuP8Hz8zPSTyXXvBrBJDV79kWe/yhDo1pcgiZ3I88iDM8J
         Z097QFOyrX5h4KrqrFQcSimM35ejCxmGCxVllSkTBbmmOQeLr8+sGJ11msqrOUl55yBP
         xAw1U+1pqs2miAQAJRiRvSxFmbwuczYum5NzR3EQsE0FkoyIL2epyCykIWEPZFZp4S/T
         LogwboOZrsZcap7u7ZyfnbJmZJLBYTeOnHqNM+5zjAJ/4yFNYUcTOtlZO9lNXj/XIPAM
         goLj8R4Q9rKsD3mbtyvXIL7pstbbGK98DTOVtyD/nv1THcRFVPTrSABLuaFKpNYBQKfO
         NJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EKnTsLEc/uaNXySNZ3J7G+TM5kbkjhSxex3uL7U+vZY=;
        b=m7zMqUbibnHEYmvoDcDxoyi20eOsERqyxHbuY9UMNebvRAxMivxEA3RMcMCRig8UVz
         2wTYWDSrKQW0QhCqMPzUHLvILXcpDvHyccTwxJuSDjtomjfz7xomjkrFRZLoN0con1AQ
         9ep5xMJDEEHGrX5A+7tj6zxi4wGOsl+X+hHri4gWfeB4+8zNhBSnyMN5hnY2IaJZHNy4
         iVCWyw4S2B7u9Zw+CCHPFp35ejTkH1v3gyuFHm32BpaZE6gGnQZaIAFAiHbt7poCas5a
         0n6Jgi9zfSn1kyKDeTH7TuVmcLS8p+csBNC2I4eHNSO+PZ5Lc4Ep/FVTHskZK3U8jA3o
         KptA==
X-Gm-Message-State: ACrzQf1SraW7Qc+bOQIPexI+fWXKGyHHsAc+0aaR9SSoqXuw1lLSI/7G
        hxUnp/7hu8QQTK0L2BCIFgqGF5iabML9Tg==
X-Google-Smtp-Source: AMsMyM4IlBCqbH2bVsd0/Ll/oW+QX3qM3hcEcP6wiZKhJONQeQ1JvjR/uAqO012YnrNX8bkge+Qcjw==
X-Received: by 2002:a5d:6c6f:0:b0:22a:74af:fb7c with SMTP id r15-20020a5d6c6f000000b0022a74affb7cmr6586935wrz.634.1664561399267;
        Fri, 30 Sep 2022 11:09:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:09:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 33/36] worktree: define subcommand -h in terms of command -h
Date:   Fri, 30 Sep 2022 20:07:56 +0200
Message-Id: <patch-v3-33.36-76e6b7d296a-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid repeating the "-h" output for the "git worktree" command, and
instead define the usage of each subcommand with macros, so that the
"-h" output for the command itself can re-use those definitions. See
[1], [2] and [3] for prior art using the same pattern.

1. b25b727494f (builtin/multi-pack-index.c: define common usage with a
   macro, 2021-03-30)
2. 8757b35d443 (commit-graph: define common usage with a macro,
   2021-08-23)
3. 1e91d3faf6c (reflog: move "usage" variables and use macros,
   2022-03-17)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/worktree.c | 109 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 84 insertions(+), 25 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 5bfc18e5a24..ba6846c3788 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -15,15 +15,72 @@
 #include "worktree.h"
 #include "quote.h"
 
-static const char * const worktree_usage[] = {
-	N_("git worktree add [<options>] <path> [<commit-ish>]"),
-	N_("git worktree list [<options>]"),
-	N_("git worktree lock [<options>] <path>"),
-	N_("git worktree move <worktree> <new-path>"),
-	N_("git worktree prune [<options>]"),
-	N_("git worktree remove [<options>] <worktree>"),
-	N_("git worktree repair [<path>...]"),
-	N_("git worktree unlock <worktree>"),
+#define BUILTIN_WORKTREE_ADD_USAGE \
+	N_("git worktree add [<options>] <path> [<commit-ish>]")
+#define BUILTIN_WORKTREE_LIST_USAGE \
+	N_("git worktree list [<options>]")
+#define BUILTIN_WORKTREE_LOCK_USAGE \
+	N_("git worktree lock [<options>] <path>")
+#define BUILTIN_WORKTREE_MOVE_USAGE \
+	N_("git worktree move <worktree> <new-path>")
+#define BUILTIN_WORKTREE_PRUNE_USAGE \
+	N_("git worktree prune [<options>]")
+#define BUILTIN_WORKTREE_REMOVE_USAGE \
+	N_("git worktree remove [<options>] <worktree>")
+#define BUILTIN_WORKTREE_REPAIR_USAGE \
+	N_("git worktree repair [<path>...]")
+#define BUILTIN_WORKTREE_UNLOCK_USAGE \
+	N_("git worktree unlock <worktree>")
+
+static const char * const git_worktree_usage[] = {
+	BUILTIN_WORKTREE_ADD_USAGE,
+	BUILTIN_WORKTREE_LIST_USAGE,
+	BUILTIN_WORKTREE_LOCK_USAGE,
+	BUILTIN_WORKTREE_MOVE_USAGE,
+	BUILTIN_WORKTREE_PRUNE_USAGE,
+	BUILTIN_WORKTREE_REMOVE_USAGE,
+	BUILTIN_WORKTREE_REPAIR_USAGE,
+	BUILTIN_WORKTREE_UNLOCK_USAGE,
+	NULL
+};
+
+static const char * const git_worktree_add_usage[] = {
+	BUILTIN_WORKTREE_ADD_USAGE,
+	NULL,
+};
+
+static const char * const git_worktree_list_usage[] = {
+	BUILTIN_WORKTREE_LIST_USAGE,
+	NULL
+};
+
+static const char * const git_worktree_lock_usage[] = {
+	BUILTIN_WORKTREE_LOCK_USAGE,
+	NULL
+};
+
+static const char * const git_worktree_move_usage[] = {
+	BUILTIN_WORKTREE_MOVE_USAGE,
+	NULL
+};
+
+static const char * const git_worktree_prune_usage[] = {
+	BUILTIN_WORKTREE_PRUNE_USAGE,
+	NULL
+};
+
+static const char * const git_worktree_remove_usage[] = {
+	BUILTIN_WORKTREE_REMOVE_USAGE,
+	NULL
+};
+
+static const char * const git_worktree_repair_usage[] = {
+	BUILTIN_WORKTREE_REPAIR_USAGE,
+	NULL
+};
+
+static const char * const git_worktree_unlock_usage[] = {
+	BUILTIN_WORKTREE_UNLOCK_USAGE,
 	NULL
 };
 
@@ -153,9 +210,10 @@ static int prune(int ac, const char **av, const char *prefix)
 	};
 
 	expire = TIME_MAX;
-	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	ac = parse_options(ac, av, prefix, options, git_worktree_prune_usage,
+			   0);
 	if (ac)
-		usage_with_options(worktree_usage, options);
+		usage_with_options(git_worktree_prune_usage, options);
 	prune_worktrees();
 	return 0;
 }
@@ -573,7 +631,7 @@ static int add(int ac, const char **av, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.checkout = 1;
-	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	ac = parse_options(ac, av, prefix, options, git_worktree_add_usage, 0);
 	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
 		die(_("options '%s', '%s', and '%s' cannot be used together"), "-b", "-B", "--detach");
 	if (lock_reason && !keep_locked)
@@ -584,7 +642,7 @@ static int add(int ac, const char **av, const char *prefix)
 		opts.keep_locked = _("added with --lock");
 
 	if (ac < 1 || ac > 2)
-		usage_with_options(worktree_usage, options);
+		usage_with_options(git_worktree_add_usage, options);
 
 	path = prefix_filename(prefix, av[0]);
 	branch = ac < 2 ? "HEAD" : av[1];
@@ -772,9 +830,9 @@ static int list(int ac, const char **av, const char *prefix)
 	};
 
 	expire = TIME_MAX;
-	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	ac = parse_options(ac, av, prefix, options, git_worktree_list_usage, 0);
 	if (ac)
-		usage_with_options(worktree_usage, options);
+		usage_with_options(git_worktree_list_usage, options);
 	else if (verbose && porcelain)
 		die(_("options '%s' and '%s' cannot be used together"), "--verbose", "--porcelain");
 	else if (!line_terminator && !porcelain)
@@ -811,9 +869,9 @@ static int lock_worktree(int ac, const char **av, const char *prefix)
 	};
 	struct worktree **worktrees, *wt;
 
-	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	ac = parse_options(ac, av, prefix, options, git_worktree_lock_usage, 0);
 	if (ac != 1)
-		usage_with_options(worktree_usage, options);
+		usage_with_options(git_worktree_lock_usage, options);
 
 	worktrees = get_worktrees();
 	wt = find_worktree(worktrees, prefix, av[0]);
@@ -844,9 +902,9 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
 	struct worktree **worktrees, *wt;
 	int ret;
 
-	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	ac = parse_options(ac, av, prefix, options, git_worktree_unlock_usage, 0);
 	if (ac != 1)
-		usage_with_options(worktree_usage, options);
+		usage_with_options(git_worktree_unlock_usage, options);
 
 	worktrees = get_worktrees();
 	wt = find_worktree(worktrees, prefix, av[0]);
@@ -914,9 +972,10 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	const char *reason = NULL;
 	char *path;
 
-	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	ac = parse_options(ac, av, prefix, options, git_worktree_move_usage,
+			   0);
 	if (ac != 2)
-		usage_with_options(worktree_usage, options);
+		usage_with_options(git_worktree_move_usage, options);
 
 	path = prefix_filename(prefix, av[1]);
 	strbuf_addstr(&dst, path);
@@ -1042,9 +1101,9 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 	const char *reason = NULL;
 	int ret = 0;
 
-	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	ac = parse_options(ac, av, prefix, options, git_worktree_remove_usage, 0);
 	if (ac != 1)
-		usage_with_options(worktree_usage, options);
+		usage_with_options(git_worktree_remove_usage, options);
 
 	worktrees = get_worktrees();
 	wt = find_worktree(worktrees, prefix, av[0]);
@@ -1102,7 +1161,7 @@ static int repair(int ac, const char **av, const char *prefix)
 	};
 	int rc = 0;
 
-	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	ac = parse_options(ac, av, prefix, options, git_worktree_repair_usage, 0);
 	p = ac > 0 ? av : self;
 	for (; *p; p++)
 		repair_worktree_at_path(*p, report_repair, &rc);
@@ -1130,6 +1189,6 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 	if (!prefix)
 		prefix = "";
 
-	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	ac = parse_options(ac, av, prefix, options, git_worktree_usage, 0);
 	return fn(ac, av, prefix);
 }
-- 
2.38.0.rc2.935.g6b421ae1592

