Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 553FD1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeBFAIx (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:08:53 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41156 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeBFAIw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:08:52 -0500
Received: by mail-pg0-f65.google.com with SMTP id 141so132867pgd.8
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vf3htiIKAmFhumIOcurPmZeuhSPt8Dc4g3YIusvwO6c=;
        b=M9a31Y8AVi8eHyZ/XzbWQzTHjNaBPa2dPyVjpOFFjNPtHNYrDIYLaH1rzCSKHiNV6g
         4KEsTZz4nyu4E5bxPb+IcvGSENO1WSELZAd/nbyzCReffSsCFv5Jjmir2D6Hh/rWGGik
         pI87B1jO+NCuC7tN45/pGZSF1U8au7zqOMbQhMaJF1X8N3+hb5+qrCCpr2guQONOHQJj
         ELgJllYoifbOWDTUkQ33jS54ROzQUz6bitqzk8CHzl23Y7riF7tTGa3HzEakB01dRmuT
         ubcSv3pUEKAQ/ie0pMVQpALsXobulBSSOQ0/W5szxmkJURyZEWyx50tJ9wrFTOsMwmZw
         FhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vf3htiIKAmFhumIOcurPmZeuhSPt8Dc4g3YIusvwO6c=;
        b=JUSOL5cS5/Ru7b47agy8rIm9qM6k8p1UbeRpZTo6PJmkqSpMgSVbKaLYIEUgYLaw+s
         CJzbf06cgB2vpZjK2LTclpqsXS6giq6pDC4e4Hl3nMRcjPCs0DE6ayrDW0i2+dtoIMyT
         cKQ+OxNC/CGV0ULhJC8Wsv8JDk/Kv8JtHkUeBmRZJSKoayuRqORIn1469wUHt8m3hpHp
         4264CvvWnLMPLrCcQtIt7gnQRjbYslbWqORD5IXm2YD7lRVMD0HVE6aWYX9ubSfYuEGA
         KleDnRG303psjiOKcrlkOAWcV2NUtz6p9jKfHzmPhiS3fZUWjAkfFBFYJB4jmq0phSL2
         dQtg==
X-Gm-Message-State: APf1xPAvj25owP/2HBhyVJLuXuRR6dKTQ/llVOiagD+mmi9fp34u8d1g
        9fzeaamnjMHhrT6V+MVQdYPgpkBy+gM=
X-Google-Smtp-Source: AH8x2271VOXzNSEHBvT7x9RBUcbZc5ik2sb1z5UIRWXQd6ZPhPe199Gur/qCxuLx4QMlUQvsMqp/ZA==
X-Received: by 10.99.6.19 with SMTP id 19mr437202pgg.222.1517875731182;
        Mon, 05 Feb 2018 16:08:51 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id z186sm14851478pgb.70.2018.02.05.16.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:08:50 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 069/194] pack: add repository argument to find_pack_entry
Date:   Mon,  5 Feb 2018 15:55:30 -0800
Message-Id: <20180205235735.216710-49-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow callers of find_pack_entry to be
more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c  | 4 ++--
 packfile.h  | 3 ++-
 sha1_file.c | 6 +++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/packfile.c b/packfile.c
index 61e84a789c..f641f6329a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1835,7 +1835,7 @@ static int fill_pack_entry(const unsigned char *sha1,
  * Iff a pack file contains the object named by sha1, return true and
  * store its location to e.
  */
-int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
+int find_pack_entry_the_repository(const unsigned char *sha1, struct pack_entry *e)
 {
 	struct mru_entry *p;
 
@@ -1855,7 +1855,7 @@ int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 int has_sha1_pack(const unsigned char *sha1)
 {
 	struct pack_entry e;
-	return find_pack_entry(sha1, &e);
+	return find_pack_entry(the_repository, sha1, &e);
 }
 
 int has_pack_index(const unsigned char *sha1)
diff --git a/packfile.h b/packfile.h
index bb1d92b849..b42e5c2db1 100644
--- a/packfile.h
+++ b/packfile.h
@@ -141,7 +141,8 @@ extern int packed_object_info_the_repository(struct packed_git *pack, off_t offs
 extern void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
 extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
 
-extern int find_pack_entry(const unsigned char *sha1, struct pack_entry *e);
+#define find_pack_entry(r, s, e) find_pack_entry_##r(s, e)
+extern int find_pack_entry_the_repository(const unsigned char *sha1, struct pack_entry *e);
 
 extern int has_sha1_pack(const unsigned char *sha1);
 
diff --git a/sha1_file.c b/sha1_file.c
index 299e8be72c..7e06ece5f3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1272,7 +1272,7 @@ int sha1_object_info_extended_the_repository(const unsigned char *sha1, struct o
 		}
 	}
 
-	if (!find_pack_entry(real, &e)) {
+	if (!find_pack_entry(the_repository, real, &e)) {
 		/* Most likely it's a loose object. */
 		if (!sha1_loose_object_info(the_repository, real, oi, flags))
 			return 0;
@@ -1282,7 +1282,7 @@ int sha1_object_info_extended_the_repository(const unsigned char *sha1, struct o
 			return -1;
 		} else {
 			reprepare_packed_git(the_repository);
-			if (!find_pack_entry(real, &e))
+			if (!find_pack_entry(the_repository, real, &e))
 				return -1;
 		}
 	}
@@ -1648,7 +1648,7 @@ static int freshen_loose_object(const unsigned char *sha1)
 static int freshen_packed_object(const unsigned char *sha1)
 {
 	struct pack_entry e;
-	if (!find_pack_entry(sha1, &e))
+	if (!find_pack_entry(the_repository, sha1, &e))
 		return 0;
 	if (e.p->freshened)
 		return 1;
-- 
2.15.1.433.g936d1b9894.dirty

