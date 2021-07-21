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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25A8C63798
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA77160FDA
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhGUXAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 19:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbhGUW7y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:59:54 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54118C06179A
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n1so3879088wri.10
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fnPVSSmamXFCgSHV5ypFYK1ExGvlZhS63QWQKAgXhkM=;
        b=MkeoTZafOQoND681y5T6HuAJaXhr6jvo+ZLcDxvfE2YDpf45h+NtMCxKhWj6SinHex
         Twbs6gqqgydk85SlCbYaXkT05qdgwORM3rQWjjkToJixMGmuAHJxHzSAWz7mTsxtB8xd
         WIywoyLtksWWtT2WpbFNz78D8hCBgQ0PmZvPBoH6j+0cy3D06Q3+qdT7DiMn/kzUPn+b
         Qc5CbsF8fnYakv5YpFg310QrgiaKh+wKzwy3F+dqaD3YsT1ih40SJd1Y3mDqHNhXZQcn
         pMd2rj2OxBzzDi1cb5f0ghIleWlQvppnM4W+P03RYsIAiVaqXU8dzRxrnChOfy75NbD0
         uggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fnPVSSmamXFCgSHV5ypFYK1ExGvlZhS63QWQKAgXhkM=;
        b=smHRV9sw559BH+I46L3dPzJ9MXRFIupNeDgHu2s+rQGZlk3SeFUXfnwzwNnOqSTSTA
         +ZtzcOqWwjWW5IbiScDoVYHJwsuQWti/eNGFEpk7kPr3G2FrbrFFjLTA/XmmVV8lrFmX
         i78AU0t7nk/y77tkk6dCZrpotmSrQE2sB84uhjw0T0HsNIXCLSNVqQLtIlo+FJ76Tby/
         uktKPUZKEN+kCfdWtImWZIO/qewdVj8GPwfaIodYovC23zcSHpV+LZ8smsmR6ISa3CF1
         Xd2ROkK4Lm3prPKoNanuFT0wxHgBAThH4HGSp5u0ovaiPDN8bCP5hCiVv6EcaEDNswfO
         /QAA==
X-Gm-Message-State: AOAM533TQwqTCmvQ8I23zlTxdeiV9NfqG8rNekXty+HgvzdGxVM/pxE2
        Ib5fQ6tkmgCy1M4YUiihssEUO2sc7XBiAg==
X-Google-Smtp-Source: ABdhPJwXQuYFsh3UPgbzg2O4r1apgDYYOaND/IH5LnzShC+AX07/6DVwaHKzHO64jKo/UU3uL+ErMA==
X-Received: by 2002:adf:f109:: with SMTP id r9mr26851496wro.370.1626910826608;
        Wed, 21 Jul 2021 16:40:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm1145649wmc.12.2021.07.21.16.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:40:26 -0700 (PDT)
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
Subject: [PATCH v3 11/12] upload-pack.c: convert to new serve.c "startup" config cb
Date:   Thu, 22 Jul 2021 01:40:12 +0200
Message-Id: <patch-11.12-2d4c3d0d463-20210721T233307Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com> <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
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

This requires a very light compatibility layer with the serve.c
callback mechanism in the form of "upload_pack" for the v0 and v1
protocols.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 serve.c       |   1 +
 upload-pack.c | 133 +++++++++++++++++++++++++++++---------------------
 upload-pack.h |   2 +
 3 files changed, 80 insertions(+), 56 deletions(-)

diff --git a/serve.c b/serve.c
index cacb0bc4e0e..162e8cea550 100644
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
index 48e8bf5694c..b9cfc09795b 100644
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
+static int config_keepalive_secs = 5;
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
+		polltimeout = config_keepalive_secs < 0
 			? -1
-			: 1000 * pack_data->keepalive;
+			: 1000 * config_keepalive_secs;
 
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
 			     data->no_done ? " no-done" : "",
 			     symref_info.buf,
@@ -1282,46 +1281,66 @@ static int parse_object_filter_config(const char *var, const char *value,
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
+		config_keepalive_secs = git_config_int(var, value);
+		if (!config_keepalive_secs)
+			config_keepalive_secs = -1;
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
 	}
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
+	upload_pack_startup_config(var, value, data);
+	upload_pack_startup_config_v2_only(var, value, data);
+	return 0;
+}
+
+static int upload_pack_config(const char *var, const char *value,
+			      void *cb_data)
+{
+	struct upload_pack_data *data = cb_data;
+
+	if (!strcmp("uploadpack.allowfilter", var))
+		data->allow_filter = git_config_bool(var, value);
 
 	if (parse_object_filter_config(var, value, data) < 0)
 		return -1;
@@ -1337,6 +1356,8 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 
 	upload_pack_data_init(&data);
 
+	if (!v1_have_startup_config++)
+		git_config(upload_pack_startup_config, NULL);
 	git_config(upload_pack_config, &data);
 
 	data.stateless_rpc = stateless_rpc;
@@ -1472,7 +1493,7 @@ static void process_args(struct packet_reader *request,
 		/* process want */
 		if (parse_want(&data->writer, arg, &data->want_obj))
 			continue;
-		if (data->allow_ref_in_want &&
+		if (config_v2_allow_ref_in_want &&
 		    parse_want_ref(&data->writer, arg, &data->wanted_refs,
 				   &data->want_obj))
 			continue;
@@ -1530,7 +1551,7 @@ static void process_args(struct packet_reader *request,
 		}
 
 		if ((git_env_bool("GIT_TEST_SIDEBAND_ALL", 0) ||
-		     data->allow_sideband_all) &&
+		     config_v2_allow_sideband_all) &&
 		    !strcmp(arg, "sideband-all")) {
 			data->writer.use_sideband = 1;
 			continue;
diff --git a/upload-pack.h b/upload-pack.h
index a06498bbea7..52011d9ecff 100644
--- a/upload-pack.h
+++ b/upload-pack.h
@@ -13,5 +13,7 @@ int upload_pack_v2(struct repository *r, struct strvec *keys,
 struct strbuf;
 int upload_pack_advertise(struct repository *r,
 			  struct strbuf *value);
+int serve_upload_pack_startup_config(const char *var, const char *value,
+				     void *data);
 
 #endif /* UPLOAD_PACK_H */
-- 
2.32.0.955.ge7c5360f7e7

