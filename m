Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9703C00140
	for <git@archiver.kernel.org>; Sun, 31 Jul 2022 18:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbiGaSUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jul 2022 14:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiGaSUF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jul 2022 14:20:05 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EE6AE64
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 11:20:01 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id k129so9193187vsk.2
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 11:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=WnNRrWiaplLQNKFpPT+3ZK9tdPl/tdsLuCvepk0x9bI=;
        b=YUY1/pZraS0x1rpTmRylH5fJnFS4QmPtBqEHwnQWHKQntUi5RFPG3HEMuVgMtb8qmb
         KGPP9sGvulV/3a64XOJy8jpvxl16lTVbaNHaFmM+zLQ39mnrrz5xQdoKS6VNK+vx4scj
         iWlVaphTX31QH0MMw3eJoRn8u2kbhs8DFU/qikR2a0etQwdFqaZ2jCGMOVZxjOuuHOGf
         yPET7nMdf7TTd+LWa3iPJYa9FL2LQDY6PkZu5kDNo9t7dZUfwa+jI6//fawVZcBoNA0T
         Lcv5zEFkWLSRHoo9gCI7pQsxhfWU4S5kP+j2WMZSUKL9goIUG1exckqbV5Mh0ERhZy/c
         bD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WnNRrWiaplLQNKFpPT+3ZK9tdPl/tdsLuCvepk0x9bI=;
        b=u1eVtJknSv0IwEFL/fKsTrD8WLh8HfY3/8JXYC3ExDFfVIeutcxww2CYKTNINCgYZK
         tK78sSECWoV2NpMKa3TSy68QU4+0nj+uAjYTdutIONyP99AQVP4QBZtWxNm7GK7kv6jX
         gKdI/0RsIQVxa/gxMrFh9V3Yy4sejjLHTPtYIRUPCtxgy5qCjHFB7Th7qtdSvvdromCp
         mlGIU9UhpSE5ijmhUW3iCoNvmT4zpDSOBvq+XpvV3HZLN0pgvDOrBK1m4bNmXo3Kdrno
         ks4JvwN8JEo405nH5P8bU+uYT0t7lOYX2OUS6mSb37BzJuHJEdaBlcUsHWZzfZZ+qqIq
         SfCA==
X-Gm-Message-State: AJIora9h+XvxpwBzvI+7nDAWAzpBPx/GALDz7npXMoITSxTWKatBFgLx
        Px4dB7f7f6+w9IiaCGwPaY+A01yfxxlcEQ==
X-Google-Smtp-Source: AGRyM1suhU0S7THSiq7qj9l7R4x/TGs4uF206t4Smb7PeawacJa9Z+YIRwDlj6GRLE+Tz8LUhDXOog==
X-Received: by 2002:a67:dd18:0:b0:358:6465:dcc6 with SMTP id y24-20020a67dd18000000b003586465dcc6mr4480752vsj.72.1659291600162;
        Sun, 31 Jul 2022 11:20:00 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id l2-20020a056102050200b003573f2ff61asm3738795vsa.22.2022.07.31.11.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 11:19:59 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, johannes.schindelin@gmx.de
Subject: [PATCH v3 0/3] t0021: convert perl script to C test-tool helper
Date:   Sun, 31 Jul 2022 15:19:47 -0300
Message-Id: <cover.1659291025.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <f38f722de7c3323207eda5ea632b5acd3765c285.1658675222.git.matheus.bernardino@usp.br>
References: <f38f722de7c3323207eda5ea632b5acd3765c285.1658675222.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert t/t0021/rot13-filter.pl to a test-tool helper to avoid the PERL
prereq in various tests.

Changes since v2:

- Split into 3 patches.
- write_packetized_from_buf_no_flush(): s/counter_ptr/packet_counter/ and
  incremented ptr directly.
