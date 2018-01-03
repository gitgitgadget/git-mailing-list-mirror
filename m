Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1B531F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751193AbeACASy (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:18:54 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:38594 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbeACASw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:18:52 -0500
Received: by mail-it0-f66.google.com with SMTP id r6so46137itr.3
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y1XXjRqDnGxfDxxTvQ9rVrbvdSVpxaf+nrn8X2ROkT8=;
        b=pM7aWPJRXlZHlEImSrksJqbxu/yeSW7LN7upOUzCKi+37qVmR4Qg1p/ZVoyn8GfivF
         8Wpt8kGBC9VhCuwnQIOXjxuXHBgy6Eibe1HPAPL9HZ7AfgGP7ZPrDpdt5RktDnaqsBC4
         LjbFD31oc/jrJs2oKHMX0cT/2AxU3KG3f8PseRZW8/M3UVIlLavKQ0MlXxVmZYcJ74il
         B951006vMy9Jm1yfG55zOdoI4bGcbwAjV4JioL50X2HFMMYz2wMjTmySOjxs2GV4U6oh
         Upcs59+HAZKG2nq4DqO0zF5wbDcfeHY45EPerTw0/yCROyZiQ1/LH5WHZEZBQesBKz7Z
         jvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y1XXjRqDnGxfDxxTvQ9rVrbvdSVpxaf+nrn8X2ROkT8=;
        b=FdKWefrJtiyAlrn2HsAU2JDFypjXzXSBymeXRCitYA1wUBZbsMMLn15mMLQ0Wk3dc2
         Yue9gtAHeKg3DBHS++4MkzS1e3myRFOOi0RDle/KlRORB7NOlyGFp0t97Ehr2L1EfZQ7
         U7TainzffasncvHwj9uuOYoi/O6LRwkFpSHcu+cSP7EbElLmMFhQZwVP/IBvg9SvndmX
         BeGqxbLGE4zMG0SDpoWwJ08vBiMgRbj35d4wqQjC6HnJ9Klmi3v9ggaRa0Lb2gWoZ9FC
         fZIf1wqMi+zE8I/e8JbJUsAv18PoyQcoBucCaHYiAul75tnnqgRV3ihfM+hFYyzygdEI
         QLFw==
X-Gm-Message-State: AKGB3mLx+k88t61dU2JclePQ3RvC3gCJWVWI2UW5S4EVz2iyuIIR7eqf
        Zknf7DkXtJLogOW5uGYXgQuLCIly3/E=
X-Google-Smtp-Source: ACJfBoudA5B4REt2FnbE7cLsgOe0nyL1f6HzWsZqt3vc5yQGfDbxOM4LiziAOmkFMjFGYh8IFKfZgw==
X-Received: by 10.36.10.73 with SMTP id 70mr87195itw.145.1514938730801;
        Tue, 02 Jan 2018 16:18:50 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:18:49 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 07/26] connect: convert get_remote_heads to use struct packet_reader
Date:   Tue,  2 Jan 2018 16:18:09 -0800
Message-Id: <20180103001828.205012-8-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to allow for better control flow when protocol_v2 is introduced
convert 'get_remote_heads()' to use 'struct packet_reader' to read
packet lines.  This enables a client to be able to peek the first line
of a server's response (without consuming it) in order to determine the
protocol version its speaking and then passing control to the
appropriate handler.

This is needed because the initial response from a server speaking
protocol_v0 includes the first ref, while subsequent protocol versions
respond with a version line.  We want to be able to read this first line
without consuming the first ref sent in the protocol_v0 case so that the
protocol version the server is speaking can be determined outside of
'get_remote_heads()' in a future patch.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 connect.c | 127 +++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 72 insertions(+), 55 deletions(-)

diff --git a/connect.c b/connect.c
index c3a014c5b..03bbb74e4 100644
--- a/connect.c
+++ b/connect.c
@@ -48,6 +48,12 @@ int check_ref_type(const struct ref *ref, int flags)
 
 static void die_initial_contact(int unexpected)
 {
+	/*
+	 * A hang-up after seeing some response from the other end
+	 * means that it is unexpected, as we know the other end is
+	 * willing to talk to us.  A hang-up before seeing any
+	 * response does not necessarily mean an ACL problem, though.
+	 */
 	if (unexpected)
 		die(_("The remote end hung up upon initial contact"));
 	else
@@ -56,6 +62,41 @@ static void die_initial_contact(int unexpected)
 		      "and the repository exists."));
 }
 
