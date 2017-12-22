Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A56C11F406
	for <e@80x24.org>; Fri, 22 Dec 2017 17:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756564AbdLVRW4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 12:22:56 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:14166 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756529AbdLVRWx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 12:22:53 -0500
Received: from localhost.localdomain (unknown [IPv6:2a01:e34:ef19:d4a0:202d:ed17:5458:2741])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 1B6BF2003ED;
        Fri, 22 Dec 2017 18:22:51 +0100 (CET)
From:   Julien Dusser <julien.dusser@free.fr>
To:     git@vger.kernel.org
Cc:     Julien Dusser <julien.dusser@free.fr>
Subject: [PATCH] Fix urlencode format string on signed char.
Date:   Fri, 22 Dec 2017 18:24:37 +0100
Message-Id: <20171222172437.19505-1-julien.dusser@free.fr>
X-Mailer: git-send-email 2.15.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git credential fails with special char in password.
remote: Invalid username or password.
fatal: Authentication failed for

File ~/.git-credential contains badly urlencoded characters
%ffffffXX%ffffffYY instead of %XX%YY.

Add a cast to an unsigned char to fix urlencode use of %02x
on a char.

Signed-off-by: Julien Dusser <julien.dusser@free.fr>
---
 strbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 323c49ceb..4d5a9ce55 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -658,7 +658,7 @@ static void strbuf_add_urlencode(struct strbuf *sb, const char *s, size_t len,
 		    (!reserved && is_rfc3986_reserved(ch)))
 			strbuf_addch(sb, ch);
 		else
-			strbuf_addf(sb, "%%%02x", ch);
+			strbuf_addf(sb, "%%%02x", (unsigned char)ch);
 	}
 }
 
-- 
2.15.1

