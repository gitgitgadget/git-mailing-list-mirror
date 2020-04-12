Return-Path: <SRS0=e9fP=54=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAABFC2BB86
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 13:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECC620732
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 13:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSKWSmP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgDLNag (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 09:30:36 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:40784 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgDLNaf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 09:30:35 -0400
Received: by mail-pf1-f173.google.com with SMTP id x3so3120058pfp.7
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 06:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LKw0zdJT/FarvCrK31agXTQF4eOaqsVi8yUDxnPRWwc=;
        b=MSKWSmP1rqtn5pE0w/4W2phpDbA9BFknHyCv/u0nU5+GrzdRYG6YIrW3MbKpqhI1El
         KiuJhoIPUxSVBjEynfICN10EZdUs7Lt/Ba7R88KTbzzM6G0CDkh92PsTWbbcoSxM1Jsz
         5Ql60XaYqcT4s79bb6U3/2K3K9aYlUXwfylmBHDyb4NvDcDazkeh/asyZjM1cyFzh0Zf
         5rxibnA2J2XwKP39dlXJAsbeZFjhiZVRCYwFZohyM5b3BZqwEO+aM9T4UvSV0o+BPKbw
         rw92I6Ww0dAjeu24N1R5ZeWwvqAKQzf9OA7gBPFqtZJD1SEN1mc5l+lYoQApgaglL8aZ
         Ryog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LKw0zdJT/FarvCrK31agXTQF4eOaqsVi8yUDxnPRWwc=;
        b=BbBC3c3Vo5EGka1CYRWuMG3TAph15faE/AL63ynnQ4hCyYmSalk9Kk5qr6M7D8EPhk
         mY+rFuFpYHwjkiYgQEhmmxw1um+mENefJNH9sstMb1qb4tQxeQa+usXzQYVOFnMe549B
         9GBUAFkf//5HqdX7zYN/F11sYPUdDhseL2M3ZOWIlqV7h1+yZwGbSbyUBz+uEEbY5SxW
         3gN51xS3NkqxprSTJnDG/0xLDZ3ZL7lqL/RFjGIDuZUUzpd7PDJoSNEIPxWK9+gknabO
         eEaEg08oF2c2AFm7LN5c0z9r8gOHHKAMeL/t8XHNPFS6TzuB8ebe6NtG1EF3wkijrTqK
         53kg==
X-Gm-Message-State: AGi0PuaaP19JIcx9Hfz3ypJmEmr6DzTguK1akfLembmgzGRFcBpWfDNC
        6AHcC+6FBqpY2ENtaPNzXxUdTKGJ
X-Google-Smtp-Source: APiQypKB2GhxruEPB1dwkxAEZiy5EON6zMaXbGwZbvXI7Tuy9wjisfVrC5dXvgenPqCb5dP++OTSgg==
X-Received: by 2002:a62:d086:: with SMTP id p128mr629848pfg.241.1586698234206;
        Sun, 12 Apr 2020 06:30:34 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 139sm6093363pfv.0.2020.04.12.06.30.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2020 06:30:33 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v10 7/8] send-pack: extension for client-side status report
Date:   Sun, 12 Apr 2020 09:30:21 -0400
Message-Id: <20200412133022.17590-8-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200407120813.25025-1-worldhello.net@gmail.com>
References: <20200407120813.25025-1-worldhello.net@gmail.com>
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
 remote.c                     | 28 +++++++++++++++
 remote.h                     |  3 ++
 send-pack.c                  | 13 ++++++-
 t/t5411/common-test-cases.sh | 10 +++---
 transport-helper.c           | 66 +++++++++++++++++++-----------------
 transport.c                  | 33 +++++++++++++++---
 6 files changed, 112 insertions(+), 41 deletions(-)

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
index 0407841ae8..ab294c9426 100644
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
@@ -194,7 +200,12 @@ static int receive_status(struct packet_reader *reader, struct ref *refs)
 			hint->status = REF_STATUS_REMOTE_REJECT;
 			ret = -1;
 		}
-		hint->remote_status = xstrdup_or_null(msg);
+		if (msg) {
+			hint->remote_status = xstrdup(msg);
+		} else if (extended_status) {
+			hint->remote_status = xstrdup(extended_status);
+			update_ref_from_remote_status(hint);
+		}
 		/* start our next search from the next ref */
 		hint = hint->next;
 	}
