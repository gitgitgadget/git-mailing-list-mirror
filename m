Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742A2C32772
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiHUN6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiHUN6c (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:58:32 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC76E007
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:30 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso6447316wmc.0
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FxP8Bdc/zCpIH1B22L2MFbnrA4tgAap1tkuH6wpfSRc=;
        b=ghAnxG7KlCPgR1kydQJDPxe5uD0yqHNVkaURLpsW9TYfbt6cRh+IRMMYVYM5Usayxb
         Dqw4agmdJB2uLff1R66/okYdM+f4thh0wwix2froHmWD6r4hDtI/YaCNsn13m+YUqea+
         IBqvpBk72DEXeDstu3/WtUzojELM2xWJmrgzgUbWWmxZQ+0EFjMFyEX07lQjX8WeJhcF
         TiyXJoAriqEFX5wzrkrpSSAMRTz0UwHxKzO+dXRhvRRng3XH9VpUcZ0PuxOy0VMHM3/Y
         cowMLsKsIKMS4HxEu6saRPF/5HDNht6Z5AI622LxC/TXAKvaftbRq9COddX29tS0G48d
         lmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FxP8Bdc/zCpIH1B22L2MFbnrA4tgAap1tkuH6wpfSRc=;
        b=VE6oVQeia/I3u846WJH2H0zDar4e87dnevpd9DRShghrT4A3hfA8AtpHlRiTTnw2Fc
         WamzAxjezcLXkuCE3Fvw+seGtm5+YBMhsXYgRFTsjRQvZg/p+JugYzmbzEtzCL1kJ862
         RTQFdAwzvvWpsdWKvpUSf++iasYUKLRoXp9iJ4QxjECBZiBIctDifi+XrlFdo1aSj/MS
         Mi6Oz7Q3tj3XCxTXDyAmTla+tln24yicTyLOOiy9WoJJzkeDOlYi3jUNWW22aQQnQ3Tc
         ploFXMHz6yodMKo7QzmjG1hlmCvoeQg28D0iN0nT3nfO+GvJkbMnBanO1ZJ6z0ZTe+Jw
         uBfA==
X-Gm-Message-State: ACgBeo2NMAe88lL2wW4jd16B4FTBup4OfCbLYrufT/jOMrB1x4/t4lU1
        b/Ovfwuet7jOidiQ3FoY0W3RQK53v8+AyklF
X-Google-Smtp-Source: AA6agR5MHyjY9SqOkZdmh8iKw7TEoOQ+Qm8KRAHrGEm6tCe585/SVXV3an7hMOFSoRq4Bhw9w2fHZQ==
X-Received: by 2002:a05:600c:1e8b:b0:3a6:acc:ebfb with SMTP id be11-20020a05600c1e8b00b003a60accebfbmr9836116wmb.66.1661090309009;
        Sun, 21 Aug 2022 06:58:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/32] submodule--helper: remove unused "list" helper
Date:   Sun, 21 Aug 2022 15:57:13 +0200
Message-Id: <patch-v3-04.32-10189ba3da7-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "submodule--helper list" sub-command, which hasn't been
used by git-submodule.sh since 2964d6e5e1e (submodule: port subcommand
'set-branch' from shell to C, 2020-06-02).

There was a test added in 2b56bb7a87a (submodule helper list: respect
correct path prefix, 2016-02-24) which relied on it, but the right
thing to do here is to delete that test as well.

That test was regression testing the "list" subcommand itself. We're
not getting anything useful from the "list | cut -f2" invocation that
we couldn't get from "foreach 'echo $sm_path'".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 40 -------------------------------------
 t/t7400-submodule-basic.sh  | 25 -----------------------
 2 files changed, 65 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fc4d2779da6..24a305151d1 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -266,45 +266,6 @@ static char *get_up_path(const char *path)
 	return strbuf_detach(&sb, NULL);
 }
 
-static int module_list(int argc, const char **argv, const char *prefix)
-{
-	int i;
-	struct pathspec pathspec;
-	struct module_list list = MODULE_LIST_INIT;
-
-	struct option module_list_options[] = {
-		OPT_STRING(0, "prefix", &prefix,
-			   N_("path"),
-			   N_("alternative anchor for relative paths")),
-		OPT_END()
-	};
-
-	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper list [--prefix=<path>] [<path>...]"),
-		NULL
-	};
-
-	argc = parse_options(argc, argv, prefix, module_list_options,
-			     git_submodule_helper_usage, 0);
-
-	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
-
-	for (i = 0; i < list.nr; i++) {
-		const struct cache_entry *ce = list.entries[i];
-
-		if (ce_stage(ce))
-			printf("%06o %s U\t", ce->ce_mode,
-			       oid_to_hex(null_oid()));
-		else
-			printf("%06o %s %d\t", ce->ce_mode,
-			       oid_to_hex(&ce->oid), ce_stage(ce));
-
-		fprintf(stdout, "%s\n", ce->name);
-	}
-	return 0;
-}
-
 static void for_each_listed_submodule(const struct module_list *list,
 				      each_submodule_fn fn, void *cb_data)
 {
@@ -3343,7 +3304,6 @@ struct cmd_struct {
 };
 
 static struct cmd_struct commands[] = {
-	{"list", module_list, 0},
 	{"clone", module_clone, SUPPORT_SUPER_PREFIX},
 	{"add", module_add, 0},
 	{"update", module_update, SUPPORT_SUPER_PREFIX},
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 6a77d817a82..b50db3f1031 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1255,31 +1255,6 @@ test_expect_success 'submodule add clone shallow submodule' '
 	)
 '
 
-test_expect_success 'submodule helper list is not confused by common prefixes' '
-	mkdir -p dir1/b &&
-	(
-		cd dir1/b &&
-		git init &&
-		echo hi >testfile2 &&
-		git add . &&
-		git commit -m "test1"
-	) &&
-	mkdir -p dir2/b &&
-	(
-		cd dir2/b &&
-		git init &&
-		echo hello >testfile1 &&
-		git add .  &&
-		git commit -m "test2"
-	) &&
-	git submodule add /dir1/b dir1/b &&
-	git submodule add /dir2/b dir2/b &&
-	git commit -m "first submodule commit" &&
-	git submodule--helper list dir1/b | cut -f 2 >actual &&
-	echo "dir1/b" >expect &&
-	test_cmp expect actual
-'
-
 test_expect_success 'setup superproject with submodules' '
 	git init sub1 &&
 	test_commit -C sub1 test &&
-- 
2.37.2.1279.g64dec4e13cf

