Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93067C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 10:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77D37610F7
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 10:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245481AbhIXKJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 06:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245587AbhIXKJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 06:09:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447BEC061574
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 03:08:25 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i24so9815378wrc.9
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 03:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G6zgCsLlvqDJDoP3842A2EsongmYGwSVgLTjX8B65Zg=;
        b=PNBw3thymZCjTemUQ7R8jI8qprtxKbkzEr4XMc69hEB+MijN+y+3fS2g+wpbm3vMPI
         ctcW7GZwUVkt86v36UOYfCsKqZ2BVmRt0u7nhS/9vv/Ht9q7jrFm7/3InwEJjCg2CoUd
         c6reXcpre1nucUzsR04XpI2vnvv6jzdtbgkE6r4IUe5S3whpp3tJdV4QnC/pehW15OYF
         txQ9lOEEnCxr1XDb7caY9eeWuTob3hpsAZGZD+ygTE8687J2yYWuecIsmxDKw1dp+uvJ
         V8X1NKcRmLNqye5nTItGlPYNkzkAYh9Jkz5FC17uQqecP2cftHexy/ymV7CKadkr5d5W
         KFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G6zgCsLlvqDJDoP3842A2EsongmYGwSVgLTjX8B65Zg=;
        b=VgrFiZ9yLGXDy+iV9JESO+1h2QrnYo1ynyyyqJ4H8t6Csq3eUw0yZyhBIBCLmFezUG
         OkOypsQyjXYC1rHbxaRsp14vYZyKRNH2zWvzh/lnRgrUOAc69resllW3LUg2y7slARSn
         eAMfZh54c1FibZ4PPVnMpb+v1PmxBMrQJtKBZnYl6ywuuXMSFw49lLNMGcPg6irGLlyg
         xBaSAx0gUOGjqqszb8QdiG6S/ij2aClSvRGyNDrPDcm1V6LWLwCZ/IDjnT7bM2YPeFjJ
         PfvUiOnWnpzUy3hHHooO6TXmx0FI6BVB+sbLyoHmJt6vLKCc4PDo/X9WJ3snIulyh0dt
         eSNw==
X-Gm-Message-State: AOAM530Sx8S+DSmCMMlYItHR6FSxNXFMyDxq9wW0EnlTZaysuAgsk7bg
        ziCSlxYEZd0JTo/JrLS1Is0547NGmD/16g==
X-Google-Smtp-Source: ABdhPJySp+80lDZmwbEFotv1yKIUgxGEX78uRQFi0id2R4KbrSXrnu7/orZ1E1EvZATmsJfBgR7p3A==
X-Received: by 2002:a1c:2246:: with SMTP id i67mr1142364wmi.157.1632478103500;
        Fri, 24 Sep 2021 03:08:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j19sm7649642wra.92.2021.09.24.03.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 03:08:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] http: check CURLE_SSL_PINNEDPUBKEYNOTMATCH when emitting errors
Date:   Fri, 24 Sep 2021 12:08:20 +0200
Message-Id: <patch-1.1-6e65734cbce-20210924T100532Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1231.g24d802460a8
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the error shown when a http.pinnedPubKey doesn't match to point
the http.pinnedPubKey variable added in aeff8a61216 (http: implement
public key pinning, 2016-02-15), e.g.:

    git -c http.pinnedPubKey=sha256/someNonMatchingKey ls-remote https://github.com/git/git.git
    fatal: unable to access 'https://github.com/git/git.git/' with http.pinnedPubkey configuration: SSL: public key does not match pinned public key!

Before this we'd emit the exact same thing without the " with
http.pinnedPubkey configuration". The advantage of doing this is that
we're going to get a translated message (everything after the ":" is
hardcoded in English in libcurl), and we've got a reference to the
git-specific configuration variable that's causing the error.

Unfortunately we can't test this easily, as there are no tests that
require https:// in the test suite, and t/lib-httpd.sh doesn't know
how to set up such tests. See [1] for the start of a discussion about
what it would take to have divergent "t/lib-httpd/apache.conf" test
setups. #leftoverbits

