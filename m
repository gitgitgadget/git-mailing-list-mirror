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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57789C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A5260249
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243324AbhIMPiV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbhIMPiF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:38:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79722C140941
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 07:51:45 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id b21-20020a1c8015000000b003049690d882so4374658wmd.5
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 07:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zDbyh/KRPMSli8eUAsRNRa2uPsoD+buxIZwFMXGvJS4=;
        b=UaltL9JtDe0jnv45ElMRKCbS/L0idiZCawmuXmE/Kj0AN0roU2BmIAqNTAXB6d2KAa
         vtdWqGwV+dWUg53LldZTyYL8bDaU4uxefL1IUI2Ynv5quLpCs8u+tjqnz2ehDV4MPg61
         4VXaFyR4F3JxvzvmENyg5eaUBUMZiIvNoOk7OUazWZ7l+xBOCqLmBntZSn3jq0MHheIK
         BHywclj26S9ukK79Mv8dW2AeFpkMl8kQclTzl7d3GCCm6KslxzY7lPiBy87RZ13mg4Xn
         FuKU4gQfokZ5+LXAHDLMnXlmPyZZcU+MQJBLvDQA7KA4sEHPkql7pksD1H0s4gnFEiWB
         tDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zDbyh/KRPMSli8eUAsRNRa2uPsoD+buxIZwFMXGvJS4=;
        b=NW/1zSh3lBjYBRPGOiLUMis2/rSo2ZW/QAlLmpGXqS1MsH4epnOviTZSuQttaMBs89
         HpzqZQnpMmKlMbMCUHkjMH2anDR7Obyrpozmzkf0pi639bRNH4wFtuUpL1KOhmWuMJAT
         r2q8/AowF4UE0wUWUzCyfTS+mFC0EbqBW+OP7Jy4/rx1VYRUF4+EqR0y+E3mBV2iXsN3
         jipno6vqzcZQVATHJkilx2rIa7GnIk1WdGiqeY5kJlSRKhBFjeQO6pu8VY7o7BW6jITo
         yyCCrk1hq5Odxtt4xN3fGfzHraBIrZPjN65pvr1nPYD2Tfuoo8DnSUdJnDHEH+Fk71SI
         cdLQ==
X-Gm-Message-State: AOAM530ix3xOzBx+M7gIWh4b0WKmpTg93kEcJEnFbrw98Dkan/Jlpk5U
        GHa/0CWLzaqoa7IEmNn1KR76X8+KuvxxUA==
X-Google-Smtp-Source: ABdhPJx9tdl4lRo2swAE3cbyC9kynqZMc2GdjuaF7jeEBNRgD8oqJ7xbXOxWxI1TJRhk/6SQWHonhQ==
X-Received: by 2002:a1c:4d01:: with SMTP id o1mr7091497wmh.61.1631544703781;
        Mon, 13 Sep 2021 07:51:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o24sm3638854wmm.11.2021.09.13.07.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 07:51:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 9/9] http: don't hardcode the value of CURL_SOCKOPT_OK
Date:   Mon, 13 Sep 2021 16:51:29 +0200
Message-Id: <patch-v4-9.9-846b466fdd5-20210913T144846Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1013.ge8323766266
In-Reply-To: <cover-v4-0.9-00000000000-20210913T144846Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20210913T144846Z-avarab@gmail.com>
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
2.33.0.1013.ge8323766266

