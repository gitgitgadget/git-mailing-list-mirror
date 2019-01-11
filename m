Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52431211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 22:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfAKWSk (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 17:18:40 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:34400 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfAKWSj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 17:18:39 -0500
Received: by mail-pf1-f201.google.com with SMTP id u20so11386684pfa.1
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 14:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6+0q0gQ23/SFGeoicC5zoMmtHFtn2A0fuBIL3tZ4MLU=;
        b=MqzeoYqbswfCTpZnRylkkwNtcpVyX55nuJTqyCI2Xo/sWIlNJzfknK3OTpD/D+u72J
         gPpAiCFKg0Ps4MZHYiyk4jL7ETPTBk5I3VDuEZh7sKVdjgv6OaEM4oMxijFfbviYVqPa
         Nx95j1Ti/Kp1FSXO3u7rklPOldEcmacON5jL+JuSwAkbr89Z9kXZ/vx+iq1DkzYAbKUv
         MxjQ43Rc0wTUrDKcpKxyiLCTULzvEhgf2P7kOrBKwtGOS1oVPouSdfi84ogOWMRXvlvM
         J9LdQbOxjZNYP5pJy0DCCeygaOh4weq6geJVEHPTg03VrvdXwzySZkiKzyCksAsxVfDF
         DFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6+0q0gQ23/SFGeoicC5zoMmtHFtn2A0fuBIL3tZ4MLU=;
        b=OGKFKET4+MD9OdU9jHrNRajTTGcElz/001/atqcs1wqYRukD/Xcj8fSuprPKBFynX4
         UovDq6v+F6CuCRVMsiilJRQgwuieCyhy8UOmvhZBk2uPvJVlX3be+zgVJxNhlO6Y6LfN
         4RJWx9X9USYONWkzahGs/oJXlUP2JTJHlo/chrFqWPs2vL4HTN6imuabXhqQmn32gbck
         +o1yZ8/Spc2HWTQw0CbHOzWZj89R6TU8caPqCgRlwYfxBDNiQvku2ExDKpMP02N5YslN
         fACqBt3Y7fjQ+zvbcNIDrCi4TApSfd62D6i3ffLyaRckCSa6GzL6YHxShLdRTF/6XclN
         meDQ==
X-Gm-Message-State: AJcUukc4QIC37Z+tZTHng4e8cM2v1WSauuiFK7v47me4dJu7zvuJR2Dn
        fsvezYMIZhFA4L19cUg64QLcuKc+hfP7BPRxynS6kaqjDj4QndXpLLp8MLqHpKmulCw1KOruqFy
        g1JJd8+c7eSi7dxkjTUa1ZprwtoeXc7b3j6Cs4GYxu0R00trXVv30AJIBAcn1q01h9D00bv6bqo
        Wk
X-Google-Smtp-Source: ALg8bN5x1n4fxN0VcpqR8/9qjhiFDI/oumi8G/qWrB6uCnim/Oi1G80elxbO3pFYJLB+cCjSbguGxyCri8QOfOLk1jSb
X-Received: by 2002:a65:5c07:: with SMTP id u7mr1138034pgr.36.1547245118334;
 Fri, 11 Jan 2019 14:18:38 -0800 (PST)
Date:   Fri, 11 Jan 2019 14:18:14 -0800
In-Reply-To: <cover.1547244620.git.jonathantanmy@google.com>
Message-Id: <9b37e68e2f0d83ea133f6662efb780466c518170.1547244620.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547244620.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 1/4] pkt-line: introduce struct packet_writer
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It will be convenient for a future patch if writing options
(specifically, whether the written data is to be multiplexed) could be
controlled from a single place, so create struct packet_writer to serve
as that place, and modify upload-pack to use it.

Currently, it only stores the output fd, but a subsequent patch will (as
described above) introduce an option to determine if the written data is
to be multiplexed.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 pkt-line.c    |  47 ++++++++++++++++++---
 pkt-line.h    |  14 +++++++
 upload-pack.c | 112 +++++++++++++++++++++++++++-----------------------
 3 files changed, 115 insertions(+), 58 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index e70ea6d88f..9d3e402d41 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -129,12 +129,14 @@ static void set_packet_header(char *buf, const int size)
 	#undef hex
 }
 
