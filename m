Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20EF51F453
	for <e@80x24.org>; Thu, 27 Sep 2018 01:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeI0HlY (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 03:41:24 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:51695 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbeI0HlY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 03:41:24 -0400
Received: by mail-it1-f201.google.com with SMTP id 204-v6so6129008itf.1
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 18:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7BMbW1ZLeHMHpsj/3KNM+xvA8r87bDDmqKwRvA27CGE=;
        b=cYaXwmeils33kkvnSQzzKLXwTRB07UCazig3Qg3BZwz/38vpXCuH+oLmX6g9OQBacP
         dmlaGAfYHUsXFxF8zKdeYjBeNXOV8EVTKD+XlQ/svcJkMPWbWaPfHSiTP8mWkj4U5FKm
         g9DlVctBBjm3Gx2Cxm8djKRAgICFnOTbm8ZRxvhr8LY6U0wkO8Sw/wvmSUE7Hm/WRtEY
         10iHA0EPynKR8xWpZxnmhD+xsbmR8h4r9+AsOlAcfT/9us5Ow1hrdSt0HzImpENw5dOm
         ySNJdHqE7Z3rc0Rfu1YYksNrFV/Gif3OaOO0embfdSeZxvUJIcaG6Wz6VqWENEKnKL4F
         ebQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7BMbW1ZLeHMHpsj/3KNM+xvA8r87bDDmqKwRvA27CGE=;
        b=WgflSyYvTNZPcazmYQP/wq/0sJz0ea3jyH+V4sxH4I843xkgSiO4nxwTrOzDV2o2cF
         3mMH5v1n5CuRNJBqyJSL8w4wfvgAHGHy9ryf956hOG36bU4zwJTW4+kKqLW2Xpx6TPYy
         NttkbOg/OMj0MXS4wKOPBlYhweb3jgwqADAjg+iGBAy/vGsBLfwSDScpj8GRHa6Y8qFV
         kvNwLIZVYub6jWT/gghzHCOKNlQ4ez0SJMzpsn0fB8FmwMIqaDDYZIJDInmh+9B6wq7B
         DNCJnkHRAzzTYcB537WPn+jIX5E0czf+7rlvFmDdiWW6qwzJG9rViGwKUNMdz6u+3BAn
         QpOA==
X-Gm-Message-State: ABuFfoi7jzIXa5PXZKrRmBVtlqlxOUOyTGiYzE3zAttFsJaUs2W3y4zC
        ewGEAy0TcWDa8cf6qRS0W+bYb1QJJqM4i8fkIRg6qGGErH/X6Ek3g8kCHxTQOP3HkotPH2LIDyK
        gLBLBBrg5erMECBNf67d35Zb6favgmblysst0SRuVsE5VDB8YpdDmlUvb+qLLii4=
X-Google-Smtp-Source: ACcGV63xUvLNZFS45G3MHO+pivJ+nOrGFgDNr9ltmCmrPH2iGwiyXuQc3wYpJPpNF8/2Sdx3WU3ktJA6mRH9TA==
X-Received: by 2002:a6b:ca84:: with SMTP id a126-v6mr5335329iog.45.1538011540588;
 Wed, 26 Sep 2018 18:25:40 -0700 (PDT)
Date:   Wed, 26 Sep 2018 18:24:54 -0700
In-Reply-To: <20180927012455.234876-1-steadmon@google.com>
Message-Id: <20180927012455.234876-4-steadmon@google.com>
Mime-Version: 1.0
References: <20180912053519.31085-1-steadmon@google.com> <20180927012455.234876-1-steadmon@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v2 3/4] archive: implement protocol v2 archive command
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds a new archive command for protocol v2. The command expects
arguments in the form "argument X" which are passed unmodified to
git-upload-archive--writer.

This command works over the file://, Git, and SSH transports. HTTP
support will be added in a separate patch.

NEEDSWORK: this is not backwards-compatible with older clients that set
GIT_PROTOCOL=version=2 or configure protocol.version=2.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/technical/protocol-v2.txt | 21 +++++++++++-
 builtin/archive.c                       | 45 +++++++++++++++++--------
 builtin/upload-archive.c                | 27 +++++++++++++--
 serve.c                                 |  7 ++++
 t/t5000-tar-tree.sh                     |  7 ++++
 t/t5701-git-serve.sh                    |  1 +
 6 files changed, 90 insertions(+), 18 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 09e4e0273f..6126fc5738 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -77,7 +77,8 @@ A v2 server would reply:
    S: <capability-advertisement>
 
 Subsequent requests are then made directly to the service
