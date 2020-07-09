Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F0AC433E2
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 21:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C051520672
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 21:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bx1vz0VZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgGIVL4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 17:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgGIVLx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 17:11:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C09CC08C5DD
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 14:11:53 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id w3so3360325wmi.4
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4tPbBuOlUBUJNGrzExajIWDAcijCiaD6SsrE7Y63AMM=;
        b=Bx1vz0VZw6Q/LZ2xBOTUjYb/PU9AAJNO8uvwhud5/7N6Bo9BUMC1H9vBR3t14pHRL3
         So0yOfYUIozab0IuefUX8+Ay2g+H0oBqfrMbMtyCjWNmp8RovYqlFxbCrSMCjoRvXX5s
         ve6iXh35ePnv2E0XNY6LTICx+D3f2umHwiO4Ne3xFqCyaDp2/UVDChbytQfNE1om+g1a
         1PnxiPH5yjcNByEAuvSMmthCi0ij8HdDlYE+BdG+2p9OVyiSF1fXhTGV/G54Kv746vWC
         xTudSTP48fv7r8/DK1z518lr+ZeaW1Bsu9F7jywo///aqmXwe64n6Ej6M79qWAtCyxYH
         4orA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4tPbBuOlUBUJNGrzExajIWDAcijCiaD6SsrE7Y63AMM=;
        b=O4eTIKHnzb4yyA57mVzJ+UeS6GIHu6/RsGntTNV6IAb1A9VOLeZU3tNr00CjOu5uln
         ZG6LbcIjHtpcvkVGpjzxtCUrPHLMZn3AZ9weTAqHq3Z8Mof4K4ZY/uobTPLRIj3tJaEr
         6o8cRGEz1ZdkSAffNi+rnkWJgYWYAiQhwFPStfawf+QNb/ObvTSWlsHe88rM8e+HBhRR
         0tW91GylnC0PryCOWLFLolE/N0YzPkcRmkVqxb3GzHhcSm5Lqkw3nFma6RlaTGHIBUl7
         nxM5cW6E+kA7GqoFIBo9HU/FewDjyDBHqn2iElBeRQx7zIgaLXGYQ3Ju0G/simlBuyyb
         orEA==
X-Gm-Message-State: AOAM530Ml39ls1a+FaK/aZ/dHqq7D4ly8NeySFsxmXx54GmjDmjyI19P
        WknqgYn0+7J2E/9CjNtj1nftEFuq
X-Google-Smtp-Source: ABdhPJxszefPmYNmPFj2FX4ZCc/vmmcBHwakebSdnxtrPq30+TOz8JS1atcynZkFHlyQQ1sMYks3OQ==
X-Received: by 2002:a7b:c406:: with SMTP id k6mr1764029wmi.130.1594329109998;
        Thu, 09 Jul 2020 14:11:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14sm7241945wrn.18.2020.07.09.14.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 14:11:49 -0700 (PDT)
Message-Id: <9c3dc4b2cb115de0725f79e27878103756de58ce.1594329108.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
References: <pull.673.git.1594056572.gitgitgadget@gmail.com>
        <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Jul 2020 21:11:46 +0000
Subject: [PATCH v2 1/3] t1400: use git rev-parse for testing PSEUDOREF
 existence
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This will allow these tests to run with alternative ref backends

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1400-update-ref.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 27171f8261..7414b898f8 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -475,57 +475,57 @@ test_expect_success 'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER
 
 test_expect_success 'given old value for missing pseudoref, do not create' '
 	test_must_fail git update-ref PSEUDOREF $A $B 2>err &&
-	test_path_is_missing .git/PSEUDOREF &&
+	test_must_fail git rev-parse PSEUDOREF &&
 	test_i18ngrep "could not read ref" err
 '
 
 test_expect_success 'create pseudoref' '
 	git update-ref PSEUDOREF $A &&
-	test $A = $(cat .git/PSEUDOREF)
+	test $A = $(git rev-parse PSEUDOREF)
 '
 
 test_expect_success 'overwrite pseudoref with no old value given' '
 	git update-ref PSEUDOREF $B &&
-	test $B = $(cat .git/PSEUDOREF)
+	test $B = $(git rev-parse PSEUDOREF)
 '
 
 test_expect_success 'overwrite pseudoref with correct old value' '
 	git update-ref PSEUDOREF $C $B &&
-	test $C = $(cat .git/PSEUDOREF)
+	test $C = $(git rev-parse PSEUDOREF)
 '
 
 test_expect_success 'do not overwrite pseudoref with wrong old value' '
 	test_must_fail git update-ref PSEUDOREF $D $E 2>err &&
-	test $C = $(cat .git/PSEUDOREF) &&
+	test $C = $(git rev-parse PSEUDOREF) &&
 	test_i18ngrep "unexpected object ID" err
 '
 
 test_expect_success 'delete pseudoref' '
 	git update-ref -d PSEUDOREF &&
-	test_path_is_missing .git/PSEUDOREF
+	test_must_fail git rev-parse PSEUDOREF
 '
 
 test_expect_success 'do not delete pseudoref with wrong old value' '
 	git update-ref PSEUDOREF $A &&
 	test_must_fail git update-ref -d PSEUDOREF $B 2>err &&
-	test $A = $(cat .git/PSEUDOREF) &&
+	test $A = $(git rev-parse PSEUDOREF) &&
 	test_i18ngrep "unexpected object ID" err
 '
 
 test_expect_success 'delete pseudoref with correct old value' '
 	git update-ref -d PSEUDOREF $A &&
-	test_path_is_missing .git/PSEUDOREF
+	test_must_fail git rev-parse PSEUDOREF
 '
 
 test_expect_success 'create pseudoref with old OID zero' '
 	git update-ref PSEUDOREF $A $Z &&
-	test $A = $(cat .git/PSEUDOREF)
+	test $A = $(git rev-parse PSEUDOREF)
 '
 
 test_expect_success 'do not overwrite pseudoref with old OID zero' '
 	test_when_finished git update-ref -d PSEUDOREF &&
 	test_must_fail git update-ref PSEUDOREF $B $Z 2>err &&
-	test $A = $(cat .git/PSEUDOREF) &&
+	test $A = $(git rev-parse PSEUDOREF) &&
 	test_i18ngrep "already exists" err
 '
 
-- 
gitgitgadget

