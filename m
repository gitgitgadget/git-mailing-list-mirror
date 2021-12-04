Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2AEC433FE
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 20:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377640AbhLDUDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 15:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355654AbhLDUDu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 15:03:50 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9679C061751
        for <git@vger.kernel.org>; Sat,  4 Dec 2021 12:00:24 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d24so13481828wra.0
        for <git@vger.kernel.org>; Sat, 04 Dec 2021 12:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u7MRwyLqmsl9T7SYIB6ENiicnNlbMDZ1Hi2KcflJUN8=;
        b=E7PFYgo7q9evz8E6tXqOMruXyMc5REWJIlPM8WVweExtYc8vl6K5RSdq7dZd6is6MK
         5nuk+sgMGuLorC7O1lqhk5eqw5DFbKhNwJou9ZHEiTAxjmCDxVwI+f6yNV9lAN80rcr0
         7elPwAla3IS2vCwskZx9WyA3TDVwyQ31K/o9u9LtvOuf/Men3wI7NXYyCoHVfs0jYteJ
         vCdCpXieJX022+uSneOiqTk7FSsbTBWfvx3UsYx1lEiVNRtBBVFZM332Guae8wB66lMW
         VAlP6TvjbV8NHDp/WcTWAtgPP1kgG3sHLzXWrwC5wNCUT8D0K8yXX05K9TcZsJDLUpOS
         m0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u7MRwyLqmsl9T7SYIB6ENiicnNlbMDZ1Hi2KcflJUN8=;
        b=YRcaW+XQiltnHoukG+FEX0RJo1MjyZ1mEH9yDwLBVL0bqDbTENkqv2puxk8FdIUYon
         8rWfOdDHF7n6nwtoYW2jH8p+w9laDr+XFWG4pMoJAd9JkEM+F2QuJjer3MWASCmDp5Gb
         XoRD/IOHVTxb2yPb5XkZl9zurl7n2uphi1+BY192kLmZy18oUQVVlfIfrTWNtHFP2ueu
         VPLjGrFR1Bk49UX2E9aj0ykG7ydQPmj43ZU9FyqaMGu8RaFi79tnc8/MtCgqkLWnQVff
         WAhUH55NWvhwA+3if2eF/OvDDB4DvaTeuxqHFDTvmng+DBX58Fr7jvGglBVsmmq5VAZc
         +YLg==
X-Gm-Message-State: AOAM53218LINziGe/XddJJAT751Vytm2hXfkLjWcuu4LFLezV5rQUZ0y
        9jUstQRu/dIXTYuLuWmfyOD15+Qxz+A=
X-Google-Smtp-Source: ABdhPJxLnDRvL90+p/e1W9TeBZo/Bmqx8UqqxIbu/IhoH96rovAOf+hPtrPbWBSwWPl5e014NPOcNQ==
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr29555952wro.484.1638648023205;
        Sat, 04 Dec 2021 12:00:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n32sm6176042wms.42.2021.12.04.12.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 12:00:22 -0800 (PST)
Message-Id: <6f7de8f54127aa08b24000cc1aea39b352913fb2.1638648020.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Dec 2021 20:00:16 +0000
Subject: [PATCH 2/6] sparse-checkout: break apart functions for
 sparse_checkout_(set|add)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

sparse_checkout_set() was reused by sparse_checkout_add() with the only
difference being a single parameter being passed to that function.
However, we would like sparse_checkout_set() to do the same work that
sparse_checkout_init() does if sparse checkouts are not already enabled.
To facilitate this transition, give each mode their own copy of the
function.  This does not introduce any behavioral changes; that will
come in a subsequent patch.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c | 54 +++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 8612328e5dd..e252b82136e 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -515,15 +515,6 @@ static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
 	insert_recursive_pattern(pl, line);
 }
 
-static char const * const builtin_sparse_checkout_set_usage[] = {
-	N_("git sparse-checkout (set|add) (--stdin | <patterns>)"),
-	NULL
-};
-
-static struct sparse_checkout_set_opts {
-	int use_stdin;
-} set_opts;
-
 static void add_patterns_from_input(struct pattern_list *pl,
 				    int argc, const char **argv,
 				    int use_stdin)
@@ -663,8 +654,43 @@ static int modify_pattern_list(int argc, const char **argv, int use_stdin,
 	return result;
 }
 
-static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
-			       enum modify_type m)
+static char const * const builtin_sparse_checkout_add_usage[] = {
+	N_("git sparse-checkout add (--stdin | <patterns>)"),
+	NULL
+};
+
+static struct sparse_checkout_add_opts {
+	int use_stdin;
+} add_opts;
+
+static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
+{
+	static struct option builtin_sparse_checkout_add_options[] = {
+		OPT_BOOL(0, "stdin", &add_opts.use_stdin,
+			 N_("read patterns from standard in")),
+		OPT_END(),
+	};
+
+	repo_read_index(the_repository);
+
+	argc = parse_options(argc, argv, prefix,
+			     builtin_sparse_checkout_add_options,
+			     builtin_sparse_checkout_add_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+
+	return modify_pattern_list(argc, argv, add_opts.use_stdin, ADD);
+}
+
+static char const * const builtin_sparse_checkout_set_usage[] = {
+	N_("git sparse-checkout set (--stdin | <patterns>)"),
+	NULL
+};
+
+static struct sparse_checkout_set_opts {
+	int use_stdin;
+} set_opts;
+
+static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_sparse_checkout_set_options[] = {
 		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
@@ -679,7 +705,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
 			     builtin_sparse_checkout_set_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
-	return modify_pattern_list(argc, argv, set_opts.use_stdin, m);
+	return modify_pattern_list(argc, argv, set_opts.use_stdin, REPLACE);
 }
 
 static char const * const builtin_sparse_checkout_reapply_usage[] = {
@@ -762,9 +788,9 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 		if (!strcmp(argv[0], "init"))
 			return sparse_checkout_init(argc, argv);
 		if (!strcmp(argv[0], "set"))
-			return sparse_checkout_set(argc, argv, prefix, REPLACE);
+			return sparse_checkout_set(argc, argv, prefix);
 		if (!strcmp(argv[0], "add"))
-			return sparse_checkout_set(argc, argv, prefix, ADD);
+			return sparse_checkout_add(argc, argv, prefix);
 		if (!strcmp(argv[0], "reapply"))
 			return sparse_checkout_reapply(argc, argv);
 		if (!strcmp(argv[0], "disable"))
-- 
gitgitgadget

