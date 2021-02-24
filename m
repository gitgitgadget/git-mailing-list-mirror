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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4321C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 702C864EF5
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbhBXTxW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbhBXTxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:53:16 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407A0C06178B
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:51:58 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h98so3027456wrh.11
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sMx0HZwcMfXSaewuB57svVW+0gB/b96yQanzPvv2DB0=;
        b=t749Sf4r5a/Mv9rJM1a+6VAbZ3O/dtUsBLAGvcVY8qSQOQkAg60qJQjPcuxisTfVi9
         L2npMdl5/SAAh6fTmwbyfowyVBfC+5mHCXlIK6ga29ml7aVV3XAScre2/vOL7n3/9nHf
         N94N8zrpdTXiZY/oqiW1qpmWNJ/e6pFM/dUAHe0t3lASXSAGnnyS7jml7+8EReeUQN0e
         mtKcf6luPBG3xgAJ883RIRJLitoWofuA1MvRxEDU6nl+K064q8QfQaZBZ7Yj2/RDR8zr
         PQ8te3A/OQLl2HqUw9bom4nKha/ob4d9AIsRHLbrcpAK6OQS5InVJS3Aq6l7jyYv2NSB
         N8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sMx0HZwcMfXSaewuB57svVW+0gB/b96yQanzPvv2DB0=;
        b=SKCpIdqplWaQoHTc7kIovpYnMD60wC3QZgqYLARCW2Mv/99zDjLz5zfOCiU8kVCd6U
         fXtTOErzsvyaBnGezu9T5OZP+nUWwIebi8GSg0IpjJyPmE2CyDd/xS0IJjEs+N4c7hU/
         RDiHcSo7r0F8NZzsZSkqHP3jTKeF48rDCdU9q6/2cLNuYvYdT3ayLoGak6MSPsgwUHvi
         KYt6E3t5iOTdrtbfB5TylEKTHh/M3PPnCl7vTRhBmA3X7lnX/rqd0ay2DEZu8YHirH3G
         O5DkG7tDx6taIDzJQhXrMrqBHtd+UNJaqmZHuw1rjAw5CgNVQB1qN5g2L4RYxyKuvcc6
         ePpA==
X-Gm-Message-State: AOAM530bzQGphZW/xxkOjqAsYHkH74MtUnoA01uTxE/TYd9RNgxNUjNm
        haU9yD5aiJaM1CKtrzzoVIcCrWIux0yzYA==
X-Google-Smtp-Source: ABdhPJyP2CEespeDwCMSXCVPbWYT6GrVOUq84hfu6qlq82XniocBR+cN7SVnwJRYuPYkQ4UcfpSZ9w==
X-Received: by 2002:a5d:47af:: with SMTP id 15mr33316596wrb.205.1614196316724;
        Wed, 24 Feb 2021 11:51:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:51:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/35] userdiff: add and use for_each_userdiff_driver()
Date:   Wed, 24 Feb 2021 20:50:59 +0100
Message-Id: <20210224195129.4004-6-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the userdiff_find_by_namelen() function so that a new
for_each_userdiff_driver() API function does most of the work.

This will be useful for the same reason we've got other for_each_*()
API functions as part of various APIs, and will be used in a follow-up
commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 userdiff.c | 61 +++++++++++++++++++++++++++++++++++++++++++-----------
 userdiff.h | 15 ++++++++++++++
 2 files changed, 64 insertions(+), 12 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index 10a02d36209..55f4f769bd3 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -259,20 +259,32 @@ static struct userdiff_driver driver_false = {
 	{ NULL, 0 }
 };
 
