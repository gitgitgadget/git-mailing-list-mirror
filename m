Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F1FECAAD5
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbiHaXSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiHaXS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C204C636
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:26 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e13so19221400wrm.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=b7L7jk7KvnSTSEBJD6g7O+ePLU2qGuW+/SP/1keNRxE=;
        b=qncsce6rmpeNtJSwrLAb1UnHd6h4UV7mYAx+Y8AAUY9O/HC/n8ShzwSwGOTRWT9uxR
         TjMCaSOw1xLREveOFhJTxfKndaHgi1HMJhp0HQvogcIPgCXClt6NTlcPOsOsZjgasj4n
         gYkASmuCcyBxSL1fQnkwK9F91Ew6Zl/BbkDNXib0l3/ALsouZmMQHQ5sAvnaCyNSzEhq
         lx6dMBtiBXp3wMUXbxsJAtQz3rk+9sb+V3EQJjhSTp0gT4R2mVT19SjNs9pcApQP4i+O
         2iezvQwcbCPHCIsHaBoFvZmGkaicqgfLMlbnHUQRGszy+ZR8VkJkeJ8A4/8MbP8iK6WG
         uLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=b7L7jk7KvnSTSEBJD6g7O+ePLU2qGuW+/SP/1keNRxE=;
        b=cOeMBjrqOVvsOEvl++YjoMuyYmypN4Sbdk+p0J0dpxfJ8oAN+0LbL9l9re1JnRLlAU
         qBTGhCliIkTBkDk1bXvMCSfu3EHZwkBm1WmGqWBU2LZseo+pGZrLkt0cAfGJm1jkq0zS
         Oyre4UTbClM1E9QM/F4Z92V4ALJpAX4Aj4Uw/PINnCzxoyggocze/juD4XSl/HlcdfGu
         /4soYjB2xIoakRhshxbgkDEg8fWII8fa2pyJrAcoZuS9z9b3aNA1bflj5v6PIinWxN5o
         epCMhxM2ubwtDPavUYKyEEssrHqfJM8dmphkpIJEwjOoqyZqi2CrJFsyPSDPDAYQ2d0t
         7pWw==
X-Gm-Message-State: ACgBeo2h04SZDlxaPYPEI0uNK1uHvYQlH7shjrsJT8VEP4LT7g23MOQ+
        GNHnabXUWbLAcOplVl/V20znx/u8H7127Q==
X-Google-Smtp-Source: AA6agR5RdP0MU6mPto+tP8PuuJ68OoIHLh6i9sQHSU8SDt8415ALB87zgpsuOLnjGO46Jk8f8gqHSg==
X-Received: by 2002:adf:f7d0:0:b0:225:82fa:422c with SMTP id a16-20020adff7d0000000b0022582fa422cmr12404053wrq.349.1661987904499;
        Wed, 31 Aug 2022 16:18:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 05/33] test-tool submodule-config: remove unused "--url" handling
Date:   Thu,  1 Sep 2022 01:17:47 +0200
Message-Id: <patch-v4-05.33-83516cdcb5c-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
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
2.37.3.1420.g76f8a3d556c

