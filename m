Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA93420A10
	for <e@80x24.org>; Sun,  1 Oct 2017 14:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbdJAO4u (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 10:56:50 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35217 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbdJAO4t (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 10:56:49 -0400
Received: by mail-wr0-f196.google.com with SMTP id r74so957155wrb.2
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 07:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=shp6mzpx/dQx8yhzWp15WbbxS/871kbxl9IdWFbfv30=;
        b=nGApNzmngg/P65T8HqVkQTQD0/J7e0Ygv84QVd3Edhpdu0tyEGMs2q21YvhhWTFo3/
         jdVWBS+Wvitps/sfPUz5XKHdGbOYiDKTDDNyiSm2CZHTrWTYm54XQweVuQPo3208JQLY
         xl2zappaI/2VotYRdqYt8PtQ2zBD9eGhsP/y9y8ik5OngKG6Uy4DdHI2k1wtHccNoHAX
         ZKJJgu9ataJlj4KkIjiKyj6dmcgfd3mdD235Dmb2PorNKaeNh/wmqW8v3GS0vC2MZ+Q7
         +DCyRQrQe6gTAqFJGIR6vQpjm2HguW4mmL0QoJOP1lVYblNm5LWhqQfCXylzjifWnUY8
         oWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=shp6mzpx/dQx8yhzWp15WbbxS/871kbxl9IdWFbfv30=;
        b=IikNT/wJUp6Uue+2xE1qBs+VBcBQEehyTG/IHjmo3BOh8Tme7aSoMXO3OTBD0tndQM
         JM4AsNK8RT4mZ7IkgeSAxMj9cpEQXF59YnhMcKJ0jJ9Im/0pU5rbd5pySLYT4ZOQLmMV
         OGYnYhLO6assaPDPlfQKvmTM5nFWMoLjkoDJbiXf78odPPOc+1WcF/O02dFLEihzi6v7
         81uNSE7nZER2uFRDX9EZJln5N9rcmBVWfq60TH95HX+CZgM6bctUpcxFPvlcK0qvQNPX
         sJd0YHkZxVRakKKUz8znY9UKOLGVUqQLQCxngqOreAUPiMz53X4kf1IgUPPBeHcnnkJh
         ETfw==
X-Gm-Message-State: AHPjjUhuwsxFnGiUxWyXP6xx3srpdFX39m2lgC1kVB5isIRDCV4mFWMH
        ZY/KlacLvPEDkHOOd3xJ2QC8wA==
X-Google-Smtp-Source: AOwi7QAcFQTRU87aQSoTiOHyTeruyxGwTMKixSV8FtEWa7MMwoiS8EbElNjKosyEE8GGLeWJoo7WeA==
X-Received: by 10.223.160.221 with SMTP id n29mr12352850wrn.214.1506869808287;
        Sun, 01 Oct 2017 07:56:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id w82sm10473516wme.5.2017.10.01.07.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Oct 2017 07:56:47 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 05/11] cache-tree: simplify locking logic
Date:   Sun,  1 Oct 2017 16:56:06 +0200
Message-Id: <3475f0eee33ca0c4b2bc928191f0b06576ee29fb.1506862824.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.727.g9ddaf86
In-Reply-To: <cover.1506862824.git.martin.agren@gmail.com>
References: <cover.1506862824.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After we have taken the lock using `LOCK_DIE_ON_ERROR`, we know that
`newfd` is non-negative. So when we check for exactly that property
before calling `write_locked_index()`, the outcome is guaranteed.

If we write and commit successfully, we set `newfd = -1`, so that we can
later avoid calling `rollback_lock_file` on an already-committed lock.
But we might just as well unconditionally call `rollback_lock_file()` --
it will be a no-op if we have already committed.

All in all, we use `newfd` as a bool and the only benefit we get from it
is that we can avoid calling a no-op. Remove `newfd` so that we have one
variable less to reason about.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 cache-tree.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 71d092ed5..f646f5673 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -602,11 +602,11 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 
 int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, const char *index_path, int flags, const char *prefix)
 {
-	int entries, was_valid, newfd;
+	int entries, was_valid;
 	struct lock_file lock_file = LOCK_INIT;
 	int ret = 0;
 
-	newfd = hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
+	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
 
 	entries = read_index_from(index_state, index_path);
 	if (entries < 0) {
@@ -625,10 +625,7 @@ int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, co
 			ret = WRITE_TREE_UNMERGED_INDEX;
 			goto out;
 		}
-		if (0 <= newfd) {
-			if (!write_locked_index(index_state, &lock_file, COMMIT_LOCK))
-				newfd = -1;
-		}
+		write_locked_index(index_state, &lock_file, COMMIT_LOCK);
 		/* Not being able to write is fine -- we are only interested
 		 * in updating the cache-tree part, and if the next caller
 		 * ends up using the old index with unupdated cache-tree part
@@ -650,8 +647,7 @@ int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, co
 		hashcpy(sha1, index_state->cache_tree->oid.hash);
 
 out:
-	if (0 <= newfd)
-		rollback_lock_file(&lock_file);
+	rollback_lock_file(&lock_file);
 	return ret;
 }
 
-- 
2.14.1.727.g9ddaf86

