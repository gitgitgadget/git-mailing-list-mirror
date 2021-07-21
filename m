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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97915C6377A
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D41F6121F
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhGUW7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhGUW7t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:59:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4098BC061757
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d12so3860026wre.13
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XqvNMAoT1PFqUy3almKkv1pyszgu/Sr7uLOpqTgjyqY=;
        b=E+1ysuAMgg/7i49DfQu2vMbreoDkVSl76D6s/7PWrysMG8nwZCsmmfE39dDZHuYNXA
         yM4vZjU73qqIw+VR2ouIoOlYwtuUVrnNfPx/9S6yoQxKuWtXT3LilgpPxM5m8Uget1uK
         mcLcxNqwcLTNA0Wpbo8F6MaVscCLusriCpZ6o8vJHUzelpI3s8JIq4tyBfP8I2NpW+ms
         rg+FVtmLjZEATbseBMdnidYoc3vZHNR3KVGHI1D1/0FOit6CdP4fDrPG6AR7sQpmvMPx
         h5fYgp4cdkIIA89j6PZIWqGWcJaLPJa/gbfhbGD3zugOYf4B3aAOOzsF9EtACpHzXmrY
         RH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XqvNMAoT1PFqUy3almKkv1pyszgu/Sr7uLOpqTgjyqY=;
        b=bf8v4CTDrrUKba4ABkUhd2KDxVocXIG0Mi8H5nN2cJiOXSGatu1gjfNnfVhm7m8A26
         A8ugun5LkJCSEHy077dRsh4Tt7W8qSNLqbia57BABWDL/XjA/TdVm6BeVPLGeHY9nm3n
         DmlBAyOUNDCWRtJmgp6XJR2GAPacEwytzHvUox1DTbmfAUFBjU5TNi50i3YKKOPhEom8
         njKJY4/uV/hkB+YHRgQ9eB2D+d5OpYCC83Z+hgW3OgStPJW0LzDkDjwtktMECWzuipqo
         +8JF7IkT+gON1K4hgykOaMAKkOwomRoI9xd5K40rqCylOtbiGgKp5PYYgDkDnfurcz33
         ZRyQ==
X-Gm-Message-State: AOAM531/WE6Hste8y6cidnCOSSMil4bXaezyVKeXY143HPzaOW7Kb1u7
        gjDWnV/VuZz5q0177b4eqXFtQdIXgiDKCw==
X-Google-Smtp-Source: ABdhPJxadY0PGM6ppUnQiEUA7bBA2LW4KV9ZCOes/A39qm0lVbaIoKAPqNOdQqmBzM0bxNqc8RduAg==
X-Received: by 2002:adf:b605:: with SMTP id f5mr45304235wre.419.1626910822545;
        Wed, 21 Jul 2021 16:40:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm1145649wmc.12.2021.07.21.16.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:40:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/12] serve: add support for a "startup" git_config() callback
Date:   Thu, 22 Jul 2021 01:40:07 +0200
Message-Id: <patch-06.12-be719dc3dc1-20210721T233307Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com> <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the introduction of serve.c we've added git_config() callbacks
and other config reading for capabilities in the following commits:

- e20b4192a37 (upload-pack: support hidden refs with protocol v2, 2018-12-18)
- 08450ef7918 (upload-pack: clear filter_options for each v2 fetch command, 2020-05-08)
- 6b5b6e422ee (serve: advertise session ID in v2 capabilities, 2020-11-11)
- 59e1205d167 (ls-refs: report unborn targets of symrefs, 2021-02-05)

Of these 08450ef7918 fixed code that needed to read config on a
per-request basis, whereas most of the config reading just wants to
check if we've enabled one semi-static config variable or other. We'd
like to re-read that value eventually, but from request-to-request
it's OK if we retain the old one, and it isn't impacted by other
request data.

So let's support this common pattern as a "startup_config" callback,
making use of our recently added "call_{advertise,command}()"
functions. This allows us to simplify e.g. the "ensure_config_read()"
function added in 59e1205d167 (ls-refs: report unborn targets of
symrefs, 2021-02-05).

We could read all the config for all the protocol capabilities, but
let's do it one callback at a time in anticipation that some won't be
called at all, and that some might be more expensive than others in
the future.

I'm not migrating over the code in the upload_pack_v2 function in
upload-pack.c yet, that case is more complex since it deals with both
v1 and v2. It will be dealt with in a code a subsequent commit.

As we'll see in subsequent commits, by moving the
transfer.advertisesid config reading out of serve() we can simplify
the codepath around advertising-only requests. See 6b5b6e422ee (serve:
advertise session ID in v2 capabilities, 2020-11-11)) for the commit
that added transfer.advertisesid.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ls-refs.c | 42 ++++++++++++++----------------------------
 ls-refs.h |  1 +
 serve.c   | 43 +++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 56 insertions(+), 30 deletions(-)

diff --git a/ls-refs.c b/ls-refs.c
index 88f6c3f60d8..02fbcfd9bde 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -7,37 +7,26 @@
 #include "pkt-line.h"
 #include "config.h"
 
-static int config_read;
-static int advertise_unborn;
-static int allow_unborn;
+/* "unborn" is on by default if there's no lsrefs.unborn config */
+static int advertise_unborn = 1;
+static int allow_unborn = 1;
 
