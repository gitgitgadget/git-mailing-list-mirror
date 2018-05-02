Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA5C221847
	for <e@80x24.org>; Wed,  2 May 2018 00:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753441AbeEBA2T (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:28:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37608 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753346AbeEBA0Z (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:25 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1EF076046C;
        Wed,  2 May 2018 00:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220783;
        bh=A3Ki3LUsxKzx2CWdul/nZhACndoDcmwT3bcxSHC+w7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=B5oiXxQIpfTLGrRhSwIRF/BzpYEPtuYLzUbiJKP4aGQkvEdmIuWGAb23Ekag6pgYv
         UfKpWnCPQ0RYzF/nz/90C6TMr69hmQj/PZTVmDkY4ca67rhRkQwgVLduXbFmaZ0Dc8
         pfmGuY24cCM+T9cVeeLKXZMMSzixxdjAAjaDvRmzK0PJNfCFKif92BTdu8jggFhpWQ
         sAjNPHAAkcMhqyWlw4xppzbc5D0DqAcsq4slT33YbsAd4/AUK1Nm8sFTRMMZBqttsT
         m+QpbkXjwN/e9+9cdLsue1fJ5Oh0syuJTAgsXYBXcNIAkYh4bNC5oie+LnZXmffZbX
         f+pjAun1tnSqMjLOx63Ua3ZCN8HCJnXZXToFP9F7Qt7x0iin3ZNxq7kquP0RRVb2od
         LsghBQsp9oaZmivaoyafzTPxT9wr3idb86/bTrinD8FGs2xC1tRIHiomQnZlLluxbT
         XINicjieKeS1tfNMtzuc5tLGBEDWQ1GTU4FS/ll/427ywuJJ3GM
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 04/42] packfile: remove unused member from struct pack_entry
Date:   Wed,  2 May 2018 00:25:32 +0000
Message-Id: <20180502002610.915892-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sha1 member in struct pack_entry is unused except for one instance
in which we store a value in it.  Since nobody ever reads this value,
don't bother to compute it and remove the member from struct pack_entry.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h    | 1 -
 packfile.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/cache.h b/cache.h
index be9fab43ec..37d3f0104b 100644
--- a/cache.h
+++ b/cache.h
@@ -1572,7 +1572,6 @@ struct pack_window {
 
 struct pack_entry {
 	off_t offset;
-	unsigned char sha1[20];
 	struct packed_git *p;
 };
 
diff --git a/packfile.c b/packfile.c
index 0bc67d0e00..5c219d0229 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1833,7 +1833,6 @@ static int fill_pack_entry(const unsigned char *sha1,
 		return 0;
 	e->offset = offset;
 	e->p = p;
-	hashcpy(e->sha1, sha1);
 	return 1;
 }
 
