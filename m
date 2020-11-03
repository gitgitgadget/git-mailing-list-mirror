Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB29C388F2
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 00:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D840722268
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 00:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eqOAI+iR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgKCA1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 19:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKCA1M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 19:27:12 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FB7C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 16:27:12 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id m5so8476448pfk.5
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 16:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=E3c2Of8bOSTUT+E5j9BMTTuG1AnorX3mUa8Idm4u03U=;
        b=eqOAI+iRRIqHeP+zQcezwHB76y7SXtOmXzqn8KRjR1IbvZK8LS3A0yc4zrvS2NUiSh
         4uaOqfWLdBVTZ14kr4urSDWW/bE4UFzjgLj0jL3lknb/dSGE/1RAESgyttWyxptVW/ZA
         JZOvo8hOUxYCQSBMSlQhzPQtsSTW4YeiMY/kLSD7lZBTLNuxFmJqjJnCVS6DBXVVcZ2M
         LC7ZMUhHx/GrAcV1NabsI1Nzmc0jxDhQhPbAGxIWsDxs80QNVIqvAWPHntMxzsEw1e+F
         jl4xtB5r8BIgGEiC17Scjb00qPvA99V5182a0DBZsfHnPGDrpg3KnrE7oCQX6EqRvP/s
         vHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E3c2Of8bOSTUT+E5j9BMTTuG1AnorX3mUa8Idm4u03U=;
        b=FI4O4Nws0y9i0MUPpe+Qk3/6B4bcgZcfil9SW0TIC3RIR/oW9SFosOmJ7SjxT16GNe
         LbTjs7yQpywraFz+5dvPkDmhRHrGtP9Hs6FFBZgTamxNjUk99ch3yq1n2sGxm0snhslD
         /lkaRe0vFpQyZM1R0SF73MPOTlKVa+x5EjXSikesZZUbkvJy/LnDlloCs2LGUCDyCOC4
         tn9VY6IriS1191cf0dNwTbDHn/tKYWsBUOvPtOmrwxH9xTxmnPDCjMBswVkwRUxFPZzh
         n9FZtIq2mQMbvXW5PVlONyAhOjrD4G2LVYDKUUNpPbTPcvs5QgndmNuwvqef7XXkEYTO
         w8HQ==
X-Gm-Message-State: AOAM532hhAPbwTTChJaUKrRIB1WQvEduiicDdXPXZlWz3zr5fqpyDVLf
        2CUFa132w4zvR6AzLG4Y2iBR4r70B0bB5k8hG/2obHJdI5uQxQsroNjbdynt+emoaLwQRsmv8xv
        aVfMQpWxYkNSHncpZpwZXhy8QSUH4RVkII2K9gPvVyZ/fJUqMfr0xKbSltK2dztyIXos8akVYvP
        qB
X-Google-Smtp-Source: ABdhPJw1yaTYVE2cxn5YB9B72A5zK4cYggtX80j7R+VNXi2bijd/w5KpkqDRSyX6KH0UsjXzMGhh3bEcbp9xVqN1Bd5d
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:63c6:0:b029:18a:8d05:5bdc with
 SMTP id x189-20020a6263c60000b029018a8d055bdcmr14365484pfb.37.1604363231813;
 Mon, 02 Nov 2020 16:27:11 -0800 (PST)
Date:   Mon,  2 Nov 2020 16:26:11 -0800
In-Reply-To: <cover.1604362701.git.jonathantanmy@google.com>
Message-Id: <148e39960a2185d2355cdfe34f8856e708fb1b80.1604362701.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1604362701.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 2/4] push: teach --base for ssh:// and file://
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For the ssh:// and file:// transports, teach push the "--base"
parameter, which indicates an ancestor of the commits to be pushed that
is believed to be known by the server.

If specified, it will be communicated to receive-pack through an Extra
Parameter. If the repository served by receive-pack indeed has that
object, receive-pack will send an abbreviated ref advertisement
containing only that object instead of the usual ref advertisement,
reducing the size of the ref advertisement and, potentially, the size of
the packfile to be sent.

This is supported both on protocol v0 and v1. (Protocol v1 is the same
as protocol v0, except that the client sends "version=1" as an Extra
Parameter and the server responds with "version 1".)

