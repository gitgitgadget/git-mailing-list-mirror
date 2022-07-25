Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F99C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 12:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbiGYMkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 08:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235226AbiGYMjm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 08:39:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662B51BE91
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id p5so2769631edi.12
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KPlfCqjHAyCWxYltM8W6BtqBbUfsA+ugruZzMMwB1vE=;
        b=hkPT+5sV/cLKvJS2dneNTOYDquMUQghL4u9QFEmjI1RG0XgikzKix06xdyMHIkiz+z
         fmpt5jh1CpGzcKT3PLJ3VtwwjDsReJaTFewGtQcGLq3v46lMvVRMUBe+t7nUMmKEa1ei
         Z1m6/BPPvl4kHbpnMqrjPCcO8vlhv4pB1zNwOFfAIQaYI6RqmVmMiD6c/2wJguevRv/n
         AIfYuUlwejh5wJJCa1+bqF6zhd5m6adjnAcRv2cNEgfmR2w/zDu4pUzYItB6MK8mGL7D
         AEbfV/nbeusHH3AL/10KpQHGUDDTrPcCMWt6fLp3AJ8A1BbjdhYvXmnXrUGb/ggMaJ9S
         Jyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KPlfCqjHAyCWxYltM8W6BtqBbUfsA+ugruZzMMwB1vE=;
        b=afLh4yyoFLUwzFo4xek1/c8qSWTcZME6Ggtn80ImjNOQYZdfblSNMXsInvLzSu2DtL
         pJ9QJz+si2Sv+nvV6nCZ1arBoIdF/OPdz/VgUx1eSq4ZU9ZcRNrkbVDU+piX8gLaDFqV
         eYJDsW4Ho4ZqJJf6ib3oyua5HZpqSJQdcya7mGDGjTiJxi/nkz4UI3tfVEgfOn3GwoZP
         haWl2oVW6+CKmT+XKZ9n7H6fJNWxQ6DH/4K/YPvGXJSO8awPVtz+SntpF0wYMpVLHAf+
         CFe+L5RTD/+y+pjcfmXY1KWb7qKqNZNcPhqiRhxRQTTZKKe0VueF/0niVFsniXHQx5Kl
         3HrQ==
X-Gm-Message-State: AJIora9fI9raVh17dvDZW4NA85VUmiVfdFYg3HVWNHiRhx7ma6iUN0NS
        lJ1qTIbSwqReMoPykv6a1xiXWJ6wx+I=
X-Google-Smtp-Source: AGRyM1t90tarKLiDCx3O2pCWkma/poK7hVyIyQf44eSTCZpSt4cQLHUjuGNQtwJWl4EgsZgktrsOSg==
X-Received: by 2002:a05:6402:2756:b0:43b:fda4:abc6 with SMTP id z22-20020a056402275600b0043bfda4abc6mr5017174edd.274.1658752769827;
        Mon, 25 Jul 2022 05:39:29 -0700 (PDT)
Received: from localhost (94-21-23-94.pool.digikabel.hu. [94.21.23.94])
        by smtp.gmail.com with ESMTPSA id w23-20020a17090649d700b0072b33e91f96sm5334253ejv.190.2022.07.25.05.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:39:29 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 17/20] builtin/remote.c: let parse-options parse subcommands
Date:   Mon, 25 Jul 2022 14:38:54 +0200
Message-Id: <20220725123857.2773963-18-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.1.633.g6a0fa73e39
In-Reply-To: <20220725123857.2773963-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git remote' parses its subcommands with a long list of if-else if
statements.  parse-options has just learned to parse subcommands, so
let's use that facility instead, with the benefits of shorter code,
handling unknown subcommands, and listing subcommands for Bash
completion.  Make sure that the default operation mode doesn't accept
any arguments; and while at it remove the capitalization of the error
message and adjust the test checking it accordingly.

Note that 'git remote' has both 'remove' and 'rm' subcommands, and the
former is preferred [1], so hide the latter for completion.

Note also that the functions implementing each subcommand only accept
the 'argc' and '**argv' parameters, so add a (unused) '*prefix'
parameter to make them match the type expected by parse-options, and
thus avoid casting a bunch of function pointers.

[1] e17dba8fe1 (remote: prefer subcommand name 'remove' to 'rm',
    2012-09-06)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/remote.c  | 70 +++++++++++++++++++++--------------------------
 t/t5505-remote.sh |  2 +-
 2 files changed, 32 insertions(+), 40 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d9b8746cb3..4a6d47c03a 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -150,7 +150,7 @@ static int parse_mirror_opt(const struct option *opt, const char *arg, int not)
 	return 0;
 }
 
-static int add(int argc, const char **argv)
+static int add(int argc, const char **argv, const char *prefix)
 {
 	int fetch = 0, fetch_tags = TAGS_DEFAULT;
 	unsigned mirror = MIRROR_NONE;
@@ -680,7 +680,7 @@ static void handle_push_default(const char* old_name, const char* new_name)
 }
 
 
