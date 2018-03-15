Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21C7B1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbeCORcU (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:32:20 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:45605 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752515AbeCORcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:32:16 -0400
Received: by mail-vk0-f74.google.com with SMTP id y20so4594386vkd.12
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=N2ri4KD6HoSZFOKvI7hmlUGUrHVOrkFqP0gy9AA6Ens=;
        b=YgWKHNZH9T8stFM1nowFgaousFLgpha4Y8azWWzWDDsS0tT1vgZCzzOj9GFFcGs4QX
         leytmQCSlLvk4H2U7wjsl7+DhuqygQr4DTPFKdDbmAYs8RxMNGH+kiUaAmU7X4De1wEC
         DYQ1uWaqrh67yIPjcNXPsweHQF7C9NZ8xpmkV+/54jq2Yba41zpxPAoEvi/bMlBuVXzC
         Y3xPy8RdZAil6UWlmRssBXzbpp+05XK/5eSQNSJFei5deZrLYwTSRfR2LFFFqqjbsw0W
         Nsdqm+ES9loS6+42ztswFhfxRCR5g2D15zCOxGxJ5YojmYHy579GPfuDa2kV/UHff7gX
         ZY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=N2ri4KD6HoSZFOKvI7hmlUGUrHVOrkFqP0gy9AA6Ens=;
        b=czAtbC0P7816YiN795mwxzfEhUPk7z4hfRtNPrhzB99e0SvI8QpTj/o/+6Bddxig4A
         GM231TbItj0e3MWfaPe6TGhaZIU99c0dsqPGmKa6lFdU0T/sIKj18mAdESVqREkqtX/2
         IDxDrKegbEdpsflwh5a7JNoOQQzJ7DqC7Cor8v9W9JBMATrtPRXCO88Iet3dPIkXL0/A
         zMPunXvyqz2FxJ1sH8voBL2vfpTEKaA6ny/J8y5Z/iWptrzJ9u4ryMBRP5XSncvSVd2J
         LDT4Nh23CDRFdOJroaV0yiHhWTsMlWVYkMrnreZSRRbjo+oXZzHGiQw5dOU+3k13/HM7
         SOdw==
X-Gm-Message-State: AElRT7FHtyI0kIZpDzx4+o0kak0GK5zkpp+kU3KFckIuG+AV0TjJupAb
        OTEKKc+APyhMgiJgrxv8+uRZBjnJnCpyXaTRXwe1x3g8kr66cX8tP6QCSCF5uyq+rY9j5skrizJ
        PqECb/BStkPnz3P+CWNlSlnjwbc/v4xsKHYvSs+sdV92uX1Jc+mzYLd2PmQ==
X-Google-Smtp-Source: AG47ELvHvigbT6llAKRn9hoEhUAhfvMGvmF1J4Q51PtvFH2UBW5/vTYrnoN6dbSAKFMw2ZeYncszDO2D0+A=
MIME-Version: 1.0
X-Received: by 10.176.37.24 with SMTP id j24mr3733469uan.5.1521135135853; Thu,
 15 Mar 2018 10:32:15 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:19 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-13-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 12/35] serve: introduce git-serve
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
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
 Documentation/Makefile                  |   1 +
 Documentation/technical/protocol-v2.txt | 170 ++++++++++++++++
 Makefile                                |   2 +
 builtin.h                               |   1 +
 builtin/serve.c                         |  30 +++
 git.c                                   |   1 +
 serve.c                                 | 247 ++++++++++++++++++++++++
 serve.h                                 |  15 ++
 t/t5701-git-serve.sh                    |  60 ++++++
 10 files changed, 528 insertions(+)
 create mode 100644 Documentation/technical/protocol-v2.txt
 create mode 100644 builtin/serve.c
 create mode 100644 serve.c
 create mode 100644 serve.h
 create mode 100755 t/t5701-git-serve.sh

diff --git a/.gitignore b/.gitignore
index 833ef3b0b7..2d0450c262 100644
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
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 4ae9ba5c86..b105775acd 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -77,6 +77,7 @@ TECH_DOCS += technical/pack-heuristics
 TECH_DOCS += technical/pack-protocol
 TECH_DOCS += technical/protocol-capabilities
 TECH_DOCS += technical/protocol-common
+TECH_DOCS += technical/protocol-v2
 TECH_DOCS += technical/racy-git
 TECH_DOCS += technical/send-pack-pipeline
 TECH_DOCS += technical/shallow
diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
new file mode 100644
index 0000000000..270b28f364
--- /dev/null
+++ b/Documentation/technical/protocol-v2.txt
@@ -0,0 +1,170 @@
+ Git Wire Protocol, Version 2
+==============================
+
+This document presents a specification for a version 2 of Git's wire
+protocol.  Protocol v2 will improve upon v1 in the following ways:
+
+  * Instead of multiple service names, multiple commands will be
+    supported by a single service
+  * Easily extendable as capabilities are moved into their own section
+    of the protocol, no longer being hidden behind a NUL byte and
+    limited by the size of a pkt-line
+  * Separate out other information hidden behind NUL bytes (e.g. agent
+    string as a capability and symrefs can be requested using 'ls-refs')
+  * Reference advertisement will be omitted unless explicitly requested
+  * ls-refs command to explicitly request some refs
+  * Designed with http and stateless-rpc in mind.  With clear flush
+    semantics the http remote helper can simply act as a proxy
+
+In protocol v2 communication is command oriented.  When first contacting a
+server a list of capabilities will advertised.  Some of these capabilities
+will be commands which a client can request be executed.  Once a command
+has completed, a client can reuse the connection and request that other
+commands be executed.
+
+ Packet-Line Framing
+---------------------
+
+All communication is done using packet-line framing, just as in v1.  See
+`Documentation/technical/pack-protocol.txt` and
+`Documentation/technical/protocol-common.txt` for more information.
+
+In protocol v2 these special packets will have the following semantics:
+
+  * '0000' Flush Packet (flush-pkt) - indicates the end of a message
+  * '0001' Delimiter Packet (delim-pkt) - separates sections of a message
+
+ Initial Client Request
+------------------------
+
+In general a client can request to speak protocol v2 by sending
+`version=2` through the respective side-channel for the transport being
+used which inevitably sets `GIT_PROTOCOL`.  More information can be
+found in `pack-protocol.txt` and `http-protocol.txt`.  In all cases the
+response from the server is the capability advertisement.
+
+ Git Transport
+~~~~~~~~~~~~~~~
+
+When using the git:// transport, you can request to use protocol v2 by
+sending "version=2" as an extra parameter:
+
+   003egit-upload-pack /project.git\0host=myserver.com\0\0version=2\0
+
+ SSH and File Transport
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+When using either the ssh:// or file:// transport, the GIT_PROTOCOL
+environment variable must be set explicitly to include "version=2".
+
+ HTTP Transport
+~~~~~~~~~~~~~~~~
+
+When using the http:// or https:// transport a client makes a "smart"
+info/refs request as described in `http-protocol.txt` and requests that
+v2 be used by supplying "version=2" in the `Git-Protocol` header.
+
+   C: Git-Protocol: version=2
+   C:
+   C: GET $GIT_URL/info/refs?service=git-upload-pack HTTP/1.0
+
+A v2 server would reply:
+
+   S: 200 OK
+   S: <Some headers>
+   S: ...
+   S:
+   S: 000eversion 2\n
+   S: <capability-advertisement>
+
+Subsequent requests are then made directly to the service
+`$GIT_URL/git-upload-pack`. (This works the same for git-receive-pack).
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
+    key = 1*(ALPHA | DIGIT | "-_")
+    value = 1*(ALPHA | DIGIT | " -_.,?\/{}[]()<>!@#$%^&*+=:;")
+
+ Command Request
+-----------------
+
+After receiving the capability advertisement, a client can then issue a
+request to select the command it wants with any particular capabilities
+or arguments.  There is then an optional section where the client can
+provide any command specific parameters or queries.  Only a single
+command can be requested at a time.
+
+    request = empty-request | command-request
+    empty-request = flush-pkt
+    command-request = command
+		      capability-list
+		      [command-args]
+		      flush-pkt
+    command = PKT-LINE("command=" key LF)
+    command-args = delim-pkt
+		   *command-specific-arg
+
+    command-specific-args are packet line framed arguments defined by
+    each individual command.
+
+The server will then check to ensure that the client's request is
+comprised of a valid command as well as valid capabilities which were
+advertised.  If the request is valid the server will then execute the
+command.  A server MUST wait till it has received the client's entire
+request before issuing a response.  The format of the response is
+determined by the command being executed, but in all cases a flush-pkt
+indicates the end of the response.
+
+When a command has finished, and the client has received the entire
+response from the server, a client can either request that another
+command be executed or can terminate the connection.  A client may
+optionally send an empty request consisting of just a flush-pkt to
+indicate that no more requests will be made.
+
+ Capabilities
+--------------
+
+There are two different types of capabilities: normal capabilities,
+which can be used to to convey information or alter the behavior of a
+request, and commands, which are the core actions that a client wants to
+perform (fetch, push, etc).
+
+Protocol version 2 is stateless by default.  This means that all commands
+must only last a single round and be stateless from the perspective of the
+server side, unless the client has requested a capability indicating that
+state should be maintained by the server.  Clients MUST NOT require state
+management on the server side in order to function correctly.  This
+permits simple round-robin load-balancing on the server side, without
+needing to worry about state management.
+
+ agent
+~~~~~~~
+
+The server can advertise the `agent` capability with a value `X` (in the
+form `agent=X`) to notify the client that the server is running version
+`X`.  The client may optionally send its own agent string by including
+the `agent` capability with a value `Y` (in the form `agent=Y`) in its
+request to the server (but it MUST NOT do so if the server did not
+advertise the agent capability). The `X` and `Y` strings may contain any
+printable ASCII characters except space (i.e., the byte range 32 < x <
+127), and are typically of the form "package/version" (e.g.,
+"git/1.8.3.1"). The agent strings are purely informative for statistics
+and debugging purposes, and MUST NOT be used to programmatically assume
+the presence or absence of particular features.
diff --git a/Makefile b/Makefile
index 3b849c0607..18c255428a 100644
--- a/Makefile
+++ b/Makefile
@@ -881,6 +881,7 @@ LIB_OBJS += revision.o
 LIB_OBJS += run-command.o
 LIB_OBJS += send-pack.o
 LIB_OBJS += sequencer.o
