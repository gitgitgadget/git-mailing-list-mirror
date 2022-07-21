Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D47C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbiGUTOM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiGUTOD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:14:03 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AE18D5DE
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:53 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so3900006wmb.5
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7QSFgwic6tV5PG89CARSp/V82j71/gfwiS5SsCs21nA=;
        b=keViqC6UdrGhI5pC0FwsYc4s1x7X74ZErlwwLnw5+USR2NweyvNlZDAzxh/aH9hlRs
         kjRvco1Xm5EG+IIUd7HXyy09psrr8Ryi7oPD+boRLI1xXqbuF1zWNeqYvidbgLP+vM1i
         7xRth2KdfGCAguTa8kzeQNY/IcI403qlW+6PBQMSXbc43cvsPYiH6mIMGvK5WtSAgjcS
         VwbV5+ST6vuAbQtxWriQSX6oSHlOk1/tgDAAokMIPRiK5wa27h2BJQwpS0ncFz2Ld9VT
         swsJpWIsJu8L+QQQssCRBlqt/Tt3YaW07gTnRUZoPqgeqm+NnERTg/lNkV/UXowzezbG
         Kfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7QSFgwic6tV5PG89CARSp/V82j71/gfwiS5SsCs21nA=;
        b=CQH2g2tDXjqiOHSKhH0y9VfX4SQSsoF6erk7CRuZ6gLIgyXz6hkKz64LvGF1DR1K4F
         vBPkPi90jqr+/KeynO8tqf4xYxJ5VOdpwENQHic3BkEQUp0W2dd8NRdSfGRW4ECCKKox
         XLhpyInSUsDAjUdLzWWMGEk/q9f1Yucu6IV0AX2brfplN3eLn5z2UOR8cxmD+AcKNtk+
         MS/SOIcoTyU2RN9aLuVYSwZXS50w9DuizVX1kDD0rbajzpXvbODq/Gvf/pRzHm7vVlZj
         7uLV8oqQStehvMWn3zitalgtakKwnUd5EMpHqKc5kxN+FWvmBc21d70qfS8yumrXQNVW
         8d9w==
X-Gm-Message-State: AJIora82JPyeSAsGCVE0ivDboZD2/YEhODgCumfK2tNsR8ZICmgnq8YL
        zi1NLGLD/4hhGFmbwJfez82okZHhsbgAag==
X-Google-Smtp-Source: AGRyM1udmMKqP6aHDbXo61vta1yODQJ0opRDQb6kiHHJ1/J3kVWwr2EspaJh5bRs+BEMoQ60797FZw==
X-Received: by 2002:a1c:7209:0:b0:3a3:1f31:ef3a with SMTP id n9-20020a1c7209000000b003a31f31ef3amr9407184wmc.87.1658430831861;
        Thu, 21 Jul 2022 12:13:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:13:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 10/26] submodule--helper: add and use *_release() functions
Date:   Thu, 21 Jul 2022 21:13:06 +0200
Message-Id: <patch-v3-10.26-6ab5aabae35-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
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
index 3223c93f91a..21b3abb7b40 100644
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
 
@@ -305,6 +310,7 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	}
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -461,6 +467,7 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -606,6 +613,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -783,6 +791,7 @@ static int module_status(int argc, const char **argv, const char *prefix)
 
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -1376,6 +1385,7 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -1528,6 +1538,7 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 
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
@@ -2831,6 +2857,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
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
2.37.1.1095.g0bd6f54ba8a

