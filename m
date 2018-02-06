Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C08A01F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbeBFAbg (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:31:36 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45007 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752283AbeBFAba (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:31:30 -0500
Received: by mail-pg0-f66.google.com with SMTP id r1so173908pgn.11
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9hhKK/SeeDwfB82I0zxeNvaR7oynfQIEfrDYZgMKhDU=;
        b=LVoZlu0n2+RNS0vrNd+pHAP88slr4ED3Lg6akXggTr7ciLcnsydw3RADrkcxOlsoct
         zu2kEE3Tsd1IItj+sO+16gX70HRAyaSFOzpBBqk3MrjOUS8Aq1qLBnqnWpUe8KRdiMww
         JxclW99XV72lnH3XrigTdLy8zOJO1oCrSL/BZ1hBoHiK4mRxLvgC0VjfYt8KhDfCDYBA
         VGtJiKDA092Qk4iZdlPD8B70MLQy69dtnXOutej/3O4WhgH3k9dxHFWjS0AKrM5poMwu
         rLxl/z9K76tz9yJzcOnfM5lg3rFfrmLos0pezCoTYl6nkJ0+WIWsBUVxtQMibU5LFwX8
         j0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9hhKK/SeeDwfB82I0zxeNvaR7oynfQIEfrDYZgMKhDU=;
        b=n9zJoENVgtQj2HvN0J7PXjHYwB2UrP0KuNNq1C0J29p3TvnXEFCoInaxUWZDLcJuu/
         r1clYTrdyEhrN0NA+3u8WxZwhROAvpX22gTSTLB9HCj3qSzVpw2q0h1T2ZPhawIulyFn
         EBaPNDfP4kKFdzDGups4D1kEDOJ+hUL6KhJcNO3uM8p1buu4N8iYmS9I9fSpEbvv6ft8
         3rwztXBxqh3gs+ksBtvx7rvmsYfxTdX1mkiIahUUW/Z1VSA+dZobfIKw/twUxfC4SdpH
         3Z2y22br706VoGNmdpMPST31MvHqIAwWqSnx9I9PjcUlOdII7PoLsZZVynZ0CbozbYxB
         oX9Q==
X-Gm-Message-State: APf1xPDcb9ndnl+ZM+OrN8Fr0UqswTDkzY45O6BEFFJqKY5zBt7v/Zfh
        pLRrmtjapUlj4EzxrRUaGe+HCDPHjOA=
X-Google-Smtp-Source: AH8x225raaOPysUBXqWQ7Duq0j68h3rjeAklub1En9yikojmrGcVS8p8d7nIybid4cBEqvhyoxGnAA==
X-Received: by 10.98.10.199 with SMTP id 68mr564520pfk.202.1517877089369;
        Mon, 05 Feb 2018 16:31:29 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id z5sm14721893pge.11.2018.02.05.16.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:31:28 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 185/194] commit: allow get_commit_buffer to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:40 -0800
Message-Id: <20180206001749.218943-87-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 6 +++---
 commit.h | 3 +--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index b241cc7979..b74086d43d 100644
--- a/commit.c
+++ b/commit.c
@@ -277,13 +277,13 @@ const void *get_cached_commit_buffer(struct repository *r, const struct commit *
 	return v->buffer;
 }
 
-const void *get_commit_buffer_the_repository(const struct commit *commit, unsigned long *sizep)
+const void *get_commit_buffer(struct repository *r, const struct commit *commit, unsigned long *sizep)
 {
-	const void *ret = get_cached_commit_buffer(the_repository, commit, sizep);
+	const void *ret = get_cached_commit_buffer(r, commit, sizep);
 	if (!ret) {
 		enum object_type type;
 		unsigned long size;
-		ret = read_sha1_file(the_repository, commit->object.oid.hash,
+		ret = read_sha1_file(r, commit->object.oid.hash,
 				     &type, &size);
 		if (!ret)
 			die("cannot read commit object %s",
diff --git a/commit.h b/commit.h
index 33f7779602..77e131d15b 100644
--- a/commit.h
+++ b/commit.h
@@ -88,8 +88,7 @@ const void *get_cached_commit_buffer(struct repository *r, const struct commit *
  * from disk. The resulting memory should not be modified, and must be given
  * to unuse_commit_buffer when the caller is done.
  */
-#define get_commit_buffer(r, c, s) get_commit_buffer_##r(c, s)
-const void *get_commit_buffer_the_repository(const struct commit *, unsigned long *size);
+const void *get_commit_buffer(struct repository *r, const struct commit *, unsigned long *size);
 
 /*
  * Tell the commit subsytem that we are done with a particular commit buffer.
-- 
2.15.1.433.g936d1b9894.dirty

