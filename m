Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F206C2D0EF
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 14:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3492D2073E
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 14:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHfPffjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgC2Odl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 10:33:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35236 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbgC2Odk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 10:33:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id k5so5178889pga.2
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 07:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3gwk+kLxVNHxPdM1d7cRbu38j4rfduA9UuqxdYyyf5g=;
        b=SHfPffjvj1/lO2zXHBv0VXcGzppMCOR0/9KI6cgxZfXUdAnQPA310lzIC5F58ThUjL
         M1LXmere5howoksPBHVrOTVcTlemqa7m8bLHwVs4qOoc7k0aGvpJ3zuPgtZ0OObJsOSQ
         fMzgwd1tu167Qh1x8JoVfXkw5eGzDm5GacaH/SHGPf+mUv3Nq19puanhoVW4WaMPzW3z
         rdICRj3QUQIGjEEWF6/2Tgm79MadD3NBchmECXSGsclYg5LbiOQXfwWmYppt2be06p4H
         76JqKpnbZrjEdseBrrbD9wzxerAd0nOgXGrVLoKUmALOMTNXmfmR3wbzBxl0HuOajp5r
         UvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3gwk+kLxVNHxPdM1d7cRbu38j4rfduA9UuqxdYyyf5g=;
        b=eqfJrpR9LXCGGDJ/GuEH5gncFFKM00KkHzqn+aTEU4MIwv+XSokJUrAnEx2IwCBINv
         XYw4Y+pPXdze/vKGMWqHbKDft9JtM6hvNpc630BetCTed6wJt9UU7tKPxlUEwkJ3EG0N
         gVXCPcdXlp3KBHty96v1xszo2Ikaves1Q9Wnn4waADAQUVCkkWZ3yoWGuWLUocZtWEMR
         MzOTg+0axpTzghOI7to5I0VEekEe55kBhvTq28KiN4kPG7ncCOQb4NIqPhs/b0pnp7xq
         nLQz5XETZqkCjLCrEMfhYm3QGE8RGNtr3mp5fjLEm7+Xpvy34BnfAOcBIYZcvhWI1bqm
         6cEg==
X-Gm-Message-State: ANhLgQ2OUaTBIl5O+QjoJnJniWxwoPEUHjeetSvFV8rVPF6zAsapFiAT
        H9W8byiKOPoRWwBnh4M80DA=
X-Google-Smtp-Source: ADFU+vsaI6HVWsAnRGBgC2N/kAJGvIMccpBWRnRce2f0aLjO/k99aCqnzRbp+BEMZBhXm7mHVHkd0w==
X-Received: by 2002:a62:ee10:: with SMTP id e16mr8609180pfi.247.1585492418985;
        Sun, 29 Mar 2020 07:33:38 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id u13sm2947246pgp.49.2020.03.29.07.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2020 07:33:38 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 4/4] transport-helper: new method reject_atomic_push()
Date:   Sun, 29 Mar 2020 10:33:29 -0400
Message-Id: <20200329143329.13846-5-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200325143608.45141-1-zhiyou.jx@alibaba-inc.com>
References: <20200325143608.45141-1-zhiyou.jx@alibaba-inc.com>
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
index ff016c468c..a2b8eaad0d 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -322,31 +322,6 @@ static int generate_push_cert(struct strbuf *req_buf,
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
@@ -491,7 +466,9 @@ int send_pack(struct send_pack_args *args,
 			if (use_atomic) {
 				strbuf_release(&req_buf);
 				strbuf_release(&cap_buf);
-				return atomic_push_failure(args, remote_refs, ref);
+				reject_atomic_push(remote_refs, args->send_mirror);
+				return error("atomic push failed for ref %s. status: %d\n",
+					     ref->name, ref->status);
 			}
 			/* else fallthrough */
 		default:
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
2.26.0.4.g39bcdcb101.dirty

