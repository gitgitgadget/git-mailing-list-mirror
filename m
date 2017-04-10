Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30CDF20960
	for <e@80x24.org>; Mon, 10 Apr 2017 20:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbdDJUqZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 16:46:25 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35718 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbdDJUqY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 16:46:24 -0400
Received: by mail-pf0-f180.google.com with SMTP id i5so38525265pfc.2
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 13:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=si3wSTg0QI7FDzHd1TBx2igm7OWAnpddssX5yQg7mRg=;
        b=ScceZlosW8aaa6fuK7y+zY+af/TV1s/mE0mzHkYSRulTFwBRKvJYk5rld0L31HZrgG
         lUgZ66FBRkkFVK8unYBGe8i++O0BSKva0f2ETjo5iCzRZSBcieWYoNYxejqqKP3a/Lg8
         r3O1m/vWl/1iXYLi1jTWNleL3C8Vc1wZ67fMLsRzkpK/zyCsgUI4LbewUbRwhSa790Yz
         HMxc7kbvcYUGka1DBr8wIhpH2HOgu1FID5M8D+tbfTm9RYWphuaxTigwDpbr11aQuKGT
         TEVTVgJJWLW+tXGVUSDI/2ZOGW4cutYIVt5JGHwit35WWjb6fTOB4sm2+ByPgu1DPC5/
         JQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=si3wSTg0QI7FDzHd1TBx2igm7OWAnpddssX5yQg7mRg=;
        b=sUw44rZUAoL85exySqZWm2mf+lUwOYoO4wkUCntwHYR9m4LF6VGxX0hCkHyjzageh4
         odTxkmgBhMsYdCkX9D+SxpC9wF6tkhlqCDP87o2zc8GA8k6rLAU2qHzYXUTphtg2FX5w
         yc6fdQ89wwKEusJ5Y3Fyswvlu2/Li2klYt2nM6kdH7i7oAbh1ThLho6TZVh+QrCSgfni
         GXiGcukOHh0qedudPbZM2DEhfkmuDTdupwmSMsjZ9Af2458XTcQfDfqpTHZbK51fxeLr
         cwMu/A/bv2Evgc1rMPSSOKbBjaSsl0F4TqYnD5RWNa5xamN/6Bpu0oNTOi1DZFvW2Tyk
         keOQ==
X-Gm-Message-State: AFeK/H3eQXJ47weBda9DTL3aYBLM9WYtGW3C9inxfAvhd4wgk3sBF8scTOf4rj33/9jGsL0M
X-Received: by 10.99.56.17 with SMTP id f17mr58746138pga.228.1491857183331;
        Mon, 10 Apr 2017 13:46:23 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id r90sm6709414pfl.120.2017.04.10.13.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 13:46:22 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC 1/4] server-endpoint: serve refs without advertisement
Date:   Mon, 10 Apr 2017 13:46:07 -0700
Message-Id: <247c6b74c9d375f3d34996c1e4465761ee9d49a1.1491851452.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.12.2.715.g7642488e1d-goog
In-Reply-To: <cover.1491851452.git.jonathantanmy@google.com>
References: <cover.1491851452.git.jonathantanmy@google.com>
In-Reply-To: <cover.1491851452.git.jonathantanmy@google.com>
References: <cover.1491851452.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a new binary that can act as an endpoint to serve refs without
first sending the ref advertisement (a list of all ref names and
associated hashes that the server contains). For very large
repositories, including an internal Android repository with more than
700000 refs, this would save tens of megabytes of network bandwidth
during each fetch.

This endpoint handles ref namespaces and "uploadpack.hiderefs" by
itself, and handles other functionality by invoking upload-pack and
acting as an intermediary (therefore having to know the relatively
minute details of the fetch-pack/upload-pack protocol).

Note: There is still an issue with the handling of "deepen" lines. The
documentation for the pack protocol states that "deepen 0" is the same
as not specifying any depth, but upload-pack seems to not accept "deepen
0". I'm not sure if it's better to change the documentation or change
the code - I generally prefer to change the code in such cases, but
treating "deepen 0" (and similar things like "deepen 000") differently
from other "deepen"s requires multiple components to know about this
special case (upload-pack, fetch-pack, and now server-endpoint) so I'm
inclined to just forbid it (like in the current code).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 .gitignore        |   1 +
 Makefile          |   2 +
 server-endpoint.c | 228 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 231 insertions(+)
 create mode 100644 server-endpoint.c

diff --git a/.gitignore b/.gitignore
index 833ef3b0b..761e06d2c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -140,6 +140,7 @@
 /git-rm
 /git-send-email
 /git-send-pack
