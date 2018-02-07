Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 654661F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932225AbeBGBNx (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:13:53 -0500
Received: from mail-yw0-f201.google.com ([209.85.161.201]:56270 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932213AbeBGBNs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:13:48 -0500
Received: by mail-yw0-f201.google.com with SMTP id l74so4393966ywc.22
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=oy62cup174/nYRadtIVgD9feqrw7cdCJAgJJC+3eRZ0=;
        b=ggHRO+28PWpX2xUfdzagAhCntU2Aa6LuZEJwCMq/Q4soe/JgGM9o7VpkeyTyPNxrGB
         2/oOrZTDWh26OYE2mENjPs8D1ONCRBOyDeUnbxZLHaZZc9lzuIhXdPDK1VoPZfUPLR+C
         9LOT6TFAYMB6LyMQxW6oAEXdZIvKQAnpvov+tLnoaTv4QMGKCOOwExCIx71kUFRe8nC9
         HF+E7OqNj2qLDJHfoJpS4z9WXW1UWYKXdA8E0ja6noV9u3SLElmmun/L8ESb0EDTfbmw
         ujNx6JMCgEnFgF95R6AlRu4PX1/iTqeHvLW9Qc83pVJLRz+oxhf18WLK0iXvSLfTmh26
         +E6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=oy62cup174/nYRadtIVgD9feqrw7cdCJAgJJC+3eRZ0=;
        b=NJc6VhoGiNGQKz6e2fm5Kg9M+QpsY6dFOjWzcu+O+ZxTiS6No9iGqHaKyOWUHZjU8V
         MES+bOWOCj2bCwH0TWm9yeJJx0uoJ0WHmJ+USTzPpF92lMEAc3JjJ0D+6U5h/otqKwCu
         ES7dwGhRs4+B4HsU/Zc3MOCeioyEKySgCKJcg0AA48p9hzSZqNI1uph5mJDq/r8dEqmv
         gPpkuvCCxDPKc0/irLNdWBIURQJlai48rHBM0uH2GHbAKV3uyx1gJzT/ygNZcQabEVts
         Dbo832ctzZyuR0MqcnNDKSK4hULKHXTzn4Uq6RvUxlN8Xl2T2UOXeC6/8eAdvrCjDVKE
         EPlw==
X-Gm-Message-State: APf1xPBVXi0q+xdIPLoChZa/JHvZOqtoEXidLdw+SQiJUN8cEKZqemx8
        cb/2Hu0X20XK4MPqWaPNhGsCvM0hqo/tQMd5MAPc8S8jQG75Fqp9NKOf9ykddIvR26giUFOkoyo
        L0l7vFwdYEBI8TeqAeJCWkEk8fur/rA5wQj661NVrHdN4tXqqyYMpZXdctQ==
X-Google-Smtp-Source: AH8x224v36S3QEbxk1qsOmck/AjuEwjaSuYIuqeeZOyIoF8KOWzVuemH0IRDgisZyQY+JvFAvA85gZsrIeg=
MIME-Version: 1.0
X-Received: by 10.37.114.6 with SMTP id n6mr2256766ybc.16.1517966028041; Tue,
 06 Feb 2018 17:13:48 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:12:51 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-15-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 14/35] connect: request remote refs using v2
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach the client to be able to request a remote's refs using protocol
v2.  This is done by having a client issue a 'ls-refs' request to a v2
server.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/upload-pack.c  |  10 ++--
 connect.c              | 123 ++++++++++++++++++++++++++++++++++++++++++++++++-
 connect.h              |   2 +
 remote.h               |   4 ++
 t/t5702-protocol-v2.sh |  53 +++++++++++++++++++++
 transport.c            |   2 +-
 6 files changed, 187 insertions(+), 7 deletions(-)
 create mode 100755 t/t5702-protocol-v2.sh

diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index 8d53e9794..a757df8da 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -5,6 +5,7 @@
 #include "parse-options.h"
 #include "protocol.h"
 #include "upload-pack.h"
+#include "serve.h"
 
 static const char * const upload_pack_usage[] = {
 	N_("git upload-pack [<options>] <dir>"),
@@ -16,6 +17,7 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 	const char *dir;
 	int strict = 0;
 	struct upload_pack_options opts = { 0 };
+	struct serve_options serve_opts = SERVE_OPTIONS_INIT;
 	struct option options[] = {
 		OPT_BOOL(0, "stateless-rpc", &opts.stateless_rpc,
 			 N_("quit after a single request/response exchange")),
@@ -48,11 +50,9 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 
 	switch (determine_protocol_version_server()) {
 	case protocol_v2:
-		/*
-		 * fetch support for protocol v2 has not been implemented yet,
-		 * so ignore the request to use v2 and fallback to using v0.
-		 */
-		upload_pack(&opts);
+		serve_opts.advertise_capabilities = opts.advertise_refs;
+		serve_opts.stateless_rpc = opts.stateless_rpc;
+		serve(&serve_opts);
 		break;
 	case protocol_v1:
 		/*
diff --git a/connect.c b/connect.c
index f2157a821..7cb1f1df7 100644
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
 
+/* Checks if the server supports the capability 'c' */
+int server_supports_v2(const char *c, int die_on_error)
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
+	while (packet_reader_read(reader) == PACKET_READ_NORMAL)
+		argv_array_push(&server_capabilities_v2, reader->line);
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
@@ -293,6 +322,98 @@ struct ref **get_remote_heads(struct packet_reader *reader,
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
+	oidcpy(&ref->old_oid, &old_oid);
+	**list = ref;
+	*list = &ref->next;
+
+	for (; i < line_sections.nr; i++) {
+		const char *arg = line_sections.items[i].string;
+		if (skip_prefix(arg, "symref-target:", &arg))
+			ref->symref = xstrdup(arg);
+
+		if (skip_prefix(arg, "peeled:", &arg)) {
+			struct object_id peeled_oid;
+			char *peeled_name;
+			struct ref *peeled;
+			if (get_oid_hex(arg, &peeled_oid)) {
+				ret = 0;
+				goto out;
+			}
+
+			peeled_name = xstrfmt("%s^{}", ref->name);
+			peeled = alloc_ref(peeled_name);
+
+			oidcpy(&peeled->old_oid, &peeled_oid);
+			**list = peeled;
+			*list = &peeled->next;
+
+			free(peeled_name);
+		}
+	}
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
diff --git a/connect.h b/connect.h
index cdb8979dc..8898d4495 100644
--- a/connect.h
+++ b/connect.h
@@ -16,4 +16,6 @@ extern int url_is_local_not_ssh(const char *url);
 struct packet_reader;
 extern enum protocol_version discover_version(struct packet_reader *reader);
 
+extern int server_supports_v2(const char *c, int die_on_error);
+
 #endif
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
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
new file mode 100755
index 000000000..1e42b5588
--- /dev/null
+++ b/t/t5702-protocol-v2.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+
+test_description='test git wire-protocol version 2'
+
+TEST_NO_CREATE_REPO=1
+
+. ./test-lib.sh
+
+# Test protocol v2 with 'git://' transport
+#
+. "$TEST_DIRECTORY"/lib-git-daemon.sh
+start_git_daemon --export-all --enable=receive-pack
+daemon_parent=$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent
+
+test_expect_success 'create repo to be served by git-daemon' '
+	git init "$daemon_parent" &&
+	test_commit -C "$daemon_parent" one
+'
+
+test_expect_success 'list refs with git:// using protocol v2' '
+	GIT_TRACE_PACKET=1 git -c protocol.version=2 \
+		ls-remote --symref "$GIT_DAEMON_URL/parent" >actual 2>log &&
+
+	# Client requested to use protocol v2
+	grep "git> .*\\\0\\\0version=2\\\0$" log &&
+	# Server responded using protocol v2
+	grep "git< version 2" log &&
+
+	git ls-remote --symref "$GIT_DAEMON_URL/parent" >expect &&
+	test_cmp actual expect
+'
+
+stop_git_daemon
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
-- 
2.16.0.rc1.238.g530d649a79-goog

