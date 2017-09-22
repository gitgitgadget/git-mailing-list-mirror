Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4574202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 00:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751779AbdIVAIO (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 20:08:14 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:45899 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbdIVAIN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 20:08:13 -0400
Received: by mail-pf0-f169.google.com with SMTP id z84so4005909pfi.2
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 17:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZxBtfAxTyU1sJBqSs9FLUqKrteT/j12Ays07yx71I6U=;
        b=bK9yvUW7Ktm8uet4hqf+X2PTUDTip7dblFAGq8KrLK9qfcConczQalgkDGiyeiu3jt
         wmLyKYkZCkUK34gJ6TC3SOa+bR0sdF04KXweaPgxBxyaxbmddWMygCfOzAnTFAqAS2As
         EHoSzzR0SAaiUwESiclJ1a2A4CTb4AD48drk/21KB+4r5/ho/v59Nlkl9PUqifoY4VM7
         3VFlBIRxsZHtGlT2yYVjnrPjpXu40Xz8gFImGK8XamBk5sVBadwQYPPSN6qahWTd+efZ
         1i8gyXX7RKb+q/O06SQEFe3rjJmliVFDIa5tpEVK3Hoi9s/rafu9r+SJwbd9n4ABzeQP
         mFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZxBtfAxTyU1sJBqSs9FLUqKrteT/j12Ays07yx71I6U=;
        b=KXwGFNoHpqJfRh8B1txTxlcRunNiHDP4qW7l8TuD96IkgW+hthtu/t6+hhoe01rqxX
         k/03eZkdKCuKmLweHPWxJxdwSfEm3uy3yHt0pmxdRkGj1X/jV2hWfjQS1lMMItOYgJ3f
         Y1R0RNE7Dh7GfHP6LhEwdFbvQleO97RiWzi86HNCAVnf9g/l2QGL5SXZ4Fgi8dji+Xj0
         4DIMTKdSOOqHQw2XEDUwMgZAdw8mx+AwxpWJfupUGw9IqcWRWz2OB4IiePS6e1rYkpkY
         LR8JWlPOZPb4aFPiRkZ219Bx8uJ63si88+2F7yMTyxd1d9ci9O6RK+gkkodWQtGHDyjz
         znow==
X-Gm-Message-State: AHPjjUin2WAE49KM8Je1nkrkj+FV7oPvWpKXFuV/wleF47rVx+WzO9wb
        lpACK6DalaO1GbHvZ0xsXF590TytSGk=
X-Google-Smtp-Source: AOwi7QAfus+XGXJhYDqk6G850aSAA5DTly3Y/rjobmRp6zl4+CeJs7jtOqVzNCxmAc7BJAhFsVqgcQ==
X-Received: by 10.159.198.11 with SMTP id f11mr7191268plo.290.1506038892767;
        Thu, 21 Sep 2017 17:08:12 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id g25sm4218449pfg.166.2017.09.21.17.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Sep 2017 17:08:11 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        gitster@pobox.com, peff@peff.net, bmwill@google.com
Subject: [PATCH v3] connect: in ref advertisement, shallows are last
Date:   Thu, 21 Sep 2017 17:08:01 -0700
Message-Id: <20170922000801.22560-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.728.g20a5b67d5.dirty
In-Reply-To: <20170922000004.GB77641@google.com>
References: <20170922000004.GB77641@google.com>
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

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
I sent the wrong version of this patch :-(

This should be the correct one. A bit less clean because I introduced a
3rd state, however.

 connect.c | 167 +++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 101 insertions(+), 66 deletions(-)

diff --git a/connect.c b/connect.c
index 49b28b83b..ef6358cfc 100644
--- a/connect.c
+++ b/connect.c
@@ -107,6 +107,91 @@ static void annotate_refs_with_symref_info(struct ref *ref)
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
+#define EXPECTING_REF_WITH_CAPABILITIES 0
+#define EXPECTING_REF 1
+#define EXPECTING_SHALLOW 2
+
+static int process_ref(int *state, int len, struct ref ***list,
+		       unsigned int flags, struct oid_array *extra_have)
+{
+	struct object_id old_oid;
+	char *name;
+	int name_len;
+
+	if (len < GIT_SHA1_HEXSZ + 2 ||
+	    get_oid_hex(packet_buffer, &old_oid) ||
+	    packet_buffer[GIT_SHA1_HEXSZ] != ' ') {
+		*state = EXPECTING_SHALLOW;
+		return 0;
+	}
+
+	name = packet_buffer + GIT_SHA1_HEXSZ + 1;
+	name_len = strlen(name);
+	if (*state == EXPECTING_REF_WITH_CAPABILITIES &&
+	    len != name_len + GIT_SHA1_HEXSZ + 1) {
+		free(server_capabilities);
+		server_capabilities = xstrdup(name + name_len + 1);
+	} else if (*state == EXPECTING_REF) {
+		if (len != name_len + GIT_SHA1_HEXSZ + 1)
+			die("unexpected capabilities after ref name");
+	}
+
+	if (extra_have && !strcmp(name, ".have")) {
+		oid_array_append(extra_have, &old_oid);
+	} else if (!strcmp(name, "capabilities^{}")) {
+		if (**list)
+			/* cannot coexist with other refs */
+			die("protocol error: unexpected capabilities^{}");
+		/* There should be no more refs; proceed to the next state. */
+		*state = EXPECTING_SHALLOW;
+		return 1;
+	} else if (check_ref(name, flags)) {
+		struct ref *ref = alloc_ref(name);
+		oidcpy(&ref->old_oid, &old_oid);
+		**list = ref;
+		*list = &ref->next;
+	}
+	*state = EXPECTING_REF;
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
@@ -123,76 +208,26 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 	 * willing to talk to us.  A hang-up before seeing any
 	 * response does not necessarily mean an ACL problem, though.
 	 */
-	int saw_response;
-	int got_dummy_ref_with_capabilities_declaration = 0;
+	int responded = 0;
+	int len;
+	int state = EXPECTING_REF_WITH_CAPABILITIES;
 
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
 
-		if (!strcmp(name, "capabilities^{}")) {
-			if (saw_response)
-				die("protocol error: unexpected capabilities^{}");
-			if (got_dummy_ref_with_capabilities_declaration)
-				die("protocol error: multiple capabilities^{}");
-			got_dummy_ref_with_capabilities_declaration = 1;
-			continue;
+	while ((len = read_remote_ref(in, &src_buf, &src_len, &responded))) {
+		switch (state) {
+		case EXPECTING_REF_WITH_CAPABILITIES:
+		case EXPECTING_REF:
+			if (process_ref(&state, len, &list, flags, extra_have))
+				break;
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

