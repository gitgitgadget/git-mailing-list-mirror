Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B1D01F516
	for <e@80x24.org>; Mon, 25 Jun 2018 16:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933630AbeFYQrH (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 12:47:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51737 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933140AbeFYQqw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 12:46:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id w137-v6so4723511wmw.1
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 09:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wzbEnHTCc81Bjcdr/1HqBqsOozVKIh9UAtwYrD0blDg=;
        b=OZSOwBT4E6cTUKJQDQ4b/rWlAhxOtwO2qXuJ/A9ACPKcwdbjzyX2Xt5tkA264om8I4
         hZoqb3njSS9rBuWlWm3OyiJxVrwh2j9UMIS9EFvMQGUTzoeb7lqYXigkKpEt+9SiNQvU
         x7bcPRqYi0JoVwJttPxVLhRZP3aRKg4VDR55gjOX53vO94giG3zT0GXmBMunpojg7i25
         mOu0ib6oVClWShU+qrKMe4DsnfTSKO3mSANsWIhcwSwby8jWlleOnZDBm1tB1pqubt3f
         hVs1dpALP799OST0IW7rpiApAaNKRN9wfJI6BTCnTj3hqFDhyzmp0iOwqmH/T4UMUNxV
         Eoiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wzbEnHTCc81Bjcdr/1HqBqsOozVKIh9UAtwYrD0blDg=;
        b=IEAW0p0lAvt+BHX9vHuyS8XPo9KCaSI7guXs5m+tgZzU4wnS2Nyk5qo11sHpG2KhIm
         mRlDkOJiqWwjSPIs63D3xv6owmyj05OidgdHsUL/vJ2EX/d2NbUn/FYcSMLhFpwjjC5j
         ZhwOkJEJBN34zcdsnq4l4u9c0ruEpdiMIWuFOxi0x/cEffpD5NCMMM7IW2Am/CiHrE4d
         Aafptw6LhXkJRBMWR01+gI0Xbih4OXhgWfyCJJsfGGZ6gjphHOSL5ZnKOJaYS2A1TASD
         mse8MMe5EYCzkFG4Q0dw5lcz/mfk0aDybWD9RnGnUV9S0W6TEnfXpNKqrWVvME4App9T
         BtiQ==
X-Gm-Message-State: APt69E1OdRtyc94IGHfG7epxbvviT1aQJUvz/cv3Q0phgWH3WDNEfwqG
        QlOJlOdXZuSTWKKKfqWhnUt5EG+L
X-Google-Smtp-Source: AAOMgpfsxeWcQrlq4WgyCSnblbpyfBiLkCMWwBhPYiHkbJgmqWG20XYyB630L5sO/z4nGQVSeZcU9g==
X-Received: by 2002:a1c:b1d7:: with SMTP id a206-v6mr1655179wmf.61.1529945210707;
        Mon, 25 Jun 2018 09:46:50 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com (5-13-160-71.residential.rdsnet.ro. [5.13.160.71])
        by smtp.gmail.com with ESMTPSA id v10-v6sm26419997wrn.97.2018.06.25.09.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 09:46:49 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, joel@teichroeb.net, gitster@pobox.com
Subject: [PATCH v6 4/6] stash: refactor `show_stash()` to use the diff API
Date:   Mon, 25 Jun 2018 19:46:37 +0300
Message-Id: <a3b02c25de08579df65ecb1de62a7b8f0434077e.1529943789.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.13.g506fc12fb
In-Reply-To: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, `show_stash()` uses `cmd_diff()` to generate
the output. After this commit, the output will be generated
using the internal API.

Before this commit, `git stash show --quiet` would act like
`git diff` and error out if the stash is not empty. Now, the
`--quiet` option does not error out given an empty stash.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 72 +++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 4f49fd04b..4589e12d6 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -10,6 +10,8 @@
 #include "run-command.h"
 #include "dir.h"
 #include "rerere.h"
+#include "revision.h"
+#include "log-tree.h"
 
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper list [<options>]"),
@@ -650,55 +652,71 @@ static int git_stash_config(const char *var, const char *value, void *cb)
 
 static int show_stash(int argc, const char **argv, const char *prefix)
 {
-	int i, ret = 0;
-	struct argv_array args = ARGV_ARRAY_INIT;
-	struct argv_array args_refs = ARGV_ARRAY_INIT;
+	int i;
+	int flags = 0;
 	struct stash_info info;
+	struct rev_info rev;
+	struct argv_array stash_args = ARGV_ARRAY_INIT;
 	struct option options[] = {
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_show_usage,
-			     PARSE_OPT_KEEP_UNKNOWN);
+	init_diff_ui_defaults();
+	git_config(git_diff_ui_config, NULL);
 
-	argv_array_push(&args, "diff");
+	init_revisions(&rev, prefix);
 
-	/* Push args which are not options into args_refs. */
-	for (i = 0; i < argc; ++i) {
-		if (argv[i][0] == '-')
-			argv_array_push(&args, argv[i]);
+	/* Push args which are not options into stash_args. */
+	for (i = 1; i < argc; ++i) {
+		if (argv[i][0] != '-')
+			argv_array_push(&stash_args, argv[i]);
 		else
-			argv_array_push(&args_refs, argv[i]);
-	}
-
-	if (get_stash_info(&info, args_refs.argc, args_refs.argv)) {
-		argv_array_clear(&args);
-		argv_array_clear(&args_refs);
-		return -1;
+			flags++;
 	}
 
 	/*
 	 * The config settings are applied only if there are not passed
 	 * any flags.
 	 */
-	if (args.argc == 1) {
+	if (!flags) {
 		git_config(git_stash_config, NULL);
 		if (show_stat)
-			argv_array_push(&args, "--stat");
+			rev.diffopt.output_format |= DIFF_FORMAT_DIFFSTAT;
+		if (show_patch) {
+			rev.diffopt.output_format = ~DIFF_FORMAT_NO_OUTPUT;
+			rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
+		}
+	}
 
-		if (show_patch)
-			argv_array_push(&args, "-p");
+	if (get_stash_info(&info, stash_args.argc, stash_args.argv)) {
+		argv_array_clear(&stash_args);
+		return -1;
 	}
 
-	argv_array_pushl(&args, oid_to_hex(&info.b_commit),
-			 oid_to_hex(&info.w_commit), NULL);
+	argc = setup_revisions(argc, argv, &rev, NULL);
+	if (!rev.diffopt.output_format)
+		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
+	diff_setup_done(&rev.diffopt);
+	rev.diffopt.flags.recursive = 1;
+	setup_diff_pager(&rev.diffopt);
 
-	ret = cmd_diff(args.argc, args.argv, prefix);
+	/*
+	 * We can return early if there was any option not recognised by
+	 * `diff_opt_parse()`, besides the word `stash`.
+	 */
+	if (argc > 1) {
+		free_stash_info(&info);
+		argv_array_clear(&stash_args);
+		usage_with_options(git_stash_helper_show_usage, options);
+	}
+
+	/* Do the diff thing. */
+	diff_tree_oid(&info.b_commit, &info.w_commit, "", &rev.diffopt);
+	log_tree_diff_flush(&rev);
 
 	free_stash_info(&info);
-	argv_array_clear(&args);
-	return ret;
+	argv_array_clear(&stash_args);
+	return 0;
 }
 
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
-- 
2.18.0.rc2.13.g506fc12fb