-static struct userdiff_driver *userdiff_find_by_namelen(const char *k, size_t len)
+struct for_each_userdiff_driver_cb {
+	const char *k;
+	size_t len;
+	struct userdiff_driver *driver;
+};
+
+static int userdiff_find_by_namelen_cb(struct userdiff_driver *driver,
+				       enum userdiff_driver_type type, void *priv)
 {
-	int i;
-	for (i = 0; i < ndrivers; i++) {
-		struct userdiff_driver *drv = drivers + i;
-		if (!strncmp(drv->name, k, len) && !drv->name[len])
-			return drv;
-	}
-	for (i = 0; i < ARRAY_SIZE(builtin_drivers); i++) {
-		struct userdiff_driver *drv = builtin_drivers + i;
-		if (!strncmp(drv->name, k, len) && !drv->name[len])
-			return drv;
+	struct for_each_userdiff_driver_cb *cb_data = priv;
+
+	if (!strncmp(driver->name, cb_data->k, cb_data->len) &&
+	    !driver->name[cb_data->len]) {
+		cb_data->driver = driver;
+		return -1; /* found it! */
 	}
-	return NULL;
+	return 0;
+}
+
+static struct userdiff_driver *userdiff_find_by_namelen(const char *k, size_t len)
+{
+	struct for_each_userdiff_driver_cb udcbdata = { .k = k, .len = len, .driver = NULL };
+
+	for_each_userdiff_driver(userdiff_find_by_namelen_cb,
+				 USERDIFF_DRIVER_TYPE_UNSPECIFIED, &udcbdata);
+	return udcbdata.driver;
 }
 
 static int parse_funcname(struct userdiff_funcname *f, const char *k,
@@ -373,3 +385,28 @@ struct userdiff_driver *userdiff_get_textconv(struct repository *r,
 
 	return driver;
 }
+
+int for_each_userdiff_driver(each_userdiff_driver_fn fn,
+			     enum userdiff_driver_type type, void *cb_data)
+{
+	int i, ret;
+	if (type & (USERDIFF_DRIVER_TYPE_UNSPECIFIED | USERDIFF_DRIVER_TYPE_CUSTOM)) {
+
+		for (i = 0; i < ndrivers; i++) {
+			struct userdiff_driver *drv = drivers + i;
+			ret = fn(drv, USERDIFF_DRIVER_TYPE_CUSTOM, cb_data);
+			if (ret)
+				return ret;
+		}
+	}
+	if (type & (USERDIFF_DRIVER_TYPE_UNSPECIFIED | USERDIFF_DRIVER_TYPE_BUILTIN)) {
+
+		for (i = 0; i < ARRAY_SIZE(builtin_drivers); i++) {
+			struct userdiff_driver *drv = builtin_drivers + i;
+			ret = fn(drv, USERDIFF_DRIVER_TYPE_BUILTIN, cb_data);
+			if (ret)
+				return ret;
+		}
+	}
+	return 0;
+}
diff --git a/userdiff.h b/userdiff.h
index 203057e13e5..fe14014a775 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -21,6 +21,13 @@ struct userdiff_driver {
 	struct notes_cache *textconv_cache;
 	int textconv_want_cache;
 };
+enum userdiff_driver_type {
+	USERDIFF_DRIVER_TYPE_UNSPECIFIED = 1<<0,
+	USERDIFF_DRIVER_TYPE_BUILTIN = 1<<1,
+	USERDIFF_DRIVER_TYPE_CUSTOM = 1<<2,
+};
+typedef int (*each_userdiff_driver_fn)(struct userdiff_driver *,
+				       enum userdiff_driver_type, void *);
 
 int userdiff_config(const char *k, const char *v);
 struct userdiff_driver *userdiff_find_by_name(const char *name);
@@ -34,4 +41,12 @@ struct userdiff_driver *userdiff_find_by_path(struct index_state *istate,
 struct userdiff_driver *userdiff_get_textconv(struct repository *r,
 					      struct userdiff_driver *driver);
 
+/*
+ * Iterate over each driver of type userdiff_driver_type, or
+ * USERDIFF_DRIVER_TYPE_UNSPECIFIED for all of them. Return non-zero
+ * to exit from the loop.
+ */
+int for_each_userdiff_driver(each_userdiff_driver_fn,
+			     enum userdiff_driver_type, void *);
+
 #endif /* USERDIFF */
-- 
2.30.0.284.gd98b1dd5eaa7

