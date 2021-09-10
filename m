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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F433C433FE
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D9D7611B0
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhIJLGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 07:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbhIJLFx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 07:05:53 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FAAC061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:04:42 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id s24so921029wmh.4
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R0MfkI47ZKJnsiLXFRP0qdKwbb8lMPMQJbi8RFlxmIE=;
        b=dsEYgEeoSgRQe9l7kOd2EjhuJqdUsJ/RRGMWDTD0Do+AgIZxMWMcgZCAF8eXJVh7hS
         Cy+NuKRXYMJzTIYPWsghLLZ2LFZIwcyIaGIflUsAnIBSCw6FJZ6WnwQOpJLTLpIZrfGq
         Q1YllJ6vbJt8ARRti+Y4/lntzcOlpXI3LbGWYkkBck1UqjIs5Zu4/Nx13G3xi/cf81oV
         j+mVWGcxrvZmxS6djsjBaDqa1rczfIzXk/i1fzfbhEBaR2oVm/+cfqJMP/xH+A46yib7
         pJGGID2ybBTIIZOr+PlNvVbsHUyCna6JDfxX/7yAoPUoyVbgt1Y5f4uEvDM3BuXv7O7H
         h6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R0MfkI47ZKJnsiLXFRP0qdKwbb8lMPMQJbi8RFlxmIE=;
        b=59SjSqSAp1FImM4NvRW5d/zrGI/r6SACgy7Hv5yx2k0nhSCyhOeRKzFVfq+ZZNA0//
         Dzx6ChjblyMwYZX7aSVAed5fVOcIMyJENNv8RHVFiM0ce+Uu/U/5x+9q8cE2K/FwNk1f
         gRbzdOu3+vNpUQBihqrmwXZP/3T/vFJdU92L4uO/jFcpKrxKduxv2C0iQf35348IcqOU
         ZljpbzCTmuHVveNFoPTyP9ZwCBBsjloAQvOMPTFQSIo9wCG0pKihqY7rlLRlyNMUbhsD
         sUbXJV9+VOIAwV1RRyevjVZOaW52AD7D1tX6ntRz1hrBXaTU7AWXD6EzKylERAjCIuoy
         fJrg==
X-Gm-Message-State: AOAM531YrHWUGFjboxKgyIbSrsJysSgchuuzejhXfFdu8iqgVl13Tq06
        FDZHpLX2LvRGwIJogBc0y0q4oZ5wkH9xOQ==
X-Google-Smtp-Source: ABdhPJyLEYu1hAtzJYRWif30QHJOin+UuB3WdpopP+E/96E8El5GqwnaUBfnRUTy1DkhVwuj6JCPQQ==
X-Received: by 2002:a1c:1b17:: with SMTP id b23mr7644757wmb.139.1631271881317;
        Fri, 10 Sep 2021 04:04:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q201sm1013631wme.2.2021.09.10.04.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 04:04:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/8] http: correct curl version check for CURLOPT_PINNEDPUBLICKEY
Date:   Fri, 10 Sep 2021 13:04:31 +0200
Message-Id: <patch-v2-6.8-397d54a1352-20210910T105523Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.873.g125ff7b9940
In-Reply-To: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
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
2.33.0.873.g125ff7b9940

