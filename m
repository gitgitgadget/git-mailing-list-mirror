Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAD4C43334
	for <git@archiver.kernel.org>; Sun, 24 Jul 2022 15:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiGXPJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jul 2022 11:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiGXPJf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jul 2022 11:09:35 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B01B2606
        for <git@vger.kernel.org>; Sun, 24 Jul 2022 08:09:30 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-10d845dcf92so11809014fac.12
        for <git@vger.kernel.org>; Sun, 24 Jul 2022 08:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wqNgVcWjyFen5BeD0om1zVOVFi2h9rhk5AzQq+Ej6js=;
        b=ohMeInXBARLX1Bem5Yhpg0WDiEFtdCFkhThmgmzbGBZlugLaepbqi1KZ5T1Pv1T1JW
         EVaw7IK4bhIPOYla7jJCTQBainjLKXQ/8+ueL4MIYd+b+Br4+Mk/lkkVL95NWu7zEiPO
         9p7yL89Ih4q4USWjNi3PyfxCvYn4wZZ9URQWHXe33gLiwgbLf3tvchAU4Rc7V59Nicb3
         WcMLWbZ+hZnQF/lTyP+P2xreoDLHBcHyuWvvVwA4GBELx6qu0StF+Cd/kvJDr8Emixv5
         XayTdgENx4tt3T3Np43eg/TCkC6EbaWmw5l7n06r31RnEB/5zC8j4pOI06TabNQhfwyy
         Fnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wqNgVcWjyFen5BeD0om1zVOVFi2h9rhk5AzQq+Ej6js=;
        b=zODO4U59aB+rYsP9aAgMRnMGtKQZProCuvByF6lujCsBgfmLV+8ibk0wwlXdkhlLaG
         Gp5Tlw7QNCF+XBEJSztYc/unDvbUNCe/Rq8cPlcSTl7wlaANEqvzG2IsSSzbtdakbvFC
         GO/6LyqElWBNKx2ghHz/pLKefOljPTan0dz9lRlQ85FTvwboYjmUxVqv2bkyREqy+0fK
         EhHy3mUUlLfwuYcFikfVJxrjYePj9oaSP3SiE6U+47Bd22vBGPcPvwxZE+0x2fM2JKy3
         5FYPhllU4+ZCvt171WxkCZuF6n7uU85N+MDcGVIb8tRMu+AQiJKxzPd1z3TU8xbVW/4T
         wjuQ==
X-Gm-Message-State: AJIora+8sfhwYovc09N2q5SCdSgtc4dUkwwZQDwgEMmhNPPJTQ9ny6N6
        mKKi+sZnGOuwhoOCAyo5ZjGe1FTw5bVRZA==
X-Google-Smtp-Source: AGRyM1vNv4k2TWWS8BxYQDSIUxg2YKvpqvtNSO2dM991YL1wlHAVxicNZyLZ2KT4HynmFFlnVklOew==
X-Received: by 2002:a05:6870:c1c1:b0:ee:5c83:7be7 with SMTP id i1-20020a056870c1c100b000ee5c837be7mr4368597oad.53.1658675368514;
        Sun, 24 Jul 2022 08:09:28 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id j5-20020aca6545000000b0033ad9f035a5sm625844oiw.34.2022.07.24.08.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 08:09:27 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com,
        christian.couder@gmail.com, avarab@gmail.com
Subject: [PATCH v2] t/t0021: convert the rot13-filter.pl script to C
Date:   Sun, 24 Jul 2022 12:09:18 -0300
Message-Id: <f38f722de7c3323207eda5ea632b5acd3765c285.1658675222.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1658518769.git.matheus.bernardino@usp.br>
References: <cover.1658518769.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This script is currently used by three test files: t0021-conversion.sh,
t2080-parallel-checkout-basics.sh, and
t2082-parallel-checkout-attributes.sh. To avoid the need for the PERL
dependency at these tests, let's convert the script to a C test-tool
command.

Note that there is a small adjustment needed at test t0021-conversion.sh
because it depended on a specific error message given by perl's die
routine.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

Changes since v1:
- Squashed the two patches together.
- Declared `remote_caps` at cmd__rot13_filter()'s stack and passed it
  down the call stack instead of dynamic allocation.

 Makefile                                |   1 +
 pkt-line.c                              |  13 +-
 pkt-line.h                              |   2 +
 t/helper/test-rot13-filter.c            | 393 ++++++++++++++++++++++++
 t/helper/test-tool.c                    |   1 +
 t/helper/test-tool.h                    |   1 +
 t/t0021-conversion.sh                   |  71 ++---
 t/t0021/rot13-filter.pl                 | 247 ---------------
 t/t2080-parallel-checkout-basics.sh     |   7 +-
 t/t2082-parallel-checkout-attributes.sh |   7 +-
 10 files changed, 447 insertions(+), 296 deletions(-)
 create mode 100644 t/helper/test-rot13-filter.c
 delete mode 100644 t/t0021/rot13-filter.pl

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
index 8e43c2def4..4425bdae36 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -309,9 +309,10 @@ int write_packetized_from_fd_no_flush(int fd_in, int fd_out)
 	return err;
 }
 
