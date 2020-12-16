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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30890C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0161F23407
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732294AbgLPSwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732277AbgLPSw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:52:27 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AF1C0619D4
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:50 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o17so48050992lfg.4
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e1STZ6GfLQdbzzy90sWhf3PHBLo7dYtqQTM6XfIkRkU=;
        b=o0wSW612t2uXBxCUKFn4hPjKD8yaWENhez/At3+eNutr0G9GL+ZYKG7ynpVhdtGN1g
         8GSK+7bd++0IHRWZ4MZ1JA3XI0uL/hzMaw1hiH3x2PujEo7ecIrQagbkNs7XhFxbVNOc
         zW4r+yTwZDCx3Thu4MMwnxRJluW/WDmqUPEHfSq2JMzuxneDRAz1ByrN2AOQC38vRYCk
         2KWzCIDX7tsGRr6YeuHPuZhWkbIKfmGnaWUmxS5O9xBA/LWAeqIkaDb4PVwYd9Q5a3sG
         EFzjOgYuk0HWZoBV4QZaIP0+3b1rXKjXDUEFsWlDbXDXk9/UvG0gaBgdh7jAsY5SC64o
         LU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e1STZ6GfLQdbzzy90sWhf3PHBLo7dYtqQTM6XfIkRkU=;
        b=ruJbE0LpwdmJsM0PT1e2Dx5+UDKhQ4Qggl8y3GbNU0s9AaNW/snS11Vmxa8gzIXDSa
         zyN3VFLWidFqnEhHoZuVc1cQEzJaVuaLpNQZtdwabUqZvDPam8IyGcUIWz98yL7n9HxS
         yKmnVkkazkgs+yFyX41LlIVRmBWkbsZY3l2Y+10qnwfJpOpxGrPVkgmDjCQRjNDyN7L5
         U+0ZjOXaG8UPtdRWBbfIgv5OaYxViZvcAiLxzzLkQ7rVZHPKPTbd5adLqwGXbSHT584D
         1a3UFJLJ53Gbk7rTU3Rkwp6OonasnuN7tOq4428Sm/kz2V/hLvkFC+8T6tL3DjirYgsW
         HRzA==
X-Gm-Message-State: AOAM530wneIaFOCcCX12JCrh2tRZoqkd9Mx2Nz2RbrVu4RtGyuZfNU9Q
        Fjr/J+kU2ESkqoD7MIv+2YxxxYeb7hY=
X-Google-Smtp-Source: ABdhPJxiCTKiwIktEfaFAX64Be6AYDrkoQHOTCJS3y3HtZaFLIzVXpJSnueAIuL0XGeBalDQjf5dXQ==
X-Received: by 2002:a2e:8106:: with SMTP id d6mr15126797ljg.217.1608144648687;
        Wed, 16 Dec 2020 10:50:48 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:48 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 21/33] diff-merges: make -m/-c/--cc explicitly mutually exclusive
Date:   Wed, 16 Dec 2020 21:49:17 +0300
Message-Id: <20201216184929.3924-22-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-c/--cc got precedence over -m only because of external logic where
corresponding flags are checked before that for -m. This is too
error-prone, so add code that explicitly makes these 3 options
mutually exclusive, so that the last option specified on the
command-line gets precedence.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/diff-merges.c b/diff-merges.c
index 4c434e914c8d..6446e2093661 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -7,6 +7,7 @@ static void suppress(struct rev_info *revs) {
 	revs->first_parent_merges = 0;
 	revs->combine_merges = 0;
 	revs->dense_combined_merges = 0;
+	revs->combined_all_paths = 0;
 }
 
 static void set_separate(struct rev_info *revs) {
@@ -25,11 +26,13 @@ static void set_m(struct rev_info *revs) {
 }
 
 static void set_combined(struct rev_info *revs) {
+	suppress(revs);
 	revs->combine_merges = 1;
 	revs->dense_combined_merges = 0;
 }
 
 static void set_dense_combined(struct rev_info *revs) {
+	suppress(revs);
 	revs->combine_merges = 1;
 	revs->dense_combined_merges = 1;
 }
-- 
2.25.1

