Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01105C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 03:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbhLJD7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 22:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236504AbhLJD7v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 22:59:51 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F35C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 19:56:17 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v11so12872573wrw.10
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 19:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mAOerwPUMrfnXbLVjrNgMJnuirc3MJ3a20wdnsiRbIw=;
        b=VM4MdU7wEdWYkvyQcaaKsRNl1IScSwH/JFm3y4BVx3XRaNBs1ztr0R8CsDrpnPeA2a
         sMdTZn7qkqbJxqMI7R3Xvz9e5gkvZwvnyaK0dYOZpwVNlSM2yNfC0OyV4Poamiox5Q0n
         WBZkMfvOCE0cRX5bbXz7QCJ34dVGiPTjdxRceAAWavoG0xoVl14qLneuaqdAxL7SvKNN
         Y/FaZ8T6wi+vYz7w+fe8ihk/FzRnpeR94bqsqfOXIY/mGZ4no5cORgki2ZaiHPwgpffG
         O2pKHXlBdY9OfS1BACecFVkGmrZzla5lDMDv5Y444tVUHF+fptY4B2xQpquwt8mWbw6+
         RKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mAOerwPUMrfnXbLVjrNgMJnuirc3MJ3a20wdnsiRbIw=;
        b=3rIfn9+5mneusgTOsenW+B+SPmgxxnu2aknsLfNHv3q4k78IQLaaQ6a6nhmStMc+9J
         S04rGhcIzs2rQw3soX3+Kg6r9MaHdH48o3ftn14TJL3/idhhnA48fAu4bha0Q6srWDB4
         LJ1iwB/q7bydWsqr8E7kxRE3kN5U2V/PEZSgAp85tb4uuh2ss1VDqR6r7oFiUPl5rNt2
         NKqRs3VgTkAwdvpIaPbnyXySKh5maz3iV4cSzeKvRq7i11lMNPlGXhJ0IPCO9QANm+7r
         Ji387fR1da5AfLwPNj3G7h9OJ5UpKvUTQDHun5bCXBDIi7nO5pyBHm49avE+hRpyOAnC
         nudw==
X-Gm-Message-State: AOAM532WLaiUzUqhKeAT+VT1J1WcU8EigYMyIuBFT+euvpYaBFMI5tg8
        U5gcA+XjKIxCD8xCIpVn72ZeFtwz/ZU=
X-Google-Smtp-Source: ABdhPJy1tROpelqcLSRMKkNjzPs2/bBkgWI2DbBWmPyAWVZesQlZrNjjyrH2FY/kEiv/iBeRcYbfbQ==
X-Received: by 2002:a5d:6449:: with SMTP id d9mr11256845wrw.332.1639108575780;
        Thu, 09 Dec 2021 19:56:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k13sm1301965wri.6.2021.12.09.19.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 19:56:15 -0800 (PST)
Message-Id: <04cd57592e9331985db2e827459775ed9bc8a22b.1639108573.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
References: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
        <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Dec 2021 03:56:05 +0000
Subject: [PATCH v3 02/10] sparse-checkout: break apart functions for
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

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Reviewed-by: Victoria Dye <vdye@github.com>
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

