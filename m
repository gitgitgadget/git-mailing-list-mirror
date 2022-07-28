Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2752CC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiG1Qaq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbiG1Qa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:30:26 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F43A64C7
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:25 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v17so2878192wrr.10
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=stR+OuorQBwE92QYi1w7bGFdan4hiToutrf2Fo8qupM=;
        b=KVx9OzW5EeH5JENqJ/pczyoyJG9xcAFaXisXfh7jaSi1GXcDkcxyykTyaoch2jtCmy
         1pMVWPtY7kXXi3f2r9XOQ8gZtSljcp4rFzPPR9UNemgYAl7ay/8cyQ2jfjItAM0g9Fdh
         vTKP3uzLnZEcK135q6aJL6MEBddegB+ehn+dn+bPsQh2dt7+cKgGHt92hsnyZrAItB21
         WodYHdj4ztLBSCLfvkeLJE0r0owRDaooYVc5pU91C6vzLHQDXr+d9G35TwXpqbWIR9hh
         595i8VVc1fHVhwAKiZ1RK8gu1ux2dBD2NfZ8osd6R31X/+wnO8CwdVgj+g48GvRKDFqR
         dl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=stR+OuorQBwE92QYi1w7bGFdan4hiToutrf2Fo8qupM=;
        b=oYag9ZuIA50dIbUXqtnHAnX6eXIIPHMY5WE4Ulw9H7cc2d5wihCW488qeKwodtKqYQ
         C83SyNqBD9Q3+v4+KJVU/PjR8sOZhialEkmPjK1dSauLllcW1OZWMvODk+ExFr9T0aiX
         jzsb66+JDjFjhupbM9Ca8UpenzNuvBmy90JRiAIqde9/PNJAAOtHz9LTgvhT8+cM3PEF
         WntilABrkSi6kw292f2Qtj7BKnvgKOf3McIt+XgtFqlk0VNaq0Sk8AmZ1bO3wTtOju/z
         v8X9QcxeVM/5L4JL9EeCfC6zLWEQKz/47Wl2yN+d2oSNwQhvh9VEGRYKZkXAgNOwk3kX
         dTHg==
X-Gm-Message-State: AJIora/9pCh9WFCY9ftLVgkpdPkt6yLKxnbBjYn4XhV9PXChrYkwXnFr
        B5JTlMDeAPS1XQN1W1sfcvOU61N3RqFszQ==
X-Google-Smtp-Source: AGRyM1vuaq6FqWE/kVWj+U5uhKQ6kxqCriQh6VeHGizjD5+03QFz+8fVRq0kgBSAqjPRHekFuWPMNQ==
X-Received: by 2002:a5d:56d1:0:b0:21e:ccc7:c595 with SMTP id m17-20020a5d56d1000000b0021eccc7c595mr5902236wrw.661.1659025823332;
        Thu, 28 Jul 2022 09:30:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d528d000000b0021ef34124ebsm1492018wrv.11.2022.07.28.09.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:30:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 06/17] submodule--helper: add and use *_release() functions
Date:   Thu, 28 Jul 2022 18:30:00 +0200
Message-Id: <patch-v4-06.17-575d3e8d2e2-20220728T162442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
References: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add release functions for "struct module_list", "struct
submodule_update_clone" and "struct update_data".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c      | 28 +++++++++++++++++++++++++++-
 t/t6134-pathspec-in-submodule.sh |  1 +
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 35a168009b7..48507a6e0df 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -160,6 +160,11 @@ struct module_list {
 };
 #define MODULE_LIST_INIT { 0 }
 
+static void module_list_release(struct module_list *ml)
+{
+	free(ml->entries);
+}
+
 static int module_list_compute(int argc, const char **argv,
 			       const char *prefix,
 			       struct pathspec *pathspec,
@@ -222,7 +227,7 @@ static void module_list_active(struct module_list *list)
 		active_modules.entries[active_modules.nr++] = ce;
 	}
 
-	free(list->entries);
+	module_list_release(list);
 	*list = active_modules;
 }
 
@@ -395,6 +400,7 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -540,6 +546,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -717,6 +724,7 @@ static int module_status(int argc, const char **argv, const char *prefix)
 
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -1289,6 +1297,7 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -1441,6 +1450,7 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -1810,6 +1820,12 @@ struct submodule_update_clone {
 };
 #define SUBMODULE_UPDATE_CLONE_INIT { 0 }
 
+static void submodule_update_clone_release(struct submodule_update_clone *suc)
+{
+	free(suc->update_clone);
+	free(suc->failed_clones);
+}
+
 struct update_data {
 	const char *prefix;
 	const char *displaypath;
@@ -1848,6 +1864,11 @@ struct update_data {
 	.max_jobs = 1, \
 }
 
+static void update_data_release(struct update_data *ud)
+{
+	module_list_release(&ud->list);
+}
+
 static void next_submodule_warn_missing(struct submodule_update_clone *suc,
 		struct strbuf *out, const char *displaypath)
 {
@@ -2530,6 +2551,7 @@ static int update_submodules(struct update_data *update_data)
 	}
 
 cleanup:
+	submodule_update_clone_release(&suc);
 	string_list_clear(&update_data->references, 0);
 	return res;
 }
@@ -2627,6 +2649,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 
 		if (module_list_compute(argc, argv, opt.prefix,
 					&pathspec2, &list) < 0) {
+			module_list_release(&list);
 			ret = 1;
 			goto cleanup;
 		}
@@ -2643,10 +2666,12 @@ static int module_update(int argc, const char **argv, const char *prefix)
 			info.flags |= OPT_QUIET;
 
 		for_each_listed_submodule(&list, init_submodule_cb, &info);
+		module_list_release(&list);
 	}
 
 	ret = update_submodules(&opt);
 cleanup:
+	update_data_release(&opt);
 	list_objects_filter_release(&filter_options);
 	clear_pathspec(&pathspec);
 	clear_pathspec(&pathspec2);
@@ -2762,6 +2787,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	ret = 0;
 cleanup:
 	clear_pathspec(&pathspec);
+	module_list_release(&list);
 	return ret;
 }
 
diff --git a/t/t6134-pathspec-in-submodule.sh b/t/t6134-pathspec-in-submodule.sh
index 0f1cb49cedc..3a241f259de 100755
--- a/t/t6134-pathspec-in-submodule.sh
+++ b/t/t6134-pathspec-in-submodule.sh
@@ -2,6 +2,7 @@
 
 test_description='test case exclude pathspec'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup a submodule' '
-- 
2.37.1.1197.g7ed548b7807

