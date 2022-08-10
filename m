Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB1BC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 15:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiHJPqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 11:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiHJPqa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 11:46:30 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29F26565D
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:46:27 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id l188so18028168oia.4
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=D62fPlwEP0XCPNqRMMKwc7Br5Fs6K9cqibOGg18QZ5Q=;
        b=LYN9AdqOXD68tLp8T3/BebHGF4Ufg6BW5ij7i41T1QOiLqgUF6+ONT9HureDuKZ0Es
         aXAJlVCRdXo2GHtPyck2eOvRLrOLcDAx9JdXYlGA0vEN7vPn536Db5Wx48XscicCcY4d
         RwGteRMQ2e+P37javJlcOtPUPwR+yOi2J7LVMnW0HQdabNT4zxVF1MDHMLrxUZ8bAZYY
         6KpUrQQwRprfMbxnH2U/Chn+O3320vJme0UGXNOGbmY+onBRAsEYOppqLRvdSAHaE0dZ
         /rziTkvRwSjyEvB/9yMmSswdCAndbveN7Zxp0e4GhD4qZFeLEC8KHX4WHF99qB5T+2xB
         CcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=D62fPlwEP0XCPNqRMMKwc7Br5Fs6K9cqibOGg18QZ5Q=;
        b=zQK5WRIOAXKCkBRIMeU3iYRxR2HulDnmYUzEhCKK2FK4GLKKvY9/H88QDNpvoB99NJ
         1Yn779kAewq9owY7f5XuhcNdYsp0EAsxaVKFjOzm7ZoIrv4VSmeJcQhCUrUwlSjZVle8
         M9v8HBZHmQmRtYzVzyKqIRxXNN2S4JOZqT7bYPwPF+v+jhwsmdFxMitmO2Kg7+ZZA1PQ
         IttowPhVTQDnGbJUftLZtD0RhAohfrfiquYQkRMbmC+Up2jH/XXbEu6JW3YoRYpJyDBu
         S+2ufclUMQiIGnvyp4wSuPj455/lWlvfW5y6wJmji7NRnB1QHTZNpmvvP/NwWC82DBjF
         ajqA==
X-Gm-Message-State: ACgBeo1b+keW0L+hmpD840t4QLhiW4CiQrqQhxN8ac4HwykQfHFKqyFu
        JAdRNR1MhzyToalspLDrV5CX23R4n9k=
X-Google-Smtp-Source: AA6agR6ZGmA0NI2AkRTgKBtCPdcb7sCdUmcEVREL6h5yiEuYjhgOexBQXJJl9D4mJaV6FQqCA/5lmw==
X-Received: by 2002:a05:6808:10c2:b0:33a:c862:7083 with SMTP id s2-20020a05680810c200b0033ac8627083mr1712625ois.172.1660146386488;
        Wed, 10 Aug 2022 08:46:26 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id m12-20020a9d7acc000000b006370abdc976sm706020otn.58.2022.08.10.08.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:46:25 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 4/7] mergetools: vimdiff: fix for diffopt
Date:   Wed, 10 Aug 2022 10:46:15 -0500
Message-Id: <20220810154618.307275-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810154618.307275-1-felipe.contreras@gmail.com>
References: <20220810154618.307275-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When diffopt has hiddenoff set and there's only one window (as is the
case in the single window mode) the diff mode is turned off.

We don't want that, so turn that option off.

Cc: Fernando Ramos <greenfoo@u92.eu>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 mergetools/vimdiff | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 06a7b38841..2ecac41231 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -351,7 +351,7 @@ gen_cmd () {
 	# can't simply append the command to the previous "-c" string as
 	# explained here: https://github.com/vim/vim/issues/9076
 
-	FINAL_CMD="-c \"set hidden | $CMD\" -c \"tabfirst\""
+	FINAL_CMD="-c \"set hidden diffopt-=hiddenoff | $CMD\" -c \"tabfirst\""
 }
 
 
@@ -555,22 +555,22 @@ run_unit_tests () {
 	TEST_CASE_15="  ((  (LOCAL , BASE , REMOTE) / MERGED))   +(BASE)   , LOCAL+ BASE , REMOTE+ (((LOCAL / BASE / REMOTE)) ,    MERGED   )  "
 	TEST_CASE_16="LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE + (LOCAL / BASE / REMOTE),MERGED"
 
-	EXPECTED_CMD_01="-c \"set hidden | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_02="-c \"set hidden | echo | leftabove vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_03="-c \"set hidden | echo | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 4b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_04="-c \"set hidden | echo | 4b | silent bufdo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_05="-c \"set hidden | echo | leftabove split | 1b | wincmd j | leftabove split | 4b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_06="-c \"set hidden | echo | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_07="-c \"set hidden | echo | leftabove vertical split | 4b | wincmd l | leftabove split | 1b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_08="-c \"set hidden | echo | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_09="-c \"set hidden | echo | leftabove split | 4b | wincmd j | leftabove vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_10="-c \"set hidden | echo | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_11="-c \"set hidden | echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_12="-c \"set hidden | echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_13="-c \"set hidden | echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_14="-c \"set hidden | echo | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | 2b | wincmd l | 1b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_15="-c \"set hidden | echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_16="-c \"set hidden | echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_01="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_02="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_03="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 4b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_04="-c \"set hidden diffopt-=hiddenoff | echo | 4b | silent bufdo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_05="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | 1b | wincmd j | leftabove split | 4b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_06="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_07="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 4b | wincmd l | leftabove split | 1b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_08="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_09="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | 4b | wincmd j | leftabove vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_10="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_11="-c \"set hidden diffopt-=hiddenoff | echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_12="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_13="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_14="-c \"set hidden diffopt-=hiddenoff | echo | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | 2b | wincmd l | 1b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_15="-c \"set hidden diffopt-=hiddenoff | echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_16="-c \"set hidden diffopt-=hiddenoff | echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
 
 	EXPECTED_TARGET_01="MERGED"
 	EXPECTED_TARGET_02="LOCAL"
@@ -635,7 +635,7 @@ run_unit_tests () {
 	cat >expect <<-\EOF
 	-f
 	-c
-	set hidden | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | quit | wincmd l | 2b | wincmd j | 3b | tabdo windo diffthis
+	set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | quit | wincmd l | 2b | wincmd j | 3b | tabdo windo diffthis
 	-c
 	tabfirst
 	lo cal
-- 
2.37.1