-int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_out)
+int write_packetized_from_buf_no_flush_count(const char *src_in, size_t len,
+					     int fd_out, int *count_ptr)
 {
-	int err = 0;
+	int err = 0, count = 0;
 	size_t bytes_written = 0;
 	size_t bytes_to_write;
 
@@ -324,10 +325,18 @@ int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_ou
 			break;
 		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write);
 		bytes_written += bytes_to_write;
+		count++;
 	}
+	if (count_ptr)
+		*count_ptr = count;
 	return err;
 }
 
+int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_out)
+{
+	return write_packetized_from_buf_no_flush_count(src_in, len, fd_out, NULL);
+}
+
 static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 			   void *dst, unsigned size, int options)
 {
diff --git a/pkt-line.h b/pkt-line.h
index 6d2a63db23..43986c525c 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -33,6 +33,8 @@ int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int write_packetized_from_fd_no_flush(int fd_in, int fd_out);
 int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_out);
+int write_packetized_from_buf_no_flush_count(const char *src_in, size_t len,
+					     int fd_out, int *count_ptr);
 
 /*
  * Stdio versions of packet_write functions. When mixing these with fd
diff --git a/t/helper/test-rot13-filter.c b/t/helper/test-rot13-filter.c
new file mode 100644
index 0000000000..536111f272
--- /dev/null
+++ b/t/helper/test-rot13-filter.c
@@ -0,0 +1,393 @@
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
+static int always_delay;
+static struct strmap delay = STRMAP_INIT;
+static struct string_list requested_caps = STRING_LIST_INIT_NODUP;
+
+static int has_capability(const char *cap)
+{
+	return unsorted_string_list_has_string(&requested_caps, cap);
+}
+
+static char *rot13(char *str)
+{
+	char *c;
+	for (c = str; *c; c++) {
+		if (*c >= 'a' && *c <= 'z')
+			*c = 'a' + (*c - 'a' + 13) % 26;
+		else if (*c >= 'A' && *c <= 'Z')
+			*c = 'A' + (*c - 'A' + 13) % 26;
+	}
+	return str;
+}
+
+static char *skip_key_dup(const char *buf, size_t size, const char *key)
+{
+	struct strbuf keybuf = STRBUF_INIT;
+	strbuf_addf(&keybuf, "%s=", key);
+	if (!skip_prefix_mem(buf, size, keybuf.buf, &buf, &size) || !size)
+		die("bad %s: '%s'", key, xstrndup(buf, size));
+	strbuf_release(&keybuf);
+	return xstrndup(buf, size);
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
+	return skip_key_dup(buf, size, key);
+}
+
+static void packet_read_capabilities(struct string_list *caps)
+{
+	while (1) {
+		int size;
+		char *buf = packet_read_line(0, &size);
+		if (!buf)
+			break;
+		string_list_append_nodup(caps,
+					 skip_key_dup(buf, size, "capability"));
+	}
+}
+
+/* Read remote capabilities and check them against capabilities we require */
+static void packet_read_and_check_capabilities(struct string_list *remote_caps,
+					       struct string_list *required_caps)
+{
+	struct string_list_item *item;
+	packet_read_capabilities(remote_caps);
+	for_each_string_list_item(item, required_caps) {
+		if (!unsorted_string_list_has_string(remote_caps, item->string)) {
+			die("required '%s' capability not available from remote",
+			    item->string);
+		}
+	}
+}
+
+/*
+ * Check our capabilities we want to advertise against the remote ones
+ * and then advertise our capabilities
+ */
+static void packet_check_and_write_capabilities(struct string_list *remote_caps,
+						struct string_list *our_caps)
+{
+	struct string_list_item *item;
+	for_each_string_list_item(item, our_caps) {
+		if (!unsorted_string_list_has_string(remote_caps, item->string)) {
+			die("our capability '%s' is not available from remote",
+			    item->string);
+		}
+		packet_write_fmt(1, "capability=%s\n", item->string);
+	}
+	packet_flush(1);
+}
+
+struct delay_entry {
+	int requested, count;
+	char *output;
+};
+
+static void command_loop(void)
+{
+	while (1) {
+		char *command = packet_key_val_read("command");
+		if (!command) {
+			fprintf(logfile, "STOP\n");
+			break;
+		}
+		fprintf(logfile, "IN: %s", command);
+
+		if (!strcmp(command, "list_available_blobs")) {
+			struct hashmap_iter iter;
+			struct strmap_entry *ent;
+			struct string_list_item *str_item;
+			struct string_list paths = STRING_LIST_INIT_NODUP;
+
+			/* flush */
+			if (packet_read_line(0, NULL))
+				die("bad list_available_blobs end");
+
+			strmap_for_each_entry(&delay, &iter, ent) {
+				struct delay_entry *delay_entry = ent->value;
+				if (!delay_entry->requested)
+					continue;
+				delay_entry->count--;
+				if (!strcmp(ent->key, "invalid-delay.a")) {
+					/* Send Git a pathname that was not delayed earlier */
+					packet_write_fmt(1, "pathname=unfiltered");
+				}
+				if (!strcmp(ent->key, "missing-delay.a")) {
+					/* Do not signal Git that this file is available */
+				} else if (!delay_entry->count) {
+					string_list_insert(&paths, ent->key);
+					packet_write_fmt(1, "pathname=%s", ent->key);
+				}
+			}
+
+			/* Print paths in sorted order. */
+			for_each_string_list_item(str_item, &paths)
+				fprintf(logfile, " %s", str_item->string);
+			string_list_clear(&paths, 0);
+
+			packet_flush(1);
+
+			fprintf(logfile, " [OK]\n");
+			packet_write_fmt(1, "status=success");
+			packet_flush(1);
+		} else {
+			char *buf, *output;
+			int size;
+			char *pathname;
+			struct delay_entry *entry;
+			struct strbuf input = STRBUF_INIT;
+
+			pathname = packet_key_val_read("pathname");
+			if (!pathname)
+				die("unexpected EOF while expecting pathname");
+			fprintf(logfile, " %s", pathname);
+
+			/* Read until flush */
+			buf = packet_read_line(0, &size);
+			while (buf) {
+				if (!strcmp(buf, "can-delay=1")) {
+					entry = strmap_get(&delay, pathname);
+					if (entry && !entry->requested) {
+						entry->requested = 1;
+					} else if (!entry && always_delay) {
+						entry = xcalloc(1, sizeof(*entry));
+						entry->requested = 1;
+						entry->count = 1;
+						strmap_put(&delay, pathname, entry);
+					}
+				} else if (starts_with(buf, "ref=") ||
+					   starts_with(buf, "treeish=") ||
+					   starts_with(buf, "blob=")) {
+					fprintf(logfile, " %s", buf);
+				} else {
+					/*
+					 * In general, filters need to be graceful about
+					 * new metadata, since it's documented that we
+					 * can pass any key-value pairs, but for tests,
+					 * let's be a little stricter.
+					 */
+					die("Unknown message '%s'", buf);
+				}
+				buf = packet_read_line(0, &size);
+			}
+
+
+			read_packetized_to_strbuf(0, &input, 0);
+			fprintf(logfile, " %"PRIuMAX" [OK] -- ", (uintmax_t)input.len);
+
+			entry = strmap_get(&delay, pathname);
+			if (entry && entry->output) {
+				output = entry->output;
+			} else if (!strcmp(pathname, "error.r") || !strcmp(pathname, "abort.r")) {
+				output = "";
+			} else if (!strcmp(command, "clean") && has_capability("clean")) {
+				output = rot13(input.buf);
+			} else if (!strcmp(command, "smudge") && has_capability("smudge")) {
+				output = rot13(input.buf);
+			} else {
+				die("bad command '%s'", command);
+			}
+
+			if (!strcmp(pathname, "error.r")) {
+				fprintf(logfile, "[ERROR]\n");
+				packet_write_fmt(1, "status=error");
+				packet_flush(1);
+			} else if (!strcmp(pathname, "abort.r")) {
+				fprintf(logfile, "[ABORT]\n");
+				packet_write_fmt(1, "status=abort");
+				packet_flush(1);
+			} else if (!strcmp(command, "smudge") &&
+				   (entry = strmap_get(&delay, pathname)) &&
+				   entry->requested == 1) {
+				fprintf(logfile, "[DELAYED]\n");
+				packet_write_fmt(1, "status=delayed");
+				packet_flush(1);
+				entry->requested = 2;
+				entry->output = xstrdup(output);
+			} else {
+				int i, nr_packets;
+				size_t output_len;
+				struct strbuf sb = STRBUF_INIT;
+				packet_write_fmt(1, "status=success");
+				packet_flush(1);
+
+				strbuf_addf(&sb, "%s-write-fail.r", command);
+				if (!strcmp(pathname, sb.buf)) {
+					fprintf(logfile, "[WRITE FAIL]\n");
+					die("%s write error", command);
+				}
+
+				output_len = strlen(output);
+				fprintf(logfile, "OUT: %"PRIuMAX" ", (uintmax_t)output_len);
+
+				if (write_packetized_from_buf_no_flush_count(output,
+					output_len, 1, &nr_packets))
+					die("failed to write buffer to stdout");
+				packet_flush(1);
+
+				for (i = 0; i < nr_packets; i++)
+					fprintf(logfile, ".");
+				fprintf(logfile, " [OK]\n");
+
+				packet_flush(1);
+				strbuf_release(&sb);
+			}
+			free(pathname);
+			strbuf_release(&input);
+		}
+		free(command);
+	}
+}
+
+static void free_delay_hash(void)
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
+static void add_delay_entry(char *pathname, int count)
+{
+	struct delay_entry *entry = xcalloc(1, sizeof(*entry));
+	entry->count = count;
+	if (strmap_put(&delay, pathname, entry))
+		BUG("adding the same path twice to delay hash?");
+}
+
+static void packet_initialize(const char *name, int version)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int size;
+	char *pkt_buf = packet_read_line(0, &size);
+
+	strbuf_addf(&sb, "%s-client", name);
+	if (!pkt_buf || strncmp(pkt_buf, sb.buf, size))
+		die("bad initialize: '%s'", xstrndup(pkt_buf, size));
+
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "version=%d", version);
+	pkt_buf = packet_read_line(0, &size);
+	if (!pkt_buf || strncmp(pkt_buf, sb.buf, size))
+		die("bad version: '%s'", xstrndup(pkt_buf, size));
+
+	pkt_buf = packet_read_line(0, &size);
+	if (pkt_buf)
+		die("bad version end: '%s'", xstrndup(pkt_buf, size));
+
+	packet_write_fmt(1, "%s-server", name);
+	packet_write_fmt(1, "version=%d", version);
+	packet_flush(1);
+	strbuf_release(&sb);
+}
+
+static char *rot13_usage = "test-tool rot13-filter [--always-delay] <log path> <capabilities>";
+
+int cmd__rot13_filter(int argc, const char **argv)
+{
+	int i = 1;
+	struct string_list remote_caps = STRING_LIST_INIT_DUP,
+			   supported_caps = STRING_LIST_INIT_NODUP;
+
+	string_list_append(&supported_caps, "clean");
+	string_list_append(&supported_caps, "smudge");
+	string_list_append(&supported_caps, "delay");
+
+	if (argc > 1 && !strcmp(argv[i], "--always-delay")) {
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
+	for ( ; i < argc; i++)
+		string_list_append(&requested_caps, argv[i]);
+
+	add_delay_entry("test-delay10.a", 1);
+	add_delay_entry("test-delay11.a", 1);
+	add_delay_entry("test-delay20.a", 2);
+	add_delay_entry("test-delay10.b", 1);
+	add_delay_entry("missing-delay.a", 1);
+	add_delay_entry("invalid-delay.a", 1);
+
+	fprintf(logfile, "START\n");
+
+	packet_initialize("git-filter", 2);
+
+	packet_read_and_check_capabilities(&remote_caps, &supported_caps);
+	packet_check_and_write_capabilities(&remote_caps, &requested_caps);
+	fprintf(logfile, "init handshake complete\n");
+
+	string_list_clear(&supported_caps, 0);
+	string_list_clear(&remote_caps, 0);
+
+	command_loop();
+
+	fclose(logfile);
+	string_list_clear(&requested_caps, 0);
+	free_delay_hash();
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
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 1c840348bd..aeaa8e02ed 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -17,9 +17,6 @@ tr \
   'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM'
 EOF
 
-write_script rot13-filter.pl "$PERL_PATH" \
-	<"$TEST_DIRECTORY"/t0021/rot13-filter.pl
-
 generate_random_characters () {
 	LEN=$1
 	NAME=$2
@@ -365,8 +362,8 @@ test_expect_success 'diff does not reuse worktree files that need cleaning' '
 	test_line_count = 0 count
 '
 
-test_expect_success PERL 'required process filter should filter data' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
+test_expect_success 'required process filter should filter data' '
+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean smudge" &&
 	test_config_global filter.protocol.required true &&
 	rm -rf repo &&
 	mkdir repo &&
@@ -450,8 +447,8 @@ test_expect_success PERL 'required process filter should filter data' '
 	)
 '
 
-test_expect_success PERL 'required process filter should filter data for various subcommands' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
+test_expect_success 'required process filter should filter data for various subcommands' '
+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean smudge" &&
 	test_config_global filter.protocol.required true &&
 	(
 		cd repo &&
@@ -561,9 +558,9 @@ test_expect_success PERL 'required process filter should filter data for various
 	)
 '
 
-test_expect_success PERL 'required process filter takes precedence' '
+test_expect_success 'required process filter takes precedence' '
 	test_config_global filter.protocol.clean false &&
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean" &&
+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean" &&
 	test_config_global filter.protocol.required true &&
 	rm -rf repo &&
 	mkdir repo &&
@@ -587,8 +584,8 @@ test_expect_success PERL 'required process filter takes precedence' '
 	)
 '
 
-test_expect_success PERL 'required process filter should be used only for "clean" operation only' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean" &&
+test_expect_success 'required process filter should be used only for "clean" operation only' '
+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -622,8 +619,8 @@ test_expect_success PERL 'required process filter should be used only for "clean
 	)
 '
 
