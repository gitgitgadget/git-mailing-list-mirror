Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C450C2BBC7
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 12:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42821206D5
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 12:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeEwCeg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502005AbgDNMd0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2501990AbgDNMdI (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 08:33:08 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93248C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 05:33:08 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g32so5933029pgb.6
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 05:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uyKk3i2XP4OGAaGs4qt7DNkx2l/Sje63xPbOYfvCtMk=;
        b=SeEwCeg6NjH4NdRf3d33uJ/V54dud2uKg8dipcx+WP4AQyUTJHqmBi7KZ2J7LcvMEH
         kEXgy4akybWZHLVdqp3okHHFRWIGBsgqvTLJMo+CxqpChn8wzGxWo0uga1leM2QAIzq7
         61djqd9z6OgkIyPePGMoDtexvVmyObSG9cHr4KjfO3mmbOMrjQd/acilYaY6VJc4rEIU
         XwBof4wq03g7DbArjBR8vTwi6XRcyJ1al3uhobfPsglG+AK7C6JYGWi9OfHjZKhvygTK
         7VMXa5q8MY/QpbnweJly5Z9Uj37ZsPR36qbeNVO1lmsbGqltZw6qpz9jvv/TmEMB5vuy
         UQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uyKk3i2XP4OGAaGs4qt7DNkx2l/Sje63xPbOYfvCtMk=;
        b=joNF8xY6+HAHKWTsBYKrNLf7lF6CQoiNBM9nX038xWA8StsnPfx/NzkL1ZW3qHiQ9v
         Ad0n/8MnFkIh2kGh0wJ5eE3w9kxWVYVXNJCDUOfFmjl3iyjLJOoX/F1bPGhMDmVmAt5s
         UO/9UVsR5sgc3A0/7HQp21GHBoCxXEGqGh4h29OkXG6Ze8Ur06J3R2SZxf7CmDtubg1p
         UtVNyuVqOgJu6QJJCKrF1JEXldEz2bXZpuyzMQyvGHO7nhElL5gb9WfnMfrLhtENljNg
         hdcrJEpRCyqytpsnOYVpIVglNHIhAwP817DFn8rI2A2PNli0d/uRR+MIYxwwQ+L/Axqk
         pDVw==
X-Gm-Message-State: AGi0PuaOZjAh3F5yjOqZTOaDXd9G4PpQMxedQ/Gx+gxqewrgzHSs0rf1
        SYvcgbQ/I+ybC3wKPt95wVw=
X-Google-Smtp-Source: APiQypImdaECZn9T91Y8BREuKtuDrnx7u9wA9tuToa+Tsu/kcDVp/DyUDGsyClXbYzD2LdP7/vjSKA==
X-Received: by 2002:a63:1f0c:: with SMTP id f12mr20959858pgf.245.1586867588049;
        Tue, 14 Apr 2020 05:33:08 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id c9sm996177pfp.53.2020.04.14.05.33.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2020 05:33:07 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v12 4/7] send-pack: extension for client-side status report
Date:   Tue, 14 Apr 2020 08:32:54 -0400
Message-Id: <20200414123257.27449-5-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqq3697cax0.fsf@gitster.c.googlers.com>
References: <xmqq3697cax0.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

This is the client-side extension for status report of git-push.

The "proc-receive" hook may receive a command for a pseudo-reference
with a zero-old as its old-oid, while the result of the hook may point
to an alternate reference and the reference may exist already with a
non-zero old-oid.  Git client may receive a report with extened status
as the following example:

    ok refs/for/master/topic\0ref=refs/pull/123/head old-oid=...

Parse the key-value pairs in the extended status after the null
character of the report, and show the proper reference name, old-oid
and new-oid to the user.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 remote.c                     | 28 +++++++++++++
 remote.h                     |  3 ++
 send-pack.c                  | 11 +++++-
 t/t5411/common-test-cases.sh |  9 +++--
 transport-helper.c           | 64 +++++++++++++++---------------
 transport.c                  | 76 +++++++++++++++++++++++++++++++++---
 6 files changed, 149 insertions(+), 42 deletions(-)

diff --git a/remote.c b/remote.c
index c43196ec06..0b22d9e14c 100644
--- a/remote.c
+++ b/remote.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "connect.h"
 #include "remote.h"
 #include "refs.h"
 #include "refspec.h"
@@ -2311,3 +2312,30 @@ void apply_push_cas(struct push_cas_option *cas,
 	for (ref = remote_refs; ref; ref = ref->next)
 		apply_cas(cas, remote, ref);
 }
+
+void update_ref_from_remote_status(struct ref *ref)
+{
+	char *val;
+	char c;
+	int len;
+
+	if (!ref->remote_status)
+		return;
+
+	val = (char *)parse_feature_value(ref->remote_status, "old-oid", &len);
+	if (val && len) {
+		c = *(val+len);
+		*(val+len) = '\0';
+		get_oid_hex(val, &ref->old_oid);
+		*(val+len) = c;
+	}
+	val = (char *)parse_feature_value(ref->remote_status, "new-oid", &len);
+	if (val && len) {
+		c = *(val+len);
+		*(val+len) = '\0';
+		get_oid_hex(val, &ref->new_oid);
+		*(val+len) = c;
+	}
+	if (parse_feature_request(ref->remote_status, "forced-update"))
+		ref->forced_update = 1;
+}
diff --git a/remote.h b/remote.h
index 11d8719b58..09cf7014e3 100644
--- a/remote.h
+++ b/remote.h
@@ -345,4 +345,7 @@ int parseopt_push_cas_option(const struct option *, const char *arg, int unset);
 int is_empty_cas(const struct push_cas_option *);
 void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
 
