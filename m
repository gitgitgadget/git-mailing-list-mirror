Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CD6D20281
	for <e@80x24.org>; Tue, 26 Sep 2017 18:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969941AbdIZSV5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 14:21:57 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:55898 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966343AbdIZSVz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 14:21:55 -0400
Received: by mail-pf0-f181.google.com with SMTP id r71so5930644pfe.12
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 11:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cTU8W4wpLobIP0US1083CVYO/uX/RGKnOGvfIX5QoI0=;
        b=nfiAzjML9wRLaTEDPovw6wTreBNReGKFx6SMggxRkHapczn5gZ2w8KSLic/VHRN7iV
         uZOPqiEy7gNJT4STy5b+a9D9+5kU9fD5tZPTwIPv8NKJkj3VwkI6k+NYdD3JVd4vQiKp
         eOdBBfCedfqbO+uRFrIedNWL3/rvNjOXdn0rvbl55gmUiCFm7uINeOBcdQCVCrcWZF1j
         ypIzDzBXkWxky3QVQQkLnmTALGsvRiTCfsa+Vy77EZqBf8oKwOqCGqtEpywqLzEi8GYJ
         Z8KsevH0RbzaGKl2ZGwD/lQvfPT+i28puxmA674jzBvYImrt8qdVr05nEkh0SFuG6pge
         AoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cTU8W4wpLobIP0US1083CVYO/uX/RGKnOGvfIX5QoI0=;
        b=J98hT47VO1Mgj/4AYXs6idbWC9pL7sWV6TX4Apzarg9T+BdsAnaUmIUY7wzprHO0OK
         hwg0wKi09TxLUaQeQwn+829IRQaIRlmv1ETjtHas9FfKCQ+bXY4L7OBNjlIxsvQ7+pCn
         U40XasOhTRjQDuAvQj6kPoQvdIYsqq1wMCw4ZW0kv5i88aVmxszKPedBUWqLiIFBPBu3
         tRvylg1pHIRCPVBdIMR5uLFWhwnJdMi+Odr/BUV6DUjFdTXMwyoWhYt4qW2LhqTDhR6R
         mGYJTqBS02f83yYFnjrVDD9X7mqtubnejRfXCJj6qqtla7LIrvwSN9+5ftAs5B9P3Q5n
         Xuzg==
X-Gm-Message-State: AHPjjUjByiF2gtW/CVFfHf3GqE4BOmbOL3ljEss2f+CebSSRs3n77ubQ
        pzTnmW3+t21kPIkrLadcK/tUAKNcP10=
X-Google-Smtp-Source: AOwi7QAkaObLXlCsik6mlByjJx1YgDXn7DUQ9Pl6S3CVtqK/2l3qAmxgsf5h6RsV7oIVJG/GyzSoWw==
X-Received: by 10.159.194.193 with SMTP id u1mr11348569plz.93.1506450114532;
        Tue, 26 Sep 2017 11:21:54 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id a1sm18975931pgu.47.2017.09.26.11.21.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 11:21:53 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        bmwill@google.com
Subject: [PATCH v5] connect: in ref advertisement, shallows are last
Date:   Tue, 26 Sep 2017 11:21:47 -0700
Message-Id: <20170926182147.73336-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.730.g85712e8bc.dirty
In-Reply-To: <20170921204501.32198-1-jonathantanmy@google.com>
References: <20170921204501.32198-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
---
Changes in v5:
 - print warning when encountering capabilities on other lines instead
   of ignoring them (also updated commit message)
 - explicitly disallow refs of name "capabilities^{}" (except when it is
   the only ref)
---
 connect.c | 183 +++++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 117 insertions(+), 66 deletions(-)

diff --git a/connect.c b/connect.c
index df56c0cbf..df65a3fc4 100644
--- a/connect.c
+++ b/connect.c
@@ -11,6 +11,7 @@
 #include "string-list.h"
 #include "sha1-array.h"
 #include "transport.h"
+#include "strbuf.h"
 
 static char *server_capabilities;
 static const char *parse_feature_value(const char *, const char *, int *);
@@ -107,6 +108,98 @@ static void annotate_refs_with_symref_info(struct ref *ref)
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
+	static char *template;
+	if (!template)
+		template = xstrfmt("%040d capabilities^{}", 0);
+	return !strcmp(packet_buffer, template);
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
@@ -123,76 +216,34 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
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
-
-		if (len < GIT_SHA1_HEXSZ + 2 || get_oid_hex(buffer, &old_oid) ||
-			buffer[GIT_SHA1_HEXSZ] != ' ')
-			die("protocol error: expected sha/ref, got '%s'", buffer);
-		name = buffer + GIT_SHA1_HEXSZ + 1;
 
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
2.14.1.821.g8fa685d3b7-goog

