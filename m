Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C412520951
	for <e@80x24.org>; Tue, 14 Mar 2017 21:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbdCNVrg (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:47:36 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35353 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752412AbdCNVrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:47:09 -0400
Received: by mail-pg0-f44.google.com with SMTP id b129so96370881pgc.2
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 14:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UxviOwEyTQISR6FoeJRcvfELWPUpLsamBHGHEYylnL4=;
        b=jtS+zbLIBTvQ8XAmjEseOHhXct7AtSU3Xak5GF6Kg/wRIanNi46jcuc8ZdN+DJiSO1
         inqVF6uBrEVlvQd7Ph5OtjszQhXhSeIvq5RalOK+SOsKgYF1jhj/+pUjXKXJtJOmqwk6
         /wb4QzrJI3qHPrrGy+7DScTbYc2H282HhQos7HLMVLh7UB2Jez3aN/EWgKyCCYqgPo2y
         5RerXuvfQIDWqVzzgiCXshcCl47YqllQaGt4s78jYMdEzhj9vdSmG1Agap2K+XGTgAcR
         HEv2dVwptNUGypzrrWL9PuVJ4ovUO3yOcbk4HsYPcLvZ2TVUsnPbQevQMnNpuaAhWf3O
         ADJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UxviOwEyTQISR6FoeJRcvfELWPUpLsamBHGHEYylnL4=;
        b=UlZpwOhrNXcm5MZ18Ow9p3EmaNWlPZ2UvNQcetHG4ETGxEsrPxfTvG025pRVtzx6fU
         hEmSggCf0fc6vL3Cz+Hq/7amvosKsr2ltNMhjgnwSYezkhdIIXdiuaKNkFSi1d5obxZB
         +wHQ4rCz5+jH0FiBIO6rLO/NLK7PErnQ/uCypZLmUrAkJGYqcZPCeNumy8/1xCJ7jkgw
         YPlC+5zq6MbCeNbRe4d9SicO+XZzWfi4zaDBcMgBqVudpI6uOkVdYITa2b6xGle8bQ+s
         So4c5ZTJCmWxFdLOr75f8adqxCXXxHl4zyqLhkzkVSQE3PBL5Kp1e/vYK79TZ55eG2vj
         pi/g==
X-Gm-Message-State: AMke39ngZkKWyMzw/8SzyzzvBYSDIS8LmMv9OK3YvvMPnLD01JDOi1h3ewlA9wsNhlr595aB
X-Received: by 10.98.133.6 with SMTP id u6mr47203708pfd.48.1489528027500;
        Tue, 14 Mar 2017 14:47:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:8559:2c0d:dab3:f802])
        by smtp.gmail.com with ESMTPSA id f3sm40637079pga.34.2017.03.14.14.47.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 14:47:06 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 15/19] unpack-trees: pass old oid to verify_clean_submodule
Date:   Tue, 14 Mar 2017 14:46:38 -0700
Message-Id: <20170314214642.7701-16-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.g0cfd38c5f6.dirty
In-Reply-To: <20170314214642.7701-1-sbeller@google.com>
References: <20170309221543.15897-1-sbeller@google.com>
 <20170314214642.7701-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The check (which uses the old oid) is yet to be implemented, but this part
is just a refactor, so it can go separately first.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3a8ee19fe8..616a0ae4b2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1407,7 +1407,8 @@ static void invalidate_ce_path(const struct cache_entry *ce,
  * Currently, git does not checkout subprojects during a superproject
  * checkout, so it is not going to overwrite anything.
  */
-static int verify_clean_submodule(const struct cache_entry *ce,
+static int verify_clean_submodule(const char *old_sha1,
+				  const struct cache_entry *ce,
 				  enum unpack_trees_error_types error_type,
 				  struct unpack_trees_options *o)
 {
@@ -1427,16 +1428,18 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	struct dir_struct d;
 	char *pathbuf;
 	int cnt = 0;
-	unsigned char sha1[20];
 
-	if (S_ISGITLINK(ce->ce_mode) &&
-	    resolve_gitlink_ref(ce->name, "HEAD", sha1) == 0) {
-		/* If we are not going to update the submodule, then
+	if (S_ISGITLINK(ce->ce_mode)) {
+		unsigned char sha1[20];
+		int sub_head = resolve_gitlink_ref(ce->name, "HEAD", sha1);
+		/*
+		 * If we are not going to update the submodule, then
 		 * we don't care.
 		 */
-		if (!hashcmp(sha1, ce->oid.hash))
+		if (!sub_head && !hashcmp(sha1, ce->oid.hash))
 			return 0;
-		return verify_clean_submodule(ce, error_type, o);
+		return verify_clean_submodule(sub_head ? NULL : sha1_to_hex(sha1),
+					      ce, error_type, o);
 	}
 
 	/*
-- 
2.12.0.rc1.49.g0cfd38c5f6.dirty