Support for http(s):// will be added in a subsequent patch.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch-pack.c   |  2 +-
 builtin/push.c         | 12 +++++--
 builtin/receive-pack.c | 46 +++++++++++++++++++++---
 builtin/send-pack.c    |  2 +-
 builtin/upload-pack.c  |  2 +-
 connect.c              |  8 ++++-
 connect.h              |  4 ++-
 http-backend.c         |  2 +-
 protocol.c             |  5 ++-
 protocol.h             |  5 ++-
 t/t5700-protocol-v1.sh | 80 ++++++++++++++++++++++++++++++++++++++++++
 transport.c            | 14 ++++++--
 transport.h            |  9 +++++
 13 files changed, 175 insertions(+), 16 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 58b7c1fbdc..9452969319 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -207,7 +207,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		if (args.diag_url)
 			flags |= CONNECT_DIAG_URL;
 		conn = git_connect(fd, dest, args.uploadpack,
-				   flags);
+				   flags, NULL);
 		if (!conn)
 			return args.diag_url ? 0 : 1;
 	}
diff --git a/builtin/push.c b/builtin/push.c
index 6da3a8e5d3..a9f3278a24 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -381,7 +381,8 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
 
 static int do_push(int flags,
 		   const struct string_list *push_options,
-		   struct remote *remote)
+		   struct remote *remote,
+		   const char *push_base)
 {
 	int i, errs;
 	const char **url;
@@ -405,6 +406,8 @@ static int do_push(int flags,
 				transport_get(remote, url[i]);
 			if (flags & TRANSPORT_PUSH_OPTIONS)
 				transport->push_options = push_options;
+			if (push_base)
+				transport_set_option(transport, TRANS_OPT_PUSH_BASE, push_base);
 			if (push_with_options(transport, push_refspec, flags))
 				errs++;
 		}
@@ -413,6 +416,8 @@ static int do_push(int flags,
 			transport_get(remote, NULL);
 		if (flags & TRANSPORT_PUSH_OPTIONS)
 			transport->push_options = push_options;
+		if (push_base)
+			transport_set_option(transport, TRANS_OPT_PUSH_BASE, push_base);
 		if (push_with_options(transport, push_refspec, flags))
 			errs++;
 	}
@@ -526,6 +531,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	struct string_list *push_options;
 	const struct string_list_item *item;
 	struct remote *remote;
+	const char *push_base = NULL;
 
 	struct option options[] = {
 		OPT__VERBOSITY(&verbosity),
@@ -562,6 +568,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 				TRANSPORT_FAMILY_IPV4),
 		OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
 				TRANSPORT_FAMILY_IPV6),
+		OPT_STRING(0, "base", &push_base, N_("revision"),
+			   N_("ancestor of commits to be pushed that is believed to be known by the server")),
 		OPT_END()
 	};
 
@@ -629,7 +637,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		if (strchr(item->string, '\n'))
 			die(_("push options must not have new line characters"));
 
-	rc = do_push(flags, push_options, remote);
+	rc = do_push(flags, push_options, remote, push_base);
 	string_list_clear(&push_options_cmdline, 0);
 	string_list_clear(&push_options_config, 0);
 	if (rc == -1)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index bb9909c52e..274f39c944 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -313,13 +313,38 @@ static void show_one_alternate_ref(const struct object_id *oid,
 	show_ref(".have", oid);
 }
 
-static void write_head_info(void)
+struct check_connected_for_one_args {
+	struct object_id *base;
+	unsigned already_emitted : 1;
+};
+static int check_connected_for_one(void *args, struct object_id *oid)
+{
+	struct check_connected_for_one_args *a = args;
+
+	if (a->already_emitted)
+		return -1;
+	oidcpy(oid, a->base);
+	a->already_emitted = 1;
+	return 0;
+}
+
+static void write_head_info(struct object_id *base)
 {
 	static struct oidset seen = OIDSET_INIT;
 
+	if (base) {
+		struct check_connected_for_one_args args = {base};
+
+		if (!check_connected(check_connected_for_one, &args, NULL)) {
+			show_ref(".have", base);
+			goto refs_shown;
+		}
+	}
+
 	for_each_ref(show_ref_cb, &seen);
 	for_each_alternate_ref(show_one_alternate_ref, &seen);
 	oidset_clear(&seen);
+refs_shown:
 	if (!sent_capabilities)
 		show_ref("capabilities^{}", &null_oid);
 
@@ -2417,6 +2442,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	struct oid_array ref = OID_ARRAY_INIT;
 	struct shallow_info si;
 	struct packet_reader reader;
+	struct strbuf base_sb = STRBUF_INIT;
 
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("quiet")),
@@ -2451,7 +2477,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	else if (0 <= receive_unpack_limit)
 		unpack_limit = receive_unpack_limit;
 
