Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A87C221847
	for <e@80x24.org>; Wed,  2 May 2018 00:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753562AbeEBA1P (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:27:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37866 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753515AbeEBA1A (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:27:00 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A2BEE60CF1;
        Wed,  2 May 2018 00:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220820;
        bh=KvyVCixoT/RQDUDsccJrhzo4t5nKGZXmEDGQhb4xhek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=cQBSyqKjCjzqhSDfFEEXG/7jP/7N5RnXzTkixUvSVv37+SOTCE+dDpZR66ae2bjO1
         LMG9qltYlWXYc9W/O94EV8ngzdC0Q8CQeJo6s7/vh5mGc6BR1UNCME2TE+pdW7KLcw
         cfBUTlS1iXoU6Q3mNBVPf6vgACfqZCmY0C5c/fB1YZkK2zrb9SAQ5mERhw/SZctQmM
         heh54K2zdIUPp165OUfo6HoiqOcG6GOss8c9ozTJqUrYZfrRMv/Yu79MJC69JGb2sl
         xtIzuJLRzvS8YGwv5Y6aQzq/eKPoMUD/NfFwAArLm28qblHk/616QHlgNLKSCeLKq7
         C4Ar3avLYmZ9WY+ZcOhVXNDNtsOG87uhCHUI5P/Ez++Aqcuy5LM4hSe84qYa9bnt+B
         WBM6qwokxzT74rHuRkTNH64t4so642XVzRLN1r6QWyXVNldCTZYGbBz0L4WwcibxXp
         BD4SjaR33Kbyb9bxxrePjlCYWvRAcGseoOLSjAUrFvsxEd4erV0
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 37/42] sequencer: use the_hash_algo for empty tree object ID
Date:   Wed,  2 May 2018 00:26:05 +0000
Message-Id: <20180502002610.915892-38-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To ensure that we are hash algorithm agnostic, use the_hash_algo to look
up the object ID for the empty tree instead of using the empty_tree_oid
variable.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 75ed9676fe..a487411fde 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1120,7 +1120,7 @@ static int try_to_commit(struct strbuf *msg, const char *author,
 
 	if (!(flags & ALLOW_EMPTY) && !oidcmp(current_head ?
 					      &current_head->tree->object.oid :
-					      &empty_tree_oid, &tree)) {
+					      the_hash_algo->empty_tree, &tree)) {
 		res = 1; /* run 'git commit' to display error message */
 		goto out;
 	}