- Convert write_packetized_from_buf_no_flush_count() to static inline.
- Simplified rot13 routine.
- Avoided memory allocations at skip_key_dup (now get_value()) and
  packet_initialize().
- Replace unsorted list "remote_caps" by strset.
- Simplified packet_read_and_check_capabilities() (now read_capabilities()),
  to test the tree capabilities directly.
- check_and_write_capabilities(): operate on (argv, argc) directly, instead of
  creating a list.
- Moved "struct delay_entry" routines closed to the struct declaration.
- command_loop(): sorted paths after their insertion to the list.
- command_loop(): extracted list_available_blobs logic to separated function.
- Other small refactoring for more idiomatic code.

Matheus Tavares (3):
  t0021: avoid grepping for a Perl-specific string at filter output
  t0021: implementation the rot13-filter.pl script in C
  tests: use the new C rot13-filter helper to avoid PERL prereq

 Makefile                                |   1 +
 pkt-line.c                              |   5 +-
 pkt-line.h                              |   8 +-
 t/helper/test-rot13-filter.c            | 379 ++++++++++++++++++++++++
 t/helper/test-tool.c                    |   1 +
 t/helper/test-tool.h                    |   1 +
 t/t0021-conversion.sh                   |  71 +++--
 t/t0021/rot13-filter.pl                 | 247 ---------------
 t/t2080-parallel-checkout-basics.sh     |   7 +-
 t/t2082-parallel-checkout-attributes.sh |   7 +-
 10 files changed, 431 insertions(+), 296 deletions(-)
 create mode 100644 t/helper/test-rot13-filter.c
 delete mode 100644 t/t0021/rot13-filter.pl

