Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A090EC433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80FD220780
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="se5GqFXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733133AbgFWRzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732973AbgFWRzt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 13:55:49 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6341FC061755
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:55:49 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e12so5187593qtr.9
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8JbklcbvWcdiJ1x9Npd1bM0uwrCcvK+2aGR5z5h8pE8=;
        b=se5GqFXUJqLB6CWbVZoPMu1q+OnmhdADVpelwBReZF1DAUalHwlb2TkS2xcPiXG68m
         O7HpMu/wlEdwRJHKgkYMHKY57LKH+pwBVZD/Y2R68Y8eMmWwSOWHqVP9TxPuEP67QnV2
         QBSfUdnWWv2m1Wst6uqRFTdvdWD08xuO/HwrEoL+Hgc5WbIadCuv82exNSEL2mz90vxa
         ql1wnHqicOVciDK3JddQMCw1VCFcZEWq590rxMLVEsDidCGHW+6QH8lOzb6yWDyvZ+Mk
         vCQrIsXziqdE5OEXHq5k/DWiG4oBrqhnOdnAKq1OeYwjlCjzaeLmGSma0rGegbiG1nlB
         9xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8JbklcbvWcdiJ1x9Npd1bM0uwrCcvK+2aGR5z5h8pE8=;
        b=Btid8YmBR7BCSgRsAof1XSHLF+sWtR9wtbtsgigWGK4oH1pyPC5xDklepilwHEgAAo
         ByRXuS8zQWU+OXx1dxYiOuxkZwg2TYQOZ4C0aYLYQQWp9yW9Pt58kWvyMgaVXCPx487b
         4VrXoypoHJ3+bj8pgh5hZzsVKlHvj/rU5PdusfiwiOvsja42pd9bWex6aIL4bl8IXmQ3
         mlFOvIvujEgVitILHqCwuEuTXnsR7VTxnZp34T1ABEJ/vz3hkOeSMcG8m7llvO5bXBpZ
         UgOHhx+Lmu2wELme/34NmDUPlmZpt9vnTes2kwhxrWQq/yFIJ+sAOg3NJRxHXEpKycSM
         IXUg==
X-Gm-Message-State: AOAM532/IkfZHv3mJRYV49skOAPnfe6tlm6BWVgl1NA9CIiYLqOGz2J2
        uUHn0DEm2sY3lHTBjPRB9jz6PkWiF3w=
X-Google-Smtp-Source: ABdhPJx8loQNNPoiPoBQhjEdInvAnycVkyDJeeylHWzMqAkVTHWh2SjcdUUxpcdm3BT1PhEDYcQxxg==
X-Received: by 2002:ac8:33f8:: with SMTP id d53mr21688828qtb.80.1592934948494;
        Tue, 23 Jun 2020 10:55:48 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id l2sm1380920qtc.80.2020.06.23.10.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 10:55:47 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/3] remote-curl: use strlen() instead of magic numbers
Date:   Tue, 23 Jun 2020 13:55:32 -0400
Message-Id: <cb8683837c9f583274780057621255a65a1c4c9f.1592934880.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.307.g7979e895e7
In-Reply-To: <cover.1592934880.git.liu.denton@gmail.com>
References: <cover.1592119902.git.liu.denton@gmail.com> <cover.1592934880.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we are dealing with a packet-line length header, we use the magic
literal `4`, representing the length of "0000" and "0001", the packet
line length headers. Use `strlen("000x")` so that we do not have to use
the magic literal.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 remote-curl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 75532a8bae..a2cbef546b 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -596,10 +596,10 @@ static int rpc_read_from_out(struct rpc_state *rpc, int options,
 			set_packet_header(buf - 4, *appended);
 			break;
 		case PACKET_READ_DELIM:
-			memcpy(buf - 4, "0001", 4);
+			memcpy(buf - strlen("0001"), "0001", strlen("0001"));
 			break;
 		case PACKET_READ_FLUSH:
-			memcpy(buf - 4, "0000", 4);
+			memcpy(buf - strlen("0000"), "0000", strlen("0000"));
 			break;
 		case PACKET_READ_RESPONSE_END:
 			die(_("remote server sent stateless separator"));
@@ -804,7 +804,7 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, "0000");
-	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, 4);
+	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, strlen("0000"));
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buf);
-- 
2.27.0.307.g7979e895e7

