Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F14F2049B
	for <e@80x24.org>; Mon, 26 Dec 2016 10:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755610AbcLZKWu (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:22:50 -0500
Received: from mail-wj0-f194.google.com ([209.85.210.194]:32861 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755488AbcLZKWp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:22:45 -0500
Received: by mail-wj0-f194.google.com with SMTP id kp2so48029076wjc.0
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rcekvVKAyCibidPxkOal+3YNarePSnDmR66vY4AnglM=;
        b=nt268czqwdGeo44LC+QHxoDUpJ5JDnkHz7WTR0JYoSlxIyMB6yVZ11EbweKuyJtBrR
         DgtE3GNKn6aZoWKdcsrffCffGwI/mA35gQKaNkt32TbqQJ9Rf0DptisJi+Qq+YOd7sei
         jozKKI7WClDwM8arANzpYqWaQJeLwcjhFgpt5IL50UQP4e+SnZFGV17bYlgvtrSdvPbc
         xHHDFdXF5YfXP51YF5+Isc3pVp6cMDQpHyKZO5Y7ecQ9t9mO2XhnpN+XoFl4w7YyiQKK
         zpL3RVU7Up+RTn0FbfL74/LRpXdH4+Ihvn7CkbRFjsebFXZAu+zmRT/ldU2GRLeHqRy0
         AgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rcekvVKAyCibidPxkOal+3YNarePSnDmR66vY4AnglM=;
        b=k6YtBSS8AAkmv7RoczoC+6fcfpbSbqbCpHiRjoPArua2t43lC0BTd8TLgugLmyd/wA
         OmV9qIp7iS6dVUde788dT6IFtANkHav/+84/T7/14tR2prjFuvmYKPldXNMuK4tLVmVJ
         Ye02oueciDDt81j0EOPAF6ANHdbbwz+MhdlPUiF2KA+YJdb6UgT7qBga1c3UKs7UHJ7K
         bs+sOlfoObYia4n+XZkAC/z3dCVTH5JZpiqWEEGH6YEds6XNXC9ylRFSpaYZENnfM/Lk
         4e/vfd69rQtPW3R6qNiS3s/LkS4xeef2qTGBAIwew5mvc3P9melwJH5nM02tN8jJ3giO
         WPnw==
X-Gm-Message-State: AIkVDXJdKAdeQOk31olSsyfEOab2Oh+FF1QLbQ/d3UJBRNO7KxauxP571X7Qxn0vQDMwDw==
X-Received: by 10.194.185.70 with SMTP id fa6mr23189434wjc.121.1482747763725;
        Mon, 26 Dec 2016 02:22:43 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id kp5sm54259010wjb.8.2016.12.26.02.22.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 02:22:43 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 09/21] config: add git_config_get_max_percent_split_change()
Date:   Mon, 26 Dec 2016 11:22:10 +0100
Message-Id: <20161226102222.17150-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.209.gda91e66374.dirty
In-Reply-To: <20161226102222.17150-1-chriscool@tuxfamily.org>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new function will be used in a following commit to get the
value of the "splitIndex.maxPercentChange" config variable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h  |  1 +
 config.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/cache.h b/cache.h
index c126fe475e..e15b421b6f 100644
--- a/cache.h
+++ b/cache.h
@@ -1822,6 +1822,7 @@ extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
 extern int git_config_get_untracked_cache(void);
 extern int git_config_get_split_index(void);
+extern int git_config_get_max_percent_split_change(void);
 
 /*
  * This is a hack for test programs like test-dump-untracked-cache to
diff --git a/config.c b/config.c
index 421e8c9da6..cf212785bb 100644
--- a/config.c
+++ b/config.c
@@ -1719,6 +1719,21 @@ int git_config_get_split_index(void)
 	return -1; /* default value */
 }
 
+int git_config_get_max_percent_split_change(void)
+{
+	int val = -1;
+
+	if (!git_config_get_int("splitindex.maxpercentchange", &val)) {
+		if (0 <= val && val <= 100)
+			return val;
+
+		return error(_("splitIndex.maxPercentChange value '%d' "
+			       "should be between 0 and 100"), val);
+	}
+
+	return -1; /* default value */
+}
+
 NORETURN
 void git_die_config_linenr(const char *key, const char *filename, int linenr)
 {
-- 
2.11.0.209.gda91e66374.dirty

