Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C2001F463
	for <e@80x24.org>; Fri, 13 Sep 2019 13:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388220AbfIMNC7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 09:02:59 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33166 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388187AbfIMNC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 09:02:56 -0400
Received: by mail-ed1-f68.google.com with SMTP id o9so27029269edq.0
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 06:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TAPD2AriovQ0IcJpCJVxop9CRVM9q4TT+plx+M33Ipk=;
        b=ecdv582RfjSCGFow9VJ5K46PwKUlwxiVw+/xUk88i6FzPHO2iy5NE0D2ld7kyS9TtH
         kLcpklZ7eCR6Lo+OA5CluUBhT1aISVXNbxMGrYryqLaQgVKl5qnyQQWJiolCB6d29zLV
         AR8Bn+W2FRFOh88cgCyR8N3KqsPN+EpPOUv/xDud4MJcXURx/NUX7m5+0qgsM3TnaaC6
         9U/Lf82A9dfg79unERr4bf3krNDIURxctU1/+34KaaulnyQBKifG0iYywyE/eFjrGx6J
         JQN1eOY7BD8JuyHmrl2eaevzqvQArKzSyHcdyVlP8vVladR3xYVpywZE7qmvWxU9/Lcm
         hKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TAPD2AriovQ0IcJpCJVxop9CRVM9q4TT+plx+M33Ipk=;
        b=HFFRKFutJI27ThpoLLQyoCpYaJ70ng7o0E4MilJPVBzE5gvJGcnEwvvvf5K7t67l3j
         iIZyxDq/9C3QNvWNtbj/pI+cx/R/BcA4zKndsUYlvBNsFZInWZwZzLxz0x/gJQHbSi+P
         lw6KBkDt9QFpmxEztvjFnVuDrZgV3navT2vXduIjFTYTooDhwpaKA5CCzzp17V8dqFVd
         HyWuObncNlYEEAfR013DDDKMLV0x5rPiB9rx+7e1igFFnhyuDr/HCFAY+QiZUg50KUdX
         iyJxnwj4laOuxGKpfdUt6brtke8vQV/4ShCFrmnicpv6Zh+rQdU3IO/I9GELHcjr7iR3
         uyow==
X-Gm-Message-State: APjAAAURZ6/OaOcx68Sj6TPiddrH3LIOxBhPOxyvqDNq28lmfjf96+4G
        IArQV4I+1mUrjWRlvIO/oM1WUk6V
X-Google-Smtp-Source: APXvYqwlHMYAe9yCDUzP1vlctXuf2NRIYD/3UNfRWuVg9YNDf4LNcikymac9L/gHl+N+tieUvwbUbA==
X-Received: by 2002:a50:baab:: with SMTP id x40mr22135084ede.60.1568379772659;
        Fri, 13 Sep 2019 06:02:52 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id c14sm2846570ejx.31.2019.09.13.06.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 06:02:52 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH 05/10] pack-bitmap: don't rely on bitmap_git->reuse_objects
Date:   Fri, 13 Sep 2019 15:02:21 +0200
Message-Id: <20190913130226.7449-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.23.0.46.gd213b4aca1.dirty
In-Reply-To: <20190913130226.7449-1-chriscool@tuxfamily.org>
References: <20190913130226.7449-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

As we now allocate 2 more words than necessary for each
bitmap to serve as marks telling us that we can stop
iterating over the words, we don't need to rely on
bitmap_git->reuse_objects to stop iterating over the words.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 pack-bitmap.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index ed2befaac6..b2422fed8f 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -622,7 +622,7 @@ static void show_objects_for_type(
 	enum object_type object_type,
 	show_reachable_fn show_reach)
 {
-	size_t pos = 0, i = 0;
+	size_t i = 0;
 	uint32_t offset;
 
 	struct ewah_iterator it;
@@ -630,13 +630,15 @@ static void show_objects_for_type(
 
 	struct bitmap *objects = bitmap_git->result;
 
-	if (bitmap_git->reuse_objects == bitmap_git->pack->num_objects)
-		return;
-
 	ewah_iterator_init(&it, type_filter);
 
-	while (i < objects->word_alloc && ewah_iterator_next(&filter, &it)) {
+	for (i = 0; i < objects->word_alloc &&
+			ewah_iterator_next(&filter, &it); i++) {
 		eword_t word = objects->words[i] & filter;
+		size_t pos = (i * BITS_IN_EWORD);
+
+		if (!word)
+			continue;
 
 		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
 			struct object_id oid;
@@ -648,9 +650,6 @@ static void show_objects_for_type(
 
 			offset += ewah_bit_ctz64(word >> offset);
 
-			if (pos + offset < bitmap_git->reuse_objects)
-				continue;
-
 			entry = &bitmap_git->pack->revindex[pos + offset];
 			nth_packed_object_oid(&oid, bitmap_git->pack, entry->nr);
 
@@ -659,9 +658,6 @@ static void show_objects_for_type(
 
 			show_reach(&oid, object_type, 0, hash, bitmap_git->pack, entry->offset);
 		}
-
-		pos += BITS_IN_EWORD;
-		i++;
 	}
 }
 
-- 
2.23.0.46.gd213b4aca1.dirty

