Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A884C25B06
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 01:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiHOBHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 21:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiHOBHE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 21:07:04 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06D011C28
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 18:07:02 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id q14so3053717vke.9
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 18:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=H0r8quyFTiIIC7aY/Dxgri8w0EKzVzGOM1r1GFtTMJo=;
        b=ci44hjy7orRE+zmmOQkjmlabZiEZfcFYBajWJf2wTTRPFDhMB/IDEOPJToj2yzsbkC
         7+/IXYUoJUcZjiOEOvHiXLMdd7/lbiYClmW3F3lKPFJklTpVKbL9UNfJfiwxSxqYUeOM
         G9Dy5MByM99gGQD2mTmc0iXCQ4YKj5VKGrVGNTxvxXhA03N5q347YtXtwO5wUU+O6Hy2
         w9vHFHK2TzZUhHq2hTP0p39Prl0VlsA8apO0ber3kjkxYp+hkcARcY4E+4dWPUbfN4M2
         CJ65C3uzSoea/fu11hhTsNaTqwTIu3XOToUcg6jTSbDLRAm9YbQS+r0J4zUdkWMaPdMM
         bpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=H0r8quyFTiIIC7aY/Dxgri8w0EKzVzGOM1r1GFtTMJo=;
        b=yInRIuD1FXUwfvlEPj39pPvAO194alkcJPqq7BMnsxV0+5fMJYpON1pmIhi1hVZ/4A
         y5gsnQjIbkr3f3pLf5z8/lj1G0aram+egVieO/3YNfT4S/6gN+NSwGcnt29R10Sc0MGQ
         0SN6YYRSKZpRuC+lyaC927a1xZ09l4KANuCelWuiDSsHUaemm6OOa7Xvzf36h3jAJ+d3
         Mom2EKfXLuhK18xWKcmGOMUIfT9AmdlW8bIH2EKR7cImHo2JufQ63y+fsjOydHPx7ub6
         z6I/obQKjv5yC8hEbAtmggPxyhSdBXRHEznpDmvcSj7LTid2fqxK7uzFdYDwBmKcHEtS
         W5VA==
X-Gm-Message-State: ACgBeo3mSGuNRZ8W1NCbNjgj5ALFp15QiJFjj0yNtPokyN7qM6POepUl
        xY3iKXFRLsMCI1z3LQ0JKc2IBD9scC/gzw==
X-Google-Smtp-Source: AA6agR6+P7I4BksYoGFMnxm9VJ7T3FHNYVIMq9arQavyEVXX16rwwwNNQ98stYx9ArL/zZSjMSwE3Q==
X-Received: by 2002:a1f:2f8e:0:b0:37c:ed7e:41a7 with SMTP id v136-20020a1f2f8e000000b0037ced7e41a7mr5611679vkv.6.1660525621298;
        Sun, 14 Aug 2022 18:07:01 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id d66-20020a1f9b45000000b003791113188csm5943133vke.55.2022.08.14.18.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 18:07:00 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, johannes.schindelin@gmx.de,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v4 2/3] t0021: implementation the rot13-filter.pl script in C
Date:   Sun, 14 Aug 2022 22:06:37 -0300
Message-Id: <99d8458f35e5ed8dbb696a3f1f27e1704d17de38.1660522524.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660522524.git.matheus.bernardino@usp.br>
References: <cover.1660522524.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This script is currently used by three test files: t0021-conversion.sh,
t2080-parallel-checkout-basics.sh, and
t2082-parallel-checkout-attributes.sh. To avoid the need for the PERL
dependency at these tests, let's convert the script to a C test-tool
command. The following commit will take care of actually modifying the
said tests to use the new C helper and removing the Perl script.

The Perl script flushes the log file handler after each write. As
commented in [1], this seems to be an early design decision that was
later reconsidered, but possibly ended up being left in the code by
accident:

	>> +$debug->flush();
	>
	> Isn't $debug flushed automatically?

	Maybe, but autoflush is not explicitly enabled. I will
	enable it again (I disabled it because of Eric's comment
	but I re-read the comment and he is only talking about
	pipes).

Anyways, this behavior is not really needed for the tests and the
flush() calls make the code slightly larger, so let's avoid them
altogether in the new C version.

