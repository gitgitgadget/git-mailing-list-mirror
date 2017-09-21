Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AC0E202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 23:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbdIUXpn (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 19:45:43 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:54320 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751773AbdIUXpm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 19:45:42 -0400
Received: by mail-pf0-f172.google.com with SMTP id d187so3968494pfg.11
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 16:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rIgyP6uDYHo7earqIvEli4UfWxhEJR25Ao8FusIao0w=;
        b=g7zHTTagbkJOu3qRE/ivOGD2oyT7toA7OEsTodjggsDIlwzdNKS7CZTg9W8CGZt+Cy
         N+pjZcXdlZZDgLzNMYURQZFT5KEOw+xONKHQ+QbRFcYtOMt50vWQ/tArLfoxxtCFKrUk
         dN52Fdt2iVbu/bikzie6ctwZM7byaV0sxJYESkX7lad97Croi7xN0kNP4uluavEBieS+
         0m74YiyFpssap+/tYeLwmmFTfrmTA3QmKaFmmJFHsWXVVDPWvyvTTvta7rdYTeebXVqc
         2O9YICPn4OPW0GEENLnHihHe6ZMwcQQXh4b8yR8cY64NxCDDafsxjOWdSDHJAOHRu1d1
         Weuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rIgyP6uDYHo7earqIvEli4UfWxhEJR25Ao8FusIao0w=;
        b=hhBAYyo7svOLoR5b8Gmvlt7zhHPGiyeMiKwm21HjpcrR+mlCeBYujCjavP1m6Cp8wt
         QAoZNu+mHJfRBB0mEFRG/864Rs1BWJxhFKIpFm8yD6qCf+QphenYy3khNz3h5BtBzmYm
         MQm5tOKGYUyFvOn4fpNBvUU4bzJ3PY1VW6GfFL9z8xyUnCD62Tky8KW5VWg32UgNYE+/
         PkKS0MXMfrh9jve3ZQc3L937Rk2GXGOmd74EgS9YXUIdufMf2BM0Iv+82EDDHB7oqbDH
         nAcCwxuFjpABXiqhuOTCd6/nU0iMGmzOGf3iPPVg19lHzWZw+Zs5rb4T2m9djFAXYGEJ
         e+/Q==
X-Gm-Message-State: AHPjjUgD1qkBfBK4py8dT55fFmccCa4+0u0piKfm4BR6vxBVqFowLweq
        t9RgplfHpb50bqXDTkzp0Rijrj8kW/k=
X-Google-Smtp-Source: AOwi7QAYncJIvK/jPRnbjBjF8tJE/b1P0nqxbLZna2s28T3DTDoIQzYbNZd2FaQwWw9ffoxmjMDGxA==
X-Received: by 10.99.100.4 with SMTP id y4mr7335313pgb.147.1506037541186;
        Thu, 21 Sep 2017 16:45:41 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id g66sm4918234pfj.161.2017.09.21.16.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Sep 2017 16:45:40 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        gitster@pobox.com, peff@peff.net, bmwill@google.com
Subject: [PATCH v2] connect: in ref advertisement, shallows are last
Date:   Thu, 21 Sep 2017 16:45:34 -0700
Message-Id: <20170921234534.18964-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.728.g20a5b67d5.dirty
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

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
In some in-office discussion, I was informed that my original patch
relaxed the ordering of ".keep" lines. Here is an update.

I'm also using a switch statement now, which avoids having multiple
lines of read_remote_ref().

 connect.c | 159 ++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 93 insertions(+), 66 deletions(-)

diff --git a/connect.c b/connect.c
index 49b28b83b..e0821dbff 100644
--- a/connect.c
+++ b/connect.c
@@ -107,6 +107,84 @@ static void annotate_refs_with_symref_info(struct ref *ref)
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
+#define EXPECTING_REF 0
+#define EXPECTING_SHALLOW 1
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
+		(*state)++;
+		return 0;
+	}
+
+	name = packet_buffer + GIT_SHA1_HEXSZ + 1;
+	name_len = strlen(name);
+	if (len != name_len + GIT_SHA1_HEXSZ + 1) {
+		free(server_capabilities);
+		server_capabilities = xstrdup(name + name_len + 1);
+	}
+
+	if (extra_have && !strcmp(name, ".have")) {
+		oid_array_append(extra_have, &old_oid);
+	} else if (!strcmp(name, "capabilities^{}")) {
+		if (**list)
+			/* cannot coexist with other refs */
+			die("protocol error: unexpected capabilities^{}");
+		/* There should be no more refs; proceed to the next state. */
+		(*state)++;
+	} else if (check_ref(name, flags)) {
+		struct ref *ref = alloc_ref(name);
+		oidcpy(&ref->old_oid, &old_oid);
+		**list = ref;
+		*list = &ref->next;
+	}
+	return 1;
+}
+
+static int process_shallow(int *state, struct oid_array *shallow_points)
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
@@ -123,76 +201,25 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 	 * willing to talk to us.  A hang-up before seeing any
 	 * response does not necessarily mean an ACL problem, though.
 	 */
-	int saw_response;
-	int got_dummy_ref_with_capabilities_declaration = 0;
+	int responded = 0;
+	int len;
+	int state = EXPECTING_REF;
 
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
+		case EXPECTING_REF:
+			if (process_ref(&state, len, &list, flags, extra_have))
+				break;
+			/* fallthrough */
+		case EXPECTING_SHALLOW:
+			if (process_shallow(&state, shallow_points))
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