-test_expect_success PERL 'required process filter should process multiple packets' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
+test_expect_success 'required process filter should process multiple packets' '
+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean smudge" &&
 	test_config_global filter.protocol.required true &&
 
 	rm -rf repo &&
@@ -687,8 +684,8 @@ test_expect_success PERL 'required process filter should process multiple packet
 	)
 '
 
-test_expect_success PERL 'required process filter with clean error should fail' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
+test_expect_success 'required process filter with clean error should fail' '
+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean smudge" &&
 	test_config_global filter.protocol.required true &&
 	rm -rf repo &&
 	mkdir repo &&
@@ -706,8 +703,8 @@ test_expect_success PERL 'required process filter with clean error should fail'
 	)
 '
 
-test_expect_success PERL 'process filter should restart after unexpected write failure' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
+test_expect_success 'process filter should restart after unexpected write failure' '
+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean smudge" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -735,7 +732,7 @@ test_expect_success PERL 'process filter should restart after unexpected write f
 		rm -f debug.log &&
 		git checkout --quiet --no-progress . 2>git-stderr.log &&
 
-		grep "smudge write error at" git-stderr.log &&
+		grep "smudge write error" git-stderr.log &&
 		test_i18ngrep "error: external filter" git-stderr.log &&
 
 		cat >expected.log <<-EOF &&