+LIB_OBJS += serve.o
 LIB_OBJS += server-info.o
 LIB_OBJS += setup.o
 LIB_OBJS += sha1-array.o
@@ -1014,6 +1015,7 @@ BUILTIN_OBJS += builtin/rev-parse.o
 BUILTIN_OBJS += builtin/revert.o
 BUILTIN_OBJS += builtin/rm.o
 BUILTIN_OBJS += builtin/send-pack.o
+BUILTIN_OBJS += builtin/serve.o
 BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-ref.o
diff --git a/builtin.h b/builtin.h
index f332a12574..3f3fdfc281 100644
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
index 0000000000..d3fd240bb3
--- /dev/null
+++ b/builtin/serve.c
@@ -0,0 +1,30 @@
+#include "cache.h"
+#include "builtin.h"
+#include "parse-options.h"
+#include "serve.h"
+
+static char const * const serve_usage[] = {
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
+	argc = parse_options(argc, argv, prefix, options, serve_usage,
+			     PARSE_OPT_KEEP_DASHDASH |
+			     PARSE_OPT_KEEP_UNKNOWN);
+	serve(&opts);
+
+	return 0;
+}
diff --git a/git.c b/git.c
index f71073dc8d..f85d682b62 100644
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
index 0000000000..7ddcba9003
--- /dev/null
+++ b/serve.c
@@ -0,0 +1,247 @@
+#include "cache.h"
+#include "repository.h"
+#include "config.h"
+#include "pkt-line.h"
+#include "version.h"
+#include "argv-array.h"
+#include "serve.h"
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
+	/*
+	 * The name of the capability.  The server uses this name when
+	 * advertising this capability, and the client uses this name to
+	 * specify this capability.
+	 */
+	const char *name;
+
+	/*
+	 * Function queried to see if a capability should be advertised.
+	 * Optionally a value can be specified by adding it to 'value'.
+	 * If a value is added to 'value', the server will advertise this
+	 * capability as "<name>=<value>" instead of "<name>".
+	 */
+	int (*advertise)(struct repository *r, struct strbuf *value);
+
+	/*
+	 * Function called when a client requests the capability as a command.
+	 * The function will be provided the capabilities requested via 'keys'
+	 * as well as a struct packet_reader 'request' which the command should
+	 * use to read the command specific part of the request.  Every command
+	 * MUST read until a flush packet is seen before sending a response.
+	 *
+	 * This field should be NULL for capabilities which are not commands.
+	 */
+	int (*command)(struct repository *r,
+		       struct argv_array *keys,
+		       struct packet_reader *request);
+};
+
+static struct protocol_capability capabilities[] = {
+	{ "agent", agent_advertise, NULL },
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
+		if (*command)
+			die("command '%s' requested after already requesting command '%s'",
+			    out, (*command)->name);
+		if (!cmd || !cmd->advertise(the_repository, NULL) || !cmd->command)
+			die("invalid command '%s'", out);
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
+enum request_state {
+	PROCESS_REQUEST_KEYS,
+	PROCESS_REQUEST_DONE,
+};
+
+static int process_request(void)
+{
+	enum request_state state = PROCESS_REQUEST_KEYS;
+	struct packet_reader reader;
+	struct argv_array keys = ARGV_ARRAY_INIT;
+	struct protocol_capability *command = NULL;
+
+	packet_reader_init(&reader, 0, NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_GENTLE_ON_EOF);
+
+	/*
+	 * Check to see if the client closed their end before sending another
+	 * request.  If so we can terminate the connection.
+	 */
+	if (packet_reader_peek(&reader) == PACKET_READ_EOF)
+		return 1;
+	reader.options = PACKET_READ_CHOMP_NEWLINE;
+
+	while (state != PROCESS_REQUEST_DONE) {
+		switch (packet_reader_peek(&reader)) {
+		case PACKET_READ_EOF:
+			BUG("Should have already died when seeing EOF");
+		case PACKET_READ_NORMAL:
+			/* collect request; a sequence of keys and values */
+			if (is_command(reader.line, &command) ||
+			    is_valid_capability(reader.line))
+				argv_array_push(&keys, reader.line);
+			else
+				die("unknown capability '%s'", reader.line);
+
+			/* Consume the peeked line */
+			packet_reader_read(&reader);
+			break;
+		case PACKET_READ_FLUSH:
+			/*
+			 * If no command and no keys were given then the client
+			 * wanted to terminate the connection.
+			 */
+			if (!keys.argc)
+				return 1;
+
+			/*
+			 * The flush packet isn't consume here like it is in
+			 * the other parts of this switch statement.  This is
+			 * so that the command can read the flush packet and
+			 * see the end of the request in the same way it would
+			 * if command specific arguments were provided after a
+			 * delim packet.
+			 */
+			state = PROCESS_REQUEST_DONE;
+			break;
+		case PACKET_READ_DELIM:
+			/* Consume the peeked line */
+			packet_reader_read(&reader);
+
+			state = PROCESS_REQUEST_DONE;
+			break;
+		}
+	}
+
+	if (!command)
+		die("no command requested");
+
+	command->command(the_repository, &keys, &reader);
+
+	argv_array_clear(&keys);
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
index 0000000000..fe65ba9f46
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
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
new file mode 100755
index 0000000000..affbad097d
--- /dev/null
+++ b/t/t5701-git-serve.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+
+test_description='test git-serve and server commands'
+
+. ./test-lib.sh
+
+test_expect_success 'test capability advertisement' '
+	cat >expect <<-EOF &&
+	version 2
+	agent=git/$(git version | cut -d" " -f3)
+	0000
+	EOF
+
+	git serve --advertise-capabilities >out &&
+	test-pkt-line unpack <out >actual &&
+	test_cmp actual expect
+'
+
+test_expect_success 'stateless-rpc flag does not list capabilities' '
+	# Empty request
+	test-pkt-line pack >in <<-EOF &&
+	0000
+	EOF
+	git serve --stateless-rpc >out <in &&
+	test_must_be_empty out &&
+
+	# EOF
+	git serve --stateless-rpc >out &&
+	test_must_be_empty out
+'
+
+test_expect_success 'request invalid capability' '
+	test-pkt-line pack >in <<-EOF &&
+	foobar
+	0000
+	EOF
+	test_must_fail git serve --stateless-rpc 2>err <in &&
+	test_i18ngrep "unknown capability" err
+'
+
+test_expect_success 'request with no command' '
+	test-pkt-line pack >in <<-EOF &&
+	agent=git/test
+	0000
+	EOF
+	test_must_fail git serve --stateless-rpc 2>err <in &&
+	test_i18ngrep "no command requested" err
+'
+
+test_expect_success 'request invalid command' '
+	test-pkt-line pack >in <<-EOF &&
+	command=foo
+	agent=git/test
+	0000
+	EOF
+	test_must_fail git serve --stateless-rpc 2>err <in &&
+	test_i18ngrep "invalid command" err
+'
+
+test_done
-- 
2.16.2.804.g6dcf76e118-goog

