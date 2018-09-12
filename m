Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84E821F404
	for <e@80x24.org>; Wed, 12 Sep 2018 05:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeILKiu (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 06:38:50 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:56647 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeILKiu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 06:38:50 -0400
Received: by mail-io0-f201.google.com with SMTP id o18-v6so709149ioh.23
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 22:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L5LVJHoAgnqJTAP9InpoukGIymju3Vxaq3r02Q8FMqk=;
        b=SkcyPxnZCDL9P4ku1FURz5Qz1owQQJ/snMlxK7pOyKPYoGO/hphQJXLKViY3bJZIOn
         g4NoXRrQM/F/cGjjI6XU00nQpvIsPNkW+YJhzWFrNjn+ViCGfe+UE16EzE8V+LKjebPX
         0A/1uT99jTwOxVx/EhgwtdGVM9kxWI7062g1JWrQ4Tsdnr61atfKCZf0vU0onBsvua2f
         RcuMWPgP+Uvdk5YDDEh2wlHIZVl6fOfOTL523wBvaD2M6MQ8L7l4rDWA0iGnBU+/+Gt5
         SDTdt/4KAYq14vqv4vi6Y/+o3GHWx/7MrLHB8yntLRBBRWzgfno30v2PRPXeBvV5d5fH
         MgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L5LVJHoAgnqJTAP9InpoukGIymju3Vxaq3r02Q8FMqk=;
        b=Zor7jMGAY5G6tLYyW7LWfqMV0jAkOvFbkzcsNcJs42NtRpkDl0GKmuwwW8TIKlYzu2
         ZG9wMpp/wJjKzrhgv+xFpIOaqDwcPTP8i42vrc+2a+7wO6BKMHZ9kj8Ittt9BLZCR8S8
         1rE6aqCwEs230JALwqM8zcGBfqCiWVo44I+fGfcXXtusOzTzG7kAzfdqWUlnHG470Wxk
         4zpNB4zEsrB/G3lsqMsVMYUQoOlOrDjJCDUX7Hv0YFjrbJqxQacCpW2fmUo2JfDKURZK
         o9OaL4odMb3Ypkx75exzena5Em+1zfdaSh04LOisc67NPe48Zhh8UPqn5IWkM152zeBw
         cT2w==
X-Gm-Message-State: APzg51DOpjRXyTjxZMJXjWCyV/9sKhtaImGrlzgCPIQQhEecBkNTju+Z
        b+BOI9a5bAcu5tAIksAFLVZv8KieQkGOE18MUj7yDvyf3zhCn3zbfEpuWHmY6X4dH6Dbe7kyd1P
        CiQc2NQpdgnfBpKvYl/V4aHTt6NeFqnAg01pyNGKecKB6m/Q6awX3SpXBChAg9Ys=
X-Google-Smtp-Source: ANB0VdZQF5ubhyRSh5E0TYEZJ9xE1qRTCk1gWv+th/kgQpF2hUQFMOQ/EbWKdQR20TOHyQDLgXUvyJFeT7ohAA==
X-Received: by 2002:a24:f902:: with SMTP id l2-v6mr411395ith.4.1536730559523;
 Tue, 11 Sep 2018 22:35:59 -0700 (PDT)
Date:   Tue, 11 Sep 2018 22:35:18 -0700
In-Reply-To: <20180912053519.31085-1-steadmon@google.com>
Message-Id: <20180912053519.31085-3-steadmon@google.com>
Mime-Version: 1.0
References: <20180912053519.31085-1-steadmon@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 2/3] archive: implement protocol v2 archive command
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, gitster@pobox.com, l.s.r@web.de,
        sandals@crustytoothpaste.net, Josh Steadmon <steadmon@google.com>
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

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/archive.c        | 45 +++++++++++++++++++++++++++-------------
 builtin/upload-archive.c | 44 ++++++++++++++++++++++++++++++++++++---
 t/t5000-tar-tree.sh      |  5 +++++
 3 files changed, 77 insertions(+), 17 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index e54fc39ad..73831887d 100644
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
 