+static enum protocol_version discover_version(struct packet_reader *reader)
+{
+	enum protocol_version version = protocol_unknown_version;
+
+	/*
+	 * Peek the first line of the server's response to
+	 * determine the protocol version the server is speaking.
+	 */
+	switch (packet_reader_peek(reader)) {
+	case PACKET_READ_EOF:
+		die_initial_contact(0);
+	case PACKET_READ_FLUSH:
+	case PACKET_READ_DELIM:
+		version = protocol_v0;
+		break;
+	case PACKET_READ_NORMAL:
+		version = determine_protocol_version_client(reader->line);
+		break;
+	}
+
+	/* Maybe process capabilities here, at least for v2 */
+	switch (version) {
+	case protocol_v1:
+		/* Read the peeked version line */
+		packet_reader_read(reader);
+		break;
+	case protocol_v0:
+		break;
+	case protocol_unknown_version:
+		die("unknown protocol version: '%s'\n", reader->line);
+	}
+
+	return version;
+}
+
 static void parse_one_symref_info(struct string_list *symref, const char *val, int len)
 {
 	char *sym, *target;
@@ -109,44 +150,10 @@ static void annotate_refs_with_symref_info(struct ref *ref)
 	string_list_clear(&symref, 0);
 }
 
-/*
- * Read one line of a server's ref advertisement into packet_buffer.
- */
-static int read_remote_ref(int in, char **src_buf, size_t *src_len,
-			   int *responded)
-{
-	int len = packet_read(in, src_buf, src_len,
-			      packet_buffer, sizeof(packet_buffer),
-			      PACKET_READ_GENTLE_ON_EOF |
-			      PACKET_READ_CHOMP_NEWLINE);
-	const char *arg;
-	if (len < 0)
-		die_initial_contact(*responded);
-	if (len > 4 && skip_prefix(packet_buffer, "ERR ", &arg))
-		die("remote error: %s", arg);
-
-	*responded = 1;
-
-	return len;
-}
-
-#define EXPECTING_PROTOCOL_VERSION 0
-#define EXPECTING_FIRST_REF 1
-#define EXPECTING_REF 2
-#define EXPECTING_SHALLOW 3
-
-/* Returns 1 if packet_buffer is a protocol version pkt-line, 0 otherwise. */
-static int process_protocol_version(void)
-{
-	switch (determine_protocol_version_client(packet_buffer)) {
-	case protocol_v1:
-		return 1;
-	case protocol_v0:
-		return 0;
-	default:
-		die("server is speaking an unknown protocol");
-	}
-}
+#define EXPECTING_FIRST_REF 0
+#define EXPECTING_REF 1
+#define EXPECTING_SHALLOW 2
+#define EXPECTING_DONE 3
 
 static void process_capabilities(int *len)
 {
@@ -230,28 +237,36 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 			      struct oid_array *shallow_points)
 {
 	struct ref **orig_list = list;
+	int len = 0;
+	int state = EXPECTING_FIRST_REF;
+	struct packet_reader reader;
+	const char *arg;
 
-	/*
-	 * A hang-up after seeing some response from the other end
-	 * means that it is unexpected, as we know the other end is
-	 * willing to talk to us.  A hang-up before seeing any
-	 * response does not necessarily mean an ACL problem, though.
-	 */
-	int responded = 0;
-	int len;
-	int state = EXPECTING_PROTOCOL_VERSION;
+	packet_reader_init(&reader, in, src_buf, src_len,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_GENTLE_ON_EOF);
+
+	discover_version(&reader);
 
 	*list = NULL;
 
-	while ((len = read_remote_ref(in, &src_buf, &src_len, &responded))) {
+	while (state != EXPECTING_DONE) {
+		switch (packet_reader_read(&reader)) {
+		case PACKET_READ_EOF:
+			die_initial_contact(1);
+		case PACKET_READ_NORMAL:
+			len = reader.pktlen;
+			if (len > 4 && skip_prefix(packet_buffer, "ERR ", &arg))
+				die("remote error: %s", arg);
+			break;
+		case PACKET_READ_FLUSH:
+			state = EXPECTING_DONE;
+			break;
+		case PACKET_READ_DELIM:
+			die("invalid packet\n");
+		}
+
 		switch (state) {
-		case EXPECTING_PROTOCOL_VERSION:
-			if (process_protocol_version()) {
-				state = EXPECTING_FIRST_REF;
-				break;
-			}
-			state = EXPECTING_FIRST_REF;
-			/* fallthrough */
 		case EXPECTING_FIRST_REF:
 			process_capabilities(&len);
 			if (process_dummy_ref()) {
@@ -269,6 +284,8 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 			if (process_shallow(len, shallow_points))
 				break;
 			die("protocol error: unexpected '%s'", packet_buffer);
+		case EXPECTING_DONE:
+			break;
 		default:
 			die("unexpected state %d", state);
 		}
-- 
2.15.1.620.gb9897f4670-goog

