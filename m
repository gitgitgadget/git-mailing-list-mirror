Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712971F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932800AbeDWXkx (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:40:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60654 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932786AbeDWXkp (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2C90560CF3;
        Mon, 23 Apr 2018 23:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526844;
        bh=FP/5LCiQWn+qMdkaST4TxHzeQHuxZnYk5I3u5qG/xhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=gJY9yZvRyzN4hxyB43YABnP4ke+obkTcRFAtCg6gM7BJxqgD05SEroOa8RTjzmSgo
         3pxucQZ7ArBBWrDG2ZEaygbOMY3lQOUpZERUc9gR5d4NDHm6rYdTznZvLWo9zAv5M1
         A88Gh8yXrm/QiJQVEz2VcyuhNdJ6a+/jFeM9Eyjl9mf7yIy8PsVHNzfeBo13n06sHE
         Dt0EktqYKtVFxSwhFF0RdssoSNvkvIsX7TITcinRO6x4oyVMTE+FwjrfJfkb/T73z0
         VmOH0kl6Z0ubQ209YMh+tz150xPeuo2ay+abWjbfUArvf5zUsfgBbj3kxSz3WLWop4
         HnfBBhbJ+VVlH7YZP4WWUIoVUohLhYHzHFYJJSGZDV/Yo6ofPwSOx5JuokYJgZmCOC
         PdB+8SctoQbV/qZdJP6tRXFHYs0tXkgtU0yIVdHdd68e/o6FkFNxaKV7cRuEpvG2gS
         3PFERgB+91kRJA2YZo/vnDL0BxKPLPfRwvYfBIYAqnsvDa6H5i6
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 36/41] sequencer: use the_hash_algo for empty tree object ID
Date:   Mon, 23 Apr 2018 23:39:46 +0000
Message-Id: <20180423233951.276447-37-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
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
index b879593486..12c1e1cdbb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1119,7 +1119,7 @@ static int try_to_commit(struct strbuf *msg, const char *author,
 
 	if (!(flags & ALLOW_EMPTY) && !oidcmp(current_head ?
 					      &current_head->tree->object.oid :
-					      &empty_tree_oid, &tree)) {
+					      the_hash_algo->empty_tree, &tree)) {
 		res = 1; /* run 'git commit' to display error message */
 		goto out;
 	}