+static int do_v2_command_and_cap(int out)
+{
+	packet_write_fmt(out, "command=archive\n");
+	/* Capability list would go here, if we had any. */
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
+	if (version == protocol_v2)
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
-	if (status == PACKET_READ_FLUSH)
-		die(_("git archive: expected ACK/NAK, got a flush packet"));
-	if (strcmp(reader.buffer, "ACK")) {
-		if (starts_with(reader.buffer, "NACK "))
-			die(_("git archive: NACK %s"), reader.buffer + 5);
-		if (starts_with(reader.buffer, "ERR "))
-			die(_("remote error: %s"), reader.buffer + 4);
-		die(_("git archive: protocol error"));
+	if (version == protocol_v0) {
+		status = packet_reader_read(&reader);
+
+		if (status == PACKET_READ_FLUSH)
+			die(_("git archive: expected ACK/NAK, got a flush packet"));
+		if (strcmp(reader.buffer, "ACK")) {
+			if (starts_with(reader.buffer, "NACK "))
+				die(_("git archive: NACK %s"), reader.buffer + 5);
+			if (starts_with(reader.buffer, "ERR "))
+				die(_("remote error: %s"), reader.buffer + 4);
+			die(_("git archive: protocol error"));
+		}
+
+		status = packet_reader_read(&reader);
+		if (status != PACKET_READ_FLUSH)
+			die(_("git archive: expected a flush"));
 	}
 
-	status = packet_reader_read(&reader);
-	if (status != PACKET_READ_FLUSH)
-		die(_("git archive: expected a flush"));
-
 	/* Now, start reading from fd[0] and spit it out to stdout */
 	rv = recv_sideband("archive", fd[0], 1);
 	rv |= transport_disconnect(transport);
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 25d911635..534e8fd56 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -5,6 +5,7 @@
 #include "builtin.h"
 #include "archive.h"
 #include "pkt-line.h"
+#include "protocol.h"
 #include "sideband.h"
 #include "run-command.h"
 #include "argv-array.h"
@@ -73,13 +74,53 @@ static ssize_t process_input(int child_fd, int band)
 	return sz;
 }
 
+static int handle_v2_command_and_cap(void)
+{
+	struct packet_reader reader;
+	enum packet_read_status status;
+
+	packet_reader_init(&reader, 0, NULL, 0, PACKET_READ_CHOMP_NEWLINE);
+
+	packet_write_fmt(1, "version 2\n");
+	/*
+	 * We don't currently send any capabilities, but maybe we could list
+	 * supported archival formats?
+	 */
+	packet_flush(1);
+
+	status = packet_reader_read(&reader);
+	if (status != PACKET_READ_NORMAL ||
+	    strcmp(reader.buffer, "command=archive"))
+		die(_("upload-archive: expected command=archive"));
+	while (status == PACKET_READ_NORMAL) {
+		/* We don't currently expect any client capabilities, but we
+		 * should still read (and ignore) any that happen to get sent.
+		 */
+		status = packet_reader_read(&reader);
+	}
+	if (status != PACKET_READ_DELIM)
+		die(_("upload-archive: expected delim packet"));
+
+	/* Let git-upload-archive--writer handle the arguments. */
+
+	return 0;
+}
+
 int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 {
 	struct child_process writer = { argv };
+	enum protocol_version version = determine_protocol_version_server();
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(upload_archive_usage);
 
+	if (version == protocol_v2)
+		handle_v2_command_and_cap();
+	else {
+		packet_write_fmt(1, "ACK\n");
+		packet_flush(1);
+	}
+
 	/*
 	 * Set up sideband subprocess.
 	 *
@@ -96,9 +137,6 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 		die("upload-archive: %s", strerror(err));
 	}
 
-	packet_write_fmt(1, "ACK\n");
-	packet_flush(1);
-
 	while (1) {
 		struct pollfd pfd[2];
 
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 2a97b27b0..4be74d6e9 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -145,6 +145,11 @@ test_expect_success \
 
 check_tar b
 
+test_expect_success 'protocol v2 for remote' '
+	GIT_PROTOCOL="version=2" git archive --remote=. HEAD >v2_remote.tar
+'
+check_tar v2_remote
+
 test_expect_success 'git archive --prefix=prefix/' '
 	git archive --prefix=prefix/ HEAD >with_prefix.tar
 '
-- 
2.19.0.397.gdd90340f6a-goog

