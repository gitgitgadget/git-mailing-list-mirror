Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A281C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B26A61361
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353575AbhJAK3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353569AbhJAK3c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 06:29:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC75DC06177B
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 03:27:47 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id s21so14672985wra.7
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 03:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g+5I+kI8JYDX1W4Jc6XuHBv/+6HIADIX2NJudsoR2mk=;
        b=DD79R7l4NWVoTbQafU0t8Tnn9OFRibr0/CVKa/rz9cT/ALOs90bFXA9uYdEG/JMMc6
         XU02GumuKgyx3osJImYySL4N3lc9JNILN8dnskTEh6Ea4wY4vmoreqUlJ8rFR9jTVShf
         UhYVOgK/R7sVBXAXgjgdJxAC8Ts3Z1w0LE7VsTPdiUqx/UHRtkgefKeyJxXoextjqHrB
         u2RWBBOplRYfIWL2atN+55R3dhDct7ZXD6YlBKasOojFhDr0bLahBftCkNSLJ1UCgz01
         V9Ga7cKapuw7sXcegcsr7q4bzs/yXupecegKdQ5BrcZDlaRB4D+Odr9pDC6IHMYp/6u6
         6aOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g+5I+kI8JYDX1W4Jc6XuHBv/+6HIADIX2NJudsoR2mk=;
        b=yLcRIePMiuotpzCu9R3YWBlKddK9nG/IL5CfoNZx/eltD+qfPOHTqRCKqLYM3AKscx
         IhEsIQpBvHGtDy5tdGbUef0SeeeTK+n3wEASBns6PMdqeZ479SbY0zEh4wbSsZPpTdpP
         VJIaf7UhPQPoe8U8+jlzlgjtQ9WOHTFQjfHgACE5ASvfkLgkq6oMaKSTTWlJCYpYwayw
         k4KZlVegxQMHHAkHKl9kw7qGQn71uV+Yp5NMUnGhfirZmydWYnz00GxpcuKPpcuXgiiM
         LpstbASV4VK3pgkUv3c1OaQ3bTZDMOhW3jM7BtUThBpgL0xoyiGGgkPA5flah6BmmUlH
         ggcg==
X-Gm-Message-State: AOAM53137Kv+HAEYX5tmLiv0z5NrgooFaadC1aVbY0NInBL9xbhq28qv
        ZRRgx3B/wBBV9CGA1ga6FrI2ePzRpAS1lw==
X-Google-Smtp-Source: ABdhPJzei0Kr8YyQ9+HBv4SP27gPyZqlpYDc8hRQv31hu/t+s40LT/KgfOFVfeNV1EdGwoISguWH3g==
X-Received: by 2002:adf:a4cf:: with SMTP id h15mr11426399wrb.56.1633084066183;
        Fri, 01 Oct 2021 03:27:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h7sm5398952wrx.14.2021.10.01.03.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 03:27:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/6] urlmatch.[ch]: add and use URLMATCH_CONFIG_INIT
Date:   Fri,  1 Oct 2021 12:27:33 +0200
Message-Id: <patch-v3-3.6-266948e604c-20211001T102056Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1375.gbbd823cc90f
In-Reply-To: <cover-v3-0.6-00000000000-20211001T102056Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210927T125715Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20211001T102056Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the initialization pattern of "struct urlmatch_config" to use
an *_INIT macro and designated initializers. Right now there's no
other "struct" member of "struct urlmatch_config" which would require
its own *_INIT, but it's good practice not to assume that. Let's also
change this to a designated initializer while we're at it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/config.c | 2 +-
 credential.c     | 2 +-
 http.c           | 2 +-
 urlmatch.h       | 4 ++++
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 865fddd6ce8..542d8d02b2b 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -575,7 +575,7 @@ static int get_urlmatch(const char *var, const char *url)
 	int ret;
 	char *section_tail;
 	struct string_list_item *item;
-	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
+	struct urlmatch_config config = URLMATCH_CONFIG_INIT;
 	struct string_list values = STRING_LIST_INIT_DUP;
 
 	config.collect_fn = urlmatch_collect_fn;
diff --git a/credential.c b/credential.c
index 000ac7a8d43..e7240f3f636 100644
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
diff --git a/http.c b/http.c
index d7c20493d7f..da12471c242 100644
--- a/http.c
+++ b/http.c
@@ -990,7 +990,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	char *low_speed_limit;
 	char *low_speed_time;
 	char *normalized_url;
-	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
+	struct urlmatch_config config = URLMATCH_CONFIG_INIT;
 
 	config.section = "http";
 	config.key = NULL;
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
2.33.0.1375.gbbd823cc90f

