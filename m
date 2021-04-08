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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1B9C43461
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 15:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE40610F9
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 15:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhDHPEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 11:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhDHPEt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 11:04:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792F7C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 08:04:37 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id f8so2812328edd.11
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 08:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b70j4mGhbot8iZZ6rPdNtmO2HbpTClAX/seAv5d3a28=;
        b=XTzyoEVdA+ROIY7NzeRn8BBJ3qGUf9P5T4VdqGTZ94KzsRCtXLaeHk4RoYvlErt5lf
         AxL+rCbG3RAZTZ2E8NR/661uhut+UU7ZmN87f8k1fGCCsYY7pqLsuN/EREU3ZoEQ79Ny
         3G0jJcT2sVtqPs5bKGqSUtgK0ZXvJ9wDDpbTa6hXuwXmMmDSmrDxRYDJIq4d/ewn3kIF
         lTv2v/EUJ+xaV60uu2FJ8ns46shEzQpAul+S3MtIYVY4cHn5fTFh24YYIhc73CbZGh7G
         4lrqjEqon4mlkvj+xT8S8jB7EWkRqxeQ/JfEqe0duyXjcA2/xP4jFJxukswqD17r3CZ4
         lC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b70j4mGhbot8iZZ6rPdNtmO2HbpTClAX/seAv5d3a28=;
        b=PJo3b4s0q5PGRH9nNt6RhnJvmaRkpF5/H5n+/V0MFKLsiEJs3t4wxa49DpZLtpOyJF
         WEvnniW8GIGe3wWnMmXAJEZFtqYJzdRjH/eTKb///pCE7Xha7w26V4wgEjN52toH/otL
         bXCnRfQ5NOBD4R5PQRXA7iORNvvaopnJOKMig2CHvBIeYVTsJR/ZsTO45YoJWdq9lXFz
         r8Jls/AGs/axQVUj1jLXlr1gVfX5px2pFIlbFpnncf8HcWFExUxNGAAWDWuyOulv5qLr
         iS11kXvR75uV/fP/wRndMVbu2JueKilXRAaV+C2m7D4AyLjwd2RRkPY/LI7jBAQ+tMN6
         IpyA==
X-Gm-Message-State: AOAM532CiSCTPWz37mR2uKkqn/lXVyTvPhjNcebPmZxDBtvypu1Nprwy
        gBe4GLPUY2ETGdTySUuqnFNQyf5DeKMz1A==
X-Google-Smtp-Source: ABdhPJz1yJjoCLXoByCv5NX1WCiY6BnK5AiK1zYsf+NPCUXxTWFECHwN9H1tZIzNQk3WqzDDGmQ6ww==
X-Received: by 2002:a05:6402:2787:: with SMTP id b7mr11961814ede.225.1617894275882;
        Thu, 08 Apr 2021 08:04:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h25sm2479253ejx.105.2021.04.08.08.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 08:04:35 -0700 (PDT)
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
Subject: [PATCH v5 4/9] userdiff: add and use for_each_userdiff_driver()
Date:   Thu,  8 Apr 2021 17:04:19 +0200
Message-Id: <patch-04.10-1a3a61e389-20210408T145833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g9b8f7de2547
In-Reply-To: <cover-00.10-0000000000-20210408T145833Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com> <cover-00.10-0000000000-20210408T145833Z-avarab@gmail.com>
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
 userdiff.c | 70 ++++++++++++++++++++++++++++++++++++++++++++----------
 userdiff.h | 13 ++++++++++
 2 files changed, 71 insertions(+), 12 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index 978ae64155..a667ccaa8c 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -259,20 +259,33 @@ static struct userdiff_driver driver_false = {
 	{ NULL, 0 }
 };
 
-static struct userdiff_driver *userdiff_find_by_namelen(const char *k, size_t len)
+struct find_by_namelen_data {
+	const char *name;
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
+	struct find_by_namelen_data *cb_data = priv;
+
+	if (!strncmp(driver->name, cb_data->name, cb_data->len) &&
+	    !driver->name[cb_data->len]) {
+		cb_data->driver = driver;
+		return 1; /* tell the caller to stop iterating */
 	}
-	return NULL;
+	return 0;
+}
+
+static struct userdiff_driver *userdiff_find_by_namelen(const char *name, size_t len)
+{
+	struct find_by_namelen_data udcbdata = {
+		.name = name,
+		.len = len,
+	};
+	for_each_userdiff_driver(userdiff_find_by_namelen_cb, &udcbdata);
+	return udcbdata.driver;
 }
 
 static int parse_funcname(struct userdiff_funcname *f, const char *k,
@@ -379,3 +392,36 @@ struct userdiff_driver *userdiff_get_textconv(struct repository *r,
 
 	return driver;
 }
+
+static int for_each_userdiff_driver_list(each_userdiff_driver_fn fn,
+					 enum userdiff_driver_type type, void *cb_data,
+					 struct userdiff_driver *drv,
+					 int drv_size)
+{
+	int i;
+	int ret;
+	for (i = 0; i < drv_size; i++) {
+		struct userdiff_driver *item = drv + i;
+		if ((ret = fn(item, type, cb_data)))
+			return ret;
+	}
+	return 0;
+}
+
+int for_each_userdiff_driver(each_userdiff_driver_fn fn, void *cb_data)
+{
+	int ret;
+
+	ret = for_each_userdiff_driver_list(fn, USERDIFF_DRIVER_TYPE_CUSTOM,
+					    cb_data, drivers, ndrivers);
+	if (ret)
+		return ret;
+
+	ret = for_each_userdiff_driver_list(fn, USERDIFF_DRIVER_TYPE_BUILTIN,
+					    cb_data, builtin_drivers,
+					    ARRAY_SIZE(builtin_drivers));
+	if (ret)
+		return ret;
+
+	return 0;
+}
diff --git a/userdiff.h b/userdiff.h
index 203057e13e..aee91bc77e 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -21,6 +21,12 @@ struct userdiff_driver {
 	struct notes_cache *textconv_cache;
 	int textconv_want_cache;
 };
+enum userdiff_driver_type {
+	USERDIFF_DRIVER_TYPE_BUILTIN = 1<<0,
+	USERDIFF_DRIVER_TYPE_CUSTOM = 1<<1,
+};
+typedef int (*each_userdiff_driver_fn)(struct userdiff_driver *,
+				       enum userdiff_driver_type, void *);
 
 int userdiff_config(const char *k, const char *v);
 struct userdiff_driver *userdiff_find_by_name(const char *name);
@@ -34,4 +40,11 @@ struct userdiff_driver *userdiff_find_by_path(struct index_state *istate,
 struct userdiff_driver *userdiff_get_textconv(struct repository *r,
 					      struct userdiff_driver *driver);
 
+/*
+ * Iterate over all userdiff drivers. The userdiff_driver_type
+ * argument to each_userdiff_driver_fn indicates their type. Return
+ * non-zero to exit early from the loop.
+ */
+int for_each_userdiff_driver(each_userdiff_driver_fn, void *);
+
 #endif /* USERDIFF */
-- 
2.31.1.527.g9b8f7de2547

