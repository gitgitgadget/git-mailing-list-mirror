Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF57E1F404
	for <e@80x24.org>; Sun, 18 Mar 2018 14:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754405AbeCRO0E (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 10:26:04 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35895 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754369AbeCROZz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 10:25:55 -0400
Received: by mail-lf0-f67.google.com with SMTP id z143-v6so15462334lff.3
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dpoS2/Z38K/JjJpnjtwuB9OsXfB5A/vpsFz5eCU+O0o=;
        b=bTpvvlNJOyFVtKgb8LJvsFW/D3ukgoyeuxG63ZhYdvTm0ZoydajYyEPF+yv2Ekedzt
         5lQGmOmzaoBYYs3gJdU2vxNhHQNqe6aRzj7nxszcIKbr4pbGB264wrpOKTjM+EXZQ6TK
         pZzv8psf9c9wckMyCIwfqp3TH3JCPyKttx/CUG0oJJlSvO1Mg6uIyOndC90ZlGImKAGG
         78TDxN0OFqvYSilXcarDNwzBBSQMKH+uOgElbCBs6oaQK9UtJFLWJN5q0T/GPy8bffBC
         16Q1S9ryS8Rcnx+kxu3RIIMD9qAPHTAA30Ztj8lQRdX0egN6/rvwIHKfst4I2fyIr9Hj
         /keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dpoS2/Z38K/JjJpnjtwuB9OsXfB5A/vpsFz5eCU+O0o=;
        b=t1zfdY4UBX1sjDRDh7L8Ad97ZiLK75jmElxeYjwYWRsZn7El75I/arbLIBfA/o43aS
         GGpUhewXcIAnA64AulQXToCTPK8NveQ+2vPjP4aQh+VeXhjs+orzbHLMUUBkoGGZJj0A
         4JHNGHQq3Ytggbt7zPzlZgZxsXeQxJLBwTACtoYlq/NckONZJbg/pVsXRmoGkTnxLShi
         XV5+KNaj5GfzhpMNg6+i2jM9QgwF4/2VEODLE87QuxnX4xmrj4ypA7vlV6/88xme/k9Q
         HosgTuumCqOUn38yBawDbU8c5G02pScfvw7UUFW368MmfbJLMJ6AQQ03fWMDGaAxeRvF
         qEYA==
X-Gm-Message-State: AElRT7GQa6/vqP1tesSzuYBVvuFzer+nlvCTHR22IvucfyantsNqlhk0
        UeEtAhA8fB73Qzo+xf2Qoj0=
X-Google-Smtp-Source: AG47ELuyl9DkK/5eFJpOcu0l8t9X1BvOKoxcFlsLc1igNcMAABEI+Jg/GhrJbIpJSh+thc7prPD+6w==
X-Received: by 10.46.154.71 with SMTP id k7mr1285346ljj.42.1521383153278;
        Sun, 18 Mar 2018 07:25:53 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n24sm2551554ljg.22.2018.03.18.07.25.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Mar 2018 07:25:52 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v6 11/11] pack-objects: reorder members to shrink struct object_entry
Date:   Sun, 18 Mar 2018 15:25:26 +0100
Message-Id: <20180318142526.9378-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.347.gf9cf61673a
In-Reply-To: <20180318142526.9378-1-pclouds@gmail.com>
References: <20180317141033.21545-1-pclouds@gmail.com>
 <20180318142526.9378-1-pclouds@gmail.com>
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
 pack-objects.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/pack-objects.h b/pack-objects.h
index cbd5cf61ca..af40211105 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -71,35 +71,36 @@ enum dfs_state {
  */
 struct object_entry {
 	struct pack_idx_entry idx;
-	/* object uncompressed size _if_ size_valid is true */
-	uint32_t size_;
-	unsigned size_valid:1;
-	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
+	void *delta_data;	/* cached delta (uncompressed) */
 	off_t in_pack_offset;
+	uint32_t hash;			/* name hint hash */
+	uint32_t size_;	/* object uncompressed size _if_ size_valid is true */
 	uint32_t delta_idx;	/* delta base object */
 	uint32_t delta_child_idx; /* deltified objects who bases me */
 	uint32_t delta_sibling_idx; /* other deltified objects who
 				     * uses the same base as me
 				     */
-	void *delta_data;	/* cached delta (uncompressed) */
 	uint32_t delta_size_:OE_DELTA_SIZE_BITS; /* delta data size (uncompressed) */
 	uint32_t delta_size_valid:1;
+	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
+	unsigned size_valid:1;
 	unsigned z_delta_size:OE_Z_DELTA_BITS;
+	unsigned type_valid:1;
 	unsigned type_:TYPE_BITS;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
-	unsigned type_valid:1;
-	uint32_t hash;			/* name hint hash */
-	unsigned char in_pack_header_size;
 	unsigned preferred_base:1; /*
 				    * we do not pack this, but is available
 				    * to be used as the base object to delta
 				    * objects against.
 				    */
 	unsigned no_try_delta:1;
+	unsigned char in_pack_header_size;
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
 	unsigned dfs_state:OE_DFS_STATE_BITS;
 	unsigned depth:OE_DEPTH_BITS;
+
+	/* size: 80, bit_padding: 16 bits */
 };
 
 struct packing_data {
-- 
2.17.0.rc0.347.gf9cf61673a