-static void ensure_config_read(void)
+int ls_refs_startup_config(const char *var, const char *value, void *data)
 {
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
+	if (!strcmp(var, "lsrefs.unborn")) {
+		if (!strcmp(value, "advertise")) {
+			/* Allowed and advertised by default */
+		} else if (!strcmp(value, "allow")) {
+			advertise_unborn = 0;
 			allow_unborn = 1;
-		} else if (!strcmp(str, "allow")) {
-			allow_unborn = 1;
-		} else if (!strcmp(str, "ignore")) {
-			/* do nothing */
+		} else if (!strcmp(value, "ignore")) {
+			advertise_unborn = 0;
+			allow_unborn = 0;
 		} else {
-			die(_("invalid value '%s' for lsrefs.unborn"), str);
+			die(_("invalid value '%s' for lsrefs.unborn"), value);
 		}
 	}
-	config_read = 1;
+	return 0;
 }
 
 /*
@@ -145,8 +134,6 @@ int ls_refs(struct repository *r, struct strvec *keys,
 
 	memset(&data, 0, sizeof(data));
 	strvec_init(&data.prefixes);
-
-	ensure_config_read();
 	git_config(ls_refs_config, NULL);
 
 	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
@@ -179,7 +166,6 @@ int ls_refs(struct repository *r, struct strvec *keys,
 int ls_refs_advertise(struct repository *r, struct strbuf *value)
 {
 	if (value) {
-		ensure_config_read();
 		if (advertise_unborn)
 			strbuf_addstr(value, "unborn");
 	}
diff --git a/ls-refs.h b/ls-refs.h
index a99e4be0bdd..5fcab0d1dca 100644
--- a/ls-refs.h
+++ b/ls-refs.h
@@ -6,6 +6,7 @@ struct strvec;
 struct packet_reader;
 int ls_refs(struct repository *r, struct strvec *keys,
 	    struct packet_reader *request);
+int ls_refs_startup_config(const char *var, const char *value, void *data);
 int ls_refs_advertise(struct repository *r, struct strbuf *value);
 
 #endif /* LS_REFS_H */
diff --git a/serve.c b/serve.c
index 85cd3eab26e..3c7c9329a14 100644
--- a/serve.c
+++ b/serve.c
@@ -33,6 +33,13 @@ static int object_format_advertise(struct repository *r,
 	return 1;
 }
 
+static int session_id_startup_config(const char *var, const char *value, void *data)
+{
+	if (!strcmp(var, "transfer.advertisesid"))
+		advertise_sid = git_config_bool(var, value);
+	return 0;
+}
+
 static int session_id_advertise(struct repository *r, struct strbuf *value)
 {
 	if (!advertise_sid)
@@ -54,6 +61,24 @@ struct protocol_capability {
 	 */
 	const char *name;
 
+	/*
+	 * A git_config() callback that'll be called only once for the
+	 * lifetime of the process, possibly over many different
+	 * requests. Used for reading config that's expected to be
+	 * static.
+	 *
+	 * The "command" or "advertise" callbacks themselves are
+	 * expected to read config that needs to be more current than
+	 * that, or which is dependent on request data.
+	 */
+	int (*startup_config)(const char *var, const char *value, void *data);
+
+	/*
+	 * A boolean to check if we've called our "startup_config"
+	 * callback.
+	 */
+	int have_startup_config;
+
 	/*
 	 * Function queried to see if a capability should be advertised.
 	 * Optionally a value can be specified by adding it to 'value'.
@@ -81,6 +106,7 @@ static struct protocol_capability capabilities[] = {
 	},
 	{
 		.name = "ls-refs",
+		.startup_config = ls_refs_startup_config,
 		.advertise = ls_refs_advertise,
 		.command = ls_refs,
 	},
@@ -99,6 +125,7 @@ static struct protocol_capability capabilities[] = {
 	},
 	{
 		.name = "session-id",
+		.startup_config = session_id_startup_config,
 		.advertise = session_id_advertise,
 	},
 	{
@@ -108,9 +135,20 @@ static struct protocol_capability capabilities[] = {
 	},
 };
 
+static void read_startup_config(struct protocol_capability *command)
+{
+	if (!command->startup_config)
+		return;
+	if (command->have_startup_config++)
+		return;
+	git_config(command->startup_config, NULL);
+}
+
 static int call_advertise(struct protocol_capability *command,
 			  struct repository *r, struct strbuf *value)
 {
+	read_startup_config(command);
+
 	return command->advertise(r, value);
 }
 
@@ -118,6 +156,9 @@ static int call_command(struct protocol_capability *command,
 			struct repository *r, struct strvec *keys,
 			struct packet_reader *request)
 {
+
+	read_startup_config(command);
+
 	return command->command(r, keys, request);
 }
 
@@ -318,8 +359,6 @@ static int process_request(void)
 /* Main serve loop for protocol version 2 */
 void serve(struct serve_options *options)
 {
-	git_config_get_bool("transfer.advertisesid", &advertise_sid);
-
 	if (options->advertise_capabilities || !options->stateless_rpc) {
 		/* serve by default supports v2 */
 		packet_write_fmt(1, "version 2\n");
-- 
2.32.0.955.ge7c5360f7e7

