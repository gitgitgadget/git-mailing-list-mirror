Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3B1D207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046133AbdDWVfv (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:35:51 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37322 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933022AbdDWVfb (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:35:31 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E8E26280B5;
        Sun, 23 Apr 2017 21:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983330;
        bh=2NSpD/LyhkhM4CA1zbv1XExfrT+1NOxf8jIFQ2ob+cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VuuM8Dx7izPJkX16TgTttk6s/wObILawG2msA2AvnWXviOxAgOyd105Pw1whLdjYg
         oVHXlvtuM0g7Cy4nauEFt0LymK2h0yJmEb21R7EssbNQLLWJJsKZZQVe35/dmUW8gj
         FkKXhQn136QqAXWjbjQUoF1b/AYSsuqfqryHrc3AqelQcyNjMCn4vufwBzJIkWAIee
         PwjxMf6lebkA/J5qfDTTrASXCyVYJbA156hfQmKCp6e9ZILpp3FY6m7YbRJn5JaWvH
         OqLlEFLY8g3b/JQt48QkJtMCGo80MYHcunVD7iV7a4b/vr7qp1iCOlM8fQ08LxVaK7
         czMV5AN21Tt/i9yVSD9PqL+IF399IOUWEYoZtE0tX9KLFHkT0n6MHLG/n1uDzsYoVt
         Oan0OMtxQDvRppNKWy7H/FyZ9ZhnZQlo3GQDnSLEOz/GQfwyOSDAy4oZkPBOfjw0+V
         pceemYyJfC3CYpgKW7cBVuZv+A+FabeQukQrix5KHQKgPKHo0/P
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/53] builtin/blame: convert static function to struct object_id
Date:   Sun, 23 Apr 2017 21:34:08 +0000
Message-Id: <20170423213453.253425-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function is a caller of lookup_commit_reference_gently, which we
will convert later.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/blame.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 07506a3e4..7d644d092 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2461,7 +2461,7 @@ static const char *dwim_reverse_initial(struct scoreboard *sb)
 	 */
 	struct object *obj;
 	struct commit *head_commit;
-	unsigned char head_sha1[20];
+	struct object_id head_oid;
 
 	if (sb->revs->pending.nr != 1)
 		return NULL;
@@ -2473,9 +2473,9 @@ static const char *dwim_reverse_initial(struct scoreboard *sb)
 		return NULL;
 
 	/* Do we have HEAD? */
-	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_sha1, NULL))
+	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_oid.hash, NULL))
 		return NULL;
-	head_commit = lookup_commit_reference_gently(head_sha1, 1);
+	head_commit = lookup_commit_reference_gently(head_oid.hash, 1);
 	if (!head_commit)
 		return NULL;
 
