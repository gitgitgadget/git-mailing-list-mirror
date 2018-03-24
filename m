Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DB0B1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 06:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeCXGe0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 02:34:26 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45075 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbeCXGeY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 02:34:24 -0400
Received: by mail-lf0-f67.google.com with SMTP id l4-v6so16932619lfg.12
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 23:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h+nbhaElqASrJpwU1GqlBr71Y0dBSWJTEugKOZMIaDE=;
        b=urcjE2G9UtkLhyCVrQ3qiQ3QaZHBIioNsYo4jtEmIlH1POLxLS+uqx/ZZKoPs+cEQX
         gHJ027oqAGSNPNjd3u1aylSpygeGDevvQvacsZvn9KXPOrbOVov/pwry8sA5b9j6Yzwb
         XyrH484Ngm0FsZIEkcvKUEWUKXiNFIujoANzrdV3qia7+prptZgOORC4lTs8uQI1zhAN
         9PU4EABZIMFjxjrjw0lSsVnBVYnsFd0VNwmUzveC+h8/E0f3w31pThjzf1mFFu/qgOVI
         qotDmNr1CG2cpr60pC0mDkGMdsntlzIsqPOgx9TwKAzh7XebqQvux9aGP0rSeODajqxn
         WIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+nbhaElqASrJpwU1GqlBr71Y0dBSWJTEugKOZMIaDE=;
        b=YJSYUsGo7/SVqnD188boCvkW5+12BfSGPnnxLL+Brg2feAQv0DC6eOQr4WdLMupTVI
         Xtx5XIBozeOEjC+0QA5VuPY7GbH8WE3LbSAP3G9dI6cTrYgrq2NT6spZb+q+IKBmi1yG
         GMpcQzLFFrBvMwMiC1uj5x9gh7RI+D0AVkKkjkdEzgwWIO4DJ0lg8fluC2WP3uCJ+++T
         +QLb+DVqhNMWdIkNsyX6SXLy8nq6Hzw9NXjMNJyYZQ6JKavADXLy9WhJS5yddz2y1ibM
         n9x9ZgRvBC2ESRe8xCcYTWz9+26AFIc79QE7mqGgQG4PXuSqM1Upca6aHHKTTz9u7vqv
         Xoqg==
X-Gm-Message-State: AElRT7HXb2xKCeil4KjLJxDj+leNUMZpd3RqkFTZFLPM4CVL+0rOLA8e
        BvKdVIe9AhKz1SzUegG7RwI=
X-Google-Smtp-Source: AIpwx4/zoDXrx/x5J7kRbu0LOrxYNNAz/k9WFefc8DCLCU5HqNer0agNwljBhHO3+NQa3zLNEWEpsA==
X-Received: by 2002:a19:5750:: with SMTP id l77-v6mr7204055lfb.10.1521873262532;
        Fri, 23 Mar 2018 23:34:22 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h8sm2251703lja.41.2018.03.23.23.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 23:34:21 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v7 13/13] pack-objects: reorder members to shrink struct object_entry
Date:   Sat, 24 Mar 2018 07:33:53 +0100
Message-Id: <20180324063353.24722-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324063353.24722-1-pclouds@gmail.com>
References: <20180318142526.9378-1-pclouds@gmail.com>
 <20180324063353.24722-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previous patches leave lots of holes and padding in this struct. This
patch reorders the members and shrinks the struct down to 80 bytes
(from 136 bytes, before any field shrinking is done) with 16 bits to
spare (and a couple more in in_pack_header_size when we really run out
of bits).

This is the last in a series of memory reduction patches (see
"pack-objects: a bit of document about struct object_entry" for the
first one).

Overall they've reduced repack memory size on linux-2.6.git from
3.747G to 3.424G, or by around 320M, a decrease of 8.5%. The runtime
of repack has stayed the same throughout this series. Ævar's testing
on a big monorepo he has access to (bigger than linux-2.6.git) has
shown a 7.9% reduction, so the overall expected improvement should be
somewhere around 8%.

See 87po42cwql.fsf@evledraar.gmail.com on-list
(https://public-inbox.org/git/87po42cwql.fsf@evledraar.gmail.com/) for
more detailed numbers and a test script used to produce the numbers
cited above.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 pack-objects.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/pack-objects.h b/pack-objects.h
index 6d0345a82c..9f19672602 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -74,34 +74,36 @@ enum dfs_state {
  */
 struct object_entry {
 	struct pack_idx_entry idx;
-	uint32_t size_:OE_SIZE_BITS;
-	uint32_t size_valid:1;
-	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
+	void *delta_data;	/* cached delta (uncompressed) */
 	off_t in_pack_offset;
+	uint32_t hash;			/* name hint hash */
+	uint32_t size_:OE_SIZE_BITS;
+	unsigned size_valid:1;
 	uint32_t delta_idx;	/* delta base object */
 	uint32_t delta_child_idx; /* deltified objects who bases me */
 	uint32_t delta_sibling_idx; /* other deltified objects who
 				     * uses the same base as me
 				     */
-	void *delta_data;	/* cached delta (uncompressed) */
 	uint32_t delta_size_:OE_DELTA_SIZE_BITS; /* delta data size (uncompressed) */
 	uint32_t delta_size_valid:1;
+	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
 	unsigned z_delta_size:OE_Z_DELTA_BITS;
+	unsigned type_valid:1;
 	unsigned type_:TYPE_BITS;
+	unsigned no_try_delta:1;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
-	unsigned type_valid:1;
-	uint32_t hash;			/* name hint hash */
-	unsigned char in_pack_header_size;
 	unsigned preferred_base:1; /*
 				    * we do not pack this, but is available
 				    * to be used as the base object to delta
 				    * objects against.
 				    */
-	unsigned no_try_delta:1;
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
 	unsigned dfs_state:OE_DFS_STATE_BITS;
+	unsigned char in_pack_header_size;
 	unsigned depth:OE_DEPTH_BITS;
+
+	/* size: 80, bit_padding: 20 bits, holes: 1 bit */
 };
 
 struct packing_data {
-- 
2.17.0.rc0.348.gd5a49e0b6f

