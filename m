Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592D6C3F6B0
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiHUOCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiHUOBw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 10:01:52 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D1D2497E
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:10 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r83-20020a1c4456000000b003a5cb389944so6415902wma.4
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=sWfspdEroPEBYjjQGCcPIcZhPAhWaQu6xpL+8f+LWcE=;
        b=HsEHWhFvsYuh1F63aY7yiVeYIiAq70mBbA1ZsituHfIasV78kwAcFuV8GGmXtvyuIn
         jNNpXSTn7NV8ediZNopZ2V/127q75l6KMKsJGN3YSQIYlZ5F/FP3ffatIlwK9MFx/fCE
         FPfZACRseFLC5KrgdltorUFATP6kVLxeMYXsNX21SZehTeHFP7DduLRtXJKisP8TjXj+
         ZB3VPmOHihwFhK6e3EKLIH6fqBdyVIx81Ge+XgN3ldpx5Y5mVkXn8EeGlwPAE7M/JysC
         kG6eSYRKcyTYcGskPJdqmfZz7u12Pr4lIPncMr2ULSPmJaKLRiVJVl08u8/C1C+O8Hgk
         5Uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=sWfspdEroPEBYjjQGCcPIcZhPAhWaQu6xpL+8f+LWcE=;
        b=N9g0oKaYkSLd4c6tFGW6cg4e+HpyT6ptF436TLKQRtZLZV/GgbtpYbetcX4KfQQgtq
         XIJvUghj4xqVuk55A/GquLmeE8cUnpyum24lDYOgHn9TbXUWrrThPZkI6TpW3AgPWtwC
         6q13YJ/nEvpWP8oewRKGIu/yUQnV2faIaTstaV7vDsJB3UVswjL0czprlgLDomRFzwsK
         T7XXBPAck81BMGsn/63xAatwCAfLwJaEAOhnqroknVQKrmpdAXAkABMIisT0SKbA30QM
         7C8GjmlqgfCBqyjPiDeOg7CPF+vth8xAFomqDMYVH9Y07ub37w6b+VaWXzRMsuDeE07f
         nqcw==
X-Gm-Message-State: ACgBeo2L3TbG8hNKe4Qwt0/TcSB7YccW1F925vGGdBmmFo6sfVsBO4fS
        3d9jr0szSga/NSDAwKc6XP2K+CkSWUO9aEXS
X-Google-Smtp-Source: AA6agR5OV3AAcrUHDRbCS14BKyvl/ay4H37pBslLi8Isg5+yOBrSYW+snfQqzGx97hvq8+Bt/DRIxA==
X-Received: by 2002:a05:600c:4e12:b0:3a5:dac2:5cec with SMTP id b18-20020a05600c4e1200b003a5dac25cecmr12832496wmq.183.1661090468405;
        Sun, 21 Aug 2022 07:01:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q4-20020a1c4304000000b003a5c7a942edsm14449642wma.28.2022.08.21.07.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 07:01:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 06/17] submodule--helper: add and use *_release() functions
Date:   Sun, 21 Aug 2022 15:59:30 +0200
Message-Id: <patch-v6-06.17-173dbb7d8fc-20220821T130415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
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
index 5eb6bec4c63..fa320eb2edf 100644
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
@@ -2555,6 +2576,7 @@ static int update_submodules(struct update_data *update_data)
 	}
 
 cleanup:
+	submodule_update_clone_release(&suc);
 	string_list_clear(&update_data->references, 0);
 	return ret;
 }
@@ -2652,6 +2674,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 
 		if (module_list_compute(argc, argv, opt.prefix,
 					&pathspec2, &list) < 0) {
+			module_list_release(&list);
 			ret = 1;
 			goto cleanup;
 		}
@@ -2668,10 +2691,12 @@ static int module_update(int argc, const char **argv, const char *prefix)
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
@@ -2787,6 +2812,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
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
2.37.2.1279.g64dec4e13cf

