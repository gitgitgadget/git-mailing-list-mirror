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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AA0C43381
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BED564E52
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhBOAxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 19:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhBOAxn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 19:53:43 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FDCC061786
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:03 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v7so7116530wrr.12
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FliCQt+KWe0ezaCzaZp+6zwkQ2ciw0OthqTq2rDtVps=;
        b=eh7QLlxHyt+ETPwwO8qOFDBXxb3PRZS4wBC7iu7BEUHab+q8wxP4eMmX+Bh1K9BHz6
         HWk8qQkTfmFwC5LhYdZdhzyEKqaeVGxnN0/Y/WTyX7uPnnvtJ674A4ct6Mw+HYeo7/KB
         YEGOtnIWxyDh+6LI0nPHmxSplB1HCs2mKprlFNUoFnjyZzo6xHn68kgqgGnBhAmui37B
         PtJ2pxzjPLqLgJoccTWXtUFy9tnO148Ddfl0IRxpouqMvDNnckJJKJspDptsG73p01l3
         EFGNZ/Ytj3CZ2XxjFalQoZ5FwLxGJH+uy4AjzTzNcPB8SmBxpiS3GZsokmkStK2AhcZt
         LGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FliCQt+KWe0ezaCzaZp+6zwkQ2ciw0OthqTq2rDtVps=;
        b=BJrn236oql/GHJCzoJHYPC2yYSNet4jbYNF7gdkNq0e0Jl47oh7YtF0eAIrpOBkfuq
         uyteRmfgCcmZcaZUy0Fw8EZDWOs4ZS0DK2cEqBuyy5wikDN2rQGDgpkFz6nCurib/SpE
         K7qL0WyNQSwUqnOrTpJ37mmW5YpoDH7QSi/o2IPQwtyqZN1Ju1xfj2ZYgKlcGL3X2fWX
         AnwdkwA4BtSM/JmvIIkJIIz89hO8PiMB0cbBGOUREyF0hyuovzhxbuObYnPSZbPYz873
         o5RDawP/W5DL5zQDQrCCXqwOlx3SS2+aASb6XZY6hvbFTw+A+/G2JSm0ayjjVcyum5cM
         WF8g==
X-Gm-Message-State: AOAM530zdx5vtOc5C6ijbOMomwa1NBpZSlG1hVPhzZF+FG1JEdG39wEZ
        GLK+s+EG2kaQRUOetR8W1c2LIkOTJ9Gv4w==
X-Google-Smtp-Source: ABdhPJyRA1ScdpMsk4W7gOHyIt7uxEtFfz2IUKKXPPRkOnKxh/PxRkXzXDZmicWCCwE4nqVrfeRBMg==
X-Received: by 2002:adf:f701:: with SMTP id r1mr16248379wrp.353.1613350381832;
        Sun, 14 Feb 2021 16:53:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm5209832wmi.2.2021.02.14.16.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:53:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/20] userdiff: add and use for_each_userdiff_driver()
Date:   Mon, 15 Feb 2021 01:52:19 +0100
Message-Id: <20210215005236.11313-4-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87tuqebj6m.fsf@evledraar.gmail.com>
References: <87tuqebj6m.fsf@evledraar.gmail.com>
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
index c92cbcc054..92b5a97e12 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -250,20 +250,32 @@ static struct userdiff_driver driver_false = {
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
@@ -364,3 +376,28 @@ struct userdiff_driver *userdiff_get_textconv(struct repository *r,
 
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

