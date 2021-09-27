Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DE7C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 12:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B98661058
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 12:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhI0NAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 09:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbhI0NAa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 09:00:30 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED0AC061604
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 05:58:51 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id s24so424834wmh.4
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 05:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6fcd36RsG2KA+FbhLjrBdVrQFExZV/4afFZDstOHA0k=;
        b=ElTUdPfDvWaPmIS75ThpzQkke/a3ibDwBQvW7cfNAFiouiQCUavVeeNJ0hKW4o9YE5
         dynT/SWQMfNdaIws/qp/W5reUP5KJkCXOUtUgdRr356IXjCMMRWrJ3ka2l7IRh7hsotz
         swHLHAemm+NINbrm1DYvsx1auffkOf55oGyrLLS3xczUFcY/iDmHdDw2jkGf/7yC9RE7
         3GhChWNL4Yk8fTkZTkSV7uWWa5HVUb9aEr66z+r9jbdkGiRUQtUbyc1cq3C6G0Vx4Ukq
         iLWhAhebyvZ2TNWLN6BtWO7WHEkWCzTC7okGzfC+TA6eL2FI0f9Pbwv8z3fMdQW+LRuA
         khjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6fcd36RsG2KA+FbhLjrBdVrQFExZV/4afFZDstOHA0k=;
        b=j/nRwnm9RNY8bX9hh39IqmxfWEtcQjRUDXkNst4lA0VIYsrJNB3xrMIwdqkKGH9OMU
         Iv7XIJVHTUjKIqPzQd1IqQVjmKv15f9WZMBnBHQHErWJeX9dzgHlsMZ4zZYs92G9VAX+
         e3JTUvTHbW1qL3aV26txcH9/11tgz91KYx/SsIfKSMD2FG/tygAM+wBGOo3XhSEt0zAQ
         jUDYuHMmSKm+mxSPRd9+Xjv9i4Nw5GZwABLPrgREbLfMnTK+Kg9xyNfMy3RdcxovQxAF
         CoN5/Y5/G7eknMx+jNOW4qO7oJ5FWDZuf2it8RvWEdtwc1CFVWNfhb3xRrVJx9NoNnM2
         4lTw==
X-Gm-Message-State: AOAM530C4+BAlZa8YiAV3DGhH0L1s8jn7LUFxHJZZF/hyVNmxarGBYHv
        TvxGbNTvQpsWy0AXxCAUno4vOnB4rR1FPQ==
X-Google-Smtp-Source: ABdhPJyvLcbzaNulK4litHUfZBPyHGR51nfijxUGVCoGCo2JIal7WY2BHMVConGrt0ZYq0hOvlEZ3g==
X-Received: by 2002:a7b:c947:: with SMTP id i7mr15883612wml.179.1632747530221;
        Mon, 27 Sep 2021 05:58:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j21sm17562179wmj.40.2021.09.27.05.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:58:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/5] urlmatch.[ch]: add and use URLMATCH_CONFIG_INIT
Date:   Mon, 27 Sep 2021 14:58:43 +0200
Message-Id: <patch-v2-3.5-3783788b553-20210927T125715Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1316.gb2e9b3ba3ae
In-Reply-To: <cover-v2-0.5-00000000000-20210927T125715Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20210927T125715Z-avarab@gmail.com>
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

