Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33B0C4332F
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 20:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F3C60F4F
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 20:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbhJBUSS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 16:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbhJBUSK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 16:18:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E4FC061714
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 13:16:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g198-20020a1c20cf000000b0030d60cd7fd6so999325wmg.0
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 13:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mdvztQa66XnY/Soy3w3qC5vSdXiCFM23ng+RutHiTwY=;
        b=jW5OWVUbf8LCUkRkzYNZbDckjfhgKJganJPq4SjYz2hB+rcsQl+0V2QFngWMS4pNNX
         3l8wePwPbBlBu7tO4BljnlSUPEcO/02YLLA2LvIxC4c/iP6aVC8Ht3IKM+rHBIxU80hG
         KdA0UYvAxDUuKjpEJnyIpph6SP40JV02lQym3hNja7y/PUXp+LJry3W0hQea+4fo4Hrg
         tQDFDDlwtaPh20xz1mtBeY7ZVwAQwyHHOBYoOnB0at/yn8ixkOt9V2g6dUgXAIFxFKIy
         FKeN3UdLihh5ubSfqzskcY2wvEgo8ceXQu8AL8lywJ60H+CSiYDtDldGKWrq1ngNZ5Dn
         rLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mdvztQa66XnY/Soy3w3qC5vSdXiCFM23ng+RutHiTwY=;
        b=GBXG7Tqz1FJrShk6X8Ir+t70+i85nPDaSCHqKhyAziL8R7v+7DLucYxvM1MYEKG3sQ
         tnL5JicMdHDdBWRNi77CwbdG7EAVrXgKh80irCMqS2HUx6gXF9yZRZ+tnAIReA3KQ4N9
         HPly6UvW05SoHKYwHXvzgKFLZBPnK02sb/v6gHomP/Jyc+1WR19a94Xa7wSLKpHV1VgA
         qr1+mjzejiDCrTe6R49uB3Rg3wW7fezwDeTPqusbZ06uh7tJljPIXOCaVjqXiJ/ikuR6
         ACNLU/l6qqjVUomefn9NyENNj9hMhKtPQW5emRC4I3DkFXhLTNcgB0HETAPvG4+YIU59
         GLbg==
X-Gm-Message-State: AOAM531EcnLwU5/Nko2KPZF2PbwG+kw7UfLbT1FegoUOAui+ltgRkj/R
        luikt+kYGnOV7jaW4GtSQZZl6qwXb+cuOA==
X-Google-Smtp-Source: ABdhPJyZGXijMDXjgXIUqiQDN19OQnYDz26WaGo9pNmuWiIePsvvHeKiePGlR85LopriZStYSRzylg==
X-Received: by 2002:a1c:ac86:: with SMTP id v128mr10721078wme.3.1633205782373;
        Sat, 02 Oct 2021 13:16:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g2sm9946009wrb.20.2021.10.02.13.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 13:16:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/5] urlmatch.[ch]: add and use URLMATCH_CONFIG_INIT
Date:   Sat,  2 Oct 2021 22:16:15 +0200
Message-Id: <patch-v4-3.5-266948e604c-20211002T201434Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1380.g193143c62ce
In-Reply-To: <cover-v4-0.5-00000000000-20211002T201434Z-avarab@gmail.com>
References: <cover-v3-0.6-00000000000-20211001T102056Z-avarab@gmail.com> <cover-v4-0.5-00000000000-20211002T201434Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the initialization pattern of "struct urlmatch_config" to use
an *_INIT macro and designated initializers. Right now there's no
other "struct" member of "struct urlmatch_config" which would require
its own *_INIT, but it's good practice not to assume that. Let's also
change this to a designated initializer while we're at it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/config.c | 2 +-
 credential.c     | 2 +-
 http.c           | 2 +-
 urlmatch.h       | 4 ++++
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 865fddd6ce8..542d8d02b2b 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -575,7 +575,7 @@ static int get_urlmatch(const char *var, const char *url)
 	int ret;
 	char *section_tail;
 	struct string_list_item *item;
-	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
+	struct urlmatch_config config = URLMATCH_CONFIG_INIT;
 	struct string_list values = STRING_LIST_INIT_DUP;
 
 	config.collect_fn = urlmatch_collect_fn;
diff --git a/credential.c b/credential.c
index 000ac7a8d43..e7240f3f636 100644
--- a/credential.c
+++ b/credential.c
@@ -105,7 +105,7 @@ static int match_partial_url(const char *url, void *cb)
 static void credential_apply_config(struct credential *c)
 {
 	char *normalized_url;
-	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
+	struct urlmatch_config config = URLMATCH_CONFIG_INIT;
 	struct strbuf url = STRBUF_INIT;
 
 	if (!c->host)
diff --git a/http.c b/http.c
index d7c20493d7f..da12471c242 100644
--- a/http.c
+++ b/http.c
@@ -990,7 +990,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	char *low_speed_limit;
 	char *low_speed_time;
 	char *normalized_url;
-	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
+	struct urlmatch_config config = URLMATCH_CONFIG_INIT;
 
 	config.section = "http";
 	config.key = NULL;
diff --git a/urlmatch.h b/urlmatch.h
index 6ff42f81b0c..34a3ba6d197 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -66,6 +66,10 @@ struct urlmatch_config {
 	int (*fallback_match_fn)(const char *url, void *cb);
 };
 
+#define URLMATCH_CONFIG_INIT { \
+	.vars = STRING_LIST_INIT_DUP, \
+}
+
 int urlmatch_config_entry(const char *var, const char *value, void *cb);
 
 #endif /* URL_MATCH_H */
-- 
2.33.0.1380.g193143c62ce

