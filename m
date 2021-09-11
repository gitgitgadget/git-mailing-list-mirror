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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF688C433FE
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 09:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C592A60F9D
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 09:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbhIKJfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 05:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbhIKJfr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 05:35:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA70CC061760
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 02:34:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i23so6281409wrb.2
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 02:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7FrwRk0mopfY+otwu8qltoY5vDAQwZGcma/GR9MLWjM=;
        b=g0KLCWAgzp6SThgWnr+oEG4lB5lZMfJHVSfaOlytZAn6hPHIRD+KG7FkZbPNRbpBYU
         ozIQUM2mv/0Aj99dinWseuzRylFLrejjQzAwsu3o9jlI7/jXsYwntL+GG3VWZrBl14qV
         N0TFse9rcWREetpZZslNIWy4EfduGId4fU1M83T4j5lt8me2K2R3EhooUCO25Oszwxhw
         2a8dGeTBqRvo7GQXHhiZiS7UHG3mHRPtYIOknAQiiQODJ0V25YhyclQGtlBMONOl/vb3
         XNp/ftQje/HIbnDnxrkUXZxTCZnBZ3ItORMHxXAGR8VKKw2qp0dVdf5tbkzG8MSgZqQT
         aFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7FrwRk0mopfY+otwu8qltoY5vDAQwZGcma/GR9MLWjM=;
        b=5vKAqugDyiBLmyjSaipiCM8PlC458JO0uPPHtMYD/3piqXg4kzfR0R/62yfH5d4625
         iuDyUl1Xj3zUti/Y6LpcrhAVqQf5wHSKrGh+qG9yqwDj5EsTW8sTrNT3Fi9VVlZfYBjR
         kkz86VdYAnO9j+xN6xL4i59RSQPHTm4sQqE5I3qBsY25HRvXS9PF2DjWlbJSJJa4xvxr
         BKa8CObdCj6XZB9v05uoST8pHOMCxdbpiTuKrObM2e0TSmOKXSATRaZdyQ6abDsusvc4
         Mv6h5w9z6B0wo5rfT5SYBCJh6mJHJ+zh1s2mk0cAW0tqDBkXOkNNIUeeMszmo2B8HbKF
         xuxA==
X-Gm-Message-State: AOAM533sbjstdHpxM4bZeM6W6/S6ZlhEUS+K4/f7X1QWptxDL05gLpV+
        DptQoxLT3goN7zhQIcNNmHWJsH+aDU7WBA==
X-Google-Smtp-Source: ABdhPJz+58WDfnf0+Bze32vUtMNCwQsgKcePCZLyau1rtOpFX7BxaZtbV7ESIdEH/a5inwlYT68New==
X-Received: by 2002:a5d:6a49:: with SMTP id t9mr2268396wrw.35.1631352873129;
        Sat, 11 Sep 2021 02:34:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s10sm1161753wrg.42.2021.09.11.02.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 02:34:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 9/9] http: don't hardcode the value of CURL_SOCKOPT_OK
Date:   Sat, 11 Sep 2021 11:34:23 +0200
Message-Id: <patch-v3-9.9-4bdec34a545-20210911T092751Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.984.gea2c3555113
In-Reply-To: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
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
 git-curl-compat.h | 11 +++++++++++
 http.c            |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index 7ad87e89ed5..a308bdb3b9b 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -20,10 +20,21 @@
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
+ */
+#if LIBCURL_VERSION_NUM < 0x071505
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
2.33.0.984.gea2c3555113

