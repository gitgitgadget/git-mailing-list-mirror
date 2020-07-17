Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8258EC433E7
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 587462076A
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxRL0Yhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgGQKyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQKyg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 06:54:36 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EFCC061755
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:35 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a6so10526508wrm.4
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QGmK/o5MGnE7qfNy6OlJiuoXu3XIcEOXYJElqWDicLk=;
        b=JxRL0YhjFx2DWZAKXO/pmpsj4tW47ZO8caNY3Biua/urhWC9YhQ91vgXAV60RXMppr
         u0OuWz7bvorZYoe1gtmk1pAAYm4rO8m0xI6Q+6MJeIBHjYlTapLfqT/sbra0z7hMCBJt
         DHUJc70Ky++b/B1rSQq2MzRjbVPn/5ZaaHpz3av9oiag26r4BnCKy45OmJcpIy0XXe04
         1fsjcbMatbV+GagGQ/feMi2KVdbLLfaiEEpiMkhvfMu1rnb8ufgOijF0M67ZU2jKF5kZ
         LdPFUf755J12a0W9/p2K9wrrzPZ70FnNRaEMOvzNISmutbFhJFdODcrh59Pzf4H7wzR7
         2uNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QGmK/o5MGnE7qfNy6OlJiuoXu3XIcEOXYJElqWDicLk=;
        b=kHe3+7i6ceEshR1BcfCYEAjooDEheKoBoPZ6MhPyJUKq9kYNGKSoJTEYsszcbYg1Bx
         M7oz3ahm0Ucub2VmTNNbKqTHinn4e7rX5ftXJ+vOj0B9K2Xx2c7VgP+NzjtXyPjfj+9D
         NwtItKDszmwmHhAiGxL/6Uz5Uelf6ItXa1yX1XQujnF2V4/tG8XjE7ygz1cZbLPDFRYa
         eCMOTvANCLnpnpbJNjzdLImXaPVcNA3j9SAaOmF53eSlzdjr8fGZMgCmofNlBqL9gI6i
         f7QbZprN+WBdSru4YcJbuyCrJtV6dQuy1HrmE+XBlK0nfi3p3jUzIMlaLAkegFcYQeMu
         xrJA==
X-Gm-Message-State: AOAM530hZjFIKBZ6fu6NRQkhIyYxp4/hGef6G5zuwPFPq13NgWFAzl3d
        K45ZawvsAa+wVlKTPdMyP6bqd5zR
X-Google-Smtp-Source: ABdhPJzbLSzs+yPFldTouLX3DYA2nRfPA43H1KAofVWsSDuCnXDfc63F7j185I9fK617laAwlVCGLw==
X-Received: by 2002:adf:ec8c:: with SMTP id z12mr9150186wrn.281.1594983274432;
        Fri, 17 Jul 2020 03:54:34 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id w14sm13924474wrt.55.2020.07.17.03.54.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 03:54:33 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v5 01/13] bisect--helper: BUG() in cmd_*() on invalid subcommand
Date:   Fri, 17 Jul 2020 12:53:54 +0200
Message-Id: <20200717105406.82226-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200717105406.82226-1-mirucam@gmail.com>
References: <20200717105406.82226-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In cmd_bisect__helper() function, there would be a bug
if an invalid or no subcommand was passed.return error()
should be replaced by BUG() in that case.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index ec4996282e..c452d3f6b7 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -716,7 +716,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		res = bisect_start(&terms, no_checkout, argv, argc);
 		break;
 	default:
-		return error("BUG: unknown subcommand '%d'", cmdmode);
+		BUG("unknown subcommand %d", (int)cmdmode);
 	}
 	free_terms(&terms);
 
-- 
2.25.0

