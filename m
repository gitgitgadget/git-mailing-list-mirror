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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38C9C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 09:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 820F0611F2
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 09:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbhIKJft (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 05:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbhIKJfp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 05:35:45 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19DFC061762
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 02:34:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x6so6246790wrv.13
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 02:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p6sAdv6gcAx92uKQ69Z6XJSwGRBaNoHiaJMILFPM5Vo=;
        b=bGqafKbTz6U+zarC1rFYD1VE16UoWvFiv3KrERp7eSudkU8l/L7KytTTD85D7FGQE5
         ep+59z5r/4E06KvUE8K0ye1q+skK5VSsFSvxFwJadeHic0zjRGihVNA4JQZuu4a4qlcQ
         Xfu7SnkA9W4DmkCq3e5N9/kilnxw375hBln9/CGHFhCMDujqJ50AairKLmHJkb1I77mk
         NArpeJjwh8/bCe9x6L75Nw1BUWp9lA2rhYvrPPpJIg6UqHgBLGFLHSAcg8qsQnF3zcFU
         wMszeVUBjKd/m5OoTbcRGIt1HgX+KIlqPub3if1+NW4/f1yLNp++mg+Dls4NsqB6i9G4
         iJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p6sAdv6gcAx92uKQ69Z6XJSwGRBaNoHiaJMILFPM5Vo=;
        b=VV0znoQsXn7DzwUw7jzHMU9ZP714vCzFwmpbeL9twiGWeaGQgDTKugEw/59rZD4Et7
         BYPKPO+dmdi/6sFhiWE3lriMuzI1JEHbwk7ysjEY31kYSgDBn01TQENx6ttyE5sbEJo6
         6N3Dk4RzJRpbs3sxdvvFmoE6mBe2h5EU4cgMKqYfAIZ0fwfbd/0NdaXSDcW3Ko2qY+Bs
         1VbyNX7Stud88XOVj+pMOx7h5VVrJ4QZpyq/VIpG6YJLhw0CIYvWz4ZqAXohxh3ibawv
         5BhHlBqGg/NyyLjSpfA/QnqqzS+vk7YQ13vjl9pt75CA3ogVRkPFiifX/o5A92sYA4Ej
         hBNQ==
X-Gm-Message-State: AOAM5332qMNQruVaqcYX54DC2Fdk4GJz/cngcsZwL6IcnwS9K31py7gO
        xLa4xBY8/ltfLTeZf3fI31b3IKKY8MQtpA==
X-Google-Smtp-Source: ABdhPJzEVAfO+znWQV+PGpVOzQ8al8el9NP+WlgtcHFO+i4F6h6Yyerpvwgw4g6J/GwFtE/JOW57+Q==
X-Received: by 2002:adf:f541:: with SMTP id j1mr2274145wrp.180.1631352871185;
        Sat, 11 Sep 2021 02:34:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s10sm1161753wrg.42.2021.09.11.02.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 02:34:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 7/9] http: correct curl version check for CURLOPT_PINNEDPUBLICKEY
Date:   Sat, 11 Sep 2021 11:34:21 +0200
Message-Id: <patch-v3-7.9-db7d6029dda-20210911T092751Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.984.gea2c3555113
In-Reply-To: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
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
2.33.0.984.gea2c3555113