Range-diff against v2:
-:  ---------- > 1:  5ec95c7e69 t0021: avoid grepping for a Perl-specific string at filter output
-:  ---------- > 2:  86e6baba46 t0021: implementation the rot13-filter.pl script in C
1:  f38f722de7 ! 3:  c66fc0a186 t/t0021: convert the rot13-filter.pl script to C
    @@ Metadata
     Author: Matheus Tavares <matheus.bernardino@usp.br>
     
      ## Commit message ##
    -    t/t0021: convert the rot13-filter.pl script to C
    +    tests: use the new C rot13-filter helper to avoid PERL prereq
     
    -    This script is currently used by three test files: t0021-conversion.sh,
    -    t2080-parallel-checkout-basics.sh, and
    -    t2082-parallel-checkout-attributes.sh. To avoid the need for the PERL
    -    dependency at these tests, let's convert the script to a C test-tool
    -    command.
    -
    -    Note that there is a small adjustment needed at test t0021-conversion.sh
    -    because it depended on a specific error message given by perl's die
    -    routine.
    +    The previous commit implemented a C version of the t0021/rot13-filter.pl
    +    script. Let's use this new C helper to eliminate the PERL prereq from
    +    various tests, and also remove the superseded Perl script.
     
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
    - ## Makefile ##
    -@@ Makefile: TEST_BUILTINS_OBJS += test-read-midx.o
    - TEST_BUILTINS_OBJS += test-ref-store.o
    - TEST_BUILTINS_OBJS += test-reftable.o
    - TEST_BUILTINS_OBJS += test-regex.o
    -+TEST_BUILTINS_OBJS += test-rot13-filter.o
    - TEST_BUILTINS_OBJS += test-repository.o
    - TEST_BUILTINS_OBJS += test-revision-walking.o
    - TEST_BUILTINS_OBJS += test-run-command.o
    -
    - ## pkt-line.c ##
    -@@ pkt-line.c: int write_packetized_from_fd_no_flush(int fd_in, int fd_out)
    - 	return err;
    - }
    - 
    --int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_out)
    -+int write_packetized_from_buf_no_flush_count(const char *src_in, size_t len,
    -+					     int fd_out, int *count_ptr)
    - {
    --	int err = 0;
    -+	int err = 0, count = 0;
    - 	size_t bytes_written = 0;
    - 	size_t bytes_to_write;
    - 
    -@@ pkt-line.c: int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_ou
    - 			break;
    - 		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write);
    - 		bytes_written += bytes_to_write;
    -+		count++;
    - 	}
    -+	if (count_ptr)
    -+		*count_ptr = count;
    - 	return err;
    - }
    - 
    -+int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_out)
    -+{
    -+	return write_packetized_from_buf_no_flush_count(src_in, len, fd_out, NULL);
    -+}
    -+
    - static int get_packet_data(int fd, char **src_buf, size_t *src_size,
    - 			   void *dst, unsigned size, int options)
    - {
    -
    - ## pkt-line.h ##
    -@@ pkt-line.h: int packet_flush_gently(int fd);
    - int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
    - int write_packetized_from_fd_no_flush(int fd_in, int fd_out);
    - int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_out);
    -+int write_packetized_from_buf_no_flush_count(const char *src_in, size_t len,
    -+					     int fd_out, int *count_ptr);
    - 
    - /*
    -  * Stdio versions of packet_write functions. When mixing these with fd
    -
    - ## t/helper/test-rot13-filter.c (new) ##
    -@@
    -+/*
    -+ * Example implementation for the Git filter protocol version 2
    -+ * See Documentation/gitattributes.txt, section "Filter Protocol"
    -+ *
    -+ * Usage: test-tool rot13-filter [--always-delay] <log path> <capabilities>
    -+ *
    -+ * Log path defines a debug log file that the script writes to. The
    -+ * subsequent arguments define a list of supported protocol capabilities
    -+ * ("clean", "smudge", etc).
    -+ *
    -+ * When --always-delay is given all pathnames with the "can-delay" flag
    -+ * that don't appear on the list bellow are delayed with a count of 1
    -+ * (see more below).
    -+ *
    -+ * This implementation supports special test cases:
    -+ * (1) If data with the pathname "clean-write-fail.r" is processed with
    -+ *     a "clean" operation then the write operation will die.
    -+ * (2) If data with the pathname "smudge-write-fail.r" is processed with
    -+ *     a "smudge" operation then the write operation will die.
    -+ * (3) If data with the pathname "error.r" is processed with any
    -+ *     operation then the filter signals that it cannot or does not want
    -+ *     to process the file.
    -+ * (4) If data with the pathname "abort.r" is processed with any
    -+ *     operation then the filter signals that it cannot or does not want
    -+ *     to process the file and any file after that is processed with the
    -+ *     same command.
    -+ * (5) If data with a pathname that is a key in the delay hash is
    -+ *     requested (e.g. "test-delay10.a") then the filter responds with
    -+ *     a "delay" status and sets the "requested" field in the delay hash.
    -+ *     The filter will signal the availability of this object after
    -+ *     "count" (field in delay hash) "list_available_blobs" commands.
    -+ * (6) If data with the pathname "missing-delay.a" is processed that the
    -+ *     filter will drop the path from the "list_available_blobs" response.
    -+ * (7) If data with the pathname "invalid-delay.a" is processed that the
    -+ *     filter will add the path "unfiltered" which was not delayed before
    -+ *     to the "list_available_blobs" response.
    -+ */
    -+
    -+#include "test-tool.h"
    -+#include "pkt-line.h"
    -+#include "string-list.h"
    -+#include "strmap.h"
    -+
    -+static FILE *logfile;
    -+static int always_delay;
    -+static struct strmap delay = STRMAP_INIT;
    -+static struct string_list requested_caps = STRING_LIST_INIT_NODUP;
    -+
    -+static int has_capability(const char *cap)
    -+{
    -+	return unsorted_string_list_has_string(&requested_caps, cap);
    -+}
    -+
    -+static char *rot13(char *str)
    -+{
    -+	char *c;
    -+	for (c = str; *c; c++) {
    -+		if (*c >= 'a' && *c <= 'z')
    -+			*c = 'a' + (*c - 'a' + 13) % 26;
    -+		else if (*c >= 'A' && *c <= 'Z')
    -+			*c = 'A' + (*c - 'A' + 13) % 26;
    -+	}
    -+	return str;
    -+}
    -+
    -+static char *skip_key_dup(const char *buf, size_t size, const char *key)
    -+{
    -+	struct strbuf keybuf = STRBUF_INIT;
    -+	strbuf_addf(&keybuf, "%s=", key);
    -+	if (!skip_prefix_mem(buf, size, keybuf.buf, &buf, &size) || !size)
    -+		die("bad %s: '%s'", key, xstrndup(buf, size));
    -+	strbuf_release(&keybuf);
    -+	return xstrndup(buf, size);
    -+}
    -+
    -+/*
    -+ * Read a text packet, expecting that it is in the form "key=value" for
    -+ * the given key. An EOF does not trigger any error and is reported
    -+ * back to the caller with NULL. Die if the "key" part of "key=value" does
    -+ * not match the given key, or the value part is empty.
    -+ */
    -+static char *packet_key_val_read(const char *key)
    -+{
    -+	int size;
    -+	char *buf;
    -+	if (packet_read_line_gently(0, &size, &buf) < 0)
    -+		return NULL;
    -+	return skip_key_dup(buf, size, key);
    -+}
    -+
    -+static void packet_read_capabilities(struct string_list *caps)
    -+{
    -+	while (1) {
    -+		int size;
    -+		char *buf = packet_read_line(0, &size);
    -+		if (!buf)
    -+			break;
    -+		string_list_append_nodup(caps,
    -+					 skip_key_dup(buf, size, "capability"));
    -+	}
    -+}
    -+
    -+/* Read remote capabilities and check them against capabilities we require */
    -+static void packet_read_and_check_capabilities(struct string_list *remote_caps,
    -+					       struct string_list *required_caps)
    -+{
    -+	struct string_list_item *item;
    -+	packet_read_capabilities(remote_caps);
    -+	for_each_string_list_item(item, required_caps) {
    -+		if (!unsorted_string_list_has_string(remote_caps, item->string)) {
    -+			die("required '%s' capability not available from remote",
    -+			    item->string);
    -+		}
    -+	}
    -+}
    -+
    -+/*
    -+ * Check our capabilities we want to advertise against the remote ones
    -+ * and then advertise our capabilities
    -+ */
    -+static void packet_check_and_write_capabilities(struct string_list *remote_caps,
    -+						struct string_list *our_caps)
    -+{
    -+	struct string_list_item *item;
    -+	for_each_string_list_item(item, our_caps) {
    -+		if (!unsorted_string_list_has_string(remote_caps, item->string)) {
    -+			die("our capability '%s' is not available from remote",
    -+			    item->string);
    -+		}
    -+		packet_write_fmt(1, "capability=%s\n", item->string);
    -+	}
    -+	packet_flush(1);
    -+}
    -+
    -+struct delay_entry {
    -+	int requested, count;
    -+	char *output;
    -+};
    -+
    -+static void command_loop(void)
    -+{
    -+	while (1) {
    -+		char *command = packet_key_val_read("command");
    -+		if (!command) {
    -+			fprintf(logfile, "STOP\n");
    -+			break;
    -+		}
    -+		fprintf(logfile, "IN: %s", command);
    -+
    -+		if (!strcmp(command, "list_available_blobs")) {
    -+			struct hashmap_iter iter;
    -+			struct strmap_entry *ent;
    -+			struct string_list_item *str_item;
    -+			struct string_list paths = STRING_LIST_INIT_NODUP;
    -+
    -+			/* flush */
    -+			if (packet_read_line(0, NULL))
    -+				die("bad list_available_blobs end");
    -+
    -+			strmap_for_each_entry(&delay, &iter, ent) {
    -+				struct delay_entry *delay_entry = ent->value;
    -+				if (!delay_entry->requested)
    -+					continue;
    -+				delay_entry->count--;
    -+				if (!strcmp(ent->key, "invalid-delay.a")) {
    -+					/* Send Git a pathname that was not delayed earlier */
    -+					packet_write_fmt(1, "pathname=unfiltered");
    -+				}
    -+				if (!strcmp(ent->key, "missing-delay.a")) {
    -+					/* Do not signal Git that this file is available */
    -+				} else if (!delay_entry->count) {
    -+					string_list_insert(&paths, ent->key);
    -+					packet_write_fmt(1, "pathname=%s", ent->key);
    -+				}
    -+			}
    -+
    -+			/* Print paths in sorted order. */
    -+			for_each_string_list_item(str_item, &paths)
    -+				fprintf(logfile, " %s", str_item->string);
    -+			string_list_clear(&paths, 0);
    -+
    -+			packet_flush(1);
    -+
    -+			fprintf(logfile, " [OK]\n");
    -+			packet_write_fmt(1, "status=success");
    -+			packet_flush(1);
    -+		} else {
    -+			char *buf, *output;
    -+			int size;
    -+			char *pathname;
    -+			struct delay_entry *entry;
    -+			struct strbuf input = STRBUF_INIT;
    -+
    -+			pathname = packet_key_val_read("pathname");
    -+			if (!pathname)
    -+				die("unexpected EOF while expecting pathname");
    -+			fprintf(logfile, " %s", pathname);
    -+
    -+			/* Read until flush */
    -+			buf = packet_read_line(0, &size);
    -+			while (buf) {
    -+				if (!strcmp(buf, "can-delay=1")) {
    -+					entry = strmap_get(&delay, pathname);
    -+					if (entry && !entry->requested) {
    -+						entry->requested = 1;
    -+					} else if (!entry && always_delay) {
    -+						entry = xcalloc(1, sizeof(*entry));
    -+						entry->requested = 1;
    -+						entry->count = 1;
    -+						strmap_put(&delay, pathname, entry);
    -+					}
    -+				} else if (starts_with(buf, "ref=") ||
    -+					   starts_with(buf, "treeish=") ||
    -+					   starts_with(buf, "blob=")) {
    -+					fprintf(logfile, " %s", buf);
    -+				} else {
    -+					/*
    -+					 * In general, filters need to be graceful about
    -+					 * new metadata, since it's documented that we
    -+					 * can pass any key-value pairs, but for tests,
    -+					 * let's be a little stricter.
    -+					 */
    -+					die("Unknown message '%s'", buf);
    -+				}
    -+				buf = packet_read_line(0, &size);
    -+			}
    -+
    -+
    -+			read_packetized_to_strbuf(0, &input, 0);
    -+			fprintf(logfile, " %"PRIuMAX" [OK] -- ", (uintmax_t)input.len);
    -+
    -+			entry = strmap_get(&delay, pathname);
    -+			if (entry && entry->output) {
    -+				output = entry->output;
    -+			} else if (!strcmp(pathname, "error.r") || !strcmp(pathname, "abort.r")) {
    -+				output = "";
    -+			} else if (!strcmp(command, "clean") && has_capability("clean")) {
    -+				output = rot13(input.buf);
    -+			} else if (!strcmp(command, "smudge") && has_capability("smudge")) {
    -+				output = rot13(input.buf);
    -+			} else {
    -+				die("bad command '%s'", command);
    -+			}
    -+
    -+			if (!strcmp(pathname, "error.r")) {
    -+				fprintf(logfile, "[ERROR]\n");
    -+				packet_write_fmt(1, "status=error");
    -+				packet_flush(1);
    -+			} else if (!strcmp(pathname, "abort.r")) {
    -+				fprintf(logfile, "[ABORT]\n");
    -+				packet_write_fmt(1, "status=abort");
    -+				packet_flush(1);
    -+			} else if (!strcmp(command, "smudge") &&
    -+				   (entry = strmap_get(&delay, pathname)) &&
    -+				   entry->requested == 1) {
    -+				fprintf(logfile, "[DELAYED]\n");
    -+				packet_write_fmt(1, "status=delayed");
    -+				packet_flush(1);
    -+				entry->requested = 2;
    -+				entry->output = xstrdup(output);
    -+			} else {
    -+				int i, nr_packets;
    -+				size_t output_len;
    -+				struct strbuf sb = STRBUF_INIT;
    -+				packet_write_fmt(1, "status=success");
    -+				packet_flush(1);
    -+
    -+				strbuf_addf(&sb, "%s-write-fail.r", command);
    -+				if (!strcmp(pathname, sb.buf)) {
    -+					fprintf(logfile, "[WRITE FAIL]\n");
    -+					die("%s write error", command);
    -+				}
    -+
    -+				output_len = strlen(output);
    -+				fprintf(logfile, "OUT: %"PRIuMAX" ", (uintmax_t)output_len);
    -+
    -+				if (write_packetized_from_buf_no_flush_count(output,
    -+					output_len, 1, &nr_packets))
    -+					die("failed to write buffer to stdout");
    -+				packet_flush(1);
    -+
    -+				for (i = 0; i < nr_packets; i++)
    -+					fprintf(logfile, ".");
    -+				fprintf(logfile, " [OK]\n");
    -+
    -+				packet_flush(1);
    -+				strbuf_release(&sb);
    -+			}
    -+			free(pathname);
    -+			strbuf_release(&input);
    -+		}
    -+		free(command);
    -+	}
    -+}
    -+
    -+static void free_delay_hash(void)
    -+{
    -+	struct hashmap_iter iter;
    -+	struct strmap_entry *ent;
    -+
    -+	strmap_for_each_entry(&delay, &iter, ent) {
    -+		struct delay_entry *delay_entry = ent->value;
    -+		free(delay_entry->output);
    -+		free(delay_entry);
    -+	}
    -+	strmap_clear(&delay, 0);
    -+}
    -+
    -+static void add_delay_entry(char *pathname, int count)
    -+{
    -+	struct delay_entry *entry = xcalloc(1, sizeof(*entry));
    -+	entry->count = count;
    -+	if (strmap_put(&delay, pathname, entry))
    -+		BUG("adding the same path twice to delay hash?");
    -+}
    -+
    -+static void packet_initialize(const char *name, int version)
    -+{
    -+	struct strbuf sb = STRBUF_INIT;
    -+	int size;
    -+	char *pkt_buf = packet_read_line(0, &size);
    -+
    -+	strbuf_addf(&sb, "%s-client", name);
    -+	if (!pkt_buf || strncmp(pkt_buf, sb.buf, size))
    -+		die("bad initialize: '%s'", xstrndup(pkt_buf, size));
    -+
    -+	strbuf_reset(&sb);
    -+	strbuf_addf(&sb, "version=%d", version);
    -+	pkt_buf = packet_read_line(0, &size);
    -+	if (!pkt_buf || strncmp(pkt_buf, sb.buf, size))
    -+		die("bad version: '%s'", xstrndup(pkt_buf, size));
    -+
    -+	pkt_buf = packet_read_line(0, &size);
    -+	if (pkt_buf)
    -+		die("bad version end: '%s'", xstrndup(pkt_buf, size));
    -+
    -+	packet_write_fmt(1, "%s-server", name);
    -+	packet_write_fmt(1, "version=%d", version);
    -+	packet_flush(1);
    -+	strbuf_release(&sb);
    -+}
    -+
    -+static char *rot13_usage = "test-tool rot13-filter [--always-delay] <log path> <capabilities>";
    -+
    -+int cmd__rot13_filter(int argc, const char **argv)
    -+{
    -+	int i = 1;
    -+	struct string_list remote_caps = STRING_LIST_INIT_DUP,
    -+			   supported_caps = STRING_LIST_INIT_NODUP;
    -+
    -+	string_list_append(&supported_caps, "clean");
    -+	string_list_append(&supported_caps, "smudge");
    -+	string_list_append(&supported_caps, "delay");
    -+
    -+	if (argc > 1 && !strcmp(argv[i], "--always-delay")) {
    -+		always_delay = 1;
    -+		i++;
    -+	}
    -+	if (argc - i < 2)
    -+		usage(rot13_usage);
    -+
    -+	logfile = fopen(argv[i++], "a");
    -+	if (!logfile)
    -+		die_errno("failed to open log file");
    -+
    -+	for ( ; i < argc; i++)
    -+		string_list_append(&requested_caps, argv[i]);
    -+
    -+	add_delay_entry("test-delay10.a", 1);
    -+	add_delay_entry("test-delay11.a", 1);
    -+	add_delay_entry("test-delay20.a", 2);
    -+	add_delay_entry("test-delay10.b", 1);
    -+	add_delay_entry("missing-delay.a", 1);
    -+	add_delay_entry("invalid-delay.a", 1);
    -+
    -+	fprintf(logfile, "START\n");
    -+
    -+	packet_initialize("git-filter", 2);
    -+
    -+	packet_read_and_check_capabilities(&remote_caps, &supported_caps);
    -+	packet_check_and_write_capabilities(&remote_caps, &requested_caps);
    -+	fprintf(logfile, "init handshake complete\n");
    -+
    -+	string_list_clear(&supported_caps, 0);
    -+	string_list_clear(&remote_caps, 0);
    -+
    -+	command_loop();
    -+
    -+	fclose(logfile);
    -+	string_list_clear(&requested_caps, 0);
    -+	free_delay_hash();
    -+	return 0;
    -+}
    -
    - ## t/helper/test-tool.c ##
    -@@ t/helper/test-tool.c: static struct test_cmd cmds[] = {
    - 	{ "read-midx", cmd__read_midx },
    - 	{ "ref-store", cmd__ref_store },
    - 	{ "reftable", cmd__reftable },
    -+	{ "rot13-filter", cmd__rot13_filter },
    - 	{ "dump-reftable", cmd__dump_reftable },
    - 	{ "regex", cmd__regex },
    - 	{ "repository", cmd__repository },
    -
    - ## t/helper/test-tool.h ##
    -@@ t/helper/test-tool.h: int cmd__read_cache(int argc, const char **argv);
    - int cmd__read_graph(int argc, const char **argv);
    - int cmd__read_midx(int argc, const char **argv);
    - int cmd__ref_store(int argc, const char **argv);
    -+int cmd__rot13_filter(int argc, const char **argv);
    - int cmd__reftable(int argc, const char **argv);
    - int cmd__regex(int argc, const char **argv);
    - int cmd__repository(int argc, const char **argv);
    -
      ## t/t0021-conversion.sh ##
     @@ t/t0021-conversion.sh: tr \
        'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM'
    @@ t/t0021-conversion.sh: test_expect_success PERL 'required process filter with cl
      	rm -rf repo &&
      	mkdir repo &&
      	(
    -@@ t/t0021-conversion.sh: test_expect_success PERL 'process filter should restart after unexpected write f
    - 		rm -f debug.log &&
    - 		git checkout --quiet --no-progress . 2>git-stderr.log &&
    - 
    --		grep "smudge write error at" git-stderr.log &&
    -+		grep "smudge write error" git-stderr.log &&
    - 		test_i18ngrep "error: external filter" git-stderr.log &&
    - 
    - 		cat >expected.log <<-EOF &&
     @@ t/t0021-conversion.sh: test_expect_success PERL 'process filter should restart after unexpected write f
      	)
      '
-- 
2.37.1

