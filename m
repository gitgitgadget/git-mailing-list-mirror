Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA33C00140
	for <git@archiver.kernel.org>; Sun, 31 Jul 2022 18:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbiGaSUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jul 2022 14:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbiGaSUO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jul 2022 14:20:14 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743FEC1D
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 11:20:10 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id w129so4545366vkg.10
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 11:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=rCvgV0pDleu45xA3+pIU3tyso2habTGi2U+UvZAlEC8=;
        b=KZRvAwPEiE7vkZpDojbiuTFZrtP7eiVTpjHtY82eFXgBTIjWkjmyQ/T9SIs6LN7pwX
         rQ4N9CrdStG1mlqn8Z3lqTUZzV3tKLJ0Kq8oBKTutrD7Ci4KI8sThllsuHKU52CEAzwf
         MgPM0mkQUhEdR+QNPBewrnW4A0enfXS9QFQpKsRZ3F5G79gOikx/IIt7Ol9hTwJ1S5qe
         5pXEjmUd09YLW7Bv0auF2IiLndSGN8j4dsbHLE9iNJObtX1YS2HvnOynni2f5pRsLz4T
         6TAxOSGmJHWyx8cRI1wjRJ+ml7fFJHQGtvgYWiLkXWxYKJyu5WLLt1d8nvyiA26lybfj
         MsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=rCvgV0pDleu45xA3+pIU3tyso2habTGi2U+UvZAlEC8=;
        b=hJgitqZFaI0TXJCDPi0qcoHRbshSEtlqbqEosPPcRcVZP3DGYS4rupQNoScmVeiK68
         7GliReksjpDRdsm6AAzn4hCz+A8h+Pvvh/OnpB2hSQ693tgBv/wxoYn3L5GYvUtW8EmK
         G/ZmCtFUcmyPCsPxUFzX4Ji4hkSCz8ns3+4MBXK8PjizofmlYYhSYOTbpLCcvToWD6SF
         tI61CuiCXaOW3mHY4iIv4viMijohl235SEfhXbk4O15UiK+08cXV3URCP2bYa8dBtIjA
         pv3FBZ4F5M+yqwCKWSLoN4VIhu8FjU/VKa396tDyQDrK7WYX6QXfqlrE8KgnAe6i8G+s
         jvWw==
X-Gm-Message-State: AJIora8kyMgtpMfOQufOIFp3oI/cDl5gPlwP1/V2C+d3JR4PPZx41Vio
        Y/qsDGhlZU9qRs/RQV4bHSTzft2H1CMGHQ==
X-Google-Smtp-Source: AGRyM1vtN3b/q8DqMSrtcSFcv+vjXWpImQjppmka0FB1F68riP/zc5yLq1hwW9EK3p8dCpeQSPFVKQ==
X-Received: by 2002:a1f:a48b:0:b0:376:6af3:55 with SMTP id n133-20020a1fa48b000000b003766af30055mr4756650vke.18.1659291609052;
        Sun, 31 Jul 2022 11:20:09 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id l2-20020a056102050200b003573f2ff61asm3738795vsa.22.2022.07.31.11.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 11:20:08 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, johannes.schindelin@gmx.de,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 2/3] t0021: implementation the rot13-filter.pl script in C
Date:   Sun, 31 Jul 2022 15:19:49 -0300
Message-Id: <86e6baba460f4d0fce353d1fb6a0e18b57ecadaa.1659291025.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1659291025.git.matheus.bernardino@usp.br>
References: <cover.1659291025.git.matheus.bernardino@usp.br>
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

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Makefile                     |   1 +
 pkt-line.c                   |   5 +-
 pkt-line.h                   |   8 +-
 t/helper/test-rot13-filter.c | 379 +++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c         |   1 +
 t/helper/test-tool.h         |   1 +
 6 files changed, 393 insertions(+), 2 deletions(-)
 create mode 100644 t/helper/test-rot13-filter.c

