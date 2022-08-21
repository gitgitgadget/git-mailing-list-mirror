Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E7CC00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiHUN6n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiHUN6c (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:58:32 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5EBDFAD
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so6426079wme.1
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=kG6xvmLw8G8Iez44RPZVg3tFpKOK4qrGd4LnfhdaHY4=;
        b=ACOIJl0qMX5hHiAbr42V45BxS0e+Sc5DH5WuveA6VXnW/BJR4XoO8cU4dxoYSPQe69
         XhCBWT+nZ5mvTnT74Td6zqAOpSwAOAeZ63TRUqkTpdfqGRLAIBQcMzQyUQZckgsxAXfD
         PGAT7sYjwTdbfbl9QZF1ENOjzlwkp0+SAGYEBILA9JZD53awaP7lnv5Mc/m3lVDQ2vT9
         NfTl7hLeloa7ygNAX68gb9fxBIXcyd4IOvrMgAkqJJwE2NTdp7gJvxA9MmnSct85fn1X
         NqTrAdMySEVIuGJRIxRSTZZNakOMtVa23BKgU0xvGlzJxQS1c3o21+yjxBlUdpiS24YV
         249A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=kG6xvmLw8G8Iez44RPZVg3tFpKOK4qrGd4LnfhdaHY4=;
        b=jUJyF7hus8y85DCWqCE6B2mg2P/fuuYhEtzKjYpCvo7Yd8neeRCI46pGyJyg6Cv1Xl
         xMFZiMGsWtjx8WAskYS+mD6D+YzhzjvrcoAklbE2Tfd3cQQi5bxJDSq4piDr2nbO6uiZ
         8CVxv1iA1v9FIVAnlHdC3OCr7rself0RnYgdbdiVVwBt/M0gXdrwArRtW503F9w1FY/Z
         Vp6QSQXArK8A/qUcxHHbgnuy2aI/EKhbquoNKfWBTsQvKtenWh0WXrUShHp5p2vMIDYs
         v+QpF7QEpMujoP+GeZLcigKdeKDghtenKJqVMfgW9CMhuOXOP89w2lcr4XT8u+szC5Wc
         e1og==
X-Gm-Message-State: ACgBeo183PCaYAEYYyF09ygm0WhrzFNUP24PNOjKAQe9M6we7rD1nb1x
        XqpX9Q4mhK3B19l6zqlP3VYh7XLgZ0F5raQC
X-Google-Smtp-Source: AA6agR7Vl1nAXvoabc9RosfINXzx788iV1CcjIovW/whbfyELLXpe6SyIjwAD2EXUj6YabuVH/s1Vw==
X-Received: by 2002:a1c:3b04:0:b0:3a5:487c:6240 with SMTP id i4-20020a1c3b04000000b003a5487c6240mr12863819wma.152.1661090310105;
        Sun, 21 Aug 2022 06:58:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/32] test-tool submodule-config: remove unused "--url" handling
Date:   Sun, 21 Aug 2022 15:57:14 +0200
Message-Id: <patch-v3-05.32-ef66dfcd45f-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No test has used this "--url" parameter since the test code that made
use of it was removed in 32bc548329d (submodule-config: remove support
for overlaying repository config, 2017-08-03).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-submodule-config.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index e2692746dfd..22a41c40926 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -15,14 +15,11 @@ int cmd__submodule_config(int argc, const char **argv)
 {
 	const char **arg = argv;
 	int my_argc = argc;
-	int output_url = 0;
 	int lookup_name = 0;
 
 	arg++;
 	my_argc--;
 	while (arg[0] && starts_with(arg[0], "--")) {
-		if (!strcmp(arg[0], "--url"))
-			output_url = 1;
 		if (!strcmp(arg[0], "--name"))
 			lookup_name = 1;
 		arg++;
@@ -57,12 +54,8 @@ int cmd__submodule_config(int argc, const char **argv)
 		if (!submodule)
 			die_usage(argc, argv, "Submodule not found.");
 
-		if (output_url)
-			printf("Submodule url: '%s' for path '%s'\n",
-					submodule->url, submodule->path);
-		else
-			printf("Submodule name: '%s' for path '%s'\n",
-					submodule->name, submodule->path);
+		printf("Submodule name: '%s' for path '%s'\n", submodule->name,
+		       submodule->path);
 
 		arg += 2;
 	}
-- 
2.37.2.1279.g64dec4e13cf

