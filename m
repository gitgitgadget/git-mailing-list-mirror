Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB9EC00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbiHBPzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbiHBPyw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:54:52 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5DC222BD
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:54:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so7168060wmj.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=f/kxyTKz9QoNRDjqExPeti1j/3c003/u0dnBf0TUCMQ=;
        b=KXsy2j6NTIYZ5uAOYaSCmO2of8Fa1T9h8c0ydR4ZIN/bMAz95rOW3p+LhC11cS8roj
         7u0mOf3X9A4XlMFx2ylLu7HkYdwd4cj2tRo2viediDkydERNHsWOl0MZgLL6YgJ+CJS/
         Ew8s3n5AlnkU88nZlLhCBAvcHcoxo6DhdqgRM93aaA+6AGSnEo6n6iI604vui1URph7s
         h1UYqBibSpYYdMHpcd5A1sxJobGUh9I/HcRbOjqImiTqvE73WXsaYl1DN5B7xjrUmcm1
         2ZuzcibxmC4cmLYYmRJseXknU8xg979fPo9pJMVcMc2uHEwIPOtWiLcUBVTkrnO3+iZ4
         CFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=f/kxyTKz9QoNRDjqExPeti1j/3c003/u0dnBf0TUCMQ=;
        b=6zfCIyVBI8AFUtDTMbPmU2PIyloFYyKGUB/D5yw6fSM9EqR+kefAxWNkPYzcmjg3zH
         ed8Yu2BoJOuMZ3BFdrs2vyS0tZG815xS/EhTMA4gpy/Dnchdqi3B2xK7uBCEBjSPv0U7
         Dluex9nRWR5AskwCBvsR8TUqogUN6qec92El5M4O2elOHKuUVSa2XQEshPw2q0QtUkUh
         3DGQDlO5GtcV2ZPKjOkckb/xl0X/s+WUc//ub3uP3p2+r8Z1iJqcakJt+HuSPy70Bedu
         Rp2NwhoR1tplCCxuI4IrjWIcVATpXIk/OCWHvZcL5IAFXFkXuu/OFnWxPhjnoRe8KS5o
         61Ug==
X-Gm-Message-State: ACgBeo0+OyEMYqY2aN22oTJqqmr2LloBTYA28B/tZcUG8exwYMeOiT9P
        DMb+kYzkr9EZrHRbNzV94Oa6YbKfI3rwxg==
X-Google-Smtp-Source: AA6agR6MuPC0AZO7FST9KVp+Z6YRtdh0JMF+ksfaicq3OlYiBnFjJxQwzKhf9vn9IyMCdjt8yxJlGw==
X-Received: by 2002:a7b:cd09:0:b0:3a3:d40:b14 with SMTP id f9-20020a7bcd09000000b003a30d400b14mr58141wmj.177.1659455689185;
        Tue, 02 Aug 2022 08:54:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b003a327b98c0asm23562286wmb.22.2022.08.02.08.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:54:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 04/17] submodule--helper: "struct pathspec" memory leak in module_update()
Date:   Tue,  2 Aug 2022 17:54:28 +0200
Message-Id: <patch-v5-04.17-f768ff2e34d-20220802T155002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
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
index 92d32f2877f..dd9a62d139d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2552,6 +2552,7 @@ static int update_submodules(struct update_data *update_data)
 static int module_update(int argc, const char **argv, const char *prefix)
 {
 	struct pathspec pathspec = { 0 };
+	struct pathspec pathspec2 = { 0 };
 	struct update_data opt = UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options = { 0 };
 	int ret;
@@ -2640,7 +2641,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		struct init_cb info = INIT_CB_INIT;
 
 		if (module_list_compute(argc, argv, opt.prefix,
-					&pathspec, &list) < 0) {
+					&pathspec2, &list) < 0) {
 			ret = 1;
 			goto cleanup;
 		}
@@ -2663,6 +2664,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 cleanup:
 	list_objects_filter_release(&filter_options);
 	clear_pathspec(&pathspec);
+	clear_pathspec(&pathspec2);
 	return ret;
 }
 
-- 
2.37.1.1233.ge8b09efaedc