diff --git a/Makefile b/Makefile
index 04d0fd1fe6..7cfcf3a911 100644
--- a/Makefile
+++ b/Makefile
@@ -764,6 +764,7 @@ TEST_BUILTINS_OBJS += test-read-midx.o
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
index 6d2a63db23..804fe687fb 100644
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
index 0000000000..d584511f8e
--- /dev/null
+++ b/t/helper/test-rot13-filter.c
@@ -0,0 +1,379 @@
+/*
+ * Example implementation for the Git filter protocol version 2
+ * See Documentation/gitattributes.txt, section "Filter Protocol"
+ *
+ * Usage: test-tool rot13-filter [--always-delay] <log path> <capabilities>
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
+
+static FILE *logfile;
+static int always_delay, has_clean_cap, has_smudge_cap;
+static struct strmap delay = STRMAP_INIT;
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
+static char *get_value(char *buf, size_t size, const char *key)
+{
+	const char *orig_buf = buf;
+	int orig_size = (int)size;
+
+	if (!skip_prefix_mem((const char *)buf, size, key, (const char **)&buf, &size) ||
+	    !skip_prefix_mem((const char *)buf, size, "=", (const char **)&buf, &size) ||
+	    !size)
+		die("expected key '%s', got '%.*s'",
+		    key, orig_size, orig_buf);
+
+	buf[size] = '\0';
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
+	int size;
+	char *buf;
+	if (packet_read_line_gently(0, &size, &buf) < 0)
+		return NULL;
+	return xstrdup(get_value(buf, size, key));
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
+		int size;
+		char *buf = packet_read_line(0, &size);
+		if (!buf)
+			break;
+		strset_add(remote_caps, get_value(buf, size, "capability"));
+	}
+
+	assert_remote_capability(remote_caps, "clean");
+	assert_remote_capability(remote_caps, "smudge");
+	assert_remote_capability(remote_caps, "delay");
+}
+
+static void check_and_write_capabilities(struct strset *remote_caps,
+					 const char **caps, int caps_count)
+{
+	int i;
+	for (i = 0; i < caps_count; i++) {
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
+		int size;
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
+		while ((buf = packet_read_line(0, &size))) {
+			if (!strcmp(buf, "can-delay=1")) {
+				entry = strmap_get(&delay, pathname);
+				if (entry && !entry->requested) {
+					entry->requested = 1;
+				} else if (!entry && always_delay) {
+					add_delay_entry(pathname, 1, 1);
+				}
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
+	int size;
+	char *pkt_buf = packet_read_line(0, &size);
+
+	if (!pkt_buf || strncmp(pkt_buf, "git-filter-client", size))
+		die("bad initialize: '%s'", xstrndup(pkt_buf, size));
+
+	pkt_buf = packet_read_line(0, &size);
+	if (!pkt_buf || strncmp(pkt_buf, "version=2", size))
+		die("bad version: '%.*s'", (int)size, pkt_buf);
+
+	pkt_buf = packet_read_line(0, &size);
+	if (pkt_buf)
+		die("bad version end: '%.*s'", (int)size, pkt_buf);
+
+	packet_write_fmt(1, "git-filter-server");
+	packet_write_fmt(1, "version=2");
+	packet_flush(1);
+}
+
+static char *rot13_usage = "test-tool rot13-filter [--always-delay] <log path> <capabilities>";
+
+int cmd__rot13_filter(int argc, const char **argv)
+{
+	const char **caps;
+	int cap_count, i = 1;
+	struct strset remote_caps = STRSET_INIT;
+
+	if (argc > 1 && !strcmp(argv[1], "--always-delay")) {
+		always_delay = 1;
+		i++;
+	}
+	if (argc - i < 2)
+		usage(rot13_usage);
+
+	logfile = fopen(argv[i++], "a");
+	if (!logfile)
+		die_errno("failed to open log file");
+
+	caps = argv + i;
+	cap_count = argc - i;
+
+	for (i = 0; i < cap_count; i++) {
+		if (!strcmp(caps[i], "clean"))
+			has_clean_cap = 1;
+		else if (!strcmp(caps[i], "smudge"))
+			has_smudge_cap = 1;
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
+	check_and_write_capabilities(&remote_caps, caps, cap_count);
+	fprintf(logfile, "init handshake complete\n");
+	strset_clear(&remote_caps);
+
+	command_loop();
+
+	fclose(logfile);
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

