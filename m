Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4354E1F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeEQWw0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:52:26 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39261 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQWwY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:52:24 -0400
Received: by mail-pf0-f194.google.com with SMTP id a22-v6so2776823pfn.6
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7NBG0ymmpayRbF2jWKQXfQ0KVG6ohfvoIUlHQlqIs/Q=;
        b=gvNlre5RGYTALzsCDycJepJ4Naqathpteo1S2XRieEhwWF96VIhrvdPw3KlNBAKqob
         5xfoL/+AdXxJKY9+E844kA/DsmYyuTjX3oq7o1+39P28C+yLLqWNhCaV8bPv4RIHJNZP
         +GFmm2NSlb9sSe4093DVQoq7ND8w/3pKvh1+uyLWOhZsbyT9dSiUtq0Yevf8ORUlXgc1
         WUwwyp/0YZv0eXWScZ0bVeEgN39hQD2BQuxhOQ46DMlC47YnTZCKopBY2FDSz9KMFAun
         lp39zUkqfFAebbXtmN7uEVKVH6QD19niEdH+YPcaWn5g3bs92xu25JpQkBJAz5G+eY8K
         xtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7NBG0ymmpayRbF2jWKQXfQ0KVG6ohfvoIUlHQlqIs/Q=;
        b=AUzkhTcNXprcbHddWTRR2pJ8VjstL5FCpZVRwA/ch4RFbbxFxpf6LHbm2bD6WgIhvL
         Tru+o2qM/X6nYY+gJ1z3/QhhNVCES6zKy3CK/t8u+Lc0gZW54s/uefzH2ihzYTGOBXLC
         tPrzMDDHKIS94YLZaBwYRt1OOGDCraQ2KFIRaQ+b8tkHkfGeMbM6XW6nGPqc3Tc4CtYq
         zQLqtj6G0xGbcKC76dJGJjzjiuTZpFxigb0zSINqLzm3U0WVyjhhDWzLE1zNsCkHiXBz
         bWEd9j/ghFoUIMH5hpmau9IXzFJjWoCi5wQEiWjmDrdbS3fG8VUNXkhRq+3iX2vsnYoc
         7i0A==
X-Gm-Message-State: ALKqPwfmrMMr+T4i8OsIr5W85uKarITu4H7LSQknbYmQMWT3/V2EfFUU
        5umG3JWTHMABpfrKBI0YJVigyA==
X-Google-Smtp-Source: AB8JxZo7JKHfzQkfb0mZ+1fs13JHeRM5cqjR9gYQG1/zuNiba1tPpVp0PoMIrjGq/6eX8IubsghUBg==
X-Received: by 2002:a63:a312:: with SMTP id s18-v6mr5360540pge.187.1526597543683;
        Thu, 17 May 2018 15:52:23 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 63-v6sm9695328pgi.4.2018.05.17.15.52.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:52:22 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Subject: [PATCH 10/19] shallow: add repository argument to check_shallow_file_for_update
Date:   Thu, 17 May 2018 15:51:45 -0700
Message-Id: <20180517225154.9200-11-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517225154.9200-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
 <20180517225154.9200-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of check_shallow_file_for_update
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 shallow.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/shallow.c b/shallow.c
index 0fadd5330d2..0028e4ea776 100644
--- a/shallow.c
+++ b/shallow.c
@@ -217,7 +217,8 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 	return result;
 }
 
-static void check_shallow_file_for_update(void)
+#define check_shallow_file_for_update(r) check_shallow_file_for_update_##r()
+static void check_shallow_file_for_update_the_repository(void)
 {
 	if (is_shallow == -1)
 		die("BUG: shallow must be initialized by now");
@@ -319,7 +320,7 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
 
 	fd = hold_lock_file_for_update(shallow_lock, git_path_shallow(),
 				       LOCK_DIE_ON_ERROR);
-	check_shallow_file_for_update();
+	check_shallow_file_for_update(the_repository);
 	if (write_shallow_commits(&sb, 0, extra)) {
 		if (write_in_full(fd, sb.buf, sb.len) < 0)
 			die_errno("failed to write to %s",
@@ -366,7 +367,7 @@ void prune_shallow(int show_only)
 	}
 	fd = hold_lock_file_for_update(&shallow_lock, git_path_shallow(),
 				       LOCK_DIE_ON_ERROR);
-	check_shallow_file_for_update();
+	check_shallow_file_for_update(the_repository);
 	if (write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY)) {
 		if (write_in_full(fd, sb.buf, sb.len) < 0)
 			die_errno("failed to write to %s",
-- 
2.17.0.582.gccdcbd54c44.dirty

