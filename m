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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494FEC11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DDEC6198E
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbhF1TWV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 15:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbhF1TWI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 15:22:08 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4254C061768
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:19:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j1so22553691wrn.9
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mGO+xKI1Y5vAzZOie0bbcmq/muUo8iIvBabQgr8m8kA=;
        b=u9L3taX0e1V7+XIb7DJmLqEl13KFwThACHMY3EwJo2nrrnkTmJHwVBkGxVmnM6L64V
         jgvEzhH9O24RcDhdBZ7tPXAvsB6MqTXgKrEASVjwGkyBue2fVlc0ZSI0gI9BUm9MXp0F
         tCVWp/uGYVQSIGZV6G4pORTztv5HUCsRr+ejocXheIIxD7GKaa9AHfHIuxBxczoDWqdi
         97EJ680OkAwMTzsCvDntX5yWJhFPmbSnKqPZd094FGoVu4cHEtt/O1I+Z0y9mC2tRkcO
         85LtvwVtcVmFmSEErV2zis9biqpKVUU9Kobd5yJhAicVlGPe9Bti4bK6/NXsOPXUwYo6
         x+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mGO+xKI1Y5vAzZOie0bbcmq/muUo8iIvBabQgr8m8kA=;
        b=VjHP2cAXeErZ4Fi5JxnVUFM7wBYTv0QKup+Qt7rCNxOVgXcaCHeRFC+XNHC05W9vU2
         kVefiTD2f6AXjKk+xpVA/K9ySX6QQtwTbArtDx6bw4fu9WNMI9SrJXAhol4MeMj/pSVf
         9tET/hYjDtTDxD8BkHaxhlRUBhpD9Omllx+qNTIQN4uEMOb/hf2pgpGO2Cr/JmJpK9qD
         lRZzq0Mz69CpnNP3b/5XrICpfqRTcTBLfopwxgY+dQmoanmXgnHV7D4GOKO/oI2mAqc1
         zqheJ/W0bxhpZ/BBqUaQtBaUhlrYcAACSj3nYPXc64L1N8TniApiul+nX5jsPvReLgnl
         za1A==
X-Gm-Message-State: AOAM530HXTnvXAs/e45RsX32sgYuklWRHlD2Nm8sE4tMnYhCCuXuyNo0
        sdaA8SRK7jrW0ThOcSNgHn7lUJY9wba6FA==
X-Google-Smtp-Source: ABdhPJy+JrDA8/+g3LeVm95yL2fCa6Z1TQJh7I4Ds/6VMaw0uXPv8VO5dKo1pK0CtaKb39UMYCpobw==
X-Received: by 2002:a05:6000:1242:: with SMTP id j2mr28503681wrx.362.1624907979045;
        Mon, 28 Jun 2021 12:19:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s5sm350531wmh.46.2021.06.28.12.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 12:19:38 -0700 (PDT)
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
Subject: [PATCH v2 8/8] upload-pack.c: convert to new serve.c "startup" config cb
Date:   Mon, 28 Jun 2021 21:19:25 +0200
Message-Id: <patch-8.8-9fd6138aa62-20210628T191634Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.611.gd4a17395dfa
In-Reply-To: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com> <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the config reading code in upload-pack.c to use the new
"startup_config" callback when we're using the v2 protocol, and
lightly fake up the same when we're using v0 and v1.

Before the series that fixed 08450ef7918 (upload-pack: clear
filter_options for each v2 fetch command, 2020-05-08) landed, most of
what's now "struct upload_pack_data" used to be static variables at
the top of this file.

This moves some of them back. See f203a88cf14 (upload-pack: move
keepalive to upload_pack_data, 2020-06-04), f1514c6aad0 (upload-pack:
move allow_unadvertised_object_request to upload_pack_data,
2020-06-11) etc.

I think this makes it easier to understand the this code, as we're now
clearly separating data and config that changes on a
request-to-request basis (see 08450ef7918), and the sort of config
that serve.c's "startup_config" is aimed at.

