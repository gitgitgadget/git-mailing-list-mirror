Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56931CCA473
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 19:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbiGVTnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 15:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbiGVTnO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 15:43:14 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9403476E9A
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 12:43:11 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-10dc1b16c12so2306292fac.6
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vpgVl0rz54/wcJJRYuhS7KupO7tVozGVO/Dt9XxVhKA=;
        b=FZTf5KsVZy++JJ28YyaQB5chC3VOjBv+T7w0rtjJ1/EaXlkS9w7P0Qw5aFk6g86uoK
         o1//BMZTUda1+5hchOFt6vNsVTY+tFrYp7X9bvBIke1V/3dcX0Vbces3rcKQPkMpnxl2
         kwsWppNO5KWp0LvmWWI6yi80hXdDh5y1q9FdogfTxzapjIUAZXKVG1ov5ktr27fhx9Z7
         VWHQOVMwFLge7n+JX/t5vpKP2pyaeo7lMmCNJID5NEwsJsmn3YDP0UQs1tCepgO6TEVM
         8tIqHftNiAZIw1xQs8+dVWT5uVl/TEY6TaYXw+nwT2Fo8eWpmbHaztMHeg5U0Wu4Zduc
         A8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vpgVl0rz54/wcJJRYuhS7KupO7tVozGVO/Dt9XxVhKA=;
        b=x3jUuWvU2XFnyzeIBgKTNlAzO/mzGnTcAYaNsa5TADsDbjAW3rU2k9XUMX0++JM1j/
         l3QIsnFp3+vTj03AShtH/NBC03AyeNqI/sB0X/9rPrfd/a8xCtnQSUVmOIm6ogkz8wcD
         g3LAB8LrbVT1fcLlLHte8WqBGvx1IHyxyc+VVRORBPP2+802MmHQicD9HmaN+WF1NHlZ
         JQXacgsXPKzDf+eTBH9KVuUGegLZeh8SB+3Mi3WFqH+hFI3uTBOpBSCB9UUH/P4+VmEz
         oFfnIYTv+H7u3tT4hJfIrjfgXgAGRNjkrKrjqjuSb0jZQdcC9L9d7EhyM/EvbotzcnTv
         Iamg==
X-Gm-Message-State: AJIora/F1nmqEISKVy1FX3Cl5HZmQtmlab6O00JDONF2a0Z6FVk+wcUR
        sn+eoHHVVe3srPvOp0BOfsIQ65RAwMh71g==
X-Google-Smtp-Source: AGRyM1uy3R9hA3suv91h6RC/Ce8bOVorNeMxBE1cPCFziWDlqALB81oJa0NMA5AdQdyWvFnSj5RSwg==
X-Received: by 2002:a05:6870:a191:b0:10b:f366:8d1b with SMTP id a17-20020a056870a19100b0010bf3668d1bmr844228oaf.2.1658518988492;
        Fri, 22 Jul 2022 12:43:08 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id w4-20020a4aa444000000b0041ba884d42csm2162093ool.42.2022.07.22.12.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 12:43:07 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com,
        christian.couder@gmail.com
Subject: [PATCH 1/2] t/t0021: convert the rot13-filter.pl script to C
Date:   Fri, 22 Jul 2022 16:42:49 -0300
Message-Id: <99823077be77bc621cfa8ccf3303bd612da343ad.1658518769.git.matheus.bernardino@usp.br>
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
command. Note, however, that we still use the script as a wrapper at
this commit, in order to minimize the amount of changes it introduces
and help reviewers. At the next commit we will properly remove the
script and adjust the affected tests to use test-tool.

Furthermore, note that there is a small adjustment at test
t0021-conversion.sh because it depended on a specific error message
given by perl's die routine.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Makefile                     |   1 +
 pkt-line.c                   |  13 +-
 pkt-line.h                   |   2 +
 t/helper/test-rot13-filter.c | 396 +++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c         |   1 +
 t/helper/test-tool.h         |   1 +
 t/t0021-conversion.sh        |   2 +-
 t/t0021/rot13-filter.pl      | 248 +---------------------
 8 files changed, 416 insertions(+), 248 deletions(-)
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
index 0000000000..bbad031aee
--- /dev/null
+++ b/t/helper/test-rot13-filter.c
@@ -0,0 +1,396 @@
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
+static struct string_list *packet_read_capabilities(void)
+{
+	struct string_list *caps = xmalloc(sizeof(*caps));
+	string_list_init_dup(caps);
+	while (1) {
+		int size;
+		char *buf = packet_read_line(0, &size);
+		if (!buf)
+			break;
+		string_list_append_nodup(caps,
+					 skip_key_dup(buf, size, "capability"));
+	}
+	return caps;
+}
+
+/* Read remote capabilities and check them against capabilities we require */
+static struct string_list *packet_read_and_check_capabilities(
+		struct string_list *required_caps)
+{
+	struct string_list *remote_caps = packet_read_capabilities();
+	struct string_list_item *item;
+	for_each_string_list_item(item, required_caps) {
+		if (!unsorted_string_list_has_string(remote_caps, item->string)) {
+			die("required '%s' capability not available from remote",
+			    item->string);
+		}
+	}
+	return remote_caps;
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
+	struct string_list *remote_caps, supported_caps = STRING_LIST_INIT_NODUP;
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
+	remote_caps = packet_read_and_check_capabilities(&supported_caps);
+	packet_check_and_write_capabilities(remote_caps, &requested_caps);
+	fprintf(logfile, "init handshake complete\n");
+
+	string_list_clear(&supported_caps, 0);
+	string_list_clear(remote_caps, 0);
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
index 1c840348bd..963b66e08c 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -735,7 +735,7 @@ test_expect_success PERL 'process filter should restart after unexpected write f
 		rm -f debug.log &&
 		git checkout --quiet --no-progress . 2>git-stderr.log &&
 
-		grep "smudge write error at" git-stderr.log &&
+		grep "smudge write error" git-stderr.log &&
 		test_i18ngrep "error: external filter" git-stderr.log &&
 
 		cat >expected.log <<-EOF &&
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 7bb93768f3..1447bc0a24 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -1,247 +1,5 @@
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
 use 5.008;
-sub gitperllib {
-	# Git assumes that all path lists are Unix-y colon-separated ones. But
-	# when the Git for Windows executes the test suite, its MSYS2 Bash
-	# calls git.exe, and colon-separated path lists are converted into
-	# Windows-y semicolon-separated lists of *Windows* paths (which
-	# naturally contain a colon after the drive letter, so splitting by
-	# colons simply does not cut it).
-	#
-	# Detect semicolon-separated path list and handle them appropriately.
 
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
+my @quoted_args = map "'$_'", @ARGV;
+exec "test-tool rot13-filter @quoted_args";
+die "failed to exec test-tool";
-- 
2.37.1

