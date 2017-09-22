Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB857202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 20:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752344AbdIVUQD (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 16:16:03 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:53709 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbdIVUQC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 16:16:02 -0400
Received: by mail-pf0-f180.google.com with SMTP id x78so1050351pff.10
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 13:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0QYjOgJKruDJrSud3MTeCZEUHYzMcySrNNXl6lydMMs=;
        b=d5uhrFz+80om8bTu7q2yR67zefPsvOYYlN+FiM5LivPsdxsTFfkkpYwaIvqSaoGBb1
         EXOsD3NstsV35TvNLIUF/iHhshAiUj9mXid7i7Cj/h9P0zQrTDnOFgPPAfodnbmSAZa+
         IAVNtsfYZgIKUx2GLArOwsG7JkrJk81XpwDB52M/4Mue6St9uq90tziD38TkFh4wSXNs
         dZvm2pijL+vUXGQMbqQDIEa1xoXQ+kW0DXzp3MbYy7tDfMYeW7U/+2RUpE4lr9HUd9mt
         Ux/RtoyD3YkIl9RaQCK111tXPpfITY9y+MfYtttEvCcSnMXKof4exKKwUYBdERNNMOKC
         511g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0QYjOgJKruDJrSud3MTeCZEUHYzMcySrNNXl6lydMMs=;
        b=YYdx6NeqwcGUlOk/lQYL1DaBcQ4SjLfmNXqDJyqbWXE8dJzr6agfzlc5Cpla2Gjlzp
         htSnpp/8cgSwN7KQHclmrM96z9tqVaO6zGh/PhMhSqsUgzyB6NV6H57WK7vxiVTCkHle
         04WkzlzFF1AqwCsd02SOF+QSqcaf4r61zl+kfDF5v4nUQL3UUymRKU4NOEpol7NMibJJ
         OgEw7DVXKHkTVG1ugjr7lXiBfIuUK4tBlNTyOs7w4ACKsPnAqb0cWIPAy8xCjbXqJ4VV
         sHpkWEq5z55Tkp5Y0NkFlO7G1qVtneoPyroOv3r0MvP62W8OmsZyN1tknzupqqRH66Cf
         WRTg==
X-Gm-Message-State: AHPjjUgllBvYZLx3h6c0OkcjGyNmzcQmOA/AYVdriWmIquM0htwd/Vw+
        3rDa3H6sf3PUZxD2WQmfidkbpezhqPc=
X-Google-Smtp-Source: AOwi7QCRQbvtTF9C3wgfHuDSXHyNxRWXBkaQqGO8tM/KdvO+le4z9W5JCG60I22HuYZ27T/d54x3Nw==
X-Received: by 10.84.235.132 with SMTP id p4mr12011plk.310.1506111361308;
        Fri, 22 Sep 2017 13:16:01 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id y83sm744776pff.167.2017.09.22.13.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Sep 2017 13:16:00 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        gitster@pobox.com, peff@peff.net, bmwill@google.com
Subject: [PATCH v4] connect: in ref advertisement, shallows are last
Date:   Fri, 22 Sep 2017 13:15:51 -0700
Message-Id: <20170922201551.15012-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.728.g20a5b67d5.dirty
In-Reply-To: <20170922164504.GD77641@google.com>
References: <20170922164504.GD77641@google.com>
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
first line in the ref advertisement, ignoring all others.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
I've updated state transitions to occur in get_remote_heads() instead,
as suggested. I didn't want to do that previously because each step in
the state machine needed to communicate if (i) the line is "consumed"
and (ii) the state needed to be advanced, but with Junio's suggestion to
reorganize the methods, that is no longer true.

As Junio said, the free(server_capabilities) can be removed.

As for whether how capabilities on subsequent lines are handled, I think
it's better to ignore them - they are behind NULs, after all.

Yes, "connect: teach client to recognize v1 server response" will need
to be modified.

This change does have the side effect that if the server sends a ref
advertisement with "shallow"s only (and no refs), things will still
work, and the server can even tuck capabilities on the first "shallow"
line. I think that's fine, and it does make the client code cleaner.
---
 connect.c | 171 ++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 105 insertions(+), 66 deletions(-)

diff --git a/connect.c b/connect.c
index 49b28b83b..978d01359 100644
--- a/connect.c
+++ b/connect.c
@@ -11,6 +11,7 @@
 #include "string-list.h"
 #include "sha1-array.h"
 #include "transport.h"
+#include "strbuf.h"
 
 static char *server_capabilities;
 static const char *parse_feature_value(const char *, const char *, int *);
@@ -107,6 +108,86 @@ static void annotate_refs_with_symref_info(struct ref *ref)
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
+static void process_capabilities(int len)
+{
+	int nul_location = strlen(packet_buffer);
+	if (nul_location == len)
+		return;
+	server_capabilities = xstrdup(packet_buffer + nul_location + 1);
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
+static int process_ref(struct ref ***list, unsigned int flags,
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
+	} else if (check_ref(name, flags)) {
+		struct ref *ref = alloc_ref(name);
+		oidcpy(&ref->old_oid, &old_oid);
+		**list = ref;
+		*list = &ref->next;
+	}
+	return 1;
+}
+
+static int process_shallow(struct oid_array *shallow_points)
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
+	return 1;
+}
+
 /*
  * Read all the refs from the other end
  */
@@ -123,76 +204,34 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
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
+			process_capabilities(len);
+			if (process_dummy_ref()) {
+				state = EXPECTING_SHALLOW;
+				break;
+			}
+			state = EXPECTING_REF;
+			/* fallthrough */
+		case EXPECTING_REF:
+			if (process_ref(&list, flags, extra_have))
+				break;
+			state = EXPECTING_SHALLOW;
+			/* fallthrough */
+		case EXPECTING_SHALLOW:
+			if (process_shallow(shallow_points))
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
2.14.1.728.g20a5b67d5.dirty

