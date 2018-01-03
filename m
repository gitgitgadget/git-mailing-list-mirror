Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 895EE1F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbeACATD (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:19:03 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:43234 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751215AbeACATB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:19:01 -0500
Received: by mail-it0-f65.google.com with SMTP id u62so47786ita.2
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r6HoTt+/IWWQjflJeJOwJ0fT0dwVRYv64REoMqb0/A8=;
        b=L72CjKxwf3uXISSQ0ubJqoc4Mt3G1x2xPy700ptfkYjec7rnO3WS6yWz7wf3HP7XqB
         sitFEeI3dwSYmo2R+T+1MLJoNHZCKun7FOHAtAJ9XNBt/vqa7HzryGsLJdHP/YPxcqyN
         cdAlWxcNelY505mYIPJ00JjOwXUN7tlQaHurdUfPacV5TwQUdHbxvPwLKdVbUs5Clf1V
         BYmnqIwVNVDLq29lGV1uwX3GvKjK0ZkdaS571Ebn6/CuD7Vxq8gxWse+ggvozvDGWd0p
         WtQ8eOz1iLTsk0xsehttHJWF7P/yHSiQWGz9/6gdOIGdsk6qGzPlCzjMQIwxIMhkWtI8
         AdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r6HoTt+/IWWQjflJeJOwJ0fT0dwVRYv64REoMqb0/A8=;
        b=HqSKb12Q1NRFn05tCN78ysCIt85tFCS+qHVf7QB+0lt/Gkj9TdXSXlBYt5Z4j3SxFL
         doCPbPqxy6H32HKYW+Jzqxbjn3n2fRZfVyxdNFXTOnabOtWSmZgZ0Lny48+v8ht9vV1C
         lMVXXYmAP8bBLA3i25tFIGcrlk6+vjALlALA6ZlOJ3ivHnBQG4bio+JsLvvy5IDhQyAs
         ESGugX3bv+2Cb9BUwd+879FHE1N1WThDG9r2lx5uCwTiEUTDAmY/VLHc4TfhMeaMJ/by
         mFf9QbC5T2vpTuF3ur4TspzkQAZSHBCNvKd3ITxKNgGptQo6T0Wk0LTxnp8l+ajTKzxg
         fNkA==
X-Gm-Message-State: AKGB3mKy+e7NAmBo/Th7/dCtAU/0O6H5f/6h7IV+IFIChvhFNXtoLfJ+
        F+DIT3VOZrzjjEaCnRsNMLE9lH7zaGs=
X-Google-Smtp-Source: ACJfBoukmVBl0wHUGyMIThnDmJpK8M+MrCkdO5xW7Bvy285V55ZXSkbAIi5738cAS+Do3CsX9uO/wA==
X-Received: by 10.36.189.140 with SMTP id x134mr30443ite.26.1514938740373;
        Tue, 02 Jan 2018 16:19:00 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:18:59 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 13/26] connect: request remote refs using v2
Date:   Tue,  2 Jan 2018 16:18:15 -0800
Message-Id: <20180103001828.205012-14-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach the client to be able to request a remote's refs using protocol
v2.  This is done by having a client issue a 'ls-refs' request to a v2
server.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 connect.c              | 101 ++++++++++++++++++++++++++++++++++++++++++++++++-
 remote.h               |   4 ++
 t/t5701-protocol-v2.sh |  28 ++++++++++++++
 transport.c            |   2 +-
 upload-pack.c          |   9 +++--
 5 files changed, 138 insertions(+), 6 deletions(-)
 create mode 100755 t/t5701-protocol-v2.sh

diff --git a/connect.c b/connect.c
index caa539b75..9badd403f 100644
--- a/connect.c
+++ b/connect.c
@@ -12,9 +12,11 @@
 #include "sha1-array.h"
 #include "transport.h"
 #include "strbuf.h"
+#include "version.h"
 #include "protocol.h"
 
 static char *server_capabilities;
+static struct argv_array server_capabilities_v2 = ARGV_ARRAY_INIT;
 static const char *parse_feature_value(const char *, const char *, int *);
 
 static int check_ref(const char *name, unsigned int flags)
@@ -62,6 +64,33 @@ static void die_initial_contact(int unexpected)
 		      "and the repository exists."));
 }
 
