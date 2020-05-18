Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ADFC433E1
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2EE42065F
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5QiX2nk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgERPrk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 11:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgERPri (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 11:47:38 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E283C05BD09
        for <git@vger.kernel.org>; Mon, 18 May 2020 08:47:38 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i68so8453911qtb.5
        for <git@vger.kernel.org>; Mon, 18 May 2020 08:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=94DHJmUmWPWRI+eSWR3V3Az6QdLbgc8wyDcHm3HccrI=;
        b=s5QiX2nkh4dELvorLmoLIFp5agX7BqwwQYjQ8WFl++yk8cKFC12VwI5oorJpFlSJ4/
         di63Q3nNpVzzhdyIbbum0PIdlkRxl/IXlagR5QD0ZA0eQ9GzicmuHpTneS+eSgIhKsJo
         tAcK3YZYiYGSM2C4HGkDvEDPpA9dXvCkkmJ5jkUydfLWex4PI1Et+v8C1s+0HdiwJsCP
         mJ3Gi4RCD4CuiX/lvS86X7stRPzysWFZZrvEvA7AFkIuKS6lWnUKergzEg+X5ElueuG8
         wpMFc6bSP4rLHdsZ4GVZZLLmd6Y31BkS2IOYps6fwtM4JBs3+IUjR+QCUUjbAHxXz4ZF
         Enmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=94DHJmUmWPWRI+eSWR3V3Az6QdLbgc8wyDcHm3HccrI=;
        b=uGPEYgegyjN0C2zXIkUZ6ojM4x13vPtIqk0QKpDRWtwYjzfHZXZCURx4vM6mhONWGY
         NFh04B7HaejwHCht2dGwByoGhNPxiRlSl6AmPKX0ZiyVDq9olNpsOIOrooCs2WxFmf74
         /I4OhmolO/rmoKyVIw5pkmJQLRk6ag3NFMQuzm7XajuqrA0weDd3jHhCOA9zkNlPSlao
         Xu2fCv2ZoIkAAQdTMHNgIU3GaQG0iO/D7EdSfZj2fPg4dDqxRexfhoOfL0uCSWregPGg
         rselEl5TXZUJ9OFAYYWE7NyMRC4ISgdXjiFtlI9ifJFDK0l+eRYYuhzd45y2R97Pr00k
         DY0g==
X-Gm-Message-State: AOAM531Y7Z9d2TRg7oiFUEumMK0qq7pvL+hWZwx+ljt6I8rKJ1AF6nj7
        jJnLrmknPoIEcRMF0SEOODzmjGx+
X-Google-Smtp-Source: ABdhPJy2Edgi1YaS7bumYTbsYVkWejUJxm94GlvAKyzZVBc2s3v0GOND9qIovH+dcJyYwToCnJDVLA==
X-Received: by 2002:ac8:4906:: with SMTP id e6mr17451166qtq.39.1589816857315;
        Mon, 18 May 2020 08:47:37 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id z201sm5146913qkb.2.2020.05.18.08.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 08:47:36 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/7] transport: extract common fetch_pack() call
Date:   Mon, 18 May 2020 11:47:20 -0400
Message-Id: <3a42575bd5d124b6b2e536b1511107ebf5ec1091.1589816719.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.706.g87896c9627
In-Reply-To: <cover.1589816718.git.liu.denton@gmail.com>
References: <cover.1589393036.git.liu.denton@gmail.com> <cover.1589816718.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the switch statement, the difference between the `protocol_v2` and
`protocol_v{1,0}` arms is a preparatory call to die_if_server_options() in
the latter. The fetch_pack() call is identical in both arms. However,
since this fetch_pack() call has so many parameters, it is not
immediately obvious that the call is identical in both cases.

Extract the common fetch_pack() call out of the switch statement so that
code duplication is reduced and the logic is more clear for future
readers.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 transport.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/transport.c b/transport.c
index 15f5ba4e8f..a6002e502f 100644
--- a/transport.c
+++ b/transport.c
@@ -371,22 +371,19 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	switch (data->version) {
 	case protocol_v2:
-		refs = fetch_pack(&args, data->fd,
-				  refs_tmp ? refs_tmp : transport->remote_refs,
-				  to_fetch, nr_heads, &data->shallow,
-				  &transport->pack_lockfile, data->version);
+		/* do nothing */
 		break;
 	case protocol_v1:
 	case protocol_v0:
 		die_if_server_options(transport);
-		refs = fetch_pack(&args, data->fd,
-				  refs_tmp ? refs_tmp : transport->remote_refs,
-				  to_fetch, nr_heads, &data->shallow,
-				  &transport->pack_lockfile, data->version);
 		break;
 	case protocol_unknown_version:
 		BUG("unknown protocol version");
 	}
+	refs = fetch_pack(&args, data->fd,
+			  refs_tmp ? refs_tmp : transport->remote_refs,
+			  to_fetch, nr_heads, &data->shallow,
+			  &transport->pack_lockfile, data->version);
 
 	close(data->fd[0]);
 	close(data->fd[1]);
-- 
2.26.2.706.g87896c9627

