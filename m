Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF04C19F2C
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiHBPqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiHBPqX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:46:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C3DB7F6
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:22 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q30so13988550wra.11
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=giNR78yvsytV5FHxWOODBwS5gjO0+1NSOHS1p439ijI=;
        b=YLSNJrO3s1gpVDQko6FudzuK76nD5xKgpVS8Tz+X56ML3mufu1FPVdDlwNMoZ5PkQE
         URrnalETWWtydR0rislHuiqTmBcEE+qNfhixk15aPSOfbobqT07rUDhfvKU++n9cpLWO
         aaZlTqD3MjrX1kR/Zzj0CYpcKfV3dFL/BgfotkkwEvuwy5s9KMhHUIfhkYy4Vu8BlcDU
         e2lf0ZS8bnuSXJZ0BURVbgzsnjsPVfWinpaFQTcyQHmPdOhfvYaoAGlB8eeIHOv7BXjQ
         wmC3r9FgEyhGBumoniOrQ+H8Jr5vx3/TVuyMtT34f+WConGOd+I/Y8ubWirJYpSQ6aTF
         ecCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=giNR78yvsytV5FHxWOODBwS5gjO0+1NSOHS1p439ijI=;
        b=YcPt3fQypb31f9PxQZHGQrpxCrs/57QHX0FS1DsaeNe+yCG/2JmXbCU5Tt9j2H/POI
         AAD7AJP9/D8ET+5YetFvgsb+IrVYYTJvDgKGLnpl7EDk4TEsF/g2Pwt6aVMVExuBefDV
         kbsxq+V37vSmgoNtbzgvf4Xf1djOg4/1ZkfjQUtooYZGHJFwFvqTOrYLjcb002LdAPpZ
         Y/V2zkOjfxjMK8xL9qzsv0UsfjTAR7257NgLLQuhpNt3/OMxjfANRw1PKFth2NdO96Yl
         /4RVf/pbpw6ue1Qg3xuFEBi+HB8K5vy3bv+21Z7u/6mcqdaShO1Nu6a9WyFq3lGEwZbC
         6HJg==
X-Gm-Message-State: ACgBeo3FK3WjaT3KeCnvkwuZ/gSj/7VZQG1DdxwCElAym2xGkWgNEYjM
        Rfa/mD2T72S6J5XQJmI9vd5VDufgHbu+Ag==
X-Google-Smtp-Source: AA6agR7sXDmBlWMciqbe+4LNqIfhWMB7uHeEdJ7nCv+7vYN7A9OB4qlvGi/QkvmTAHOcExOokdSc2w==
X-Received: by 2002:a05:6000:1d84:b0:20e:5fae:6e71 with SMTP id bk4-20020a0560001d8400b0020e5fae6e71mr13489666wrb.224.1659455180856;
        Tue, 02 Aug 2022 08:46:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/28] submodule--helper: remove unused "list" helper
Date:   Tue,  2 Aug 2022 17:45:48 +0200
Message-Id: <patch-v2-04.28-6f78f9c9274-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
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
2.37.1.1233.ge8b09efaedc

