Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBDFC433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A4560D42
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhI0AzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 20:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbhI0AzD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 20:55:03 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC47AC061575
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:53:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i23so47329538wrb.2
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6fcd36RsG2KA+FbhLjrBdVrQFExZV/4afFZDstOHA0k=;
        b=UVv70ljnT8fxnvvlV34zfeB7i+wRIbxrDVmkfRgSHwo0Uxus47F58+5S2XeYSKwgvF
         iijtHP8z57OD51Epz3CN1DnsSLwYXmYgMa5mNCS8UBvOP+NOIE5pwaC2/VzXJIjG9Gn1
         yGlRp3mvROHnJ0+lS6z2UZ+cCkYiE5pJSiW48edwGkn+p/4gHucEZRuTPUj7Aw1cY37L
         M4QL0ugmeuwdTe7WX7ezdOnsw2u2QSAMjAB0xRnA2/HKytmctG0Hc+oRDZ93l6Ewu+TB
         X+++uHnP9BfC9BNibB4w3G8B5G26l+qEvL19AlFJQlaTKbjJmDTlf4nDcNxw3N3gaJJv
         R0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6fcd36RsG2KA+FbhLjrBdVrQFExZV/4afFZDstOHA0k=;
        b=U/heIcorTw0kXxGV8DCPrmw9jLBq7US4oTNI2HlrifjkWEflaeZY9CklNSLzbMgRjd
         BDF8bIOAZcoBwPd9zmJuAO+UGBi68erHPgQuPAX6GCyHlowXyUTKk1uKxcwbjMUlxNTR
         TwWrUNbhyNTHRdSoeWSEtJSSkWPwEavyFnyvZ6EleKLy+mvSw/bQirE0uXvWteeQPs2p
         vusKGFDyW4FFIqWzG1iJWLD+kJDH8AnJALAhgv69T++N2i3WgdChbdwvAVtvPJneXlNU
         lqurWrxel01hv8EniVX/DHyh+QQZgYRKAh0SlyBWhTC+yrAQLeYKno3qbW9LNmDpvojb
         obNg==
X-Gm-Message-State: AOAM531JAZuxDHIMjnxSlUs23wZbtHNTKZBKktsn+0qh07DaytZnNANs
        gR7Ge1KpfSpCKwPHPjT9xts+wmImkWP4jg==
X-Google-Smtp-Source: ABdhPJwbaLoiDH+qpHmT+XhhACy3cQ5Cux2w6vLFaYhWv/FTOgLxa1PrE1sPznKjUujQrCI4CoJQvQ==
X-Received: by 2002:a05:6000:160c:: with SMTP id u12mr24862245wrb.128.1632704005204;
        Sun, 26 Sep 2021 17:53:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i2sm14749745wrq.78.2021.09.26.17.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 17:53:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/6] urlmatch.[ch]: add and use URLMATCH_CONFIG_INIT
Date:   Mon, 27 Sep 2021 02:53:18 +0200
Message-Id: <patch-4.6-cb4c81dcc83-20210927T004920Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1316.gb2e9b3ba3ae
In-Reply-To: <cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the initialization pattern of "struct urlmatch_config" to use
an *_INIT macro and designated initializers.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/config.c | 3 +--
 credential.c     | 4 +---
 http.c           | 4 +---
 urlmatch.h       | 4 ++++
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 865fddd6ce8..1ea4f68b7de 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -575,11 +575,10 @@ static int get_urlmatch(const char *var, const char *url)
 	int ret;
 	char *section_tail;
 	struct string_list_item *item;
-	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
+	struct urlmatch_config config = URLMATCH_CONFIG_INIT;
 	struct string_list values = STRING_LIST_INIT_DUP;
 
 	config.collect_fn = urlmatch_collect_fn;
-	config.cascade_fn = NULL;
 	config.cb = &values;
 
 	if (!url_normalize(url, &config.url))
diff --git a/credential.c b/credential.c
index 000ac7a8d43..c85db8a75cd 100644
--- a/credential.c
+++ b/credential.c
@@ -105,7 +105,7 @@ static int match_partial_url(const char *url, void *cb)
 static void credential_apply_config(struct credential *c)
 {
 	char *normalized_url;
-	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
+	struct urlmatch_config config = URLMATCH_CONFIG_INIT;
 	struct strbuf url = STRBUF_INIT;
 
 	if (!c->host)
@@ -117,9 +117,7 @@ static void credential_apply_config(struct credential *c)
 		return;
 
 	config.section = "credential";
-	config.key = NULL;
 	config.collect_fn = credential_config_callback;
-	config.cascade_fn = NULL;
 	config.select_fn = select_all;
 	config.fallback_match_fn = match_partial_url;
 	config.cb = c;
diff --git a/http.c b/http.c
index d7c20493d7f..3d6ad5c7be8 100644
--- a/http.c
+++ b/http.c
@@ -990,13 +990,11 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	char *low_speed_limit;
 	char *low_speed_time;
 	char *normalized_url;
-	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
+	struct urlmatch_config config = URLMATCH_CONFIG_INIT;
 
 	config.section = "http";
-	config.key = NULL;
 	config.collect_fn = http_options;
 	config.cascade_fn = git_default_config;
-	config.cb = NULL;
 
 	http_is_verbose = 0;
 	normalized_url = url_normalize(url, &config.url);
diff --git a/urlmatch.h b/urlmatch.h
index 6ff42f81b0c..34a3ba6d197 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -66,6 +66,10 @@ struct urlmatch_config {
 	int (*fallback_match_fn)(const char *url, void *cb);
 };
 
+#define URLMATCH_CONFIG_INIT { \
+	.vars = STRING_LIST_INIT_DUP, \
+}
+
 int urlmatch_config_entry(const char *var, const char *value, void *cb);
 
 #endif /* URL_MATCH_H */
-- 
2.33.0.1316.gb2e9b3ba3ae

