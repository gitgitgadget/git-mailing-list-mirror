Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3232C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiHUOCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiHUOBw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 10:01:52 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DB824969
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:08 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so4722900wmb.4
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Aht2eLDQVtsdxjnDkuMxV4rf4sCd9KnLpTrEC/CllNs=;
        b=lF+CM7OgUfFEE8kZZt2qgi+T3DmJ6KApzKAdcXxK30HE6T8G9odXNaFFKWVekALFd2
         vuLyr1QIVY0cxVBAGwkl2udvO0MdGcFPIUYYrHMIM+R8N5Nwn3S1QnvVwqq04FkxKy3Y
         ArvV/7m18eI4C5snNMG8Gzr57+rCoKUp697WOl59RQZJXWrlKKBSa2ZQvVq192gaqwjB
         hRxs2Ld8SxZT75+G+fEO1wRpoTNUwzxHwaBP9Epwa6QLKOovHRz0i9BEKz2fM24v8wj5
         Xmk+DwIj/8QJ2NyOmgmbCARtCBc53RfoWWsxSPD0lxj8K5qhuBWbqxKcvaa8OGrjQSUl
         hGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Aht2eLDQVtsdxjnDkuMxV4rf4sCd9KnLpTrEC/CllNs=;
        b=7UZyFqeudFM6HWAGtR5NgRdHzYX/fiefz/0N+sLITPW3bP4LK1GCFAqd/qNUCcDK/D
         HeEiGtENiVWyuzff2Nif0Ov8tWsIHG+NeMtx4P7MTajYzB54dSpX10uyHNcRgkYddzjC
         W3Ugy1160n8740FDj2j1kHQ5+RcO8KjpJbh9xilog+EE5Pkz8Q7KWR0H0+Qn10qb8LHc
         LdIV1ds6GBFIeXK+M8adGvsV7dXbLwWLqGIqDp2cRjo3zJR7Sct01yu5e76GVgmxJMj4
         0xbSadWGMo6YEKFGYSGQZmVH/le0xCE9l6GD+YnFZWrMU/lI4dEin6+vYdaWn0FyoUAq
         8mQA==
X-Gm-Message-State: ACgBeo30000Bab16baKJUGySPyhdoVx0D0IfeifHBibuiy4mv3tSyvG1
        tx2iqBN9P9DhkhLR6vC33zfu9/aZHSqy5Ca4
X-Google-Smtp-Source: AA6agR4IP/FCb8b+p5Lvq25C53gK36UEdTEm+ki6PYBj2Edh8UlDWZKPST4jdOmkLCHEPUFByKFq7A==
X-Received: by 2002:a7b:ce13:0:b0:3a6:34f8:e21d with SMTP id m19-20020a7bce13000000b003a634f8e21dmr7099202wmc.22.1661090466115;
        Sun, 21 Aug 2022 07:01:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q4-20020a1c4304000000b003a5c7a942edsm14449642wma.28.2022.08.21.07.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 07:01:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 04/17] submodule--helper: "struct pathspec" memory leak in module_update()
Date:   Sun, 21 Aug 2022 15:59:28 +0200
Message-Id: <patch-v6-04.17-8fc3dad316e-20220821T130415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The module_update() function calls module_list_compute() twice, which
in turn will reset the "struct pathspec" passed to it. Let's instead
track two of them, and clear them both.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a118f615783..64dc906b5e6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2562,6 +2562,7 @@ static int update_submodules(struct update_data *update_data)
 static int module_update(int argc, const char **argv, const char *prefix)
 {
 	struct pathspec pathspec = { 0 };
+	struct pathspec pathspec2 = { 0 };
 	struct update_data opt = UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options = { 0 };
 	int ret;
@@ -2650,7 +2651,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		struct init_cb info = INIT_CB_INIT;
 
 		if (module_list_compute(argc, argv, opt.prefix,
-					&pathspec, &list) < 0) {
+					&pathspec2, &list) < 0) {
 			ret = 1;
 			goto cleanup;
 		}
@@ -2673,6 +2674,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 cleanup:
 	list_objects_filter_release(&filter_options);
 	clear_pathspec(&pathspec);
+	clear_pathspec(&pathspec2);
 	return ret;
 }
 
-- 
2.37.2.1279.g64dec4e13cf

