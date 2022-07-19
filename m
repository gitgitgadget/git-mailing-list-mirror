Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56EFC433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240104AbiGSUrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbiGSUri (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AD351A08
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:33 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so62289wmb.5
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5zOJQ+E+PlACHytMmRlQvw7aKNDdqDnkM9aCFV4uZFs=;
        b=NOyDhmJXws+xoNpuD8LpOLEocUaiHWpAwVkhm7WZ/h/5wQz3N/dQK+KpZvZK4HNaZE
         Hha5WaeJ9OnS77OR2+ELWLTtJFIaImOQZQeDnEMYsg3gUvs9KN7u4y57ki+C7uSPPHgX
         d4G6cB9BTTNXK2X0/+dh5+3oV7u/b+h/TMW3Bc9lMPb34y6dCMV9PGsILcgk9sBOjo+4
         XGIf1XuH72Eg6FPs2HHrxcNoHR8szmxoXJwplZ+BcKyOogxRmQ/12GAKnIOTxBMaM4Sg
         6HwDTJyquTxeZiytC/kuQ4U/reUqYzMbpGJ3aSfmsArA728s+PaMESuttsx0dlWaugdq
         ieVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5zOJQ+E+PlACHytMmRlQvw7aKNDdqDnkM9aCFV4uZFs=;
        b=4x4WwyQi/hFQKctNy7rBpMccCDCu5HNsn4btQoDpFBRghyRp8ZCX7/fDYw2/xB71ms
         mPpLQXs1QoKbwRZvMyC0Fdx9ERUMtRufTu+B0P0jox5vBzC34Zb1ZlImg7XCLwGucAA0
         jNoRBj/CYMLwMyBoN/M/0vUWx287YwKuc6U8zPFDJhPCLtcZAwhxXoDVlH7kizPygquW
         fjGBQQrGkfKz9N2UxG5IIPH/UDd49uurVGGRG21jlG2m69XVMhrLo8Mvw0+EIi8auc7W
         ubSxJ+2pUGLIwWPJywMVgMPwM2leiLdzfrZDbfHlTn+t84p6/wWsPpWjHvX6cRthBM1e
         Ii8g==
X-Gm-Message-State: AJIora/rbftXvwsoZ5EHoCiuYL5nLulLsVL99XCpuIMtSnByAX7aS+BI
        P1KsYb6inrwMmh0ewRnxGlcckGWOpzHmJQ==
X-Google-Smtp-Source: AGRyM1sKdlegkiBvB/7qIOcwALFK69i9y5Cy48cbkmSjbA5jRI5HBzRehG/DhqKEumPG18X5/z+DGw==
X-Received: by 2002:a7b:c453:0:b0:3a3:1c65:ff97 with SMTP id l19-20020a7bc453000000b003a31c65ff97mr870411wmi.180.1658263652475;
        Tue, 19 Jul 2022 13:47:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/24] submodule--helper: add and use *_release() functions
Date:   Tue, 19 Jul 2022 22:46:59 +0200
Message-Id: <patch-v2-08.24-b7582391c91-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
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
 builtin/submodule--helper.c      | 29 ++++++++++++++++++++++++++++-
 t/t6134-pathspec-in-submodule.sh |  1 +
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7e9af9999bb..5d26e188560 100644
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
@@ -1904,6 +1915,12 @@ struct submodule_update_clone {
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
@@ -1942,6 +1959,11 @@ struct update_data {
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
@@ -2595,6 +2617,7 @@ static int update_submodules(struct update_data *update_data)
 	}
 
 cleanup:
+	submodule_update_clone_release(&suc);
 	string_list_clear(&update_data->references, 0);
 	return res;
 }
@@ -2694,6 +2717,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 
 		if (module_list_compute(argc, argv, opt.prefix,
 					&pathspec2, &list) < 0) {
+			module_list_release(&list);
 			ret = 1;
 			goto cleanup;
 		}
@@ -2710,10 +2734,12 @@ static int module_update(int argc, const char **argv, const char *prefix)
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
@@ -2833,6 +2859,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
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
2.37.1.1062.g385eac7fccf

