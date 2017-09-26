Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C94B20281
	for <e@80x24.org>; Tue, 26 Sep 2017 23:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969123AbdIZX4u (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 19:56:50 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:53547 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966844AbdIZX4s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 19:56:48 -0400
Received: by mail-pg0-f46.google.com with SMTP id j70so6771337pgc.10
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 16:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8Zm3MM/0tsBjCAS0DqLZvQiabGE7UNbz+wSrz7UUZF0=;
        b=UH7Pe1y7+Fa4E0yhJjtduOYPWsSAHpM8lvvgGHtcmk1J874H8mCPzHO9KYXm/jsBae
         pdA+vd59XNdVPxWOh4iNTK61d4iiDS2TdOwYoHtLzVBRPiCCIC8NXbqzh0dHtubp4TST
         WxZyuh4MM/QfXcCWGUzpZMk6St988Kyo+LlTc+3biDzvz0RL0oFGdYO8oS1yBiDXPJzy
         NRrr8f2YffJzo/FEZGNouyqZZ1CjFJIPtlKf7//88YiFM64qIN3VlNQGYea67J4R/6z1
         aE68nRS6LZ8b4sdFNUdpskMvwBQzUDMS8Z6VKNJsTm5MDZxZ6py5UO53bCpK6HFlAVoe
         p9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8Zm3MM/0tsBjCAS0DqLZvQiabGE7UNbz+wSrz7UUZF0=;
        b=hue8wxg79ybzQVGA1M/dZup6J2JSbD5pr7bh+oKFNpwEC83IWZI3X6+okaaMI8oGUf
         QE2F0ZUkAXqmxbMBn2r12sZ2keQuPXniBkVCZPnIVlqJQByHhcyt0LQ0U6OzE4hjfTYM
         Fn/Hjt4rY/ArkCms5M6HHuWF7SaYRtNB/Vhz54n2mDGhcBe5TzTXnFj0qgIt/R+vGH0t
         z6QLsoq7mU4pyhP9y86Yl8i5xocL1wKbExG+1EnG2s2Bq3bSVjUOcnlesQwfRr+EJrIT
         bZv21PrJh8FdIkt6roE/s40xb1kFimSGB/Q3bMHBvotBAWhxmXzGEGyVP0SbTOlOleQV
         nYYg==
X-Gm-Message-State: AHPjjUgnUX7Z0pWPoZenaLMP8YkpGieKyW+FCjoPJM7bHytH6WrQHM/A
        0vRaKBCeiY5+TZtTYmpHSNVTvtKSlIQ=
X-Google-Smtp-Source: AOwi7QAGzHazErJHlID9CLmUlX3wxfW34NKfZWxwvyPh/o7gNRzc9ekRx1M1VzdiK6tVCgSIR28EAw==
X-Received: by 10.99.112.79 with SMTP id a15mr12462408pgn.154.1506470207267;
        Tue, 26 Sep 2017 16:56:47 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id j2sm18071699pgn.26.2017.09.26.16.56.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 16:56:46 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 1/9] connect: in ref advertisement, shallows are last
Date:   Tue, 26 Sep 2017 16:56:19 -0700
Message-Id: <20170926235627.79606-2-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.992.g2c7b836f3a-goog
In-Reply-To: <20170926235627.79606-1-bmwill@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170926235627.79606-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Currently, get_remote_heads() parses the ref advertisement in one loop,
allowing refs and shallow lines to intersperse, despite this not being
allowed by the specification. Refactor get_remote_heads() to use two
loops instead, enforcing that refs come first, and then shallows.

This also makes it easier to teach get_remote_heads() to interpret other
lines in the ref advertisement, which will be done in a subsequent
patch.

As part of this change, this patch interprets capabilities only on the
first line in the ref advertisement, printing a warning message when
encountering capabilities on other lines.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 connect.c | 189 ++++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 123 insertions(+), 66 deletions(-)

diff --git a/connect.c b/connect.c
index df56c0cbf..8e2e276b6 100644
--- a/connect.c
+++ b/connect.c
@@ -11,6 +11,7 @@
 #include "string-list.h"
 #include "sha1-array.h"
 #include "transport.h"
+#include "strbuf.h"
 
 static char *server_capabilities;
 static const char *parse_feature_value(const char *, const char *, int *);
@@ -107,6 +108,104 @@ static void annotate_refs_with_symref_info(struct ref *ref)
 	string_list_clear(&symref, 0);
 }
 
