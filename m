Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA8CC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 20:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BA220866
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 20:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="Yes8jSRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfK0UYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:24:19 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34011 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfK0UYS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 15:24:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id z188so11514978pgb.1
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 12:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sHebGpZFo1qMmUe+6cihL7LgjwvkIQJOH2dpvLxnDY8=;
        b=Yes8jSRpzqWME10AhiSFon++Oec2GV172e3WqvwxR6i195Zct5dUOQY83norvhV6Kz
         BJw8PM5KU9vTwZsqt+dV02tq4OOMALeOGgyj8KcrEEstCsJQLftPURAtaS5Vz8NDJaL0
         KBwXLBvX4ung2TxIuFBl2Ry0aO5Z3YeaPPJRcBmsai0KWNmhgy8E2/9vBXvArXO+sUWO
         wTAwDnyg1fXuhKAIFVXWu7K5ZZdw7Drplq36blm4UkKrCWm5S6sL8/vgv1MvRKK2QrVK
         6U7MSKQMS6Ffhi/8dYiYEFqSRuqobLOe76TUFK/04ByOq7wbMobKh6IJyq9REGqeGNQ2
         TYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sHebGpZFo1qMmUe+6cihL7LgjwvkIQJOH2dpvLxnDY8=;
        b=iY6uM2GqkWHSya8Xp5MdA/Cqgag9U153xiWk7sn4qMRlk7tphMRj/5bhJVnebuj/9L
         5KlR8sKWiyqUeo9nYlNBVX8VcQ4VWQqasY0spAO90A8pMwzkW6z8Drdo/zpEVkulnq/v
         PsYEMmUqlP1LxAOlSNDvs+HmxPfAsPM8dMirFRDnWLbXDvmHpSIsPXNudu9bjGOA8+1L
         FP1gxN2S5gEsZFYudMm7tXvvTrltE2nH1mOn9KfU1M2hSQskkFydWkMKYa+KiTHOK9j2
         i8iD7iGbrVQ+53LkqFwKWHfdBkQamiBMItxRUSs/jSnG/RvYR25OT0iiT/zW7hKl1Ms4
         M/ag==
X-Gm-Message-State: APjAAAWLUmiq9UMdMIepZt9lRkoGVhCM/y0GOPg1GUwMsDyztXHUb76E
        5ifBYwra6bKtHtQgTdPuSkWIZwELbjQAGA==
X-Google-Smtp-Source: APXvYqyR8TKSJR98lt7Vb1XDU95uOy5AQ3ZrqwqTr40EIUSMahM4W+Hp6vSzxbH6ZWfaHyTHA+esSQ==
X-Received: by 2002:a63:e608:: with SMTP id g8mr6969644pgh.448.1574886257743;
        Wed, 27 Nov 2019 12:24:17 -0800 (PST)
Received: from localhost ([182.232.36.174])
        by smtp.gmail.com with ESMTPSA id 16sm17632956pgm.86.2019.11.27.12.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 12:24:17 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH 1/1] grep: don't return an expression from pcre2_free()
Date:   Wed, 27 Nov 2019 20:24:11 +0000
Message-Id: <20191127202411.4298-2-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127202411.4298-1-hji@dyntopia.com>
References: <20191127202411.4298-1-hji@dyntopia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, the void pcre2_free() function in grep.c returned free().
While free() itself is void, afaict it's still an expression as per
section A.2.3, subsection 6.8.6 (jump-statement) in both C99 [1] and C11
[2]:

> return expression

Section 6.8.6.4 in C99 [1] and C11 [2] says that:

> A return statement with an expression shall not appear in a function
> whose return type is void.

The consequence of the old behavior was that developer builds with
pedantic errors enabled broke Git if PCRE2 was enabled and a
smart-enough compiler to detect these errors was used.  This commit
fixes pedantic builds of Git that enables --with-libpcre.

[1] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf
[2] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf

Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
---
 grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index b7ae5a442a..0552b127c1 100644
--- a/grep.c
+++ b/grep.c
@@ -26,7 +26,7 @@ static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_data)
 
 static void pcre2_free(void *pointer, MAYBE_UNUSED void *memory_data)
 {
-	return free(pointer);
+	free(pointer);
 }
 #endif
 
-- 
2.24.0.156.g00c62833a5

