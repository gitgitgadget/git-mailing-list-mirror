Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DABB1F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbeACAUI (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:20:08 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:42603 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbeACAS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:18:58 -0500
Received: by mail-io0-f196.google.com with SMTP id x67so458920ioi.9
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=62OYd96r01J2nloN3/rSpr5Weit3MlY/WhU9OsI66xs=;
        b=DIwupAlm6s6E5o0w3FXHY5heK8DPDhAPyTn1AcXgI3c8lmldWut5wQWQn2AEr2GFHZ
         kPwXzlz0W2SfEB3YzMOPLU2O7bApoxerONCMAjNKgttDVuPjtYIdlqoozQjYuVMYOEN6
         hHUQr96GAyjNdpxpMZ3fD5owRSmGsY35N6vrJ2xviYo9RhZQtjhPRlBsXQQ24YrneRbr
         b7h85Yyhg9yaB7u3C8vwOWLKuRCvD10/cdUvVBkrv9uit4GB4tjPV+nH15/1Bjksercq
         zJ52eumHIafPHSFF+cVudD/Dzrq9ijombvUMJAfgSLwcJL9IKnR+FhDvQNPK3TBY+oBV
         brbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=62OYd96r01J2nloN3/rSpr5Weit3MlY/WhU9OsI66xs=;
        b=ZZr4qjnW/bWqXLhpR8FcrM8s+NN9+2jA6w01M5NIxiaAibc6PDuc2t3KNXNVmmLUJu
         3YerrCb9STf2FcQZbKHfIfhT2oLY6Zla4NVxLl+aGO8NIoLo3C0rq3t5//5BXjUEQGbN
         axW2fwWoyXzO4DGe8fQHSfUvj7u+p03w9RIP2RPQuoXz4d7Ha+SPPohiZXZ2Bp5uoCgN
         mmiE2+HpGg5JERZkpC9Yo+zlWXArI4zsQ2K4h/aDfwnHQP2eKh5bDJnSCTq7CNAxKvvc
         N/623Lb93oNzw4elRPiNI8zY46pvYLcDxr5M8TGTNhcpOebZsAArPQCe4dUInXelZZ5M
         ig0A==
X-Gm-Message-State: AKGB3mLUg5T0gg0TRK/AavD6WIpWwx+xK8qsOeIPNJrTBcHTivO8l+sq
        0fMXQlm6/+FedqZISlGKy6/af5OtAKY=
X-Google-Smtp-Source: ACJfBosINius+ggxWsuqjP1Nz8/nIDm60k1LjXR1BaxrXC4GAvaTI8X0WrqFMF6E5xptHa4HjNse8w==
X-Received: by 10.107.169.149 with SMTP id f21mr43982620ioj.162.1514938737084;
        Tue, 02 Jan 2018 16:18:57 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:18:56 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 11/26] serve: introduce git-serve
Date:   Tue,  2 Jan 2018 16:18:13 -0800
Message-Id: <20180103001828.205012-12-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce git-serve, the base server for protocol version 2.

Protocol version 2 is intended to be a replacement for Git's current
wire protocol.  The intention is that it will be a simpler, less
wasteful protocol which can evolve over time.

Protocol version 2 improves upon version 1 by eliminating the initial
ref advertisement.  In its place a server will export a list of
capabilities and commands which it supports in a capability
advertisement.  A client can then request that a particular command be
executed by providing a number of capabilities and command specific
parameters.  At the completion of a command, a client can request that
another command be executed or can terminate the connection by sending a
flush packet.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 .gitignore                              |   1 +
 Documentation/technical/protocol-v2.txt |  91 ++++++++++++
 Makefile                                |   2 +
 builtin.h                               |   1 +
 builtin/serve.c                         |  30 ++++
 git.c                                   |   1 +
 serve.c                                 | 239 ++++++++++++++++++++++++++++++++
 serve.h                                 |  15 ++
 8 files changed, 380 insertions(+)
 create mode 100644 Documentation/technical/protocol-v2.txt
 create mode 100644 builtin/serve.c
 create mode 100644 serve.c
 create mode 100644 serve.h

diff --git a/.gitignore b/.gitignore
index 833ef3b0b..2d0450c26 100644
--- a/.gitignore
+++ b/.gitignore
@@ -140,6 +140,7 @@
 /git-rm
 /git-send-email
 /git-send-pack
+/git-serve
 /git-sh-i18n
 /git-sh-i18n--envsubst
 /git-sh-setup
diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
new file mode 100644
index 000000000..b87ba3816
--- /dev/null
+++ b/Documentation/technical/protocol-v2.txt
@@ -0,0 +1,91 @@
+ Git Wire Protocol, Version 2
+==============================
+
+This document presents a specification for a version 2 of Git's wire
+protocol.  Protocol v2 will improve upon v1 in the following ways:
+
+  * Instead of multiple service names, multiple commands will be
+    supported by a single service.
+  * Easily extendable as capabilities are moved into their own section
+    of the protocol, no longer being hidden behind a NUL byte and
+    limited by the size of a pkt-line (as there will be a single
+    capability per pkt-line).
+  * Separate out other information hidden behind NUL bytes (e.g. agent
+    string as a capability and symrefs can be requested using 'ls-refs')
+  * Reference advertisement will be omitted unless explicitly requested
+  * ls-refs command to explicitly request some refs
+
+ Detailed Design
+=================
+
+A client can request to speak protocol v2 by sending `version=2` in the
+side-channel `GIT_PROTOCOL` in the initial request to the server.
+
+In protocol v2 communication is command oriented.  When first contacting a
+server a list of capabilities will advertised.  Some of these capabilities
+will be commands which a client can request be executed.  Once a command
+has completed, a client can reuse the connection and request that other
+commands be executed.
+
+ Special Packets
+-----------------
+
+In protocol v2 these special packets will have the following semantics:
+
+  * '0000' Flush Packet (flush-pkt) - indicates the end of a message
+  * '0001' Delimiter Packet (delim-pkt) - separates sections of a message
+
+ Capability Advertisement
+--------------------------
+
+A server which decides to communicate (based on a request from a client)
+using protocol version 2, notifies the client by sending a version string
+in its initial response followed by an advertisement of its capabilities.
+Each capability is a key with an optional value.  Clients must ignore all
+unknown keys.  Semantics of unknown values are left to the definition of
+each key.  Some capabilities will describe commands which can be requested
+to be executed by the client.
+
+    capability-advertisement = protocol-version
+			       capability-list
+			       flush-pkt
+
+    protocol-version = PKT-LINE("version 2" LF)
+    capability-list = *capability
+    capability = PKT-LINE(key[=value] LF)
+
+    key = 1*CHAR
+    value = 1*CHAR
+    CHAR = 1*(ALPHA / DIGIT / "-" / "_")
+
+A client then responds to select the command it wants with any particular
+capabilities or arguments.  There is then an optional section where the
+client can provide any command specific parameters or queries.
+
+    command-request = command
+		      capability-list
+		      (command-args)
+		      flush-pkt
+    command = PKT-LINE("command=" key LF)
+    command-args = delim-pkt
+		   *arg
+    arg = 1*CHAR
+
+The server will then check to ensure that the client's request is
+comprised of a valid command as well as valid capabilities which were
+advertised.  If the request is valid the server will then execute the
+command.
+
+A particular command can last for as many rounds as are required to
+complete the service (multiple for negotiation during fetch or no
+additional trips in the case of ls-refs).
+
+When finished a client should send an empty request of just a flush-pkt to
+terminate the connection.
+
+ Commands in v2
+~~~~~~~~~~~~~~~~
+
+Commands are the core actions that a client wants to perform (fetch, push,
+etc).  Each command will be provided with a list capabilities and
+arguments as requested by a client.
diff --git a/Makefile b/Makefile
index e0740b452..5f3b5fe8b 100644
--- a/Makefile
+++ b/Makefile
@@ -876,6 +876,7 @@ LIB_OBJS += revision.o
 LIB_OBJS += run-command.o
 LIB_OBJS += send-pack.o
 LIB_OBJS += sequencer.o
+LIB_OBJS += serve.o
 LIB_OBJS += server-info.o
 LIB_OBJS += setup.o
 LIB_OBJS += sha1-array.o
@@ -1009,6 +1010,7 @@ BUILTIN_OBJS += builtin/rev-parse.o
 BUILTIN_OBJS += builtin/revert.o
 BUILTIN_OBJS += builtin/rm.o
 BUILTIN_OBJS += builtin/send-pack.o
+BUILTIN_OBJS += builtin/serve.o
 BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-ref.o
diff --git a/builtin.h b/builtin.h
index f332a1257..3f3fdfc28 100644
--- a/builtin.h
+++ b/builtin.h
@@ -215,6 +215,7 @@ extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
 extern int cmd_revert(int argc, const char **argv, const char *prefix);
 extern int cmd_rm(int argc, const char **argv, const char *prefix);
 extern int cmd_send_pack(int argc, const char **argv, const char *prefix);