-static void format_packet(struct strbuf *out, const char *fmt, va_list args)
+static void format_packet(struct strbuf *out, const char *prefix,
+			  const char *fmt, va_list args)
 {
 	size_t orig_len, n;
 
 	orig_len = out->len;
 	strbuf_addstr(out, "0000");
+	strbuf_addstr(out, prefix);
 	strbuf_vaddf(out, fmt, args);
 	n = out->len - orig_len;
 
@@ -145,13 +147,13 @@ static void format_packet(struct strbuf *out, const char *fmt, va_list args)
 	packet_trace(out->buf + orig_len + 4, n - 4, 1);
 }
 
-static int packet_write_fmt_1(int fd, int gently,
+static int packet_write_fmt_1(int fd, int gently, const char *prefix,
 			      const char *fmt, va_list args)
 {
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	format_packet(&buf, fmt, args);
+	format_packet(&buf, prefix, fmt, args);
 	if (write_in_full(fd, buf.buf, buf.len) < 0) {
 		if (!gently) {
 			check_pipe(errno);
@@ -168,7 +170,7 @@ void packet_write_fmt(int fd, const char *fmt, ...)
 	va_list args;
 
 	va_start(args, fmt);
-	packet_write_fmt_1(fd, 0, fmt, args);
+	packet_write_fmt_1(fd, 0, "", fmt, args);
 	va_end(args);
 }
 
@@ -178,7 +180,7 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
 	va_list args;
 
 	va_start(args, fmt);
-	status = packet_write_fmt_1(fd, 1, fmt, args);
+	status = packet_write_fmt_1(fd, 1, "", fmt, args);
 	va_end(args);
 	return status;
 }
@@ -211,7 +213,7 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 	va_list args;
 
 	va_start(args, fmt);
-	format_packet(buf, fmt, args);
+	format_packet(buf, "", fmt, args);
 	va_end(args);
 }
 
@@ -486,3 +488,36 @@ enum packet_read_status packet_reader_peek(struct packet_reader *reader)
 	reader->line_peeked = 1;
 	return reader->status;
 }
+
+void packet_writer_init(struct packet_writer *writer, int dest_fd)
+{
+	writer->dest_fd = dest_fd;
+}
+
+void packet_writer_write(struct packet_writer *writer, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	packet_write_fmt_1(writer->dest_fd, 0, "", fmt, args);
+	va_end(args);
+}
+
+void packet_writer_error(struct packet_writer *writer, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	packet_write_fmt_1(writer->dest_fd, 0, "ERR ", fmt, args);
+	va_end(args);
+}
+
+void packet_writer_delim(struct packet_writer *writer)
+{
+	packet_delim(writer->dest_fd);
+}
+
+void packet_writer_flush(struct packet_writer *writer)
+{
+	packet_flush(writer->dest_fd);
+}
diff --git a/pkt-line.h b/pkt-line.h
index d7e1dbc047..023ad2951d 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -183,4 +183,18 @@ extern enum packet_read_status packet_reader_peek(struct packet_reader *reader);
 #define LARGE_PACKET_DATA_MAX (LARGE_PACKET_MAX - 4)
 extern char packet_buffer[LARGE_PACKET_MAX];
 
+struct packet_writer {
+	int dest_fd;
+};
+
+void packet_writer_init(struct packet_writer *writer, int dest_fd);
+
+/* These functions die upon failure. */
+__attribute__((format (printf, 2, 3)))
+void packet_writer_write(struct packet_writer *writer, const char *fmt, ...);
+__attribute__((format (printf, 2, 3)))
+void packet_writer_error(struct packet_writer *writer, const char *fmt, ...);
+void packet_writer_delim(struct packet_writer *writer);
+void packet_writer_flush(struct packet_writer *writer);
+
 #endif
diff --git a/upload-pack.c b/upload-pack.c
index 08b547cf01..60a26bbbfd 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -613,13 +613,14 @@ static void check_non_tip(struct object_array *want_obj)
 	}
 }
 
-static void send_shallow(struct commit_list *result)
+static void send_shallow(struct packet_writer *writer,
+			 struct commit_list *result)
 {
 	while (result) {
 		struct object *object = &result->item->object;
 		if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
-			packet_write_fmt(1, "shallow %s",
-					 oid_to_hex(&object->oid));
+			packet_writer_write(writer, "shallow %s",
+					    oid_to_hex(&object->oid));
 			register_shallow(the_repository, &object->oid);
 			shallow_nr++;
 		}
@@ -627,7 +628,8 @@ static void send_shallow(struct commit_list *result)
 	}
 }
 
