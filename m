Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7665C19F2D
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 02:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiHGCuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 22:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiHGCt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 22:49:57 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF52E03B
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 19:49:56 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-10ea30a098bso7066186fac.8
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 19:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+vFKgthyYGmSi+XHn0WQ7EwyWKyRNMvxMBm4nXgVCt8=;
        b=aaUvhc/uN7LfiHzHk51/+c7nKud2IYh63KGcaAYC39dvawnG4WSa/C95i7kyOe3BT/
         OBWcoFfvZlivM9IP/3CRL7QlMV3Ah56dTnaoNGAsydfIXP4HP6zm9UggMTc4Ey40tL5F
         6kuNvYfsryHEjtgujbTWiz0FOjJR2EhaQrCnC83lWqsHyoU6GjS+a21CloWRD0JpDBhB
         udwOiMbMINqRHSpnPgp87e7SCJRv+RWsROynunnQx5ueTe3/CCLIY0ShYMdB6S/XYbEM
         5jeMRbD26k0rECvajBB6FJaLtbL+oZHHdd1sm3w4+wPb2BhHTlQssEaO8fTd9XAdoulA
         e6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+vFKgthyYGmSi+XHn0WQ7EwyWKyRNMvxMBm4nXgVCt8=;
        b=d76eQV1524HpFAPywo7sFKJ9qxrCOxNiHS9wKPj/usmgMOXmtxYbyrtsFI2XMKbqUA
         qXtyhnBpgLhGG26zfTGUsZvFBgv/Qsy81ghlWLY3pXMK3MxIf0nlkP80KNORiSu4HR2W
         tMKJLv3jYyIk8azQFT+aXiaQXm8Qtf+E6XvKqrHsFgcR4bEd01LXaBB33yvDmBVFg49W
         zT76py/Pht5WFeMZiCY7vg/znE81NoaOh7dCW/5KBTwL3ZKPATL2cIJGxz5nBOgNWgUo
         K14eCAfCLgiYbTUrP8NpbkUCaqLiIP5Qj1eQj/M4y+adwLvnPViUBd/LQZjhEMC3ajyr
         LesQ==
X-Gm-Message-State: ACgBeo3PSRkX2M8JaAr5gcpXnh+nBnTJKzB9MUubHEwA6HadwH6zqSra
        YOaWFWn9JP4/do0xWcRe5Uj5RThrdTU=
X-Google-Smtp-Source: AA6agR6C8PxXm8vx3gx7XcUUfq7dw0qzBmZOi8+AAxac6TCF2lziHeCtr+fcIukp4Lf7m1Rat2H0KA==
X-Received: by 2002:a05:6870:c223:b0:10e:5c96:7c4d with SMTP id z35-20020a056870c22300b0010e5c967c4dmr6061549oae.112.1659840595380;
        Sat, 06 Aug 2022 19:49:55 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:afaf:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id s21-20020a4ac115000000b0042859bebfebsm1475116oop.45.2022.08.06.19.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 19:49:54 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 9/9] mergetools: vimdiff: use vimdiff for vimdiff3
Date:   Sat,  6 Aug 2022 21:49:41 -0500
Message-Id: <20220807024941.222018-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1.378.g3f95da6bac
In-Reply-To: <20220807024941.222018-1-felipe.contreras@gmail.com>
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are pretty close to actually using vimdiff (-d) so let's just go
ahead and do it: no need for do the same thing vimdiff does.

Also, we need to disable diffopt=closeoff because we are closing all the
other windows.

Cc: Fernando Ramos <greenfoo@u92.eu>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 mergetools/vimdiff | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 34373ad92c..daeb3cf1d0 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -325,7 +325,7 @@ gen_cmd () {
 	if ! echo "$LAYOUT" | grep ",\|/" >/dev/null
 	then
 		buf=$(get_buf "$LAYOUT")
-		FINAL_CMD="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | ${buf}b\""
+		FINAL_CMD="-d -c \"set hidden diffopt-=hiddenoff diffopt-=closeoff | ${buf}b | only\""
 		return
 	fi
 
@@ -560,7 +560,7 @@ run_unit_tests () {
 	EXPECTED_CMD_01="-c \"echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_02="-c \"echo | leftabove vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_03="-c \"echo | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 4b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_04="-c \"set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | 4b\""
+	EXPECTED_CMD_04="-d -c \"set hidden diffopt-=hiddenoff diffopt-=closeoff | 4b | only\""
 	EXPECTED_CMD_05="-c \"echo | leftabove split | 1b | wincmd j | leftabove split | 4b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_06="-c \"echo | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_07="-c \"echo | leftabove vertical split | 4b | wincmd l | leftabove split | 1b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-- 
2.37.1.378.g3f95da6bac

