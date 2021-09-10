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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E90C433FE
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F07611B0
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbhIJLGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 07:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbhIJLFz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 07:05:55 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60A9C061760
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:04:44 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b6so2025315wrh.10
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gdyHaiS7NgAAponwRzaB9fFkyNFfvagqnezXwI73qHs=;
        b=ptcuEQClND5eizv6H46jcpGGe+aJk7amw+8QLmYSoIjSuWZKeywPrPaRtVbji81MLt
         uYDODl1ZarJVIdN0kTLy7wFjgOQhOA78KP7cny2spUzvnfAwLJjpIYr8a6nbrp7SDC+6
         wqHQcorwmv+jnV4+62xBK8LMiYEPK0CCDGMS6Rco0kidLmuklWYF232PONlUCMgczZIb
         I6qlQmPbh4nokSoqz3MTPWj9/R4HBLKrBI3gLFqPaGRUhOiR+0Iox8ggfRRUSwDLWcXb
         gm2U0hj3G5pESfmZvLTT4rx1Wfdptl7sIfxOkJNgWebI7kdyS2SRcDJg4YWjK62WK0fC
         W85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gdyHaiS7NgAAponwRzaB9fFkyNFfvagqnezXwI73qHs=;
        b=lZQbYnA/FVVwp1WNmI9OcfmMVXS8hRqQ9bdEyWalgNYZf8lmg8GVqU1mO1dFtg808r
         q9vUvwKzQ8ZD8OMg1gpFssKG00d+x4rOhiM4OXyKdjwbSOpnjcnGW4ioS7pIRkGOqckr
         gVhZqBd/d1NfPYjt7KLUdVdyTbBJzWkZzOda2h9t72r5vmEG/6kxqp/1OgzJP8p1jUJ0
         OI+RVV15XgC1/CmxDYWKfqPh20WK+gCSWMnYpE8B5Nt4GKzFRE2K+3d7oNKJHk18m4W0
         ZW3wrafsI9fbP07EJJw160+GE+mwknHGT4YmqBTC+1zVtU1kYXSP/mReOcZmOA3pCmRR
         ze/A==
X-Gm-Message-State: AOAM533yA5PUwj2tAa+iZlU895Il1kOWpuHuMUOz1TaEi23o+rTgYTvo
        l+Z9a6QQi7QwohS1cxZV8VbfljszrTZvRQ==
X-Google-Smtp-Source: ABdhPJwshtKq7s/94eEFdE5cU8/KUUFu+FbP5+cATtsA45du7QlvYAA6wTGFhpl8gvG4I8/YWq5heA==
X-Received: by 2002:adf:eb4f:: with SMTP id u15mr6226138wrn.352.1631271883309;
        Fri, 10 Sep 2021 04:04:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q201sm1013631wme.2.2021.09.10.04.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 04:04:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 8/8] http: don't hardcode the value of CURL_SOCKOPT_OK
Date:   Fri, 10 Sep 2021 13:04:33 +0200
Message-Id: <patch-v2-8.8-465ab33ebda-20210910T105523Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.873.g125ff7b9940
In-Reply-To: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the new git-curl-compat.h header to define CURL_SOCKOPT_OK to its
known value if we're on an older curl version that doesn't have it. It
was hardcoded in http.c in a15d069a198 (http: enable keepalive on TCP
sockets, 2013-10-12).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-curl-compat.h | 16 ++++++++++++++++
 http.c            |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index 7ad87e89ed5..3d162730aaf 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -20,10 +20,26 @@
  * GIT_CURL_HAVE_X. If multiple similar symbols with the same prefix
  * were defined in the same version we pick one and check for that name.
  *
+ * We may also define a missing CURL_* symbol to its known value, if
+ * doing so is sufficient to add support for it to older versions that
+ * don't have it.
+ *
  * Keep any symbols in date order of when their support was
  * introduced, oldest first, in the official version of cURL library.
  */
 
+/**
+ * CURL_SOCKOPT_OK was added in 7.21.5, released in April 2011.
+ *
+ * This should be safe as CURL_SOCKOPT_OK has always been a macro, not
+ * an enum field (checked on curl version 7.78.0, released on July 19,
+ * 2021). Even if that were to change the value of "0" for "OK" is
+ * unlikely to change.
+ */
+#ifndef CURL_SOCKOPT_OK
+#define CURL_SOCKOPT_OK 0
+#endif
+
 /**
  * CURLOPT_TCP_KEEPALIVE was added in 7.25.0, released in March 2012.
  */
diff --git a/http.c b/http.c
index 94eefe97089..d7c20493d7f 100644
--- a/http.c
+++ b/http.c
@@ -537,7 +537,7 @@ static int sockopt_callback(void *client, curl_socket_t fd, curlsocktype type)
 	if (rc < 0)
 		warning_errno("unable to set SO_KEEPALIVE on socket");
 
-	return 0; /* CURL_SOCKOPT_OK only exists since curl 7.21.5 */
+	return CURL_SOCKOPT_OK;
 }
 
 static void set_curl_keepalive(CURL *c)
-- 
2.33.0.873.g125ff7b9940