Thus it's clear that the "allow_uor" passed to functions like
"is_our_ref()" is constant after startup (usually it'll never change
for a given server's configuration, or change once).

This requires a very light compatibly layer with the serve.c callback
mechanism in the form of "upload_pack" for the v0 and v1 protocols.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 serve.c       |   1 +
 upload-pack.c | 139 ++++++++++++++++++++++++++++++--------------------
 upload-pack.h |   2 +
 3 files changed, 86 insertions(+), 56 deletions(-)

diff --git a/serve.c b/serve.c
index cce96dd5a81..1054d1459c9 100644
--- a/serve.c
+++ b/serve.c
@@ -112,6 +112,7 @@ static struct protocol_capability capabilities[] = {
 	},
 	{
 		.name = "fetch",
+		.startup_config = serve_upload_pack_startup_config,
 		.advertise = upload_pack_advertise,
 		.command = upload_pack_v2,
 	},
diff --git a/upload-pack.c b/upload-pack.c
index 297b76fcb43..6c0d566e9e0 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -52,6 +52,19 @@ enum allow_uor {
 	ALLOW_ANY_SHA1 = 0x07
 };
 
+/*
+ * "Global" configuration that won't be affected by the type of
+ * request we're doing, or by other request data in "struct
+ * upload_pack_data" below.
+ */
+static int v1_have_startup_config;
+static int config_keepalive = 5;
+static enum allow_uor config_allow_uor;
+static unsigned config_advertise_sid;
+static const char *config_pack_objects_hook;
+static unsigned config_v2_allow_ref_in_want;
+static unsigned config_v2_allow_sideband_all;
+
 /*
  * Please annotate, and if possible group together, fields used only
  * for protocol v0 or only for protocol v2.
@@ -70,7 +83,6 @@ struct upload_pack_data {
 	timestamp_t deepen_since;
 	int deepen_rev_list;
 	int deepen_relative;
-	int keepalive;
 	int shallow_nr;
 	timestamp_t oldest_have;
 
@@ -85,15 +97,12 @@ struct upload_pack_data {
 	int use_sideband;
 
 	struct string_list uri_protocols;
-	enum allow_uor allow_uor;
 
 	struct list_objects_filter_options filter_options;
 	struct string_list allowed_filters;
 
 	struct packet_writer writer;
 
-	const char *pack_objects_hook;
-
 	unsigned stateless_rpc : 1;				/* v0 only */
 	unsigned no_done : 1;					/* v0 only */
 	unsigned daemon_mode : 1;				/* v0 only */
@@ -109,9 +118,6 @@ struct upload_pack_data {
 	unsigned long tree_filter_max_depth;
 
 	unsigned done : 1;					/* v2 only */
-	unsigned allow_ref_in_want : 1;				/* v2 only */
-	unsigned allow_sideband_all : 1;			/* v2 only */
-	unsigned advertise_sid : 1;
 };
 
 static void upload_pack_data_init(struct upload_pack_data *data)
@@ -141,9 +147,6 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	data->allow_filter_fallback = 1;
 	data->tree_filter_max_depth = ULONG_MAX;
 	packet_writer_init(&data->writer, 1);
-
-	data->keepalive = 5;
-	data->advertise_sid = 0;
 }
 
 static void upload_pack_data_clear(struct upload_pack_data *data)
@@ -158,8 +161,6 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
 	object_array_clear(&data->extra_edge_obj);
 	list_objects_filter_release(&data->filter_options);
 	string_list_clear(&data->allowed_filters, 0);
-
-	free((char *)data->pack_objects_hook);
 }
 
 static void reset_timeout(unsigned int timeout)
@@ -277,10 +278,10 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 	int i;
 	FILE *pipe_fd;
 
-	if (!pack_data->pack_objects_hook)
+	if (!config_pack_objects_hook)
 		pack_objects.git_cmd = 1;
 	else {
-		strvec_push(&pack_objects.args, pack_data->pack_objects_hook);
+		strvec_push(&pack_objects.args, config_pack_objects_hook);
 		strvec_push(&pack_objects.args, "git");
 		pack_objects.use_shell = 1;
 	}
