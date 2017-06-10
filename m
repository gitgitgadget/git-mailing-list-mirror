Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 797681FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 13:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbdFJNks (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 09:40:48 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:32864 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbdFJNkp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 09:40:45 -0400
Received: by mail-qt0-f196.google.com with SMTP id w1so19546114qtg.0
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 06:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=In8PrAKBYpGSKE5dzKf7imA+mR4mixVcpVmfcR1hZRM=;
        b=F2YHMplrC2kIfu0Pmrm5ywsQIsmza/T1LS8D9R/E35U/NIj0ffJfEg8ziCWY9LPHPG
         jOD2HAbGEjjp9c5OFLWYy8KUsCBvK9qFAHIkM3lXT9L4zqgQyI3bsSNDeeqLOZJwZYKe
         ZQ+Nlev3An3Q1k9qeE2YCwiZiATGRN9wT0ZIbLvjY9la2U3kfGB543+I/9GlTQTEyNjL
         Z/PbNb7TeBDtExqszKGKyb/iT2Dfd58k6bCgmPlnTyy/5QUxFJJ54MEMQcStCnMfvjWb
         Khq2AF1nc8RD6WbaRjqR1E6dhgGJi6x+8HqtIuFtboTF/Z6WWdUUS2SLDXMGUGx0KjXR
         zhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=In8PrAKBYpGSKE5dzKf7imA+mR4mixVcpVmfcR1hZRM=;
        b=IfWAvAfc2lbJC3TqNIgCBnDNR1W2AXPxCIoNNHTRzbXprqXFz4A8m+CQentyB6aIJd
         B1Nax41jaeBJ+f2204cEPpnFTFmHoRqyCX7yGdbe2JVKRjKPu2UeE4y68W5RTB/Vf0P9
         Re9XFyfJxO5kSE3e4UAKq7fRiWyT5Nq2tulqsp97gMOWKBMWlU/02YV46p33YRJ60sY/
         UZ2L1VvLwtf15c3E+S4DDC8e5Bv339ZPJ6yQFMK2Tpvdj9hW+NkPZInrSxzrGBWuq5wB
         2lPxTJJKuXMz17iDazbYMVCSlmmtBJ1pXP0SEti+WMU1VSZegbxcQKwDbYrly3lQw/1X
         Yvgg==
X-Gm-Message-State: AODbwcCH/bNGuvA9RAMdtfBxDaDMlMI+NphKKl12pToWHXX3oapmD1pW
        kkUaocIVPTuaFX1jLdM=
X-Received: by 10.237.33.187 with SMTP id l56mr17992873qtc.165.1497102044510;
        Sat, 10 Jun 2017 06:40:44 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id f94sm2707503qtb.16.2017.06.10.06.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Jun 2017 06:40:44 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
Subject: [PATCH v5 1/7] bswap: add 64 bit endianness helper get_be64
Date:   Sat, 10 Jun 2017 09:40:20 -0400
Message-Id: <20170610134026.104552-2-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170610134026.104552-1-benpeart@microsoft.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new get_be64 macro to enable 64 bit endian conversions on memory
that may or may not be aligned.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 compat/bswap.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/compat/bswap.h b/compat/bswap.h
index d47c003544..f89fe7f4b5 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -158,6 +158,7 @@ static inline uint64_t git_bswap64(uint64_t x)
 
 #define get_be16(p)	ntohs(*(unsigned short *)(p))
 #define get_be32(p)	ntohl(*(unsigned int *)(p))
+#define get_be64(p)	ntohll(*(uint64_t *)(p))
 #define put_be32(p, v)	do { *(unsigned int *)(p) = htonl(v); } while (0)
 
 #else
@@ -170,6 +171,9 @@ static inline uint64_t git_bswap64(uint64_t x)
 	(*((unsigned char *)(p) + 1) << 16) | \
 	(*((unsigned char *)(p) + 2) <<  8) | \
 	(*((unsigned char *)(p) + 3) <<  0) )
+#define get_be64(p)	( \
+	((uint64_t)get_be32((unsigned char *)(p) + 0) << 32) | \
+	((uint64_t)get_be32((unsigned char *)(p) + 4) <<  0)
 #define put_be32(p, v)	do { \
 	unsigned int __v = (v); \
 	*((unsigned char *)(p) + 0) = __v >> 24; \
-- 
2.13.0

