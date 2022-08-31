Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D55DECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiHaXPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiHaXOz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:14:55 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F062F3D
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:51 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id az27so20127114wrb.6
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Qi4agyD/LA8El8RXzhvsSF8DI0jluhgQGU6OkmGzv0s=;
        b=R6mns3HlB8Z4ilJ1GrCKRy670935pvlXE7UT9PVIRKT8iLNUzSLVY4+nZG/mi1vLyu
         0FfUoiw5xcDPDZ3io2JYonBIC6BWUa/Ad81KeJHVy13e+wH1MM90TMMnqU+850JVlnJJ
         qYldOqf8XpiL2tyNktvb67W1n4nqeihMEhLHro6qmuZZfspZrX3EObmSgIqA50WaIUfY
         2e5cvh8KrkiGzd13YJtI33iqnqGJlVRrJ2PNvOvHP1gSu/1BGrTtoJJKW7EFh399v2jB
         Q63a/H07TjCnPnW+tSGEVgIA814/OojNam8T3OaKfWCaPqRhcsl+v2NPtAXRK1+udzU2
         V5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Qi4agyD/LA8El8RXzhvsSF8DI0jluhgQGU6OkmGzv0s=;
        b=UQGCpwLN7Fi3mCH9UQ6meY1ZjHOd//lzyR2dJXHT/gPe7ebirG0iJZzQUknkS0D95M
         yVWXTyoY8/rNwJ/GT3lRMmpfRHQLj3v5elQp5VGh14H99pD68b795pGx3tCe51yI0ImJ
         mxrsW4Dv0/fqPVBPwF8h3lX1xq1Tg3Uc4ilxHNR4eDMe3hAmcY0jzZvQCz+n3iJeBqQP
         c2mDLO/ZNbSEC/8wEO8ZMsE8T7agrEDlzB9eBj9NqjY9aeGnHzxel/vS8PZ40OyJ09Iv
         Uk02yv16zZFlgqqBqgwp5fG5YjJih01/vLCuhF15coi4KaS/Bs7zU9m/HwV33WEMHWD4
         zFyg==
X-Gm-Message-State: ACgBeo12S7pCH65LAqnxBux8V4G7Qt6oVMlP/f3dRw17wznAxwIM/X7t
        9tthQaNf9GcNKeWN6KBqu5KAJAo7z5zeZA==
X-Google-Smtp-Source: AA6agR7W39zuL3/Gt+fs1sryx5jbqUwGDnBzfGTKre+PqpP5NDUgyytQtFt3ZDHGJFYEgPGbbdcdKg==
X-Received: by 2002:a5d:5350:0:b0:225:7560:8403 with SMTP id t16-20020a5d5350000000b0022575608403mr12229065wrv.507.1661987689133;
        Wed, 31 Aug 2022 16:14:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c058e00b003a5ad7f6de2sm3484666wmd.15.2022.08.31.16.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:14:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 06/17] submodule--helper: add and use *_release() functions
Date:   Thu,  1 Sep 2022 01:14:13 +0200
Message-Id: <patch-v7-06.17-07a4cda579f-20220831T231003Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
References: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
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
index 0c23dd93d96..ae918a662b4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -172,6 +172,11 @@ struct module_list {
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
@@ -234,7 +239,7 @@ static void module_list_active(struct module_list *list)
 		active_modules.entries[active_modules.nr++] = ce;
 	}
 
-	free(list->entries);
+	module_list_release(list);
 	*list = active_modules;
 }
 
@@ -407,6 +412,7 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -553,6 +559,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -730,6 +737,7 @@ static int module_status(int argc, const char **argv, const char *prefix)
 
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -1305,6 +1313,7 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -1457,6 +1466,7 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -1834,6 +1844,12 @@ struct submodule_update_clone {
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
@@ -1872,6 +1888,11 @@ struct update_data {
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
@@ -2557,6 +2578,7 @@ static int update_submodules(struct update_data *update_data)
 	}
 
 cleanup:
+	submodule_update_clone_release(&suc);
 	string_list_clear(&update_data->references, 0);
 	return ret;
 }
@@ -2654,6 +2676,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 
 		if (module_list_compute(argc, argv, opt.prefix,
 					&pathspec2, &list) < 0) {
+			module_list_release(&list);
 			ret = 1;
 			goto cleanup;
 		}
@@ -2670,10 +2693,12 @@ static int module_update(int argc, const char **argv, const char *prefix)
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
@@ -2789,6 +2814,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
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
2.37.3.1420.g76f8a3d556c