-`$GIT_URL/git-upload-pack`. (This works the same for git-receive-pack).
+`$GIT_URL/git-upload-pack`. (This works the same for git-receive-pack or
+git-upload-archive).
 
  Capability Advertisement
 --------------------------
@@ -168,6 +169,24 @@ printable ASCII characters except space (i.e., the byte range 32 < x <
 and debugging purposes, and MUST NOT be used to programmatically assume
 the presence or absence of particular features.
 
+ archive
+~~~~~~~~~
+
+`archive` is the command to request an archive (such as a tarball) from a server
+over v2.
+
+archive takes the following optional arguments:
+
+    argument <arg>
+       This specifies that <arg> should be passed as an argument to the
+       underlying archive writer.  This option can be repeated to pass
+       additional arguments to the archive writer.
+
+See linkgit:git-archive[1] for allowed values of `<arg>`.
+
+The output of archive is a packet-line stream of the resulting archive, with
+error messages transferred over the sideband channel.
+
  ls-refs
 ~~~~~~~~~
 
diff --git a/builtin/archive.c b/builtin/archive.c
index 4eb547c5b7..f91d222677 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -5,9 +5,11 @@
 #include "cache.h"
 #include "builtin.h"
 #include "archive.h"
+#include "connect.h"
 #include "transport.h"
 #include "parse-options.h"
 #include "pkt-line.h"
+#include "protocol.h"
 #include "sideband.h"
 
 static void create_output_file(const char *output_file)
@@ -23,6 +25,13 @@ static void create_output_file(const char *output_file)
 	}
 }
 
+static void do_v2_command_and_cap(int out)
+{
+	packet_write_fmt(out, "command=archive\n");
+	/* Capability list would go here, if we wanted to request any. */
+	packet_delim(out);
+}
+
 static int run_remote_archiver(int argc, const char **argv,
 			       const char *remote, const char *exec,
 			       const char *name_hint)
