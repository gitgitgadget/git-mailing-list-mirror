Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291F1C4361A
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02731611BF
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387778AbhELUj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 16:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386805AbhELUWN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 16:22:13 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0720EC061761
        for <git@vger.kernel.org>; Wed, 12 May 2021 13:16:22 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c13so6072752pfv.4
        for <git@vger.kernel.org>; Wed, 12 May 2021 13:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P1VPwUQIVZdAcZuMTZaOrMoNj5NQ16fBQVzWuyJMI3s=;
        b=Y5FJhhiNr6A0M5vZnc1dnfdffLmbafCFQPxwRLVcz1lls1NN62DYTvXz6YKcM6X3CS
         /zoAjT+klBfLiKvR1XraF07PGbzZfKcbl8COxOvpcrvhsvXfS3W0O+X1ieq5wIb7tU/a
         5RNyL+ZE7xe0I/ZdAMsOzGEEytcLaYL76J/MdTXsk0CkM8azrYA+n7tZwnzV5P+EDpBt
         ry4X/IZFQfgjM1MFskRGtJlQHyRp7KygCrkk6Q8mbkU+SECW3jj8nQYVXqh3JzKPTGFQ
         FOFtnzRxqnTp9eHFIpyRa2pd2w5OiOX9dI33uKhNuyoml70/hjAuCqmDtPYFXo+29T3q
         Zkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P1VPwUQIVZdAcZuMTZaOrMoNj5NQ16fBQVzWuyJMI3s=;
        b=iT7xPa7I1gqjzSDxbxliyaR3RmKhGgRDgqcJv+GUfmTPCA+BYF4ymP2gxexGWVx9d2
         hM26Xy+xtMJnPWMfYm8YOhLKRVx2kLSKNInRcOCz+BBpz/rmanE9tzHFhvJyPYZB6eVf
         p9kQM8YbcYVOELPzLGC1bfVBQ0Njrh8kVZ4gA3r/J0BOfI2//EoEsjLs4Amm5jQIfgkT
         sT/c00BBxjV4H5OaYMTtaB11c3aTPdmy3ou9OwvO0rwnkmxHqJszekuoXowXEtEviFBy
         7CENMqyzM32o4BWjBOmYqrVQDyV/Ogcmrh9E0aXgFPHDEvfbKTMyU27MdPF81A8P1FUa
         z2Gw==
X-Gm-Message-State: AOAM530kAomPiRpmcyXYZkXLKHYHzKWfoV52mZfG0QPoX0xvhNYmG77M
        8GFYwzd42MN3GcbzK4xEikjzaO9XlpQ=
X-Google-Smtp-Source: ABdhPJyB42B560oGqDWJRf7BGLs2FfSi7xBrVD8CGZWRXgpd92F/WL6jxhQNYPYxoPMAwWGTBEpQwA==
X-Received: by 2002:a17:90a:d98b:: with SMTP id d11mr286180pjv.33.1620850581392;
        Wed, 12 May 2021 13:16:21 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id bx12sm5109133pjb.1.2021.05.12.13.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 13:16:21 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/2] t3905: correct test title
Date:   Wed, 12 May 2021 13:16:12 -0700
Message-Id: <1f554261a57fd7e379d5d7fa81be871a55ed5ec5.1620850247.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd
In-Reply-To: <cover.1620850247.git.liu.denton@gmail.com>
References: <cover.1620850247.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We reference the non-existent option `git stash show --show-untracked`
when we really meant `--only-untracked`. Correct the test title
accordingly.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3905-stash-include-untracked.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index b470db7ef7..2e6796725b 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -367,7 +367,7 @@ test_expect_success 'stash show --only-untracked only shows untracked files' '
 	test_cmp expect actual
 '
 
-test_expect_success 'stash show --no-include-untracked cancels --{include,show}-untracked' '
+test_expect_success 'stash show --no-include-untracked cancels --{include,only}-untracked' '
 	git reset --hard &&
 	git clean -xf &&
 	>untracked &&
-- 
2.31.1.751.gd2f1c929bd

