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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C12BC6377D
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0494D6121F
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhGUW76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhGUW7u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:59:50 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE594C0613D3
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:25 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p15-20020a05600c358fb0290245467f26a4so1902429wmq.0
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GZHsAB+dmh65tEoAdxy0vHNdJHymc+12TBGJQ7MStzM=;
        b=mO8nORC/whGLkprjxN4leh+oJphwLEE0CxK0LoJXv5ByBZF8QGEQC6ZjpEwGMi1l0z
         6Sa7+iz1RAamnGzSxvEEO09XvZwmt5WLvFKSuaR6FzWO8eC+YeJ6xJ+WJzEutj0Bh/4U
         3qb22207ErAoE9JsFeuTi2qTEv00jmagln6M29Y3UKh75OdukbVh26+n0Hd6GuUKRbRk
         D2WNTU8qnejBlLWLrPrTZ4hYgWRUFEii/YcECwYKV4HEVISjvr31JIDDSTiobZpjZCp5
         VjdP7B8YrT9scfXjmZ7cO61BLM7MFe5h1sjLrQ3FNIkW11qPJgUBrsTqXOyZV9VrRE/e
         0pXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GZHsAB+dmh65tEoAdxy0vHNdJHymc+12TBGJQ7MStzM=;
        b=EyagCXgtkU3e5nk+oD+GvjWbkgFvLobZny7Ql7C5SeEttSBOMwJqi2i8cEhDQiMrJD
         SrGYNEYmBoPEEChhn8eHSYUPVjBOyy+dxkTFc9+EBhnRNsJU+q3eZsMX9n8gwzbAfPIe
         FZ5ZKhD7BTwawz7RIBd3ytnZ6AJz+bieYbro7f3n2ezUekI+X3vUHna3QhXfNnxdmKSa
         GruC5wKLi5vH7l7f8UrEOZZpfvz0MdkoaAW324UpmlZ899aQOQLs+ff0Yga62sf1QOu6
         jmvOAqC72mjna1FPOhHGOKsFROEGw6T+zjPqIrEAJIdQ6gVMqRzSsWB3a34zgoB92Sn7
         Wd5w==
X-Gm-Message-State: AOAM533fSBWwf7p4rsIjATyGe+FYkskeOLqaVVzGcJDSvnng2isvAMXM
        QH82jRqGxKqecfwPI08h7FqS7xecEQDZxg==
X-Google-Smtp-Source: ABdhPJxrXpsHHGcwxHwM9cHW0bKK43XSuKFSUfl3enK6KghCIGisNIm8aOEP7IgqhPkJuu79Rt+odQ==
X-Received: by 2002:a05:600c:22d8:: with SMTP id 24mr39183585wmg.157.1626910824088;
        Wed, 21 Jul 2021 16:40:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm1145649wmc.12.2021.07.21.16.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:40:23 -0700 (PDT)
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
Subject: [PATCH v3 08/12] serve.[ch]: remove "serve_options", split up --advertise-refs code
Date:   Thu, 22 Jul 2021 01:40:09 +0200
Message-Id: <patch-08.12-fb80f152713-20210721T233307Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com> <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "advertise capabilities" mode of serve.c added in
ed10cb952d3 (serve: introduce git-serve, 2018-03-15) is only used by
the http-backend.c to call {upload,receive}-pack with the
--advertise-refs parameter. See 42526b478e3 (Add stateless RPC options
to upload-pack, receive-pack, 2009-10-30).

Let's just make cmd_upload_pack() take the two (v2) or three (v2)
parameters the the v2/v1 servicing functions need directly, and pass
those in via the function signature. The logic of whether daemon mode
is implied by the timeout belongs in the v1 function (only used
there).

Once we split up the "advertise v2 refs" from "serve v2 request" it
becomes clear that v2 never cared about those in combination. The only
time it mattered was for v1 to emit its ref advertisement, in that
case we wanted to emit the smart-http-only "no-done" capability.

Since we only do that in the --advertise-refs codepath let's just have
it set "do_done" itself in v1's upload_pack() just before send_ref(),
at that point --advertise-refs and --stateless-rpc in combination are
redundant (the only user is get_info_refs() in http-backend.c), so we
can just pass in --advertise-refs only.

Since we need to touch all the serve() and advertise_capabilities()
codepaths let's rename them to less clever and obvious names, it's
been suggested numerous times, the latest of which is [1]'s suggestion
for protocol_v2_serve_loop(). Let's go with that.

1. https://lore.kernel.org/git/CAFQ2z_NyGb8rju5CKzmo6KhZXD0Dp21u-BbyCb2aNxLEoSPRJw@mail.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/upload-pack.c    | 25 ++++++++++++-------------
 http-backend.c           |  2 +-
 serve.c                  | 18 +++++-------------
 serve.h                  |  8 ++------
 t/helper/test-serve-v2.c | 14 +++++++++-----
 upload-pack.c            | 18 +++++++++++-------
 upload-pack.h            | 10 ++--------
 7 files changed, 42 insertions(+), 53 deletions(-)

diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index 6da8fa2607c..8506030a648 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -16,16 +16,17 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 {
 	const char *dir;
 	int strict = 0;
-	struct upload_pack_options opts = { 0 };
-	struct serve_options serve_opts = SERVE_OPTIONS_INIT;
+	int advertise_refs = 0;
+	int stateless_rpc = 0;
+	int timeout = 0;
 	struct option options[] = {
-		OPT_BOOL(0, "stateless-rpc", &opts.stateless_rpc,
+		OPT_BOOL(0, "stateless-rpc", &stateless_rpc,
 			 N_("quit after a single request/response exchange")),
-		OPT_BOOL(0, "advertise-refs", &opts.advertise_refs,
+		OPT_BOOL(0, "advertise-refs", &advertise_refs,
 			 N_("exit immediately after initial ref advertisement")),
 		OPT_BOOL(0, "strict", &strict,
 			 N_("do not try <directory>/.git/ if <directory> is no Git directory")),
-		OPT_INTEGER(0, "timeout", &opts.timeout,
+		OPT_INTEGER(0, "timeout", &timeout,
 			    N_("interrupt transfer after <n> seconds of inactivity")),
 		OPT_END()
 	};
@@ -38,9 +39,6 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 	if (argc != 1)
 		usage_with_options(upload_pack_usage, options);
 
-	if (opts.timeout)
-		opts.daemon_mode = 1;
-
 	setup_path();
 
 	dir = argv[0];
@@ -50,21 +48,22 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 
 	switch (determine_protocol_version_server()) {
 	case protocol_v2:
-		serve_opts.advertise_capabilities = opts.advertise_refs;
-		serve_opts.stateless_rpc = opts.stateless_rpc;
-		serve(&serve_opts);
+		if (advertise_refs)
+			protocol_v2_advertise_capabilities();
+		else
+			protocol_v2_serve_loop(stateless_rpc);
 		break;
 	case protocol_v1:
 		/*
 		 * v1 is just the original protocol with a version string,
 		 * so just fall through after writing the version string.
 		 */
-		if (opts.advertise_refs || !opts.stateless_rpc)
+		if (advertise_refs || !stateless_rpc)
 			packet_write_fmt(1, "version 1\n");
 
 		/* fallthrough */
 	case protocol_v0:
-		upload_pack(&opts);
+		upload_pack(advertise_refs, stateless_rpc, timeout);
 		break;
 	case protocol_unknown_version:
 		BUG("unknown protocol version");
diff --git a/http-backend.c b/http-backend.c
index b329bf63f09..d37463cec8b 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -534,7 +534,7 @@ static void get_info_refs(struct strbuf *hdr, char *arg)
 
 	if (service_name) {
 		const char *argv[] = {NULL /* service name */,
-			"--stateless-rpc", "--advertise-refs",
+			"--advertise-refs",
 			".", NULL};
 		struct rpc_service *svc = select_service(hdr, service_name);
 
diff --git a/serve.c b/serve.c
index 10209ab237d..cacb0bc4e0e 100644
--- a/serve.c
+++ b/serve.c
@@ -162,7 +162,7 @@ static int call_command(struct protocol_capability *command,
 	return command->command(r, keys, request);
 }
 
-static void advertise_capabilities(void)
+void protocol_v2_advertise_capabilities(void)
 {
 	struct strbuf capability = STRBUF_INIT;
 	struct strbuf value = STRBUF_INIT;
@@ -359,24 +359,16 @@ static int process_request(void)
 	return 0;
 }
 
-/* Main serve loop for protocol version 2 */
-void serve(struct serve_options *options)
+void protocol_v2_serve_loop(int stateless_rpc)
 {
-	if (options->advertise_capabilities || !options->stateless_rpc) {
-		advertise_capabilities();
-		/*
-		 * If only the list of capabilities was requested exit
-		 * immediately after advertising capabilities
-		 */
-		if (options->advertise_capabilities)
-			return;
-	}
+	if (!stateless_rpc)
+		protocol_v2_advertise_capabilities();
 
 	/*
 	 * If stateless-rpc was requested then exit after
 	 * a single request/response exchange
 	 */
-	if (options->stateless_rpc) {
+	if (stateless_rpc) {
 		process_request();
 	} else {
 		for (;;)
diff --git a/serve.h b/serve.h
index 56da77a87af..f946cf904a2 100644
--- a/serve.h
+++ b/serve.h
@@ -1,11 +1,7 @@
 #ifndef SERVE_H
 #define SERVE_H
 
-struct serve_options {
-	unsigned advertise_capabilities;
-	unsigned stateless_rpc;
-};
-#define SERVE_OPTIONS_INIT { 0 }
-void serve(struct serve_options *options);
+void protocol_v2_advertise_capabilities(void);
+void protocol_v2_serve_loop(int stateless_rpc);
 
 #endif /* SERVE_H */
diff --git a/t/helper/test-serve-v2.c b/t/helper/test-serve-v2.c
index aee35e5aef4..28e905afc36 100644
--- a/t/helper/test-serve-v2.c
+++ b/t/helper/test-serve-v2.c
@@ -10,12 +10,12 @@ static char const * const serve_usage[] = {
 
 int cmd__serve_v2(int argc, const char **argv)
 {
-	struct serve_options opts = SERVE_OPTIONS_INIT;
-
+	int stateless_rpc = 0;
+	int advertise_capabilities = 0;
 	struct option options[] = {
-		OPT_BOOL(0, "stateless-rpc", &opts.stateless_rpc,
+		OPT_BOOL(0, "stateless-rpc", &stateless_rpc,
 			 N_("quit after a single request/response exchange")),
-		OPT_BOOL(0, "advertise-capabilities", &opts.advertise_capabilities,
+		OPT_BOOL(0, "advertise-capabilities", &advertise_capabilities,
 			 N_("exit immediately after advertising capabilities")),
 		OPT_END()
 	};
@@ -25,7 +25,11 @@ int cmd__serve_v2(int argc, const char **argv)
 	argc = parse_options(argc, argv, prefix, options, serve_usage,
 			     PARSE_OPT_KEEP_DASHDASH |
 			     PARSE_OPT_KEEP_UNKNOWN);
-	serve(&opts);
+
+	if (advertise_capabilities)
+		protocol_v2_advertise_capabilities();
+	else
+		protocol_v2_serve_loop(stateless_rpc);
 
 	return 0;
 }
diff --git a/upload-pack.c b/upload-pack.c
index 297b76fcb43..48e8bf5694c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1214,7 +1214,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 				     " allow-tip-sha1-in-want" : "",
 			     (data->allow_uor & ALLOW_REACHABLE_SHA1) ?
 				     " allow-reachable-sha1-in-want" : "",
-			     data->stateless_rpc ? " no-done" : "",
+			     data->no_done ? " no-done" : "",
 			     symref_info.buf,
 			     data->allow_filter ? " filter" : "",
 			     session_id.buf,
@@ -1329,7 +1329,8 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
-void upload_pack(struct upload_pack_options *options)
+void upload_pack(const int advertise_refs, const int stateless_rpc,
+		 const int timeout)
 {
 	struct packet_reader reader;
 	struct upload_pack_data data;
@@ -1338,14 +1339,17 @@ void upload_pack(struct upload_pack_options *options)
 
 	git_config(upload_pack_config, &data);
 
-	data.stateless_rpc = options->stateless_rpc;
-	data.daemon_mode = options->daemon_mode;
-	data.timeout = options->timeout;
+	data.stateless_rpc = stateless_rpc;
+	data.timeout = timeout;
+	if (data.timeout)
+		data.daemon_mode = 1;
 
 	head_ref_namespaced(find_symref, &data.symref);
 
-	if (options->advertise_refs || !data.stateless_rpc) {
+	if (advertise_refs || !data.stateless_rpc) {
 		reset_timeout(data.timeout);
+		if (advertise_refs)
+			data.no_done = 1;
 		head_ref_namespaced(send_ref, &data);
 		for_each_namespaced_ref(send_ref, &data);
 		advertise_shallow_grafts(1);
@@ -1355,7 +1359,7 @@ void upload_pack(struct upload_pack_options *options)
 		for_each_namespaced_ref(check_ref, NULL);
 	}
 
-	if (!options->advertise_refs) {
+	if (!advertise_refs) {
 		packet_reader_init(&reader, 0, NULL, 0,
 				   PACKET_READ_CHOMP_NEWLINE |
 				   PACKET_READ_DIE_ON_ERR_PACKET);
diff --git a/upload-pack.h b/upload-pack.h
index 27ddcdc6cb0..a06498bbea7 100644
--- a/upload-pack.h
+++ b/upload-pack.h
@@ -1,14 +1,8 @@
 #ifndef UPLOAD_PACK_H
 #define UPLOAD_PACK_H
 
-struct upload_pack_options {
-	int stateless_rpc;
-	int advertise_refs;
-	unsigned int timeout;
-	int daemon_mode;
-};
-
-void upload_pack(struct upload_pack_options *options);
+void upload_pack(const int advertise_refs, const int stateless_rpc,
+		 const int timeout);
 
 struct repository;
 struct strvec;
-- 
2.32.0.955.ge7c5360f7e7

