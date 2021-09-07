Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55E5C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D33F7610FE
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343614AbhIGMBw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343517AbhIGMBo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:01:44 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F155AC061757
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 05:00:38 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id f65so4410910pfb.10
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 05:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eDbSJi2QOaogZ9ovnA3MA96+Hw0IYbX50mD+rUQb/FQ=;
        b=h+brCEEFzz2GqO+f2TtMtOPSlJz/JZgYFwg1W2PSWF/c/4EsHPMk3LlJDi8OmuQ004
         eBHVoVhTd3EHXo9RcShraq2O7JlpeLhHO55pRgLAHvZf4hxnzxvEW6nMSudfvlKBAt5v
         hK+jrFqFvC1G6iprrtwdmOzdKgjwOOhGzjPuAR3UX8xQcM1tVMXh5Fm4ZOTPrQsF3WNb
         M311c9xpO6u41jjJI6DO9f2yn7QewO5dQXYzRljLABMr1zXpEyO+0m7Lcu5yd77yr/yF
         6haN9hj4rVc9BCeRFxOloqBq1kwf6+e/aJ9zzdRN7gx2ehS1KZDCz8b4fuyttmpushvP
         QKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eDbSJi2QOaogZ9ovnA3MA96+Hw0IYbX50mD+rUQb/FQ=;
        b=k7GF7oTAJIQEB8LpLci4PW4tbEpHVGlIlBHeM89RUUei322NzLmBwEOjrlmyjoHeTM
         /UCaQxOJ8VwuWiD2tw/hu02GJXfqDr9YtqZQndyxx2bXTpTbHhKscaHdlNRdEDrUzJfQ
         4lOkgV487HNiezSCdB+U6z/Z2WZkb5fejvocySMNLPNCB2nOvHmsyCN+mYyAXUCQfq3o
         3uBQ2/ud54nV2z0v7N+rf1g7HYvO3BboBZdBJldatyltkSDzUJXt5LYXgjKP5YHwTXCe
         sQbGeH7/Yzu672Rmk+8AWHWT/JdMfM9uxNwGQaM3WcjE1+ZMNKnJlnxHFu7bnCd0pXuN
         3t1A==
X-Gm-Message-State: AOAM532P5yVuovygek3imhvagNzwBb8twYqrWPRTjBhUlz4PznWa8P1H
        PJtp3IgvfWtKs6U0bY0RTmBcAPcdmFU=
X-Google-Smtp-Source: ABdhPJyEnZMWdmDSRRKRiKOHTbmK8vtGoQqzoihWmm/p9ytFRMsLvpI3Ynx/20KMzvrCid8MCoyIjg==
X-Received: by 2002:a62:7c0d:0:b0:3fe:60d2:bce2 with SMTP id x13-20020a627c0d000000b003fe60d2bce2mr16192018pfc.27.1631016038303;
        Tue, 07 Sep 2021 05:00:38 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.210])
        by smtp.gmail.com with ESMTPSA id a142sm11248150pfd.172.2021.09.07.05.00.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 05:00:38 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, emilyshaffer@google.com,
        gitster@pobox.com, jrnieder@gmail.com, kaartic.sivaraam@gmail.com,
        pc44800@gmail.com, periperidip@gmail.com, avarab@gmail.com,
        Atharva Raykar <raykar.ath@gmail.com>
Subject: [PATCH 13/13] submodule--helper: remove run-update-procedure subcommand
Date:   Tue,  7 Sep 2021 17:29:32 +0530
Message-Id: <20210907115932.36068-14-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210907115932.36068-1-raykar.ath@gmail.com>
References: <20210907115932.36068-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The subcommand 'submodule--helper run-update-procedure' is no longer
needed after the conversion of the bulk of 'update' to C.

While we are at it, let's rename 'do_run_update_procedure()' to
'run_update_procedure()' to reflect the fact that it is no longer a
utility function meant to be wrapped in another function.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 73 +------------------------------------
 1 file changed, 2 insertions(+), 71 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7622d6bd24..6565e2cd78 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2484,7 +2484,7 @@ static int run_update_command(struct update_data *ud, int subforce, struct strin
 	return 0;
 }
 
