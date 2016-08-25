Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEE751F859
	for <e@80x24.org>; Thu, 25 Aug 2016 12:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932704AbcHYMCy (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 08:02:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33930 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755503AbcHYMCx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 08:02:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so7101805wma.1
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 05:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=bzmvgSIXq1h7JmWwz3VY3kOeOhK0dDNL4x2o3K7M5nM=;
        b=CsHP+uikcCz1DwZteQjJarkgGmDvf3B0Ujl2bwm6//GLV2sNNcWpqoQ81eVhd+5Tfe
         pu9Uv3DnPmprUh27bPKHiqFjgONRPl/7snu4gdV7iK65NmMkl3SicaX/C5g/ZcUmyq2l
         2ez6BOx5HBYc1TsNBZCxJwHSoXShcUv/b1IWU0W0p6U/uOPaPhCeDHFLEdJ7QEkwE5kK
         WnGg/rEcx9ZIsBIoEixwzO5OBsdJRCN3wQZ+ukMI719k5X/6R1TSN9o3r8otdsJX9mwR
         aZfElVoGqhzMj1gsiySpxrPxuTmTid8IEOu7jfzVwK/B6fhL8I9rnsV171W9GSx9fIZj
         KVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bzmvgSIXq1h7JmWwz3VY3kOeOhK0dDNL4x2o3K7M5nM=;
        b=mAASKmpNkkdUeoERhF0wHujqutG7DI2ay7Eoj7zZPDSYkGNUevP03DxylHRrA+eJK4
         Qc6GGf11eskHljrU4qSmL7yAM0E8CW6F8bfwPNEoN3U/7ftul8wzYPL4WZKQIbChhYQ2
         jApdEngKo0zlELTqTe1hK/Ggw03N7TWrg7d4bej3UuqfjeRxKIp7xxtqfH6sU7jDBCP3
         PkY3nJgVBfbfGdQ0o5gcB3vNewkMAqEfetRnogkzs6nw8/lLbB5J6LGVqf4Ce0msctAC
         6LT9ANlU5oNpLK7/sXKFG8ZUlnO3iB71HvOxxm5iQn7P1V4G+UCHPngSzLfup9LTy7Rn
         JXpg==
X-Gm-Message-State: AEkoouve4g/vBxAERl9+FmADkKtFRqROrZ8j+s2tGRHu/BEBJjjmdkZZZO8nxc0sg3BlGw==
X-Received: by 10.28.17.9 with SMTP id 9mr27714653wmr.73.1472123276268;
        Thu, 25 Aug 2016 04:07:56 -0700 (PDT)
Received: from bcnf9f9l32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id p71sm38304839wmf.9.2016.08.25.04.07.54
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 25 Aug 2016 04:07:55 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v6 00/13] Git filter protocol
Date:   Thu, 25 Aug 2016 13:07:39 +0200
Message-Id: <20160825110752.31581-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

The goal of this series is to avoid launching a new clean/smudge filter
process for each file that is filtered.

A short summary about v1 to v5 can be found here:
https://git.github.io/rev_news/2016/08/17/edition-18/

This series is also published on web:
https://github.com/larsxschneider/git/pull/10

Thanks a lot for your reviews,
Lars


## Changes since v5

### Peff
* http://public-inbox.org/git/20160810131541.ovpvgwdxjibae5gy%40sigill.intra.peff.net/
    * drop patch "pkt-line: add `gentle` parameter to format_packet()"
* http://public-inbox.org/git/20160810143321.q7mjirgr5ynml5ff@sigill.intra.peff.net/
    * drop patch "pkt-line: call packet_trace() only if a packet is actually send"
* http://public-inbox.org/git/20160810132814.gqnipsdwyzjmuqjy%40sigill.intra.peff.net/
    * make pkt-line write buffer static
    * replace PKTLINE_DATA_MAXLEN with sizeof(packet_write_buffer) - 4)
      in pkt-line.c to --> makes it easier to see that things are correct
