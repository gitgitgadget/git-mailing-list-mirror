Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B6DD1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932793AbeDWXks (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:40:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60654 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932766AbeDWXkg (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1315460B4E;
        Mon, 23 Apr 2018 23:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526835;
        bh=DZhruOF5rbSf2cqXyaMYj/k+UKraeUEAFhQTrRrek6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=jVyspDKi44sGq/7JbC+l1K2E2TCSs7Hz92UsyEo8lChYsF6EVu340xDqtKI5hROuR
         8s47R4chafjBEiIYEN2ZP8VFANts74l9ZzqtAJbHF3t0RrlAq/zGm45d058QI1rIhc
         ETImw0VV5nHdSsHlQr1QUXnTs6SNydCVTNh1zeGofVYQZ9ZY0XAZSXaTp7iT+8GQo4
         IpVfj2T7k06kpRh06CcS3iHQMiSC9LD1NbCJF+Zm7eZZmCQCg2hkU/qNDDJ5UTABfQ
         Mepz2O0NGMVeINalBz9qmAFtbvXRXRbeVF2+aLdrSJXdyaMtMbCI/9jtfsbP79qxbS
         uIyO9UAxSGEuW9ezh81MK9cGVjxltjQDvu8iO2Es6RDkwEER6JcPlBznfjqfYReQoj
         yYs80/b08u84ZrVjPULYWxlgbA3GzMoxAIO7RcdlVUI3ML5npGnWjFxPBI3q9Wn+Ch
         RiVGC1zieLkX7j4V3HBGUJnzy8kn73g/zyS5rKMWx5t1nO2DkxA
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 28/41] merge: convert empty tree constant to the_hash_algo
Date:   Mon, 23 Apr 2018 23:39:38 +0000
Message-Id: <20180423233951.276447-29-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To avoid dependency on a particular hash algorithm, convert a use of
EMPTY_TREE_SHA1_HEX to use the_hash_algo->empty_tree instead.  Since
both branches now use oid_to_hex, condense the if statement into a
ternary.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 merge.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/merge.c b/merge.c
index f06a4773d4..5186cb6156 100644
--- a/merge.c
+++ b/merge.c
@@ -11,10 +11,7 @@
 
 static const char *merge_argument(struct commit *commit)
 {
-	if (commit)
-		return oid_to_hex(&commit->object.oid);
-	else
-		return EMPTY_TREE_SHA1_HEX;
+	return oid_to_hex(commit ? &commit->object.oid : the_hash_algo->empty_tree);
 }
 
 int index_has_changes(struct strbuf *sb)