-static int mv(int argc, const char **argv)
+static int mv(int argc, const char **argv, const char *prefix)
 {
 	int show_progress = isatty(2);
 	struct option options[] = {
@@ -844,7 +844,7 @@ static int mv(int argc, const char **argv)
 	return 0;
 }
 
-static int rm(int argc, const char **argv)
+static int rm(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] = {
 		OPT_END()
@@ -1255,7 +1255,7 @@ static int show_all(void)
 	return result;
 }
 
-static int show(int argc, const char **argv)
+static int show(int argc, const char **argv, const char *prefix)
 {
 	int no_query = 0, result = 0, query_flag = 0;
 	struct option options[] = {
@@ -1358,7 +1358,7 @@ static int show(int argc, const char **argv)
 	return result;
 }
 
-static int set_head(int argc, const char **argv)
+static int set_head(int argc, const char **argv, const char *prefix)
 {
 	int i, opt_a = 0, opt_d = 0, result = 0;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
@@ -1463,7 +1463,7 @@ static int prune_remote(const char *remote, int dry_run)
 	return result;
 }
 
-static int prune(int argc, const char **argv)
+static int prune(int argc, const char **argv, const char *prefix)
 {
 	int dry_run = 0, result = 0;
 	struct option options[] = {
@@ -1492,7 +1492,7 @@ static int get_remote_default(const char *key, const char *value, void *priv)
 	return 0;
 }
 
-static int update(int argc, const char **argv)
+static int update(int argc, const char **argv, const char *prefix)
 {
 	int i, prune = -1;
 	struct option options[] = {
@@ -1575,7 +1575,7 @@ static int set_remote_branches(const char *remotename, const char **branches,
 	return 0;
 }
 
-static int set_branches(int argc, const char **argv)
+static int set_branches(int argc, const char **argv, const char *prefix)
 {
 	int add_mode = 0;
 	struct option options[] = {
@@ -1594,7 +1594,7 @@ static int set_branches(int argc, const char **argv)
 	return set_remote_branches(argv[0], argv + 1, add_mode);
 }
 
-static int get_url(int argc, const char **argv)
+static int get_url(int argc, const char **argv, const char *prefix)
 {
 	int i, push_mode = 0, all_mode = 0;
 	const char *remotename = NULL;
@@ -1647,7 +1647,7 @@ static int get_url(int argc, const char **argv)
 	return 0;
 }
 
-static int set_url(int argc, const char **argv)
+static int set_url(int argc, const char **argv, const char *prefix)
 {
 	int i, push_mode = 0, add_mode = 0, delete_mode = 0;
 	int matches = 0, negative_matches = 0;
@@ -1739,41 +1739,33 @@ static int set_url(int argc, const char **argv)
 
 int cmd_remote(int argc, const char **argv, const char *prefix)
 {
+	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose; must be placed before a subcommand")),
+		OPT_SUBCOMMAND("add", &fn, add),
+		OPT_SUBCOMMAND("rename", &fn, mv),
+		OPT_SUBCOMMAND_F("rm", &fn, rm, PARSE_OPT_NOCOMPLETE),
+		OPT_SUBCOMMAND("remove", &fn, rm),
+		OPT_SUBCOMMAND("set-head", &fn, set_head),
+		OPT_SUBCOMMAND("set-branches", &fn, set_branches),
+		OPT_SUBCOMMAND("get-url", &fn, get_url),
+		OPT_SUBCOMMAND("set-url", &fn, set_url),
+		OPT_SUBCOMMAND("show", &fn, show),
+		OPT_SUBCOMMAND("prune", &fn, prune),
+		OPT_SUBCOMMAND("update", &fn, update),
 		OPT_END()
 	};
-	int result;
 
 	argc = parse_options(argc, argv, prefix, options, builtin_remote_usage,
-		PARSE_OPT_STOP_AT_NON_OPTION);
+			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
 
-	if (argc < 1)
-		result = show_all();
-	else if (!strcmp(argv[0], "add"))
-		result = add(argc, argv);
-	else if (!strcmp(argv[0], "rename"))
-		result = mv(argc, argv);
-	else if (!strcmp(argv[0], "rm") || !strcmp(argv[0], "remove"))
-		result = rm(argc, argv);
-	else if (!strcmp(argv[0], "set-head"))
-		result = set_head(argc, argv);
-	else if (!strcmp(argv[0], "set-branches"))
-		result = set_branches(argc, argv);
-	else if (!strcmp(argv[0], "get-url"))
-		result = get_url(argc, argv);
-	else if (!strcmp(argv[0], "set-url"))
-		result = set_url(argc, argv);
-	else if (!strcmp(argv[0], "show"))
-		result = show(argc, argv);
-	else if (!strcmp(argv[0], "prune"))
-		result = prune(argc, argv);
-	else if (!strcmp(argv[0], "update"))
-		result = update(argc, argv);
-	else {
-		error(_("Unknown subcommand: %s"), argv[0]);
-		usage_with_options(builtin_remote_usage, options);
+	if (fn) {
+		return !!fn(argc, argv, prefix);
+	} else {
+		if (argc) {
+			error(_("unknown subcommand: %s"), argv[0]);
+			usage_with_options(builtin_remote_usage, options);
+		}
+		return !!show_all();
 	}
-
-	return result ? 1 : 0;
 }
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index f075dd4afa..0cdb563994 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -266,7 +266,7 @@ test_expect_success 'without subcommand does not take arguments' '
 	(
 		cd test &&
 		test_expect_code 129 git remote origin 2>err &&
-		grep "^error: Unknown subcommand:" err
+		grep "^error: unknown subcommand:" err
 	)
 '
 
-- 
2.37.1.633.g6a0fa73e39

