Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1B8D20954
	for <e@80x24.org>; Mon,  4 Dec 2017 23:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbdLDX7W (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 18:59:22 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44103 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbdLDX7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 18:59:16 -0500
Received: by mail-pf0-f194.google.com with SMTP id m26so9792597pfj.11
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 15:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gFCnNA2p2ogrVIaqpLm410K+x4RmzphFhJvw2xk0RaY=;
        b=EwTp9f7eesbKiHZz6dr33iHpxARdNJo+Bdoy3KbtWlWViRzv2yoQLFyPEelzJwnXLx
         RLKUlntWShuukeGOYppOn/gd+fENDeTnS/LnfWHF88Tcr/hCB4bFgDOGQWiu1siJjD15
         7m2ctrt6zQPA0y/8RkOQyAglp5Xdix89ctPe367Zkgbmvc42nfNEDD9c4RmkPsOZbG6W
         3m+VJk0UpgpiESJb4ELjWPZWR0Xvbya5Gg7+hLVqV6RqnS2FRtNzGQXZBWM9+Ix+iewq
         xvb2lWl0G9z1mN4eHNvzbCNiDRspNkuXVBRVeI/wTrABYxfc1apZmkvQ3yop3/pG6J6U
         i3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gFCnNA2p2ogrVIaqpLm410K+x4RmzphFhJvw2xk0RaY=;
        b=cKwuhpPLx1uaUA/1ajAhdM0uUooxiT7e0BQpmyXn/0c56AwEccuy+jhZmfRvMcU9m/
         AL1NMebLzK+05ZzhCsHMwiOj2l4twK7Nih5/g/5j++pvbXdqotzwGd4xS/G5qyS+E/Tk
         6iIHipP9svT259d3H9hNkK7xG3dHaeYBgZrk3J6x/1fytwXlF3a0rxVXgIHbf4LiCs99
         5SjMlYwtDPZnWjqWotZMOc5w0tix7y3BNo981fwsqugv+9gJ2LYK6oBqndmq7FLHJk2K
         9w2CWxHQIS40PGU3DPelKPLoZ5dkcL56+GVdvDMGXyW2h4m4XSS+Z3DggGOWXB489ctz
         uHfw==
X-Gm-Message-State: AJaThX6wRNyNBwV7weYCq5SjFyqj2bLA7K/g6XuQQMx4ehZys2Gvzhov
        VyLsDyIQ09VMPGCBTTWuj+D8O3z0OG0=
X-Google-Smtp-Source: AGs4zMagJR8fG5FNssd/HYVrlbOOBtRaB67J+QE+KUpO4vgE1MGSeJ5F5WFKdouDxyBc30BmWbojgA==
X-Received: by 10.84.193.36 with SMTP id e33mr16529660pld.313.1512431955636;
        Mon, 04 Dec 2017 15:59:15 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id b187sm24939223pfg.109.2017.12.04.15.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 15:59:14 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [WIP 07/15] connect: convert get_remote_heads to use struct packet_reader
Date:   Mon,  4 Dec 2017 15:58:15 -0800
Message-Id: <20171204235823.63299-8-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081-goog
In-Reply-To: <20171204235823.63299-1-bmwill@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <20171204235823.63299-1-bmwill@google.com>
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
 connect.c | 125 +++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 70 insertions(+), 55 deletions(-)

diff --git a/connect.c b/connect.c
index 7fbd396b3..f79ea9179 100644
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
+	case PACKET_READ_ERROR:
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
+		BUG("ERROR");
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
@@ -230,28 +237,34 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
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
+	packet_reader_init(&reader, in, src_buf, src_len);
+
+	discover_version(&reader);
 
 	*list = NULL;
 
-	while ((len = read_remote_ref(in, &src_buf, &src_len, &responded))) {
+	while (state != EXPECTING_DONE) {
+		switch (packet_reader_read(&reader)) {
+		case PACKET_READ_ERROR:
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
@@ -269,6 +282,8 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 			if (process_shallow(len, shallow_points))
 				break;
 			die("protocol error: unexpected '%s'", packet_buffer);
+		case EXPECTING_DONE:
+			break;
 		default:
 			die("unexpected state %d", state);
 		}
-- 
2.15.1.424.g9478a66081-goog