-static int do_run_update_procedure(struct update_data *ud, struct string_list *err)
+static int run_update_procedure(struct update_data *ud, struct string_list *err)
 {
 	int subforce = is_null_oid(&ud->suboid) || ud->force;
 
@@ -2514,74 +2514,6 @@ static int do_run_update_procedure(struct update_data *ud, struct string_list *e
 	return run_update_command(ud, subforce, err);
 }
 
-static int run_update_procedure(int argc, const char **argv, const char *prefix)
-{
-	int force = 0, quiet = 0, nofetch = 0, just_cloned = 0;
-	char *prefixed_path, *update = NULL;
-	struct update_data update_data = UPDATE_DATA_INIT;
-	struct string_list err = STRING_LIST_INIT_DUP;
-
-	struct option options[] = {
-		OPT__QUIET(&quiet, N_("suppress output for update by rebase or merge")),
-		OPT__FORCE(&force, N_("force checkout updates"), 0),
-		OPT_BOOL('N', "no-fetch", &nofetch,
-			 N_("don't fetch new objects from the remote site")),
-		OPT_BOOL(0, "just-cloned", &just_cloned,
-			 N_("overrides update mode in case the repository is a fresh clone")),
-		OPT_INTEGER(0, "depth", &update_data.depth, N_("depth for shallow fetch")),
-		OPT_STRING(0, "prefix", &prefix,
-			   N_("path"),
-			   N_("path into the working tree")),
-		OPT_STRING(0, "update", &update,
-			   N_("string"),
-			   N_("rebase, merge, checkout or none")),
-		OPT_STRING(0, "recursive-prefix", &update_data.recursive_prefix, N_("path"),
-			   N_("path into the working tree, across nested "
-			      "submodule boundaries")),
-		OPT_CALLBACK_F(0, "oid", &update_data.oid, N_("sha1"),
-			       N_("SHA1 expected by superproject"), PARSE_OPT_NONEG,
-			       parse_opt_object_id),
-		OPT_CALLBACK_F(0, "suboid", &update_data.suboid, N_("subsha1"),
-			       N_("SHA1 of submodule's HEAD"), PARSE_OPT_NONEG,
-			       parse_opt_object_id),
-		OPT_END()
-	};
-
-	const char *const usage[] = {
-		N_("git submodule--helper run-update-procedure [<options>] <path>"),
-		NULL
-	};
-
-	argc = parse_options(argc, argv, prefix, options, usage, 0);
-
-	if (argc != 1)
-		usage_with_options(usage, options);
-
-	update_data.force = !!force;
-	update_data.quiet = !!quiet;
-	update_data.nofetch = !!nofetch;
-	update_data.just_cloned = !!just_cloned;
-	update_data.sm_path = argv[0];
-
-	if (update_data.recursive_prefix)
-		prefixed_path = xstrfmt("%s%s", update_data.recursive_prefix, update_data.sm_path);
-	else
-		prefixed_path = xstrdup(update_data.sm_path);
-
-	update_data.displaypath = get_submodule_displaypath(prefixed_path, prefix);
-
-	determine_submodule_update_strategy(the_repository, update_data.just_cloned,
-					    update_data.sm_path, update,
-					    &update_data.update_strategy);
-
-	free(prefixed_path);
-
-	if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)
-		return do_run_update_procedure(&update_data, &err);
-
-	return 3;
-}
-
 static const char *remote_submodule_branch(const char *path)
 {
 	const struct submodule *sub;
@@ -3018,7 +2950,7 @@ static int update_submodule(struct update_data *update_data)
 	}
 
 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
-		if (do_run_update_procedure(update_data, &err))
+		if (run_update_procedure(update_data, &err))
 			return 1;
 
 	if (update_data->recursive) {
@@ -3401,7 +3333,6 @@ static struct cmd_struct commands[] = {
 	{"clone", module_clone, 0},
 	{"add-clone", add_clone, 0},
 	{"update", module_update, 0},
-	{"run-update-procedure", run_update_procedure, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
-- 
2.32.0

