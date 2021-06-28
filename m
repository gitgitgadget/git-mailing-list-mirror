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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5422C11F67
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89F5B61992
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbhF1TWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 15:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbhF1TWF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 15:22:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA72C061767
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:19:39 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u8so9310900wrq.8
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UY4h8s3G2YOHwkAT4tEY5NOgJh8Kv382VgqvFyK7y2c=;
        b=oMKpVBAVgdHu3dumhKRmfI5KXgE1r9nLMci3Ox4Nj2Z+lY/0eGOI1Yq6IDBO1ZE0mb
         zMS/+Fut5VHpCWEm+ClGgIJOQU8AMq8WKQREzjy3jtM4KP80d0LyCzjtGxITa0c8ZoZ+
         4xsak+vgNuBSIVSEi6bEMCV3Hreg7Ykn1RYpHz2R9O32ACss+efcfRIlHoQ9V46mVHJ9
         /Lc66y7FpGWl8oHJZG86UTQKx25fXv25qYjnV+lE0UGej7WJSrNGXJcGn7kEZG2ddbM+
         2K88/dgVzSwz/ayj7QOEdfYjQKnqxqtTRBM86SIoRdorQFECvUij2kST/0kaER1ha2BO
         KQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UY4h8s3G2YOHwkAT4tEY5NOgJh8Kv382VgqvFyK7y2c=;
        b=QO2AoBReMUWxUDOfuo3CVNSEjpsIyzhkEgqRl1vbzQzR9DGRlgkKUpPuLN6kRJp/Eb
         X8xlTpeNm5RF2/kX5aycZFbCYl2kbHX2FjrsuqB/8fqEewb50v+2XUbb2mQtUb16Ms2c
         BGfXqNTSXZKFBUE+O+buv00sbxi6UE8z20mXZFbzm6JZUrsJyy0Z6zgN6Vv1lNGdMJIu
         nfn/hHX00FM2vu15tNbbGpoRsgrUle+UbiYK59IR7eEIqG8tGgAo+AjzjjQIrsC+59QM
         issW2r8X8MNOjH1yEuSPZP3KEU7Bs7w/hjlkNlOakTyJFHOEg8B8++az6AeLHja8Wh2z
         Mmdg==
X-Gm-Message-State: AOAM5319juYocE7Os243GVmxArmIcbub3mIRBL1BhxjeYiG8qxvV9XGd
        oQP6yRJjah59Y2Qd7X03eSfjQWep6H6PJQ==
X-Google-Smtp-Source: ABdhPJyNvJar1xG8eMMMD9Kq02Mb0vs5QKY72c+FOaJtX5m0G6xOeKRf2kc1Ct+Bl0XZzJIBn95m2A==
X-Received: by 2002:a5d:6cce:: with SMTP id c14mr8050588wrc.183.1624907977933;
        Mon, 28 Jun 2021 12:19:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s5sm350531wmh.46.2021.06.28.12.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 12:19:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/8] serve: add support for a "startup" git_config() callback
Date:   Mon, 28 Jun 2021 21:19:24 +0200
Message-Id: <patch-7.8-0a4fb01ae38-20210628T191634Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.611.gd4a17395dfa
In-Reply-To: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com> <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ls-refs.c | 42 ++++++++++++++----------------------------
 ls-refs.h |  1 +
 serve.c   | 42 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 55 insertions(+), 30 deletions(-)

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
index 6dbd05248b9..cce96dd5a81 100644
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
@@ -108,6 +135,15 @@ static struct protocol_capability capabilities[] = {
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
@@ -115,6 +151,8 @@ static int call_advertise(struct protocol_capability *command,
 	struct strbuf sb = STRBUF_INIT;
 	const char *msg;
 
+	read_startup_config(command);
+
 	strbuf_addf(&sb, "advertise/%s", command->name);
 	trace2_region_enter("serve", sb.buf, r);
 	ret = command->advertise(r, value);
@@ -132,6 +170,8 @@ static int call_command(struct protocol_capability *command,
 	int ret;
 	struct strbuf sb = STRBUF_INIT;
 
+	read_startup_config(command);
+
 	strbuf_addf(&sb, "command/%s", command->name);
 	trace2_region_enter("serve", sb.buf, r);
 	ret = command->command(r, keys, request);
@@ -338,8 +378,6 @@ static int process_request(void)
 /* Main serve loop for protocol version 2 */
 void serve(struct serve_options *options)
 {
-	git_config_get_bool("transfer.advertisesid", &advertise_sid);
-
 	if (options->advertise_capabilities || !options->stateless_rpc) {
 		/* serve by default supports v2 */
 		packet_write_fmt(1, "version 2\n");
-- 
2.32.0.611.gd4a17395dfa