-	switch (determine_protocol_version_server()) {
+	switch (determine_protocol_version_server(&base_sb)) {
 	case protocol_v2:
 		/*
 		 * push support for protocol v2 has not been implemented yet,
@@ -2474,10 +2500,21 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	}
 
 	if (advertise_refs || !stateless_rpc) {
-		write_head_info();
+		if (base_sb.len) {
+			struct object_id oid;
+			const char *p;
+
+			if (parse_oid_hex(base_sb.buf, &oid, &p) || *p != '\0')
+				die("invalid base");
+			write_head_info(&oid);
+		} else {
+			write_head_info(NULL);
+		}
 	}
-	if (advertise_refs)
+	if (advertise_refs) {
+		strbuf_release(&base_sb);
 		return 0;
+	}
 
 	packet_reader_init(&reader, 0, NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
@@ -2540,6 +2577,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	}
 	if (use_sideband)
 		packet_flush(1);
+	strbuf_release(&base_sb);
 	oid_array_clear(&shallow);
 	oid_array_clear(&ref);
 	free((void *)push_cert_nonce);
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 7af148d733..1557db7a42 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -262,7 +262,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		fd[1] = 1;
 	} else {
 		conn = git_connect(fd, dest, receivepack,
-			args.verbose ? CONNECT_VERBOSE : 0);
+			args.verbose ? CONNECT_VERBOSE : 0, NULL);
 	}
 
 	packet_reader_init(&reader, fd[0], NULL, 0,
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index 6da8fa2607..32aaa7742c 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -48,7 +48,7 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 	if (!enter_repo(dir, strict))
 		die("'%s' does not appear to be a git repository", dir);
 
-	switch (determine_protocol_version_server()) {
+	switch (determine_protocol_version_server(NULL)) {
 	case protocol_v2:
 		serve_opts.advertise_capabilities = opts.advertise_refs;
 		serve_opts.stateless_rpc = opts.stateless_rpc;
diff --git a/connect.c b/connect.c
index 5221f1764c..fa5b7ea886 100644
--- a/connect.c
+++ b/connect.c
@@ -1318,7 +1318,8 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
  * the connection failed).
  */
 struct child_process *git_connect(int fd[2], const char *url,
-				  const char *prog, int flags)
+				  const char *prog, int flags,
+				  const char *other_extra_parameters)
 {
 	char *hostandport, *path;
 	struct child_process *conn;
@@ -1369,6 +1370,11 @@ struct child_process *git_connect(int fd[2], const char *url,
 
 		if (version > 0)
 			strbuf_addf(&extra_parameters, "version=%d", version);
+		if (other_extra_parameters) {
+			if (extra_parameters.len)
+				strbuf_addch(&extra_parameters, ':');
+			strbuf_addstr(&extra_parameters, other_extra_parameters);
+		}
 
 		conn->use_shell = 1;
 		conn->in = conn->out = -1;
diff --git a/connect.h b/connect.h
index c53586e929..6d502d4224 100644
--- a/connect.h
+++ b/connect.h
@@ -7,7 +7,9 @@
 #define CONNECT_DIAG_URL      (1u << 1)
 #define CONNECT_IPV4          (1u << 2)
 #define CONNECT_IPV6          (1u << 3)
-struct child_process *git_connect(int fd[2], const char *url, const char *prog, int flags);
+struct child_process *git_connect(int fd[2], const char *url,
+				  const char *prog, int flags,
+				  const char *other_extra_parameters);
 int finish_connect(struct child_process *conn);
 int git_connection_is_socket(struct child_process *conn);
 int server_supports(const char *feature);
diff --git a/http-backend.c b/http-backend.c
index a03b4bae22..7cd684c8b5 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -544,7 +544,7 @@ static void get_info_refs(struct strbuf *hdr, char *arg)
 		end_headers(hdr);
 
 
-		if (determine_protocol_version_server() != protocol_v2) {
+		if (determine_protocol_version_server(NULL) != protocol_v2) {
 			packet_write_fmt(1, "# service=git-%s\n", svc->name);
 			packet_flush(1);
 		}
diff --git a/protocol.c b/protocol.c
index 052d7edbb9..ad653b7521 100644
--- a/protocol.c
+++ b/protocol.c
@@ -42,7 +42,7 @@ enum protocol_version get_protocol_version_config(void)
 	return protocol_v2;
 }
 
-enum protocol_version determine_protocol_version_server(void)
+enum protocol_version determine_protocol_version_server(struct strbuf *base_sb)
 {
 	const char *git_protocol = getenv(GIT_PROTOCOL_ENVIRONMENT);
 	enum protocol_version version = protocol_v0;
@@ -67,6 +67,9 @@ enum protocol_version determine_protocol_version_server(void)
 				v = parse_protocol_version(value);
 				if (v > version)
 					version = v;
+			} else if (skip_prefix(item->string, "base=", &value)) {
+				if (base_sb)
+					strbuf_addstr(base_sb, value);
 			}
 		}
 
diff --git a/protocol.h b/protocol.h
index cef1a4a01c..e418b92049 100644
--- a/protocol.h
+++ b/protocol.h
@@ -22,8 +22,11 @@ enum protocol_version get_protocol_version_config(void);
  * by setting appropriate values for the key 'version'.  If a client doesn't
  * request a particular protocol version, a default of 'protocol_v0' will be
  * used.
+ *
+ * If base_sb is not NULL and an extra parameter "base" is specified, this
+ * function will append its value to base_sb.
  */
-enum protocol_version determine_protocol_version_server(void);
+enum protocol_version determine_protocol_version_server(struct strbuf *base_sb);
 
 /*
  * Used by a client to determine which protocol version the server is speaking
diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index 022901b9eb..22459d37f5 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -146,6 +146,56 @@ test_expect_success 'push with file:// using protocol v1' '
 	grep "push< version 1" log
 '
 
+test_expect_success 'push with file:// using protocol v1 and --base' '
+	test_commit -C file_child four &&
+	COMMON_HASH=$(git -C file_child rev-parse three) &&
+
+	# Push to another branch, as the target repository has the
+	# master branch checked out and we cannot push into it.
+	GIT_TRACE_PACKET=1 git -C file_child -c protocol.version=1 \
+		push --base=three origin HEAD:client_branch_four 2>log &&
+
+	# Server responded using protocol v1
+	grep "push< version 1" log &&
+	# Server advertised only the expected object
+	grep "$COMMON_HASH .have" log
+'
+
+test_expect_success 'push with file:// using protocol v0 and --base' '
+	test_commit -C file_child five &&
+	COMMON_HASH=$(git -C file_child rev-parse four) &&
+
+	# Push to another branch, as the target repository has the
+	# master branch checked out and we cannot push into it.
+	GIT_TRACE_PACKET=1 git -C file_child -c protocol.version=0 \
+		push --base=four origin HEAD:client_branch_five 2>log &&
+
+	# Server did not respond with any version
+	! grep "push< version" log &&
+	# Server advertised only the expected object
+	grep "$COMMON_HASH .have" log
+'
+
+test_expect_success 'push with invalid --base' '
+	test_commit -C file_child six &&
+
+	# Server does not have "six".
+	test_must_fail git -C file_child -c protocol.version=0 \
+		push --base=an_invalid_object origin HEAD:client_branch_six 2>log &&
+	grep "is not a valid object" log
+'
+
+test_expect_success 'push with --base that does not exist on server' '
+	COMMON_HASH=$(git -C file_child rev-parse six) &&
+
+	# The push still succeeds.
+	GIT_TRACE_PACKET=1 git -C file_child -c protocol.version=0 \
+		push --base=six origin HEAD:client_branch_six 2>log &&
+
+	# Server did not advertise "six", since it does not know it
+	! grep "$COMMON_HASH .have" log
+'
+
 # Test protocol v1 with 'ssh://' transport
 #
 test_expect_success 'setup ssh wrapper' '
@@ -226,6 +276,36 @@ test_expect_success 'push with ssh:// using protocol v1' '
 	grep "push< version 1" log
 '
 
+test_expect_success 'push with ssh:// using protocol v1 and --base' '
+	test_commit -C ssh_child four &&
+	COMMON_HASH=$(git -C ssh_child rev-parse three) &&
+
+	# Push to another branch, as the target repository has the
+	# master branch checked out and we cannot push into it.
+	GIT_TRACE_PACKET=1 git -C ssh_child -c protocol.version=1 \
+		push --base="$COMMON_HASH" origin HEAD:client_branch_four 2>log &&
+
+	# Server responded using protocol v1
+	grep "push< version 1" log &&
+	# Server advertised only the expected object
+	grep "$COMMON_HASH .have" log
+'
+
+test_expect_success 'push with ssh:// using protocol v0 and --base' '
+	test_commit -C ssh_child five &&
+	COMMON_HASH=$(git -C ssh_child rev-parse four) &&
+
+	# Push to another branch, as the target repository has the
+	# master branch checked out and we cannot push into it.
+	GIT_TRACE_PACKET=1 git -C ssh_child -c protocol.version=0 \
+		push --base="$COMMON_HASH" origin HEAD:client_branch_five 2>log &&
+
+	# Server did not respond with any version
+	! grep "push< version" log &&
+	# Server advertised only the expected object
+	grep "$COMMON_HASH .have" log
+'
+
 # Test protocol v1 with 'http://' transport
 #
 . "$TEST_DIRECTORY"/lib-httpd.sh
diff --git a/transport.c b/transport.c
index ffe2115845..531ca0a834 100644
--- a/transport.c
+++ b/transport.c
@@ -236,6 +236,10 @@ static int set_git_option(struct git_transport_options *opts,
 		list_objects_filter_die_if_populated(&opts->filter_options);
 		parse_list_objects_filter(&opts->filter_options, value);
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_PUSH_BASE)) {
+		if (get_oid(value, &opts->push_base))
+			die(_("transport: '%s' is not a valid object"), value);
+		return 0;
 	}
 	return 1;
 }
@@ -244,6 +248,7 @@ static int connect_setup(struct transport *transport, int for_push)
 {
 	struct git_transport_data *data = transport->data;
 	int flags = transport->verbose > 0 ? CONNECT_VERBOSE : 0;
+	char *extra_parameters = NULL;
 
 	if (data->conn)
 		return 0;
@@ -254,11 +259,16 @@ static int connect_setup(struct transport *transport, int for_push)
 	case TRANSPORT_FAMILY_IPV6: flags |= CONNECT_IPV6; break;
 	}
 
+	if (!is_null_oid(&data->options.push_base))
+		extra_parameters = xstrfmt("base=%s",
+					   oid_to_hex(&data->options.push_base));
+
 	data->conn = git_connect(data->fd, transport->url,
 				 for_push ? data->options.receivepack :
 				 data->options.uploadpack,
-				 flags);
+				 flags, extra_parameters);
 
+	free(extra_parameters);
 	return 0;
 }
 
@@ -815,7 +825,7 @@ static int connect_git(struct transport *transport, const char *name,
 {
 	struct git_transport_data *data = transport->data;
 	data->conn = git_connect(data->fd, transport->url,
-				 executable, 0);
+				 executable, 0, NULL);
 	fd[0] = data->fd[0];
 	fd[1] = data->fd[1];
 	return 0;
diff --git a/transport.h b/transport.h
index ca409ea1e4..ce51edd673 100644
--- a/transport.h
+++ b/transport.h
@@ -46,6 +46,12 @@ struct git_transport_options {
 	 * transport_set_option().
 	 */
 	struct oid_array *negotiation_tips;
+
+	/*
+	 * When pushing, if this is not a null OID, indicates an ancestor of
+	 * the commits to be pushed that is believed to be known by the server.
+	 */
+	struct object_id push_base;
 };
 
 enum transport_family {
@@ -208,6 +214,9 @@ void transport_check_allowed(const char *type);
 /* Request atomic (all-or-nothing) updates when pushing */
 #define TRANS_OPT_ATOMIC "atomic"
 
+/* See "push_base" in struct git_transport_options */
+#define TRANS_OPT_PUSH_BASE "push-base"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
-- 
2.29.1.341.ge80a0c044ae-goog

