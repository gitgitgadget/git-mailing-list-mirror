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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212A7C433E6
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAB4464DEB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhBOPtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 10:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhBOPpc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:45:32 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837C3C0617AA
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:51 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o15so6573562wmq.5
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ILNqwJvzmh6SvyzGjR68oYrKEltXH5W/P0qo3Mp639s=;
        b=gUcgWC1Yc8TtgAZAGuZ+bpkx41q5Odf6+pIkyvZzq/JXLrXeee72Q2wma7Vu0qMpj6
         gYYUzrFs2Xc1swnRecfWQvifAmemoJA1fC+eA3tglc4/i1kGJ8VoojMG8n6D0y3GyZ1G
         T8P+Mt2VcEM37HBean0Uy7WA0jQ6/eN+WCmq66iMpW04JIJ6mJt7AlQss0UwMDhJlpkd
         HCtvnrDOcJkYJQjI2nnFwOGsGjh32mvaDiV7oJLttuj9Kra669cXEB/gVRuzHSkGpKGg
         PdeXwMblFuUvrLvMZg2Z3vTRzwy3g96ptMcWG1f3f6Xdm1/aT6g6PBw0SEYnB2S+wvji
         m6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ILNqwJvzmh6SvyzGjR68oYrKEltXH5W/P0qo3Mp639s=;
        b=mE02m3NqveBbdorc7odlT4BqgSYQn/7fEd8GzaDoomG4il+cM/lsU+jfyeFs2uhN5g
         Du4LMhYDGrfLw0SKe6c+7EbThwveRVPa28Q0juRWNtro4U8nUNtdVoyyuG3cQ6CwPGrP
         cGigzoBBc44wfgqz2qPajJllKggqvHBxg2cA50vVGc7g7cwOZfMsA8VT6kxqh7QJtpSY
         wY8BnPaah92rVAIaj8MZWHO+0Dm4XiPd+XiBPpyRywa0kI0wCwhsSEtNkf/FR2VCeIh/
         P5ClrSq3A1Spqd/INJa4TfTB4+ui0jQfpkPZpkzw4PrJb3VtUWIxEifQ23+ZbAHL9VNG
         YiKg==
X-Gm-Message-State: AOAM531AUAacxAyuY/6GStni4kL0kCOGZ+sD3opwYmEu33ep023vp84+
        RQzxYafCRJchElH53GmkBPxM8vdlHmqxUg==
X-Google-Smtp-Source: ABdhPJzPkLrK77T9kdjW9mPpv3qquh4LxLfLPqd5tPLziIkLThfswY7R8t7JvmsqYG0P0ZqnjrcmiQ==
X-Received: by 2002:a1c:7f83:: with SMTP id a125mr14436729wmd.141.1613403890037;
        Mon, 15 Feb 2021 07:44:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:44:49 -0800 (PST)
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
Subject: [PATCH v2 05/27] userdiff: add and use for_each_userdiff_driver()
Date:   Mon, 15 Feb 2021 16:44:05 +0100
Message-Id: <20210215154427.32693-6-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
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
index 10a02d3620..55f4f769bd 100644
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
index 203057e13e..fe14014a77 100644
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

