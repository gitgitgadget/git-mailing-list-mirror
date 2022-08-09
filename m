Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AAFC00140
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 00:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244741AbiHIAqC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 20:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244457AbiHIAp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 20:45:56 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99502607
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 17:45:55 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-10ec41637b3so12413325fac.4
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 17:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=/KsMV8bO28r8XWPibTJUsU4WPAuMb/p+GBwUmaHVRNg=;
        b=mFeMk6vwgXG+q9Kkd5C6KG6KbwtSt1quIwqu5qLI8YcrQql+c4KEvZ4Ms/MmdE17by
         +6kgqys3wWSWWcd1WN1Lp3rA17DY0mtEvrtbBcxkwdm6F4rzgPHppHxx6ujl7GnJZoOP
         XtHTJmYx3yNEi2FNK+4/AVBCjke855btSr0lO9cD9ZtvZ62x0PZeQ9QHfJXgiGfIRlPb
         uNY6KFmpfHRLQhVvs/6V7sXn988hi/nrPWs64NsdWAMZ9mqzaEIaRnQUYpaQi8rdkPCK
         4BYj51kLHJFMZm2Fir2e2VbTz3C4UmPIy/MD60LzmtaENoMAqV+7ivV1+LkaqZYUOObE
         XOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/KsMV8bO28r8XWPibTJUsU4WPAuMb/p+GBwUmaHVRNg=;
        b=tkxaXhd6leq4d+2wuauEmfdhbVyEOdZe6IeENdaUUSsSDJo+NhKfSy5zD0WjBwuIeq
         WVIyMs/wyIhFzloY9QbssoWSDG75gKRfHpidhZeByzv1CmWv1GQB7Pu4vrfJCNtZkKwm
         Uj9kwKmnwhqNdvJKQY46DC9DYBNRaB5ZOWgun1H+laMReB5U7XFjY5Xy6NcS17raj9Za
         sfAVv8bUSYofRbWK45Iwsha8vshCjyuNtPpNXLHdN8CJwtM4BSHbRJrVtyLguMAGGM2o
         Cb0EHRlKGpAVOn3d3fibo6M58AoXvTb3uNSckSfrZbtNL1Z79uC56vgVp2RGERjGFGzR
         tgyw==
X-Gm-Message-State: ACgBeo2lMN0m+J2U6daZ8OkX2y5ebNKiebeHJs0uohi1+GPbxv9gYd4e
        ZzAhg3lVZWBcPyuXtqZq5MmK7pxXn2s=
X-Google-Smtp-Source: AA6agR76vTv97qRdMIEL7OpGCRiucYTxacK/LWjpZ7zc08RdeE/mmjPKd+onLhkjN9KXHiJXELqk1A==
X-Received: by 2002:a05:6870:42c3:b0:101:c31d:c40e with SMTP id z3-20020a05687042c300b00101c31dc40emr12964773oah.39.1660005954681;
        Mon, 08 Aug 2022 17:45:54 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:afaf:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id k204-20020aca3dd5000000b003430f19e11bsm220403oia.17.2022.08.08.17.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 17:45:54 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 3/7] mergetools: vimdiff: silence annoying messages
Date:   Mon,  8 Aug 2022 19:45:45 -0500
Message-Id: <20220809004549.123020-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809004549.123020-1-felipe.contreras@gmail.com>
References: <20220809004549.123020-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using the single window mode we are greeted with the following
warning:

  "./content_LOCAL_8975" 6L, 28B
  "./content_BASE_8975" 6 lines, 29 bytes
  "./content_REMOTE_8975" 6 lines, 29 bytes
  "content" 16 lines, 115 bytes
  Press ENTER or type command to continue

every time.

Silence that.

Suggested-by: Fernando Ramos <greenfoo@u92.eu>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 mergetools/vimdiff | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 95d637b997..06a7b38841 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -343,7 +343,7 @@ gen_cmd () {
 	then
 		CMD="$CMD | tabdo windo diffthis"
 	else
-		CMD="$CMD | bufdo diffthis"
+		CMD="$CMD | silent bufdo diffthis"
 	fi
 
 
@@ -558,7 +558,7 @@ run_unit_tests () {
 	EXPECTED_CMD_01="-c \"set hidden | echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_02="-c \"set hidden | echo | leftabove vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_03="-c \"set hidden | echo | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 4b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_04="-c \"set hidden | echo | 4b | bufdo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_04="-c \"set hidden | echo | 4b | silent bufdo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_05="-c \"set hidden | echo | leftabove split | 1b | wincmd j | leftabove split | 4b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_06="-c \"set hidden | echo | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_07="-c \"set hidden | echo | leftabove vertical split | 4b | wincmd l | leftabove split | 1b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-- 
2.37.1

