Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F88C32793
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 16:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353069AbiHSQc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353202AbiHSQbD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 12:31:03 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DDD10B50E
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:05:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id w19so9633498ejc.7
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Yb2mxz4Owu+fLvWPbpa7ct/Z1EX6Be87e1iqXnJrX7c=;
        b=Mt6Dw0VqkE/G6EBOx9ejBeCWaqi65f15eygiEw+2kKVh/lrmdZ4+z58E49LUUmtenc
         Mh544FvU7Yn+CjdY/Zj2UFE/cmmnx2ibcZ3kfnfHD+Ymau7t5hQZn9DHKIQDT2pVWRXU
         VuNOK6jYX11ZF7TSsHKNLHCusWXlbXGqiqVm72Vo3X5raQ7Yu5Ir4/BXYO0rDVnuUP1r
         mNGMIUZW4rkGe7FRvtlGbh/OI2LNvsHhqNWIrVhuvJGFa5xzRny/zM2ZDhoH0jiOQJLh
         VlcSsQku0ZO0DXhuIDxkY4at28j99OFCZ5AN5ZXRmXZw58sWLiv2O/PHlna7cY1pm8np
         9LYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Yb2mxz4Owu+fLvWPbpa7ct/Z1EX6Be87e1iqXnJrX7c=;
        b=CNHogtQCgAxXdPzQBzO67M/N+7fq1/oSq27UAHTJ0PK/PIlSctqzszH63y3t6rPm37
         Q7RMlNPMwNWhDAYLippPmHpj8h+5+sAyqbAXVBUrEEOZjkSQArdci+i10M9txlZ6r600
         dzkMhsYlq3+zHQXYNn49JZKNlBqsAguFDjLmN1Ta7e0DMm7XUrki4TVTQGA3FISW3wio
         qyJIvFqqoO2W3DaZo6k2Otg1t7iXFQRpaC/kmxCk+rcFq0qUm/4dc0nZozur9QZohEhY
         YKUDTnWKlAAnMPLXt4GKvR3Gu90CmgUu/QwlbklQ2Z/hotrJLaAVNaEfyIdgq9osJQYS
         djYA==
X-Gm-Message-State: ACgBeo1OBJQr1aEYhhwEGIQus19pHIvu7UE0qVuM2qZPBCb7/ePLoY6n
        Gqizb8GLNRpCMKHvR7tcojZsHu7/n/Y=
X-Google-Smtp-Source: AA6agR53VzwHOxy72XtMAfL1fx3Vz9QySbxrU/jTFDZSGRxG76urY5UEz7lWX3dUA4CYfP+0IOibeg==
X-Received: by 2002:a17:907:7f26:b0:73c:b69a:c7c5 with SMTP id qf38-20020a1709077f2600b0073cb69ac7c5mr3017643ejc.165.1660925105423;
        Fri, 19 Aug 2022 09:05:05 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id ju9-20020a17090798a900b0073d5a8a2bfcsm369089ejc.221.2022.08.19.09.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 09:05:05 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 18/20] builtin/sparse-checkout.c: let parse-options parse subcommands
Date:   Fri, 19 Aug 2022 18:04:09 +0200
Message-Id: <20220819160411.1791200-19-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.2.817.g36f84ce71d
In-Reply-To: <20220819160411.1791200-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
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
2.37.2.817.g36f84ce71d