@@ -371,9 +372,9 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 		if (!pollsize)
 			break;
 
-		polltimeout = pack_data->keepalive < 0
+		polltimeout = config_keepalive < 0
 			? -1
-			: 1000 * pack_data->keepalive;
+			: 1000 * config_keepalive;
 
 		ret = poll(pfd, pollsize, polltimeout);
 
@@ -581,9 +582,9 @@ static int get_common_commits(struct upload_pack_data *data,
 	}
 }
 
-static int is_our_ref(struct object *o, enum allow_uor allow_uor)
+static int is_our_ref(struct object *o)
 {
-	int allow_hidden_ref = (allow_uor &
+	int allow_hidden_ref = (config_allow_uor &
 				(ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));
 	return o->flags & ((allow_hidden_ref ? HIDDEN_REF : 0) | OUR_REF);
 }
@@ -593,8 +594,7 @@ static int is_our_ref(struct object *o, enum allow_uor allow_uor)
  */
 static int do_reachable_revlist(struct child_process *cmd,
 				struct object_array *src,
-				struct object_array *reachable,
-				enum allow_uor allow_uor)
+				struct object_array *reachable)
 {
 	static const char *argv[] = {
 		"rev-list", "--stdin", NULL,
@@ -627,14 +627,14 @@ static int do_reachable_revlist(struct child_process *cmd,
 			continue;
 		if (reachable && o->type == OBJ_COMMIT)
 			o->flags &= ~TMP_MARK;
-		if (!is_our_ref(o, allow_uor))
+		if (!is_our_ref(o))
 			continue;
 		if (fprintf(cmd_in, "^%s\n", oid_to_hex(&o->oid)) < 0)
 			goto error;
 	}
 	for (i = 0; i < src->nr; i++) {
 		o = src->objects[i].item;
-		if (is_our_ref(o, allow_uor)) {
+		if (is_our_ref(o)) {
 			if (reachable)
 				add_object_array(o, NULL, reachable);
 			continue;
@@ -671,8 +671,7 @@ static int get_reachable_list(struct upload_pack_data *data,
 	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + hash + LF */
 	const unsigned hexsz = the_hash_algo->hexsz;
 
-	if (do_reachable_revlist(&cmd, &data->shallows, reachable,
-				 data->allow_uor) < 0)
+	if (do_reachable_revlist(&cmd, &data->shallows, reachable) < 0)
 		return -1;
 
 	while ((i = read_in_full(cmd.out, namebuf, hexsz + 1)) == hexsz + 1) {
@@ -703,13 +702,13 @@ static int get_reachable_list(struct upload_pack_data *data,
 	return 0;
 }
 
-static int has_unreachable(struct object_array *src, enum allow_uor allow_uor)
+static int has_unreachable(struct object_array *src)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	char buf[1];
 	int i;
 
-	if (do_reachable_revlist(&cmd, src, NULL, allow_uor) < 0)
+	if (do_reachable_revlist(&cmd, src, NULL) < 0)
 		return 1;
 
 	/*
@@ -748,9 +747,9 @@ static void check_non_tip(struct upload_pack_data *data)
 	 * uploadpack.allowReachableSHA1InWant,
 	 * non-tip requests can never happen.
 	 */
-	if (!data->stateless_rpc && !(data->allow_uor & ALLOW_REACHABLE_SHA1))
+	if (!data->stateless_rpc && !(config_allow_uor & ALLOW_REACHABLE_SHA1))
 		goto error;
-	if (!has_unreachable(&data->want_obj, data->allow_uor))
+	if (!has_unreachable(&data->want_obj))
 		/* All the non-tip ones are ancestors of what we advertised */
 		return;
 
@@ -758,7 +757,7 @@ static void check_non_tip(struct upload_pack_data *data)
 	/* Pick one of them (we know there at least is one) */
 	for (i = 0; i < data->want_obj.nr; i++) {
 		struct object *o = data->want_obj.objects[i].item;
-		if (!is_our_ref(o, data->allow_uor)) {
+		if (!is_our_ref(o)) {
 			packet_writer_error(&data->writer,
 					    "upload-pack: not our ref %s",
 					    oid_to_hex(&o->oid));
@@ -1123,8 +1122,8 @@ static void receive_needs(struct upload_pack_data *data,
 		}
 		if (!(o->flags & WANTED)) {
 			o->flags |= WANTED;
-			if (!((data->allow_uor & ALLOW_ANY_SHA1) == ALLOW_ANY_SHA1
-			      || is_our_ref(o, data->allow_uor)))
+			if (!((config_allow_uor & ALLOW_ANY_SHA1) == ALLOW_ANY_SHA1
+			      || is_our_ref(o)))
 				has_non_tip = 1;
 			add_object_array(o, NULL, &data->want_obj);
 		}
@@ -1184,7 +1183,7 @@ static void format_symref_info(struct strbuf *buf, struct string_list *symref)
 }
 
 static void format_session_id(struct strbuf *buf, struct upload_pack_data *d) {
-	if (d->advertise_sid)
+	if (config_advertise_sid)
 		strbuf_addf(buf, " session-id=%s", trace2_session_id());
 }
 
@@ -1210,9 +1209,9 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s%s object-format=%s agent=%s\n",
 			     oid_to_hex(oid), refname_nons,
 			     0, capabilities,
-			     (data->allow_uor & ALLOW_TIP_SHA1) ?
+			     (config_allow_uor & ALLOW_TIP_SHA1) ?
 				     " allow-tip-sha1-in-want" : "",
-			     (data->allow_uor & ALLOW_REACHABLE_SHA1) ?
+			     (config_allow_uor & ALLOW_REACHABLE_SHA1) ?
 				     " allow-reachable-sha1-in-want" : "",
 			     data->stateless_rpc ? " no-done" : "",
 			     symref_info.buf,
@@ -1282,45 +1281,71 @@ static int parse_object_filter_config(const char *var, const char *value,
 	return 0;
 }
 
-static int upload_pack_config(const char *var, const char *value, void *cb_data)
+static int upload_pack_startup_config(const char *var, const char *value,
+				      void *cb_data)
 {
-	struct upload_pack_data *data = cb_data;
-
 	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
 		if (git_config_bool(var, value))
-			data->allow_uor |= ALLOW_TIP_SHA1;
+			config_allow_uor |= ALLOW_TIP_SHA1;
 		else
-			data->allow_uor &= ~ALLOW_TIP_SHA1;
+			config_allow_uor &= ~ALLOW_TIP_SHA1;
 	} else if (!strcmp("uploadpack.allowreachablesha1inwant", var)) {
 		if (git_config_bool(var, value))
-			data->allow_uor |= ALLOW_REACHABLE_SHA1;
+			config_allow_uor |= ALLOW_REACHABLE_SHA1;
 		else
-			data->allow_uor &= ~ALLOW_REACHABLE_SHA1;
+			config_allow_uor &= ~ALLOW_REACHABLE_SHA1;
 	} else if (!strcmp("uploadpack.allowanysha1inwant", var)) {
 		if (git_config_bool(var, value))
-			data->allow_uor |= ALLOW_ANY_SHA1;
+			config_allow_uor |= ALLOW_ANY_SHA1;
 		else
-			data->allow_uor &= ~ALLOW_ANY_SHA1;
+			config_allow_uor &= ~ALLOW_ANY_SHA1;
 	} else if (!strcmp("uploadpack.keepalive", var)) {
-		data->keepalive = git_config_int(var, value);
-		if (!data->keepalive)
-			data->keepalive = -1;
-	} else if (!strcmp("uploadpack.allowfilter", var)) {
-		data->allow_filter = git_config_bool(var, value);
-	} else if (!strcmp("uploadpack.allowrefinwant", var)) {
-		data->allow_ref_in_want = git_config_bool(var, value);
-	} else if (!strcmp("uploadpack.allowsidebandall", var)) {
-		data->allow_sideband_all = git_config_bool(var, value);
+		config_keepalive = git_config_int(var, value);
+		if (!config_keepalive)
+			config_keepalive = -1;
 	} else if (!strcmp("core.precomposeunicode", var)) {
 		precomposed_unicode = git_config_bool(var, value);
 	} else if (!strcmp("transfer.advertisesid", var)) {
-		data->advertise_sid = git_config_bool(var, value);
+		config_advertise_sid = git_config_bool(var, value);
 	}
 
 	if (current_config_scope() != CONFIG_SCOPE_LOCAL &&
 	    current_config_scope() != CONFIG_SCOPE_WORKTREE) {
 		if (!strcmp("uploadpack.packobjectshook", var))
-			return git_config_string(&data->pack_objects_hook, var, value);
+			return git_config_string(&config_pack_objects_hook, var, value);
+	}
+	return 0;
+}
+
+static int upload_pack_startup_config_v2_only(const char *var,
+					      const char *value, void *cb_data)
+{
+	if (!strcmp("uploadpack.allowrefinwant", var))
+		config_v2_allow_ref_in_want = git_config_bool(var, value);
+	else if (!strcmp("uploadpack.allowsidebandall", var))
+		config_v2_allow_sideband_all = git_config_bool(var, value);
+	return 0;
+}
+
+int serve_upload_pack_startup_config(const char *var, const char *value, void *data)
+{
+	int ret;
+	ret = upload_pack_startup_config(var, value, data);
+	if (ret)
+		return ret;
+	ret = upload_pack_startup_config_v2_only(var, value, data);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+static int upload_pack_config(const char *var, const char *value,
+			      void *cb_data)
+{
+	struct upload_pack_data *data = cb_data;
+
+	if (!strcmp("uploadpack.allowfilter", var)) {
+		data->allow_filter = git_config_bool(var, value);
 	}
 
 	if (parse_object_filter_config(var, value, data) < 0)
@@ -1336,6 +1361,8 @@ void upload_pack(struct upload_pack_options *options)
 
 	upload_pack_data_init(&data);
 
+	if (!v1_have_startup_config++)
+		git_config(upload_pack_startup_config, NULL);
 	git_config(upload_pack_config, &data);
 
 	data.stateless_rpc = options->stateless_rpc;
@@ -1468,7 +1495,7 @@ static void process_args(struct packet_reader *request,
 		/* process want */
 		if (parse_want(&data->writer, arg, &data->want_obj))
 			continue;
-		if (data->allow_ref_in_want &&
+		if (config_v2_allow_ref_in_want &&
 		    parse_want_ref(&data->writer, arg, &data->wanted_refs,
 				   &data->want_obj))
 			continue;
@@ -1526,7 +1553,7 @@ static void process_args(struct packet_reader *request,
 		}
 
 		if ((git_env_bool("GIT_TEST_SIDEBAND_ALL", 0) ||
-		     data->allow_sideband_all) &&
+		     config_v2_allow_sideband_all) &&
 		    !strcmp(arg, "sideband-all")) {
 			data->writer.use_sideband = 1;
 			continue;
diff --git a/upload-pack.h b/upload-pack.h
index 27ddcdc6cb0..bd8b1ec5b3e 100644
--- a/upload-pack.h
+++ b/upload-pack.h
@@ -19,5 +19,7 @@ int upload_pack_v2(struct repository *r, struct strvec *keys,
 struct strbuf;
 int upload_pack_advertise(struct repository *r,
 			  struct strbuf *value);
+int serve_upload_pack_startup_config(const char *var, const char *value,
+				     void *data);
 
 #endif /* UPLOAD_PACK_H */
-- 
2.32.0.611.gd4a17395dfa

