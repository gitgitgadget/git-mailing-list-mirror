Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD1251F97E
	for <e@80x24.org>; Mon, 15 Oct 2018 00:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbeJOHpD (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 03:45:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50566 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726444AbeJOHpC (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Oct 2018 03:45:02 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0749561B7F;
        Mon, 15 Oct 2018 00:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539561738;
        bh=I16As3imq2gajq0YlE45BPYL1vCMaclWwrwqYmg61Ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=tNwbssxh7wBG8I3gm7dDvNw9ohIQIFueW/NldG+pTEyBU522/RBoDJitvafXmnYq4
         a/M8zJIn32/7UHm4TjlWwMB2lfUZf7zGRcfcn/uy2S79OQI8lWckmM/FgAwUv3Qbaz
         ZZFGALJK/byP7CnC86YN2cl4wsx7MA6QKFg+MY/FWd88g1GsonM7xULWk0bEXH3Vhb
         PZZNiGNeLJ89dEPALeJDbk8H1edkuJUf0AzTZP6fhciOcvmj60c9TjV7SO4ONGFxKi
         4FQiIXxRt5ja3JXF8sxlo4zUExtP4dySlSx+dxZkQPXNibr8fwbJVrpZ2riUuGOr6T
         W/TEMKBQtbP6ZaRgFWFKwBQVWiHRCv2zeR7Xchp72vtWZ3GONKSVwSoe7sEenvjleE
         kCO+u5TgLZoL6arrP0JkunOYHN/uA4ZlR/cgy1rb7TRtWmozvgG4TOv1+JPhLaXxLb
         4fiLSLC1XUmA5Y4EiF7I2V1JC0rc9o3aPTQbJOm3sPUQ4diI1ij
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 06/15] pack-revindex: express constants in terms of the_hash_algo
Date:   Mon, 15 Oct 2018 00:01:53 +0000
Message-Id: <20181015000202.951965-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
In-Reply-To: <20181015000202.951965-1-sandals@crustytoothpaste.net>
References: <20181015000202.951965-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Express the various constants used in terms of the_hash_algo.
While we're at it, fix a comment style issue as well.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 pack-revindex.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index bb521cf7fb..3c58784a5f 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -122,13 +122,14 @@ static void create_pack_revindex(struct packed_git *p)
 	unsigned num_ent = p->num_objects;
 	unsigned i;
 	const char *index = p->index_data;
+	const unsigned hashsz = the_hash_algo->rawsz;
 
 	ALLOC_ARRAY(p->revindex, num_ent + 1);
 	index += 4 * 256;
 
 	if (p->index_version > 1) {
 		const uint32_t *off_32 =
-			(uint32_t *)(index + 8 + p->num_objects * (20 + 4));
+			(uint32_t *)(index + 8 + p->num_objects * (hashsz + 4));
 		const uint32_t *off_64 = off_32 + p->num_objects;
 		for (i = 0; i < num_ent; i++) {
 			uint32_t off = ntohl(*off_32++);
@@ -142,16 +143,17 @@ static void create_pack_revindex(struct packed_git *p)
 		}
 	} else {
 		for (i = 0; i < num_ent; i++) {
-			uint32_t hl = *((uint32_t *)(index + 24 * i));
+			uint32_t hl = *((uint32_t *)(index + (hashsz + 4) * i));
 			p->revindex[i].offset = ntohl(hl);
 			p->revindex[i].nr = i;
 		}
 	}
 
-	/* This knows the pack format -- the 20-byte trailer
+	/*
+	 * This knows the pack format -- the hash trailer
 	 * follows immediately after the last object data.
 	 */
-	p->revindex[num_ent].offset = p->pack_size - 20;
+	p->revindex[num_ent].offset = p->pack_size - hashsz;
 	p->revindex[num_ent].nr = -1;
 	sort_revindex(p->revindex, num_ent, p->pack_size);
 }
