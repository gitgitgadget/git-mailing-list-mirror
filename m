Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D8F01F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750999AbeBFAAE (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:00:04 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39231 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeBFAAC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:00:02 -0500
Received: by mail-pg0-f66.google.com with SMTP id w17so119224pgv.6
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dYMvfImizbDo0MmNT8RVCwEeWTGICjJUnHO+YJTCdMY=;
        b=VBKqXFXWhNV2mRBjcdA98E913FIoYf6o3qf5VFQR+ztcW7yjadp4yh42QIGTmwzlts
         wsXsvZ5/i/k5fsgBtSYstZNgdUJ4wlJRcSGvUHcghiAyrKMbvdv/SuJ0DxKYpx4xWQ4n
         0VU8lONkPVyP4ljlVhJCHLBmgI51kdXtZD/8oNrm5vzlCIF4rG9m5DkWfSshnBBC5oOH
         krc7UDm/CPf7Xl5t2ptcLQ0Fxw34RLQsMoOBLXQOgW1u8s76/4jMg8Z2e0iq7FU4pyki
         HpfO/uMgnftziy4b2AgDDzQknBuMTUeJiObW9rXBE0gxIlUqC2eWr1sz5RyTNqlfnT1L
         QLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dYMvfImizbDo0MmNT8RVCwEeWTGICjJUnHO+YJTCdMY=;
        b=UQFi7KdwQeBT8LHeGmc3tKtPRvmqnLQgJ2lHWayT2ykBdQaC4ByemhDBQbkPnKqcxf
         2BwGthSAp7XA60pE85y7P1Rh5KObu0qa9Ho9mGYCSwNGkc9LRk4iBYWXqo+qUf9VgkYK
         pfzKbmI8rTeVTC2ky1EeIgjJskWDEZySbL8pAafw53kuDnxPUtIE2iUJYXpKG5oEluU6
         9huLV0Tqsh0kS9/SEyF4qHqTT9ouOVBE7GF1VIe+tvZFacdjCcgAtoa/oJqFcta0+yXl
         EbWS+LvEkShLijzYtJj8LRmqSxDznEcJwAwBcwABq4//N8L3WytINMcCurD1C1IO5AMt
         z6Ng==
X-Gm-Message-State: APf1xPCaqgxBBlajA0AoQ++A+mmySYWu/u+ahEoVkBHdua5TN9r9f4S0
        na30jhpfIygZ8w/J/nLKihhCko3xcCQ=
X-Google-Smtp-Source: AH8x224aZlWlgTwu9hcKcr+riTOF/earsZiqLTzebcrQwJTRK4EkGinXbmqL//JwKDmvZq3cQBRsWQ==
X-Received: by 10.99.117.74 with SMTP id f10mr371637pgn.385.1517875201602;
        Mon, 05 Feb 2018 16:00:01 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id o1sm14989029pgn.6.2018.02.05.16.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:00:01 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 031/194] pack: allow prepare_packed_git to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:54:52 -0800
Message-Id: <20180205235735.216710-11-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 packfile.c | 18 +++++++++---------
 packfile.h |  3 +--
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/packfile.c b/packfile.c
index 2b73e62a44..7dc7e8e383 100644
--- a/packfile.c
+++ b/packfile.c
@@ -872,19 +872,19 @@ static void prepare_packed_git_mru(struct repository *r)
 		mru_append(&r->objects.packed_git_mru, p);
 }
 
-void prepare_packed_git_the_repository(void)
+void prepare_packed_git(struct repository *r)
 {
 	struct alternate_object_database *alt;
 
-	if (the_repository->objects.packed_git_initialized)
+	if (r->objects.packed_git_initialized)
 		return;
-	prepare_packed_git_one(the_repository, get_object_directory(), 1);
-	prepare_alt_odb(the_repository);
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
-		prepare_packed_git_one(the_repository, alt->path, 0);
-	rearrange_packed_git(the_repository);
-	prepare_packed_git_mru(the_repository);
-	the_repository->objects.packed_git_initialized = 1;
+	prepare_packed_git_one(r, r->objectdir, 1);
+	prepare_alt_odb(r);
+	for (alt = r->objects.alt_odb_list; alt; alt = alt->next)
+		prepare_packed_git_one(r, alt->path, 0);
+	rearrange_packed_git(r);
+	prepare_packed_git_mru(r);
+	r->objects.packed_git_initialized = 1;
 }
 
 void reprepare_packed_git_the_repository(void)
diff --git a/packfile.h b/packfile.h
index ba6f08be99..75be3cb877 100644
--- a/packfile.h
+++ b/packfile.h
@@ -32,8 +32,7 @@ extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-#define prepare_packed_git(r) prepare_packed_git_##r()
-extern void prepare_packed_git_the_repository(void);
+extern void prepare_packed_git(struct repository *r);
 #define reprepare_packed_git(r) reprepare_packed_git_##r()
 extern void reprepare_packed_git_the_repository(void);
 extern void install_packed_git(struct repository *r, struct packed_git *pack);
-- 
2.15.1.433.g936d1b9894.dirty

