Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2C731F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 19:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389402AbfAOTko (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 14:40:44 -0500
Received: from mail-yb1-f202.google.com ([209.85.219.202]:56855 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbfAOTko (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 14:40:44 -0500
Received: by mail-yb1-f202.google.com with SMTP id j187so1770917ybj.23
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 11:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DIKxDgKKxKSaykgt3EqAyn+3jrMPTYEjJy0cDSQXe2g=;
        b=mYE7NT0wG7/lhTDf6KM1fs1V3rFNxs9om4JVdi21epMUhDG+7bokl81BOUrm20iIQg
         nb7fp5NvB+vbS/TmHIKOMJBUHV99Vz5Sfpin11ROTuyijJGfj53VWWMTZcY6yfX5KxUN
         YKFh8n0okLNe85RQmB7GPHeikc806gVB5974BacGGnV3DjZq5VCrXrcnHz6uMj6CYfWM
         uzIECeBk1I911m7c7xym5BlTfh/efu5Ll8hNQLQ5PA1h0FviQr1YQAQwMnkIWqOjatNQ
         UIT001MhHslophF/4reml7fSXyNx2RRKhyrShCXE63j3HWqaDUT18Rp6thJXeU0cujBe
         opYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DIKxDgKKxKSaykgt3EqAyn+3jrMPTYEjJy0cDSQXe2g=;
        b=gthtmJ8Rs9QZY0hgdz1pVBOk0dXBKAtq5Yhuz9jiHekJdUNoajevm6u+wXTf1RJPLW
         7380RETUBldEIlfC9yos2u77OB3+eFbYjt0AwwYYSEUTvuexecAK610fPP82gLoBDLVA
         3G8HeDnblzoM+NSQGtYpMRg5w/anejI14i27ZUyazhwOZTeZwldEfm9yw4/+WICl1UGc
         CrbOCZgcZxuDuZdZfNQKEywUdaSw0APhSV6BlfR9dO75P6ZHbPKdCjSKB55wrxdTZ/Oi
         KMi9KVfQ769EyOvT6MbxI9rhNxHNmVQiQZFVMTnU8+KSy6duXEzNvNL0NuUtGtsV22ht
         bQKw==
X-Gm-Message-State: AJcUukfNZGtNvcYDOrGil+ywIBQc9asP0Un9lwznKYP84NjysAcWFL43
        e6BUBIywOxuUNHCJ6E8o/n5jq1ThEglzOlAPTlX65BURhDQZZNjt157mk0r3V/dbR/E57+dZh/M
        wPN6xtH6zFl1ntv0qBoqzzEmfAiXihTqtqYaPo6uvQ1KuIHrllBa7P4ZOjsPoJEblPom+eEmNta
        QK
X-Google-Smtp-Source: ALg8bN67sTr+Z7xG1/kf0NAtQ0BYktTDhwEJprtS71fmgDMGqm6QNRheH/a9sTTNEUFsJWihGTCJU/8Ku8ob3/t3FDe1
X-Received: by 2002:a25:69ca:: with SMTP id e193mr2180128ybc.62.1547581243191;
 Tue, 15 Jan 2019 11:40:43 -0800 (PST)
Date:   Tue, 15 Jan 2019 11:40:29 -0800
In-Reply-To: <cover.1547581039.git.jonathantanmy@google.com>
Message-Id: <d6eefeb9c7e21191223ee6944d87972549fa6515.1547581039.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547244620.git.jonathantanmy@google.com> <cover.1547581039.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2 3/4] {fetch,upload}-pack: sideband v2 fetch response
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, a response to a fetch request has sideband support only while
the packfile is being sent, meaning that the server cannot send notices
until the start of the packfile.

Extend sideband support in protocol v2 fetch responses to the whole
response. upload-pack will advertise it if the
uploadpack.allowsidebandall configuration variable is set, and
fetch-pack will automatically request it if advertised.

If the sideband is to be used throughout the whole response, upload-pack
will use it to send errors instead of prefixing a PKT-LINE payload with
"ERR ".

This will be tested in a subsequent patch.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/protocol-v2.txt | 10 +++++
 fetch-pack.c                            | 12 ++++-
 pkt-line.c                              | 58 ++++++++++++++++++++-----
 pkt-line.h                              |  4 ++
 sideband.c                              |  7 ++-
 sideband.h                              |  2 +-
 upload-pack.c                           | 16 +++++++
 7 files changed, 94 insertions(+), 15 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 09e4e0273f..1b0633f59f 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -307,6 +307,16 @@ the 'wanted-refs' section in the server's response as explained below.
 	particular ref, where <ref> is the full name of a ref on the
 	server.
 
+If the 'sideband-all' feature is advertised, the following argument can be
+included in the client's request:
+
+    sideband-all
+	Instruct the server to send the whole response multiplexed, not just
+	the packfile section. All non-flush and non-delim PKT-LINE in the
+	response (not only in the packfile section) will then start with a byte
+	indicating its sideband (1, 2, or 3), and the server may send "0005\1"
+	(a PKT-LINE of sideband 1 with no payload) as a keepalive packet.
+
 The response of `fetch` is broken into a number of sections separated by
 delimiter packets (0001), with each section beginning with its section
 header.
diff --git a/fetch-pack.c b/fetch-pack.c
index 3f9626dbf7..b89199891d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1125,7 +1125,8 @@ static int add_haves(struct fetch_negotiator *negotiator,
 static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      const struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,
-			      int *haves_to_send, int *in_vain)
+			      int *haves_to_send, int *in_vain,
+			      int sideband_all)
 {
 	int ret = 0;
 	struct strbuf req_buf = STRBUF_INIT;
@@ -1151,6 +1152,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 		packet_buf_write(&req_buf, "include-tag");
 	if (prefer_ofs_delta)
 		packet_buf_write(&req_buf, "ofs-delta");
+	if (sideband_all)
+		packet_buf_write(&req_buf, "sideband-all");
 
 	/* Add shallow-info and deepen request */
 	if (server_supports_feature("fetch", "shallow", 0))
@@ -1359,6 +1362,10 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
+	if (server_supports_feature("fetch", "sideband-all", 0)) {
+		reader.use_sideband = 1;
+		reader.me = "fetch-pack";
+	}
 
 	while (state != FETCH_DONE) {
 		switch (state) {
@@ -1392,7 +1399,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		case FETCH_SEND_REQUEST:
 			if (send_fetch_request(&negotiator, fd[1], args, ref,
 					       &common,
-					       &haves_to_send, &in_vain))
+					       &haves_to_send, &in_vain,
+					       reader.use_sideband))
 				state = FETCH_GET_PACK;
 			else
 				state = FETCH_PROCESS_ACKS;
diff --git a/pkt-line.c b/pkt-line.c
index 5feb73ebec..69162f3990 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -447,7 +447,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 
 	while (1) {
 		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
-		retval = demultiplex_sideband(me, buf, len);
+		retval = demultiplex_sideband(me, buf, len, 0);
 		switch (retval) {
 		case SIDEBAND_PRIMARY:
 			write_or_die(out, buf + 1, len - 1);
@@ -474,6 +474,7 @@ void packet_reader_init(struct packet_reader *reader, int fd,
 	reader->buffer = packet_buffer;
 	reader->buffer_size = sizeof(packet_buffer);
 	reader->options = options;
+	reader->me = "git";
 }
 
 enum packet_read_status packet_reader_read(struct packet_reader *reader)
@@ -483,16 +484,48 @@ enum packet_read_status packet_reader_read(struct packet_reader *reader)
 		return reader->status;
 	}
 
-	reader->status = packet_read_with_status(reader->fd,
-						 &reader->src_buffer,
-						 &reader->src_len,
-						 reader->buffer,
-						 reader->buffer_size,
-						 &reader->pktlen,
-						 reader->options);
+	/*
+	 * Consume all progress and keepalive packets until a primary payload
+	 * packet is received
+	 */
+	while (1) {
+		int retval;
+		reader->status = packet_read_with_status(reader->fd,
+							 &reader->src_buffer,
+							 &reader->src_len,
+							 reader->buffer,
+							 reader->buffer_size,
+							 &reader->pktlen,
+							 reader->options);
+		if (!reader->use_sideband)
+			break;
+		retval = demultiplex_sideband(reader->me, reader->buffer,
+					      reader->pktlen, 1);
+		switch (retval) {
+		case SIDEBAND_PROTOCOL_ERROR:
+		case SIDEBAND_REMOTE_ERROR:
+			BUG("should have died in diagnose_sideband");
+		case SIDEBAND_FLUSH:
+			goto nonprogress_received;
+		case SIDEBAND_PRIMARY:
+			if (reader->pktlen != 1)
+				goto nonprogress_received;
+			/*
+			 * Since the packet contains nothing but the sideband
+			 * designator, this is a keepalive packet. Wait for the
+			 * next one.
+			 */
+			break;
+		default: /* SIDEBAND_PROGRESS */
+			;
+		}
+	}
 
+nonprogress_received:
 	if (reader->status == PACKET_READ_NORMAL)
-		reader->line = reader->buffer;
+		/* Skip the sideband designator if sideband is used */
+		reader->line = reader->use_sideband ?
+			reader->buffer + 1 : reader->buffer;
 	else
 		reader->line = NULL;
 
@@ -514,6 +547,7 @@ enum packet_read_status packet_reader_peek(struct packet_reader *reader)
 void packet_writer_init(struct packet_writer *writer, int dest_fd)
 {
 	writer->dest_fd = dest_fd;
+	writer->use_sideband = 0;
 }
 
 void packet_writer_write(struct packet_writer *writer, const char *fmt, ...)
@@ -521,7 +555,8 @@ void packet_writer_write(struct packet_writer *writer, const char *fmt, ...)
 	va_list args;
 
 	va_start(args, fmt);
-	packet_write_fmt_1(writer->dest_fd, 0, "", fmt, args);
+	packet_write_fmt_1(writer->dest_fd, 0,
+			   writer->use_sideband ? "\001" : "", fmt, args);
 	va_end(args);
 }
 
@@ -530,7 +565,8 @@ void packet_writer_error(struct packet_writer *writer, const char *fmt, ...)
 	va_list args;
 
 	va_start(args, fmt);
-	packet_write_fmt_1(writer->dest_fd, 0, "ERR ", fmt, args);
+	packet_write_fmt_1(writer->dest_fd, 0,
+			   writer->use_sideband ? "\003" : "ERR ", fmt, args);
 	va_end(args);
 }
 
diff --git a/pkt-line.h b/pkt-line.h
index a8e92a4b63..ad9a4a2cd7 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -162,6 +162,9 @@ struct packet_reader {
 
 	/* indicates if a line has been peeked */
 	int line_peeked;
+
+	unsigned use_sideband : 1;
+	const char *me;
 };
 
 /*
@@ -201,6 +204,7 @@ extern char packet_buffer[LARGE_PACKET_MAX];
 
 struct packet_writer {
 	int dest_fd;
+	unsigned use_sideband : 1;
 };
 
 void packet_writer_init(struct packet_writer *writer, int dest_fd);
diff --git a/sideband.c b/sideband.c
index dce22d20b1..9d3051e3fe 100644
--- a/sideband.c
+++ b/sideband.c
@@ -113,7 +113,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 #define ANSI_SUFFIX "\033[K"
 #define DUMB_SUFFIX "        "
 
-int demultiplex_sideband(const char *me, char *buf, int len)
+int demultiplex_sideband(const char *me, char *buf, int len, int die_on_error)
 {
 	static const char *suffix;
 	struct strbuf outbuf = STRBUF_INIT;
@@ -144,6 +144,9 @@ int demultiplex_sideband(const char *me, char *buf, int len)
 	len--;
 	switch (band) {
 	case 3:
+		if (die_on_error)
+			die("remote error: %s", buf + 1);
+
 		strbuf_addf(&outbuf, "%s%s", outbuf.len ? "\n" : "",
 			    DISPLAY_PREFIX);
 		maybe_colorize_sideband(&outbuf, buf + 1, len);
@@ -196,6 +199,8 @@ int demultiplex_sideband(const char *me, char *buf, int len)
 	}
 
 cleanup:
+	if (die_on_error && retval == SIDEBAND_PROTOCOL_ERROR)
+		die("%s", outbuf.buf);
 	if (outbuf.len) {
 		strbuf_addch(&outbuf, '\n');
 		xwrite(2, outbuf.buf, outbuf.len);
diff --git a/sideband.h b/sideband.h
index 7244971231..f75c4fde2a 100644
--- a/sideband.h
+++ b/sideband.h
@@ -15,7 +15,7 @@
  * also prints a message (or the formatted contents of the notice in the case
  * of SIDEBAND_PROGRESS) to stderr.
  */
-int demultiplex_sideband(const char *me, char *buf, int len);
+int demultiplex_sideband(const char *me, char *buf, int len, int die_on_error);
 
 void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_max);
 
