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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC978C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 14:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96EAE6109D
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 14:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbhFPOSo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 10:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbhFPOSl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 10:18:41 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B21AC0617A6
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 07:16:35 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v9so2888137wrx.6
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 07:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o7Izus7FlArctGrdqIJutA2Lh1sN1MAdDpjhgqzvBTA=;
        b=uh2xL+GXCj/22pA8xdcLF7Sjqnt38uDfKuFppY77DPa+EWPdN7tRTDCLM+P2BTi1Zr
         q2Ws2s6bZRu0DmzQmxNEc9k2aHTl0wLTtDNzf7oKAP3sL3uREQunBtnt0AsDhmReebme
         +cnGawqgLM+/N5tslNQfuky7QdNlnijQZIDdCUBgOzV6Og9nvKFdaBxVqHEhoqWJzSPR
         lXBsmFRZ7CWuAL24BNJhKKMP84EsGtuHX9Ty1ksnw/cT91vCW+JUdCf6NDRD3gz1upm1
         N7G++nnBGJeJSB6OH1WTeZ8uobp8lhHh5FrJvxLf2o1L49JsRduqENSjPIOxR5ufIoUV
         VbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o7Izus7FlArctGrdqIJutA2Lh1sN1MAdDpjhgqzvBTA=;
        b=b4qN2STiuEiiIwqgTdPaiUE0BkI9zAbYcj0Tj3aneaqtYYjIC6xE/S+bv1OKiYdivw
         m3zWTmORmxnUUUJjaps8nSaU6pMQPEMKsCSGBJAQHtHND8XVR5zQfIh/pxqgz4R1o5ZO
         bvx0d15M4FBJXGVdMoBnCRfFKljWaiE/85ig8SFL3EOQoCG/w2i8554OPJsSaRhqOsb7
         /EtLxKRs0h4I2ljnfqIHx3P+xSutyY3Jy1ydTuB5CuiRCZaLrF9S1PA6ttTHJtMq670r
         7Gxt6n9wCiWRRgfxwgu8a+99mLxIzAnR6qzyzV5j/LCV3CyWHB+91V3TCkPV/9SZ8Qtf
         MDEA==
X-Gm-Message-State: AOAM532jMbq+6lylvMVswiGr1Q9ESrTpfpklNy8YVFODSsOdVwrqMMKB
        n0+LOsqEHdkFtfFbJMUyP6xlnPklFyfdeQ==
X-Google-Smtp-Source: ABdhPJw9qovyIMTGPoU4XrYmDs9vQ4cxSoD0iUH27HiZi7HSlAtZEJTI2c6uZWvrTitGIQygoGqnbg==
X-Received: by 2002:a5d:6a0d:: with SMTP id m13mr5612308wru.318.1623852993756;
        Wed, 16 Jun 2021 07:16:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a9sm2258555wrv.37.2021.06.16.07.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 07:16:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] serve: add support for a git_config() callback
Date:   Wed, 16 Jun 2021 16:16:21 +0200
Message-Id: <patch-5.5-c8625025125-20210616T141332Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the introduction of serve.c we've added git_config() callbacks
and other config reading for capabilities in the following commits:

- e20b4192a37 (upload-pack: support hidden refs with protocol v2, 2018-12-18)
- 59e1205d167 (ls-refs: report unborn targets of symrefs, 2021-02-05)
- 6b5b6e422ee (serve: advertise session ID in v2 capabilities, 2020-11-11)

This code can be simplified by simply adding support to serve.c itself
for reading config at the right time before the capability is
called. In particular the ensure_config_read() function being gone
makes this whole thing much simpler.

A behavior change here is that we're eagerly doing the configuration
for all our capabilities regardless of which one we end up serving,
whereas before we'd defer it until the point where we were processing
the specific command.

We could try to be more lazy here and only read the config if we find
out that we're serving "ls-refs" or "session-id", but it's just a fast
git_config() callback, I think in this case simplicity trumps a
premature optimization.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ls-refs.c | 55 ++++++++++++++++++-------------------------------------
 ls-refs.h |  1 +
 serve.c   | 34 +++++++++++++++++++++++++++++++++-
 3 files changed, 52 insertions(+), 38 deletions(-)

diff --git a/ls-refs.c b/ls-refs.c
index 88f6c3f60d8..a8a3e90bd71 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -7,38 +7,9 @@
 #include "pkt-line.h"
 #include "config.h"
 
