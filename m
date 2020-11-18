Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56E9C63697
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 14:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A3B720829
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 14:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KB8oWgQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgKROXg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 09:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgKROXe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 09:23:34 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349C9C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 06:23:33 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 23so4242369wmg.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 06:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=oBKHFsMz45J7FyS00zAiEI6YI7P3NIbRkX/3m5PmNH4=;
        b=KB8oWgQlex0m4L2pzv+O3h1+u7tkDnTThiucgW1MYiV3lL9jglmWX7aP6Bl1mSo27/
         +JMt305bPJZJKf3J1QqU6TsOZ3UK0XTWOchUpKtkn9l8JRcEuvK1nZUsxQMUFCma8atu
         UW0Zk703do3/ZCCa2K+Ek2NX4xMqJkos9lroJQwNI6W1bh7trnfXAsnkwBnWvN8+caZS
         HJ6xVNkyQaSKu3UkWZ5NMcyYMN4kaNPBMUQiJ9avcSlbeJmsjgxxPc0Bf+U6drGjIpP9
         5XNMVLuuFaQfYDKk1IBOSFpNeLFdkHPR3U5WSJ7bYoOoHOaw5FUplOt3kWtQyNFkFHb1
         b6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oBKHFsMz45J7FyS00zAiEI6YI7P3NIbRkX/3m5PmNH4=;
        b=TnUz7TIJShTGmvVR9xZqaSrzTh3FNfCwxiJQEsLDotofEWfe1SBhQ48/uZBp2e4zUu
         1KQKg3H91opU7AQRpnfyW5VbWacE5Z3Ewlrn68xtvyaRuuxh6qxpEAvCpjrj6/ohCJz2
         1P+WlI/6vIXLOv1cKaRNjWgfyOP6mvCmH+qr4OFwFZMy1c7qnzQkegwlEdIqtluZoVXL
         NursNFmkYT3cAvi//J83FGrV2Xrr3Q1SfjkB7B06q8A3aFvmsJL2z0s0WLCbzIumeZZ0
         CKiavTb+q6wGAqMYQw8LFmMZDV5gFoBowhfzup9Pr3YDPLEcwv911q6fesuZ5qZQ1tD4
         F6Vw==
X-Gm-Message-State: AOAM530DZ1ApYuofS8io4QDl2M4JMz1Z71fttW1RLTxHd7egXx79sYBX
        L9CEOIxjoHWeJG4JaMRdhXMkLMUFngA=
X-Google-Smtp-Source: ABdhPJzw69TEFKcu5s3qrQSdTP+TYqWYlost9ldxGDgQqN6tjy/lXc2pkyOJrH6JGtwhXuuCy2a5RA==
X-Received: by 2002:a1c:b6c5:: with SMTP id g188mr273789wmf.1.1605709411402;
        Wed, 18 Nov 2020 06:23:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2sm4246258wme.45.2020.11.18.06.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 06:23:31 -0800 (PST)
Message-Id: <pull.791.git.1605709410465.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 14:23:30 +0000
Subject: [PATCH] t1309: use a non-loaded branch name in the `onbranch` test
 cases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `onbranch` test cases in question do not actually want to include
anything; Instead, they want to verify that the `onbranch` code path
does not regress in the early-config case or in the non-Git case, where
the `onbranch` include is actually ignored.

Therefore, the actual branch name does not matter at all. We might just
as well avoid racially-charged names here.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    t1309: use a non-loaded branch name in the onbranch test cases
    
    Just something I stumbled over while working on 
    https://github.com/gitgitgadget/git/pull/762.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-791%2Fdscho%2Ft1309-onbranch-tests-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-791/dscho/t1309-onbranch-tests-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/791

 t/t1309-early-config.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index ebb8e1aecb..b4a9158307 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -91,11 +91,11 @@ test_expect_failure 'ignore .git/ with invalid config' '
 
 test_expect_success 'early config and onbranch' '
 	echo "[broken" >broken &&
-	test_with_config "[includeif \"onbranch:master\"]path=../broken"
+	test_with_config "[includeif \"onbranch:topic\"]path=../broken"
 '
 
 test_expect_success 'onbranch config outside of git repo' '
-	test_config_global includeIf.onbranch:master.path non-existent &&
+	test_config_global includeIf.onbranch:topic.path non-existent &&
 	nongit git help
 '
 

base-commit: e31aba42fb12bdeb0f850829e008e1e3f43af500
-- 
gitgitgadget