@@ -761,8 +758,8 @@ test_expect_success PERL 'process filter should restart after unexpected write f
 	)
 '
 
-test_expect_success PERL 'process filter should not be restarted if it signals an error' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
+test_expect_success 'process filter should not be restarted if it signals an error' '
+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean smudge" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -804,8 +801,8 @@ test_expect_success PERL 'process filter should not be restarted if it signals a
 	)
 '
 
-test_expect_success PERL 'process filter abort stops processing of all further files' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
+test_expect_success 'process filter abort stops processing of all further files' '
+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean smudge" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -861,10 +858,10 @@ test_expect_success PERL 'invalid process filter must fail (and not hang!)' '
 	)
 '
 
-test_expect_success PERL 'delayed checkout in process filter' '
-	test_config_global filter.a.process "rot13-filter.pl a.log clean smudge delay" &&
+test_expect_success 'delayed checkout in process filter' '
+	test_config_global filter.a.process "test-tool rot13-filter a.log clean smudge delay" &&
 	test_config_global filter.a.required true &&
-	test_config_global filter.b.process "rot13-filter.pl b.log clean smudge delay" &&
+	test_config_global filter.b.process "test-tool rot13-filter b.log clean smudge delay" &&
 	test_config_global filter.b.required true &&
 
 	rm -rf repo &&