-static int config_read;
-static int advertise_unborn;
-static int allow_unborn;
-
-static void ensure_config_read(void)
-{
-	const char *str = NULL;
-
-	if (config_read)
-		return;
-
-	if (repo_config_get_string_tmp(the_repository, "lsrefs.unborn", &str)) {
-		/*
-		 * If there is no such config, advertise and allow it by
-		 * default.
-		 */
-		advertise_unborn = 1;
-		allow_unborn = 1;
-	} else {
-		if (!strcmp(str, "advertise")) {
-			advertise_unborn = 1;
-			allow_unborn = 1;
-		} else if (!strcmp(str, "allow")) {
-			allow_unborn = 1;
-		} else if (!strcmp(str, "ignore")) {
-			/* do nothing */
-		} else {
-			die(_("invalid value '%s' for lsrefs.unborn"), str);
-		}
-	}
-	config_read = 1;
-}
+/* "unborn" is on by default if there's no lsrefs.unborn config */
+static int advertise_unborn = 1;
+static int allow_unborn = 1;
 
 /*
  * Check if one of the prefixes is a prefix of the ref.
@@ -128,8 +99,22 @@ static void send_possibly_unborn_head(struct ls_refs_data *data)
 	strbuf_release(&namespaced);
 }
 
-static int ls_refs_config(const char *var, const char *value, void *data)
+int ls_refs_configure(const char *var, const char *value, void *data)
 {
+	if (!strcmp(var, "lsrefs.unborn")) {
+		if (!strcmp(value, "advertise")) {
+			/* Allowed and advertised by default */
+		} else if (!strcmp(value, "allow")) {
+			advertise_unborn = 0;
+			allow_unborn = 1;
+		} else if (!strcmp(value, "ignore")) {
+			advertise_unborn = 0;
+			allow_unborn = 0;
+		} else {
+			die(_("invalid value '%s' for lsrefs.unborn"), value);
+		}
+	}
+
 	/*
 	 * We only serve fetches over v2 for now, so respect only "uploadpack"
 	 * config. This may need to eventually be expanded to "receive", but we
@@ -146,9 +131,6 @@ int ls_refs(struct repository *r, struct strvec *keys,
 	memset(&data, 0, sizeof(data));
 	strvec_init(&data.prefixes);
 
-	ensure_config_read();
-	git_config(ls_refs_config, NULL);
-
 	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
 		const char *arg = request->line;
 		const char *out;
@@ -179,7 +161,6 @@ int ls_refs(struct repository *r, struct strvec *keys,
 int ls_refs_advertise(struct repository *r, struct strbuf *value)
 {
 	if (value) {
-		ensure_config_read();
 		if (advertise_unborn)
 			strbuf_addstr(value, "unborn");
 	}
diff --git a/ls-refs.h b/ls-refs.h
index a99e4be0bdd..afa6dfeb259 100644
--- a/ls-refs.h
+++ b/ls-refs.h
@@ -6,6 +6,7 @@ struct strvec;
 struct packet_reader;
 int ls_refs(struct repository *r, struct strvec *keys,
 	    struct packet_reader *request);
+int ls_refs_configure(const char *var, const char *value, void *data);
 int ls_refs_advertise(struct repository *r, struct strbuf *value);
 
 #endif /* LS_REFS_H */
diff --git a/serve.c b/serve.c
index 49ea9fc8fd5..62cb8aeacdb 100644
--- a/serve.c
+++ b/serve.c
@@ -33,6 +33,13 @@ static int object_format_advertise(struct repository *r,
 	return 1;
 }
 
+static int session_id_configure(const char *var, const char *value, void *data)
+{
+	if (!strcmp(var, "transfer.advertisesid"))
+		advertise_sid = git_config_bool(var, value);
+	return 0;
+}
+
 static int session_id_advertise(struct repository *r, struct strbuf *value)
 {
 	if (!advertise_sid)
@@ -50,6 +57,13 @@ struct protocol_capability {
 	 */
 	const char *name;
 
+	/*
+	 * A git_config() callback. If defined it'll be dispatched too
+	 * sometime before the other functions are called, giving the
+	 * capability a chance to configure itself.
+	 */
+	int (*configure)(const char *var, const char *value, void *data);
+
 	/*
 	 * Function queried to see if a capability should be advertised.
 	 * Optionally a value can be specified by adding it to 'value'.
@@ -79,6 +93,7 @@ static struct protocol_capability capabilities[] = {
 	},
 	{
 		.name = "ls-refs",
+		.configure = ls_refs_configure,
 		.advertise = ls_refs_advertise,
 		.command = ls_refs,
 	},
@@ -97,6 +112,7 @@ static struct protocol_capability capabilities[] = {
 	},
 	{
 		.name = "session-id",
+		.configure = session_id_configure,
 		.advertise = session_id_advertise,
 	},
 	{
@@ -106,6 +122,22 @@ static struct protocol_capability capabilities[] = {
 	},
 };
 
+static int git_serve_config(const char *var, const char *value, void *data)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(capabilities); i++) {
+		struct protocol_capability *c = &capabilities[i];
+		config_fn_t fn = c->configure;
+		int ret;
+		if (!fn)
+			continue;
+		ret = fn(var, value, data);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 static void advertise_capabilities(void)
 {
 	struct strbuf capability = STRBUF_INIT;
@@ -303,7 +335,7 @@ static int process_request(void)
 /* Main serve loop for protocol version 2 */
 void serve(struct serve_options *options)
 {
-	git_config_get_bool("transfer.advertisesid", &advertise_sid);
+	git_config(git_serve_config, NULL);
 
 	if (options->advertise_capabilities || !options->stateless_rpc) {
 		/* serve by default supports v2 */
-- 
2.32.0.576.g59759b6ca7d

