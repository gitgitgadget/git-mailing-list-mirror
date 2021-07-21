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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75201C6377A
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ACB56023D
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhGUVly (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 17:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhGUVlu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 17:41:50 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D93C061757
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 15:22:25 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m38-20020a05600c3b26b02902161fccabf1so401578wms.2
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 15:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YTlh+f7DTH2pJDga0jMh+Y9T+cCiBpdIFHJWyUTk4bs=;
        b=h5Rsbgbbopky9cwSULp5wEyc162UfHwJzMqIH0flolRrDGsOcxr0RWaASqFCLFtul6
         exJ8i+FuLB6ffsziMs+Hvg3hXo1BQpwAZMgtQvROw5sQU7E/RFbkr4rYEx9vaGgVcYxb
         A5NImWIPwjNG1P0DEfeyfZVf93cqt0D7pkXY8IjVssP8A/dnYK0FqaBL2kn3ie1OvYWn
         KHjdJNcHfSUZwRqw1Rxk2MtMkyFaH8mwxpXHK7Tm3FHULOb92koU/yet1JXUvjcLYYtr
         ouEwBKibKO6VfBLhMAPdfG88iejm3XvEPyWaWwfqMRG9/TJVRLt2QsIxlu6VW9Vobs8k
         IplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YTlh+f7DTH2pJDga0jMh+Y9T+cCiBpdIFHJWyUTk4bs=;
        b=X9sAFNqhGN7ncs+qBH5XAsWtLQ+l3uV9rm9iTiYybX0jk3yZTmkyfsuXMuJiiFHBs5
         pSgxHi6VCijaAXy5i9rAmIS9M/GlA3SLDHEMHy0KmgtDkdSQGkZF+eb29NsAgjsJCr24
         47mhzQJ2J2gPko24ftY0Zo37yTjVVnT3BTbs1k8APqkeYJeBbcYXlm+cQ4gkoR1v+dga
         qvr4OioCCFMUbjlbudgYn/o/2su7iZa947rW7M8LrEIJnnqqC/tjsaOCLEyonLgtM6Qn
         TxwRod2C+BxSJyJpMUMCwCigKs4AvJDZruvTJwdFQdep1SCX3bKTRR21ycLTFIDN/LK8
         +H4A==
X-Gm-Message-State: AOAM530REU8DXKbugpJ3G9rnpBQxg9qQeM4MxDkYrS3K4FcOXFNWv1aE
        nPUIs4ja5SXDhElsFmbSpK46Xyy+4hb6Rg==
X-Google-Smtp-Source: ABdhPJw3p0hQBEi7cY4r/hSbFH2zATdvwYT/yZ5Dx1MJOxt9nDJKM4IaznwHJXCbPQ6Kf4VDv0ifwQ==
X-Received: by 2002:a05:600c:1c08:: with SMTP id j8mr39832683wms.50.1626906143825;
        Wed, 21 Jul 2021 15:22:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d9sm27792132wrx.76.2021.07.21.15.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 15:22:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/5] http: drop support for curl < 7.19.3 and < 7.16.4 (again)
Date:   Thu, 22 Jul 2021 00:22:15 +0200
Message-Id: <patch-4.5-9a30e92520c-20210721T220402Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net> <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the conditional use of CURLAUTH_DIGEST_IE and
CURLOPT_USE_SSL. These two have been split from earlier simpler checks
against LIBCURL_VERSION_NUM for ease of review.

The CURLAUTH_DIGEST_IE flag was added in n 7.19.3[1], and
CURLOPT_USE_SSL in 7.16.4[2], as noted in [2] it was then renamed from
the older CURLOPT_FTP_SSL.

1. https://curl.se/libcurl/c/CURLOPT_HTTPAUTH.html
2. https://curl.se/libcurl/c/CURLOPT_USE_SSL.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 http.c | 4 ----
 http.h | 9 ---------
 2 files changed, 13 deletions(-)

diff --git a/http.c b/http.c
index 1f0d7664d35..e9446850a62 100644
--- a/http.c
+++ b/http.c
@@ -120,9 +120,7 @@ static int http_auth_methods_restricted;
 /* Modes for which empty_auth cannot actually help us. */
 static unsigned long empty_auth_useless =
 	CURLAUTH_BASIC
-#ifdef CURLAUTH_DIGEST_IE
 	| CURLAUTH_DIGEST_IE
-#endif
 	| CURLAUTH_DIGEST;
 
 static struct curl_slist *pragma_header;
@@ -893,10 +891,8 @@ static CURL *get_curl_handle(void)
 	if (curl_ftp_no_epsv)
 		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
 
-#ifdef CURLOPT_USE_SSL
 	if (curl_ssl_try)
 		curl_easy_setopt(result, CURLOPT_USE_SSL, CURLUSESSL_TRY);
-#endif
 
 	/*
 	 * CURL also examines these variables as a fallback; but we need to query
diff --git a/http.h b/http.h
index 19f19dbe74c..3db5a0cf320 100644
--- a/http.h
+++ b/http.h
@@ -12,15 +12,6 @@
 
 #define DEFAULT_MAX_REQUESTS 5
 
-/*
- * CURLOPT_USE_SSL was known as CURLOPT_FTP_SSL up to 7.16.4,
- * and the constants were known as CURLFTPSSL_*
-*/
-#if !defined(CURLOPT_USE_SSL) && defined(CURLOPT_FTP_SSL)
-#define CURLOPT_USE_SSL CURLOPT_FTP_SSL
-#define CURLUSESSL_TRY CURLFTPSSL_TRY
-#endif
-
 struct slot_results {
 	CURLcode curl_result;
 	long http_code;
-- 
2.32.0.874.ge7a9d58bfcf