+/* Parse key-value pairs of remote_status and update the reference accordingly */
+void update_ref_from_remote_status(struct ref *ref);
+
 #endif
diff --git a/send-pack.c b/send-pack.c
index 0407841ae8..166e986aa6 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -159,6 +159,9 @@ static int receive_status(struct packet_reader *reader, struct ref *refs)
 	while (1) {
 		const char *refname;
 		char *msg;
+		char *extended_status = NULL;
+		int len;
+
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
 			break;
 		if (!starts_with(reader->line, "ok ") && !starts_with(reader->line, "ng ")) {
@@ -167,10 +170,13 @@ static int receive_status(struct packet_reader *reader, struct ref *refs)
 			break;
 		}
 
+		len = strlen(reader->line);
 		refname = reader->line + 3;
 		msg = strchr(refname, ' ');
 		if (msg)
 			*msg++ = '\0';
+		if (reader->pktlen > len)
+			extended_status = (char *)reader->line + len + 1;
 
 		/* first try searching at our hint, falling back to all refs */
 		if (hint)
@@ -194,7 +200,10 @@ static int receive_status(struct packet_reader *reader, struct ref *refs)
 			hint->status = REF_STATUS_REMOTE_REJECT;
 			ret = -1;
 		}
-		hint->remote_status = xstrdup_or_null(msg);
+		if (msg)
+			hint->remote_status = xstrdup(msg);
+		else if (extended_status)
+			hint->remote_status = xstrdup(extended_status);
 		/* start our next search from the next ref */
 		hint = hint->next;
 	}
diff --git a/t/t5411/common-test-cases.sh b/t/t5411/common-test-cases.sh
index e850292e50..397748dd6f 100644
--- a/t/t5411/common-test-cases.sh
+++ b/t/t5411/common-test-cases.sh
@@ -605,9 +605,9 @@ test_expect_success "proc-receive: report with extended status" '
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/next/topic
+	 * [new reference] HEAD -> refs/pull/123/head
 	 * [new reference] HEAD -> refs/for/a/b/c/topic
-	 * [new reference] HEAD -> refs/for/master/topic
+	 + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
@@ -645,7 +645,8 @@ test_expect_success "proc-receive: report multiple response" '
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/master/topic
+	 * [new reference] HEAD -> refs/changes/23/123/1
+	 <OID-A>..<OID-B> HEAD -> refs/changes/24/124/2
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
@@ -704,7 +705,7 @@ test_expect_success "proc-receive: report update of mixed refs" '
 	 * [new branch] HEAD -> baz
 	 * [new reference] HEAD -> refs/for/next/topic
 	 * [new branch] HEAD -> foo