* http://public-inbox.org/git/20160810133745.wagccvvf35o3pbwb%40sigill.intra.peff.net/
    * check max content length before using packet_write_fmt_gently()


### Junio
* http://public-inbox.org/git/xmqqpopg5yqf.fsf%40gitster.mtv.corp.google.com/
    *  change packet_write_gently_fmt() to packet_write_fmt_gently()
* http://public-inbox.org/git/xmqq8tw45vtg.fsf@gitster.mtv.corp.google.com/
    * rename packet_write() to packet_write_fmt() before adding new functions


## Stefan
* http://public-inbox.org/git/CAGZ79kboxgBRHSa2s7CKZ1Uo%3D13WT%3DrT8VHCNJNj_Q9jQzZAYw%40mail.gmail.com/
    * state more clearly that everything after version=2 is specific to version=2
    * do not duplicate protocol in commit message,
      summarize design decisions instead
    * use single line comment
    * remove unnessary braces


## Dscho
* http://public-inbox.org/git/alpine.DEB.2.20.1608181617240.4924@virtualbox/
    * wrap commit messages at 72
    * s/CLOEXEX/CLOEXEC/


## Interdiff (v5..v6)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 6e563a6..6346700 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -393,13 +393,20 @@ standard input and standard output.

 Git starts the filter when it encounters the first file
 that needs to be cleaned or smudged. After the filter started
-Git sends a welcome message, a list of supported protocol
-version numbers, and a flush packet. Git expects to read the
-welcome message and one protocol version number from the
-previously sent list. Afterwards Git sends a list of supported
-capabilities and a flush packet. Git expects to read a list of
-desired capabilities, which must be a subset of the supported
-capabilities list, and a flush packet as response:
+Git sends a welcome message ("git-filter-client"), a list of
+supported protocol version numbers, and a flush packet. Git expects
+to read a welcome response message ("git-filter-server") and exactly
+one protocol version number from the previously sent list. All further
+communication will be based on the selected version. The remaining
+protocol description below documents "version=2". Please note that
+"version=42" in the example below does not exist and is only there
+to illustrate how the protocol would look like with more than one
+version.
+
+After the version negotiation Git sends a list of supported capabilities
+and a flush packet. Git expects to read a list of desired capabilities,
+which must be a subset of the supported capabilities list, and a flush
+packet as response:
 ------------------------
 packet:          git> git-filter-client
 packet:          git> version=2
