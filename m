Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BB6C83001
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 00:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E15208FE
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 00:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SW8W5VCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgD1ABR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 20:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726251AbgD1ABQ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 20:01:16 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77369C03C1A8
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 17:01:16 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id g23so22541427qto.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 17:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7dlEWniC5YOAGNYfTrSAXaBcS+CRwesoGXRuEnRBLvU=;
        b=SW8W5VCNuV79KDxwloPmfT1vWgaviQWzTWyco8dY5/Q+1s2r1DLEZSOjH8Iu28L0lR
         ++aL5NiwUr9h7wMg3vczYeAz4d9X/rNurUjneiUpGyrTesClB+JUkpq5UobMjMaFfhUZ
         fBg2ukBRzFveDYPEd8GKNhVgwW7acEdC90sFMs0mVhXgOr39L49BQO1qvccaQblsSmxM
         MD1pmAV/hG4wHXavPmoyvB6ljr+5sxCxOfRucDuoa3HoyBhkzq+V1O9LSztsOAfb5GLj
         Vy5Y/lmprBmQpuNQLHI0H6i1vF/zJ1m/snNQO7LKHS4Qx8OWJgjlUZaSru7wOCKdIF+J
         Me4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7dlEWniC5YOAGNYfTrSAXaBcS+CRwesoGXRuEnRBLvU=;
        b=kzrVEH0+LzT39XWkPPjWlDKyiDfXBIfMmR4Fz+ewE/4+OwqtVpPsabpAP5SH61s4ns
         32a0b+qwiPgGehDhl34PjU9boNhDmon0ip+/oaLco7V5xqwu72stqOBAOnsltIHH8zUp
         RoVWi77XqcQLcnCYsUrXMHJJM669ZRD8/SWVgLdbmoMB15n7p8XzJfVJZS4lRhI6fVtj
         41ID1rgLEabDCWbOQUb4QcFoy1xLiPEjWJhBmehNK/XVdrBFYpEyElY4Gw6/Zs63DPYg
         +jgSGwaoPSl+Wzw4ErP0avAMj2PBY+Hc+1YIykNImDEb3sRk9K902+Tr6lYv4mQlAOK8
         HMvw==
X-Gm-Message-State: AGi0PublRy1hlKpZfbL5WxlGo+4oKXaDusSyXMSZ9XU1JruTUoP0OEmd
        nz03RZYJBR4AQaud4SP4A7LNVYiSFVj154GxAUDLGndm6cqR6+PrJ8RcBXmug93+F7vidqae5qr
        xJULerOKD0iQhd1GM505hdxXIamAcCFrIDVVCSDHv+yO1cjv/e0v07TfFV4VwoKPnlj7GwIyeaB
        ew
X-Google-Smtp-Source: APiQypLZ4VoXkDd9Y+BrCDIOKKxFZxbPAhcgMFDI8lm2R2bMH1W9/lUMJ4EmxL/Cls7XOSYF3Enytg1rKUpVo17OFHc+
X-Received: by 2002:a0c:9e6d:: with SMTP id z45mr25254102qve.206.1588032075437;
 Mon, 27 Apr 2020 17:01:15 -0700 (PDT)
Date:   Mon, 27 Apr 2020 17:01:08 -0700
In-Reply-To: <cover.1588031728.git.jonathantanmy@google.com>
Message-Id: <f0cfbc03c27658e54a73c46570c5153961ed85b6.1588031728.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1587775989.git.jonathantanmy@google.com> <cover.1588031728.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v2 1/3] fetch-pack: return enum from process_acks()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

process_acks() returns 0, 1, or 2, depending on whether "ready" was
received and if not, whether at least one commit was found to be common.
Replace these magic numbers with a documented enum.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 0b07b3ee73..45547a621e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1268,9 +1268,29 @@ static int process_section_header(struct packet_reader *reader,
 	return ret;
 }
 
-static int process_acks(struct fetch_negotiator *negotiator,
-			struct packet_reader *reader,
-			struct oidset *common)
+enum common_found {
+	/*
+	 * No commit was found to be possessed by both the client and the
+	 * server, and "ready" was not received.
+	 */
+	NO_COMMON_FOUND,
+
+	/*
+	 * At least one commit was found to be possessed by both the client and
+	 * the server, and "ready" was not received.
+	 */
+	COMMON_FOUND,
+
+	/*
+	 * "ready" was received, indicating that the server is ready to send
+	 * the packfile without any further negotiation.
+	 */
+	READY
+};
+
+static enum common_found process_acks(struct fetch_negotiator *negotiator,
+				      struct packet_reader *reader,
+				      struct oidset *common)
 {
 	/* received */
 	int received_ready = 0;
@@ -1320,7 +1340,8 @@ static int process_acks(struct fetch_negotiator *negotiator,
 		die(_("expected no other sections to be sent after no 'ready'"));
 
 	/* return 0 if no common, 1 if there are common, or 2 if ready */
-	return received_ready ? 2 : (received_ack ? 1 : 0);
+	return received_ready ? READY :
+		(received_ack ? COMMON_FOUND : NO_COMMON_FOUND);
 }
 
 static void receive_shallow_info(struct fetch_pack_args *args,
@@ -1508,13 +1529,13 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		case FETCH_PROCESS_ACKS:
 			/* Process ACKs/NAKs */
 			switch (process_acks(negotiator, &reader, &common)) {
-			case 2:
+			case READY:
 				state = FETCH_GET_PACK;
 				break;
-			case 1:
+			case COMMON_FOUND:
 				in_vain = 0;
 				/* fallthrough */
-			default:
+			case NO_COMMON_FOUND:
 				state = FETCH_SEND_REQUEST;
 				break;
 			}
-- 
2.26.2.303.gf8c07b1a785-goog

