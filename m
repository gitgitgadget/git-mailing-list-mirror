Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1D1C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 09:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 597D760EFD
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 09:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238241AbhG3JfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 05:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhG3JfL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 05:35:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C07C061765
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 02:35:06 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c16so10448837wrp.13
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 02:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tcsh00QOQf+qysdPnrhEpOfwU5gWW3FuwQOuDiE/zw4=;
        b=IloGr6YruR3m/jj37m7KMEKuOEL0K3rIzBcH0aogONMGcId+UJeO11+TrwR8ejrSHm
         ZW+dVWTzlZRjirIyteRLkbkqa5yvoRhwDDuoEb7Z+8/YzECndMwdgqX0ZruxDVod48X9
         Yy1THJbQv6gSLUo9yc6eC6yrulf/hGttpgypdFrPsUXMDpkRXiGa7CqayGz7R6tlH2pg
         1gAEsu9j7h0ZAb4ZrimGGFwQhXY0XiWPS2P7XlqTo3QcDelfQ3dZkivkNU4oCxVThus0
         mZNKXLQiOSqwzBBUpAHsc8yQb9Hiv0ocn9gvXYpT2CGUaJgqmf5FkzvPBKC4BSKYWG8l
         3GnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tcsh00QOQf+qysdPnrhEpOfwU5gWW3FuwQOuDiE/zw4=;
        b=JHngNnCkk2DfKSc5YkDfX2CNPnD9Wp3Zw77/JTInAxB6XOwxlTFmNrYe0shLMtrB0J
         92ZoFIv0NZdgb/sNZ/vtJEiz+YIqWEAyi8XPQu2dWqI1t+OaPtH+Y4Ry1XSDj4icZL7l
         eIYaEBcJnsj24SOMkOPgY29RnIByydZ9B7CcLQOMotMjfYUZaI5oDYZd5vtcd/1uxcte
         SA3benSYWYS79V5rUWqZbTsbCXnaatAfYK5BCdVB7dV+3B6CBBqz1YG0+JavX6cNZKhT
         QDd3GQLJIRSOw0OTTfL1m6W0q+tXD07Dq/PPDCZY65X/ONXpi7oGj1p5WSQBZ7Jke6Yf
         +SpQ==
X-Gm-Message-State: AOAM533migMJdkZKZczEbytf90mu5P+4VmY3gj1ZC2FXexy7KSVsQovF
        zJYdftMsHw7/eJAAQmJOreGaB9HtbIecWw==
X-Google-Smtp-Source: ABdhPJyygJboU2kxiNvMb/PTiX4X7bT0ifO7ts9WAy5L46m7VPe/COWBR3KNjr6nuY4QpThsjZX/vA==
X-Received: by 2002:a5d:4688:: with SMTP id u8mr2021315wrq.65.1627637704684;
        Fri, 30 Jul 2021 02:35:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t17sm1089903wru.94.2021.07.30.02.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 02:35:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/7] http: drop support for curl < 7.19.3 and <= 7.16.4 (or <7.17.0) (again)
Date:   Fri, 30 Jul 2021 11:31:56 +0200
Message-Id: <patch-v3-4.7-230b968382f-20210730T092843Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.1069.g516d52f3d85
In-Reply-To: <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com> <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the conditional use of CURLAUTH_DIGEST_IE and
CURLOPT_USE_SSL. These two have been split from earlier simpler checks
against LIBCURL_VERSION_NUM for ease of review.

The CURLAUTH_DIGEST_IE flag was added in 7.19.3[1], and
CURLOPT_USE_SSL in 7.16.4[2] or 7.17.0[3], depending on the source. As
noted in [2] it was then renamed around that time from the older
CURLOPT_FTP_SSL.

1. https://curl.se/libcurl/c/CURLOPT_HTTPAUTH.html
2. https://curl.se/libcurl/c/CURLOPT_USE_SSL.html
3. https://github.com/curl/curl/blob/master/docs/libcurl/symbols-in-versions

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
2.32.0.1069.g516d52f3d85

