Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 056491F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 21:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbeJIFLB (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 01:11:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49294 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbeJIFLA (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Oct 2018 01:11:00 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 83CCB60782;
        Mon,  8 Oct 2018 21:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539035831;
        bh=QTAeYojQOsmNZI0XOfqBrXs6MTsVfciEnFUO51RbfL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=gm2lFMIm2B1Ut8ODPAK+q4P3l1zTWqf0hg/H2WvXPJsqHcv5Bg4y6R0n62QBu5fBO
         bDpRyENis50pGCw0fxYTo7icYKjc4p2gPkOIy7VudFx4lyxz5Tqokd1dcR9o8End/Q
         svzzhqLhsKQeXks2VVMeiEhzUOgDqr/W6zyTpUfq2scM90Pw3U9ZF/spVZ5q4s+Lt3
         9/U+AEajQQsMsiF/5P7OQbMXlfTtYr7qdkEQac8v1m063+6jWFAIja2xjDDy4rbWlw
         O8EKOzT+yWq2pcBKB6ayoYU/kxJAgXxk2j0Zxi1U64pMgpZPLR8k7IwLD7ZCK8Ycxo
         j3LX8n4WWx+yzxJAmpyX1xZp9BbZaPAPeQJ1Sm931JefliRd3OKuCUwakuIFIKDFJA
         j0+gqBSx/f+GcXUASrxiX8NASyRa1mbLHEukfxV6kHosHbvlcxFiXvzP5O29vsyO5w
         2EkLSlyK9iXhMkxySxI6jDU+6DjEaxFYML7VcbXhmCTH6gw9rKy
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/14] builtin/mktree: remove hard-coded constant
Date:   Mon,  8 Oct 2018 21:56:50 +0000
Message-Id: <20181008215701.779099-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c
In-Reply-To: <20181008215701.779099-1-sandals@crustytoothpaste.net>
References: <20181008215701.779099-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using a hard-coded constant for the size of a hex object ID,
switch to use the computed pointer from parse_oid_hex that points after
the parsed object ID.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/mktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 2dc4ad6ba8..94e82b8504 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -98,7 +98,7 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
 
 	*ntr++ = 0; /* now at the beginning of SHA1 */
 
-	path = ntr + 41;  /* at the beginning of name */
+	path = (char *)p + 1;  /* at the beginning of name */
 	if (!nul_term_line && path[0] == '"') {
 		struct strbuf p_uq = STRBUF_INIT;
 		if (unquote_c_style(&p_uq, path, NULL))
