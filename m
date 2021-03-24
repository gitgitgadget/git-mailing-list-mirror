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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9757C433EA
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A906F61A05
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhCXBth (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 21:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbhCXBtU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 21:49:20 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FE2C061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:49:19 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j7so22800280wrd.1
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vX0F8KGVcvq+hsDOU41OxzxH57opIj1jV160QaiGkx0=;
        b=t9DNyLIw51JKbG708TqkDdooqlO07ZAkQ4mVObmodimkQI6F+i7OYs3CuAZ6vjxPko
         h/VNxAmHhqeUrL5uelKmGwKbCljAGE7RzSZdCw2VtTTEYouMQXLU6ZITPibQERBQzS62
         dEGQHX1njqa1lTJ3VjGy8qGqqpE/2YXB9VeQHD4xYj0uyMZ5RbJoboyKNFdwxJPSCdO5
         zEJn6W0HJetzKJmErrBS24Yw5KSWHQGVz2/Tz7w/f9eKA/UKBRJsk7/RAjsHft66ZiNE
         Ft20RFYTNCtnk58wLy6tztENtn5OQjA8NQKZ5trDO2/PfXWI9Soyb7bn+l33rmBdsUNm
         1VXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vX0F8KGVcvq+hsDOU41OxzxH57opIj1jV160QaiGkx0=;
        b=CaBaZdZc2SQQY/6vlanEn9cb2Taw9H/GMyVLE5kJmueTkLo0gN8wDgb1SMNEmJtQdh
         b/dGVroclXlVoIQtbJDuL4rVoKx/YZJnDNsfjMYuiaKnzIMjjcXtotMoyRwkOeoIwDRV
         lPde2a99isHDg3c3aoJthGhQpKTT8RllESWaTJEVGonchOwQZ3VAmvMmxvoXKgr+Cm+9
         OXaPVZ3kVmsEi0OrYeyfsshenF9U/oO69l/Vw+h82nrxbEwIXQWT+Znb0LK4kdrJZ/dm
         SFTE7PAbExbP+ugczf28xoKNmDHWHk/nY6zoaYnIqKjJ+eh5WQ7qas2yds8aI6QaVvJ0
         UncQ==
X-Gm-Message-State: AOAM533XIoRcoteqDRJkhtK3Fw+a3RYCfi2MTXLB3ZjSIS//bAVli+fY
        peHqUAOpomBT5+aX9tOg9vDepJO3RjkP0g==
X-Google-Smtp-Source: ABdhPJwsb1DVKyLTys8e89WIMy/nNHVS7on4oscgv2M5KIwqk6hLh8DT+fuKiDh9+azujvBDPBlctg==
X-Received: by 2002:a05:6000:1acb:: with SMTP id i11mr785726wry.68.1616550558360;
        Tue, 23 Mar 2021 18:49:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y205sm598177wmc.18.2021.03.23.18.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 18:49:17 -0700 (PDT)
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
Subject: [PATCH v4 05/10] userdiff: add and use for_each_userdiff_driver()
Date:   Wed, 24 Mar 2021 02:48:47 +0100
Message-Id: <patch-05.11-64ea5e8443f-20210324T014604Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.366.ga80606b22c1
In-Reply-To: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
References: <20210224195129.4004-1-avarab@gmail.com> <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
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
2.31.0.366.ga80606b22c1

