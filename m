Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92853C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 12:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbiGYMkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 08:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbiGYMjn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 08:39:43 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660DF1BE9D
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:34 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id e15so13776209edj.2
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4+9ogDczNmdKY7J3//12DGhMum4qTvsIadvdJAxybzw=;
        b=MpsGKd27FFsQfJ41sXe6FgoN3S2rj6ml9uNb9uj69JlKJeMSZP8xci0QGpozXnh++c
         e7HaH34tWUArpnHO3vEV8V2dXUwBzcK20Vzv+oOVcJVOWKzJBAGvd7KS6UeMM3hmnwJB
         UneSI6cEct2NU9UBzvyTjnTWwLrUYAs4gchk+YlD/Omb9s6Z6gem+w24+ADQVIlmqaKp
         V3wqhg5iQ7HfsOgIbra3jqdfrV0oFSFW1+cX0Neci2qUh2DRDv0WwhegxAuJEiBPg9mT
         uJtMZtjMgaGVnomDckRAsZph7xHURLTMoVAFR3lkQLzVjlH2rcFl+3upURE3RnXrsf1u
         GhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4+9ogDczNmdKY7J3//12DGhMum4qTvsIadvdJAxybzw=;
        b=7eU/5Xbb87da9cBk1OyMpMavXTxEhvd1PsDHeL+RTcFhMM0Z2eDym6GUXiLdxeGCLP
         woE2WcfzSv8uAreblNE12yPZ/nBwHJtBfbdE+VzImA6/AMhtNudzZw9glhihhrfGx1ly
         QEaN/c/NDbpCQSG+Ma9Q8yS7sAN09f7C+ROeKxd2YlU4rnvAvkbBFlVpBdTrrHJARzVV
         YgKxt9xN32Fx8s39su/ZAkEocC3t4AkHSbXHNbqTw2RanoVPkvSh8mCvE9OaCiElMy6j
         KUqw1gaCFdmVrpfi5ZyaRZNfhEL1bt0ZulEUhRAj/c2OWqNCcWViMzt9LpWAUC+CJ5tY
         iWsQ==
X-Gm-Message-State: AJIora/HZxK1KM7nMX/Pzk1dQDtNpT2Mgqx3Zsn6dCdRFy1XgB2FASl1
        qVBZBumzvzGSrr34PWr1GS3LExrc78w=
X-Google-Smtp-Source: AGRyM1vGh8pn7ImOPc7PW6DMa5ZPP+53pzLN57qT70Eq6xxjKdDNiLDGV7GyU0G3+jh3lpzWWOYylg==
X-Received: by 2002:a05:6402:51d1:b0:43b:f89e:a751 with SMTP id r17-20020a05640251d100b0043bf89ea751mr5734099edd.391.1658752773001;
        Mon, 25 Jul 2022 05:39:33 -0700 (PDT)
Received: from localhost (94-21-23-94.pool.digikabel.hu. [94.21.23.94])
        by smtp.gmail.com with ESMTPSA id y10-20020a056402358a00b0043a8f5ad272sm7209615edc.49.2022.07.25.05.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:39:32 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 19/20] builtin/stash.c: let parse-options parse subcommands
Date:   Mon, 25 Jul 2022 14:38:56 +0200
Message-Id: <20220725123857.2773963-20-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.1.633.g6a0fa73e39
In-Reply-To: <20220725123857.2773963-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git stash' parses its subcommands with a long list of if-else if
statements.  parse-options has just learned to parse subcommands, so
let's use that facility instead, with the benefits of shorter code,
and listing subcommands for Bash completion.

Note that the push_stash() function implementing the 'push' subcommand
accepts an extra flag parameter to indicate whether push was assumed,
so add a wrapper function with the standard subcommand function
signature.

Note also that this change "hides" the '-h' option in 'git stash push
-h' from the parse_option() call in cmd_stash(), as it comes after the
subcommand.  Consequently, from now on it will emit the usage of the
'push' subcommand instead of the usage of 'git stash'.  We had a
failing test for this case, which can now be flipped to expect
success.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/stash.c  | 53 ++++++++++++++++++++++--------------------------
 t/t3903-stash.sh |  2 +-
 2 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index a14e832e9f..1ba24c1173 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1739,6 +1739,11 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 			     include_untracked, only_staged);
 }
 
