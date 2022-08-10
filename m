Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B23C25B07
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 15:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbiHJPqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 11:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiHJPq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 11:46:27 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30385A156
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:46:25 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-116c7286aaaso2349481fac.11
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=/KsMV8bO28r8XWPibTJUsU4WPAuMb/p+GBwUmaHVRNg=;
        b=lrzlm+rIkKCFf2aiOZRsT1fqBBZ/wtF+ok/ZPtUdcDpGA+YPE8RjnEBJliCx2ViMYx
         Y6ZaRBOuRTnzFGse1GhFRs4PWAPpQ4BND/cro1vZatJjnEUA1Jo3chEfeMmie8ZCPTud
         33BjPAeWbSE9z784KM/NOgqCPk3edj5It2DtjrxVLFLael66zXYaj67ELB/6xs2Yz4hF
         AI5+jQptpcGO5jx/oEyoBfsgprEiPfoBOgb47XfqsIoiho9blI4ypr48G/ztbbyu86RX
         tMOtnwqMihHgpvyfkEc4OTlhNq2Vcy+sOCIaufN8svVTbENXxnkqidf8duLNg+IPwPK+
         8Txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/KsMV8bO28r8XWPibTJUsU4WPAuMb/p+GBwUmaHVRNg=;
        b=yL17CkXB6ibxplEd2RooUohQTCQt0Rd/ZW7E8nwDyIwLA7W+HHId8V8Rmt5QTiZOCf
         ERZtsq96NWBPsxe/j81yKTfMr+gmYHd0gCJ3Ho/Snq5GT9sXv6CRBg9VVeSpScP1UWiV
         SFr5S6SQjmR6Rf1x887HqcobeMQiwfYuCu7tM0Abz0iZmRlT8ex1gCC5iab3aP/21ufz
         XbYq5Nm//idnVg/dF0zfHE5OVyqFOSJvqG1suWoqlgvy1x1dLu0rCBitvh79lOLWlVer
         xKRtOg3wgwGlhljfcW1ghOAdbAv5kqxFpeXajS4bymb6wPrdVE5fzOePCkhvwWs9kgM4
         BuZw==
X-Gm-Message-State: ACgBeo0AC4M++rTZfKPCZ9mKS2FaqrGbn5EuPs62FbmmHngF8W6j05ox
        soilHo/0d6PqVK7D/Xd9Y3/I7dgsRjY=
X-Google-Smtp-Source: AA6agR6Z48W7WneGNDoEau3YdmtdYK9j5Y/vLCN2UpxTuqems52+D2JDq60QziMgwWUGMPvWqC7/DA==
X-Received: by 2002:a05:6870:d683:b0:10d:a90:d4a1 with SMTP id z3-20020a056870d68300b0010d0a90d4a1mr1681561oap.240.1660146384792;
        Wed, 10 Aug 2022 08:46:24 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id h13-20020a9d798d000000b0061cbd18bd18sm732116otm.45.2022.08.10.08.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:46:24 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 3/7] mergetools: vimdiff: silence annoying messages
Date:   Wed, 10 Aug 2022 10:46:14 -0500
Message-Id: <20220810154618.307275-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810154618.307275-1-felipe.contreras@gmail.com>
References: <20220810154618.307275-1-felipe.contreras@gmail.com>
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