+/git-server-endpoint
 /git-sh-i18n
 /git-sh-i18n--envsubst
 /git-sh-setup
diff --git a/Makefile b/Makefile
index c80fec292..0d3813772 100644
--- a/Makefile
+++ b/Makefile
@@ -603,6 +603,7 @@ PROGRAM_OBJS += shell.o
 PROGRAM_OBJS += show-index.o
 PROGRAM_OBJS += upload-pack.o
 PROGRAM_OBJS += remote-testsvn.o
+PROGRAM_OBJS += server-endpoint.o
 
 # Binary suffix, set to .exe for Windows builds
 X =
@@ -673,6 +674,7 @@ BINDIR_PROGRAMS_NEED_X += git-upload-pack
 BINDIR_PROGRAMS_NEED_X += git-receive-pack
 BINDIR_PROGRAMS_NEED_X += git-upload-archive
 BINDIR_PROGRAMS_NEED_X += git-shell
+BINDIR_PROGRAMS_NEED_X += git-server-endpoint
 
 BINDIR_PROGRAMS_NO_X += git-cvsserver
 
diff --git a/server-endpoint.c b/server-endpoint.c
new file mode 100644
index 000000000..a9c0c7c94
--- /dev/null
+++ b/server-endpoint.c
@@ -0,0 +1,228 @@
+#include "cache.h"
+#include "pkt-line.h"
+#include "refs.h"
+#include "revision.h"
+#include "run-command.h"
+
+static const char * const server_endpoint_usage[] = {
+	N_("git server-endpoint [<options>] <dir>"),
+	NULL
+};
+
+static const char *capabilities = "multi_ack_detailed side-band-64k shallow";
+
+struct handle_want_data {
+	int upload_pack_in_fd;
+	int capabilities_sent;
+	struct string_list sent_namespaced_names;
+};
+
+static int send_want(const char *namespaced_name, const struct object_id *oid,
+		     int flags, void *handle_want_data)
+{
+	struct handle_want_data *data = handle_want_data;
+
+	if (ref_is_hidden(strip_namespace(namespaced_name), namespaced_name))
+		return 0;
+	if (string_list_lookup(&data->sent_namespaced_names, namespaced_name))
+		return 0;
+
+	string_list_insert(&data->sent_namespaced_names, namespaced_name);
+
+	if (data->capabilities_sent) {
+		packet_write_fmt(data->upload_pack_in_fd, "want %s\n",
+				 oid_to_hex(oid));
+	} else {
+		packet_write_fmt(data->upload_pack_in_fd, "want %s%s\n",
+				 oid_to_hex(oid), capabilities);
+		data->capabilities_sent = 1;
+	}
+
+	return 0;
+}
+
+static void handle_want(const char *arg, struct handle_want_data *data) {
+	char *namespaced_name = xstrfmt("%s%s", get_git_namespace(), arg);
+	if (has_glob_specials(arg)) {
+		for_each_glob_ref(send_want, namespaced_name, data);
+	} else {
+		struct object_id oid;
+		if (!read_ref(namespaced_name, oid.hash))
+			send_want(namespaced_name, &oid, 0, data);
+	}
+	free(namespaced_name);
+}
+
+static int fetch_ref(int stateless_rpc)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	static const char *argv[] = {
+		"upload-pack", ".", NULL, NULL
+	};
+	struct handle_want_data handle_want_data = {0, 0, STRING_LIST_INIT_DUP};
+
+	char *line;
+	int size;
+
+	int upload_pack_will_respond = 0;
+	int wanted_refs_sent = 0;
+
+	if (stateless_rpc)
+		argv[2] = "--stateless-rpc";
+	cmd.argv = argv;
+	cmd.git_cmd = 1;
+	cmd.in = -1;
+	cmd.out = -1;
+
+	if (start_command(&cmd))
+		goto error;
+
+	handle_want_data.upload_pack_in_fd = cmd.in;
+
+	if (!stateless_rpc) {
+		/* Drain the initial ref advertisement (until flush-pkt). */
+		while (packet_read_line(cmd.out, NULL))
+			;
+	}
+
+	/* Send the wants. Upload-pack will not respond to this unless a depth
+	 * request is made. */
+	while ((line = packet_read_line(0, NULL))) {
+		const char *arg;
+		if (skip_prefix(line, "want ", &arg)) {
+			handle_want(arg, &handle_want_data);
+		} else if (starts_with(line, "shallow ")) {
+			packet_write_fmt(cmd.in, "%s", line);
+		} else if (starts_with(line, "deepen ") ||
+			   starts_with(line, "deepen-since ") ||
+			   starts_with(line, "deepen-not ")) {
+			packet_write_fmt(cmd.in, "%s", line);
+			upload_pack_will_respond = 1;
+		}
+	}
+	packet_flush(cmd.in);
+
+	if (upload_pack_will_respond) {
+		while ((line = packet_read_line(cmd.out, NULL))) {
+			packet_write_fmt(1, "%s", line);
+		}
+		packet_flush(1);
+	}
+
+	/* Continue to copy the conversation. */
+	do {
+		char buffer[LARGE_PACKET_DATA_MAX];
+		char size_buffer[5]; /* 4 bytes + NUL */
+		int done_received = 0;
+		int ready_received = 0;
+		int options = PACKET_READ_CHOMP_NEWLINE;
+
+		while ((line = packet_read_line(0, NULL))) {
+			packet_write_fmt(cmd.in, "%s", line);
+			if (!strcmp(line, "done")) {
+				done_received = 1;
+				/* "done" also marks the end of the request. */
+				goto after_flush;
+			}
+		}
+		packet_flush(cmd.in);
+after_flush:
+		while ((size = packet_read(cmd.out, NULL, NULL, buffer,
+					   sizeof(buffer), options))) {
+			int send_wanted_refs = 0;
+			if (!wanted_refs_sent) {
+				if ((done_received || ready_received) &&
+				    size == strlen("ACK ") + GIT_SHA1_HEXSZ &&
+				    starts_with(buffer, "ACK "))
+					send_wanted_refs = 1;
+				else if (done_received && !strcmp(buffer, "NAK"))
+					send_wanted_refs = 1;
+				else if (size == strlen("ACK  ready") + GIT_SHA1_HEXSZ &&
+					 starts_with(buffer, "ACK ") &&
+					 !strcmp(buffer + strlen("ACK  ") + GIT_SHA1_HEXSZ, "ready"))
+					ready_received = 1;
+			}
+			if (send_wanted_refs) {
+				struct string_list_item *item;
+				for_each_string_list_item(item,
+							  &handle_want_data.sent_namespaced_names) {
+					struct object_id oid;
+					if (read_ref(item->string, oid.hash))
+						die("something happened");
+					packet_write_fmt(1, "wanted %s %s",
+							 oid_to_hex(&oid),
+							 strip_namespace(item->string));
+				}
+				wanted_refs_sent = 1;
+				/* Do not chomp any more characters because
+				 * binary data (packfile) is about to be sent.
+				 */
+				options = 0;
+			}
+			sprintf(size_buffer, "%04x", size + 4);
+			write_or_die(1, size_buffer, 4);
+			write_or_die(1, buffer, size);
+			if (!wanted_refs_sent && !strcmp(buffer, "NAK")) {
+				/* NAK before we send wanted refs marks the end
+				 * of the response. */
+				goto after_flush_2;
+			}
+		}
+		packet_flush(1);
+after_flush_2:
+		;
+	} while (!stateless_rpc && !wanted_refs_sent);
+
+	close(cmd.in);
+	cmd.in = -1;
+	close(cmd.out);
+	cmd.out = -1;
+
+	if (finish_command(&cmd))
+		return -1;
+
+	return 0;
+
+error:
+
+	if (cmd.in >= 0)
+		close(cmd.in);
+	if (cmd.out >= 0)
+		close(cmd.out);
+	return -1;
+}
+
+static int server_endpoint_config(const char *var, const char *value, void *unused)
+{
+	return parse_hide_refs_config(var, value, "uploadpack");
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	int stateless_rpc = 0;
+
+	struct option options[] = {
+		OPT_BOOL(0, "stateless-rpc", &stateless_rpc,
+			 N_("quit after a single request/response exchange")),
+		OPT_END()
+	};
+
+	char *line;
+
+	packet_trace_identity("server-endpoint");
+	check_replace_refs = 0;
+
+	argc = parse_options(argc, argv, NULL, options, server_endpoint_usage, 0);
+
+	if (argc != 1)
+		die("must have 1 arg");
+
+	if (!enter_repo(argv[0], 0))
+		die("does not appear to be a git repository");
+	git_config(server_endpoint_config, NULL);
+
+	line = packet_read_line(0, NULL);
+	if (!strcmp(line, "fetch-refs"))
+		return fetch_ref(stateless_rpc);
+	die("only fetch-refs is supported");
+}
-- 
2.12.2.715.g7642488e1d-goog