diff --git a/t/t5411/common-test-cases.sh b/t/t5411/common-test-cases.sh
index 35fe73c34e..413e6502be 100644
--- a/t/t5411/common-test-cases.sh
+++ b/t/t5411/common-test-cases.sh
@@ -673,9 +673,9 @@ test_expect_success "report update of all special refs" '
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/a/b/c/topic
 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/next/topic
+	 * [new reference] HEAD -> refs/pull/123/head
 	 * [new reference] HEAD -> refs/review/a/b/c/topic
-	 * [new reference] HEAD -> refs/for/master/topic
+	 + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
@@ -738,7 +738,7 @@ test_expect_success "report mixed refs update" '
 	 * [new branch] HEAD -> baz
 	 * [new reference] HEAD -> refs/for/next/topic
 	 * [new branch] HEAD -> foo
-	 * [new reference] HEAD -> refs/for/master/topic
+	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
@@ -812,8 +812,8 @@ test_expect_success "report test: fallthrough" '
 	 <OID-A>..<OID-B> <COMMIT-B> -> bar
 	 - [deleted] foo
 	 + <OID-B>...<OID-A> HEAD -> master (forced update)
-	 * [new reference] HEAD -> refs/for/master/topic
-	 * [new reference] HEAD -> refs/for/next/topic
+	 <OID-A>..<OID-B> HEAD -> refs/pull/123/head
+	 + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
diff --git a/transport-helper.c b/transport-helper.c
index 20a7185ec4..d2179631cf 100644
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
 
@@ -802,6 +804,8 @@ static int push_update_ref_status(struct strbuf *buf,
 	(*ref)->status = status;
 	(*ref)->forced_update |= forced;
 	(*ref)->remote_status = msg;
+	if (status == REF_STATUS_OK && (*ref)->remote_status)
+		update_ref_from_remote_status(*ref);
 	return !(status == REF_STATUS_OK);
 }
 
diff --git a/transport.c b/transport.c
index 272c0f4046..b0451c7a3c 100644
--- a/transport.c
+++ b/transport.c
@@ -463,11 +463,30 @@ static void print_ref_status(char flag, const char *summary,
 			     struct ref *to, struct ref *from, const char *msg,
 			     int porcelain, int summary_width)
 {
+	char *from_name = NULL;
+	char *to_name = NULL;
+	const char *val;
+	int len;
+
+	if (from && from->remote_status) {
+		val = parse_feature_value(from->remote_status, "ref", &len);
+		if (val && len)
+			 from_name = xmemdupz(val, len);
+	}
+	if (to && to->remote_status) {
+		val = parse_feature_value(to->remote_status, "ref", &len);
+		if (val && len)
+			 to_name = xmemdupz(val, len);
+	}
+
 	if (porcelain) {
 		if (from)
-			fprintf(stdout, "%c\t%s:%s\t", flag, from->name, to->name);
+			fprintf(stdout, "%c\t%s:%s\t", flag,
+				from_name ? from_name : from->name,
+				to_name ? to_name: to->name);
 		else
-			fprintf(stdout, "%c\t:%s\t", flag, to->name);
+			fprintf(stdout, "%c\t:%s\t", flag,
+				to_name ? to_name: to->name);
 		if (msg)
 			fprintf(stdout, "%s (%s)\n", summary, msg);
 		else
@@ -481,9 +500,11 @@ static void print_ref_status(char flag, const char *summary,
 		fprintf(stderr, " %s%c %-*s%s ", red, flag, summary_width,
 			summary, reset);
 		if (from)
-			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
+			fprintf(stderr, "%s -> %s",
+				prettify_refname(from_name ? from_name : from->name),
+				prettify_refname(to_name ? to_name : to->name));
 		else
-			fputs(prettify_refname(to->name), stderr);
+			fputs(prettify_refname(to_name ? to_name : to->name), stderr);
 		if (msg) {
 			fputs(" (", stderr);
 			fputs(msg, stderr);
@@ -491,6 +512,10 @@ static void print_ref_status(char flag, const char *summary,
 		}
 		fputc('\n', stderr);
 	}
+	if (from_name)
+		free(from_name);
+	if (to_name)
+		free(to_name);
 }
 
 static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_width)
-- 
2.24.1.15.g448c31058d.agit.4.5

