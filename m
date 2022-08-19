Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3362EC32792
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 16:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353062AbiHSQc4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353111AbiHSQai (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 12:30:38 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E82111CF23
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:57 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id tl27so9659646ejc.1
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=tC04UvSMZZW0ww1Rjm/+lEDPWI1OEcwwEWpncdJFpB4=;
        b=h05cx+azluFcc3i2wuGbEgh4FJM3xAD5bcO/ulneL1ZOCEfEp4seis7sANi7DMP1c4
         /alm9pa3Z1QhuaDu41c/tnMtwObmODqcejm3arqxGAh8Np766XhgDzhgnrbt5LOm5hUy
         3VbhauHwv6DTahfuz3l3J2I4r/e8Jsm2IUnLQ6kdn+7VfP7Lk29qB5ivWJdZ466aZPx/
         3Wv0LRQDVO8Ktf2T47FHbApjsPp9r7rwMS/FxjE27QBiXnhSlBd0RX6XvQfqlWkycpWr
         BvqREbeozCpwx66Ze1unKvI3mwmwYipuEbgAAB22MVJ3WXe1Onxn5qRJ9u0YnYueMR/M
         8YGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=tC04UvSMZZW0ww1Rjm/+lEDPWI1OEcwwEWpncdJFpB4=;
        b=vLD+5ClHfJ7lbtvJAUuajJh8pHv2KuHru7HJ0HxcBaFdqiJ5hcLbyTXo71O2I/eNeA
         SRDfXfCBe4YX/TJ5MWTkbE6DB7op5b8TBR4bSeKKH4CAVtWAHhva2POfIFSTDiMNUt7f
         SeH61fSCS14qFEXfy3HXwPQLb1kS7wi7VkrSm2RdPPfqJUgbM+EmjXOc26pWW5ccmqcn
         tGwJ1E29qSobEkQhp5jskM4PHgeeplNMFRr9CJ1+IjnbgkQZpGcQ/FuDOoyOv5CZNcuz
         lF8ab8LfcksA+nVujr98z1h0ufh3bJJimNSmb3aT6V+jKxJ/OsePricE3nN4oVejt6kV
         z1Dg==
X-Gm-Message-State: ACgBeo2Ak2cEzdOZADKnP+/on2+JecmMPoAM9l4T+mzhG4Mt7nPEKIJv
        PPaAC26Bn2siAqqXMOqrFO/7g45249c=
X-Google-Smtp-Source: AA6agR4oYQ1rhdIT9JQn4YWiG4Fnw86hQj57NHgojk92ROEG8qVEohcsCAAgYK90Ezmk1fWE91B+fA==
X-Received: by 2002:a17:907:c06:b0:701:eb60:ded with SMTP id ga6-20020a1709070c0600b00701eb600dedmr5488596ejc.178.1660925092976;
        Fri, 19 Aug 2022 09:04:52 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090676d200b0073d60922edfsm81029ejn.102.2022.08.19.09.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 09:04:52 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 11/20] builtin/commit-graph.c: let parse-options parse subcommands
Date:   Fri, 19 Aug 2022 18:04:02 +0200
Message-Id: <20220819160411.1791200-12-szeder.dev@gmail.com>
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

'git commit-graph' parses its subcommands with an if-else if
statement.  parse-options has just learned to parse subcommands, so
let's use that facility instead, with the benefits of shorter code,
handling missing or unknown subcommands, and listing subcommands for
Bash completion.

Note that the functions implementing each subcommand only accept the
'argc' and '**argv' parameters, so add a (unused) '*prefix' parameter
to make them match the type expected by parse-options, and thus avoid
casting function pointers.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/commit-graph.c  | 30 +++++++++++++-----------------
 t/t5318-commit-graph.sh |  4 ++--
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 51c4040ea6..1eb5492cbd 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -58,7 +58,7 @@ static struct option *add_common_options(struct option *to)
 	return parse_options_concat(common_opts, to);
 }
 
-static int graph_verify(int argc, const char **argv)
+static int graph_verify(int argc, const char **argv, const char *prefix)
 {
 	struct commit_graph *graph = NULL;
 	struct object_directory *odb = NULL;
@@ -190,7 +190,7 @@ static int git_commit_graph_write_config(const char *var, const char *value,
 	return 0;
 }
 
-static int graph_write(int argc, const char **argv)
+static int graph_write(int argc, const char **argv, const char *prefix)
 {
 	struct string_list pack_indexes = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
@@ -307,26 +307,22 @@ static int graph_write(int argc, const char **argv)
 
 int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 {
-	struct option *builtin_commit_graph_options = common_opts;
+	parse_opt_subcommand_fn *fn = NULL;
+	struct option builtin_commit_graph_options[] = {
+		OPT_SUBCOMMAND("verify", &fn, graph_verify),
+		OPT_SUBCOMMAND("write", &fn, graph_write),
+		OPT_END(),
+	};
+	struct option *options = parse_options_concat(builtin_commit_graph_options, common_opts);
 
 	git_config(git_default_config, NULL);
-	argc = parse_options(argc, argv, prefix,
-			     builtin_commit_graph_options,
-			     builtin_commit_graph_usage,
-			     PARSE_OPT_STOP_AT_NON_OPTION);
-	if (!argc)
-		goto usage;
 
 	read_replace_refs = 0;
 	save_commit_buffer = 0;
 
-	if (!strcmp(argv[0], "verify"))
-		return graph_verify(argc, argv);
-	else if (argc && !strcmp(argv[0], "write"))
-		return graph_write(argc, argv);
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_commit_graph_usage, 0);
+	FREE_AND_NULL(options);
 
-	error(_("unrecognized subcommand: %s"), argv[0]);
-usage:
-	usage_with_options(builtin_commit_graph_usage,
-			   builtin_commit_graph_options);
+	return fn(argc, argv, prefix);
 }
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index be0b5641ff..7e040eb1ed 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -12,12 +12,12 @@ test_expect_success 'usage' '
 
 test_expect_success 'usage shown without sub-command' '
 	test_expect_code 129 git commit-graph 2>err &&
-	! grep error: err
+	grep usage: err
 '
 
 test_expect_success 'usage shown with an error on unknown sub-command' '
 	cat >expect <<-\EOF &&
-	error: unrecognized subcommand: unknown
+	error: unknown subcommand: `unknown'\''
 	EOF
 	test_expect_code 129 git commit-graph unknown 2>stderr &&
 	grep error stderr >actual &&
-- 
2.37.2.817.g36f84ce71d

