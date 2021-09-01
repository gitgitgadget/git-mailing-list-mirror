Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845FCC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 11:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69E4861026
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 11:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243925AbhIAL6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 07:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243838AbhIAL6P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 07:58:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FD2C061760
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 04:57:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m9so4143632wrb.1
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 04:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BrIOyyYw+jCFvpv61hsUXTft4vxNbyrxYjFHyiRi1Vo=;
        b=khd1nso27pU3Rvdu49cvB0JVAcgHyG1RTMQsGlf0xAIaPAo6qhufdSGRneq75b7AM7
         ENhiobyp6QCVPK9s54yvyccSEV2KXfWGTk6A2r83/3HgXVmiElD7eOp6kqYas609u040
         g7fSKhLptFZGLI2VLTnyQmYpURvmzGZ78RiIsfs1GfiymFkOJhrVoge5wkAkW61vQcFS
         z/h5aPalMCXp3oBaWcIn7t00oPMhyJTj1XGkhWI0Aozz7sBM2rkwlRYYAlJHfL1rjmuu
         gmjYI5Wvs3Ljpizz8h9PBZqWW3mD4nHgcQ479WlX4VLnUbasXGX2G9RMaDCwZSDmnV+g
         g5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BrIOyyYw+jCFvpv61hsUXTft4vxNbyrxYjFHyiRi1Vo=;
        b=ZQKRckG1IGKrCdNfDcPYe1G3JC9stYpUiAf9vjWXz0rDhZ4F7ju5pwuUOFeXrDDKxy
         2nsQ3Mm9AmSx7PUH9bAdY+m+w9zm2ITALUG6img1wewUz3h5jT6ZTPppbJ/EDSymfHKH
         7XN+2LwoBKef2nv3CiuvoeJ9rBkwYRLHubCDNnnBfsxqtO/1OLyoBOhv3L30lS/Iu9D/
         3PAxUKTydJsuxjyQgAWaV7UfnLmtsJLcTLAqOCuLlFaRiv/gR6AA1o/zFFa3nP1uh9fh
         OyWx2badrk/e9K2v999+zHN5a0gAm9Zq3aSS5PxkDUl5tCT1NNTnmLE9w4cnEwveJPMe
         mCjw==
X-Gm-Message-State: AOAM532pW9r3nDSMeRwIl2+NJSJnp/HG6wep4SFzUOJtXnHRbyQ3nCmU
        tSHGjhcheT9GBEswEEhWsl/4yQ2M09E=
X-Google-Smtp-Source: ABdhPJwTWHxH2T7LV/temqx+sr1SMirXMpLxpH0oO5lBH1ZZkZLj45gOzPmHV71kNAVXKiNJCwU9rQ==
X-Received: by 2002:adf:ee48:: with SMTP id w8mr36974095wro.10.1630497437461;
        Wed, 01 Sep 2021 04:57:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m24sm28161722wrb.18.2021.09.01.04.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 04:57:17 -0700 (PDT)
Message-Id: <8da29d539fc2c9700630d5ec4a80cacf64d44aa0.1630497435.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
        <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Sep 2021 11:57:08 +0000
Subject: [PATCH v2 1/7] t5520: do not use `pull.rebase=preserve`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Even if those tests try to override that setting, let's not use it
because it is deprecated: let's use `merges` instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5520-pull.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index e2c0c510222..bb9b6b900eb 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -598,7 +598,7 @@ test_expect_success '--rebase=false create a new merge commit' '
 
 test_expect_success '--rebase=true rebases and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
-	test_config pull.rebase preserve &&
+	test_config pull.rebase merges &&
 	git pull --rebase=true . copy &&
 	test_cmp_rev HEAD^^ copy &&
 	echo file3 >expect &&
@@ -620,9 +620,9 @@ test_expect_success '--rebase=invalid fails' '
 	test_must_fail git pull --rebase=invalid . copy
 '
 
-test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-merge' '
+test_expect_success '--rebase overrides pull.rebase=merges and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
-	test_config pull.rebase preserve &&
+	test_config pull.rebase merges &&
 	git pull --rebase . copy &&
 	test_cmp_rev HEAD^^ copy &&
 	echo file3 >expect &&
-- 
gitgitgadget

