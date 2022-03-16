Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC634C433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 14:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350193AbiCPOCf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 10:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240745AbiCPOCd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 10:02:33 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E635966628
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 07:01:18 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g20so2840701edw.6
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 07:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6YsIQ2LV9gQ7a1cxMHU4fR4RLr+PARleKrolN8DGNf0=;
        b=o+/urihPV4dqEnNVeSXL6hZZWrvWtnBx33CF0KIbU5L+8iDJxQMpJeZy5+lTew+QZX
         Hrc7W9qP0jS4VX5I6QkaWRmIWVAEf2QIp+NdVIOnZeABPx891gkTL8tqvN1BVV1fE12x
         GUmj1i8Lk/ectlhRoYs+ZQZn/YPeXPJpAuMofmsfGikeX3oGIz4tEQoFMOm2rwJioBKq
         uxZuWp7R2gMVdvgsgH5hmTvfjwSCd0AiFA48x8d7rGVu33wQjwnukafQEDHJNHYbUPIu
         +lAYCao6/FsXDk+95GZBvltO1qPKV5tfNyUqbGCX2kmQeMI8nDdUw45pYAQC3mZcOiQa
         AwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6YsIQ2LV9gQ7a1cxMHU4fR4RLr+PARleKrolN8DGNf0=;
        b=qIt+czgL7HKkL8mV5qD4Bl9unD9E5UxaErtw8Fg06yy/uX73oBkr2blTCyDPy5USK9
         EnhYubcuSXZPobUYmaDICkr9FTLRzVG2RAVa54pSQq9nbGVzpJhUFoUg9pvDvB9KXuoq
         K8NTBabQN2SpB+TJ6EI5YDwpqdVDalQByDUgPZaimhpaAX+0isvXd9eZ/8t1h7gD1tIX
         kgPFJmIK4d222V++PqlcifZ17ezAzU/bItkc8lBYHMnRXhtHmJoyPWWe3Ig5ZT0RBlX+
         LVB3/ajJLfbvqwyn5S9+g+dLt2Nl28Gd2AU3SXuIkbNBj80IEZ9KVZ/BFYd+/T23e/o7
         48Kw==
X-Gm-Message-State: AOAM530EfAdId2EbvzhP9ZQ68vlSbG4HW2mBtXu7xhLYxdLfjpJKRMx0
        aWRqh+8OXhax93kDrakPrPu3QKKppxA=
X-Google-Smtp-Source: ABdhPJyWegRelpbv2dcyjaYPiO/9nhJgRnXQbCO/5dKogeiwYpL1MmKqQxa1iOcg/RPb0AtGbB78Dg==
X-Received: by 2002:a50:d49a:0:b0:418:f02c:2c39 with SMTP id s26-20020a50d49a000000b00418f02c2c39mr579295edi.147.1647439277056;
        Wed, 16 Mar 2022 07:01:17 -0700 (PDT)
Received: from fedora35.example.com ([151.27.250.86])
        by smtp.gmail.com with ESMTPSA id yy18-20020a170906dc1200b006d6e5c75029sm910011ejb.187.2022.03.16.07.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 07:01:16 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com,
        Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 1/2] curl: streamline conditional compilation
Date:   Wed, 16 Mar 2022 14:01:05 +0000
Message-Id: <20220316140106.14678-2-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316140106.14678-1-gitter.spiros@gmail.com>
References: <20220316140106.14678-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier we introduced git-curl-compat.h that defines bunch of
GIT_CURL_HAVE_X where X is a feature of cURL library we care about,
to make it easily manageable to conditionally compile code against
the version of cURL library we are given.

There however are two oddball macros.  Instead of checking
GIT_CURL_HAVE_CURL_SOCKOPT_OK and using a fallback definition for
CURL_SOCKOPT_OK macro, we just defined CURL_SOCKOPT_OK to a safe
value when compiling against an old version that lack the symbol.
Also, the macro to check CURLOPT_TCP_KEEPALIVE (alone) was named
GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE.

Introduce GIT_CURL_HAVE_CURL_SOCKOPT_OK and define it for the
versions of cURL where we used to use our fallback definition for
CURL_SOCKOPT_OK, and use the fallback definition based on the new
GIT_CURL_HAVE_CURL_SOCKOPT_OK symbol at its sole use site.

To better conform the naming convention of other symbols, rename
GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE to GIT_CURL_HAVE_CURL_SOCKOPT_OK
and update its sole use site.

After this, conditional compilation with cURL library is all
controlled uniformly with GIT_CURL_HAVE_X mechanism.

Co-authored-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 git-curl-compat.h | 6 +++---
 http.c            | 6 ++++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index 56a83b6bbd..b14234f9e7 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -31,15 +31,15 @@
 /**
  * CURL_SOCKOPT_OK was added in 7.21.5, released in April 2011.
  */
-#if LIBCURL_VERSION_NUM < 0x071505
-#define CURL_SOCKOPT_OK 0
+#if LIBCURL_VERSION_NUM >= 0x071505
+#define GIT_CURL_HAVE_CURL_SOCKOPT_OK 1
 #endif
 
 /**
  * CURLOPT_TCP_KEEPALIVE was added in 7.25.0, released in March 2012.
  */
 #if LIBCURL_VERSION_NUM >= 0x071900
-#define GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE 1
+#define GIT_CURL_HAVE_CURLOPT_TCP_KEEPALIVE 1
 #endif
 
 
diff --git a/http.c b/http.c
index 229da4d148..d7ad7db1d6 100644
--- a/http.c
+++ b/http.c
@@ -517,7 +517,7 @@ static int has_proxy_cert_password(void)
 }
 #endif
 
-#ifdef GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE
+#ifdef GIT_CURL_HAVE_CURLOPT_TCP_KEEPALIVE
 static void set_curl_keepalive(CURL *c)
 {
 	curl_easy_setopt(c, CURLOPT_TCP_KEEPALIVE, 1);
@@ -536,7 +536,9 @@ static int sockopt_callback(void *client, curl_socket_t fd, curlsocktype type)
 	rc = setsockopt(fd, SOL_SOCKET, SO_KEEPALIVE, (void *)&ka, len);
 	if (rc < 0)
 		warning_errno("unable to set SO_KEEPALIVE on socket");
-
+#ifndef GIT_CURL_HAVE_CURL_SOCKOPT_OK
+#define CURL_SOCKOPT_OK 0
+#endif
 	return CURL_SOCKOPT_OK;
 }
 
-- 
2.35.1