diff --git a/upload-pack.c b/upload-pack.c
index 60a26bbbfd..765b7695d2 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -71,6 +71,8 @@ static int allow_filter;
 static int allow_ref_in_want;
 static struct list_objects_filter_options filter_options;
 
+static int allow_sideband_all;
+
 static void reset_timeout(void)
 {
 	alarm(timeout);
@@ -1046,6 +1048,8 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 		allow_filter = git_config_bool(var, value);
 	} else if (!strcmp("uploadpack.allowrefinwant", var)) {
 		allow_ref_in_want = git_config_bool(var, value);
+	} else if (!strcmp("uploadpack.allowsidebandall", var)) {
+		allow_sideband_all = git_config_bool(var, value);
 	}
 
 	if (current_config_scope() != CONFIG_SCOPE_REPO) {
@@ -1284,6 +1288,11 @@ static void process_args(struct packet_reader *request,
 			continue;
 		}
 
+		if (allow_sideband_all && !strcmp(arg, "sideband-all")) {
+			data->writer.use_sideband = 1;
+			continue;
+		}
+
 		/* ignore unknown lines maybe? */
 		die("unexpected line: '%s'", arg);
 	}
@@ -1496,6 +1505,7 @@ int upload_pack_advertise(struct repository *r,
 	if (value) {
 		int allow_filter_value;
 		int allow_ref_in_want;
+		int allow_sideband_all_value;
 
 		strbuf_addstr(value, "shallow");
 
@@ -1510,6 +1520,12 @@ int upload_pack_advertise(struct repository *r,
 					 &allow_ref_in_want) &&
 		    allow_ref_in_want)
 			strbuf_addstr(value, " ref-in-want");
+
+		if (!repo_config_get_bool(the_repository,
+					 "uploadpack.allowsidebandall",
+					 &allow_sideband_all_value) &&
+		    allow_sideband_all_value)
+			strbuf_addstr(value, " sideband-all");
 	}
 
 	return 1;
-- 
2.19.0.271.gfe8321ec05.dirty

