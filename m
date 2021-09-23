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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29944C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 04:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A4A61040
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 04:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhIWEOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 00:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhIWEOd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 00:14:33 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251E6C061768
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 21:13:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id y5so719664pll.3
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 21:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SF4RQ8lFcmr+NV8juJLBQeBUSPmVGnYNnxeZZynF8C4=;
        b=FCeyLH7APWKyQiujb939IBJhYMbnGSGcrkXvjs9lVnRBU/xPgO+Cm6EP/fsYLfrsNR
         JSpOwUJgMUyKnbTqqoJ4gFbDK+yHg7jcoZfja4zHF0ZCw7sRm6vnfuxkhsyo2vMHZL29
         bwmERknTk+KGsFZERIu9Wlh/ZwwumgU0/h8KfIHhMxhQzd9HqS9avtpM4NquAHnxsY6y
         siPZ6DJ/S4zCg6D6wqv+J2abhTJEYlmz6gCScHXRAO+aQjZkiKsldiulMxhAu4J50ylW
         GkpRN1AhgdOqlL6E6PLKf/7IRpib1Xtf/g6ICWlx3oyS87g4Owj3y5sRkyyPzn3l8RW+
         edlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SF4RQ8lFcmr+NV8juJLBQeBUSPmVGnYNnxeZZynF8C4=;
        b=SccOFMnOgmwZ5A1rAQ3Mmwc4VfUa6DcnIonxPF9q8e+ILnk7wvYz98TusekuNcR/Qn
         ihLvvLjFaspSJD9O8Uq4lTSm3T7TYlBaUxUwCWL/4CPwCW5kEEo9GBV7Zrg1c8V4CfN0
         fuRr1phWFVjUad0DZXSBT06UmQXiwV+bfqm1vZhhEH8QJVGM7H3mji8FNkfs/EJGC5mb
         FDgIHME7PoUEc13WebRqxWLaxaidE9uTQq0W/sPIT7iFF/2G0Rr39G5yRZy2PB1QwNHz
         2NA/dMHM8WrHmQQhNN+3eStcxDUeDVl0drtJZlVE5LhWVplSBEqCq8ufI9rCjTWaHeRQ
         p6mQ==
X-Gm-Message-State: AOAM533RLGoOFsg+0UT7jVZk+QivGcyqujssZ/trxbY2FtuOArJqE/yP
        NyNR10FZJWUry19yVqHWd4U=
X-Google-Smtp-Source: ABdhPJxeBIzpQGuQitGKwGOvAeor5Tg1wgEwiBF8xpxVQTgie+spF+T2TyvZt5yZc9GbJRdC0YQWhA==
X-Received: by 2002:a17:90b:1c8f:: with SMTP id oo15mr10624011pjb.87.1632370381647;
        Wed, 22 Sep 2021 21:13:01 -0700 (PDT)
Received: from sarawiggum.fas.fa.disney.com ([198.187.190.10])
        by smtp.gmail.com with ESMTPSA id u10sm3649870pjf.46.2021.09.22.21.13.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Sep 2021 21:13:01 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v5 3/3] difftool: add a missing space to the run_dir_diff() comments
Date:   Wed, 22 Sep 2021 21:12:52 -0700
Message-Id: <20210923041252.52596-4-davvid@gmail.com>
X-Mailer: git-send-email 2.33.0.720.g59ef144b50
In-Reply-To: <20210923041252.52596-1-davvid@gmail.com>
References: <20210923041252.52596-1-davvid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 builtin/difftool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 861a4ec5fa..a972431f6d 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -542,7 +542,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	}
 
 	/*
-	 * Symbolic links require special treatment.The standard "git diff"
+	 * Symbolic links require special treatment. The standard "git diff"
 	 * shows only the link itself, not the contents of the link target.
 	 * This loop replicates that behavior.
 	 */
-- 
2.33.0.720.g59ef144b50

