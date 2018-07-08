Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C8751F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 23:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933112AbeGHXg5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 19:36:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54320 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932821AbeGHXgy (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 19:36:54 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B89E36073F;
        Sun,  8 Jul 2018 23:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531093013;
        bh=4MC5CteoJK4k1/NCPq7kXOwTpZKIc1gIvrAAsjBodAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=VBl3Gsz4vpvttL4nwkr4lLpCz/9+zQXKrsNjnGU7ISIvjZWP7lHbG6ah24MEBREqT
         NkRq8Lh5d6KLyUWVR50AqaHnKMBSlh7+hGsYw2vE/hnadfMG5rk1GLll32SAcNVwcf
         Ke7MsHhKzlHXGoLDOM7/YbtI1GF8XtzoBBtXrr0J5VyA4SvuG4eEF2kKQn6YRywbxf
         ur+d+Y59Hw/jwBKbERpwXAR7BdZUl52QaDo2zINghFAhSY2+s+sUwOJRpXl0oCX4cF
         CD475X1612eS41rV+3vYGruX2cV/Ez9WMBzzDNq2srGePKOtlQARJGMIE2/xAzWttc
         qJ/VTdExJtYYwKAsWeaAmeNk8EyzlUDWc063tbZKDDCGhjaExdheIw/IO3PP0Hbk8U
         22mlz4H5QMjlvPLZuXyP4mHgijWk32DxGhFGLnPEDB0dqvGE1QwGbTGvayHI2TIwuM
         GGykENXKPNRvE3ZIxDpc9tXm6QiqSP1WokgECGW4Z9fm5NnKQcM
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 05/17] strbuf: allocate space with GIT_MAX_HEXSZ
Date:   Sun,  8 Jul 2018 23:36:26 +0000
Message-Id: <20180708233638.520172-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180708233638.520172-1-sandals@crustytoothpaste.net>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to be sure we have enough space to use with any hash algorithm,
use GIT_MAX_HEXSZ to allocate space.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 strbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index b0716ac585..030556111d 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -921,7 +921,7 @@ void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
 			      int abbrev_len)
 {
 	int r;
-	strbuf_grow(sb, GIT_SHA1_HEXSZ + 1);
+	strbuf_grow(sb, GIT_MAX_HEXSZ + 1);
 	r = find_unique_abbrev_r(sb->buf + sb->len, oid, abbrev_len);
 	strbuf_setlen(sb, sb->len + r);
 }
