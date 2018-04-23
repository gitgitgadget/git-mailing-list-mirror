Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27B2F1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932696AbeDWXlG (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:41:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60740 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932745AbeDWXkq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:46 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1B88160D54;
        Mon, 23 Apr 2018 23:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526845;
        bh=0suzklJG0d1MNG2nlWN/45tMrCsFv4BO4ihcXECL36Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=atjjEHtqlopnFabnnolnjX4GooQwRt9BXB1SOVvR8TXzLEZKtBm4qDMM3Tc7EMByd
         eLIhpYGCaQE/LQPAVuu9L3ZnOE5uZhFgkikUE47A99dyJJrq7RZdjMtumDfiGmNCoa
         hCjkCoAHFuwd7qYzADTsdgTqU7TCOBEGKPU8OhCINDgLqs2Q2kjLv1WMfKh5l7aHCB
         N9yPGmNWAfDT86huwvugMqULV+OCjs1AE8MnPo1UqezDxz7371AxtGASNw4DBW2/Ur
         L/fPGcg6SLdkN3AgxL1zZVeF65CudJiPVQ9OZiC4UTfoO5jRxMLKtdGijRfW/ZDzm1
         yOy0RKzv/w/cp9G2Kt4aMYhT6W4KMwRuSjTjy2M3z8r8JrF5D1QmJQAqv6MqNrnTI0
         MRnNWOqBTKUq6BpDQzHpBOiyUsOUvKR/1D0nFJWPxe8ZNCAz7CwVFyEeMLz6eOhw8D
         +G3nxcfDP6EY2XiLpl5Yo07Fm5qVRYTrNW9V7l0VvfgSKHZraZ0
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 37/41] dir: use the_hash_algo for empty blob object ID
Date:   Mon, 23 Apr 2018 23:39:47 +0000
Message-Id: <20180423233951.276447-38-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To ensure that we are hash algorithm agnostic, use the_hash_algo to look
up the object ID for the empty blob instead of using the empty_tree_oid
variable.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 06f4c4a8bf..e879c34c2e 100644
--- a/dir.c
+++ b/dir.c
@@ -828,7 +828,7 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 		if (size == 0) {
 			if (oid_stat) {
 				fill_stat_data(&oid_stat->stat, &st);
-				oidcpy(&oid_stat->oid, &empty_blob_oid);
+				oidcpy(&oid_stat->oid, the_hash_algo->empty_blob);
 				oid_stat->valid = 1;
 			}
 			close(fd);