-static void send_unshallow(const struct object_array *shallows,
+static void send_unshallow(struct packet_writer *writer,
+			   const struct object_array *shallows,
 			   struct object_array *want_obj)
 {
 	int i;
@@ -636,8 +638,8 @@ static void send_unshallow(const struct object_array *shallows,
 		struct object *object = shallows->objects[i].item;
 		if (object->flags & NOT_SHALLOW) {
 			struct commit_list *parents;
-			packet_write_fmt(1, "unshallow %s",
-					 oid_to_hex(&object->oid));
+			packet_writer_write(writer, "unshallow %s",
+					    oid_to_hex(&object->oid));
 			object->flags &= ~CLIENT_SHALLOW;
 			/*
 			 * We want to _register_ "object" as shallow, but we
@@ -662,7 +664,7 @@ static void send_unshallow(const struct object_array *shallows,
 	}
 }
 
-static void deepen(int depth, int deepen_relative,
+static void deepen(struct packet_writer *writer, int depth, int deepen_relative,
 		   struct object_array *shallows, struct object_array *want_obj)
 {
 	if (depth == INFINITE_DEPTH && !is_repository_shallow(the_repository)) {
@@ -680,7 +682,7 @@ static void deepen(int depth, int deepen_relative,
 		result = get_shallow_commits(&reachable_shallows,
 					     depth + 1,
 					     SHALLOW, NOT_SHALLOW);
-		send_shallow(result);
+		send_shallow(writer, result);
 		free_commit_list(result);
 		object_array_clear(&reachable_shallows);
 	} else {
@@ -688,14 +690,15 @@ static void deepen(int depth, int deepen_relative,
 
 		result = get_shallow_commits(want_obj, depth,
 					     SHALLOW, NOT_SHALLOW);
-		send_shallow(result);
+		send_shallow(writer, result);
 		free_commit_list(result);
 	}
 
-	send_unshallow(shallows, want_obj);
+	send_unshallow(writer, shallows, want_obj);
 }
 
-static void deepen_by_rev_list(int ac, const char **av,
+static void deepen_by_rev_list(struct packet_writer *writer, int ac,
+			       const char **av,
 			       struct object_array *shallows,
 			       struct object_array *want_obj)
 {
@@ -703,13 +706,14 @@ static void deepen_by_rev_list(int ac, const char **av,
 
 	close_commit_graph(the_repository);
 	result = get_shallow_commits_by_rev_list(ac, av, SHALLOW, NOT_SHALLOW);
-	send_shallow(result);
+	send_shallow(writer, result);
 	free_commit_list(result);
-	send_unshallow(shallows, want_obj);
+	send_unshallow(writer, shallows, want_obj);
 }
 
 /* Returns 1 if a shallow list is sent or 0 otherwise */
-static int send_shallow_list(int depth, int deepen_rev_list,
+static int send_shallow_list(struct packet_writer *writer,
+			     int depth, int deepen_rev_list,
 			     timestamp_t deepen_since,
 			     struct string_list *deepen_not,
 			     struct object_array *shallows,
@@ -720,7 +724,7 @@ static int send_shallow_list(int depth, int deepen_rev_list,
 	if (depth > 0 && deepen_rev_list)
 		die("git upload-pack: deepen and deepen-since (or deepen-not) cannot be used together");
 	if (depth > 0) {
-		deepen(depth, deepen_relative, shallows, want_obj);
+		deepen(writer, depth, deepen_relative, shallows, want_obj);
 		ret = 1;
 	} else if (deepen_rev_list) {
 		struct argv_array av = ARGV_ARRAY_INIT;
@@ -741,7 +745,7 @@ static int send_shallow_list(int depth, int deepen_rev_list,
 			struct object *o = want_obj->objects[i].item;
 			argv_array_push(&av, oid_to_hex(&o->oid));
 		}
-		deepen_by_rev_list(av.argc, av.argv, shallows, want_obj);
+		deepen_by_rev_list(writer, av.argc, av.argv, shallows, want_obj);
 		argv_array_clear(&av);
 		ret = 1;
 	} else {
@@ -834,8 +838,10 @@ static void receive_needs(struct packet_reader *reader, struct object_array *wan
 	int has_non_tip = 0;
 	timestamp_t deepen_since = 0;
 	int deepen_rev_list = 0;
+	struct packet_writer writer;
 
 	shallow_nr = 0;
+	packet_writer_init(&writer, 1);
 	for (;;) {
 		struct object *o;
 		const char *features;
@@ -892,9 +898,9 @@ static void receive_needs(struct packet_reader *reader, struct object_array *wan
 
 		o = parse_object(the_repository, &oid_buf);
 		if (!o) {
-			packet_write_fmt(1,
-					 "ERR upload-pack: not our ref %s",
-					 oid_to_hex(&oid_buf));
+			packet_writer_error(&writer,
+					    "upload-pack: not our ref %s",
+					    oid_to_hex(&oid_buf));
 			die("git upload-pack: not our ref %s",
 			    oid_to_hex(&oid_buf));
 		}
@@ -923,7 +929,7 @@ static void receive_needs(struct packet_reader *reader, struct object_array *wan
 	if (depth == 0 && !deepen_rev_list && shallows.nr == 0)
 		return;
 
-	if (send_shallow_list(depth, deepen_rev_list, deepen_since,
+	if (send_shallow_list(&writer, depth, deepen_rev_list, deepen_since,
 			      &deepen_not, &shallows, want_obj))
 		packet_flush(1);
 	object_array_clear(&shallows);
@@ -1102,6 +1108,8 @@ struct upload_pack_data {
 	int deepen_rev_list;
 	int deepen_relative;
 
+	struct packet_writer writer;
+
 	unsigned stateless_rpc : 1;
 
 	unsigned use_thin_pack : 1;
@@ -1125,6 +1133,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	data->haves = haves;
 	data->shallows = shallows;
 	data->deepen_not = deepen_not;
+	packet_writer_init(&data->writer, 1);
 }
 
 static void upload_pack_data_clear(struct upload_pack_data *data)
@@ -1136,7 +1145,8 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
 	string_list_clear(&data->deepen_not, 0);
 }
 
-static int parse_want(const char *line, struct object_array *want_obj)
+static int parse_want(struct packet_writer *writer, const char *line,
+		      struct object_array *want_obj)
 {
 	const char *arg;
 	if (skip_prefix(line, "want ", &arg)) {
@@ -1149,9 +1159,9 @@ static int parse_want(const char *line, struct object_array *want_obj)
 
 		o = parse_object(the_repository, &oid);
 		if (!o) {
-			packet_write_fmt(1,
-					 "ERR upload-pack: not our ref %s",
-					 oid_to_hex(&oid));
+			packet_writer_error(writer,
+					    "upload-pack: not our ref %s",
+					    oid_to_hex(&oid));
 			die("git upload-pack: not our ref %s",
 			    oid_to_hex(&oid));
 		}
@@ -1167,7 +1177,8 @@ static int parse_want(const char *line, struct object_array *want_obj)
 	return 0;
 }
 
-static int parse_want_ref(const char *line, struct string_list *wanted_refs,
+static int parse_want_ref(struct packet_writer *writer, const char *line,
+			  struct string_list *wanted_refs,
 			  struct object_array *want_obj)
 {
 	const char *arg;
@@ -1177,7 +1188,7 @@ static int parse_want_ref(const char *line, struct string_list *wanted_refs,
 		struct object *o;
 
 		if (read_ref(arg, &oid)) {
-			packet_write_fmt(1, "ERR unknown ref %s", arg);
+			packet_writer_error(writer, "unknown ref %s", arg);
 			die("unknown ref %s", arg);
 		}
 
@@ -1220,10 +1231,11 @@ static void process_args(struct packet_reader *request,
 		const char *p;
 
 		/* process want */
-		if (parse_want(arg, want_obj))
+		if (parse_want(&data->writer, arg, want_obj))
 			continue;
 		if (allow_ref_in_want &&
-		    parse_want_ref(arg, &data->wanted_refs, want_obj))
+		    parse_want_ref(&data->writer, arg, &data->wanted_refs,
+				   want_obj))
 			continue;
 		/* process have line */
 		if (parse_have(arg, &data->haves))
@@ -1317,26 +1329,26 @@ static int process_haves(struct oid_array *haves, struct oid_array *common,
 	return 0;
 }
 
-static int send_acks(struct oid_array *acks, struct strbuf *response,
+static int send_acks(struct packet_writer *writer, struct oid_array *acks,
 		     const struct object_array *have_obj,
 		     struct object_array *want_obj)
 {
 	int i;
 
-	packet_buf_write(response, "acknowledgments\n");
+	packet_writer_write(writer, "acknowledgments\n");
 
 	/* Send Acks */
 	if (!acks->nr)
-		packet_buf_write(response, "NAK\n");
+		packet_writer_write(writer, "NAK\n");
 
 	for (i = 0; i < acks->nr; i++) {
-		packet_buf_write(response, "ACK %s\n",
-				 oid_to_hex(&acks->oid[i]));
+		packet_writer_write(writer, "ACK %s\n",
+				    oid_to_hex(&acks->oid[i]));
 	}
 
 	if (ok_to_give_up(have_obj, want_obj)) {
 		/* Send Ready */
-		packet_buf_write(response, "ready\n");
+		packet_writer_write(writer, "ready\n");
 		return 1;
 	}
 
@@ -1348,25 +1360,20 @@ static int process_haves_and_send_acks(struct upload_pack_data *data,
 				       struct object_array *want_obj)
 {
 	struct oid_array common = OID_ARRAY_INIT;
-	struct strbuf response = STRBUF_INIT;
 	int ret = 0;
 
 	process_haves(&data->haves, &common, have_obj);
 	if (data->done) {
 		ret = 1;
-	} else if (send_acks(&common, &response, have_obj, want_obj)) {
-		packet_buf_delim(&response);
+	} else if (send_acks(&data->writer, &common, have_obj, want_obj)) {
+		packet_writer_delim(&data->writer);
 		ret = 1;
 	} else {
 		/* Add Flush */
-		packet_buf_flush(&response);
+		packet_writer_flush(&data->writer);
 		ret = 0;
 	}
 
-	/* Send response */
-	write_or_die(1, response.buf, response.len);
-	strbuf_release(&response);
-
 	oid_array_clear(&data->haves);
 	oid_array_clear(&common);
 	return ret;
@@ -1379,15 +1386,15 @@ static void send_wanted_ref_info(struct upload_pack_data *data)
 	if (!data->wanted_refs.nr)
 		return;
 
-	packet_write_fmt(1, "wanted-refs\n");
+	packet_writer_write(&data->writer, "wanted-refs\n");
 
 	for_each_string_list_item(item, &data->wanted_refs) {
-		packet_write_fmt(1, "%s %s\n",
-				 oid_to_hex(item->util),
-				 item->string);
+		packet_writer_write(&data->writer, "%s %s\n",
+				    oid_to_hex(item->util),
+				    item->string);
 	}
 
-	packet_delim(1);
+	packet_writer_delim(&data->writer);
 }
 
 static void send_shallow_info(struct upload_pack_data *data,
@@ -1398,14 +1405,15 @@ static void send_shallow_info(struct upload_pack_data *data,
 	    !is_repository_shallow(the_repository))
 		return;
 
-	packet_write_fmt(1, "shallow-info\n");
+	packet_writer_write(&data->writer, "shallow-info\n");
 
-	if (!send_shallow_list(data->depth, data->deepen_rev_list,
+	if (!send_shallow_list(&data->writer, data->depth,
+			       data->deepen_rev_list,
 			       data->deepen_since, &data->deepen_not,
 			       &data->shallows, want_obj) &&
 	    is_repository_shallow(the_repository))
-		deepen(INFINITE_DEPTH, data->deepen_relative, &data->shallows,
-		       want_obj);
+		deepen(&data->writer, INFINITE_DEPTH, data->deepen_relative,
+		       &data->shallows, want_obj);
 
 	packet_delim(1);
 }
@@ -1467,7 +1475,7 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 			send_wanted_ref_info(&data);
 			send_shallow_info(&data, &want_obj);
 
-			packet_write_fmt(1, "packfile\n");
+			packet_writer_write(&data.writer, "packfile\n");
 			create_pack_file(&have_obj, &want_obj);
 			state = FETCH_DONE;
 			break;
-- 
2.19.0.271.gfe8321ec05.dirty

