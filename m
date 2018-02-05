Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 335AC1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeBFAHg (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:07:36 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38025 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752222AbeBFAHC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:07:02 -0500
Received: by mail-pg0-f65.google.com with SMTP id l18so135957pgc.5
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w9ycPQEa0PINzMkCsYyasohm/dTwLayFxmdcGc0YfYI=;
        b=j6s2TQpF56LUgdGLAtaX7by1a7kJHxkJlkprp7HIL2einEndMif4x8eP6GvUJ7mLU8
         Z87X4kqOv6OrNYq0wAoOuGorlNC37f1k2FMoL0sWtRSQ6b2zqsROLAj/8wc4muvcRQLX
         vQdy/md+69JNKXyK6b1O/532Bbk/PgwgWALN6MZNjIYuz7EEZ77HmKB03PG9VF+zJnYr
         OuS/cziHStYX6JJ/Q4Tk0CcZ5Pq006jyI4hVmbNbtvADTuXokSKLsmZ735LHpTReX+rc
         Iw5i9NZW6Z9XNGG4WcBqkrv4/gPOpxZrOq4s2VIeJ0m2VJ4PY3px/fXMojQxKNUQW9M3
         DaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w9ycPQEa0PINzMkCsYyasohm/dTwLayFxmdcGc0YfYI=;
        b=HamCdrnnoOjsycBP6TukBli6y/ns/rJcLGCa5ld5nBs0LjKB0jK1Y/BNNQACv/+QJQ
         gcDdNQQYEqCm4o6/s11e8YeOU6//E5XCTg7s5PvF0zaIo851lm2Il63wDbeLcFJIS5/f
         UdAnk0KyDZK2vXpDzaXK+PoYN7TTm3CHThzoPakI/U+3ISxlTUF/DFAm3hjQrelwN460
         pmiGnbWCv8wxZtlla155HASeqH2pHl+H6kmj4UWJwXcnoWq3hWlNYU9dzRB2NfA9+Y3s
         Nu5M2LBAdW6fh34dCH/Z4RkY6ihXL9T/irivUf6vZQpmpOF0+SFbAqc02KZGTL7GiyO3
         AoDQ==
X-Gm-Message-State: APf1xPAsSskGnzfrbsQTFNM5B1R4l4Cj68ZO/Nuo4DWqpmuHGzW8ScsU
        iM7Eff+zHifz2QeU04PKf4Hq52UygS0=
X-Google-Smtp-Source: AH8x225TEKSAvilfqPsS6xRCxq2ZZZ7QGlCgLXcYVTrcey2YSW1sL04HXSS0zO6hQkGx2o/pXJ6hvQ==
X-Received: by 10.98.55.3 with SMTP id e3mr507855pfa.119.1517875621584;
        Mon, 05 Feb 2018 16:07:01 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id k7sm683818pgt.20.2018.02.05.16.07.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:07:01 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 062/194] replace_object: allow do_lookup_replace_object to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:55:23 -0800
Message-Id: <20180205235735.216710-42-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 9 +++++----
 replace-object.h | 3 +--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index d9250a7cf8..a6a34217d8 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -94,12 +94,13 @@ static void prepare_replace_object(struct repository *r)
  * permanently-allocated value.  This function always respects replace
  * references, regardless of the value of check_replace_refs.
  */
-const unsigned char *do_lookup_replace_object_the_repository(const unsigned char *sha1)
+const unsigned char *do_lookup_replace_object(struct repository *r,
+					      const unsigned char *sha1)
 {
 	int pos, depth = MAXREPLACEDEPTH;
 	const unsigned char *cur = sha1;
 
-	prepare_replace_object(the_repository);
+	prepare_replace_object(r);
 
 	/* Try to recursively replace the object */
 	do {
@@ -107,9 +108,9 @@ const unsigned char *do_lookup_replace_object_the_repository(const unsigned char
 			die("replace depth too high for object %s",
 			    sha1_to_hex(sha1));
 
-		pos = replace_object_pos(the_repository, cur);
+		pos = replace_object_pos(r, cur);
 		if (0 <= pos)
-			cur = the_repository->objects.replacements.items[pos]->replacement;
+			cur = r->objects.replacements.items[pos]->replacement;
 	} while (0 <= pos);
 
 	return cur;
diff --git a/replace-object.h b/replace-object.h
index 8af730f5e3..67a433d5a5 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -13,8 +13,7 @@ struct replace_object {
  * This internal function is only declared here for the benefit of
  * lookup_replace_object().  Please do not call it directly.
  */
-#define do_lookup_replace_object(r, s) do_lookup_replace_object_##r(s)
-extern const unsigned char *do_lookup_replace_object_the_repository(const unsigned char *sha1);
+extern const unsigned char *do_lookup_replace_object(struct repository *r, const unsigned char *sha1);
 
 /*
  * If object sha1 should be replaced, return the replacement object's
-- 
2.15.1.433.g936d1b9894.dirty