@@ -32,6 +41,7 @@ static int run_remote_archiver(int argc, const char **argv,
 	struct remote *_remote;
 	struct packet_reader reader;
 	enum packet_read_status status;
+	enum protocol_version version;
 
 	_remote = remote_get(remote);
 	if (!_remote->url[0])
@@ -41,6 +51,11 @@ static int run_remote_archiver(int argc, const char **argv,
 
 	packet_reader_init(&reader, fd[0], NULL, 0, PACKET_READ_CHOMP_NEWLINE);
 
+	version = discover_version(&reader);
+
+	if (version == protocol_v2 && server_supports_v2("archive", 0))
+		do_v2_command_and_cap(fd[1]);
+
 	/*
 	 * Inject a fake --format field at the beginning of the
 	 * arguments, with the format inferred from our output
@@ -56,22 +71,24 @@ static int run_remote_archiver(int argc, const char **argv,
 		packet_write_fmt(fd[1], "argument %s\n", argv[i]);
 	packet_flush(fd[1]);
 
-	status = packet_reader_read(&reader);
-
-	if (status != PACKET_READ_NORMAL || reader.pktlen <= 0)
-		die(_("git archive: expected ACK/NAK, got a flush packet"));
-	if (strcmp(reader.line, "ACK")) {
-		if (starts_with(reader.line, "NACK "))
-			die(_("git archive: NACK %s"), reader.line + 5);
-		if (starts_with(reader.line, "ERR "))
-			die(_("remote error: %s"), reader.line + 4);
-		die(_("git archive: protocol error"));
+	if (version == protocol_v0) {
+		status = packet_reader_read(&reader);
+
+		if (status != PACKET_READ_NORMAL || reader.pktlen <= 0)
+			die(_("git archive: expected ACK/NAK, got a flush packet"));
+		if (strcmp(reader.line, "ACK")) {
+			if (starts_with(reader.line, "NACK "))
+				die(_("git archive: NACK %s"), reader.line + 5);
+			if (starts_with(reader.line, "ERR "))
+				die(_("remote error: %s"), reader.line + 4);
+			die(_("git archive: protocol error"));
+		}
+
+		status = packet_reader_read(&reader);
+		if (status == PACKET_READ_NORMAL && reader.pktlen > 0)
+			die(_("git archive: expected a flush"));
 	}
 
-	status = packet_reader_read(&reader);
-	if (status == PACKET_READ_NORMAL && reader.pktlen > 0)
-		die(_("git archive: expected a flush"));
-
 	/* Now, start reading from fd[0] and spit it out to stdout */
 	rv = recv_sideband("archive", fd[0], 1);
 	rv |= transport_disconnect(transport);
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 25d9116356..b8a8fb256f 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -5,6 +5,8 @@
 #include "builtin.h"
 #include "archive.h"
 #include "pkt-line.h"
+#include "protocol.h"
+#include "serve.h"
 #include "sideband.h"
 #include "run-command.h"
 #include "argv-array.h"
@@ -76,10 +78,24 @@ static ssize_t process_input(int child_fd, int band)
 int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 {
 	struct child_process writer = { argv };
+	enum protocol_version version = determine_protocol_version_server();
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(upload_archive_usage);
 
+	if (version == protocol_v2) {
+		struct serve_options options = SERVE_OPTIONS_INIT;
+
+		/* Send "version 2" message and capabilities. */
+		options.advertise_capabilities = 1;
+		serve(&options);
+
+		/* Process command request and validate client capabilities. */
+		options.advertise_capabilities = 0;
+		options.stateless_rpc = 1;
+		serve(&options);
+	}
+
 	/*
 	 * Set up sideband subprocess.
 	 *
@@ -92,12 +108,17 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 	writer.git_cmd = 1;
 	if (start_command(&writer)) {
 		int err = errno;
-		packet_write_fmt(1, "NACK unable to spawn subprocess\n");
+		if (version == protocol_v0 || version == protocol_v1)
+			packet_write_fmt(1, "NACK unable to spawn subprocess\n");
+		else if (version == protocol_v2)
+			error_clnt("unable to spawn subprocess\n");
 		die("upload-archive: %s", strerror(err));
 	}
 
-	packet_write_fmt(1, "ACK\n");
-	packet_flush(1);
+	if (version == protocol_v0 || version == protocol_v1) {
+		packet_write_fmt(1, "ACK\n");
+		packet_flush(1);
+	}
 
 	while (1) {
 		struct pollfd pfd[2];
diff --git a/serve.c b/serve.c
index bda085f09c..cef575086f 100644
--- a/serve.c
+++ b/serve.c
@@ -52,8 +52,15 @@ struct protocol_capability {
 		       struct packet_reader *request);
 };
 
+static int noop(struct repository *r, struct argv_array *keys,
+		struct packet_reader *request)
+{
+	return 0;
+}
+
 static struct protocol_capability capabilities[] = {
 	{ "agent", agent_advertise, NULL },
+	{ "archive", always_advertise, noop },
 	{ "ls-refs", always_advertise, ls_refs },
 	{ "fetch", upload_pack_advertise, upload_pack_v2 },
 	{ "server-option", always_advertise, NULL },
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index c408e3a23d..4a76354021 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -138,6 +138,13 @@ test_expect_success \
 
 test_expect_success 'extract archive' 'check_tar b'
 
+test_expect_success 'protocol v2 for remote' '
+	GIT_PROTOCOL="version=2" GIT_TRACE_PACKET="$(pwd)/log" git archive \
+		--remote=. HEAD >v2_remote.tar &&
+	grep "version 2" log
+'
+test_expect_success 'extract v2 archive' 'check_tar v2_remote'
+
 test_expect_success 'git archive --prefix=prefix/' '
 	git archive --prefix=prefix/ HEAD >with_prefix.tar
 '
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 75ec79e6cb..f47a14660b 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -8,6 +8,7 @@ test_expect_success 'test capability advertisement' '
 	cat >expect <<-EOF &&
 	version 2
 	agent=git/$(git version | cut -d" " -f3)
+	archive
 	ls-refs
 	fetch=shallow
 	server-option
-- 
2.19.0.605.g01d371f741-goog

