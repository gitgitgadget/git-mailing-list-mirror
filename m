Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BDAC433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 12:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbiGYMkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 08:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiGYMjm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 08:39:42 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DBE1AD9A
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:32 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id u12so8717357edd.5
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47i6Q9+LRRPh3yFCFFvf2r3QpQBokpERZvxDL4K4L5s=;
        b=N7e/nPw1tQJa9WONaF5pCUH/wjkO8OJQMbvxM6rwaxDdRYDzUHzZg1chhY8YWeMSKU
         yNBsnFsJoRgqD/Y2FqYywbBVy5VmLpUe48uFz+ncDKWcD2d2vsOiT/bcC2iVMc8cWc8f
         79yaOYiKo4M8E5dMFH2bliKMl9F3gwGdo3O9tAapUaG7yBsAqjV21nkl7Di1yi+eoRQA
         0wfpI3KYDGbmAFlsgRourVLXUvCf9SAioeHHGEUUCCg4KM4RdufTQ0Uhn1mwXgkchbGe
         6+ZOCIktyW/iejU+8UGQf+oWJOjKpaL1v0viD5yTVHlW9HIf0yej0OsvCnTjQZfS5uGo
         zAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47i6Q9+LRRPh3yFCFFvf2r3QpQBokpERZvxDL4K4L5s=;
        b=D+qWere/+QbZ5qMLi1CYaIoi/OJBxTp/ks+ppf8lyzy+Z37YMjLLSQIb/fQTVD/okC
         wWiQaxC/K13W/5lOJaUQ6kKM765nkTPcQd3qdMyxn1gCGjuBNSlRFRCm40mkDyxmjFNf
         Fe42k3auA8vOMdSRDNVKM7aGZqnEXfSy2Iu6xbBvR+v/WfWWx4/OVG3vQl3a1Rhj/Db4
         0VQeFSm0TcPL+6iQ3yDq0Dl1IcoDNnsKT4YDAJSDJsNClKh3f+yFoCuPZEQ0xt+D7mYT
         DIl9h3iEUd1zxz8U1/SNID9n+A2DOb4Ua+PF12Q5vsGByGyD/2/NzcQfxRMx+7lEcOZL
         vN5A==
X-Gm-Message-State: AJIora/1sYT0O0VJX/tbXHh1NJuoxYt9pBInMe+9jm0Ec31r/n9yA+Lp
        Ytme+nWockcY+G2yJKeifh5YCFv8ujw=
X-Google-Smtp-Source: AGRyM1vzygk3cGHF46KXMi6ohVGED5tSsMySMEYz8f8Pb8VZf873KMrEFDPbCJk5ogwekKyfuTa/gQ==
X-Received: by 2002:aa7:c618:0:b0:43b:d489:f452 with SMTP id h24-20020aa7c618000000b0043bd489f452mr13091969edq.145.1658752771247;
        Mon, 25 Jul 2022 05:39:31 -0700 (PDT)
Received: from localhost (94-21-23-94.pool.digikabel.hu. [94.21.23.94])
        by smtp.gmail.com with ESMTPSA id b3-20020aa7d483000000b0043ad162b5e3sm7022695edr.18.2022.07.25.05.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:39:30 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 18/20] builtin/sparse-checkout.c: let parse-options parse subcommands
Date:   Mon, 25 Jul 2022 14:38:55 +0200
Message-Id: <20220725123857.2773963-19-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.1.633.g6a0fa73e39
In-Reply-To: <20220725123857.2773963-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git sparse-checkout' parses its subcommands with a couple of if
statements.  parse-options has just learned to parse subcommands, so
let's use that facility instead, with the benefits of shorter code,
handling missing or unknown subcommands, and listing subcommands for
Bash completion.

Note that some of the functions implementing each subcommand only
accept the 'argc' and '**argv' parameters, so add a (unused) '*prefix'
parameter to make them match the type expected by parse-options, and
thus avoid casting function pointers.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/sparse-checkout.c | 44 ++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index a5e4b95a9d..7b39a150a9 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -48,7 +48,7 @@ static char const * const builtin_sparse_checkout_list_usage[] = {
 	NULL
 };
 
-static int sparse_checkout_list(int argc, const char **argv)
+static int sparse_checkout_list(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_sparse_checkout_list_options[] = {
 		OPT_END(),
@@ -431,7 +431,7 @@ static struct sparse_checkout_init_opts {
 	int sparse_index;
 } init_opts;
 
-static int sparse_checkout_init(int argc, const char **argv)
+static int sparse_checkout_init(int argc, const char **argv, const char *prefix)
 {
 	struct pattern_list pl;
 	char *sparse_filename;
@@ -843,7 +843,8 @@ static struct sparse_checkout_reapply_opts {
 	int sparse_index;
 } reapply_opts;
 
-static int sparse_checkout_reapply(int argc, const char **argv)
+static int sparse_checkout_reapply(int argc, const char **argv,
+				   const char *prefix)
 {
 	static struct option builtin_sparse_checkout_reapply_options[] = {
 		OPT_BOOL(0, "cone", &reapply_opts.cone_mode,
@@ -876,7 +877,8 @@ static char const * const builtin_sparse_checkout_disable_usage[] = {
 	NULL
 };
 
-static int sparse_checkout_disable(int argc, const char **argv)
+static int sparse_checkout_disable(int argc, const char **argv,
+				   const char *prefix)
 {
 	static struct option builtin_sparse_checkout_disable_options[] = {
 		OPT_END(),
@@ -922,39 +924,25 @@ static int sparse_checkout_disable(int argc, const char **argv)
 
 int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 {
-	static struct option builtin_sparse_checkout_options[] = {
+	parse_opt_subcommand_fn *fn = NULL;
+	struct option builtin_sparse_checkout_options[] = {
+		OPT_SUBCOMMAND("list", &fn, sparse_checkout_list),
+		OPT_SUBCOMMAND("init", &fn, sparse_checkout_init),
+		OPT_SUBCOMMAND("set", &fn, sparse_checkout_set),
+		OPT_SUBCOMMAND("add", &fn, sparse_checkout_add),
+		OPT_SUBCOMMAND("reapply", &fn, sparse_checkout_reapply),
+		OPT_SUBCOMMAND("disable", &fn, sparse_checkout_disable),
 		OPT_END(),
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_sparse_checkout_usage,
-				   builtin_sparse_checkout_options);
-
 	argc = parse_options(argc, argv, prefix,
 			     builtin_sparse_checkout_options,
-			     builtin_sparse_checkout_usage,
-			     PARSE_OPT_STOP_AT_NON_OPTION);
+			     builtin_sparse_checkout_usage, 0);
 
 	git_config(git_default_config, NULL);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
-	if (argc > 0) {
-		if (!strcmp(argv[0], "list"))
-			return sparse_checkout_list(argc, argv);
-		if (!strcmp(argv[0], "init"))
-			return sparse_checkout_init(argc, argv);
-		if (!strcmp(argv[0], "set"))
-			return sparse_checkout_set(argc, argv, prefix);
-		if (!strcmp(argv[0], "add"))
-			return sparse_checkout_add(argc, argv, prefix);
-		if (!strcmp(argv[0], "reapply"))
-			return sparse_checkout_reapply(argc, argv);
-		if (!strcmp(argv[0], "disable"))
-			return sparse_checkout_disable(argc, argv);
-	}
-
-	usage_with_options(builtin_sparse_checkout_usage,
-			   builtin_sparse_checkout_options);
+	return fn(argc, argv, prefix);
 }
-- 
2.37.1.633.g6a0fa73e39

