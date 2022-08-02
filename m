Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D8CC00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbiHBPzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbiHBPyx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:54:53 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE221248CD
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:54:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j15so10355644wrr.2
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=zW44YT7/Cq/Ntej4p8Rasg1CPMGy4PnivNxEgCDRxwg=;
        b=WlqjG2wiKHs6pp0hg+9AEojZ/B19xbnJ+xQqW4+2lRoVYep0KJhoZEAGHatWth9P+L
         nVnQ5ji8vqoDo9fZ/VngUtspfKkGFmWRy8cQxAV4lT+wZ0YBx9T9dWjuz1lwuk/ViFbs
         p/pvJbVOXq0NPiHgZcnK/RCAMUaRgqNbQarN4fDGqfuME+pZ0JNAglq9CFYTJBi6B0n8
         JDaANXyWV29+hBa6ZRFNmWWTumLWG2nOQfV8D1x2ocnuc5Ny5+tHY7ATD+IIwTIMas5/
         XzfWajT6afR/Flu2kb8gyQn3tzKnmm1O0pJa0vChuZLyKvNVsNOTfK7wfIEW/vUS18/T
         cusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zW44YT7/Cq/Ntej4p8Rasg1CPMGy4PnivNxEgCDRxwg=;
        b=Rm+opLjshQ8YiTYMCR14gWydtobwQMfmmV5PqZGSskYVN0nliFJnNR1AFfYk+i0T1z
         NkRCg3Xc/Fp0aVIh2WhPbwZgJ9IPst+dOi8dWbROl7jh5gd1xnpl6VaWUD5u84Yi1EJ4
         BljCN2ozpyHft0atg2O7GgCA8P96uiFew5N8QN4TXBeKUn0F5Fk+GKsJ2bFOkOYL/pnn
         YZUTs9WHh465aRSx6H8HSANE6LNpOcL3w0cAugTlkI4EobzEaFpbNOSpRxH2ho2QU4oO
         jli8kfDTTDCKf42EthIxXh4akEb+0O21BywjdvHyXHA39ZrOjp+U7GI8LAZBahZPINQu
         nPwQ==
X-Gm-Message-State: ACgBeo0ew/bhh1LY8h9JIrXwElf8dTurBLLc6YYlHoko3G+eSElHWKBT
        TSrJa90KqQHZUonYIJJ/ESmp+ziM2ZKT/w==
X-Google-Smtp-Source: AA6agR6UCYqr9Avs1CTP1VkmkyZb+IrVvqjQoOHvarqMcxBDYXzR8wOSp1NOUXwCfoJwm+1wREySFw==
X-Received: by 2002:a5d:4308:0:b0:21e:4855:f369 with SMTP id h8-20020a5d4308000000b0021e4855f369mr13284641wrq.706.1659455691210;
        Tue, 02 Aug 2022 08:54:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b003a327b98c0asm23562286wmb.22.2022.08.02.08.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:54:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 06/17] submodule--helper: add and use *_release() functions
Date:   Tue,  2 Aug 2022 17:54:30 +0200
Message-Id: <patch-v5-06.17-25377f1d06c-20220802T155002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
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
index 3f79908b203..8e9ef58f8be 100644
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
@@ -560,6 +566,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -737,6 +744,7 @@ static int module_status(int argc, const char **argv, const char *prefix)
 
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -1309,6 +1317,7 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -1461,6 +1470,7 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 
 	ret = 0;
 cleanup:
+	module_list_release(&list);
 	clear_pathspec(&pathspec);
 	return ret;
 }
@@ -1836,6 +1846,12 @@ struct submodule_update_clone {
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
@@ -1874,6 +1890,11 @@ struct update_data {
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
@@ -2545,6 +2566,7 @@ static int update_submodules(struct update_data *update_data)
 	}
 
 cleanup:
+	submodule_update_clone_release(&suc);
 	string_list_clear(&update_data->references, 0);
 	return ret;
 }
@@ -2642,6 +2664,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 
 		if (module_list_compute(argc, argv, opt.prefix,
 					&pathspec2, &list) < 0) {
+			module_list_release(&list);
 			ret = 1;
 			goto cleanup;
 		}
@@ -2658,10 +2681,12 @@ static int module_update(int argc, const char **argv, const char *prefix)
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
@@ -2777,6 +2802,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
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
2.37.1.1233.ge8b09efaedc

