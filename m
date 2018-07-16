Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60EEA1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 01:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeGPBxQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jul 2018 21:53:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58938 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727265AbeGPBxQ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Jul 2018 21:53:16 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:78f3:848c:e199:5398])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 24BCC60779;
        Mon, 16 Jul 2018 01:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531704499;
        bh=+xykSABiTsB/yGB6lP+eDwfiX1/awpZNsIUwB4X1jng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ha9GASlbD3ohhFaJTJqdub+rrSOz64rppvuoFOrMYmY86EhpmFrqs7k19Q/GT/rk5
         uYb44Wmmq/Z44IXJVBqUZb0CIceUNcbq2W8ONTCgEQt6tq7iZTpbDxiNs5HVGrul6i
         RwX6XDX95pxbwQIEjG/E9Pvam9EqrqNqljZccmclNWiebHxm1UdyGGa5Dnjvs9GJKE
         3plXdfvRwxX/bhIeirB97cuPPv5NR/b5MGjQzQaFkKLADI3BNM1lODzf7lrKWU8Tpt
         aH+8+orwaHn+TkAoRaHRS2RppZIqhEE+wZf0EWMzj/fKEAb2uNL/jJDoomd9nZiTQ+
         /i0Ax8YdTijPOfZQ1qRQ5ijXN3/99+ur7ZyvWf3X8AW/gGusSE+BFuQEFFMVIv7Md4
         bvoq48WOHOzdmbWZwjfLLjGZQduwugyQJ8hBs86W9UxeFRC5EqAB9Na0hD9IzwnsKb
         iuK3X2cwudOE9zuphsqo9ko4maQq0RRYzW4gDIE3pA2jzaI/mvs
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 02/16] tree-walk: replace hard-coded constants with the_hash_algo
Date:   Mon, 16 Jul 2018 01:27:54 +0000
Message-Id: <20180716012808.961328-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180716012808.961328-1-sandals@crustytoothpaste.net>
References: <20180716012808.961328-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the hard-coded 20-based values and replace them with uses of
the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 tree-walk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tree-walk.c b/tree-walk.c
index 8f5090862b..c1f27086a9 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -26,8 +26,9 @@ static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned l
 {
 	const char *path;
 	unsigned int mode, len;
+	const unsigned hashsz = the_hash_algo->rawsz;
 
-	if (size < 23 || buf[size - 21]) {
+	if (size < hashsz + 3 || buf[size - (hashsz + 1)]) {
 		strbuf_addstr(err, _("too-short tree object"));
 		return -1;
 	}