[1]: https://lore.kernel.org/git/7F1F1A0E-8FC3-4FBD-81AA-37786DE0EF50@gmail.com/

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Makefile                     |   1 +
 pkt-line.c                   |   5 +-
 pkt-line.h                   |   8 +-
 t/helper/test-rot13-filter.c | 382 +++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c         |   1 +
 t/helper/test-tool.h         |   1 +
 6 files changed, 396 insertions(+), 2 deletions(-)
 create mode 100644 t/helper/test-rot13-filter.c

diff --git a/Makefile b/Makefile
index 2ec9b2dc6b..ae7def7c66 100644
--- a/Makefile
+++ b/Makefile
@@ -772,6 +772,7 @@ TEST_BUILTINS_OBJS += test-read-midx.o
 TEST_BUILTINS_OBJS += test-ref-store.o
 TEST_BUILTINS_OBJS += test-reftable.o
 TEST_BUILTINS_OBJS += test-regex.o
+TEST_BUILTINS_OBJS += test-rot13-filter.o
 TEST_BUILTINS_OBJS += test-repository.o
 TEST_BUILTINS_OBJS += test-revision-walking.o
 TEST_BUILTINS_OBJS += test-run-command.o
diff --git a/pkt-line.c b/pkt-line.c
index 8e43c2def4..ce4e73b683 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -309,7 +309,8 @@ int write_packetized_from_fd_no_flush(int fd_in, int fd_out)
 	return err;
 }
 
-int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_out)
+int write_packetized_from_buf_no_flush_count(const char *src_in, size_t len,
+					     int fd_out, int *packet_counter)
 {
 	int err = 0;
 	size_t bytes_written = 0;
@@ -324,6 +325,8 @@ int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_ou
 			break;
 		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write);
 		bytes_written += bytes_to_write;
+		if (packet_counter)
+			(*packet_counter)++;
 	}
 	return err;
 }
