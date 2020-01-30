Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190CBC2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 20:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17FD214AF
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 20:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="Kd+ad25t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgA3Udn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:33:43 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45430 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3Udm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 15:33:42 -0500
Received: by mail-qk1-f196.google.com with SMTP id x1so4283001qkl.12
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 12:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PFlu6Kd5xZf8c1KxpG0FtgGfpr0yJL7fsgah1JBxGpM=;
        b=Kd+ad25tbZwmSx0IEYKssfra6/JYdmrsZxDqis1eYmURkjsmxd2w3S/nH+cVsKMTFn
         NlFssENrFDBuUl0py3BkHX4K0TnYEj06bZLLutvutO324A6IN6h2W4fGdfe9tDRlf8Gu
         3PK5ATYMCzy//7ehN97kOHuJkfZUyynX9rjzUAMSvzlL29ux0gOtfM/PIx2C0bITxrJN
         po8DkeC/vLKB9bTSjr7WvAE6QERF/cBSIu4IBbSQksZS90aeOYMghbFnf4bvMgZ4AOab
         3+BYhMQmrDrt4AUC4tOq7RM8djbAfGex89Yahjzx0DNfSK5Wfbkr8wR3XTbLLWvLHwvP
         mXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PFlu6Kd5xZf8c1KxpG0FtgGfpr0yJL7fsgah1JBxGpM=;
        b=C6Q79x16MwdhTIskhRTcxCzP6TBN1Y7KpQd1Jae73gwJqDuocnFWUyqL3WxfQlvPDq
         x9yM8pCL4m/1UwHH3AbV1dxyB+3TelyX5etgdaNzA5N1hV8hnwpEgH266wA/x5fkYFiR
         gpT/hkUKdN86nE76JAhOZbAMhCDKCs95tTrcmX7dlBnYwBD7ssZzFRJSZX0YUqLCYK9j
         LhCduJ8BNbk7EjuxksRvr/j5LHYHn5PPSA0hb+NlxsOk5UlgIL0wNDTFedYk44mNNAUy
         C30O5jxPTLWVxK06yC0p1fYRA7Qnecifhmx9k5oMXLmlTDFLs8JpYlMdKCBJHNaxJFL/
         Yvlw==
X-Gm-Message-State: APjAAAWS1V3CumLHeCvEO9NzLW18yxfPNnItESbGUT7H+71TSpHeQ1wk
        /z7CDWFuIlH7K0ja5uho+Qk9RTcEiGo=
X-Google-Smtp-Source: APXvYqzhfXCezRCYw+vKRuFvWCPBXOJ303+r+++Z8oukvpoY3ltfaRfZq9aDNtqHPFoEv5oE6g6ZkQ==
X-Received: by 2002:ae9:f714:: with SMTP id s20mr7186379qkg.236.1580416421540;
        Thu, 30 Jan 2020 12:33:41 -0800 (PST)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o12sm3436514qke.79.2020.01.30.12.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:33:40 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: [PATCH 3/7] pack-check: use given repo's hash_algo at verify_packfile()
Date:   Thu, 30 Jan 2020 17:32:19 -0300
Message-Id: <b06ad765589e0384abc5d860fa89781f18ef8dac.1580413221.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580413221.git.matheus.bernardino@usp.br>
References: <cover.1580413221.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At verify_packfile(), use the git_hash_algo from the provided repository
instead of the_hash_algo, for consistency. Like the previous patch, this
shouldn't bring any behavior changes, since this function is currently
only receiving the_repository.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 pack-check.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/pack-check.c b/pack-check.c
index 2cc3603189..0fb3b365c7 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -67,23 +67,23 @@ static int verify_packfile(struct repository *r,
 	if (!is_pack_valid(p))
 		return error("packfile %s cannot be accessed", p->pack_name);
 
-	the_hash_algo->init_fn(&ctx);
+	r->hash_algo->init_fn(&ctx);
 	do {
 		unsigned long remaining;
 		unsigned char *in = use_pack(p, w_curs, offset, &remaining);
 		offset += remaining;
 		if (!pack_sig_ofs)
-			pack_sig_ofs = p->pack_size - the_hash_algo->rawsz;
+			pack_sig_ofs = p->pack_size - r->hash_algo->rawsz;
 		if (offset > pack_sig_ofs)
 			remaining -= (unsigned int)(offset - pack_sig_ofs);
-		the_hash_algo->update_fn(&ctx, in, remaining);
+		r->hash_algo->update_fn(&ctx, in, remaining);
 	} while (offset < pack_sig_ofs);
-	the_hash_algo->final_fn(hash, &ctx);
+	r->hash_algo->final_fn(hash, &ctx);
 	pack_sig = use_pack(p, w_curs, pack_sig_ofs, NULL);
 	if (!hasheq(hash, pack_sig))
 		err = error("%s pack checksum mismatch",
 			    p->pack_name);
-	if (!hasheq(index_base + index_size - the_hash_algo->hexsz, pack_sig))
+	if (!hasheq(index_base + index_size - r->hash_algo->hexsz, pack_sig))
 		err = error("%s pack checksum does not match its index",
 			    p->pack_name);
 	unuse_pack(w_curs);
-- 
2.25.0

