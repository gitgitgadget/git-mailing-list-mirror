Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB52DC433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40884223BE
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pyg13UbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbgJSTbw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 15:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbgJSTbv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 15:31:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840F2C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:31:51 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x7so1035924wrl.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kG9c48RprmqtbIDMXpyglg7zHdgW3mjvKs7JlyaTCUU=;
        b=Pyg13UbK/PEhWuzSjFlHO6R4Zu4xVaRF5QTljjkYsWiRv/lflgjxXwTWEr2U1Ly21K
         elIgiTbETPqvNflbsL5Ekvu8vkN0Q2r8SgCfP36OSQ14AmoaSIms0me7xPT1+ggAzkxN
         umwSQWLnTYcDusypijEFRQZSLfIlgm21jeG+J2dOWNnAsOyVUf/IOHs+4mqSDWoEEwKh
         dXFlndcE05QgRj4cavKYyIQlhL7KM3C3Zyki9HNTFW1wqFAxnMYMrz9SSfNuG0+XhkF0
         x4feuyt6oxrDbpjie18YR1ZnR6LWePsd9U8VWLu0DumFG4+qsXVEX+SBPweZtUJSl/Th
         W3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kG9c48RprmqtbIDMXpyglg7zHdgW3mjvKs7JlyaTCUU=;
        b=NrO20MsxhlHLX2MvTaPGYgIXfZpOS3zGjjP2BO2zCox5qBeoT4jHU56fAB379pWqus
         klMU8+DisG6EiTPKHDev/xneSGianmmURHHn4gi6+RD3nyitBID6S4ZxUSpBkomqNxwp
         7LlmFITKLHmjL9U7qDTS/oBa9iGz0on3SHIVDeqP+8ydFvZVYkdsac6kmB4IlmCbKuKp
         keFBOuHljZ/7ixGn5vLl77xs+czs2cRne8SIfM91xU/wYeK+Rsq2I4PXYEcgngMupFnp
         NBL0i5OVksdQ70zlj4umRCR75GWQORpf4/i/P8znav/HHsvUdqNBGHu8b6TmCAhruvrx
         0H9Q==
X-Gm-Message-State: AOAM533cskjJhBcpeUhE/8EV/6r5jnUxbM34SugPZ//fJtTxBztd2Ec/
        aubO6sQfQAjgP2ll3hHMSAyqDtDltcQ=
X-Google-Smtp-Source: ABdhPJzR2X7x44mJYg6Vzm73IAd8qPtIx4GJmmEzcMTPrPYZn3Fr0/VMvvLAUJAPxH2w60qYAN8o1A==
X-Received: by 2002:adf:9504:: with SMTP id 4mr869238wrs.27.1603135910043;
        Mon, 19 Oct 2020 12:31:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x21sm958861wmi.3.2020.10.19.12.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:31:49 -0700 (PDT)
Message-Id: <7860d8d7df43075ad5424d8210d6f6e17c2042db.1603135903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.758.git.1603135902.gitgitgadget@gmail.com>
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 19:31:36 +0000
Subject: [PATCH 05/10] t6200: adjust suppression pattern to also match "main"
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

In preparation to running t6200 with the default branch name set to
"main", let's adjust the only non-trivial aspect thereof. The rest will
be done via a trivial `sed` invocation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6200-fmt-merge-msg.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 7d549748ef..e61f8fb3d0 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -556,7 +556,7 @@ test_expect_success 'merge.suppressDest configuration' '
 	head -n1 full.2 >actual &&
 	grep -e "Merge branch .side. into master$" actual &&
 
-	git -c merge.suppressDest="ma??er" fmt-merge-msg <.git/FETCH_HEAD >full.3 &&
+	git -c merge.suppressDest="ma*" fmt-merge-msg <.git/FETCH_HEAD >full.3 &&
 	head -n1 full.3 >actual &&
 	grep -e "Merge branch .side." actual &&
 	! grep -e " into master$" actual
-- 
gitgitgadget