1. https://lore.kernel.org/git/YUonS1uoZlZEt+Yd@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I had this waiting on the now-landed ab/http-drop-old-curl-plus due to
adding a new entry to git-curl-compat.h.

 git-curl-compat.h | 3 ++-
 http.c            | 4 ++++
 http.h            | 1 +
 remote-curl.c     | 4 ++++
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index a308bdb3b9b..56a83b6bbd8 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -64,16 +64,17 @@
 #if LIBCURL_VERSION_NUM >= 0x072200
 #define GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_0
 #endif
 
 /**
  * CURLOPT_PINNEDPUBLICKEY was added in 7.39.0, released in November
- * 2014.
+ * 2014. CURLE_SSL_PINNEDPUBKEYNOTMATCH was added in that same version.
  */
 #if LIBCURL_VERSION_NUM >= 0x072c00
 #define GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY 1
+#define GIT_CURL_HAVE_CURLE_SSL_PINNEDPUBKEYNOTMATCH 1
 #endif
 
 /**
  * CURL_HTTP_VERSION_2 was added in 7.43.0, released in June 2015.
  *
  * The CURL_HTTP_VERSION_2 alias (but not CURL_HTTP_VERSION_2_0) has
diff --git a/http.c b/http.c
index d7c20493d7f..b6735b51c31 100644
--- a/http.c
+++ b/http.c
@@ -1486,12 +1486,16 @@ static int handle_curl_result(struct slot_results *results)
 		 * certificate, bad password, or something else wrong
 		 * with the certificate.  So we reject the credential to
 		 * avoid caching or saving a bad password.
 		 */
 		credential_reject(&cert_auth);
 		return HTTP_NOAUTH;
+#ifdef GIT_CURL_HAVE_CURLE_SSL_PINNEDPUBKEYNOTMATCH
+	} else if (results->curl_result == CURLE_SSL_PINNEDPUBKEYNOTMATCH) {
+		return HTTP_NOMATCHPUBLICKEY;
+#endif
 	} else if (missing_target(results))
 		return HTTP_MISSING_TARGET;
 	else if (results->http_code == 401) {
 		if (http_auth.username && http_auth.password) {
 			credential_reject(&http_auth);
 			return HTTP_NOAUTH;
diff --git a/http.h b/http.h
index 3db5a0cf320..df1590e53a4 100644
--- a/http.h
+++ b/http.h
@@ -151,12 +151,13 @@ struct http_get_options {
 #define HTTP_OK			0
 #define HTTP_MISSING_TARGET	1
 #define HTTP_ERROR		2
 #define HTTP_START_FAILED	3
 #define HTTP_REAUTH	4
 #define HTTP_NOAUTH	5
+#define HTTP_NOMATCHPUBLICKEY	6
 
 /*
  * Requests a URL and stores the result in a strbuf.
  *
  * If the result pointer is NULL, a HTTP HEAD request is made instead of GET.
  */
diff --git a/remote-curl.c b/remote-curl.c
index 598cff7cde6..8700dbdc0ac 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -496,12 +496,16 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		die(_("repository '%s' not found"),
 		    transport_anonymize_url(url.buf));
 	case HTTP_NOAUTH:
 		show_http_message(&type, &charset, &buffer);
 		die(_("Authentication failed for '%s'"),
 		    transport_anonymize_url(url.buf));
+	case HTTP_NOMATCHPUBLICKEY:
+		show_http_message(&type, &charset, &buffer);
+		die(_("unable to access '%s' with http.pinnedPubkey configuration: %s"),
+		    transport_anonymize_url(url.buf), curl_errorstr);
 	default:
 		show_http_message(&type, &charset, &buffer);
 		die(_("unable to access '%s': %s"),
 		    transport_anonymize_url(url.buf), curl_errorstr);
 	}
 
-- 
2.33.0.1231.g24d802460a8

