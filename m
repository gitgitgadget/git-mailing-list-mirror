Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36EA01F932
	for <e@80x24.org>; Sat, 29 Dec 2018 21:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeL2VTb (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 16:19:31 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:47210 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeL2VTb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 16:19:31 -0500
Received: by mail-pf1-f201.google.com with SMTP id m3so26202365pfj.14
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 13:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/uQU1wTPSVK8PGB7cmqkXxgWQToUCRqE1Opf+RETJ7c=;
        b=debW4K2UIAIopwClqLv83zx/lU95fOZe1rs2DoulRaa+YxIb8RkMGxPhalW3vkR+x7
         k7x89od0mcirV8Z9v9y8FamWo0Y0IHdLkPyvxLdKfKMKYdMDB+KslNzaQnTb0Y91lDyE
         vsNY9HSCgE3CXF1eT9NrlfpHM64uLnDMu8SJgjXYioG/USyrn3HxcGcrY2+khtfKremb
         D/+gllit/Nji+tR7O2ghz8eI7r4bUxhnuedQLlrCrTuAGpZe4GZI+aLdPE4OAze/6X+M
         AzNTWmOMPMzmrh4Bp3weoQgzQewbPO67NuLc9jkVBCfl2VrJ0rNHHeViO29VgH4486e1
         s8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/uQU1wTPSVK8PGB7cmqkXxgWQToUCRqE1Opf+RETJ7c=;
        b=lGF6tGfZIpYOqcLteumScSV2OoAC/DQ9C438RuvF0E7CB1iTYomaNXSE8+PS+jrDjc
         YQvJfYakr/epAwEk4JW3mabjw5HCJP6kOxJaOyPplNC5tXSqIMfExTuMUlngoOoWBijv
         hz28jhLKpPm3XOZtnTKgUVwjpRaHkWzuwQFq3ZND+HAlHtAKsQKzForYXDlpSk0A2NsB
         6eOBFh2Jl6dPFwU1sisqC+Ia+UElZ5sXhMrub+q7kL1nXAkWxEHPvsohkxqWJkSX9gUU
         u/EfI2YQOZQ9e6K7srDoiWvY4/JxjtzSFCNtxah07hnhscvGRSKz/2LT4z9f+mxeVY9T
         Cr2A==
X-Gm-Message-State: AA+aEWYgJAYl+XFcxbs1PIxI4STS/MV0CAa2zN/fIugZ620lqbgJa9/A
        wdVufhlMVOYIWNpgj1QY4fx9+xVJST7V4pZ3dLA=
X-Google-Smtp-Source: AFSGD/U3NLsdtV6AwmTUOc6Ho4M1oXpmr6M4vciasPObeAF9UbgVwv8iRFm1ZHIX3SwpDLLz4v6A6nuFea0T5V/wqmM=
X-Received: by 2002:a62:c6c5:: with SMTP id x66mr14819178pfk.68.1546118369126;
 Sat, 29 Dec 2018 13:19:29 -0800 (PST)
Date:   Sat, 29 Dec 2018 13:19:14 -0800
In-Reply-To: <20181229211915.161686-1-masayasuzuki@google.com>
Message-Id: <20181229211915.161686-2-masayasuzuki@google.com>
Mime-Version: 1.0
References: <reply-to=20181127045301.103807-1-masayasuzuki@google.com> <20181229211915.161686-1-masayasuzuki@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
Subject: [PATCH v2 1/2] Use packet_reader instead of packet_read_line
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     masayasuzuki@google.com
Cc:     git@vger.kernel.org, peff@peff.net, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By using and sharing a packet_reader while handling a Git pack protocol
request, the same reader option is used throughout the code. This makes
it easy to set a reader option to the request parsing code.

Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
---
 builtin/archive.c      | 19 ++++++-------
 builtin/receive-pack.c | 60 +++++++++++++++++++++--------------------
 fetch-pack.c           | 61 +++++++++++++++++++++++-------------------
 remote-curl.c          | 22 ++++++++++-----
 send-pack.c            | 37 ++++++++++++-------------
 upload-pack.c          | 38 +++++++++++++-------------
 6 files changed, 129 insertions(+), 108 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index d2455237c..2fe1f05ca 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -27,10 +27,10 @@ static int run_remote_archiver(int argc, const char **argv,
 			       const char *remote, const char *exec,
 			       const char *name_hint)
 {
-	char *buf;
 	int fd[2], i, rv;
 	struct transport *transport;
 	struct remote *_remote;
+	struct packet_reader reader;
 
 	_remote = remote_get(remote);
 	if (!_remote->url[0])
@@ -53,18 +53,19 @@ static int run_remote_archiver(int argc, const char **argv,
 		packet_write_fmt(fd[1], "argument %s\n", argv[i]);
 	packet_flush(fd[1]);
 
-	buf = packet_read_line(fd[0], NULL);
-	if (!buf)
+	packet_reader_init(&reader, fd[0], NULL, 0, PACKET_READ_CHOMP_NEWLINE);
+
+	if (packet_reader_read(&reader) != PACKET_READ_NORMAL)
 		die(_("git archive: expected ACK/NAK, got a flush packet"));
-	if (strcmp(buf, "ACK")) {
-		if (starts_with(buf, "NACK "))
-			die(_("git archive: NACK %s"), buf + 5);
-		if (starts_with(buf, "ERR "))
-			die(_("remote error: %s"), buf + 4);
+	if (strcmp(reader.line, "ACK")) {
+		if (starts_with(reader.line, "NACK "))
+			die(_("git archive: NACK %s"), reader.line + 5);
+		if (starts_with(reader.line, "ERR "))
+			die(_("remote error: %s"), reader.line + 4);
 		die(_("git archive: protocol error"));
 	}
 
-	if (packet_read_line(fd[0], NULL))
+	if (packet_reader_read(&reader) != PACKET_READ_FLUSH)
 		die(_("git archive: expected a flush"));
 
 	/* Now, start reading from fd[0] and spit it out to stdout */
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 33187bd8e..81cc07370 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1569,30 +1569,29 @@ static void queue_commands_from_cert(struct command **tail,
 	}
 }
 
-static struct command *read_head_info(struct oid_array *shallow)
+static struct command *read_head_info(struct packet_reader *reader,
+				      struct oid_array *shallow)
 {
 	struct command *commands = NULL;
 	struct command **p = &commands;
 	for (;;) {
-		char *line;
-		int len, linelen;
+		int linelen;
 
-		line = packet_read_line(0, &len);
-		if (!line)
+		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
 			break;
 
-		if (len > 8 && starts_with(line, "shallow ")) {
+		if (reader->pktlen > 8 && starts_with(reader->line, "shallow ")) {
 			struct object_id oid;
-			if (get_oid_hex(line + 8, &oid))
+			if (get_oid_hex(reader->line + 8, &oid))
 				die("protocol error: expected shallow sha, got '%s'",
-				    line + 8);
+				    reader->line + 8);
 			oid_array_append(shallow, &oid);
 			continue;
 		}
 
-		linelen = strlen(line);
-		if (linelen < len) {
-			const char *feature_list = line + linelen + 1;
+		linelen = strlen(reader->line);
+		if (linelen < reader->pktlen) {
+			const char *feature_list = reader->line + linelen + 1;
 			if (parse_feature_request(feature_list, "report-status"))
 				report_status = 1;
 			if (parse_feature_request(feature_list, "side-band-64k"))
@@ -1607,28 +1606,32 @@ static struct command *read_head_info(struct oid_array *shallow)
 				use_push_options = 1;
 		}
 
-		if (!strcmp(line, "push-cert")) {
+		if (!strcmp(reader->line, "push-cert")) {
 			int true_flush = 0;
-			char certbuf[1024];
+			int saved_options = reader->options;
+			reader->options &= ~PACKET_READ_CHOMP_NEWLINE;
 
 			for (;;) {
-				len = packet_read(0, NULL, NULL,
-						  certbuf, sizeof(certbuf), 0);
-				if (!len) {
+				packet_reader_read(reader);
+				if (reader->status == PACKET_READ_FLUSH) {
 					true_flush = 1;
 					break;
 				}
-				if (!strcmp(certbuf, "push-cert-end\n"))
+				if (reader->status != PACKET_READ_NORMAL) {
+					die("protocol error: got an unexpected packet");
+				}
+				if (!strcmp(reader->line, "push-cert-end\n"))
 					break; /* end of cert */
-				strbuf_addstr(&push_cert, certbuf);
+				strbuf_addstr(&push_cert, reader->line);
 			}
+			reader->options = saved_options;
 
 			if (true_flush)
 				break;
 			continue;
 		}
 
-		p = queue_command(p, line, linelen);
+		p = queue_command(p, reader->line, linelen);
 	}
 
 	if (push_cert.len)
@@ -1637,18 +1640,14 @@ static struct command *read_head_info(struct oid_array *shallow)
 	return commands;
 }
 
-static void read_push_options(struct string_list *options)
+static void read_push_options(struct packet_reader *reader,
+			      struct string_list *options)
 {
 	while (1) {
-		char *line;
-		int len;
-
-		line = packet_read_line(0, &len);
-
-		if (!line)
+		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
 			break;
 
-		string_list_append(options, line);
+		string_list_append(options, reader->line);
 	}
 }
 
@@ -1924,6 +1923,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	struct oid_array shallow = OID_ARRAY_INIT;
 	struct oid_array ref = OID_ARRAY_INIT;
 	struct shallow_info si;
+	struct packet_reader reader;
 
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("quiet")),
@@ -1986,12 +1986,14 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	if (advertise_refs)
 		return 0;
 
-	if ((commands = read_head_info(&shallow)) != NULL) {
+	packet_reader_init(&reader, 0, NULL, 0, PACKET_READ_CHOMP_NEWLINE);
+
+	if ((commands = read_head_info(&reader, &shallow)) != NULL) {
 		const char *unpack_status = NULL;
 		struct string_list push_options = STRING_LIST_INIT_DUP;
 
 		if (use_push_options)
-			read_push_options(&push_options);
+			read_push_options(&reader, &push_options);
 		if (!check_cert_push_options(&push_options)) {
 			struct command *cmd;
 			for (cmd = commands; cmd; cmd = cmd->next)
diff --git a/fetch-pack.c b/fetch-pack.c
index 9691046e6..86790b9bb 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -135,38 +135,42 @@ enum ack_type {
 	ACK_ready
 };
 
-static void consume_shallow_list(struct fetch_pack_args *args, int fd)
+static void consume_shallow_list(struct fetch_pack_args *args,
+				 struct packet_reader *reader)
 {
 	if (args->stateless_rpc && args->deepen) {
 		/* If we sent a depth we will get back "duplicate"
 		 * shallow and unshallow commands every time there
 		 * is a block of have lines exchanged.
 		 */
-		char *line;
-		while ((line = packet_read_line(fd, NULL))) {
-			if (starts_with(line, "shallow "))
+		while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
+			if (starts_with(reader->line, "shallow "))
 				continue;
-			if (starts_with(line, "unshallow "))
+			if (starts_with(reader->line, "unshallow "))
 				continue;
 			die(_("git fetch-pack: expected shallow list"));
 		}
+		if (reader->status != PACKET_READ_FLUSH)
+			die(_("git fetch-pack: expected a flush packet after shallow list"));
 	}
 }
 
-static enum ack_type get_ack(int fd, struct object_id *result_oid)
+static enum ack_type get_ack(struct packet_reader *reader,
+			     struct object_id *result_oid)
 {
 	int len;
-	char *line = packet_read_line(fd, &len);
 	const char *arg;
 
-	if (!line)
+	if (packet_reader_read(reader) != PACKET_READ_NORMAL)
 		die(_("git fetch-pack: expected ACK/NAK, got a flush packet"));
-	if (!strcmp(line, "NAK"))
+	len = reader->pktlen;
+
+	if (!strcmp(reader->line, "NAK"))
 		return NAK;
-	if (skip_prefix(line, "ACK ", &arg)) {
+	if (skip_prefix(reader->line, "ACK ", &arg)) {
 		if (!get_oid_hex(arg, result_oid)) {
 			arg += 40;
-			len -= arg - line;
+			len -= arg - reader->line;
 			if (len < 1)
 				return ACK;
 			if (strstr(arg, "continue"))
@@ -178,9 +182,9 @@ static enum ack_type get_ack(int fd, struct object_id *result_oid)
 			return ACK;
 		}
 	}
-	if (skip_prefix(line, "ERR ", &arg))
+	if (skip_prefix(reader->line, "ERR ", &arg))
 		die(_("remote error: %s"), arg);
-	die(_("git fetch-pack: expected ACK/NAK, got '%s'"), line);
+	die(_("git fetch-pack: expected ACK/NAK, got '%s'"), reader->line);
 }
 
 static void send_request(struct fetch_pack_args *args,
@@ -248,10 +252,14 @@ static int find_common(struct fetch_negotiator *negotiator,
 	int got_ready = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 	size_t state_len = 0;
+	struct packet_reader reader;
 
 	if (args->stateless_rpc && multi_ack == 1)
 		die(_("--stateless-rpc requires multi_ack_detailed"));
 
+	packet_reader_init(&reader, fd[0], NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE);
+
 	if (!args->no_dependents) {
 		mark_tips(negotiator, args->negotiation_tips);
 		for_each_cached_alternate(negotiator, insert_one_alternate_object);
@@ -336,31 +344,30 @@ static int find_common(struct fetch_negotiator *negotiator,
 	state_len = req_buf.len;
 
 	if (args->deepen) {
-		char *line;
 		const char *arg;
 		struct object_id oid;
 
 		send_request(args, fd[1], &req_buf);
-		while ((line = packet_read_line(fd[0], NULL))) {
-			if (skip_prefix(line, "shallow ", &arg)) {
+		while (packet_reader_read(&reader) == PACKET_READ_NORMAL) {
+			if (skip_prefix(reader.line, "shallow ", &arg)) {
 				if (get_oid_hex(arg, &oid))
-					die(_("invalid shallow line: %s"), line);
+					die(_("invalid shallow line: %s"), reader.line);
 				register_shallow(the_repository, &oid);
 				continue;
 			}
-			if (skip_prefix(line, "unshallow ", &arg)) {
+			if (skip_prefix(reader.line, "unshallow ", &arg)) {
 				if (get_oid_hex(arg, &oid))
-					die(_("invalid unshallow line: %s"), line);
+					die(_("invalid unshallow line: %s"), reader.line);
 				if (!lookup_object(the_repository, oid.hash))
-					die(_("object not found: %s"), line);
+					die(_("object not found: %s"), reader.line);
 				/* make sure that it is parsed as shallow */
 				if (!parse_object(the_repository, &oid))
-					die(_("error in object: %s"), line);
+					die(_("error in object: %s"), reader.line);
 				if (unregister_shallow(&oid))
-					die(_("no shallow found: %s"), line);
+					die(_("no shallow found: %s"), reader.line);
 				continue;
 			}
-			die(_("expected shallow/unshallow, got %s"), line);
+			die(_("expected shallow/unshallow, got %s"), reader.line);
 		}
 	} else if (!args->stateless_rpc)
 		send_request(args, fd[1], &req_buf);
@@ -397,9 +404,9 @@ static int find_common(struct fetch_negotiator *negotiator,
 			if (!args->stateless_rpc && count == INITIAL_FLUSH)
 				continue;
 
-			consume_shallow_list(args, fd[0]);
+			consume_shallow_list(args, &reader);
 			do {
-				ack = get_ack(fd[0], result_oid);
+				ack = get_ack(&reader, result_oid);
 				if (ack)
 					print_verbose(args, _("got %s %d %s"), "ack",
 						      ack, oid_to_hex(result_oid));
@@ -469,9 +476,9 @@ static int find_common(struct fetch_negotiator *negotiator,
 	strbuf_release(&req_buf);
 
 	if (!got_ready || !no_done)
-		consume_shallow_list(args, fd[0]);
+		consume_shallow_list(args, &reader);
 	while (flushes || multi_ack) {
-		int ack = get_ack(fd[0], result_oid);
+		int ack = get_ack(&reader, result_oid);
 		if (ack) {
 			print_verbose(args, _("got %s (%d) %s"), "ack",
 				      ack, oid_to_hex(result_oid));
diff --git a/remote-curl.c b/remote-curl.c
index 1220dffcd..bbd9ba0f3 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -409,28 +409,36 @@ static struct discovery *discover_refs(const char *service, int for_push)
 	if (maybe_smart &&
 	    (5 <= last->len && last->buf[4] == '#') &&
 	    !strbuf_cmp(&exp, &type)) {
-		char *line;
+		struct packet_reader reader;
+		packet_reader_init(&reader, -1, last->buf, last->len,
+				   PACKET_READ_CHOMP_NEWLINE);
 
 		/*
 		 * smart HTTP response; validate that the service
 		 * pkt-line matches our request.
 		 */
-		line = packet_read_line_buf(&last->buf, &last->len, NULL);
-		if (!line)
+		if (packet_reader_read(&reader) != PACKET_READ_NORMAL)
 			die("invalid server response; expected service, got flush packet");
 
 		strbuf_reset(&exp);
 		strbuf_addf(&exp, "# service=%s", service);
-		if (strcmp(line, exp.buf))
-			die("invalid server response; got '%s'", line);
+		if (strcmp(reader.line, exp.buf))
+			die("invalid server response; got '%s'", reader.line);
 		strbuf_release(&exp);
 
 		/* The header can include additional metadata lines, up
 		 * until a packet flush marker.  Ignore these now, but
 		 * in the future we might start to scan them.
 		 */
-		while (packet_read_line_buf(&last->buf, &last->len, NULL))
-			;
+		for (;;) {
+			packet_reader_read(&reader);
+			if (reader.pktlen <= 0) {
+				break;
+			}
+		}
+
+		last->buf = reader.src_buffer;
+		last->len = reader.src_len;
 
 		last->proto_git = 1;
 	} else if (maybe_smart &&
diff --git a/send-pack.c b/send-pack.c
index f69268677..913645046 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -135,38 +135,36 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *extra, struc
 	return 0;
 }
 
-static int receive_unpack_status(int in)
+static int receive_unpack_status(struct packet_reader *reader)
 {
-	const char *line = packet_read_line(in, NULL);
-	if (!line)
+	if (packet_reader_read(reader) != PACKET_READ_NORMAL)
 		return error(_("unexpected flush packet while reading remote unpack status"));
-	if (!skip_prefix(line, "unpack ", &line))
-		return error(_("unable to parse remote unpack status: %s"), line);
-	if (strcmp(line, "ok"))
-		return error(_("remote unpack failed: %s"), line);
+	if (!skip_prefix(reader->line, "unpack ", &reader->line))
+		return error(_("unable to parse remote unpack status: %s"), reader->line);
+	if (strcmp(reader->line, "ok"))
+		return error(_("remote unpack failed: %s"), reader->line);
 	return 0;
 }
 
-static int receive_status(int in, struct ref *refs)
+static int receive_status(struct packet_reader *reader, struct ref *refs)
 {
 	struct ref *hint;
 	int ret;
 
 	hint = NULL;
-	ret = receive_unpack_status(in);
+	ret = receive_unpack_status(reader);
 	while (1) {
-		char *refname;
+		const char *refname;
 		char *msg;
-		char *line = packet_read_line(in, NULL);
-		if (!line)
+		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
 			break;
-		if (!starts_with(line, "ok ") && !starts_with(line, "ng ")) {
-			error("invalid ref status from remote: %s", line);
+		if (!starts_with(reader->line, "ok ") && !starts_with(reader->line, "ng ")) {
+			error("invalid ref status from remote: %s", reader->line);
 			ret = -1;
 			break;
 		}
 
-		refname = line + 3;
+		refname = reader->line + 3;
 		msg = strchr(refname, ' ');
 		if (msg)
 			*msg++ = '\0';
@@ -187,7 +185,7 @@ static int receive_status(int in, struct ref *refs)
 			continue;
 		}
 
-		if (line[0] == 'o' && line[1] == 'k')
+		if (reader->line[0] == 'o' && reader->line[1] == 'k')
 			hint->status = REF_STATUS_OK;
 		else {
 			hint->status = REF_STATUS_REMOTE_REJECT;
@@ -390,6 +388,7 @@ int send_pack(struct send_pack_args *args,
 	int ret;
 	struct async demux;
 	const char *push_cert_nonce = NULL;
+	struct packet_reader reader;
 
 	/* Does the other end support the reporting? */
 	if (server_supports("report-status"))
@@ -559,6 +558,8 @@ int send_pack(struct send_pack_args *args,
 		in = demux.out;
 	}
 
+	packet_reader_init(&reader, in, NULL, 0, PACKET_READ_CHOMP_NEWLINE);
+
 	if (need_pack_data && cmds_sent) {
 		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
 			for (ref = remote_refs; ref; ref = ref->next)
@@ -573,7 +574,7 @@ int send_pack(struct send_pack_args *args,
 			 * are failing, and just want the error() side effects.
 			 */
 			if (status_report)
-				receive_unpack_status(in);
+				receive_unpack_status(&reader);
 
 			if (use_sideband) {
 				close(demux.out);
@@ -590,7 +591,7 @@ int send_pack(struct send_pack_args *args,
 		packet_flush(out);
 
 	if (status_report && cmds_sent)
-		ret = receive_status(in, remote_refs);
+		ret = receive_status(&reader, remote_refs);
 	else
 		ret = 0;
 	if (args->stateless_rpc)
diff --git a/upload-pack.c b/upload-pack.c
index 5e81f1ff2..1638825ee 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -354,7 +354,8 @@ static int ok_to_give_up(const struct object_array *have_obj,
 					    min_generation);
 }
 
-static int get_common_commits(struct object_array *have_obj,
+static int get_common_commits(struct packet_reader *reader,
+			      struct object_array *have_obj,
 			      struct object_array *want_obj)
 {
 	struct object_id oid;
@@ -366,12 +367,11 @@ static int get_common_commits(struct object_array *have_obj,
 	save_commit_buffer = 0;
 
 	for (;;) {
-		char *line = packet_read_line(0, NULL);
 		const char *arg;
 
 		reset_timeout();
 
-		if (!line) {
+		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
 			if (multi_ack == 2 && got_common
 			    && !got_other && ok_to_give_up(have_obj, want_obj)) {
 				sent_ready = 1;
@@ -390,7 +390,7 @@ static int get_common_commits(struct object_array *have_obj,
 			got_other = 0;
 			continue;
 		}
-		if (skip_prefix(line, "have ", &arg)) {
+		if (skip_prefix(reader->line, "have ", &arg)) {
 			switch (got_oid(arg, &oid, have_obj)) {
 			case -1: /* they have what we do not */
 				got_other = 1;
@@ -416,7 +416,7 @@ static int get_common_commits(struct object_array *have_obj,
 			}
 			continue;
 		}
-		if (!strcmp(line, "done")) {
+		if (!strcmp(reader->line, "done")) {
 			if (have_obj->nr > 0) {
 				if (multi_ack)
 					packet_write_fmt(1, "ACK %s\n", last_hex);
@@ -425,7 +425,7 @@ static int get_common_commits(struct object_array *have_obj,
 			packet_write_fmt(1, "NAK\n");
 			return -1;
 		}
-		die("git upload-pack: expected SHA1 list, got '%s'", line);
+		die("git upload-pack: expected SHA1 list, got '%s'", reader->line);
 	}
 }
 
@@ -826,7 +826,7 @@ static int process_deepen_not(const char *line, struct string_list *deepen_not,
 	return 0;
 }
 
-static void receive_needs(struct object_array *want_obj)
+static void receive_needs(struct packet_reader *reader, struct object_array *want_obj)
 {
 	struct object_array shallows = OBJECT_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
@@ -840,33 +840,32 @@ static void receive_needs(struct object_array *want_obj)
 		struct object *o;
 		const char *features;
 		struct object_id oid_buf;
-		char *line = packet_read_line(0, NULL);
 		const char *arg;
 
 		reset_timeout();
-		if (!line)
+		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
 			break;
 
-		if (process_shallow(line, &shallows))
+		if (process_shallow(reader->line, &shallows))
 			continue;
-		if (process_deepen(line, &depth))
+		if (process_deepen(reader->line, &depth))
 			continue;
-		if (process_deepen_since(line, &deepen_since, &deepen_rev_list))
+		if (process_deepen_since(reader->line, &deepen_since, &deepen_rev_list))
 			continue;
-		if (process_deepen_not(line, &deepen_not, &deepen_rev_list))
+		if (process_deepen_not(reader->line, &deepen_not, &deepen_rev_list))
 			continue;
 
-		if (skip_prefix(line, "filter ", &arg)) {
+		if (skip_prefix(reader->line, "filter ", &arg)) {
 			if (!filter_capability_requested)
 				die("git upload-pack: filtering capability not negotiated");
 			parse_list_objects_filter(&filter_options, arg);
 			continue;
 		}
 
-		if (!skip_prefix(line, "want ", &arg) ||
+		if (!skip_prefix(reader->line, "want ", &arg) ||
 		    parse_oid_hex(arg, &oid_buf, &features))
 			die("git upload-pack: protocol error, "
-			    "expected to get object ID, not '%s'", line);
+			    "expected to get object ID, not '%s'", reader->line);
 
 		if (parse_feature_request(features, "deepen-relative"))
 			deepen_relative = 1;
@@ -1055,6 +1054,7 @@ void upload_pack(struct upload_pack_options *options)
 {
 	struct string_list symref = STRING_LIST_INIT_DUP;
 	struct object_array want_obj = OBJECT_ARRAY_INIT;
+	struct packet_reader reader;
 
 	stateless_rpc = options->stateless_rpc;
 	timeout = options->timeout;
@@ -1078,10 +1078,12 @@ void upload_pack(struct upload_pack_options *options)
 	if (options->advertise_refs)
 		return;
 
-	receive_needs(&want_obj);
+	packet_reader_init(&reader, 0, NULL, 0, PACKET_READ_CHOMP_NEWLINE);
+
+	receive_needs(&reader, &want_obj);
 	if (want_obj.nr) {
 		struct object_array have_obj = OBJECT_ARRAY_INIT;
-		get_common_commits(&have_obj, &want_obj);
+		get_common_commits(&reader, &have_obj, &want_obj);
 		create_pack_file(&have_obj, &want_obj);
 	}
 }
-- 
2.20.1.415.g653613c723-goog

