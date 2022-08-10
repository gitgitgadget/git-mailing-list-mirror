Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6A2C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 15:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiHJPqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 11:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiHJPqd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 11:46:33 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1969C6C134
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:46:32 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id z22-20020a056830129600b0063711f456ceso2959668otp.7
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=NOw/4aTbF2oYA41XIhgX4HaaR8IyfgJw4zMqrejEcJ8=;
        b=XQWh2JpHXYucIPTsCPLVoYqYNRepuLEHYZ0fqstUmVXWJQaHy3n6xHXaPTVG0Vn2VL
         N+5iYB9XQpRGGJfWulaZ7D69/oZbQYQRoJA+/AqeDEDzx4ndk5EeW5pu7d1RwK/wRJLN
         0vi6/pIR9Q5nUBTdUzFfblK1gYTtDtwECDpD057CYUu2Mp3AJOiOzxHwF2Ehw3mSWDYk
         qP3bV4BDPnUzdj+Mw6w/vrno1vT5so9jY78uyWMnRrZb6C2oyFToLEtUIqTD0LIxMGYg
         /dXMVaNhwZAqZBop7BFfhRxMXBSdCWJTlixLsb180K8elERWxVunvBOKW+njbkTGXFdR
         wdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NOw/4aTbF2oYA41XIhgX4HaaR8IyfgJw4zMqrejEcJ8=;
        b=3RpAdb366hdbOSHp837W0NQG0pIrELAgBy5ge6eoTz7SNk98PiGBshFLCHXPlMnHUw
         NkWEITTYy29fFVNjPSWYt8+PrZWYXqEzPREUgFlDVsfWBYCxUIJ23CZL6MeEy7zqqkFK
         C3M2LL2l0IH0Lm2Yz9K+DySXNJI2c9GFL+S2DBnzIZaULL11bUUixxamWl7h8IuGdmyx
         ts3rgEH5BUYUMcVGlNQ1NNIT3Dd3owTJBMkSfEdHtG+8YvIL8VT00bXrp1W4Is9a+lHE
         jV/4q/V+sKdG2anpw/FW9trA5aGGSoOWGA+a+xaWCpLg6UDkdhbrUvtPjDbCSOipfhdO
         7c1Q==
X-Gm-Message-State: ACgBeo3Co+IKWQfhU7I14ir24TFxZSHjz2M6J92zcpOuHAVG2sZ5VyHP
        v4WyOAVp9QrkHurebBN6yfQUtlTMDas=
X-Google-Smtp-Source: AA6agR6yVVjtGQcsqZb9aLVN6JoOjguG61A4NSWWMfGAoJeJVpt5ECv/yPEL8oz2w2U4fuqi0k9Axw==
X-Received: by 2002:a9d:5f16:0:b0:628:192c:dff1 with SMTP id f22-20020a9d5f16000000b00628192cdff1mr10194991oti.126.1660146391090;
        Wed, 10 Aug 2022 08:46:31 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id bi1-20020a056808188100b0033ac7e40050sm658996oib.52.2022.08.10.08.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:46:30 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 7/7] mergetools: vimdiff: simplify tabfirst
Date:   Wed, 10 Aug 2022 10:46:18 -0500
Message-Id: <20220810154618.307275-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810154618.307275-1-felipe.contreras@gmail.com>
References: <20220810154618.307275-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we wrap the tabdo command there's no need for a separate command
call.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 mergetools/vimdiff | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index e27734b6e7..06937acbf5 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -335,13 +335,9 @@ gen_cmd () {
 	done
 	IFS=$oldIFS
 
-	CMD="$CMD | tabdo windo diffthis"
+	CMD="$CMD | execute 'tabdo windo diffthis'"
 
-	# Add an extra "-c" option to move to the first tab (notice that we
-	# can't simply append the command to the previous "-c" string as
-	# explained here: https://github.com/vim/vim/issues/9076
-
-	FINAL_CMD="-c \"set hidden diffopt-=hiddenoff | $CMD\" -c \"tabfirst\""
+	FINAL_CMD="-c \"set hidden diffopt-=hiddenoff | $CMD | tabfirst\""
 }
 
 
@@ -545,22 +541,22 @@ run_unit_tests () {
 	TEST_CASE_15="  ((  (LOCAL , BASE , REMOTE) / MERGED))   +(BASE)   , LOCAL+ BASE , REMOTE+ (((LOCAL / BASE / REMOTE)) ,    MERGED   )  "
 	TEST_CASE_16="LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE + (LOCAL / BASE / REMOTE),MERGED"
 
-	EXPECTED_CMD_01="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_02="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_03="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 4b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_04="-c \"set hidden diffopt-=hiddenoff | echo | silent execute 'bufdo diffthis' | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_05="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | 1b | wincmd j | leftabove split | 4b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_06="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_07="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 4b | wincmd l | leftabove split | 1b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_08="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_09="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | 4b | wincmd j | leftabove vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_10="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_11="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_12="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_13="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_14="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_15="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_16="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_01="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_02="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 1b | wincmd l | 3b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_03="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 4b | wincmd l | 3b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_04="-c \"set hidden diffopt-=hiddenoff | echo | silent execute 'bufdo diffthis' | 4b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_05="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | 1b | wincmd j | leftabove split | 4b | wincmd j | 3b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_06="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_07="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 4b | wincmd l | leftabove split | 1b | wincmd j | 3b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_08="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 4b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_09="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | 4b | wincmd j | leftabove vertical split | 1b | wincmd l | 3b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_10="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_11="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_12="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | 4b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_13="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_14="-c \"set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_15="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'tabdo windo diffthis' | tabfirst\""
+	EXPECTED_CMD_16="-c \"set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnew | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'tabdo windo diffthis' | tabfirst\""
 
 	EXPECTED_TARGET_01="MERGED"
 	EXPECTED_TARGET_02="LOCAL"
@@ -625,9 +621,7 @@ run_unit_tests () {
 	cat >expect <<-\EOF
 	-f
 	-c
-	set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | quit | wincmd l | 2b | wincmd j | 3b | tabdo windo diffthis
-	-c
-	tabfirst
+	set hidden diffopt-=hiddenoff | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | quit | wincmd l | 2b | wincmd j | 3b | execute 'tabdo windo diffthis' | tabfirst
 	lo cal
 	' '
 	mer ged
-- 
2.37.1

