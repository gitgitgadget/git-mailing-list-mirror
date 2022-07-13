Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356CEC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbiGMNQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbiGMNQh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:16:37 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CAD11473
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v16so15435469wrd.13
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f7EIr2ouVyGIb9wMj+zPRZlLs6BZL8FuFoUJKmoK15M=;
        b=epW6b2y3sPXW3AV5iIPpGYwcBsYUWm5a1eZ2uG6+aNoTvMeIpM2EcxB0sIW+fYfPIS
         EjgOZkTq80E9G31+n1HR1VSoSobIBxMoCkeSuNE8fzHNjmRdOjXSw0rdOrC4nAM5dJcQ
         j8/g1zu3T8svtH3QYGd/5T1EmDmQdAd0Cm/gcD55IXF3sNWs+w7i7RMosSFZ8aHK5Q6h
         03WI8dg/qYk8Gx5DIWQUg+Vwl1lVnB+b2zt0Ja0ejSL2DZzUEur3wLrkh2ZfTcrlToSu
         +g/cXIt4C1RPHs+FLDOQRpVk2gbsKCG0GvKG6uRsLfKfeEvOKqtKVHfGzNTL59ENnCK0
         BUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f7EIr2ouVyGIb9wMj+zPRZlLs6BZL8FuFoUJKmoK15M=;
        b=7iA4V2KCVo3K0chosNNOp1wnPWPmgig8P5GrYLZN1QbGK7U5gFaW8FJO+891a1R5Cv
         tSHOx39Qtg7FADMxkHCDcAMNEnToEjYScDs90Njp8sUSDlj4drTb6yLYY36s9TIeVeQG
         gFMGjlN04JgXoStK+0fw/iMhexNXNbalP85Q8rBgbQzJjOzvJFffhNyIf2AoED+P9CxW
         moHuX3ZZbZsYdh9JFIERVCLKuPNyipARdhQy5Bdc4ebPdBh4BcVwTJH4NZrGbvs3kfPn
         tHbAarWkxdmmdIusetKnelQiPwVS3wZvSRG3JR9FhJSB01PsMqGZ/0h6quIPILW2+fWt
         C0JQ==
X-Gm-Message-State: AJIora8ygOGt7HEjjZGMc3n6i1oafhbCekiAP4vtXMvI+XisE4ZOutH3
        apZJJYPzcZsrEfUuzYv0DX+TagxsGp4kvA==
X-Google-Smtp-Source: AGRyM1sJOZJk6pBvyXkhrhSzpnrIRNmGPvIXZ+6Cj79iBr5Xr9vEkvQq0HI2Tu4ly+xSLYwZfxIkLg==
X-Received: by 2002:adf:facc:0:b0:21d:8c8f:4b51 with SMTP id a12-20020adffacc000000b0021d8c8f4b51mr3150546wrs.307.1657718191398;
        Wed, 13 Jul 2022 06:16:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t63-20020a1c4642000000b003a2e05a81b3sm2216352wma.8.2022.07.13.06.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:16:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/11] submodule--helper: add and use *_release() functions
Date:   Wed, 13 Jul 2022 15:16:11 +0200
Message-Id: <patch-06.11-b9984e982db-20220713T131601Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.932.g7b7031e73bc
In-Reply-To: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add release functions for "struct module_list", "struct
submodule_update_clone" and "struct update_data". For now we're
leaving some of the "struct update_data" members, we'll deal with
those in a subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c      | 30 +++++++++++++++++++++++++++++-
 t/t6134-pathspec-in-submodule.sh |  1 +
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2099c5774b2..a964dbeec38 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -182,6 +182,11 @@ struct module_list {
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
@@ -243,7 +248,7 @@ static void module_list_active(struct module_list *list)
 		active_modules.entries[active_modules.nr++] = ce;
 	}
 
-	free(list->entries);
+	module_list_release(list);
 	*list = active_modules;
 }
 
@@ -307,6 +312,7 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	}
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -465,6 +471,7 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -612,6 +619,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -791,6 +799,7 @@ static int module_status(int argc, const char **argv, const char *prefix)
 
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -1387,6 +1396,7 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -1541,6 +1551,7 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -1910,6 +1921,13 @@ struct submodule_update_clone {
 };
 #define SUBMODULE_UPDATE_CLONE_INIT { 0 }
 
+static void submodule_update_clone_release(struct submodule_update_clone *suc)
+{
+	/* Not "update_data", owned by update_data_release() */
+	free(suc->update_clone);
+	free(suc->failed_clones);
+}
+
 struct update_data {
 	const char *prefix;
 	const char *displaypath;
@@ -1948,6 +1966,11 @@ struct update_data {
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
@@ -2618,6 +2641,7 @@ static int update_submodules(struct update_data *update_data)
 	}
 
 cleanup:
+	submodule_update_clone_release(&suc);
 	string_list_clear(&update_data->references, 0);
 	return res;
 }
@@ -2716,6 +2740,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 
 		if (module_list_compute(argc, argv, opt.prefix,
 					&pathspec, &list) < 0) {
+			module_list_release(&list);
 			ret = 1;
 			goto cleanup;
 		}
@@ -2732,10 +2757,12 @@ static int module_update(int argc, const char **argv, const char *prefix)
 			info.flags |= OPT_QUIET;
 
 		for_each_listed_submodule(&list, init_submodule_cb, &info);
+		module_list_release(&list);
 	}
 
 	ret = update_submodules(&opt);
 cleanup:
+	update_data_release(&opt);
 	list_objects_filter_release(&filter_options);
 	clear_pathspec(&pathspec);
 	return ret;
@@ -2854,6 +2881,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
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
2.37.0.932.g7b7031e73bc

