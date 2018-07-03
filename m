Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CB521F516
	for <e@80x24.org>; Tue,  3 Jul 2018 03:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753837AbeGCD6j (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 23:58:39 -0400
Received: from mail-yb0-f173.google.com ([209.85.213.173]:46316 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753428AbeGCD6i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 23:58:38 -0400
Received: by mail-yb0-f173.google.com with SMTP id s14-v6so200941ybp.13
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 20:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uEERrNrjmNuoIxQFevCyjYzLNw/SDZFZGmO9O0YaPco=;
        b=SOu4P6szugwMqUkJelsYnYT2iNRb8krKFhKFLKfE+9ZSJBGnIzKpJXxhT50LOj5kbI
         4SYDiJ5OHJdNPBc0oV2XD4wmXaelRHLyNTR08u6L2ENGnqEmH0zUqi9NWL3wmbjgPNaR
         BfSW3v/yuugd1bBLQ4kyO0RlvOmcGEXdhWD8A+pC3hMQ6Fq6np8L2ZammU9Qd/uidSWf
         XcNaCceG8GEfxBTHuhJp6/vHs4KsPkI3i7ijseB7FFeLGy6xVwPU9jhl9vGdNz+0grdw
         HdomBTt3CZsBxECqc4Afo8TpaLe2OG1avq+2CEG30Rnr9Aj15CSU3DNpjx+Pf7hn/t1U
         IgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uEERrNrjmNuoIxQFevCyjYzLNw/SDZFZGmO9O0YaPco=;
        b=C6h2mXinNEDPVdHqm8j969MR/86EvZ+AvVebKSFEo2sdS+xWYIubr2aTdW8E4G2ioc
         /Vhb2Jt2zDZVJW25mKGQX2i3TC7InDU8C9xoLYN3wvjjJ3jAbbeKOL4BGm4B7avML8PZ
         2JIjwNyw+c1MmpXyRUmpBtACdGiD6crOEw59+TTUb9+8XjjrR7Ma0AcFF4sok0Gncnem
         4URmmyMOKhzDqtwEGDeXtDAJzfXmqUG35P0hzl1C7ZQWldyXriyTOy5ft8DXfyCiLmdz
         InjJdo8yxRwWBYSDh0ffuhb3FKgDRv9q0vbuqs9N3SIygqPeTePL1EcOLjWNRP7f3unU
         26sQ==
X-Gm-Message-State: APt69E0TiBv5c+tALNDRGDAuLWEZO6mE4GzHn7hyH+Sdt1b34861LJf7
        lxuzkuG/dqkC3t4pouJfm/fscTiV
X-Google-Smtp-Source: AAOMgpdMIUX4V+8LRqbzOyJTqKq2CzvAHDAoyrCMVAZ1xfY9LFy/kOHpbrrhn65zxDHKxEU0iEagZg==
X-Received: by 2002:a25:ae5b:: with SMTP id g27-v6mr3999216ybe.351.1530590316303;
        Mon, 02 Jul 2018 20:58:36 -0700 (PDT)
Received: from localhost.localdomain ([70.63.112.210])
        by smtp.gmail.com with ESMTPSA id q131-v6sm97262ywq.8.2018.07.02.20.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 20:58:35 -0700 (PDT)
From:   Joshua Nelson <jyn514@gmail.com>
To:     git@vger.kernel.org
Cc:     Joshua Nelson <jyn514@gmail.com>
Subject: [PATCH 1/3] ls-tree: make <tree-ish> optional
Date:   Mon,  2 Jul 2018 23:58:00 -0400
Message-Id: <20180703035802.24060-1-jyn514@gmail.com>
X-Mailer: git-send-email 2.18.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

use syntax similar to `git-checkout` to make <tree-ish> optional for
`ls-tree`. if <tree-ish> is omitted, default to HEAD. infer arguments as
follows:

1. if args start with --
	assume <tree-ish> to be HEAD
2. if exactly one arg precedes --, treat the argument as <tree-ish>
3. if more than one arg precedes --, exit with an error
4. if -- is not in args
	a) if args[0] is a valid <tree-ish> object, treat is as such
	b) else, assume <tree-ish> to be HEAD

in all cases, every argument besides <tree-ish> is treated as a <path>
---
 builtin/ls-tree.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git builtin/ls-tree.c builtin/ls-tree.c
index 409da4e83..14102b052 100644
--- builtin/ls-tree.c
+++ builtin/ls-tree.c
@@ -153,7 +153,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		chomp_prefix = strlen(prefix);
 
 	argc = parse_options(argc, argv, prefix, ls_tree_options,
-			     ls_tree_usage, 0);
+			     ls_tree_usage, PARSE_OPT_KEEP_DASHDASH);
 	if (full_tree) {
 		ls_tree_prefix = prefix = NULL;
 		chomp_prefix = 0;
@@ -163,10 +163,39 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	    ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
 		ls_options |= LS_SHOW_TREES;
 
+	const char *object;
+	short initialized = 0;
 	if (argc < 1)
-		usage_with_options(ls_tree_usage, ls_tree_options);
-	if (get_oid(argv[0], &oid))
-		die("Not a valid object name %s", argv[0]);
+		object = "HEAD";
+	else {
+		/* taken from checkout.c;
+		 * we have a simpler case because we never create a branch */
+		short dash_dash_pos = -1, i = 0;
+		for (; i < argc; i++) {
+			if (!strcmp(argv[i], "--")) {
+				dash_dash_pos = i;
+				break;
+			}
+		}
+		if (dash_dash_pos == 0) {
+			object = "HEAD";
+			argv++, argc++;
+		} else if (dash_dash_pos == 1) {
+			object = argv[0];
+			argv += 2, argc += 2;
+		} else if (dash_dash_pos >= 2)
+			die(_("only one reference expected, %d given."), dash_dash_pos);
+		else if (get_oid(argv[0], &oid)) // not a valid object
+			object = "HEAD";
+		else {
+			argv++, argc++;
+			initialized = 1;
+		}
+	}
+
+	if (!initialized) // if we've already run get_oid, don't run it again
+		if (get_oid(object, &oid))
+			die("Not a valid object name %s", object);
 
 	/*
 	 * show_recursive() rolls its own matching code and is
@@ -177,7 +206,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC &
 				  ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
 		       PATHSPEC_PREFER_CWD,
-		       prefix, argv + 1);
+		       prefix, argv);
 	for (i = 0; i < pathspec.nr; i++)
 		pathspec.items[i].nowildcard_len = pathspec.items[i].len;
 	pathspec.has_wildcard = 0;
-- 
2.18.GIT

