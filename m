Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542CBC43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 12:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbiGYMjq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 08:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbiGYMjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 08:39:25 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430E51ADBA
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:22 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id j22so20338473ejs.2
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PpXfuqw2xU4RxEyr4KTWKDlUeB5iSBUEWZ5aCp/LZAM=;
        b=IkW7B+GQZujdIeesrqb/wNBo8+xi4yAb4vvY0oe6UjUHYayLmWbivFp1quR2znEc30
         uqxKIHXDOXZgsHnTolnEp4K7xlZXLNGNQrnhwh3bhXkHeCPGm40BmL3DouEN2xxUY0fj
         is3Xzte37a7iAJgOc1Z6qHdJgB6aQj3VM+aJb1V7znMpLQjdPOEUiuTm9Ycu9fuGoAyV
         rYy2HRbEWWlb1AwEK5////EY14oCIOi+P2ERdGyBvIHXsGIWJ4g5YL8NwH/VROTJSXqr
         rcx72aYUtEAYpYzcOHLWtnrUxQM47MPp0fsMQnLzbARPwsw1M4gm5ap58o4pSdwXYwP4
         XirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PpXfuqw2xU4RxEyr4KTWKDlUeB5iSBUEWZ5aCp/LZAM=;
        b=mNZ48oXxCMLMO48IMgXxcJ7TUrTtI9e6vj46dHAO9up8DHI4uNF0Vbxu527gaCiyzN
         4SAMB9SG3A5hlMr2GC58hbGNMebzlk0pdvO10YOH/cCRrBvs1gkmssyINSLJbRG+/uaP
         6rtTzm8CZs2GDJIsOBBvPR7JybfFozicDCkW49JqAOhy5F41qRz9E7wRTpex4oYAm/rG
         2cFvsjMkSzGau+RfNYXeXfMeDrOeK8BQqZPd40ddcv2Z0UzZZ+iER5zKu8wliy3tDfil
         +rwSft4ooyobPKGm7YEGDDNvlGrpGwT+Ho+idfZ8dqEMSxgoBhq+eE1ImpYuMl3dmIUz
         JyVw==
X-Gm-Message-State: AJIora86PpGnvdpyHkGziFGjEwtouS4oqzRlvqjLyVELVe7o3CgQ53ow
        ai9yQRujcOuB8zQ8ohbDTvJa14G9X2U=
X-Google-Smtp-Source: AGRyM1t/bH8uRmYNT0pYmPQHqPDV1Czqte+X/OVz3pWohe7q8kn90/+rvuv6BH35IYAI0vTvpyoOQg==
X-Received: by 2002:a17:907:7388:b0:72b:9be1:e32d with SMTP id er8-20020a170907738800b0072b9be1e32dmr9802953ejc.611.1658752760505;
        Mon, 25 Jul 2022 05:39:20 -0700 (PDT)
Received: from localhost (94-21-23-94.pool.digikabel.hu. [94.21.23.94])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709060cca00b0072b2ef2757csm5300275ejh.180.2022.07.25.05.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:39:20 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 11/20] builtin/commit-graph.c: let parse-options parse subcommands
Date:   Mon, 25 Jul 2022 14:38:48 +0200
Message-Id: <20220725123857.2773963-12-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.1.633.g6a0fa73e39
In-Reply-To: <20220725123857.2773963-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
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
index be0b5641ff..e85b36e825 100755
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
+	error: unknown subcommand: unknown
 	EOF
 	test_expect_code 129 git commit-graph unknown 2>stderr &&
 	grep error stderr >actual &&
-- 
2.37.1.633.g6a0fa73e39

