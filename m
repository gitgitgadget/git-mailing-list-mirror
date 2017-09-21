Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1DCD202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 20:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751741AbdIUUpH (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 16:45:07 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:46347 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbdIUUpG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 16:45:06 -0400
Received: by mail-pf0-f182.google.com with SMTP id r68so3782012pfj.3
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 13:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=imZ75qcqtZxL2TqhdLec3eFXclFFXrXFDElvOIA3190=;
        b=Dd1/3y26ck8wlh+4JXEu4WSONEyWFcPrb8OQm0P2h9jH7gsoHf8i8sgdIOrg+222pL
         WwLKmPd+jO5V9KMBGr+fbZ5RDp2pXWYoxwqCpBBJUVhv+1cPUQ9wdEL3atxHoqxSHtJX
         0g4NrRETey/ngOXfbLt3sLalJWyXPfBGOIwhuPFMElizxE3HvI4h7XnPiVploTZDSwZ+
         k2xKA6gVlfLjkeUxpUYmcU2Q0ZwQFgQYCo08J7c1OLQ530iDAc417gz/6Y1UrImoPBVG
         TpTXXsAxY9lgZfGXcPkiCwEkh5kjdlRtbmsmSWnnPytClHfRuA2xPLJLJPEUXRELhHg+
         XTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=imZ75qcqtZxL2TqhdLec3eFXclFFXrXFDElvOIA3190=;
        b=Ldv+KZLTIO3krfy+vuz/E7OBkNOVyhTJWaBftb7GCTX07EINfRJm3wEVhvkFKwkADV
         naaCi6QWJAU6zZ/UaP1hTHXqVy7lXb3qZEwP7I8k4/clarfWsyIAotoir+qeit/+5LMG
         N1wJTFZY84ckhYJaShhLgaLnj7RbVvf5yWqaJMiGLIJH9ZPYqKOIO1wpvAiM1yebW2IC
         SsVBHyPj5wCQuvCYHxQ05pLc2/zvxGQOFPARlqeW6toRUpDE+y/4rW/tOYZ7QyozbIqV
         TrB7TeFnKzbciOsU7siBp/3FqiTmIpHgEXdcBN6yKp5T/li3b02IGJSUC7rjaq8lbQPD
         vlpA==
X-Gm-Message-State: AHPjjUjMER/F9k2azRnR4uaFxfip3xCBTeA1dJevAF2UGulm06scI++Y
        j4uq23dJjMV7W7naCGpocqWbbz5iyhk=
X-Google-Smtp-Source: AOwi7QAnqlfCqsVybi+YBFungIpGBw/UzKQhqvpKnv3cXo2F9taYeOb1BW/RUYT2Ojcs47zOJlT+WA==
X-Received: by 10.99.127.68 with SMTP id p4mr6863606pgn.253.1506026705442;
        Thu, 21 Sep 2017 13:45:05 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id t19sm3648300pfa.73.2017.09.21.13.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Sep 2017 13:45:04 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH] connect: in ref advertisement, shallows are last
Date:   Thu, 21 Sep 2017 13:45:01 -0700
Message-Id: <20170921204501.32198-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.728.g20a5b67d5.dirty
In-Reply-To: <20170920200627.GA82704@google.com>
References: <20170920200627.GA82704@google.com>
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
It seems that some people are concerned about looseness in interpreting
the ref advertisement, so here is a patch to tighten it instead. This is
a replacement for Brandon's PATCH 1.5.

I think this is what Jonathan Nieder meant by his instruction flow idea.

I've checked that Brandon's other patches apply cleanly on this patch,
except for "connect: teach client to recognize v1 server response" which
has to be modified to the following:

    @@ -149,6 +150,26 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
     	*list = NULL;
     
     	len = read_remote_ref(in, &src_buf, &src_len, &responded);
    +
    +	switch (determine_protocol_version_client(packet_buffer)) {
    +	case protocol_v1:
    +		/*
    +		 * First pkt-line contained the version string.
    +		 * Continue on to process the ref advertisement.
    +		 */
    +		len = read_remote_ref(in, &src_buf, &src_len, &responded);
    +		break;
    +	case protocol_v0:
    +		/*
    +		 * Server is speaking protocol v0 and sent a
    +		 * ref so we need to process it.
    +		 */
    +		break;
    +	default:
    +		die("server is speaking an unknown protocol");
    +		break;
    +	}
    +

 connect.c | 112 ++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 61 insertions(+), 51 deletions(-)