diff --git a/convert.c b/convert.c
index e421f4a..362a0af 100644
--- a/convert.c
+++ b/convert.c
@@ -530,7 +530,9 @@ static int packet_write_list(int fd, const char *line, ...)
  {
    if (!line)
      break;
-   err = packet_write_gently_fmt(fd, "%s", line);
+   if (strlen(line) > PKTLINE_DATA_MAXLEN)
+     return -1;
+   err = packet_write_fmt_gently(fd, "%s", line);
    if (err)
      return err;
    line = va_arg(args, const char*);
@@ -686,11 +688,18 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len

  sigchain_push(SIGPIPE, SIG_IGN);

- err = packet_write_gently_fmt(process->in, "command=%s\n", filter_type);
+
+ err = (strlen(filter_type) > PKTLINE_DATA_MAXLEN);
+ if (err)
+   goto done;
+ err = packet_write_fmt_gently(process->in, "command=%s\n", filter_type);
  if (err)
    goto done;

- err = packet_write_gently_fmt(process->in, "pathname=%s\n", path);
+ err = (strlen(path) > PKTLINE_DATA_MAXLEN);
+ if (err)
+   goto done;
+ err = packet_write_fmt_gently(process->in, "pathname=%s\n", path);
  if (err)
    goto done;

@@ -722,9 +731,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len

  if (err || errno == EPIPE) {
    if (!strcmp(filter_status.buf, "error")) {
-     /*
-        * The filter signaled a problem with the file.
-        */
+     /* The filter signaled a problem with the file. */
    } else if (!strcmp(filter_status.buf, "error-all")) {
      /*
       * The filter signaled a permanent problem. Don't try to filter
@@ -818,9 +825,8 @@ static int read_convert_config(const char *var, const char *value, void *cb)
  if (!strcmp("clean", key))
    return git_config_string(&drv->clean, var, value);

- if (!strcmp("process", key)) {
+ if (!strcmp("process", key))
    return git_config_string(&drv->process, var, value);
- }

  if (!strcmp("required", key)) {
    drv->required = git_config_bool(var, value);
diff --git a/pkt-line.c b/pkt-line.c
index b98e291..3033aa3 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -3,7 +3,7 @@
 #include "run-command.h"

 char packet_buffer[LARGE_PACKET_MAX];
-char packet_write_buffer[LARGE_PACKET_MAX];
+static char packet_write_buffer[LARGE_PACKET_MAX];
 static const char *packet_trace_prefix = "git";
 static struct trace_key trace_packet = TRACE_KEY_INIT(PACKET);
 static struct trace_key trace_pack = TRACE_KEY_INIT(PACKFILE);
@@ -107,6 +107,7 @@ void packet_buf_flush(struct strbuf *buf)
 static void set_packet_header(char *buf, const int size)
 {
  static char hexchar[] = "0123456789abcdef";
+
  #define hex(a) (hexchar[(a) & 15])
  buf[0] = hex(size >> 12);
  buf[1] = hex(size >> 8);
@@ -115,7 +116,7 @@ static void set_packet_header(char *buf, const int size)
  #undef hex
 }

-static int format_packet(int gentle, struct strbuf *out, const char *fmt, va_list args)
+static void format_packet(struct strbuf *out, const char *fmt, va_list args)
 {
  size_t orig_len, n;

@@ -124,15 +125,11 @@ static int format_packet(int gentle, struct strbuf *out, const char *fmt, va_lis
  strbuf_vaddf(out, fmt, args);
  n = out->len - orig_len;

- if (n > LARGE_PACKET_MAX) {
-   if (gentle)
-     return -1;
-   else
-     die("protocol error: impossibly long line");
- }
+ if (n > LARGE_PACKET_MAX)
+   die("protocol error: impossibly long line");

  set_packet_header(&out->buf[orig_len], n);
- return 0;
+ packet_trace(out->buf + orig_len + 4, n - 4, 1);
 }

 void packet_write_fmt(int fd, const char *fmt, ...)
@@ -142,28 +139,26 @@ void packet_write_fmt(int fd, const char *fmt, ...)

  strbuf_reset(&buf);
  va_start(args, fmt);
- format_packet(0, &buf, fmt, args);
+ format_packet(&buf, fmt, args);
  va_end(args);
- packet_trace(buf.buf + 4, buf.len - 4, 1);
  write_or_die(fd, buf.buf, buf.len);
 }

-int packet_write_gently_fmt(int fd, const char *fmt, ...)
+int packet_write_fmt_gently(int fd, const char *fmt, ...)
 {
  static struct strbuf buf = STRBUF_INIT;
  va_list args;

  strbuf_reset(&buf);
  va_start(args, fmt);
- format_packet(1, &buf, fmt, args);
+ format_packet(&buf, fmt, args);
  va_end(args);
- packet_trace(buf.buf + 4, buf.len - 4, 1);
  return (write_in_full(fd, buf.buf, buf.len) == buf.len ? 0 : -1);
 }

 int packet_write_gently(const int fd_out, const char *buf, size_t size)
 {
- if (size > PKTLINE_DATA_MAXLEN)
+ if (size > sizeof(packet_write_buffer) - 4)
    return -1;
  packet_trace(buf, size, 1);
  memmove(packet_write_buffer + 4, buf, size);
@@ -177,7 +172,7 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
  va_list args;

  va_start(args, fmt);
- format_packet(0, buf, fmt, args);
+ format_packet(buf, fmt, args);
  va_end(args);
 }

@@ -185,13 +180,14 @@ int packet_write_stream_with_flush_from_fd(int fd_in, int fd_out)
 {
  int err = 0;
  ssize_t bytes_to_write;
+
  while (!err) {
-   bytes_to_write = xread(fd_in, packet_write_buffer, PKTLINE_DATA_MAXLEN);
+   bytes_to_write = xread(fd_in, packet_write_buffer, sizeof(packet_write_buffer) - 4);
    if (bytes_to_write < 0)
      return COPY_READ_ERROR;
    if (bytes_to_write == 0)
      break;
-   if (bytes_to_write > PKTLINE_DATA_MAXLEN)
+   if (bytes_to_write > sizeof(packet_write_buffer) - 4)
      return COPY_WRITE_ERROR;
    err = packet_write_gently(fd_out, packet_write_buffer, bytes_to_write);
  }
@@ -205,9 +201,10 @@ int packet_write_stream_with_flush_from_buf(const char *src_in, size_t len, int
  int err = 0;
  size_t bytes_written = 0;
  size_t bytes_to_write;
+
  while (!err) {
-   if ((len - bytes_written) > PKTLINE_DATA_MAXLEN)
-     bytes_to_write = PKTLINE_DATA_MAXLEN;
+   if ((len - bytes_written) > sizeof(packet_write_buffer) - 4)
+     bytes_to_write = sizeof(packet_write_buffer) - 4;
    else
      bytes_to_write = len - bytes_written;
    if (bytes_to_write == 0)
diff --git a/pkt-line.h b/pkt-line.h
index ddd6041..6a3b7cf 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -24,7 +24,7 @@ void packet_write_fmt(int fd, const char *fmt, ...) __attribute__((format (print
 void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int packet_flush_gently(int fd);
-int packet_write_gently_fmt(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int packet_write_stream_with_flush_from_fd(int fd_in, int fd_out);
 int packet_write_stream_with_flush_from_buf(const char *src_in, size_t len, int fd_out);



Lars Schneider (13):
  pkt-line: rename packet_write() to packet_write_fmt()
  pkt-line: extract set_packet_header()
  pkt-line: add packet_write_fmt_gently()
  pkt-line: add packet_flush_gently()
  pkt-line: add packet_write_gently()
  pkt-line: add functions to read/write flush terminated packet streams
  pack-protocol: fix maximum pkt-line size
  convert: quote filter names in error messages
  convert: modernize tests
  convert: generate large test files only once
  convert: make apply_filter() adhere to standard Git error handling
  convert: add filter.<driver>.process option
  read-cache: make sure file handles are not inherited by child
    processes

 Documentation/gitattributes.txt             | 146 ++++++++-
 Documentation/technical/protocol-common.txt |   6 +-
 builtin/archive.c                           |   4 +-
 builtin/receive-pack.c                      |   4 +-
 builtin/remote-ext.c                        |   4 +-
 builtin/upload-archive.c                    |   4 +-
 connect.c                                   |   2 +-
 convert.c                                   | 373 ++++++++++++++++++---
 daemon.c                                    |   2 +-
 http-backend.c                              |   2 +-
 pkt-line.c                                  | 142 +++++++-
 pkt-line.h                                  |  12 +-
 read-cache.c                                |   2 +-
 shallow.c                                   |   2 +-
 t/t0021-conversion.sh                       | 482 +++++++++++++++++++++++++---
 t/t0021/rot13-filter.pl                     | 176 ++++++++++
 unpack-trees.c                              |   1 +
 upload-pack.c                               |  30 +-
 18 files changed, 1272 insertions(+), 122 deletions(-)
 create mode 100755 t/t0021/rot13-filter.pl

--
2.9.2

