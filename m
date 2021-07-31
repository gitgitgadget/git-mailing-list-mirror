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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830B3C4320A
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 02:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62FB460EB2
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 02:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbhGaCZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 22:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbhGaCZU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 22:25:20 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734A4C06175F
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 19:25:13 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id a19so7825957qtx.1
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 19:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hV16QzQD4oTUCaV7eqsKgIXqxMD0XUMExMXFqOGoH24=;
        b=X7OAylaNFxlR5DuuoSOmJa7K605dRpNybiIlDnDBzW77afUfOCdbkvXyi96KSjkN6W
         WPLIhSqwrDVe+PqI6mSWii/YDlLEmkr5s8tsohoEoFrLyDlz716Ms36M9tCYfD4XEbw0
         h7YLkxuiLXYlEg+g5LWSAUa75H/ffG+rbcBeuOXccstMtMD8wHU0bh5rrOSjei5ipQjA
         I+AVYP/+gyisB7+XVbhHrKa4bG+ygtNP0xuyMIRLdvskw+LFvZFguf0b+7aIjwmZsDE1
         rjsjjRL/EufJPp5K5Wi42BGi3k+LUXpdY1lbYK3tG7tGdUdgh0mgV4pXvEy3gbUEX5Bt
         DLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hV16QzQD4oTUCaV7eqsKgIXqxMD0XUMExMXFqOGoH24=;
        b=OU/973MTTfRTNuYS/QcBVM+LPubU/EHXvGkiv5gvpjn5B9/0gXA+yOQ03uDNi9D7XB
         tW/QapaIcLNXhBlYdndvRRsglbRVHaY8lAm//oI1Q2Wwp4pEkfcsYerlKR/VqRPpYhMs
         TzgLl11pw7TM1GLZMOzybbcaLVlY+2daIVum20xdgFy3cM7O6CzJbGEomA7kWO7EA0gS
         LtbT9PZ5jJQqRm4CPyCprd5XYUpHOoEEUDZ6OFS5pbLucKEoiZ7kn5OQUJ6wAw62BVKM
         VOY+ntbz3FyLWiAZMpGzpsgcyl1Fku63ImkxCHjYcmgg4jrotHsS1djGtPndhMUqdg5D
         9J6Q==
X-Gm-Message-State: AOAM530XI6A2SPjAsJZa/llYkZgaT2bn+pnFdjkiFIpG1PpjLCY6/oID
        XhfFW6XstjmBo5Yg0DnGF2M4dE9kdBQ9fA==
X-Google-Smtp-Source: ABdhPJxeJc/sv48rGsWcOUGiFBP5TtCGbxvgTePJ/URfDpL4+R1OwpOgfDryTAm/z4JNea0z5qeG+g==
X-Received: by 2002:a05:622a:16:: with SMTP id x22mr5074495qtw.90.1627698312485;
        Fri, 30 Jul 2021 19:25:12 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id j4sm1831823qkk.78.2021.07.30.19.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 19:25:12 -0700 (PDT)
From:   Ben Boeckel <mathstuf@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v1 1/4] advice: add a function to set the value of an advice type
Date:   Fri, 30 Jul 2021 22:25:01 -0400
Message-Id: <20210731022504.1912702-2-mathstuf@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731022504.1912702-1-mathstuf@gmail.com>
References: <20210731022504.1912702-1-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is setup for removing the `advice` global variables.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 advice.c | 5 +++++
 advice.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/advice.c b/advice.c
index 0b9c89c48a..fd58631dc1 100644
--- a/advice.c
+++ b/advice.c
@@ -187,6 +187,11 @@ int advice_enabled(enum advice_type type)
 	}
 }
 
+void advice_set(enum advice_type type, int value)
+{
+	advice_setting[type].enabled = value;
+}
+
 void advise_if_enabled(enum advice_type type, const char *advice, ...)
 {
 	va_list params;
diff --git a/advice.h b/advice.h
index bd26c385d0..74425a9f1a 100644
--- a/advice.h
+++ b/advice.h
@@ -87,6 +87,11 @@ void advise(const char *advice, ...);
  */
 int advice_enabled(enum advice_type type);
 
+/**
+ * Enable or disable advice of a certain kind.
+ */
+void advice_set(enum advice_type type, int value);
+
 /**
  * Checks the visibility of the advice before printing.
  */
-- 
2.31.1

