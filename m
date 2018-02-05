Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB5701F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeBFAJt (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:09:49 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40127 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbeBFAJr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:09:47 -0500
Received: by mail-pg0-f67.google.com with SMTP id g2so139784pgn.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wUQE0OOGMKhqejASCaRQTuPHkO0qOfnBBQvpvnQKa18=;
        b=ZfnPDoJtkuRuyv/MNWN8a4cdJFtCuWRPa6Zl55D/KbKAHltSmCEJNVUie2Bt0njsBX
         b6CXoVAIghuzcpPZ+rHnMb2EgG+YRXmGps+iYpoSw5hB6ZD5Eq66OpvKLdAien3miT6v
         8SNOtBOX1+3wTDfisHdXWDqCQzfvKkxpCiDcA7UTdrMOdQN4f0hMQ5NmgJ2ZpIdyQelz
         mE/E/mqHrSm+l2kQt7ohB3796vsHYfPg1jjJjDuJvLCGgcqtFTIQi8c9SCtf8Q9R6IZt
         wCYIWT1StlSFs8MLe9VkKJRGAGNBmPz++zYFSgTltZ6wGNrqbkY9Opj6/nmW3VUPOaOE
         dc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wUQE0OOGMKhqejASCaRQTuPHkO0qOfnBBQvpvnQKa18=;
        b=PH7Az/STdQllmxZ8luZYzKux6b+eXBg2BNsEo19F40L8/sgXXsiaAZ/7s4PAh34Xf+
         15b607xhJanRiIZQK2J/IGNT1zeEayB/qVeAr9YgHawmGj2tyTw3FLcQ2iAE9q56mbnv
         vKVwdyNkVB+fHerZK5BqutcOccFu7oCcKS9A+r34py2rKCffrhDnaKi6j4yUP8t/L7Pi
         THyJg+n+83JYa16m0Mt02SPzsgjHKZrw9cYLLNzm9/hpFv5qjQ3fwIQOBa7dLyVHAxZC
         a09u9QxWH3Lk90BYfWXuQkxDkZMMzc+S9NHQX27NKWYa8KJbtos+TIkZX9D3JWRGewlU
         F4kg==
X-Gm-Message-State: APf1xPBaatOc+kjTLJmNBIRMk4YPTR/3O35ukAFGtuf0ro1LFbElurE3
        Oox7U18x72ITT4sVJ7prR5u0wP+ld8s=
X-Google-Smtp-Source: AH8x226Twi3dBTI1faLu+zwP+V1mP+QhoD8f9iecUn3XPTC6pnWJ/t26Adl/ob+i2+r7OLqfP39ZuQ==
X-Received: by 10.99.108.72 with SMTP id h69mr408231pgc.302.1517875786710;
        Mon, 05 Feb 2018 16:09:46 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id j3sm17081164pfh.39.2018.02.05.16.09.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:09:46 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 073/194] pack: allow find_pack_entry to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:55:34 -0800
Message-Id: <20180205235735.216710-53-sbeller@google.com>
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
 packfile.c | 12 +++++++-----
 packfile.h |  5 +++--
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/packfile.c b/packfile.c
index 9f7ca8f211..178d2e0ddd 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1839,17 +1839,19 @@ static int fill_pack_entry(const unsigned char *sha1,
  * Iff a pack file contains the object named by sha1, return true and
  * store its location to e.
  */
-int find_pack_entry_the_repository(const unsigned char *sha1, struct pack_entry *e)
+int find_pack_entry(struct repository *r,
+		    const unsigned char *sha1,
+		    struct pack_entry *e)
 {
 	struct mru_entry *p;
 
-	prepare_packed_git(the_repository);
-	if (!the_repository->objects.packed_git)
+	prepare_packed_git(r);
+	if (!r->objects.packed_git)
 		return 0;
 
-	for (p = the_repository->objects.packed_git_mru.head; p; p = p->next) {
+	for (p = r->objects.packed_git_mru.head; p; p = p->next) {
 		if (fill_pack_entry(sha1, e, p->item)) {
-			mru_mark(&the_repository->objects.packed_git_mru, p);
+			mru_mark(&r->objects.packed_git_mru, p);
 			return 1;
 		}
 	}
diff --git a/packfile.h b/packfile.h
index 615c58cbac..6d10871d25 100644
--- a/packfile.h
+++ b/packfile.h
@@ -142,8 +142,9 @@ extern int packed_object_info_the_repository(struct packed_git *pack, off_t offs
 extern void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
 extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
 
-#define find_pack_entry(r, s, e) find_pack_entry_##r(s, e)
-extern int find_pack_entry_the_repository(const unsigned char *sha1, struct pack_entry *e);
+extern int find_pack_entry(struct repository *r,
+			   const unsigned char *sha1,
+			   struct pack_entry *e);
 
 extern int has_sha1_pack(const unsigned char *sha1);
 
-- 
2.15.1.433.g936d1b9894.dirty

