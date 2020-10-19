Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFEEC43457
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 502A5223BF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4ItQs94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbgJSTfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 15:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731280AbgJSTfs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 15:35:48 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CE7C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:35:47 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g12so987727wrp.10
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=51qnyM0oQPKf1T95ynoz0JMbhKqPGV0a/d3fTLw2UhA=;
        b=i4ItQs94jve7G1blO1liADjtgvZbJUTifwU1aDkQRHdYAtMfjstYD3XvflwqocY5MF
         7h31C83TCOzA3eg5a2YTkiynowqKcZFETXtVDeDIynFc5LBktzgmQtqGS0vWOTXGRq36
         bWBJNepO3gW4uV/UwM//H2NMjzpVM2mXQJwYjMLJrXrv4r1rOEGaiwqeLxJW/DKMUIMj
         BJCQxQLfBm33E9ZLRmmbZGqYN4yrNnGSteMX1JR+qUo5IC+5T33wxm75sCXPJKtd3lNB
         FjCav8JeU9yIi8ZJTVLB0pQ01Efb+6J3/c/KAugVGIXwgiv0AqTjKwQBqhyoKnhBnKS5
         6Y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=51qnyM0oQPKf1T95ynoz0JMbhKqPGV0a/d3fTLw2UhA=;
        b=q9bdzbyAYAerla6sxFKaPlqWCy6zQN8R0tmBaIaBJAx0bI0oXN0qmo19T3NmykerJ/
         EB1EDKx1x+ZpSCqEAhNBVl/4C8KUiHp5tmkLo1LFtSgbFK7WjHSBRY6LJhrreDdB33f0
         bzGn2lfxt41sieXNp43XzGuKcMXY0wJ5NAPHG4Zc7eAgwH6dGA8szgMjtxBRP7jBzVa/
         RhlovUrNRBaGyB3WZtU6s3nSD9L9OHZt3NnzgDn9g8ZHUTGwL5yXMxQ9Cuib7zpDZCB+
         vYfwu9d4hjB7j0tRPtLzEpb8csCVBAYldJWWthV5JIABd0PfhTifBOYgSaeIiuPGZGan
         q8gA==
X-Gm-Message-State: AOAM530pNYM3TQ1ZrFcgTFneX5kUDq3i//WU/iXZ3Y912rcWMfSPuwOC
        C0lboEYhcIHRgHzS7Sxt8HUbO2h5hAk=
X-Google-Smtp-Source: ABdhPJykYjpK4ou9paMBx/Tlr4ZeGJryzmoZg/unVdYtx8BQqUM348hIQTDXkZE3LZRVE/6Kxenx4Q==
X-Received: by 2002:a5d:494c:: with SMTP id r12mr849444wrs.406.1603136146312;
        Mon, 19 Oct 2020 12:35:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j7sm681160wmc.7.2020.10.19.12.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:35:45 -0700 (PDT)
Message-Id: <c61e560451c4d7f101a23acec69117ddac563330.1603136143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
References: <pull.753.git.1602600323973.gitgitgadget@gmail.com>
        <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 19:35:42 +0000
Subject: [PATCH v2 3/3] sideband: add defense against packets missing a band
 designator
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

While there is currently no instance of code producing this type of
packet, if the `demultiplex_sideband()` would receive a packet whose
payload is not only empty but even misses the band designator, it would
mistake it for a flush packet.

Let's defend against such a bug in the future.

Note: `demultiplex_sideband()` will treat empty flush, delim, eof and
response-end packets all alike: it will treat them as flush packets.
Since empty packets by definition are missing a band designator, this is
the best that function can do. Therefore, it would make little sense to
pass the `status` on to `demultiplex_sideband()`. Besides, fbd76cd450
(sideband: reverse its dependency on pkt-line, 2019-01-16) went out of
its way to _stop_ the code inside `demultiplex_sideband()` from relying
on anything in `pkt-line.h`; that includes the data type `enum
packet_read_status` that we would need if we were to pass `status` as a
parameter to that function.

Based on a suggestion by Jeff King.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 pkt-line.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 657a702927..f72048f623 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -461,8 +461,10 @@ int recv_sideband(const char *me, int in_stream, int out)
 	enum sideband_type sideband_type;
 
 	while (1) {
-		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX,
-				  0);
+		int status = packet_read_with_status(in_stream, NULL, NULL, buf,
+						     LARGE_PACKET_MAX, &len, 0);
+		if (!len && status == PACKET_READ_NORMAL)
+			BUG("missing band designator");
 		if (!demultiplex_sideband(me, buf, len, 0, &scratch,
 					  &sideband_type))
 			continue;
@@ -520,6 +522,8 @@ enum packet_read_status packet_reader_read(struct packet_reader *reader)
 							 reader->options);
 		if (!reader->use_sideband)
 			break;
+		if (!reader->pktlen && reader->status == PACKET_READ_NORMAL)
+			BUG("missing band designator");
 		if (demultiplex_sideband(reader->me, reader->buffer,
 					 reader->pktlen, 1, &scratch,
 					 &sideband_type))
-- 
gitgitgadget
