Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FD9C433E0
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 22:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96EA1206EB
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 22:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gvd8VvkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgGXWiu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 18:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgGXWit (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 18:38:49 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30664C0619D3
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 15:38:49 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id ba2so6417870plb.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 15:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=oGGmANiWYRz2cfeqYz1QWzU9UB5XnVP0RJTEch6uElQ=;
        b=gvd8VvkXpB4MAipBgXsxQvFUnnA9TcxeWBKmgnnB51HbgEeflfP+O/84fE2/LMle4w
         hJh1tf6QhRCkMgRcpI0HILsohov0jCpLNW9TGv8/WxecXAXf8Zb3NnF3b6PWwpayc4kT
         Yfd21a+NgQrAGZxPiYE/kTwSTIBb7MdNlwCSYcDfENykrVcoCUIMS+ykgMlY2+r2TLoe
         ijq188gqseKuvN6VkYQguqjJ3MyT8t3/SKeU/3awcm1GNY/XVNTDFE084R6UjpPsEU5q
         Zoj7wnEFJevSAkQTOHz2O1H4Rd7LYg1HffS/+6eHMHVzZA85EDmdRMYgGrmGMpFAduy+
         3H2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=oGGmANiWYRz2cfeqYz1QWzU9UB5XnVP0RJTEch6uElQ=;
        b=Jp6vac6BtgyhdjpeXwu1eJuOZ/IzGRvRDtPSPEPAsmDEyMdFr5ERpoQ+NSeS6y5NNL
         4v+xj3P1LSuPnlJqCJAeWx82+06YgJJ619cxAieUd+Oe1/HcpzxyNbtMYp67lBrnvKDq
         9BJiDq50sWSvJX0SFxaiBQBSFNtQ3nLvx5DZzbYgSPIe6/DON14zoEpmmPSNyJ5uUGDs
         Bcje+3UzlcgFMv1Dsu+4FJsAuSHOk84qpTR4bifiuyQnS2V/yZ+49J8RRuqV7/oqBpI/
         CNLjDF/9segUdJzUKlyczJJ7wEOyHChWnhupOaJo2jYBPTn+SqzqsrSDNQhT5jTOtUXe
         FnNw==
X-Gm-Message-State: AOAM530JFQNG1P5PYR7kroS2qJzrpHWrzndiBeelk2iDzqsnqAn9Ajy6
        D/uX0+kkak0yean6AJhqiP0HF6XUgUD+iZ7x/jlydIKj2us6T+mXhfWVChFZxa0RVgI2MhRo1Z4
        b/CdWDtnmSVmCHT2ugaitMAwm4M6/kWqeYPlE3DDbSivd+D2n1QP1zFOCaZgVa7mxVkmLZE+A88
        AF
X-Google-Smtp-Source: ABdhPJzTcdYayUxSubzQdWlECRAVxbEaKt79h3d7CbsZxQIhlwXeZxhc/g3WXcuosm7unlSkpC2/N/0i8a1laZT2WwYp
X-Received: by 2002:a62:7650:: with SMTP id r77mr10588213pfc.235.1595630328435;
 Fri, 24 Jul 2020 15:38:48 -0700 (PDT)
Date:   Fri, 24 Jul 2020 15:38:44 -0700
Message-Id: <20200724223844.2723397-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [RFC PATCH] Modify fetch-pack to no longer die on error?
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We've had a few instances where a lazy fetch in a partial clone fails,
leading to a fatal error, when the calling code could have easily
recovered - in other words, the severity of the bug should have just a
wasted fetch instead of stopping the whole command. Part of the issue
(and possibly the whole issue - I haven't looked at this beyond
fetch-pack yet) is that fetch-pack dies whenever it encounters an
error, so I took a look at fixing that.

(Note that fetch-pack is sometimes run through a remote helper, meaning
that we could leave the die() invocations in and just make sure that we
handle failure in the separate process correctly. But when the promisor
remote is HTTP protocol v2 or SSH protocol v0/v2, this is not true -
fetch_pack() is run in-process.)

I think the best way for easy authorship and review is to convert each
possibly-dying function into a function that either returns a
possibly-null error string or returns success/failure and writes the
error string into an "out" parameter. In this way, the change is rather
mechanical and should be easy to review. In the patch below I chose the
former approach, and I modified 2 functions (one that returns no value
and one that returns a value) to demonstrate what it would look like.

We could also take this further and have a "struct error" for type
safety and macros - e.g. THROW() to return a "struct error", TRY() to
execute what's inside the parentheses and return the error if there is
one, and OR_DIE() to execute what's inside the parentheses and die if
there is an error.

Any opinions before I continue working on this?

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 78 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 25 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 80fb3bd899..20a7e05ea8 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -24,6 +24,8 @@
 #include "fsck.h"
 #include "shallow.h"
 
+typedef char * error_string;
+
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
 static int unpack_limit = 100;
@@ -136,8 +138,8 @@ enum ack_type {
 	ACK_ready
 };
 
-static void consume_shallow_list(struct fetch_pack_args *args,
-				 struct packet_reader *reader)
+static error_string consume_shallow_list(struct fetch_pack_args *args,
+					 struct packet_reader *reader)
 {
 	if (args->stateless_rpc && args->deepen) {
 		/* If we sent a depth we will get back "duplicate"
@@ -149,41 +151,54 @@ static void consume_shallow_list(struct fetch_pack_args *args,
 				continue;
 			if (starts_with(reader->line, "unshallow "))
 				continue;
-			die(_("git fetch-pack: expected shallow list"));
+			return xstrdup(_("git fetch-pack: expected shallow list"));
 		}
 		if (reader->status != PACKET_READ_FLUSH)
-			die(_("git fetch-pack: expected a flush packet after shallow list"));
+			return xstrdup(_("git fetch-pack: expected a flush packet after shallow list"));
 	}
+	return NULL;
 }
 
-static enum ack_type get_ack(struct packet_reader *reader,
-			     struct object_id *result_oid)
+static error_string get_ack(struct packet_reader *reader,
+			    enum ack_type *result_ack,
+			    struct object_id *result_oid)
 {
 	int len;
 	const char *arg;
 
 	if (packet_reader_read(reader) != PACKET_READ_NORMAL)
-		die(_("git fetch-pack: expected ACK/NAK, got a flush packet"));
+		return xstrdup(_("git fetch-pack: expected ACK/NAK, got a flush packet"));
 	len = reader->pktlen;
 
-	if (!strcmp(reader->line, "NAK"))
-		return NAK;
+	if (!strcmp(reader->line, "NAK")) {
+		*result_ack = NAK;
+		return NULL;
+	}
 	if (skip_prefix(reader->line, "ACK ", &arg)) {
 		const char *p;
 		if (!parse_oid_hex(arg, result_oid, &p)) {
 			len -= p - reader->line;
-			if (len < 1)
-				return ACK;
-			if (strstr(p, "continue"))
-				return ACK_continue;
-			if (strstr(p, "common"))
-				return ACK_common;
-			if (strstr(p, "ready"))
-				return ACK_ready;
-			return ACK;
+			if (len < 1) {
+				*result_ack = ACK;
+				return NULL;
+			}
+			if (strstr(p, "continue")) {
+				*result_ack = ACK_continue;
+				return NULL;
+			}
+			if (strstr(p, "common")) {
+				*result_ack = ACK_common;
+				return NULL;
+			}
+			if (strstr(p, "ready")) {
+				*result_ack = ACK_ready;
+				return NULL;
+			}
+			*result_ack = ACK;
+			return NULL;
 		}
 	}
-	die(_("git fetch-pack: expected ACK/NAK, got '%s'"), reader->line);
+	return xstrfmt(_("git fetch-pack: expected ACK/NAK, got '%s'"), reader->line);
 }
 
 static void send_request(struct fetch_pack_args *args,
@@ -394,7 +409,8 @@ static int find_common(struct fetch_negotiator *negotiator,
 		print_verbose(args, "have %s", oid_to_hex(oid));
 		in_vain++;
 		if (flush_at <= ++count) {
-			int ack;
+			enum ack_type ack;
+			error_string err;
 
 			packet_buf_flush(&req_buf);
 			send_request(args, fd[1], &req_buf);
@@ -409,9 +425,11 @@ static int find_common(struct fetch_negotiator *negotiator,
 			if (!args->stateless_rpc && count == INITIAL_FLUSH)
 				continue;
 
-			consume_shallow_list(args, &reader);
+			if ((err = consume_shallow_list(args, &reader)))
+				die("%s", err);
 			do {
-				ack = get_ack(&reader, result_oid);
+				if ((err = get_ack(&reader, &ack, result_oid)))
+					die("%s", err);
 				if (ack)
 					print_verbose(args, _("got %s %d %s"), "ack",
 						      ack, oid_to_hex(result_oid));
@@ -457,6 +475,9 @@ static int find_common(struct fetch_negotiator *negotiator,
 						got_ready = 1;
 					break;
 					}
+				case NAK:
+					/* nothing */
+					break;
 				}
 			} while (ack);
 			flushes--;
@@ -481,10 +502,17 @@ static int find_common(struct fetch_negotiator *negotiator,
 	}
 	strbuf_release(&req_buf);
 
-	if (!got_ready || !no_done)
-		consume_shallow_list(args, &reader);
+	if (!got_ready || !no_done) {
+		error_string err;
+		if ((err = consume_shallow_list(args, &reader)))
+			die("%s", err);
+	}
 	while (flushes || multi_ack) {
-		int ack = get_ack(&reader, result_oid);
+		error_string err;
+		enum ack_type ack;
+
+		if ((err = get_ack(&reader, &ack, result_oid)))
+			die("%s", err);
 		if (ack) {
 			print_verbose(args, _("got %s (%d) %s"), "ack",
 				      ack, oid_to_hex(result_oid));
-- 
2.28.0.rc0.142.g3c755180ce-goog