+extern int cmd_serve(int argc, const char **argv, const char *prefix);
 extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
diff --git a/builtin/serve.c b/builtin/serve.c
new file mode 100644
index 000000000..bb726786a
--- /dev/null
+++ b/builtin/serve.c
@@ -0,0 +1,30 @@
+#include "cache.h"
+#include "builtin.h"
+#include "parse-options.h"
+#include "serve.h"
+
+static char const * const grep_usage[] = {
+	N_("git serve [<options>]"),
+	NULL
+};
+
+int cmd_serve(int argc, const char **argv, const char *prefix)
+{
+	struct serve_options opts = SERVE_OPTIONS_INIT;
+
+	struct option options[] = {
+		OPT_BOOL(0, "stateless-rpc", &opts.stateless_rpc,
+			 N_("quit after a single request/response exchange")),
+		OPT_BOOL(0, "advertise-capabilities", &opts.advertise_capabilities,
+			 N_("exit immediately after advertising capabilities")),
+		OPT_END()
+	};
+
+	/* ignore all unknown cmdline switches for now */
+	argc = parse_options(argc, argv, prefix, options, grep_usage,
+			     PARSE_OPT_KEEP_DASHDASH |
+			     PARSE_OPT_KEEP_UNKNOWN);
+	serve(&opts);
+
+	return 0;
+}
diff --git a/git.c b/git.c
index f71073dc8..f85d682b6 100644
--- a/git.c
+++ b/git.c
@@ -461,6 +461,7 @@ static struct cmd_struct commands[] = {
 	{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
 	{ "rm", cmd_rm, RUN_SETUP },
 	{ "send-pack", cmd_send_pack, RUN_SETUP },
+	{ "serve", cmd_serve, RUN_SETUP },
 	{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
 	{ "show", cmd_show, RUN_SETUP },
 	{ "show-branch", cmd_show_branch, RUN_SETUP },
diff --git a/serve.c b/serve.c
new file mode 100644
index 000000000..da8127775
--- /dev/null
+++ b/serve.c
@@ -0,0 +1,239 @@
+#include "cache.h"
+#include "repository.h"
+#include "config.h"
+#include "pkt-line.h"
+#include "version.h"
+#include "argv-array.h"
+#include "serve.h"
+
+static int always_advertise(struct repository *r,
+			    struct strbuf *value)
+{
+	return 1;
+}
+
+static int agent_advertise(struct repository *r,
+			   struct strbuf *value)
+{
+	if (value)
+		strbuf_addstr(value, git_user_agent_sanitized());
+	return 1;
+}
+
+struct protocol_capability {
+	const char *name; /* capability name */
+
+	/*
+	 * Function queried to see if a capability should be advertised.
+	 * Optionally a value can be specified by adding it to 'value'.
+	 */
+	int (*advertise)(struct repository *r, struct strbuf *value);
+
+	/*
+	 * Function called when a client requests the capability as a command.
+	 * The command request will be provided to the function via 'keys', the
+	 * capabilities requested, and 'args', the command specific parameters.
+	 *
+	 * This field should be NULL for capabilities which are not commands.
+	 */
+	int (*command)(struct repository *r,
+		       struct argv_array *keys,
+		       struct argv_array *args);
+};
+
+static struct protocol_capability capabilities[] = {
+	{ "agent", agent_advertise, NULL },
+	{ "stateless-rpc", always_advertise, NULL },
+};
+
+static void advertise_capabilities(void)
+{
+	struct strbuf capability = STRBUF_INIT;
+	struct strbuf value = STRBUF_INIT;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(capabilities); i++) {
+		struct protocol_capability *c = &capabilities[i];
+
+		if (c->advertise(the_repository, &value)) {
+			strbuf_addstr(&capability, c->name);
+
+			if (value.len) {
+				strbuf_addch(&capability, '=');
+				strbuf_addbuf(&capability, &value);
+			}
+
+			strbuf_addch(&capability, '\n');
+			packet_write(1, capability.buf, capability.len);
+		}
+
+		strbuf_reset(&capability);
+		strbuf_reset(&value);
+	}
+
+	packet_flush(1);
+	strbuf_release(&capability);
+	strbuf_release(&value);
+}
+
+static struct protocol_capability *get_capability(const char *key)
+{
+	int i;
+
+	if (!key)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(capabilities); i++) {
+		struct protocol_capability *c = &capabilities[i];
+		const char *out;
+		if (skip_prefix(key, c->name, &out) && (!*out || *out == '='))
+			return c;
+	}
+
+	return NULL;
+}
+
+static int is_valid_capability(const char *key)
+{
+	const struct protocol_capability *c = get_capability(key);
+
+	return c && c->advertise(the_repository, NULL);
+}
+
+static int is_command(const char *key, struct protocol_capability **command)
+{
+	const char *out;
+
+	if (skip_prefix(key, "command=", &out)) {
+		struct protocol_capability *cmd = get_capability(out);
+
+		if (!cmd || !cmd->advertise(the_repository, NULL) || !cmd->command)
+			die("invalid cmd '%s'", out);
+		if (*command)
+			die("command already requested");
+
+		*command = cmd;
+		return 1;
+	}
+
+	return 0;
+}
+
+int has_capability(const struct argv_array *keys, const char *capability,
+		   const char **value)
+{
+	int i;
+	for (i = 0; i < keys->argc; i++) {
+		const char *out;
+		if (skip_prefix(keys->argv[i], capability, &out) &&
+		    (!*out || *out == '=')) {
+			if (value) {
+				if (*out == '=')
+					out++;
+				*value = out;
+			}
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+#define PROCESS_REQUEST_KEYS 0
+#define PROCESS_REQUEST_ARGS 1
+#define PROCESS_REQUEST_DONE 2
+
+static int process_request(void)
+{
+	int state = PROCESS_REQUEST_KEYS;
+	struct packet_reader reader;
+	struct argv_array keys = ARGV_ARRAY_INIT;
+	struct argv_array args = ARGV_ARRAY_INIT;
+	struct protocol_capability *command = NULL;
+
+	packet_reader_init(&reader, 0, NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE);
+
+	while (state != PROCESS_REQUEST_DONE) {
+		switch (packet_reader_read(&reader)) {
+		case PACKET_READ_EOF:
+			BUG("Should have already died when seeing EOF");
+		case PACKET_READ_NORMAL:
+			break;
+		case PACKET_READ_FLUSH:
+			state = PROCESS_REQUEST_DONE;
+			continue;
+		case PACKET_READ_DELIM:
+			if (state != PROCESS_REQUEST_KEYS)
+				die("protocol error");
+			state = PROCESS_REQUEST_ARGS;
+			/*
+			 * maybe include a check to make sure that a
+			 * command/capabilities were given.
+			 */
+			continue;
+		}
+
+		switch (state) {
+		case PROCESS_REQUEST_KEYS:
+			/* collect request; a sequence of keys and values */
+			if (is_command(reader.line, &command) ||
+			    is_valid_capability(reader.line))
+				argv_array_push(&keys, reader.line);
+			break;
+		case PROCESS_REQUEST_ARGS:
+			/* collect arguments for the requested command */
+			argv_array_push(&args, reader.line);
+			break;
+		case PROCESS_REQUEST_DONE:
+			continue;
+		default:
+			BUG("invalid state");
+		}
+	}
+
+	/*
+	 * If no command and no keys were given then the client wanted to
+	 * terminate the connection.
+	 */
+	if (!keys.argc && !args.argc)
+		return 1;
+
+	if (!command)
+		die("no command requested");
+
+	command->command(the_repository, &keys, &args);
+
+	argv_array_clear(&keys);
+	argv_array_clear(&args);
+	return 0;
+}
+
+/* Main serve loop for protocol version 2 */
+void serve(struct serve_options *options)
+{
+	if (options->advertise_capabilities || !options->stateless_rpc) {
+		/* serve by default supports v2 */
+		packet_write_fmt(1, "version 2\n");
+
+		advertise_capabilities();
+		/*
+		 * If only the list of capabilities was requested exit
+		 * immediately after advertising capabilities
+		 */
+		if (options->advertise_capabilities)
+			return;
+	}
+
+	/*
+	 * If stateless-rpc was requested then exit after
+	 * a single request/response exchange
+	 */
+	if (options->stateless_rpc) {
+		process_request();
+	} else {
+		for (;;)
+			if (process_request())
+				break;
+	}
+}
diff --git a/serve.h b/serve.h
new file mode 100644
index 000000000..fe65ba9f4
--- /dev/null
+++ b/serve.h
@@ -0,0 +1,15 @@
+#ifndef SERVE_H
+#define SERVE_H
+
+struct argv_array;
+extern int has_capability(const struct argv_array *keys, const char *capability,
+			  const char **value);
+
+struct serve_options {
+	unsigned advertise_capabilities;
+	unsigned stateless_rpc;
+};
+#define SERVE_OPTIONS_INIT { 0 }
+extern void serve(struct serve_options *options);
+
+#endif /* SERVE_H */
-- 
2.15.1.620.gb9897f4670-goog

