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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64B6C433FE
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A5A60249
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241525AbhIMPiM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbhIMPiE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:38:04 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A90C020E7D
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 07:51:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u16so15148509wrn.5
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 07:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DMUtiS4Lhx7VGgQLSJW5yNJ36WytHsRs5vDzmXhu+kc=;
        b=jEyEm1ABkdv6A35eYj4yoEf07eng5vMN8DaHzWA7VjK56m0BHAF3mvh17dmItFym0B
         ++upmkLI/8Ye7oLBuaOLx+fQ+S2DA3V9MV59jz3CWyM4QMWRhBduHTlgK7Kv1FlShQeR
         P4bm0R80E44AhYZlZKx8qp6nXO9zPCZ+jarm/Vv3TY8oyFOLokC2gAPgXbA8XZ9ggA2x
         Bu4JPibYxtaHKqownTg75Ig69Kr9u1RVAyn2AYUGZsSbiaTMkkxOe1fnOU5QTpEzZQR7
         GRmGcRGe37QvCabkoAwp7VrOdG9HDifIrgkALLQpe8w6/CGQ0Jlf5M/8NdwWkMwOiNj3
         n4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DMUtiS4Lhx7VGgQLSJW5yNJ36WytHsRs5vDzmXhu+kc=;
        b=Y7iJkcwPFQsGcXILYk5MStkZ93EGOvIN+B/9ZO7QY2HEJJ5le/tE//ND4KPDNTKyAN
         9yx1Ur0tg9qouvrHf/c+hU1+xPMi6O/uTcu0/GZscCo23w1f10HPCv47JB4w2V5IDkDF
         EVOtz2lh9bKKYxnUqKMCGnD9tNfTserNV7WYuzTJ0hPLJy4Z65spiO3XJPqW8U2TfhcV
         lt96f2mf/CC0TI2PbkQ17c4O4E1womo2+QyWVKLFjLEXEDb/1RnTOyM94rurjcJUdbmY
         3rY4FQNoJ5hMJP5HfryI5kVUnFCD9eoqbzg+2UxHKot9j46vRXKpBOwpPGjkgSTHOxoJ
         c15w==
X-Gm-Message-State: AOAM531+SDpeWhmbzruu1Fb5tzhbwdeH7OED6Nee/If4LMrtOJ+vWYlu
        1oL6cJOsKo58Luo3h1KhEfl3heDNG96l+A==
X-Google-Smtp-Source: ABdhPJyZ0123/AWB2+2msjE3TD3BCPzvY2k6h6wJhPwhu/+2cTAAYxGAHFmVgiqh6NF7m9XcdIYisA==
X-Received: by 2002:a05:6000:46:: with SMTP id k6mr5863896wrx.104.1631544701324;
        Mon, 13 Sep 2021 07:51:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o24sm3638854wmm.11.2021.09.13.07.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 07:51:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 7/9] http: correct curl version check for CURLOPT_PINNEDPUBLICKEY
Date:   Mon, 13 Sep 2021 16:51:27 +0200
Message-Id: <patch-v4-7.9-7aa5149c395-20210913T144846Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1013.ge8323766266
In-Reply-To: <cover-v4-0.9-00000000000-20210913T144846Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20210913T144846Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In aeff8a61216 (http: implement public key pinning, 2016-02-15) a
dependency and warning() was added if curl older than 7.44.0 was used,
but the relevant code depended on CURLOPT_PINNEDPUBLICKEY, introduced
in 7.39.0.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 http.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index b82b5b7a532..543faad9879 100644
--- a/http.c
+++ b/http.c
@@ -59,7 +59,7 @@ static struct {
 static const char *ssl_key;
 static const char *ssl_capath;
 static const char *curl_no_proxy;
-#if LIBCURL_VERSION_NUM >= 0x072c00
+#if LIBCURL_VERSION_NUM >= 0x072700
 static const char *ssl_pinnedkey;
 #endif
 static const char *ssl_cainfo;
@@ -373,10 +373,10 @@ static int http_options(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp("http.pinnedpubkey", var)) {
-#if LIBCURL_VERSION_NUM >= 0x072c00
+#if LIBCURL_VERSION_NUM >= 0x072700
 		return git_config_pathname(&ssl_pinnedkey, var, value);
 #else
-		warning(_("Public key pinning not supported with cURL < 7.44.0"));
+		warning(_("Public key pinning not supported with cURL < 7.39.0"));
 		return 0;
 #endif
 	}
@@ -845,7 +845,7 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
 	if (ssl_capath != NULL)
 		curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
-#if LIBCURL_VERSION_NUM >= 0x072c00
+#if LIBCURL_VERSION_NUM >= 0x072700
 	if (ssl_pinnedkey != NULL)
 		curl_easy_setopt(result, CURLOPT_PINNEDPUBLICKEY, ssl_pinnedkey);
 #endif
-- 
2.33.0.1013.ge8323766266