@@ -940,8 +937,8 @@ test_expect_success PERL 'delayed checkout in process filter' '
 	)
 '
 
-test_expect_success PERL 'missing file in delayed checkout' '
-	test_config_global filter.bug.process "rot13-filter.pl bug.log clean smudge delay" &&
+test_expect_success 'missing file in delayed checkout' '
+	test_config_global filter.bug.process "test-tool rot13-filter bug.log clean smudge delay" &&
 	test_config_global filter.bug.required true &&
 
 	rm -rf repo &&
@@ -960,8 +957,8 @@ test_expect_success PERL 'missing file in delayed checkout' '
 	grep "error: .missing-delay\.a. was not filtered properly" git-stderr.log
 '
 
-test_expect_success PERL 'invalid file in delayed checkout' '
-	test_config_global filter.bug.process "rot13-filter.pl bug.log clean smudge delay" &&
+test_expect_success 'invalid file in delayed checkout' '
+	test_config_global filter.bug.process "test-tool rot13-filter bug.log clean smudge delay" &&
 	test_config_global filter.bug.required true &&
 
 	rm -rf repo &&
@@ -990,10 +987,10 @@ do
 		mode_prereq='UTF8_NFD_TO_NFC' ;;
 	esac
 
-	test_expect_success PERL,SYMLINKS,$mode_prereq \
+	test_expect_success SYMLINKS,$mode_prereq \
 	"delayed checkout with $mode-collision don't write to the wrong place" '
 		test_config_global filter.delay.process \
