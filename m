Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A6EC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiG1QRf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiG1QRU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:17:20 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330BE70E64
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b26so2860955wrc.2
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+yMA1isxeEPjHcysVRNFcUUinzCsIItW8LpLfuxmLk4=;
        b=l+qg6mBcFxfAhlUFGsFj/4P7WpPSdPVpeHETTqBe9dAYrWLjeUN2Eyh7Ljr+plbk8l
         uR+KvQ6v3meXJqT58RF/n+fHYiohZdb/cNQTWEHfx8QZa4sLTe86b4ZJLDW4yYbhnbjD
         QSR7oRrTbesRB1uFswZm9Ul3HtWV78OOY4EJGEQtzsCq29Q4wyk2ULpT0LwWI9ChZgrw
         m9FpoJYvhWO9AU01LeLcyfrTFnkLr4LtU1glJqaRNxZx9JVZsJaMAwV4h/nCVx7CabxI
         4OwTZh0P75hhSZ56kHDeXoE37G6rT23/b/5SPiOq3KsvjGHmJWXPwygApYNmrsTd2i04
         309A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+yMA1isxeEPjHcysVRNFcUUinzCsIItW8LpLfuxmLk4=;
        b=tgGfMOvmTM4/wW72hLljv3MeUxxa1yNA48HdYqhUa4JJT7c8ypfGoK2QtNsn3TyQy5
         uh2lmjr2Vep1eQm7AjOAV1uZNGdyzCexQ0eTVlDUgFdWYAliihBPR9uirfF5x2LUJSe3
         B02xOubqHXLseIE3w4dH91b2299AweDQ2V5IiBBZg/JBCCMdvzPG6qr4sHpi1Pv0xXgx
         f+5IJ+rHMR7+qtl/3shAHqtkdzqHU3bwd5o4WjISLIV95/eOQouPB+qcLv/TX9kALRM6
         TIHOhQDWsx4MIuHM3qCltdhR+tFKRiIMYFSehKg5zzVbF+mdwQztRJ3p/ZSvNBXL2Vh7
         1MXA==
X-Gm-Message-State: AJIora9hJXH330+fGh4CkVp9Nkldl4sZp11dOE1BuUJ3vAxl8gsb7f7x
        IEod7vZRygkf5vpmYRyN+MDQKWHYLMEAgA==
X-Google-Smtp-Source: AGRyM1uHRfA6dwkN4fTFYPUNRLIq17Z6YTzXg3bPCRDvq9vN5AKl1rkHNBM0fvJxSaXaTCh/j+KKMw==
X-Received: by 2002:adf:d1e2:0:b0:21d:bca6:2371 with SMTP id g2-20020adfd1e2000000b0021dbca62371mr17547882wrd.315.1659025035416;
        Thu, 28 Jul 2022 09:17:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w13-20020adfee4d000000b0021f0af83142sm1220117wro.91.2022.07.28.09.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:17:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/20] submodule--helper: remove unused "list" helper
Date:   Thu, 28 Jul 2022 18:16:49 +0200
Message-Id: <patch-04.20-27df2efe718-20220728T161116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1167.g38fda70d8c4
In-Reply-To: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
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
index ac2553ba9d3..47ed24c6a60 100644
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
@@ -3340,7 +3301,6 @@ struct cmd_struct {
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
2.37.1.1167.g38fda70d8c4

