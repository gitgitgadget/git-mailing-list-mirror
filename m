Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADFFC2BB85
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 16:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6695320857
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 16:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ej5j9R3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410796AbgDPQYd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2410770AbgDPQY3 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 12:24:29 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2784AC061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 09:24:29 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b72so1867122pfb.11
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 09:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F7X1+/hgYdrwheZ2RW40orwF77yMEqdOCDz+jw7Mq2w=;
        b=ej5j9R3FQr3tCWRBZ3Q7qERoMDfahIJXSQigkAZA4F6/mvKQZ42o5HfOtwSoglPhXp
         DJbgy7Qzr1GgYBgWG0tLJtvjJmcgATiX1RkNVzbax6E61cvIDYk66c5ZomqJTr7WZB1g
         R0Ga3pbaIwlG878VMBKYzct0v0bPrTEHx4lP9BQzqfUulElswV0LFcXrM8bA5qP6D5de
         RsPzBjdi+H3wcaF7BayXtBkclO9nNuXXl8hU/bT9wJKzrcnP1bsH9IF8O3AGWAQR7//s
         KvT8zA9I951nXJj3OGOTo1tMHYPsnuFawa1wKd9yxMHhc2ay5gI9c7w7rGMjzynlEQYF
         2IZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F7X1+/hgYdrwheZ2RW40orwF77yMEqdOCDz+jw7Mq2w=;
        b=ryCoqceC6mnbqZ6pvyqRmd2KQXnZ/UKGpxBbtLyOgF/2IzSeYblbyewl1dteWj4EbT
         TEjYh9Ljfa7J85idLi64QGW9bXaOtE32LPSvibxNFEwoNZntWu1vQs2F4jzWa5nNTajX
         3NsUpijWoGilN3AehN1OwnmU+8bsMeUzfOIp5ZJRtSGUQg5CBQ4yIAhMvgqFn6F8U/tX
         3R2f2rgqlBvqpPfEf81nrSzKdGij/ZXzJBO4X0FDq1wu7vu9NC/jrtB1JIQ8cZDdaLqn
         Al2StTMhRC5WjMqqhW16K6s5JXVNb/9w0sQfAm9JZ1yrSrTlu/TxmmkrVfJQrj+sBGg4
         VYdA==
X-Gm-Message-State: AGi0PubMpXixvqVHMwOZtv+JrHYDDXRu4sBwhH3AT2ggJeD4mO7FnqUI
        SJWb2CHQyMPKWheKn9BDenrsLcH8mu0=
X-Google-Smtp-Source: APiQypIcOPuzgcYN371svoO/WGQkFSriCqWzzyorL1+xfDI+xwdu0dQL2gu+3L/0S7XEsoMoC/QfpQ==
X-Received: by 2002:a63:1820:: with SMTP id y32mr21376140pgl.182.1587054267041;
        Thu, 16 Apr 2020 09:24:27 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id c125sm17007933pfa.142.2020.04.16.09.24.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 09:24:26 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 5/5] transport-helper: new method reject_atomic_push()
Date:   Thu, 16 Apr 2020 12:24:15 -0400
Message-Id: <20200416162415.5751-6-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200329143329.13846-1-worldhello.net@gmail.com>
References: <20200329143329.13846-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Add new method in transport-helper to reject all references if any
reference is failed for atomic push.

This method is reused in "send-pack.c" and "transport-helper.c", one for
SSH, git and file protocols, and the other for HTTP protocol.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 send-pack.c        | 29 +++--------------------------
 transport-helper.c | 38 +++++++++++++++++++++++---------------
 transport.h        |  3 +++
 3 files changed, 29 insertions(+), 41 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index efefb687b2..a7c53193c9 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -320,31 +320,6 @@ static int generate_push_cert(struct strbuf *req_buf,
 	return update_seen;
 }
 
-
-static int atomic_push_failure(struct send_pack_args *args,
-			       struct ref *remote_refs,
-			       struct ref *failing_ref)
-{
-	struct ref *ref;
-	/* Mark other refs as failed */
-	for (ref = remote_refs; ref; ref = ref->next) {
-		if (!ref->peer_ref && !args->send_mirror)
-			continue;
-
-		switch (ref->status) {
-		case REF_STATUS_NONE:
-		case REF_STATUS_OK:
-		case REF_STATUS_EXPECTING_REPORT:
-			ref->status = REF_STATUS_ATOMIC_PUSH_FAILED;
-			continue;
-		default:
-			break; /* do nothing */
-		}
-	}
-	return error("atomic push failed for ref %s. status: %d\n",
-		     failing_ref->name, failing_ref->status);
-}
-
 #define NONCE_LEN_LIMIT 256
 
 static void reject_invalid_nonce(const char *nonce, int len)
@@ -489,7 +464,9 @@ int send_pack(struct send_pack_args *args,
 			if (use_atomic) {
 				strbuf_release(&req_buf);
 				strbuf_release(&cap_buf);
-				atomic_push_failure(args, remote_refs, ref);
+				reject_atomic_push(remote_refs, args->send_mirror);
+				error("atomic push failed for ref %s. status: %d\n",
+				      ref->name, ref->status);
 				return args->porcelain ? 0 : -1;
 			}
 			/* else fallthrough */
diff --git a/transport-helper.c b/transport-helper.c
index ab3b52eb14..a46afcb69d 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -894,21 +894,7 @@ static int push_refs_with_push(struct transport *transport,
 		case REF_STATUS_REJECT_STALE:
 		case REF_STATUS_REJECT_ALREADY_EXISTS:
 			if (atomic) {
-				/* Mark other refs as failed */
-				for (ref = remote_refs; ref; ref = ref->next) {
-					if (!ref->peer_ref && !mirror)
-						continue;
-
-					switch (ref->status) {
-					case REF_STATUS_NONE:
-					case REF_STATUS_OK:
-					case REF_STATUS_EXPECTING_REPORT:
-						ref->status = REF_STATUS_ATOMIC_PUSH_FAILED;
-						continue;
-					default:
-						break; /* do nothing */
-					}
-				}
+				reject_atomic_push(remote_refs, mirror);
 				string_list_clear(&cas_options, 0);
 				return 0;
 			} else
@@ -1503,3 +1489,25 @@ int bidirectional_transfer_loop(int input, int output)
 
 	return tloop_spawnwait_tasks(&state);
 }
+
+void reject_atomic_push(struct ref *remote_refs, int mirror_mode)
+{
+	struct ref *ref;
+
+	/* Mark other refs as failed */
+	for (ref = remote_refs; ref; ref = ref->next) {
+		if (!ref->peer_ref && !mirror_mode)
+			continue;
+
+		switch (ref->status) {
+		case REF_STATUS_NONE:
+		case REF_STATUS_OK:
+		case REF_STATUS_EXPECTING_REPORT:
+			ref->status = REF_STATUS_ATOMIC_PUSH_FAILED;
+			continue;
+		default:
+			break; /* do nothing */
+		}
+	}
+	return;
+}
diff --git a/transport.h b/transport.h
index e0131daab9..4298c855be 100644
--- a/transport.h
+++ b/transport.h
@@ -265,4 +265,7 @@ int transport_refs_pushed(struct ref *ref);
 void transport_print_push_status(const char *dest, struct ref *refs,
 		  int verbose, int porcelain, unsigned int *reject_reasons);
 
+/* common method used by transport-helper.c and send-pack.c */
+void reject_atomic_push(struct ref *refs, int mirror_mode);
+
 #endif
-- 
2.24.1.15.g448c31058d.agit.4.5

