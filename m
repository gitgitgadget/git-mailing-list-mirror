Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5A4C352BE
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 16:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4438B2063A
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 16:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtObFgk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731805AbgDMQsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731777AbgDMQsj (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Apr 2020 12:48:39 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF434C008749
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 09:48:38 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id e16so3757046pjp.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bHBqCfBVWklnW7g/Pe9qVtdQDkxWyDDmVXPRncu3M78=;
        b=MtObFgk89cbR7Xcono/qiKtZkBzk0DzjnB0Kq++LuPeYiZ/+h40swjw63XSnItj7Py
         DMQMVYBuIwdv4piFwA3AqGNLhs+M4GwaUAxITB1FQLNEeoSf6ay5t75Fh2BRd2Zn5azx
         1/uR9M72Q1jfWKQS/V5iq2O1gLcD5hS68ax5sC8zsp9l8A/9IXqD/T7O/ZGQqIz13VWI
         O75EifAxbJtS4QfIXIIe3PVSp4dhJGM+GUmVNCsFyqvutvER3k2P4tIUJuWnr6s5Mv94
         XsHK7liKMUk6NkTmdMZ7yps9pg8Zq+2S+vK98C1treMH2WI0f+AXqW+pIkim91cf6954
         VKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bHBqCfBVWklnW7g/Pe9qVtdQDkxWyDDmVXPRncu3M78=;
        b=tYvEu/5dlA+qsijhJqBslK5NpvgLrYkE8x3fXNLuiv1D/jUIa4Dml0UaVEazOmpZCL
         JZhd+pecAA6YeIeecCbVIiLsdIf59Skn+k44p+rulHC69U0u93ZCTSpeBebAHrWPZn4c
         fDV5smfLxXa6Xkd+somuaeMawY043Wmr1fWadv334amb9aAYhMK9JH4uqcYjixJXMbvy
         h8TZYZ62aTBsxRIX//cXXTqAdByZzX0yVPiwr1BGDC4/CtBlouO3Eb35J21+WceNBvyP
         d7aXZJH4KafDPv3mPk2nQqf1sTi8GPZSOC0ww+r1w8YP5n+aibXQlEuBp9s/LfZjYSb5
         fBYw==
X-Gm-Message-State: AGi0PuaFyv/iNigdv++yXbFRsvGsa7U66I6s6aJceVGRY7spHcsjEqOy
        k4CNUH17w63L5Vi3abLhjvA=
X-Google-Smtp-Source: APiQypJiUCumg01LwFiHmgHnqZpVIedhGgKl8V8PICFErZ2XgIEnC8VCpc+ePglkl/RRrivni+/Pgg==
X-Received: by 2002:a17:902:b40e:: with SMTP id x14mr18931545plr.154.1586796518427;
        Mon, 13 Apr 2020 09:48:38 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id e11sm9254885pfh.117.2020.04.13.09.48.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2020 09:48:38 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v11 4/7] send-pack: extension for client-side status report
Date:   Mon, 13 Apr 2020 12:48:24 -0400
Message-Id: <20200413164828.23260-5-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200412133022.17590-1-worldhello.net@gmail.com>
References: <20200412133022.17590-1-worldhello.net@gmail.com>
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
 t/t5411/common-test-cases.sh |  6 ++--
 transport-helper.c           | 66 +++++++++++++++++++-----------------
 transport.c                  | 33 +++++++++++++++---
 6 files changed, 110 insertions(+), 39 deletions(-)

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
index fe970df755..7fa7211ce4 100644
--- a/t/t5411/common-test-cases.sh
+++ b/t/t5411/common-test-cases.sh
@@ -640,9 +640,9 @@ test_expect_success "proc-receive: report with extended status" '
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/next/topic
+	 * [new reference] HEAD -> refs/pull/123/head
 	 * [new reference] HEAD -> refs/for/a/b/c/topic
-	 * [new reference] HEAD -> refs/for/master/topic
+	 + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
@@ -701,7 +701,7 @@ test_expect_success "proc-receive: report update of mixed refs" '
 	 * [new branch] HEAD -> baz
 	 * [new reference] HEAD -> refs/for/next/topic
 	 * [new branch] HEAD -> foo
-	 * [new reference] HEAD -> refs/for/master/topic
+	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
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

