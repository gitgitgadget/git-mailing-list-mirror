Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1D9420954
	for <e@80x24.org>; Mon,  4 Dec 2017 23:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbdLDX7b (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 18:59:31 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39399 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752075AbdLDX7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 18:59:25 -0500
Received: by mail-pf0-f194.google.com with SMTP id l24so9800760pfj.6
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 15:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lmCnFycmkg1HdLwG91piKPHedy7PQGucl71khlntVv0=;
        b=DOb2k/W7zDia1RQYJh+VNSd2agLLIHJXpb1VBButDw9asPYCt23m3ssmvVwuz+Y5b/
         tX6k9Sec1gu9HZdtwVSfF6BvjSo55JhbQa4q03hrECJdYwqs/pl0iCAQRP/fUe8Rh5Js
         muYZ8ckWHrMptHy2rvIalutaX/an6icf6RzJus+ZtNm1kHrez0wCYulCdBTUEnkykD2M
         Ex7d7L0rtxj0yFqdeSlQhcaOL+J290lZ5R5aigasRcTbxKro0RLgnSDFT2EMWIjVS9GE
         htg8XJFeKzbu9lMUUpBgtm0cCmKqV6GedH+3HVgSTASqU5ddS+J/v3Esy3v3/2fHRnrA
         xQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lmCnFycmkg1HdLwG91piKPHedy7PQGucl71khlntVv0=;
        b=XYfK+sAhET82kg7b43QfDkVN0SgSsIpgWgHL6DPrmsC8NG2rAe88w2keCKziw0gnhO
         T/pvHyjnsy8LNYavtd/QcfuXNeCx0v0scWB66rOdKQ5sheLNCSJSw5Z5yE05rO2v97Mr
         WjlMuszplWaqIBGrpxYAJdvGUMBOIuLvBRo2iLgT3HWFNvv7ebv9r7CAoVDCgU4I2msG
         f3e40ErLp5/bW7hwELucUkV2xJ8sq85o+CbwJ2x+sN9eCnv5ndEyZvDlkCEJIqwzlUg5
         JtLgq7hnJi0xji7i9owNICAKeQIVrA0qXiSMVYz2v6oWBza5vVL7k8H59eTRc3qvKqmW
         ecyw==
X-Gm-Message-State: AKGB3mL/afPCKNKt6KocrdPSK9ncAc0jcs9CE9ik+EmMfmohgDjUEvSI
        D6nawn/0I5Axsfd2lhlTKRp+BFZ+1p0=
X-Google-Smtp-Source: AGs4zMYzLSEv2nvCq1GQNQBtPjwWh+VVYTfJrPj8XMYI7Ea7szeFfbTpL7pUxmgGNI393waYg3gmJw==
X-Received: by 10.98.220.218 with SMTP id c87mr496121pfl.229.1512431964094;
        Mon, 04 Dec 2017 15:59:24 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id b187sm24939223pfg.109.2017.12.04.15.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 15:59:23 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [WIP 13/15] connect: request remote refs using v2
Date:   Mon,  4 Dec 2017 15:58:21 -0800
Message-Id: <20171204235823.63299-14-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081-goog
In-Reply-To: <20171204235823.63299-1-bmwill@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <20171204235823.63299-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach the client to be able to request a remote's refs using protocol
v2.  This is done by having a client issue a 'ls-refs' request to a v2
server.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 connect.c              | 85 +++++++++++++++++++++++++++++++++++++++++++++++++-
 remote.h               |  2 ++
 t/t5701-protocol-v2.sh | 28 +++++++++++++++++
 transport.c            |  2 +-
 upload-pack.c          |  3 +-
 5 files changed, 117 insertions(+), 3 deletions(-)
 create mode 100755 t/t5701-protocol-v2.sh

diff --git a/connect.c b/connect.c
index 433f08649..b3c933fc1 100644
--- a/connect.c
+++ b/connect.c
@@ -15,6 +15,7 @@
 #include "protocol.h"
 
 static char *server_capabilities;
+static struct argv_array server_capabilities_v2 = ARGV_ARRAY_INIT;
 static const char *parse_feature_value(const char *, const char *, int *);
 
 static int check_ref(const char *name, unsigned int flags)
@@ -62,6 +63,30 @@ static void die_initial_contact(int unexpected)
 		      "and the repository exists."));
 }
 
+static int server_supports_v2(const char *c)
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
@@ -85,7 +110,7 @@ enum protocol_version discover_version(struct packet_reader *reader)
 	/* Maybe process capabilities here, at least for v2 */
 	switch (version) {
 	case protocol_v2:
-		die("support for protocol v2 not implemented yet");
+		process_capabilities_v2(reader);
 		break;
 	case protocol_v1:
 		/* Read the peeked version line */
@@ -292,6 +317,64 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 	return list;
 }
 
+static int process_ref_v2(const char *line, struct ref ***list)
+{
+	struct object_id old_oid;
+	const char *end_of_name;
+	struct ref *ref;
+
+	if (parse_oid_hex(line, &old_oid, &line))
+		return 0;
+	if (*line != ' ')
+		return 0;
+	line++;
+
+	end_of_name = strchr(line, ' ');
+
+	if (!end_of_name)
+		ref = alloc_ref(line);
+	else {
+		struct strbuf name = STRBUF_INIT;
+		/* symref info */
+		strbuf_add(&name, line, end_of_name - line);
+		ref = alloc_ref(name.buf);
+		ref->symref = xstrdup(end_of_name + 1);
+
+		strbuf_release(&name);
+	}
+
+	oidcpy(&ref->old_oid, &old_oid);
+	**list = ref;
+	*list = &ref->next;
+
+	return 1;
+}
+struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
+			     struct ref **list, unsigned int flags)
+{
+	*list = NULL;
+	/* Check that the server supports the ls-refs command */
+	if (!server_supports_v2("ls-refs"))
+		die("server doesn't support 'ls-refs' command");
+
+	/* Issue request for ls-refs */
+	packet_write_fmt(fd_out, "command=ls-refs");
+	packet_delim(fd_out);
+	packet_write_fmt(fd_out, "--symrefs");
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
index af34e44a4..64d87bf5b 100644
--- a/remote.h
+++ b/remote.h
@@ -155,6 +155,8 @@ extern struct ref **get_remote_heads(struct packet_reader *reader,
 				     struct ref **list, unsigned int flags,
 				     struct oid_array *extra_have,
 				     struct oid_array *shallow_points);
+extern struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
+				    struct ref **list, unsigned int flags);
 
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
index 8a3735cf5..ddd0d6174 100644
--- a/transport.c
+++ b/transport.c
@@ -202,7 +202,7 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 	data->version = discover_version(&reader);
 	switch (data->version) {
 	case protocol_v2:
-		die("support for protocol v2 not implemented yet");
+		get_remote_refs(data->fd[1], &reader, &refs, for_push ? REF_NORMAL : 0);
 		break;
 	case protocol_v1:
 	case protocol_v0:
diff --git a/upload-pack.c b/upload-pack.c
index d706175e4..3296831f8 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -19,6 +19,7 @@
 #include "argv-array.h"
 #include "prio-queue.h"
 #include "protocol.h"
+#include "serve.h"
 
 static const char * const upload_pack_usage[] = {
 	N_("git upload-pack [<options>] <dir>"),
@@ -1106,7 +1107,7 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 
 	switch (determine_protocol_version_server()) {
 	case protocol_v2:
-		die("support for protocol v2 not implemented yet");
+		serve();
 		break;
 	case protocol_v1:
 		/*
-- 
2.15.1.424.g9478a66081-goog