+static int push_stash_unassumed(int argc, const char **argv, const char *prefix)
+{
+	return push_stash(argc, argv, prefix, 0);
+}
+
 static int save_stash(int argc, const char **argv, const char *prefix)
 {
 	int keep_index = -1;
@@ -1787,15 +1792,28 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 	pid_t pid = getpid();
 	const char *index_file;
 	struct strvec args = STRVEC_INIT;
-
+	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
+		OPT_SUBCOMMAND("apply", &fn, apply_stash),
+		OPT_SUBCOMMAND("clear", &fn, clear_stash),
+		OPT_SUBCOMMAND("drop", &fn, drop_stash),
+		OPT_SUBCOMMAND("pop", &fn, pop_stash),
+		OPT_SUBCOMMAND("branch", &fn, branch_stash),
+		OPT_SUBCOMMAND("list", &fn, list_stash),
+		OPT_SUBCOMMAND("show", &fn, show_stash),
+		OPT_SUBCOMMAND("store", &fn, store_stash),
+		OPT_SUBCOMMAND("create", &fn, create_stash),
+		OPT_SUBCOMMAND("push", &fn, push_stash_unassumed),
+		OPT_SUBCOMMAND_F("save", &fn, save_stash, PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
 
 	git_config(git_stash_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
-			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_DASHDASH);
+			     PARSE_OPT_SUBCOMMAND_OPTIONAL |
+			     PARSE_OPT_KEEP_UNKNOWN_OPT |
+			     PARSE_OPT_KEEP_DASHDASH);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
@@ -1804,33 +1822,10 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
 		    (uintmax_t)pid);
 
-	if (!argc)
-		return !!push_stash(0, NULL, prefix, 0);
-	else if (!strcmp(argv[0], "apply"))
-		return !!apply_stash(argc, argv, prefix);
-	else if (!strcmp(argv[0], "clear"))
-		return !!clear_stash(argc, argv, prefix);
-	else if (!strcmp(argv[0], "drop"))
-		return !!drop_stash(argc, argv, prefix);
-	else if (!strcmp(argv[0], "pop"))
-		return !!pop_stash(argc, argv, prefix);
-	else if (!strcmp(argv[0], "branch"))
-		return !!branch_stash(argc, argv, prefix);
-	else if (!strcmp(argv[0], "list"))
-		return !!list_stash(argc, argv, prefix);
-	else if (!strcmp(argv[0], "show"))
-		return !!show_stash(argc, argv, prefix);
-	else if (!strcmp(argv[0], "store"))
-		return !!store_stash(argc, argv, prefix);
-	else if (!strcmp(argv[0], "create"))
-		return !!create_stash(argc, argv, prefix);
-	else if (!strcmp(argv[0], "push"))
-		return !!push_stash(argc, argv, prefix, 0);
-	else if (!strcmp(argv[0], "save"))
-		return !!save_stash(argc, argv, prefix);
-	else if (*argv[0] != '-')
-		usage_msg_optf(_("unknown subcommand: %s"),
-			       git_stash_usage, options, argv[0]);
+	if (fn)
+		return !!fn(argc, argv, prefix);
+	else if (!argc)
+		return !!push_stash_unassumed(0, NULL, prefix);
 
 	/* Assume 'stash push' */
 	strvec_push(&args, "push");
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 2a4c3fd61c..376cc8f4ab 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -25,7 +25,7 @@ test_expect_success 'usage on main command -h emits a summary of subcommands' '
 	grep -F "or: git stash show" usage
 '
 
-test_expect_failure 'usage for subcommands should emit subcommand usage' '
+test_expect_success 'usage for subcommands should emit subcommand usage' '
 	test_expect_code 129 git stash push -h >usage &&
 	grep -F "usage: git stash [push" usage
 '
-- 
2.37.1.633.g6a0fa73e39

