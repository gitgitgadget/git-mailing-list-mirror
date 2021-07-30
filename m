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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7058BC4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 18:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F8C6023B
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 18:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhG3SAG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 14:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhG3R77 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 13:59:59 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAC7C0613CF
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 10:59:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j2so12326914wrx.9
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Np5a1kzELe/k427r8aPp1Eydoyivy420pflqQqtdpBY=;
        b=kcMV6/0iJSJzp8HpapnqRxmLLsrVyoa9VGkYO754Qqvg/cW9UpAYGoCXPcVmrIEOnC
         b9JCAoFL2gfFZYl7Jv9n5WbZQ7vc0OI656ysVaPj2jgvnjdKgcFmcplsbE1UiyiVI4VN
         kIGGRcUTUUqnVGkeEV2tSedtRAhmtlSGKkxNtIf/8ZQoUWURt9oHRiwhChKwwgJ3zmvT
         FkXN5PIt7Hkb922iX6ZBEio7TBpctcr9C1YLK7VuaQHcfetMG/htSqz+cmVsz4L5m+5y
         Esl+yVckMZUxYMmbjlwECqQCuP1DdeZAfpXG7tuY/C5t4WxyQxxElM/rzNkE7NgDGMG3
         kCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Np5a1kzELe/k427r8aPp1Eydoyivy420pflqQqtdpBY=;
        b=CbRPywxkJOurT6Ab8vvFIeS1qPhtOxLCQXKDGm0dK+Pk6H4iHB5KT6p9V5mw/bNYIJ
         gQz5PG3+oPQpEbQpUE+RConrCT0UnrOole554OYA5gb2z/iMLxkmhYgQGSlxmJiJLy+O
         dOBYsxE3EgbVb8uduMyUjPVYqmZSG/lIvsqHA91UnHE0erhMUxe/13DHFVE78RXmxQv1
         Xt54VWML639MX37Rm5gwb5038P7xzJWGlKc5B+gVPt7IVSEVCg7R1BytUvG5LEFobJv+
         +oj52XKy1EdY2hzH2jGM3J5bx1PRUysAr7CntlGJba+BOoynv+bgaG/B3IctBSi6M4h1
         C0jg==
X-Gm-Message-State: AOAM533NNqUWdFt4w89oruviYKRHRor5lAR2mjgne7bVz8oUaOEcjBd0
        c3vZCJDviL51XavxFtmouICndkX3exwi2w==
X-Google-Smtp-Source: ABdhPJzSIQ/AMddtuZ+LXTzQjrvK4Ag6zHi+o9SenW8DW2QNMaT9IbUPsv6yhgxQUEpptJL/zr72fw==
X-Received: by 2002:a05:6000:1106:: with SMTP id z6mr4403953wrw.296.1627667992129;
        Fri, 30 Jul 2021 10:59:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i186sm2540311wmi.43.2021.07.30.10.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 10:59:51 -0700 (PDT)
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
Subject: [PATCH v4 4/5] http: drop support for curl < 7.19.3 and < 7.17.0 (again)
Date:   Fri, 30 Jul 2021 19:59:45 +0200
Message-Id: <patch-v4-4.5-42d1c72ff7e-20210730T175650Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.1071.g36f34456314
In-Reply-To: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
References: <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com> <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
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
CURLOPT_USE_SSL in 7.17.0[2][3], as noted in [2] it was then renamed
from the older CURLOPT_FTP_SSL.

The documentation[2] currently claims that it was introduced in
7.16.4, but the symbols-in-versions file correctly states
7.17.0[3].

I've submitted an upstream
patch (<patch-1.1-953bab490-20210730T170510Z-avarab@gmail.com>) to the
curl-library mailing list fix the documentation.

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
2.32.0.1071.g36f34456314