diff --git a/connect.c b/connect.c
index 49b28b83b..9bf97adf6 100644
--- a/connect.c
+++ b/connect.c
@@ -107,6 +107,26 @@ static void annotate_refs_with_symref_info(struct ref *ref)
 	string_list_clear(&symref, 0);
 }
 
+/*
+ * Read one line of a server's ref advertisement into packet_buffer.
+ */
+int read_remote_ref(int in, char **src_buf, size_t *src_len, int *responded)
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
 /*
  * Read all the refs from the other end
  */
@@ -123,46 +143,23 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 	 * willing to talk to us.  A hang-up before seeing any
 	 * response does not necessarily mean an ACL problem, though.
 	 */
-	int saw_response;
-	int got_dummy_ref_with_capabilities_declaration = 0;
+	int responded = 0;
+	int len;
 
 	*list = NULL;
-	for (saw_response = 0; ; saw_response = 1) {
-		struct ref *ref;
+
+	len = read_remote_ref(in, &src_buf, &src_len, &responded);
+	do {
 		struct object_id old_oid;
 		char *name;
-		int len, name_len;
-		char *buffer = packet_buffer;
-		const char *arg;
+		int name_len;
 
-		len = packet_read(in, &src_buf, &src_len,
-				  packet_buffer, sizeof(packet_buffer),
-				  PACKET_READ_GENTLE_ON_EOF |
-				  PACKET_READ_CHOMP_NEWLINE);
-		if (len < 0)
-			die_initial_contact(saw_response);
-
-		if (!len)
+		if (len < GIT_SHA1_HEXSZ + 2 ||
+		    get_oid_hex(packet_buffer, &old_oid) ||
+		    packet_buffer[GIT_SHA1_HEXSZ] != ' ')
 			break;
 
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
+		name = packet_buffer + GIT_SHA1_HEXSZ + 1;
 		name_len = strlen(name);
 		if (len != name_len + GIT_SHA1_HEXSZ + 1) {
 			free(server_capabilities);
@@ -171,29 +168,42 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 
 		if (extra_have && !strcmp(name, ".have")) {
 			oid_array_append(extra_have, &old_oid);
-			continue;
-		}
-
-		if (!strcmp(name, "capabilities^{}")) {
-			if (saw_response)
+		} else if (!strcmp(name, "capabilities^{}")) {
+			if (*list)
+				/* cannot coexist with other refs */
 				die("protocol error: unexpected capabilities^{}");
-			if (got_dummy_ref_with_capabilities_declaration)
-				die("protocol error: multiple capabilities^{}");
-			got_dummy_ref_with_capabilities_declaration = 1;
-			continue;
+			/*
+			 * There should be no more refs; read the next line and
+			 * go to next block.
+			 */
+			len = read_remote_ref(in, &src_buf, &src_len,
+					      &responded);
+			break;
+		} else if (check_ref(name, flags)) {
+			struct ref *ref = alloc_ref(name);
+			oidcpy(&ref->old_oid, &old_oid);
+			*list = ref;
+			list = &ref->next;
 		}
+	} while ((len = read_remote_ref(in, &src_buf, &src_len, &responded)));
 
-		if (!check_ref(name, flags))
-			continue;
+	do {
+		const char *arg;
+		struct object_id old_oid;
 
-		if (got_dummy_ref_with_capabilities_declaration)
-			die("protocol error: unexpected ref after capabilities^{}");
+		if (skip_prefix(packet_buffer, "shallow ", &arg)) {
+			if (get_oid_hex(arg, &old_oid))
+				die("protocol error: expected shallow sha-1, got '%s'", arg);
+			if (!shallow_points)
+				die("repository on the other end cannot be shallow");
+			oid_array_append(shallow_points, &old_oid);
+		} else {
+			break;
+		}
+	} while ((len = read_remote_ref(in, &src_buf, &src_len, &responded)));
 
-		ref = alloc_ref(buffer + GIT_SHA1_HEXSZ + 1);
-		oidcpy(&ref->old_oid, &old_oid);
-		*list = ref;
-		list = &ref->next;
-	}
+	if (len)
+		die("protocol error: unexpected '%s'", packet_buffer);
 
 	annotate_refs_with_symref_info(*orig_list);
 
-- 
2.14.1.728.g20a5b67d5.dirty