diff --git a/pkt-line.h b/pkt-line.h
index 1f623de60a..79c538b99e 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -32,7 +32,13 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((f
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int write_packetized_from_fd_no_flush(int fd_in, int fd_out);
-int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_out);
+int write_packetized_from_buf_no_flush_count(const char *src_in, size_t len,
+					     int fd_out, int *packet_counter);
+static inline int write_packetized_from_buf_no_flush(const char *src_in,
+						     size_t len, int fd_out)
+{
+	return write_packetized_from_buf_no_flush_count(src_in, len, fd_out, NULL);
+}
 
 /*
  * Stdio versions of packet_write functions. When mixing these with fd
diff --git a/t/helper/test-rot13-filter.c b/t/helper/test-rot13-filter.c
new file mode 100644
index 0000000000..f8d564c622
--- /dev/null
+++ b/t/helper/test-rot13-filter.c
@@ -0,0 +1,382 @@
+/*
+ * Example implementation for the Git filter protocol version 2
+ * See Documentation/gitattributes.txt, section "Filter Protocol"
+ *
+ * Usage: test-tool rot13-filter [--always-delay] --log=<path> <capabilities>
+ *
+ * Log path defines a debug log file that the script writes to. The
+ * subsequent arguments define a list of supported protocol capabilities
+ * ("clean", "smudge", etc).
+ *
+ * When --always-delay is given all pathnames with the "can-delay" flag
+ * that don't appear on the list bellow are delayed with a count of 1
+ * (see more below).
+ *
+ * This implementation supports special test cases:
+ * (1) If data with the pathname "clean-write-fail.r" is processed with
+ *     a "clean" operation then the write operation will die.
+ * (2) If data with the pathname "smudge-write-fail.r" is processed with
+ *     a "smudge" operation then the write operation will die.
+ * (3) If data with the pathname "error.r" is processed with any
+ *     operation then the filter signals that it cannot or does not want
+ *     to process the file.
+ * (4) If data with the pathname "abort.r" is processed with any
+ *     operation then the filter signals that it cannot or does not want
+ *     to process the file and any file after that is processed with the
+ *     same command.
+ * (5) If data with a pathname that is a key in the delay hash is
+ *     requested (e.g. "test-delay10.a") then the filter responds with
+ *     a "delay" status and sets the "requested" field in the delay hash.
+ *     The filter will signal the availability of this object after
+ *     "count" (field in delay hash) "list_available_blobs" commands.
+ * (6) If data with the pathname "missing-delay.a" is processed that the
+ *     filter will drop the path from the "list_available_blobs" response.
+ * (7) If data with the pathname "invalid-delay.a" is processed that the
+ *     filter will add the path "unfiltered" which was not delayed before
+ *     to the "list_available_blobs" response.
+ */
+
+#include "test-tool.h"
+#include "pkt-line.h"
+#include "string-list.h"
+#include "strmap.h"
+#include "parse-options.h"
+
+static FILE *logfile;
+static int always_delay, has_clean_cap, has_smudge_cap;
+static struct strmap delay = STRMAP_INIT;
+
+static inline const char *str_or_null(const char *str)
+{
+	return str ? str : "(null)";
+}
+
+static char *rot13(char *str)
+{
+	char *c;
+	for (c = str; *c; c++)
+		if (isalpha(*c))
+			*c += tolower(*c) < 'n' ? 13 : -13;
+	return str;
+}
+
+static char *get_value(char *buf, const char *key)
+{
+	const char *orig_buf = buf;
+	if (!buf ||
+	    !skip_prefix((const char *)buf, key, (const char **)&buf) ||
+	    !skip_prefix((const char *)buf, "=", (const char **)&buf) ||
+	    !*buf)
+		die("expected key '%s', got '%s'", key, str_or_null(orig_buf));
+	return buf;
+}
+
+/*
+ * Read a text packet, expecting that it is in the form "key=value" for
+ * the given key. An EOF does not trigger any error and is reported
+ * back to the caller with NULL. Die if the "key" part of "key=value" does
+ * not match the given key, or the value part is empty.
+ */
+static char *packet_key_val_read(const char *key)
+{
+	char *buf;
+	if (packet_read_line_gently(0, NULL, &buf) < 0)
+		return NULL;
+	return xstrdup(get_value(buf, key));
+}
+
+static inline void assert_remote_capability(struct strset *caps, const char *cap)
+{
+	if (!strset_contains(caps, cap))
+		die("required '%s' capability not available from remote", cap);
+}
+
+static void read_capabilities(struct strset *remote_caps)
+{
+	for (;;) {
+		char *buf = packet_read_line(0, NULL);
+		if (!buf)
+			break;
+		strset_add(remote_caps, get_value(buf, "capability"));
+	}
+
+	assert_remote_capability(remote_caps, "clean");
+	assert_remote_capability(remote_caps, "smudge");
+	assert_remote_capability(remote_caps, "delay");
+}
+
+static void check_and_write_capabilities(struct strset *remote_caps,
+					 const char **caps, int nr_caps)
+{
+	int i;
+	for (i = 0; i < nr_caps; i++) {
+		if (!strset_contains(remote_caps, caps[i]))
+			die("our capability '%s' is not available from remote",
+			    caps[i]);
+		packet_write_fmt(1, "capability=%s\n", caps[i]);
+	}
+	packet_flush(1);
+}
+
+struct delay_entry {
+	int requested, count;
+	char *output;
+};
+
+static void free_delay_entries(void)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *ent;
+
+	strmap_for_each_entry(&delay, &iter, ent) {
+		struct delay_entry *delay_entry = ent->value;
+		free(delay_entry->output);
+		free(delay_entry);
+	}
+	strmap_clear(&delay, 0);
+}
+
+static void add_delay_entry(char *pathname, int count, int requested)
+{
+	struct delay_entry *entry = xcalloc(1, sizeof(*entry));
+	entry->count = count;
+	entry->requested = requested;
+	if (strmap_put(&delay, pathname, entry))
+		BUG("adding the same path twice to delay hash?");
+}
+
+static void reply_list_available_blobs_cmd(void)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *ent;
+	struct string_list_item *str_item;
+	struct string_list paths = STRING_LIST_INIT_NODUP;
+
+	/* flush */
+	if (packet_read_line(0, NULL))
+		die("bad list_available_blobs end");
+
+	strmap_for_each_entry(&delay, &iter, ent) {
+		struct delay_entry *delay_entry = ent->value;
+		if (!delay_entry->requested)
+			continue;
+		delay_entry->count--;
+		if (!strcmp(ent->key, "invalid-delay.a")) {
+			/* Send Git a pathname that was not delayed earlier */
+			packet_write_fmt(1, "pathname=unfiltered");
+		}
+		if (!strcmp(ent->key, "missing-delay.a")) {
+			/* Do not signal Git that this file is available */
+		} else if (!delay_entry->count) {
+			string_list_append(&paths, ent->key);
+			packet_write_fmt(1, "pathname=%s", ent->key);
+		}
+	}
+
+	/* Print paths in sorted order. */
+	string_list_sort(&paths);
+	for_each_string_list_item(str_item, &paths)
+		fprintf(logfile, " %s", str_item->string);
+	string_list_clear(&paths, 0);
+
+	packet_flush(1);
+
+	fprintf(logfile, " [OK]\n");
+	packet_write_fmt(1, "status=success");
+	packet_flush(1);
+}
+
+static void command_loop(void)
+{
+	for (;;) {
+		char *buf, *output;
+		char *pathname;
+		struct delay_entry *entry;
+		struct strbuf input = STRBUF_INIT;
+		char *command = packet_key_val_read("command");
+
+		if (!command) {
+			fprintf(logfile, "STOP\n");
+			break;
+		}
+		fprintf(logfile, "IN: %s", command);
+
+		if (!strcmp(command, "list_available_blobs")) {
+			reply_list_available_blobs_cmd();
+			free(command);
+			continue;
+		}
+
+		pathname = packet_key_val_read("pathname");
+		if (!pathname)
+			die("unexpected EOF while expecting pathname");
+		fprintf(logfile, " %s", pathname);
+
+		/* Read until flush */
+		while ((buf = packet_read_line(0, NULL))) {
+			if (!strcmp(buf, "can-delay=1")) {
+				entry = strmap_get(&delay, pathname);
+				if (entry && !entry->requested)
+					entry->requested = 1;
+				else if (!entry && always_delay)
+					add_delay_entry(pathname, 1, 1);
+			} else if (starts_with(buf, "ref=") ||
+				   starts_with(buf, "treeish=") ||
+				   starts_with(buf, "blob=")) {
+				fprintf(logfile, " %s", buf);
+			} else {
+				/*
+				 * In general, filters need to be graceful about
+				 * new metadata, since it's documented that we
+				 * can pass any key-value pairs, but for tests,
+				 * let's be a little stricter.
+				 */
+				die("Unknown message '%s'", buf);
+			}
+		}
+
+		read_packetized_to_strbuf(0, &input, 0);
+		fprintf(logfile, " %"PRIuMAX" [OK] -- ", (uintmax_t)input.len);
+
+		entry = strmap_get(&delay, pathname);
+		if (entry && entry->output) {
+			output = entry->output;
+		} else if (!strcmp(pathname, "error.r") || !strcmp(pathname, "abort.r")) {
+			output = "";
+		} else if (!strcmp(command, "clean") && has_clean_cap) {
+			output = rot13(input.buf);
+		} else if (!strcmp(command, "smudge") && has_smudge_cap) {
+			output = rot13(input.buf);
+		} else {
+			die("bad command '%s'", command);
+		}
+
+		if (!strcmp(pathname, "error.r")) {
+			fprintf(logfile, "[ERROR]\n");
+			packet_write_fmt(1, "status=error");
+			packet_flush(1);
+		} else if (!strcmp(pathname, "abort.r")) {
+			fprintf(logfile, "[ABORT]\n");
+			packet_write_fmt(1, "status=abort");
+			packet_flush(1);
+		} else if (!strcmp(command, "smudge") &&
+			   (entry = strmap_get(&delay, pathname)) &&
+			   entry->requested == 1) {
+			fprintf(logfile, "[DELAYED]\n");
+			packet_write_fmt(1, "status=delayed");
+			packet_flush(1);
+			entry->requested = 2;
+			if (entry->output != output) {
+				free(entry->output);
+				entry->output = xstrdup(output);
+			}
+		} else {
+			int i, nr_packets = 0;
+			size_t output_len;
+			const char *p;
+			packet_write_fmt(1, "status=success");
+			packet_flush(1);
+
+			if (skip_prefix(pathname, command, &p) &&
+			    !strcmp(p, "-write-fail.r")) {
+				fprintf(logfile, "[WRITE FAIL]\n");
+				die("%s write error", command);
+			}
+
+			output_len = strlen(output);
+			fprintf(logfile, "OUT: %"PRIuMAX" ", (uintmax_t)output_len);
+
+			if (write_packetized_from_buf_no_flush_count(output,
+				output_len, 1, &nr_packets))
+				die("failed to write buffer to stdout");
+			packet_flush(1);
+
+			for (i = 0; i < nr_packets; i++)
+				fprintf(logfile, ".");
+			fprintf(logfile, " [OK]\n");
+
+			packet_flush(1);
+		}
+		free(pathname);
+		strbuf_release(&input);
+		free(command);
+	}
+}
+
+static void packet_initialize(void)
+{
+	char *pkt_buf = packet_read_line(0, NULL);
+
+	if (!pkt_buf || strcmp(pkt_buf, "git-filter-client"))
+		die("bad initialize: '%s'", str_or_null(pkt_buf));
+
+	pkt_buf = packet_read_line(0, NULL);
+	if (!pkt_buf || strcmp(pkt_buf, "version=2"))
+		die("bad version: '%s'", str_or_null(pkt_buf));
+
+	pkt_buf = packet_read_line(0, NULL);
+	if (pkt_buf)
+		die("bad version end: '%s'", pkt_buf);
+
+	packet_write_fmt(1, "git-filter-server");
+	packet_write_fmt(1, "version=2");
+	packet_flush(1);
+}
+
+static const char *rot13_usage[] = {
+	"test-tool rot13-filter [--always-delay] --log=<path> <capabilities>",
+	NULL
+};
+
+int cmd__rot13_filter(int argc, const char **argv)
+{
+	int i, nr_caps;
+	struct strset remote_caps = STRSET_INIT;
+	const char *log_path = NULL;
+
+	struct option options[] = {
+		OPT_BOOL(0, "always-delay", &always_delay,
+			 "delay all paths with the can-delay flag"),
+		OPT_STRING(0, "log", &log_path, "path",
+			   "path to the debug log file"),
+		OPT_END()
+	};
+	nr_caps = parse_options(argc, argv, NULL, options, rot13_usage,
+				PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (!log_path || !nr_caps)
+		usage_with_options(rot13_usage, options);
+
+	logfile = fopen(log_path, "a");
+	if (!logfile)
+		die_errno("failed to open log file");
+
+	for (i = 0; i < nr_caps; i++) {
+		if (!strcmp(argv[i], "smudge"))
+			has_smudge_cap = 1;
+		if (!strcmp(argv[i], "clean"))
+			has_clean_cap = 1;
+	}
+
+	add_delay_entry("test-delay10.a", 1, 0);
+	add_delay_entry("test-delay11.a", 1, 0);
+	add_delay_entry("test-delay20.a", 2, 0);
+	add_delay_entry("test-delay10.b", 1, 0);
+	add_delay_entry("missing-delay.a", 1, 0);
+	add_delay_entry("invalid-delay.a", 1, 0);
+
+	fprintf(logfile, "START\n");
+	packet_initialize();
+
+	read_capabilities(&remote_caps);
+	check_and_write_capabilities(&remote_caps, argv, nr_caps);
+	fprintf(logfile, "init handshake complete\n");
+	strset_clear(&remote_caps);
+
+	command_loop();
+
+	if (fclose(logfile))
+		die_errno("error closing logfile");
+	free_delay_entries();
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 318fdbab0c..d6a560f832 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -65,6 +65,7 @@ static struct test_cmd cmds[] = {
 	{ "read-midx", cmd__read_midx },
 	{ "ref-store", cmd__ref_store },
 	{ "reftable", cmd__reftable },
+	{ "rot13-filter", cmd__rot13_filter },
 	{ "dump-reftable", cmd__dump_reftable },
 	{ "regex", cmd__regex },
 	{ "repository", cmd__repository },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index bb79927163..21a91b1019 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -54,6 +54,7 @@ int cmd__read_cache(int argc, const char **argv);
 int cmd__read_graph(int argc, const char **argv);
 int cmd__read_midx(int argc, const char **argv);
 int cmd__ref_store(int argc, const char **argv);
+int cmd__rot13_filter(int argc, const char **argv);
 int cmd__reftable(int argc, const char **argv);
 int cmd__regex(int argc, const char **argv);
 int cmd__repository(int argc, const char **argv);
-- 
2.37.1

