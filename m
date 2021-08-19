Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B586C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 13:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2339260F4C
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 13:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239939AbhHSNVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 09:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239300AbhHSNV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 09:21:26 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D579C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 06:20:50 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id o10so3960881plg.0
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 06:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TW2SUmCz1BT+jBZILpsYTqfdcEeKOL5Hnss/SbsWeFg=;
        b=Ri1f3oJCBlIib2/t7xruZqZ4PYZslHeDBADK3PTCLOztHWg/JMVMAuTK5vCumPXygl
         qR8oO77DdHroC49QC2blPfrClhwIh29JPrJOKHlzHf9+mB47WMdGpTyVXDQ0V9rp3p7u
         y1wsnaHfp80E5wB5bi4W4BSrG90x2iZdUNSCMsoMJpU1CQ2BZNJiTGgyS1IELCU5I2cj
         KoLbym+10fdnXPHQ2Od/Cjr4SPxltRv8crFodscjzseLfuC2oohFGDjGEhwHzyCKLty0
         6R7JY/YK5XQXGpuTlD+KE3wCI7bDe7isRI36BV6/WGug5UY2b37+gmTTYbON9Gm3G1Br
         o+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TW2SUmCz1BT+jBZILpsYTqfdcEeKOL5Hnss/SbsWeFg=;
        b=MT7tDyvMl09K3Ru6pRGWDa94w8zEKThe7RE0Sn7s6FtuEtb27kL/+x1b31l/ZCJUU2
         DuaaPxJ7vnEPc7U1cMJ+LNu5y1/ZiO9QPtE4QKPGu3n+Gjsj77tfufkS41Da8+mATYoH
         vIBhlHG6vN+a30SJHUMpjGKrSqoNp4zNXJch6hKwRVW7Joz4QQSNDV+5Y0O1ZnSaMShM
         mSMrTcYs58d8v5RGUnjctwyTNB3fBMnK2+hF8Rwjty7Oh9U94msM7FWZXURqEwdUbU4o
         WqP5g8uq5DFjbpUhfQ5qDtjgQ93SyMqVnuPN0iv7syx9y2kDlfmsyoI6VFyt1TClmbEh
         6PSA==
X-Gm-Message-State: AOAM530lKycc3eW1LS0Zl7EMHOMAylYvyZUC6QcLnIlt0ahXwQTpuHTl
        2AFmY9TaOHJ/iwVS/YBtR6MDniVX2a2g1smN
X-Google-Smtp-Source: ABdhPJxRzYvzm1dd6u5F821zzgelvp7lyL2AImxCrRQZrR0dM7ymjcDRuM1Y0Z4ILgIoGTTMmuiu2w==
X-Received: by 2002:a17:90a:9a8a:: with SMTP id e10mr15181278pjp.125.1629379249854;
        Thu, 19 Aug 2021 06:20:49 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.145])
        by smtp.gmail.com with ESMTPSA id j187sm3403853pfb.132.2021.08.19.06.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 06:20:49 -0700 (PDT)
From:   Xia XiaoWen <haoyurenzhuxia@gmail.com>
X-Google-Original-From: Xia XiaoWen <chenan.xxw@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, worldhello.net@gmail.com,
        Xia XiaoWen <chenan.xxw@alibaba-inc.com>
Subject: [PATCH 2/2] negative values are ignored for http.maxreceivespeed
Date:   Thu, 19 Aug 2021 21:18:08 +0800
Message-Id: <20210819131808.40759-2-chenan.xxw@alibaba-inc.com>
X-Mailer: git-send-email 2.28.1.49.gafcb914ae4.dirty.agit.6.3.1
In-Reply-To: <20210819131808.40759-1-chenan.xxw@alibaba-inc.com>
References: <20210819131808.40759-1-chenan.xxw@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 http.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 12030cf3bc..2e01ebf559 100644
--- a/http.c
+++ b/http.c
@@ -84,7 +84,7 @@ static const char *ssl_cainfo;
 static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
 #if LIBCURL_VERSION_NUM >= 0x070f05
-static ssize_t curl_max_receive_speed = -1;
+static ssize_t curl_max_receive_speed = 0;
 #endif
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
@@ -983,7 +983,9 @@ static CURL *get_curl_handle(void)
 	}
 
 #if LIBCURL_VERSION_NUM >= 0x070f05
-	if (curl_max_receive_speed > 0)
+	if (curl_max_receive_speed < 0)
+		warning("negative values are ignored for http.maxreceivespeed");
+	else if (curl_max_receive_speed > 0)
 		curl_easy_setopt(result, CURLOPT_MAX_RECV_SPEED_LARGE,
 				 curl_max_receive_speed);
 #endif
-- 
2.28.1.49.gafcb914ae4.dirty.agit.6.3.1