+static int server_supports_v2(const char *c, int die_on_error)
+{
+	int i;
+
+	for (i = 0; i < server_capabilities_v2.argc; i++) {
+		const char *out;
+		if (skip_prefix(server_capabilities_v2.argv[i], c, &out) &&
+		    (!*out || *out == '='))
+			return 1;
+	}
+
+	if (die_on_error)
+		die("server doesn't support '%s'", c);
+
+	return 0;
+}
+
+static void process_capabilities_v2(struct packet_reader *reader)
+{
+	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
+		argv_array_push(&server_capabilities_v2, reader->line);
+	}
+
+	if (reader->status != PACKET_READ_FLUSH)
+		die("protocol error");
+}
+
 enum protocol_version discover_version(struct packet_reader *reader)
 {
 	enum protocol_version version = protocol_unknown_version;
@@ -85,7 +114,7 @@ enum protocol_version discover_version(struct packet_reader *reader)
 	/* Maybe process capabilities here, at least for v2 */
 	switch (version) {
 	case protocol_v2:
-		die("support for protocol v2 not implemented yet");
+		process_capabilities_v2(reader);
 		break;
 	case protocol_v1:
 		/* Read the peeked version line */
@@ -292,6 +321,76 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 	return list;
 }
 
+static int process_ref_v2(const char *line, struct ref ***list)
+{
+	int ret = 1;
+	int i = 0;
+	struct object_id old_oid;
+	struct ref *ref;
+	struct string_list line_sections = STRING_LIST_INIT_DUP;
+
+	if (string_list_split(&line_sections, line, ' ', -1) < 2) {
+		ret = 0;
+		goto out;
+	}
+
+	if (get_oid_hex(line_sections.items[i++].string, &old_oid)) {
+		ret = 0;
+		goto out;
+	}
+
+	ref = alloc_ref(line_sections.items[i++].string);
+
+	if (i < line_sections.nr)
+		ref->symref = xstrdup(line_sections.items[i++].string);
+
+	oidcpy(&ref->old_oid, &old_oid);
+	**list = ref;
+	*list = &ref->next;
+
+out:
+	string_list_clear(&line_sections, 0);
+	return ret;
+}
+
+struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
+			     struct ref **list, int for_push,
+			     const struct argv_array *ref_patterns)
+{
+	int i;
+	*list = NULL;
+
+	/* Check that the server supports the ls-refs command */
+	/* Issue request for ls-refs */
+	if (server_supports_v2("ls-refs", 1))
+		packet_write_fmt(fd_out, "command=ls-refs\n");
+
+	if (server_supports_v2("agent", 0))
+	    packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());
+
+	packet_delim(fd_out);
+	/* When pushing we don't want to request the peeled tags */
+	if (!for_push)
+		packet_write_fmt(fd_out, "peel\n");
+	packet_write_fmt(fd_out, "symrefs\n");
+	for (i = 0; ref_patterns && i < ref_patterns->argc; i++) {
+		packet_write_fmt(fd_out, "ref-pattern %s\n",
+				 ref_patterns->argv[i]);
+	}
+	packet_flush(fd_out);
+
+	/* Process response from server */
+	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
+		if (!process_ref_v2(reader->line, &list))
+			die("invalid ls-refs response: %s", reader->line);
+	}
+
+	if (reader->status != PACKET_READ_FLUSH)
+		die("protocol error");
+
+	return list;
+}
+
 static const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp)
 {
 	int len;
diff --git a/remote.h b/remote.h
index 2016461df..21d0c776c 100644
--- a/remote.h
+++ b/remote.h
@@ -151,10 +151,14 @@ void free_refs(struct ref *ref);
 
 struct oid_array;
 struct packet_reader;
+struct argv_array;
 extern struct ref **get_remote_heads(struct packet_reader *reader,
 				     struct ref **list, unsigned int flags,
 				     struct oid_array *extra_have,
 				     struct oid_array *shallow_points);
+extern struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
+				    struct ref **list, int for_push,
+				    const struct argv_array *ref_patterns);
 
 int resolve_remote_symref(struct ref *ref, struct ref *list);
 int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid);
diff --git a/t/t5701-protocol-v2.sh b/t/t5701-protocol-v2.sh
new file mode 100755
index 000000000..4bf4d61ac
--- /dev/null
+++ b/t/t5701-protocol-v2.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_description='test git wire-protocol version 2'
+
+TEST_NO_CREATE_REPO=1
+
+. ./test-lib.sh
+
+# Test protocol v2 with 'file://' transport
+#
+test_expect_success 'create repo to be served by file:// transport' '
+	git init file_parent &&
+	test_commit -C file_parent one
+'
+
+test_expect_success 'list refs with file:// using protocol v2' '
+	GIT_TRACE_PACKET=1 git -c protocol.version=2 \
+		ls-remote --symref "file://$(pwd)/file_parent" >actual 2>log &&
+
+	# Server responded using protocol v2
+	cat log &&
+	grep "git< version 2" log &&
+
+	git ls-remote --symref "file://$(pwd)/file_parent" >expect &&
+	test_cmp actual expect
+'
+
+test_done
diff --git a/transport.c b/transport.c
index 83d9dd1df..ffc6b2614 100644
--- a/transport.c
+++ b/transport.c
@@ -204,7 +204,7 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 	data->version = discover_version(&reader);
 	switch (data->version) {
 	case protocol_v2:
-		die("support for protocol v2 not implemented yet");
+		get_remote_refs(data->fd[1], &reader, &refs, for_push, NULL);
 		break;
 	case protocol_v1:
 	case protocol_v0:
diff --git a/upload-pack.c b/upload-pack.c
index 2bc888fc1..2ca60d27c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -19,6 +19,7 @@
 #include "argv-array.h"
 #include "prio-queue.h"
 #include "protocol.h"
+#include "serve.h"
 
 static const char * const upload_pack_usage[] = {
 	N_("git upload-pack [<options>] <dir>"),
@@ -1071,6 +1072,7 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 {
 	const char *dir;
 	int strict = 0;
+	struct serve_options opts = SERVE_OPTIONS_INIT;
 	struct option options[] = {
 		OPT_BOOL(0, "stateless-rpc", &stateless_rpc,
 			 N_("quit after a single request/response exchange")),
@@ -1105,10 +1107,9 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 
 	switch (determine_protocol_version_server()) {
 	case protocol_v2:
-		/*
-		 * fetch support for protocol v2 has not been implemented yet,
-		 * so ignore the request to use v2 and fallback to using v0.
-		 */
+		opts.advertise_capabilities = advertise_refs;
+		opts.stateless_rpc = stateless_rpc;
+		serve(&opts);
 		break;
 	case protocol_v1:
 		/*
-- 
2.15.1.620.gb9897f4670-goog