-	 * [new reference] HEAD -> refs/for/master/topic
+	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
diff --git a/transport-helper.c b/transport-helper.c
index 20a7185ec4..cec3495d59 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -747,37 +747,39 @@ static int push_update_ref_status(struct strbuf *buf,
 			msg = xstrdup(msg);
 		strbuf_release(&msg_buf);
 
-		if (!strcmp(msg, "no match")) {
-			status = REF_STATUS_NONE;
-			FREE_AND_NULL(msg);
-		}
-		else if (!strcmp(msg, "up to date")) {
-			status = REF_STATUS_UPTODATE;
-			FREE_AND_NULL(msg);
-		}
-		else if (!strcmp(msg, "non-fast forward")) {
-			status = REF_STATUS_REJECT_NONFASTFORWARD;
-			FREE_AND_NULL(msg);
-		}
-		else if (!strcmp(msg, "already exists")) {
-			status = REF_STATUS_REJECT_ALREADY_EXISTS;
-			FREE_AND_NULL(msg);
-		}
-		else if (!strcmp(msg, "fetch first")) {
-			status = REF_STATUS_REJECT_FETCH_FIRST;
-			FREE_AND_NULL(msg);
-		}
-		else if (!strcmp(msg, "needs force")) {
-			status = REF_STATUS_REJECT_NEEDS_FORCE;
-			FREE_AND_NULL(msg);
-		}
-		else if (!strcmp(msg, "stale info")) {
-			status = REF_STATUS_REJECT_STALE;
-			FREE_AND_NULL(msg);
-		}
-		else if (!strcmp(msg, "forced update")) {
-			forced = 1;
-			FREE_AND_NULL(msg);
+		if (status != REF_STATUS_OK) {
+			if (!strcmp(msg, "no match")) {
+				status = REF_STATUS_NONE;
+				FREE_AND_NULL(msg);
+			}
+			else if (!strcmp(msg, "up to date")) {
+				status = REF_STATUS_UPTODATE;
+				FREE_AND_NULL(msg);
+			}
+			else if (!strcmp(msg, "non-fast forward")) {
+				status = REF_STATUS_REJECT_NONFASTFORWARD;
+				FREE_AND_NULL(msg);
+			}
+			else if (!strcmp(msg, "already exists")) {
+				status = REF_STATUS_REJECT_ALREADY_EXISTS;
+				FREE_AND_NULL(msg);
+			}
+			else if (!strcmp(msg, "fetch first")) {
+				status = REF_STATUS_REJECT_FETCH_FIRST;
+				FREE_AND_NULL(msg);
+			}
+			else if (!strcmp(msg, "needs force")) {
+				status = REF_STATUS_REJECT_NEEDS_FORCE;
+				FREE_AND_NULL(msg);
+			}
+			else if (!strcmp(msg, "stale info")) {
+				status = REF_STATUS_REJECT_STALE;
+				FREE_AND_NULL(msg);
+			}
+			else if (!strcmp(msg, "forced update")) {
+				forced = 1;
+				FREE_AND_NULL(msg);
+			}
 		}
 	}
 
diff --git a/transport.c b/transport.c
index 272c0f4046..dbff7c50e5 100644
--- a/transport.c
+++ b/transport.c
@@ -463,11 +463,23 @@ static void print_ref_status(char flag, const char *summary,
 			     struct ref *to, struct ref *from, const char *msg,
 			     int porcelain, int summary_width)
 {
+	char *to_name = NULL;
+	const char *val;
+	int len;
+
+	if (to && to->remote_status) {
+		val = parse_feature_value(to->remote_status, "ref", &len);
+		if (val && len)
+		to_name = xmemdupz(val, len);
+	}
+
 	if (porcelain) {
 		if (from)
-			fprintf(stdout, "%c\t%s:%s\t", flag, from->name, to->name);
+			fprintf(stdout, "%c\t%s:%s\t", flag, from->name,
+				to_name ? to_name : to->name);
 		else
-			fprintf(stdout, "%c\t:%s\t", flag, to->name);
+			fprintf(stdout, "%c\t:%s\t", flag,
+				to_name ? to_name : to->name);
 		if (msg)
 			fprintf(stdout, "%s (%s)\n", summary, msg);
 		else
@@ -481,9 +493,11 @@ static void print_ref_status(char flag, const char *summary,
 		fprintf(stderr, " %s%c %-*s%s ", red, flag, summary_width,
 			summary, reset);
 		if (from)
-			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
+			fprintf(stderr, "%s -> %s",
+				prettify_refname(from->name),
+				prettify_refname(to_name ? to_name : to->name));
 		else
-			fputs(prettify_refname(to->name), stderr);
+			fputs(prettify_refname(to_name ? to_name : to->name), stderr);
 		if (msg) {
 			fputs(" (", stderr);
 			fputs(msg, stderr);
@@ -491,6 +505,7 @@ static void print_ref_status(char flag, const char *summary,
 		}
 		fputc('\n', stderr);
 	}
+	free(to_name);
 }
 
 static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_width)
@@ -531,8 +546,8 @@ static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_widt
 	}
 }
 
-static int print_one_push_status(struct ref *ref, const char *dest, int count,
-				 int porcelain, int summary_width)
+static int _print_one_push_status(struct ref *ref, const char *dest, int count,
+				  int porcelain, int summary_width)
 {
 	if (!count) {
 		char *url = transport_anonymize_url(dest);
@@ -602,6 +617,55 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count,
 	return 1;
 }
 
+static int print_one_push_status(struct ref *ref, const char *dest, int count,
+				 int porcelain, int summary_width)
+{
+	char *head;
+	char *begin;
+	int n = 0;
+
+	if (!ref->remote_status)
+		return _print_one_push_status(ref, dest, count,
+					      porcelain, summary_width);
+
+	head = ref->remote_status;
+	begin = strstr(head, "ref=");
+	if (!begin)
+		begin = ref->remote_status;
+	for (;;) {
+		char *end;
+		struct object_id old_oid;
+		struct object_id new_oid;
+		int forced_update;
+
+		end = strstr(begin + 4, "ref=");
+		if (end)
+			*(end-1) = '\0';
+
+		oidcpy(&old_oid, &ref->old_oid);
+		oidcpy(&new_oid, &ref->new_oid);
+		forced_update = ref->forced_update;
+
+		ref->remote_status = begin;
+		update_ref_from_remote_status(ref);
+		_print_one_push_status(ref, dest, count + n++,
+				       porcelain, summary_width);
+
+		oidcpy(&ref->old_oid, &old_oid);
+		oidcpy(&ref->new_oid, &new_oid);
+		ref->forced_update = forced_update;
+
+		if (end) {
+			begin = end;
+			*(end-1) = ' ';
+		} else {
+			break;
+		}
+	}
+	ref->remote_status = head;
+	return n;
+}
+
 static int measure_abbrev(const struct object_id *oid, int sofar)
 {
 	char hex[GIT_MAX_HEXSZ + 1];
-- 
2.24.1.15.g448c31058d.agit.4.5

