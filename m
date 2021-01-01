Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DF5C433DB
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C93D2076C
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbhAACSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbhAACSN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:18:13 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AADC0613C1
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:32 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id y14so4615631oom.10
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DinOPoSsBoZWlpglEib5h2wjiPtcrmaywJJsThhl87E=;
        b=KWTSiX1KXpKZ5hGtwkN/MqsZCFQqVawt/TCdKeyPlZ6I8+C5goq9l0LySC3sCdOpqz
         DJ6VDK3dW3NVGQhATygV2g9gP8CpuzuKHIuUSZpCm5vbFAYZl/1r7jVhn/Qa9G+F3rcy
         4WP9xOhn4u3eDXXhb7Id5asQlG4jKSR5EqxNs1SHx+7xBuCfcD0jzz6id3lo+zII/V6E
         FV3NkTU/6kIgWcYNizyC4st6LTRQkA6yaOqzMWeCAkyIILhdBFsgI3dVwkSuZVNgyH3g
         rxEGaxyzRyCxr6n84DdsVMRUfm1hVMQl9Zbh+dHESZCUmfqKEXE/hSRESATz8g3WvDO3
         hsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DinOPoSsBoZWlpglEib5h2wjiPtcrmaywJJsThhl87E=;
        b=Er5ubDWXMInZNVdClemoB7Yii4KXwQKgbDTH6UirbvAzZmmjyyA4PYznr54bU/eBu6
         F5MasTJ7lNN9CXjz+MsBjdhJNaVipkEvjm/pl+APp8S8LQAT6KclGLTWmnqDIo3t8JRE
         O1hYvhkxABQdD9yZNKGIMd7VOmNP0Opu04u7QAtqfGy/2UzCEfiUvXWSSBgxyfLSkunl
         ZvwqFCxjjxbJalxSTp/WTkFzCiZGr/Ik/6RjU8A4OmCbSsr1YGnFPrc1+VhBIBrryUuW
         OcE+GHpTQDrjfzUlqdB3iXULuhfIjCL0jHUxYRMbGgotZpAtQBBv/gO88XVDbz1Wv5zm
         uycw==
X-Gm-Message-State: AOAM531SedEs6opBLv0T9nUxm5FJPAfyrNxRJKUBRQLpytAZhDikgsXT
        xsofTNUcrS8XJmFU6W2w0fh9+Vyw4Y8U+w==
X-Google-Smtp-Source: ABdhPJyI1JK1q6lteK26atufW5BoYsI5PTOLA0v8p8Iu7HPjWiAdVPhEbrxCUMVjox/HMtbPVL7fAQ==
X-Received: by 2002:a4a:4988:: with SMTP id z130mr40807121ooa.34.1609467452045;
        Thu, 31 Dec 2020 18:17:32 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id e1sm11447011oib.11.2020.12.31.18.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:31 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 43/47] completion: bash: add __git_have_func helper
Date:   Thu, 31 Dec 2020 20:16:18 -0600
Message-Id: <20210101021622.798041-44-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the code more readable, and also will help when new code
wants to do similar checks.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 59f1563674..4bd3e706ac 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3200,15 +3200,19 @@ __git_support_parseopt_helper () {
 	esac
 }
 
+__git_have_func () {
+	declare -f $1 >/dev/null 2>/dev/null
+}
+
 __git_complete_command () {
 	local command="$1"
 	local completion_func="_git_${command//-/_}"
-	if ! declare -f $completion_func >/dev/null 2>/dev/null &&
-		declare -f _completion_loader >/dev/null 2>/dev/null
+	if ! __git_have_func $completion_func &&
+		__git_have_func _completion_loader
 	then
 		_completion_loader "git-$command"
 	fi
-	if declare -f $completion_func >/dev/null 2>/dev/null
+	if __git_have_func $completion_func
 	then
 		$completion_func
 		return 0
-- 
2.30.0

