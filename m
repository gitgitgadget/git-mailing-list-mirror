Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7442C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8A0D6121E
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhDGW4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhDGW4i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 18:56:38 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB8BC061763
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 15:56:27 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g8so671099lfv.12
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 15:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AUsIQRj1onwryjyYAz0ft9PONSwV/jVQ/QRT5WoYNcQ=;
        b=duxW4xp3uhgzJRDB1P7aqAvnf7d4DDJXjvQzWKQ68ps8W4cLoKWYyw2nL+f3+XdOAJ
         6PfyxPhdiVb9ChvFPq4U1EPUAwmOyneZ0/WX/i2kFvGX7W7/e6Nr6jU5VQrBHjJLpO/2
         cLJ41TkquMDsVOq9Tqe3L+aH0wyg1wMeLjXOnvSsArLHQ72zKO0qLWEZiXSWPbs/bZw6
         Moa1ezVBBa/flpkaVmq2uObnWld4luOK0F/a29UVM5aVOvCPPRn4COrDKwghlinuyOV6
         9s/kGhxDJs0/WGq8O7F8uTWwngxuXfGaMZofKy70HWmwc58zv56h1HRPqHb5wyAwmnY1
         LNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AUsIQRj1onwryjyYAz0ft9PONSwV/jVQ/QRT5WoYNcQ=;
        b=Tm/LDcu5Q1LyfaMTrRPW1EnrvcgmmOTdG9n/hVGUQo79ehQQ0bOsu6ooOEbQb/6/NH
         H8Dw15UJHRi3AFwNQ2WsERRUYw/FDhiw2/alt5ixUlCxGBwkhKYF5Nn7BvmnSjJt8o8t
         WFgpNmAbHkr9AozTRw2vDQiJMGz4MIb86Ztbrq9b1cRbqhcUTKczy5AcLdidIl1iFqjd
         F9ad3dbG5zkphk0NBAKfA1mm04MZg5CXmP6ZMli6uNV+DUyq4Uh80oNe6rEREop7MBuY
         kXlLW+1/KwEui3MdwLbI+72zzfys2seYgn46Da5OPPOTdhOSjFPwgvyQlc4FKQHr/HxV
         OtKQ==
X-Gm-Message-State: AOAM530+tF69oDHGdpsgUWgbA0GMfWBX5QEO48malMZvrLwz7ZTOY7b5
        kJ+PoQy2JKHOf90ggjSfw8A=
X-Google-Smtp-Source: ABdhPJxCFTE4TgVB3qMx6dSJXseCCY+0Sd9JqvTlAeq933yVC5j7dTLmsEqUsOV4C/r1+0leoyTB7A==
X-Received: by 2002:ac2:548a:: with SMTP id t10mr3838699lfk.309.1617836186411;
        Wed, 07 Apr 2021 15:56:26 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t25sm2580101ljo.102.2021.04.07.15.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 15:56:26 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 6/9] t4013: add tests for log.diffMerges config
Date:   Thu,  8 Apr 2021 01:56:05 +0300
Message-Id: <20210407225608.14611-7-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407225608.14611-1-sorganov@gmail.com>
References: <20210407225608.14611-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test that wrong values are denied.

Test that the value of log.diffMerges properly affects both
--diff-merges=def and -m.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t4013-diff-various.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 275a6790896d..ee4afca06ced 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -460,6 +460,32 @@ test_expect_success 'log --diff-merges=def matches --diff-merges=separate' '
 	test_cmp expected actual
 '
 
+test_expect_success 'deny wrong log.diffMerges config' '
+	git config log.diffMerges wrong-value &&
+	test_expect_code 128 git log &&
+	git config --unset log.diffMerges
+'
+
+test_expect_success 'git config log.diffMerges first-parent' '
+	git log -p --diff-merges=first-parent master >result &&
+	process_diffs result >expected &&
+	git config log.diffMerges first-parent &&
+	git log -p --diff-merges=def master >result &&
+	process_diffs result >actual &&
+	git config --unset log.diffMerges &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git config log.diffMerges first-parent vs -m' '
+	git log -p --diff-merges=first-parent master >result &&
+	process_diffs result >expected &&
+	git config log.diffMerges first-parent &&
+	git log -p -m master >result &&
+	process_diffs result >actual &&
+	git config --unset log.diffMerges &&
+	test_cmp expected actual
+'
+
 test_expect_success 'log -S requires an argument' '
 	test_must_fail git log -S
 '
-- 
2.25.1

