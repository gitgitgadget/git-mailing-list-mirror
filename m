Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C40ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiHaXSq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbiHaXS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:26 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3E4A00FB
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:25 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id j26so8130011wms.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ePoGfql8fulmTurQ/+7+GoZ75R80Tquo3+jcfAq5KWs=;
        b=l37AijbQFukbqd474pWY1wyhYbKQ8HmlQPjVcMv2Gj/dQJkBlI2s/qaZx+qfizydM+
         CwqQ2Tve8cic/lVmT6z2S2lWLoLNOh8sDT1B+Sbgoh7nYMoRJAWXHXMt/Fl8on+G/Ii3
         9ZrtibIqyKXzovIR0Bk3G2pnWCVJahFt3tnGfqEBFIgZEFE34x0G0NHF3eS+KHyyX4FG
         VseLdUO+Tx1nT5lIVH1bAD2e6Do8WTPfdovqd14aY3yrShQaVO+5u1c7pcuZnUKRRtN6
         N3iNG2tkhYm+Z/3DE21f7OCk/iJ4rbw9u+bNmrvZ5zv6K0zVA2btOoItxEGuSXvn9kUZ
         VHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ePoGfql8fulmTurQ/+7+GoZ75R80Tquo3+jcfAq5KWs=;
        b=yEBT7Qr1kxkxl5/CPLzJX1tvDXJSt2u1K0j3X2Gpe4PbkWMkDLjx6GQh5vlV8qZkZB
         f6hCAWC1zB0kBSN4WQ4RgcLkbBDKkivFLiwMNOsBfzNq5Y5Vl6NKkjTYaWXJiuNZlT1A
         tvtm4/ZVgb+MXIrvdJwZkPOEjx3GlPQErt78YHq56H2jxEtCju40sKLyiNYFn2ldI8vL
         soVhQ7PMaBWBbaXh13N1yshDjkJ3ZSbuP/xvQXF3cDukwTXHuoblvLFaBvEm04xy7F78
         UbKothZQxbfHyJW4Uxe8mGVidIni4uDHXNtE7dFZranUJAc285Ux37IvsxxWVQJS4mTr
         SPsQ==
X-Gm-Message-State: ACgBeo0YI2JEiQztDmE9xUZq8LfNcayw9jdICqPpib2Dr/3bFKw3O/nZ
        dKif/kdYs6AhGkM/8tZLF9EWN72k1Ni/cw==
X-Google-Smtp-Source: AA6agR6m2DRiaqf+HW5+YsmlkqcoxGDFtRe3J4IcyMSdhawtVAloVRz1dMBP3w/1goa2MGiZA/SbrA==
X-Received: by 2002:a05:600c:1f1a:b0:3a6:2569:496b with SMTP id bd26-20020a05600c1f1a00b003a62569496bmr3243230wmb.176.1661987903636;
        Wed, 31 Aug 2022 16:18:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 04/33] submodule--helper: remove unused "list" helper
Date:   Thu,  1 Sep 2022 01:17:46 +0200
Message-Id: <patch-v4-04.33-6714a04a5c8-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
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
2.37.3.1420.g76f8a3d556c

