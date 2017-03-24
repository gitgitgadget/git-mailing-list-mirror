Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C8681FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 15:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965989AbdCXP1w (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 11:27:52 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35795 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965508AbdCXP1o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 11:27:44 -0400
Received: by mail-qk0-f193.google.com with SMTP id o135so852455qke.2
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3U9f1jAC4LSmBm7uNRMkLhx5/B4qU8s7tYOVzKM7uGg=;
        b=eoIyP3Ye2BKbgOA2r+wx8E/7/4uZNneAGOVDrpIgIMoC0/lYKeBTY12vKSctte15xl
         IuSJr2BFqgsHiWix/E5imdns5+HkLWzRyvAmqG+FkEDZD5ZfUVAyoK32nL7mHoLTZu8X
         ZF3iyoz60wuhyiRn1igWoo8ipB8QWzw4SQXmb3Rxkbqb2vwvbYVDKpG6ki3iZDn3eJxd
         HtcEMawm5XshekH1XaolK9i7+jSEhrh/Txj0aVPSkdsLVDzA6stSCwteSAbO439ycSsU
         G/ZuAEyzQZecyqKi1hTw4ytxlXJVVFsTurFnGx4SI2ahLQWWAWST+6Cnvggc6QeYCe2x
         6vRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3U9f1jAC4LSmBm7uNRMkLhx5/B4qU8s7tYOVzKM7uGg=;
        b=rZvc88DK+CZr7pSWhoTpOwMuWgxOFrSoFkrJq0CFMdXKPkyV1sDCCTIXFQqkzWoO63
         9+4YqcS0F/amYBYeNUVir7zDRRcBmg3PeiTpNGyenEirltrnUK5oIc4aKTuRSu9i1IB8
         BEVghP104K7RtGPLdKXAEwHWM48YhmnnhcFNsYe6qb0iM2+OoCjGo+wMyqNckcVR2AmQ
         fT2+EBs7Ezas8mEF9+8/ZIrAjjcoWNEzs9d7U1uvSg20Fk8+iBelUsIoGCTIIOfy+Of8
         Tcr5xX6TaLS7OgEuEmrOB4BP9bbOscNUx2XSEknk3s+dXe6hWm2ypkEKWdDRUTbdPy/G
         iHkg==
X-Gm-Message-State: AFeK/H0isEcAxkgsY9xqf33eV6xQDnYRkOf6/KWlhc/DuziYsNhYS1X2yHJJWgo+3E0IVw==
X-Received: by 10.55.163.215 with SMTP id m206mr7612065qke.243.1490369262458;
        Fri, 24 Mar 2017 08:27:42 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id d23sm1717589qta.32.2017.03.24.08.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 08:27:42 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com, christian.couder@gmail.com,
        larsxschneider@gmail.com
Subject: [PATCH v2 2/2] sub-process: refactor the filter process code into a reusable module
Date:   Fri, 24 Mar 2017 11:27:23 -0400
Message-Id: <20170324152726.14632-4-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.gvfs.1.43.g876ba2a
In-Reply-To: <20170324152726.14632-1-benpeart@microsoft.com>
References: <20170324152726.14632-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the filter.<driver>.process code into a separate sub-process
module that can be used to reduce the cost of starting up a sub-process
for multiple commands.  It does this by keeping the external process
running and processing all commands by communicating over standard input
and standard output using the packet format (pkt-line) based protocol.
Full documentation is in Documentation/technical/api-sub-process.txt.

This code is refactored from:

	Commit edcc85814c ("convert: add filter.<driver>.process option", 2016-10-16)
	keeps the external process running and processes all commands

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/technical/api-sub-process.txt |  54 ++++++++++
 Makefile                                    |   1 +
 convert.c                                   | 160 ++++++----------------------
 sub-process.c                               | 117 ++++++++++++++++++++
 sub-process.h                               |  46 ++++++++
 5 files changed, 248 insertions(+), 130 deletions(-)
 create mode 100644 Documentation/technical/api-sub-process.txt
 create mode 100644 sub-process.c
 create mode 100644 sub-process.h

diff --git a/Documentation/technical/api-sub-process.txt b/Documentation/technical/api-sub-process.txt
new file mode 100644
index 0000000000..eb5005aa72
--- /dev/null
+++ b/Documentation/technical/api-sub-process.txt
@@ -0,0 +1,54 @@
+sub-process API
+===============
+
+The sub-process API makes it possible to run background sub-processes
+that should run until the git command exits and communicate with it
+through stdin and stdout.  This reduces the overhead of having to fork
+a new process each time it needs to be communicated with.
+
+The sub-processes are kept in a hashmap by command name and looked up
+via the subprocess_find_entry function.  If an existing instance can not
+be found then a new process should be created and started.  When the
+parent git command terminates, all sub-processes are also terminated.
+
+This API is based on the run-command API.
+
+Data structures
+---------------
+
+* `struct subprocess_entry`
+
+The sub-process structure.  Members should not be accessed directly.
+
+Types
+-----
+
+'int(*subprocess_start_fn)(struct subprocess_entry *entry)'::
+
+	User-supplied function to initialize the sub-process.  This is
+	typically used to negoiate the interface version and capabilities.
+
+
+Functions
+---------
+
+`subprocess_start`::
+
+	Start a subprocess and add it to the subprocess hashmap.
+
+`subprocess_stop`::
+
+	Kill a subprocess and remove it from the subprocess hashmap.
+
+`subprocess_find_entry`::
+
+	Find a subprocess in the subprocess hashmap.
+
+`subprocess_get_child_process`::
+
+	Get the underlying `struct child_process` from a subprocess.
+
+`subprocess_read_status`::
+
+	Helper function to read packets looking for the last "status=<foo>"
+	key/value pair.
diff --git a/Makefile b/Makefile
index a5a11e721a..8afe733092 100644
--- a/Makefile
+++ b/Makefile
@@ -830,6 +830,7 @@ LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
 LIB_OBJS += submodule.o
 LIB_OBJS += submodule-config.o
+LIB_OBJS += sub-process.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += tempfile.o
diff --git a/convert.c b/convert.c
index 8d652bf27c..565a1d0d8c 100644
--- a/convert.c
+++ b/convert.c
@@ -4,6 +4,7 @@
 #include "quote.h"
 #include "sigchain.h"
 #include "pkt-line.h"
+#include "sub-process.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -497,132 +498,30 @@ static int apply_single_file_filter(const char *path, const char *src, size_t le
 #define CAP_SMUDGE   (1u<<1)
 
 struct cmd2process {
-	struct hashmap_entry ent; /* must be the first member! */
+	struct subprocess_entry subprocess;
 	unsigned int supported_capabilities;
-	const char *cmd;
-	struct child_process process;
 };
 
-static int cmd_process_map_initialized;
-static struct hashmap cmd_process_map;
-
-static int cmd2process_cmp(const struct cmd2process *e1,
-			   const struct cmd2process *e2,
-			   const void *unused)
+static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 {
-	return strcmp(e1->cmd, e2->cmd);
-}
-
-static struct cmd2process *find_multi_file_filter_entry(struct hashmap *hashmap, const char *cmd)
-{
-	struct cmd2process key;
-	hashmap_entry_init(&key, strhash(cmd));
-	key.cmd = cmd;
-	return hashmap_get(hashmap, &key, NULL);
-}
-
-static int packet_write_list(int fd, const char *line, ...)
-{
-	va_list args;
 	int err;
-	va_start(args, line);
-	for (;;) {
-		if (!line)
-			break;
-		if (strlen(line) > LARGE_PACKET_DATA_MAX)
-			return -1;
-		err = packet_write_fmt_gently(fd, "%s\n", line);
-		if (err)
-			return err;
-		line = va_arg(args, const char*);
-	}
-	va_end(args);
-	return packet_flush_gently(fd);
-}
-
-static void read_multi_file_filter_status(int fd, struct strbuf *status)
-{
-	struct strbuf **pair;
-	char *line;
-	for (;;) {
-		line = packet_read_line(fd, NULL);
-		if (!line)
-			break;
-		pair = strbuf_split_str(line, '=', 2);
-		if (pair[0] && pair[0]->len && pair[1]) {
-			/* the last "status=<foo>" line wins */
-			if (!strcmp(pair[0]->buf, "status=")) {
-				strbuf_reset(status);
-				strbuf_addbuf(status, pair[1]);
-			}
-		}
-		strbuf_list_free(pair);
-	}
-}
-
-static void kill_multi_file_filter(struct hashmap *hashmap, struct cmd2process *entry)
-{
-	if (!entry)
-		return;
-
-	entry->process.clean_on_exit = 0;
-	kill(entry->process.pid, SIGTERM);
-	finish_command(&entry->process);
-
-	hashmap_remove(hashmap, entry, NULL);
-	free(entry);
-}
-
-static void stop_multi_file_filter(struct child_process *process)
-{
-	sigchain_push(SIGPIPE, SIG_IGN);
-	/* Closing the pipe signals the filter to initiate a shutdown. */
-	close(process->in);
-	close(process->out);
-	sigchain_pop(SIGPIPE);
-	/* Finish command will wait until the shutdown is complete. */
-	finish_command(process);
-}
-
-static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, const char *cmd)
-{
-	int err;
-	struct cmd2process *entry;
+	struct cmd2process *entry = (struct cmd2process *)subprocess;
 	struct child_process *process;
-	const char *argv[] = { cmd, NULL };
 	struct string_list cap_list = STRING_LIST_INIT_NODUP;
 	char *cap_buf;
 	const char *cap_name;
 
-	entry = xmalloc(sizeof(*entry));
-	entry->cmd = cmd;
-	entry->supported_capabilities = 0;
-	process = &entry->process;
-
-	child_process_init(process);
-	process->argv = argv;
-	process->use_shell = 1;
-	process->in = -1;
-	process->out = -1;
-	process->clean_on_exit = 1;
-	process->clean_on_exit_handler = stop_multi_file_filter;
-
-	if (start_command(process)) {
-		error("cannot fork to run external filter '%s'", cmd);
-		return NULL;
-	}
-
-	hashmap_entry_init(entry, strhash(cmd));
+	process = subprocess_get_child_process(&entry->subprocess);
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
-	err = packet_write_list(process->in, "git-filter-client", "version=2", NULL);
+	err = packet_writel(process->in, "git-filter-client", "version=2", NULL);
 	if (err)
 		goto done;
 
 	err = strcmp(packet_read_line(process->out, NULL), "git-filter-server");
 	if (err) {
-		error("external filter '%s' does not support filter protocol version 2", cmd);
+		error("external filter '%s' does not support filter protocol version 2", subprocess->cmd);
 		goto done;
 	}
 	err = strcmp(packet_read_line(process->out, NULL), "version=2");
@@ -632,7 +531,7 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	if (err)
 		goto done;
 
-	err = packet_write_list(process->in, "capability=clean", "capability=smudge", NULL);
+	err = packet_writel(process->in, "capability=clean", "capability=smudge", NULL);
 
 	for (;;) {
 		cap_buf = packet_read_line(process->out, NULL);
@@ -651,7 +550,7 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 		} else {
 			warning(
 				"external filter '%s' requested unsupported filter capability '%s'",
-				cmd, cap_name
+				subprocess->cmd, cap_name
 			);
 		}
 
@@ -661,14 +560,10 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 done:
 	sigchain_pop(SIGPIPE);
 
-	if (err || errno == EPIPE) {
-		error("initialization for external filter '%s' failed", cmd);
-		kill_multi_file_filter(hashmap, entry);
-		return NULL;
-	}
+	if (err || errno == EPIPE)
+		err = err ? err : errno;
 
-	hashmap_add(hashmap, entry);
-	return entry;
+	return err;
 }
 
 static int apply_multi_file_filter(const char *path, const char *src, size_t len,
@@ -682,22 +577,20 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	struct strbuf filter_status = STRBUF_INIT;
 	const char *filter_type;
 
-	if (!cmd_process_map_initialized) {
-		cmd_process_map_initialized = 1;
-		hashmap_init(&cmd_process_map, (hashmap_cmp_fn) cmd2process_cmp, 0);
-		entry = NULL;
-	} else {
-		entry = find_multi_file_filter_entry(&cmd_process_map, cmd);
-	}
+	entry = (struct cmd2process *)subprocess_find_entry(cmd);
 
 	fflush(NULL);
 
 	if (!entry) {
-		entry = start_multi_file_filter(&cmd_process_map, cmd);
-		if (!entry)
+		entry = xmalloc(sizeof(*entry));
+		entry->supported_capabilities = 0;
+
+		if (subprocess_start(&entry->subprocess, cmd, start_multi_file_filter_fn)) {
+			free(entry);
 			return 0;
+		}
 	}
-	process = &entry->process;
+	process = subprocess_get_child_process(&entry->subprocess);
 
 	if (!(wanted_capability & entry->supported_capabilities))
 		return 0;
@@ -737,7 +630,10 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	if (err)
 		goto done;
 
-	read_multi_file_filter_status(process->out, &filter_status);
+	err = subprocess_read_status(process->out, &filter_status);
+	if (err)
+		goto done;
+
 	err = strcmp(filter_status.buf, "success");
 	if (err)
 		goto done;
@@ -746,7 +642,10 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	if (err)
 		goto done;
 
-	read_multi_file_filter_status(process->out, &filter_status);
+	err = subprocess_read_status(process->out, &filter_status);
+	if (err)
+		goto done;
+
 	err = strcmp(filter_status.buf, "success");
 
 done:
@@ -768,7 +667,8 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 			 * Force shutdown and restart if another blob requires filtering.
 			 */
 			error("external filter '%s' failed", cmd);
-			kill_multi_file_filter(&cmd_process_map, entry);
+			subprocess_stop((struct subprocess_entry *)entry);
+			free(entry);
 		}
 	} else {
 		strbuf_swap(dst, &nbuf);
diff --git a/sub-process.c b/sub-process.c
new file mode 100644
index 0000000000..5a06a9fd1e
--- /dev/null
+++ b/sub-process.c
@@ -0,0 +1,117 @@
+/*
+ * Generic implementation of background process infrastructure.
+ */
+#include "sub-process.h"
+#include "sigchain.h"
+#include "pkt-line.h"
+
+static int subprocess_map_initialized;
+static struct hashmap subprocess_map;
+
+static int name2process_cmp(const struct subprocess_entry *e1,
+		const struct subprocess_entry *e2, const void *unused)
+{
+	return strcmp(e1->cmd, e2->cmd);
+}
+
+static void subprocess_exit_handler(struct child_process *process)
+{
+	sigchain_push(SIGPIPE, SIG_IGN);
+	/* Closing the pipe signals the filter to initiate a shutdown. */
+	close(process->in);
+	close(process->out);
+	sigchain_pop(SIGPIPE);
+	/* Finish command will wait until the shutdown is complete. */
+	finish_command(process);
+}
+
+int subprocess_start(struct subprocess_entry *entry, const char *cmd,
+		subprocess_start_fn startfn)
+{
+	int err;
+	const char *argv[] = { cmd, NULL };
+
+	if (!subprocess_map_initialized) {
+		hashmap_init(&subprocess_map, (hashmap_cmp_fn)name2process_cmp, 0);
+		subprocess_map_initialized = 1;
+	}
+
+	entry->cmd = cmd;
+
+	child_process_init(&entry->process);
+	entry->process.argv = argv;
+	entry->process.use_shell = 1;
+	entry->process.in = -1;
+	entry->process.out = -1;
+	entry->process.clean_on_exit = 1;
+	entry->process.clean_on_exit_handler = subprocess_exit_handler;
+
+	err = start_command(&entry->process);
+	if (err) {
+		error("cannot fork to run sub-process '%s'", entry->cmd);
+		return err;
+	}
+
+	err = startfn(entry);
+	if (err) {
+		error("initialization for sub-process '%s' failed", entry->cmd);
+		subprocess_stop(entry);
+		return err;
+	}
+
+	hashmap_entry_init(entry, strhash(entry->cmd));
+	hashmap_add(&subprocess_map, entry);
+
+	return 0;
+}
+
+void subprocess_stop(struct subprocess_entry *entry)
+{
+	if (!entry)
+		return;
+
+	entry->process.clean_on_exit = 0;
+	kill(entry->process.pid, SIGTERM);
+	finish_command(&entry->process);
+
+	hashmap_remove(&subprocess_map, entry, NULL);
+}
+
+struct subprocess_entry *subprocess_find_entry(const char *cmd)
+{
+	struct subprocess_entry key;
+
+	if (!subprocess_map_initialized) {
+		hashmap_init(&subprocess_map, (hashmap_cmp_fn)name2process_cmp, 0);
+		subprocess_map_initialized = 1;
+		return NULL;
+	}
+
+	hashmap_entry_init(&key, strhash(cmd));
+	key.cmd = cmd;
+	return hashmap_get(&subprocess_map, &key, NULL);
+}
+
+int subprocess_read_status(int fd, struct strbuf *status)
+{
+	struct strbuf **pair;
+	char *line;
+	int len;
+
+	for (;;) {
+		len = packet_read_line_gently(fd, NULL, &line);
+		if ((len == -1) || !line)
+			break;
+		pair = strbuf_split_str(line, '=', 2);
+		if (pair[0] && pair[0]->len && pair[1]) {
+			/* the last "status=<foo>" line wins */
+			if (!strcmp(pair[0]->buf, "status=")) {
+				strbuf_reset(status);
+				strbuf_addbuf(status, pair[1]);
+			}
+		}
+		strbuf_list_free(pair);
+	}
+
+	return len == -1 ? len : 0;
+}
diff --git a/sub-process.h b/sub-process.h
new file mode 100644
index 0000000000..d1492f476d
--- /dev/null
+++ b/sub-process.h
@@ -0,0 +1,46 @@
+#ifndef SUBPROCESS_H
+#define SUBPROCESS_H
+
+#include "git-compat-util.h"
+#include "hashmap.h"
+#include "run-command.h"
+
+/*
+ * Generic implementation of background process infrastructure.
+ * See Documentation/technical/api-background-process.txt.
+ */
+
+ /* data structures */
+
+struct subprocess_entry {
+	struct hashmap_entry ent; /* must be the first member! */
+	struct child_process process;
+	const char *cmd;
+};
+
+/* subprocess functions */
+
+typedef int(*subprocess_start_fn)(struct subprocess_entry *entry);
+int subprocess_start(struct subprocess_entry *entry, const char *cmd,
+		subprocess_start_fn startfn);
+
+void subprocess_stop(struct subprocess_entry *entry);
+
+struct subprocess_entry *subprocess_find_entry(const char *cmd);
+
+/* subprocess helper functions */
+
+static inline struct child_process *subprocess_get_child_process(
+		struct subprocess_entry *entry)
+{
+	return &entry->process;
+}
+
+/*
+ * Helper function that will read packets looking for "status=<foo>"
+ * key/value pairs and return the value from the last "status" packet
+ */
+
+int subprocess_read_status(int fd, struct strbuf *status);
+
+#endif
-- 
2.12.0.gvfs.1.43.g876ba2a

