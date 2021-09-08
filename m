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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC35C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6FBD610E9
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352121AbhIHPdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 11:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349619AbhIHPdN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 11:33:13 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E20CC0613C1
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 08:32:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 192-20020a1c04c9000000b002f7a4ab0a49so1476699wme.0
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 08:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UezT40KMIcX23ehphtMO5VMswgfsPjBmXZgy+GNeAQQ=;
        b=Uac2kRqhOKke8SqCGs23XgqFH75mvrOKrHa9SAAZtTTtjGH0SpRxu4a+D2UVeoXDY1
         shL5M8Y7A2tDy2C49+SpomScTv+wYhR9XbTV3aSLNTa6v/oBjp8ICSnhPUI0GFtP8VNk
         N0kAAp9mumFfH5OkIrrV5KY5aZppWi5OynwwJZWRuwZ/XOnKUxDMreP6b9f19AvyRgL7
         feeLGhGqkhSmEettmj1iqb3n95vGFgFfGSsXQ4zrQo+4ilyK3X0EN+ghXkd4+8drRTzN
         /zk8jWSXLs2o/OMhtb3Sd1b1C7os0V36fQs1uMryogyRvedRal1lbWCMAapWjpe3OSc8
         pfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UezT40KMIcX23ehphtMO5VMswgfsPjBmXZgy+GNeAQQ=;
        b=Fv1Q+73UH79qCkq6k49q55doazocgN7x7XNuTnbhIxMqIDisTGn3VA/gbi5d0TvX+a
         t7XiTNr6S+nCG/iRkgsiSEISoAqR13NzX7F94Wv4ibMFlxJoNlCSKglkBOGZrvY6oRq5
         sczVzLe8wr6QD3KmJ7QfSy6Xq0lcMqGPkndX6HosyFQdQ7ZJn8zpBv0GQAOlmJOA9yM5
         nuV17aQwc64FjnvdvnrbQbFjVxGgmcOhPIuyBnSK6u9UwdI3sg86QeQXJjOyNnou1+a1
         bHExafMaDu24jtIRoVJ+LmFRtLHBDE8SmZkgbuDfdKyyiw77EuzwrbnrJrpHXq0uUvDl
         odxA==
X-Gm-Message-State: AOAM530/gUCxBxPwJjruQxYLxcuIySGzRjkydsgypHiEn4m1s7JVuvui
        tZR7p4MzCshi+vII+HDvvvPPGro8KC7JlA==
X-Google-Smtp-Source: ABdhPJyNAlXnugR6vQmk4i2UvIuJxUANogGDwk4MZLFOt5r33NPxbn8d7oim/VBF78uWzZPz+TPUPQ==
X-Received: by 2002:a05:600c:3b26:: with SMTP id m38mr4135911wms.155.1631115122859;
        Wed, 08 Sep 2021 08:32:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm2385580wrh.67.2021.09.08.08.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 08:32:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] http: correct curl version check for CURLOPT_PINNEDPUBLICKEY
Date:   Wed,  8 Sep 2021 17:31:53 +0200
Message-Id: <patch-2.5-511534ce17a-20210908T152807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.825.g2bf60429931
In-Reply-To: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
References: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com> <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
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

Let's also remove the macro check before we declare the ssl_pinnedkey
variable, the pattern for other such variables is to declare the
static variable unconditionally, we just may not use it on older
versions. This reduces macro verbosity.

The reduction in verbosity comes at the small cost of issuing a
warning about the unused variable if this code is compiled with curl
versions older than 7.39.0. I think that's an acceptable trade-off,
anyone compiling a new git with a 2014-era toolchain likely has at
least other warning that'll have prompted them not to use -Werror, and
if not maybe this'll prompt them to compile their new git with a more
modern libcurl.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 http.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/http.c b/http.c
index 56856178bfe..f7d5b6a0776 100644
--- a/http.c
+++ b/http.c
@@ -59,9 +59,7 @@ static struct {
 static const char *ssl_key;
 static const char *ssl_capath;
 static const char *curl_no_proxy;
-#if LIBCURL_VERSION_NUM >= 0x072c00
 static const char *ssl_pinnedkey;
-#endif
 static const char *ssl_cainfo;
 static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
@@ -373,10 +371,10 @@ static int http_options(const char *var, const char *value, void *cb)
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
@@ -845,7 +843,7 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
 	if (ssl_capath != NULL)
 		curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
-#if LIBCURL_VERSION_NUM >= 0x072c00
+#if LIBCURL_VERSION_NUM >= 0x072700
 	if (ssl_pinnedkey != NULL)
 		curl_easy_setopt(result, CURLOPT_PINNEDPUBLICKEY, ssl_pinnedkey);
 #endif
-- 
2.33.0.825.g2bf60429931

