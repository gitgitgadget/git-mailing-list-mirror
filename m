Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27E3D1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeBFAGJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:06:09 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45096 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbeBFAGF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:06:05 -0500
Received: by mail-pg0-f68.google.com with SMTP id m136so118002pga.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y5DXLCcHvBjdHt33VhE9tmBJjy8kvpLVV+pEKWRc2iM=;
        b=tO6WCIb6ma06M95Sd0trtY6Ss45+Dtoy4O7skzHNWYOyDGDnbfxeuUK6o8NEWk9Jgy
         +sMM4Y6UXzFLhU4dW3qpDWQubHmCMDPYPXfRO8FyzKtpid6I6W57pbphFhmeUdHEYcmG
         oSG3l593MyYaYOR33O3O+gBmM6WEKuJlAZ8Wg9/9nOgrtWCXoVXn1m3qQkgMcA7WqE3W
         j0ZqATCc7wzysEhVdtlEZ3gVKdxtBTd1A8h89fOLOg37HhUelIiG43lLFVqZ9IR1BZ9E
         moalkcOS5jZ3xy2CsyESREqkCOgHrF0wToxwW4VlJDpsTmZM1/ee/unkG0Uq/a1fZRc0
         aeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y5DXLCcHvBjdHt33VhE9tmBJjy8kvpLVV+pEKWRc2iM=;
        b=F6bbsqR8dz5de/wCGOL6TYag62UH25nbv57pxiXKsYrqn1L27Ll/hqjQKp4pujHAvX
         lltvBKkumN7AMqKsJZU65E/VRs5aUI8cm7xdfDX5o7jTsVOp5+O6V2aZO43FnMGdNAsP
         nZF7oVwOmk8TypR+P+fA4x2SDuSHr519LZCQ01uAyUs9Jbo3W9xacAFHzENshwRxw0lK
         2Qy7NOrAvareCigYd5ttnoz0BPmyeYxWlkgaXRpxUlYe1TlrUFaUa9NOsgjDXFhkTlsc
         vzRkMFsVdI+y9d7Vwh31DTVgk1O52nzzOA2RZrE1mIDlTbantGXvAlU732pDH6rAs1ip
         CeSA==
X-Gm-Message-State: APf1xPCi3gv+mzX5tbkj3CSrD6t0rC9xpzWzPLZrda1Gcu4PvFHAHBBh
        9cxkf4Yz9pl3pXVKq8jckmBCJSbZJw0=
X-Google-Smtp-Source: AH8x225/HTm5zRV9PPI9/UFTO/fUBVQA0D0CdBDgjMI5rFqvO7YhWfDbAJNZ6v2KaP04csHu80H+4A==
X-Received: by 10.101.92.195 with SMTP id b3mr391951pgt.319.1517875564957;
        Mon, 05 Feb 2018 16:06:04 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id r26sm19197771pfi.72.2018.02.05.16.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:06:04 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 057/194] replace-object: allow register_replace_object to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:55:18 -0800
Message-Id: <20180205235735.216710-37-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index c30bee2e69..31b6b3044e 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -18,33 +18,32 @@ static int replace_object_pos(struct repository *r, const unsigned char *sha1)
 			replace_sha1_access);
 }
 
-#define register_replace_object(r, rp, i) \
-	register_replace_object_##r(rp, i)
-static int register_replace_object_the_repository(struct replace_object *replace,
-						  int ignore_dups)
+static int register_replace_object(struct repository *r,
+				   struct replace_object *replace,
+				   int ignore_dups)
 {
-	int pos = replace_object_pos(the_repository, replace->original);
+	int pos = replace_object_pos(r, replace->original);
 
 	if (0 <= pos) {
 		if (ignore_dups)
 			free(replace);
 		else {
-			free(the_repository->objects.replacements.items[pos]);
-			the_repository->objects.replacements.items[pos] = replace;
+			free(r->objects.replacements.items[pos]);
+			r->objects.replacements.items[pos] = replace;
 		}
 		return 1;
 	}
 	pos = -pos - 1;
-	ALLOC_GROW(the_repository->objects.replacements.items,
-		   the_repository->objects.replacements.nr + 1,
-		   the_repository->objects.replacements.alloc);
-	the_repository->objects.replacements.nr++;
-	if (pos < the_repository->objects.replacements.nr)
-		memmove(the_repository->objects.replacements.items + pos + 1,
-			the_repository->objects.replacements.items + pos,
-			(the_repository->objects.replacements.nr - pos - 1) *
-			sizeof(*the_repository->objects.replacements.items));
-	the_repository->objects.replacements.items[pos] = replace;
+	ALLOC_GROW(r->objects.replacements.items,
+		   r->objects.replacements.nr + 1,
+		   r->objects.replacements.alloc);
+	r->objects.replacements.nr++;
+	if (pos < r->objects.replacements.nr)
+		memmove(r->objects.replacements.items + pos + 1,
+			r->objects.replacements.items + pos,
+			(r->objects.replacements.nr - pos - 1) *
+			sizeof(*r->objects.replacements.items));
+	r->objects.replacements.items[pos] = replace;
 	return 0;
 }
 
-- 
2.15.1.433.g936d1b9894.dirty