-			"\"$TEST_ROOT/rot13-filter.pl\" --always-delay delayed.log clean smudge delay" &&
+			"test-tool rot13-filter --always-delay delayed.log clean smudge delay" &&
 		test_config_global filter.delay.required true &&
 
 		git init $mode-collision &&
@@ -1026,12 +1023,12 @@ do
 	'
 done
 
-test_expect_success PERL,SYMLINKS,CASE_INSENSITIVE_FS \
+test_expect_success SYMLINKS,CASE_INSENSITIVE_FS \
 "delayed checkout with submodule collision don't write to the wrong place" '
 	git init collision-with-submodule &&
 	(
 		cd collision-with-submodule &&
-		git config filter.delay.process "\"$TEST_ROOT/rot13-filter.pl\" --always-delay delayed.log clean smudge delay" &&
+		git config filter.delay.process "test-tool rot13-filter --always-delay delayed.log clean smudge delay" &&
 		git config filter.delay.required true &&
 
 		# We need Git to treat the submodule "a" and the
@@ -1062,11 +1059,11 @@ test_expect_success PERL,SYMLINKS,CASE_INSENSITIVE_FS \
 	)
 '
 
-test_expect_success PERL 'setup for progress tests' '
+test_expect_success 'setup for progress tests' '
 	git init progress &&
 	(
 		cd progress &&
-		git config filter.delay.process "rot13-filter.pl delay-progress.log clean smudge delay" &&
+		git config filter.delay.process "test-tool rot13-filter delay-progress.log clean smudge delay" &&
 		git config filter.delay.required true &&
 
 		echo "*.a filter=delay" >.gitattributes &&
@@ -1132,12 +1129,12 @@ do
 	'
 done
 
-test_expect_success PERL 'delayed checkout correctly reports the number of updated entries' '
+test_expect_success 'delayed checkout correctly reports the number of updated entries' '
 	rm -rf repo &&
 	git init repo &&
 	(
 		cd repo &&
-		git config filter.delay.process "../rot13-filter.pl delayed.log clean smudge delay" &&
+		git config filter.delay.process "test-tool rot13-filter delayed.log clean smudge delay" &&
 		git config filter.delay.required true &&
 
 		echo "*.a filter=delay" >.gitattributes &&
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
deleted file mode 100644
index 7bb93768f3..0000000000
--- a/t/t0021/rot13-filter.pl
+++ /dev/null
@@ -1,247 +0,0 @@
-#
-# Example implementation for the Git filter protocol version 2
-# See Documentation/gitattributes.txt, section "Filter Protocol"
-#
-# Usage: rot13-filter.pl [--always-delay] <log path> <capabilities>
-#
-# Log path defines a debug log file that the script writes to. The
-# subsequent arguments define a list of supported protocol capabilities
-# ("clean", "smudge", etc).
-#
-# When --always-delay is given all pathnames with the "can-delay" flag
-# that don't appear on the list bellow are delayed with a count of 1
-# (see more below).
-#
-# This implementation supports special test cases:
-# (1) If data with the pathname "clean-write-fail.r" is processed with
-#     a "clean" operation then the write operation will die.
-# (2) If data with the pathname "smudge-write-fail.r" is processed with
-#     a "smudge" operation then the write operation will die.
-# (3) If data with the pathname "error.r" is processed with any
-#     operation then the filter signals that it cannot or does not want
-#     to process the file.
-# (4) If data with the pathname "abort.r" is processed with any
-#     operation then the filter signals that it cannot or does not want
-#     to process the file and any file after that is processed with the
-#     same command.
-# (5) If data with a pathname that is a key in the DELAY hash is
-#     requested (e.g. "test-delay10.a") then the filter responds with
-#     a "delay" status and sets the "requested" field in the DELAY hash.
-#     The filter will signal the availability of this object after
-#     "count" (field in DELAY hash) "list_available_blobs" commands.
-# (6) If data with the pathname "missing-delay.a" is processed that the
-#     filter will drop the path from the "list_available_blobs" response.
-# (7) If data with the pathname "invalid-delay.a" is processed that the
-#     filter will add the path "unfiltered" which was not delayed before
-#     to the "list_available_blobs" response.
-#
-
-use 5.008;
-sub gitperllib {
-	# Git assumes that all path lists are Unix-y colon-separated ones. But
-	# when the Git for Windows executes the test suite, its MSYS2 Bash
-	# calls git.exe, and colon-separated path lists are converted into
-	# Windows-y semicolon-separated lists of *Windows* paths (which
-	# naturally contain a colon after the drive letter, so splitting by
-	# colons simply does not cut it).
-	#
-	# Detect semicolon-separated path list and handle them appropriately.
-
-	if ($ENV{GITPERLLIB} =~ /;/) {
-		return split(/;/, $ENV{GITPERLLIB});
-	}
-	return split(/:/, $ENV{GITPERLLIB});
-}
-use lib (gitperllib());
-use strict;
-use warnings;
-use IO::File;
-use Git::Packet;
-
-my $MAX_PACKET_CONTENT_SIZE = 65516;
-
-my $always_delay = 0;
-if ( $ARGV[0] eq '--always-delay' ) {
-	$always_delay = 1;
-	shift @ARGV;
-}
-
-my $log_file                = shift @ARGV;
-my @capabilities            = @ARGV;
-
-open my $debug, ">>", $log_file or die "cannot open log file: $!";
-
-my %DELAY = (
-	'test-delay10.a' => { "requested" => 0, "count" => 1 },
-	'test-delay11.a' => { "requested" => 0, "count" => 1 },
-	'test-delay20.a' => { "requested" => 0, "count" => 2 },
-	'test-delay10.b' => { "requested" => 0, "count" => 1 },
-	'missing-delay.a' => { "requested" => 0, "count" => 1 },
-	'invalid-delay.a' => { "requested" => 0, "count" => 1 },
-);
-
-sub rot13 {
-	my $str = shift;
-	$str =~ y/A-Za-z/N-ZA-Mn-za-m/;
-	return $str;
-}
-
-print $debug "START\n";
-$debug->flush();
-
-packet_initialize("git-filter", 2);
-
-my %remote_caps = packet_read_and_check_capabilities("clean", "smudge", "delay");
-packet_check_and_write_capabilities(\%remote_caps, @capabilities);
-
-print $debug "init handshake complete\n";
-$debug->flush();
-
-while (1) {
-	my ( $res, $command ) = packet_key_val_read("command");
-	if ( $res == -1 ) {
-		print $debug "STOP\n";
-		exit();
-	}
-	print $debug "IN: $command";
-	$debug->flush();
-
-	if ( $command eq "list_available_blobs" ) {
-		# Flush
-		packet_compare_lists([1, ""], packet_bin_read()) ||
-			die "bad list_available_blobs end";
-
-		foreach my $pathname ( sort keys %DELAY ) {
-			if ( $DELAY{$pathname}{"requested"} >= 1 ) {
-				$DELAY{$pathname}{"count"} = $DELAY{$pathname}{"count"} - 1;
-				if ( $pathname eq "invalid-delay.a" ) {
-					# Send Git a pathname that was not delayed earlier
-					packet_txt_write("pathname=unfiltered");
-				}
-				if ( $pathname eq "missing-delay.a" ) {
-					# Do not signal Git that this file is available
-				} elsif ( $DELAY{$pathname}{"count"} == 0 ) {
-					print $debug " $pathname";
-					packet_txt_write("pathname=$pathname");
-				}
-			}
-		}
-
-		packet_flush();
-
-		print $debug " [OK]\n";
-		$debug->flush();
-		packet_txt_write("status=success");
-		packet_flush();
-	} else {
-		my ( $res, $pathname ) = packet_key_val_read("pathname");
-		if ( $res == -1 ) {
-			die "unexpected EOF while expecting pathname";
-		}
-		print $debug " $pathname";
-		$debug->flush();
-
-		# Read until flush
-		my ( $done, $buffer ) = packet_txt_read();
-		while ( $buffer ne '' ) {
-			if ( $buffer eq "can-delay=1" ) {
-				if ( exists $DELAY{$pathname} and $DELAY{$pathname}{"requested"} == 0 ) {
-					$DELAY{$pathname}{"requested"} = 1;
-				} elsif ( !exists $DELAY{$pathname} and $always_delay ) {
-					$DELAY{$pathname} = { "requested" => 1, "count" => 1 };
-				}
-			} elsif ($buffer =~ /^(ref|treeish|blob)=/) {
-				print $debug " $buffer";
-			} else {
-				# In general, filters need to be graceful about
-				# new metadata, since it's documented that we
-				# can pass any key-value pairs, but for tests,
-				# let's be a little stricter.
-				die "Unknown message '$buffer'";
-			}
-
-			( $done, $buffer ) = packet_txt_read();
-		}
-		if ( $done == -1 ) {
-			die "unexpected EOF after pathname '$pathname'";
-		}
-
-		my $input = "";
-		{
-			binmode(STDIN);
-			my $buffer;
-			my $done = 0;
-			while ( !$done ) {
-				( $done, $buffer ) = packet_bin_read();
-				$input .= $buffer;
-			}
-			if ( $done == -1 ) {
-				die "unexpected EOF while reading input for '$pathname'";
-			}			
-			print $debug " " . length($input) . " [OK] -- ";
-			$debug->flush();
-		}
-
-		my $output;
-		if ( exists $DELAY{$pathname} and exists $DELAY{$pathname}{"output"} ) {
-			$output = $DELAY{$pathname}{"output"}
-		} elsif ( $pathname eq "error.r" or $pathname eq "abort.r" ) {
-			$output = "";
-		} elsif ( $command eq "clean" and grep( /^clean$/, @capabilities ) ) {
-			$output = rot13($input);
-		} elsif ( $command eq "smudge" and grep( /^smudge$/, @capabilities ) ) {
-			$output = rot13($input);
-		} else {
-			die "bad command '$command'";
-		}
-
-		if ( $pathname eq "error.r" ) {
-			print $debug "[ERROR]\n";
-			$debug->flush();
-			packet_txt_write("status=error");
-			packet_flush();
-		} elsif ( $pathname eq "abort.r" ) {
-			print $debug "[ABORT]\n";
-			$debug->flush();
-			packet_txt_write("status=abort");
-			packet_flush();
-		} elsif ( $command eq "smudge" and
-			exists $DELAY{$pathname} and
-			$DELAY{$pathname}{"requested"} == 1 ) {
-			print $debug "[DELAYED]\n";
-			$debug->flush();
-			packet_txt_write("status=delayed");
-			packet_flush();
-			$DELAY{$pathname}{"requested"} = 2;
-			$DELAY{$pathname}{"output"} = $output;
-		} else {
-			packet_txt_write("status=success");
-			packet_flush();
-
-			if ( $pathname eq "${command}-write-fail.r" ) {
-				print $debug "[WRITE FAIL]\n";
-				$debug->flush();
-				die "${command} write error";
-			}
-
-			print $debug "OUT: " . length($output) . " ";
-			$debug->flush();
-
-			while ( length($output) > 0 ) {
-				my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
-				packet_bin_write($packet);
-				# dots represent the number of packets
-				print $debug ".";
-				if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
-					$output = substr( $output, $MAX_PACKET_CONTENT_SIZE );
-				} else {
-					$output = "";
-				}
-			}
-			packet_flush();
-			print $debug " [OK]\n";
-			$debug->flush();
-			packet_flush();
-		}
-	}
-}
diff --git a/t/t2080-parallel-checkout-basics.sh b/t/t2080-parallel-checkout-basics.sh
index c683e60007..7d956625ca 100755
--- a/t/t2080-parallel-checkout-basics.sh
+++ b/t/t2080-parallel-checkout-basics.sh
@@ -230,12 +230,9 @@ test_expect_success SYMLINKS 'parallel checkout checks for symlinks in leading d
 # check the final report including sequential, parallel, and delayed entries
 # all at the same time. So we must have finer control of the parallel checkout
 # variables.
-test_expect_success PERL '"git checkout ." report should not include failed entries' '
-	write_script rot13-filter.pl "$PERL_PATH" \
-		<"$TEST_DIRECTORY"/t0021/rot13-filter.pl &&
-
+test_expect_success '"git checkout ." report should not include failed entries' '
 	test_config_global filter.delay.process \
-		"\"$(pwd)/rot13-filter.pl\" --always-delay delayed.log clean smudge delay" &&
+		"test-tool rot13-filter --always-delay delayed.log clean smudge delay" &&
 	test_config_global filter.delay.required true &&
 	test_config_global filter.cat.clean cat  &&
 	test_config_global filter.cat.smudge cat  &&
diff --git a/t/t2082-parallel-checkout-attributes.sh b/t/t2082-parallel-checkout-attributes.sh
index 2525457961..2df55b9405 100755
--- a/t/t2082-parallel-checkout-attributes.sh
+++ b/t/t2082-parallel-checkout-attributes.sh
@@ -138,12 +138,9 @@ test_expect_success 'parallel-checkout and external filter' '
 # The delayed queue is independent from the parallel queue, and they should be
 # able to work together in the same checkout process.
 #
-test_expect_success PERL 'parallel-checkout and delayed checkout' '
-	write_script rot13-filter.pl "$PERL_PATH" \
-		<"$TEST_DIRECTORY"/t0021/rot13-filter.pl &&
-
+test_expect_success 'parallel-checkout and delayed checkout' '
 	test_config_global filter.delay.process \
-		"\"$(pwd)/rot13-filter.pl\" --always-delay \"$(pwd)/delayed.log\" clean smudge delay" &&
+		"test-tool rot13-filter --always-delay \"$(pwd)/delayed.log\" clean smudge delay" &&
 	test_config_global filter.delay.required true &&
 
 	echo "abcd" >original &&
-- 
2.37.1