+/*
+ * Read one line of a server's ref advertisement into packet_buffer.
+ */
+static int read_remote_ref(int in, char **src_buf, size_t *src_len,
+			   int *responded)
+{
+	int len = packet_read(in, src_buf, src_len,
+			      packet_buffer, sizeof(packet_buffer),
+			      PACKET_READ_GENTLE_ON_EOF |
+			      PACKET_READ_CHOMP_NEWLINE);
+	const char *arg;
+	if (len < 0)
+		die_initial_contact(*responded);
+	if (len > 4 && skip_prefix(packet_buffer, "ERR ", &arg))
+		die("remote error: %s", arg);
+
+	*responded = 1;
+
+	return len;
+}
+
+#define EXPECTING_FIRST_REF 0
+#define EXPECTING_REF 1
+#define EXPECTING_SHALLOW 2
+
+static void process_capabilities(int *len)
+{
+	int nul_location = strlen(packet_buffer);
+	if (nul_location == *len)
+		return;
+	server_capabilities = xstrdup(packet_buffer + nul_location + 1);
+	*len = nul_location;
+}
+
+static int process_dummy_ref(void)
+{
+	struct object_id oid;
+	const char *name;
+
+	if (parse_oid_hex(packet_buffer, &oid, &name))
+		return 0;
+	if (*name != ' ')
+		return 0;
+	name++;
+
+	return !oidcmp(&null_oid, &oid) && !strcmp(name, "capabilities^{}");
+}
+
+static void check_no_capabilities(int len)
+{
+	if (strlen(packet_buffer) != len)
+		warning("Ignoring capabilities after first line '%s'",
+			packet_buffer + strlen(packet_buffer));
+}
+
+static int process_ref(int len, struct ref ***list, unsigned int flags,
+		       struct oid_array *extra_have)
+{
+	struct object_id old_oid;
+	const char *name;
+
+	if (parse_oid_hex(packet_buffer, &old_oid, &name))
+		return 0;
+	if (*name != ' ')
+		return 0;
+	name++;
+
+	if (extra_have && !strcmp(name, ".have")) {
+		oid_array_append(extra_have, &old_oid);
+	} else if (!strcmp(name, "capabilities^{}")) {
+		die("protocol error: unexpected capabilities^{}");
+	} else if (check_ref(name, flags)) {
+		struct ref *ref = alloc_ref(name);
+		oidcpy(&ref->old_oid, &old_oid);
+		**list = ref;
+		*list = &ref->next;
+	}
+	check_no_capabilities(len);
+	return 1;
+}
+
+static int process_shallow(int len, struct oid_array *shallow_points)
+{
+	const char *arg;
+	struct object_id old_oid;
+
+	if (!skip_prefix(packet_buffer, "shallow ", &arg))
+		return 0;
+
+	if (get_oid_hex(arg, &old_oid))
+		die("protocol error: expected shallow sha-1, got '%s'", arg);
+	if (!shallow_points)
+		die("repository on the other end cannot be shallow");
+	oid_array_append(shallow_points, &old_oid);
+	check_no_capabilities(len);
+	return 1;
+}
+
 /*
  * Read all the refs from the other end
  */
@@ -123,76 +222,34 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 	 * willing to talk to us.  A hang-up before seeing any
 	 * response does not necessarily mean an ACL problem, though.
 	 */
-	int saw_response;
-	int got_dummy_ref_with_capabilities_declaration = 0;
+	int responded = 0;
+	int len;
+	int state = EXPECTING_FIRST_REF;
 
 	*list = NULL;
-	for (saw_response = 0; ; saw_response = 1) {
-		struct ref *ref;
-		struct object_id old_oid;
-		char *name;
-		int len, name_len;
-		char *buffer = packet_buffer;
-		const char *arg;
-
-		len = packet_read(in, &src_buf, &src_len,
-				  packet_buffer, sizeof(packet_buffer),
-				  PACKET_READ_GENTLE_ON_EOF |
-				  PACKET_READ_CHOMP_NEWLINE);
-		if (len < 0)
-			die_initial_contact(saw_response);
-
-		if (!len)
-			break;
-
-		if (len > 4 && skip_prefix(buffer, "ERR ", &arg))
-			die("remote error: %s", arg);
-
-		if (len == GIT_SHA1_HEXSZ + strlen("shallow ") &&
-			skip_prefix(buffer, "shallow ", &arg)) {
-			if (get_oid_hex(arg, &old_oid))
-				die("protocol error: expected shallow sha-1, got '%s'", arg);
-			if (!shallow_points)
-				die("repository on the other end cannot be shallow");
-			oid_array_append(shallow_points, &old_oid);
-			continue;
-		}
 
-		if (len < GIT_SHA1_HEXSZ + 2 || get_oid_hex(buffer, &old_oid) ||
-			buffer[GIT_SHA1_HEXSZ] != ' ')
-			die("protocol error: expected sha/ref, got '%s'", buffer);
-		name = buffer + GIT_SHA1_HEXSZ + 1;
-
-		name_len = strlen(name);
-		if (len != name_len + GIT_SHA1_HEXSZ + 1) {
-			free(server_capabilities);
-			server_capabilities = xstrdup(name + name_len + 1);
-		}
-
-		if (extra_have && !strcmp(name, ".have")) {
-			oid_array_append(extra_have, &old_oid);
-			continue;
-		}
-
-		if (!strcmp(name, "capabilities^{}")) {
-			if (saw_response)
-				die("protocol error: unexpected capabilities^{}");
-			if (got_dummy_ref_with_capabilities_declaration)
-				die("protocol error: multiple capabilities^{}");
-			got_dummy_ref_with_capabilities_declaration = 1;
-			continue;
+	while ((len = read_remote_ref(in, &src_buf, &src_len, &responded))) {
+		switch (state) {
+		case EXPECTING_FIRST_REF:
+			process_capabilities(&len);
+			if (process_dummy_ref()) {
+				state = EXPECTING_SHALLOW;
+				break;
+			}
+			state = EXPECTING_REF;
+			/* fallthrough */
+		case EXPECTING_REF:
+			if (process_ref(len, &list, flags, extra_have))
+				break;
+			state = EXPECTING_SHALLOW;
+			/* fallthrough */
+		case EXPECTING_SHALLOW:
+			if (process_shallow(len, shallow_points))
+				break;
+			die("protocol error: unexpected '%s'", packet_buffer);
+		default:
+			die("unexpected state %d", state);
 		}
-
-		if (!check_ref(name, flags))
-			continue;
-
-		if (got_dummy_ref_with_capabilities_declaration)
-			die("protocol error: unexpected ref after capabilities^{}");
-
-		ref = alloc_ref(buffer + GIT_SHA1_HEXSZ + 1);
-		oidcpy(&ref->old_oid, &old_oid);
-		*list = ref;
-		list = &ref->next;
 	}
 
 	annotate_refs_with_symref_info(*orig_list);
-- 
2.14.1.992.g2c7b836f3a-goog

