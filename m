Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1306420467
	for <e@80x24.org>; Mon, 16 Oct 2017 17:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754211AbdJPRzr (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 13:55:47 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:57087 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754176AbdJPRzp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 13:55:45 -0400
Received: by mail-it0-f50.google.com with SMTP id r127so2126152itb.5
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 10:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+QmiLDmNNNpseZQKw/APsfNELlrdOFbpGlsdPKrkO2o=;
        b=vlxMPDTQzOp7GBmjS2nOXITK8SCA5fxZ7dU10fPvVE5BETIBeVFUxzlVKbfv2FPzsy
         X1SUIEe5ebkXLe1se8Q+ZZj+PvUSx+AvgSLRjVan9BlI01VgQQb6Gl3jKnN4LzXILUSm
         NqRuPgo8yEUewNCCGdBYbdQZEbWDKdKhJ9NR1fpQQpw+tN+GeXMR0CdRqgkpHLjEY96k
         usD/wq+3jRg5U1vgEV9o0jpmpzA2avUVeHTZt74K1L7v2XK3c2kcZO6C1aTxlugVQall
         m68QuPKZdLJJhWFRvpFSz1kMu6CVvOkTcqE9luldtvtVz5bSfzD7G8PWnrEP+6zwZ7Cs
         P9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+QmiLDmNNNpseZQKw/APsfNELlrdOFbpGlsdPKrkO2o=;
        b=LxD63XvEYAqdAubQtXfizePWazXeDkJRwhcmU9/Su+7GkINPqg7m/euhUsHYUbV0/s
         4CtZWDLuacNnjGb6IjsoojT+HnuYLiYIssEcC+LHYgMxMdnMHJkZp80pqaddDvJ90Rtn
         juKAcU3NySbwVK+PEEhscx+io4vCUe2h4DfJ3fVdA1/bbA7JYPeXyzXGIx+4yK6MzCs7
         XgSXQHAYZCOfMw0PQID748pNtDg7BDrKARIplrZ3X++TgVBI/zIegcw7A8947jgv+Kjt
         gk6e0P7t7Uu+f5IH8E2OqCoCw2sfWzPJUp0+QHsJI36FJ5WZoby7GkDv0m7qCthJqG3L
         YBDQ==
X-Gm-Message-State: AMCzsaXp4jU87V7rCBk1jUtrJV+BTEntroFXrcYmgJ/eQx9bE4w1YH7Q
        uam+U3Cqpq7m3iOf+fDU9t6zWaCclBM=
X-Google-Smtp-Source: ABhQp+Qc81g2e2uEuM6wu9arZsLin0FtHl4alj6rx9OtmnM1OIqyp/AiqoS1WApISefv4IjySSM9lg==
X-Received: by 10.36.149.196 with SMTP id m187mr2234259itd.75.1508176544002;
        Mon, 16 Oct 2017 10:55:44 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s74sm3813071ita.21.2017.10.16.10.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Oct 2017 10:55:42 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     martin.agren@gmail.com, simon@ruderich.org, bturner@atlassian.com,
        git@jeffhostetler.com, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com, peff@peff.net, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 01/11] connect: in ref advertisement, shallows are last
Date:   Mon, 16 Oct 2017 10:55:22 -0700
Message-Id: <20171016175532.73459-2-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc-goog
In-Reply-To: <20171016175532.73459-1-bmwill@google.com>
References: <20171003201507.3589-1-bmwill@google.com>
 <20171016175532.73459-1-bmwill@google.com>
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
2.15.0.rc0.271.g36b669edcc-goog

