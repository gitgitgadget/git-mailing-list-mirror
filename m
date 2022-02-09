Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD54C433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 11:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiBIL62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 06:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiBIL5m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 06:57:42 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0B2E00FEC4
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 02:59:19 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h6so3296290wrb.9
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 02:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zeh2b0qmlLamc9C66LjbDoUaY/NfxvM6VlNOo80stEs=;
        b=ICW5nBp975kXT6FTUg8jaHqsNuq246UZEApgjhBbdGy7XKJLjz+M1j3YbDvwZqwZwu
         t/OhNax9ESLCZAb2T3NuwHunpPIhNG2nRUL/NilkpBXKWXD4HGEZxLZVQB6QVHb/3KCT
         y/pIPBfgIthftOVF7pgUrt4ORO8U6MjJ9x68cqH8nJVu7hkLcq/WY81yXTOZmoEZyjT/
         u9Vy8Eq6eFmgLHMnPVj7yKtlSW1jXmYJEvK5pGRUYTPjL1L840WZZLsw+FDm7gbPeQjI
         W/7D8Jztu/4F9RFxHWjXv8kLCIi/X79Sr7kYGrl2r6KLi2vkYMA2XxHzBizrqVAGTKMR
         LklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zeh2b0qmlLamc9C66LjbDoUaY/NfxvM6VlNOo80stEs=;
        b=gDxLxjAxlZqa+xsOpRh58fZ1QgIm9i0QKRd8bbm0b8Hx5irSy8SyngnoB9+O2gpmS0
         xP07D/sHg5mhgyAfk1EB/qOcPxTIkBbalAgPfXPhee9pd4JZx8jD32vpgTxXSpcMI9i5
         LqtkePmr9z56H6M8PBYPbiFcEwjvNI9Xx+2Qt9JTZizrXLQD3XurP2iEz3o2WxjtBoAZ
         E444PD/Li0lwJAHAhDwwrdikPmJcsjmft9XoMwmSus2SjZS/NYMWKqiE+pjV7vjRj3Dq
         n7srvvxnwwGJ/y4GyGnboejpn6+fXbV6PVBsR80aKFw16CC9Di3fA45gQGYZubnByPaz
         TkLw==
X-Gm-Message-State: AOAM532n07PuXY3kTuV1Ojhxd5GdzJse8OD6vcyF5lrwPWJt2ZXNUmPQ
        QcqIIpXSdQKo69Dv+Zo2yj6VUgPsdjE=
X-Google-Smtp-Source: ABdhPJwyHXGBBlcm4iV7loh+R/ywTgakbF76WIZ0yqH03ADJzywF8h/ihDfVj4tBnVS6z2AGz4W8zA==
X-Received: by 2002:a5d:6c67:: with SMTP id r7mr1626984wrz.518.1644404357869;
        Wed, 09 Feb 2022 02:59:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7sm3852875wrm.15.2022.02.09.02.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 02:59:17 -0800 (PST)
Message-Id: <b8f88f1b9f84fb3f8d71a75c49f33e3426f103c0.1644404356.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.git.1644404356.gitgitgadget@gmail.com>
References: <pull.1140.git.1644404356.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Feb 2022 10:59:13 +0000
Subject: [PATCH 1/3] xdiff: handle allocation failure in patience diff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Edward Thomson <ethomson@edwardthomson.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Other users of libxdiff such as libgit2 need to be able to handle
allocation failures. As NULL is a valid return value the function
signature is changed to be able report allocation failures.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xpatience.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index c5d48e80aef..3e3d99f8922 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -198,7 +198,7 @@ static int binary_search(struct entry **sequence, int longest,
  * item per sequence length: the sequence with the smallest last
  * element (in terms of line2).
  */
-static struct entry *find_longest_common_sequence(struct hashmap *map)
+static int find_longest_common_sequence(struct hashmap *map, struct entry **res)
 {
 	struct entry **sequence = xdl_malloc(map->nr * sizeof(struct entry *));
 	int longest = 0, i;
@@ -211,6 +211,9 @@ static struct entry *find_longest_common_sequence(struct hashmap *map)
 	 */
 	int anchor_i = -1;
 
+	if (!sequence)
+		return -1;
+
 	for (entry = map->first; entry; entry = entry->next) {
 		if (!entry->line2 || entry->line2 == NON_UNIQUE)
 			continue;
@@ -230,8 +233,9 @@ static struct entry *find_longest_common_sequence(struct hashmap *map)
 
 	/* No common unique lines were found */
 	if (!longest) {
+		*res = NULL;
 		xdl_free(sequence);
-		return NULL;
+		return 0;
 	}
 
 	/* Iterate starting at the last element, adjusting the "next" members */
@@ -241,8 +245,9 @@ static struct entry *find_longest_common_sequence(struct hashmap *map)
 		entry->previous->next = entry;
 		entry = entry->previous;
 	}
+	*res = entry;
 	xdl_free(sequence);
-	return entry;
+	return 0;
 }
 
 static int match(struct hashmap *map, int line1, int line2)
@@ -358,14 +363,16 @@ static int patience_diff(mmfile_t *file1, mmfile_t *file2,
 		return 0;
 	}
 
-	first = find_longest_common_sequence(&map);
+	result = find_longest_common_sequence(&map, &first);
+	if (result)
+		goto out;
 	if (first)
 		result = walk_common_sequence(&map, first,
 			line1, count1, line2, count2);
 	else
 		result = fall_back_to_classic_diff(&map,
 			line1, count1, line2, count2);
-
+ out:
 	xdl_free(map.entries);
 	return result;
 }
-- 
gitgitgadget

