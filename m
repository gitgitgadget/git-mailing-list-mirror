Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89E961F406
	for <e@80x24.org>; Tue, 15 May 2018 23:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbeEOXnB (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 19:43:01 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:46432 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752265AbeEOXm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 19:42:59 -0400
Received: by mail-pl0-f52.google.com with SMTP id 30-v6so953134pld.13
        for <git@vger.kernel.org>; Tue, 15 May 2018 16:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lwuGOVFIw2Up3EM/01DPp8jctIkGIzdU6Lk4Ls1kxpM=;
        b=N39hU5w1ZhOod07Se6Qih+O7sqyey3Lv4QdrS4C66+xcSwcyS1fYHwwmr8YQD6hY+K
         X6gfZC6xGlCz8bQpD3/bYfBYGcIijxRepnRJmR0MM+zg5lWVkRrgV3lSWO5KppLUW10g
         GSwG74HlgYPxMkhtlBusN45BLlYTt+dwTabTu6eMwWNVH9uInaMu3dy764P2OcvYMQtN
         QLliBhYt726DX+16vpWWEDPLoP1mx5BSS7yz0LsFqLoA39LFdzkbL8eF3dgtvfeO/sNK
         wVHdeHE8CwQ5uF4XvAn2Batji+EaMZDmmNA3VDjSr7xAh+atXPlkuHAi5r2tsRJCL9lY
         s1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lwuGOVFIw2Up3EM/01DPp8jctIkGIzdU6Lk4Ls1kxpM=;
        b=myjGRDJXeXlNxsY6aJGAlrxOA1e6rqkuMZHcOeIj+FlOSe51PydDsBWRudo/CpSvGF
         iuAXBKCIEwalINp7pbDQji8LRaPpN6up1zIBCK1yQvpPkEoJNYFjR+274txpJK0Q46DV
         JS486SQaVXnpx8FuxWhg+QSX80zn8wKjK4lMJZaKbZli3gYqM2yY0fB+G7VNzfDWc3uA
         QDFcaK1o0vkhkp1sMPH0xuD334RRORhcF3Y+PZGtIcr0nVPO5oAVRsqGyNJl3sRZWb4/
         7c5typxyOrbEWGHdXTv5EEBejmKh84yz9oEiysYkVLhvsknATinUMRa2Qn/95FTqkRHX
         h7Aw==
X-Gm-Message-State: ALKqPwco/OQIWdd088ABT3cDF7s8gSTBBMJ/1Ab6pAVTQlUFZ9Yv9DP3
        nbyLy0DTsnzideQ47ujd+wNYSAYY9as=
X-Google-Smtp-Source: AB8JxZotUGf8EyAvkBi6M/jOEISPjW0hvLmP1Nq+Yj4mBP7kWHa6mXwt3tVMfMzLXCoG0JZjB4J0Ow==
X-Received: by 2002:a17:902:d886:: with SMTP id b6-v6mr15917343plz.361.1526427778002;
        Tue, 15 May 2018 16:42:58 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id n5-v6sm1332392pff.134.2018.05.15.16.42.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 16:42:57 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 15/19] cache: convert get_graft_file to handle arbitrary repositories
Date:   Tue, 15 May 2018 16:42:29 -0700
Message-Id: <20180515234233.143708-16-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180515234233.143708-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h       | 2 +-
 commit.c      | 2 +-
 environment.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index ab716011b7e..cb1aeb1dcbf 100644
--- a/cache.h
+++ b/cache.h
@@ -476,7 +476,7 @@ extern const char *get_git_dir(void);
 extern const char *get_git_common_dir(void);
 extern char *get_object_directory(void);
 extern char *get_index_file(void);
-extern char *get_graft_file(void);
+extern char *get_graft_file(struct repository *r);
 extern int set_git_dir(const char *path);
 extern int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
 extern int get_common_dir(struct strbuf *sb, const char *gitdir);
diff --git a/commit.c b/commit.c
index 3fcb2fd66ce..24028fd257a 100644
--- a/commit.c
+++ b/commit.c
@@ -204,7 +204,7 @@ static void prepare_commit_graft_the_repository(void)
 
 	if (commit_graft_prepared)
 		return;
-	graft_file = get_graft_file();
+	graft_file = get_graft_file(the_repository);
 	read_graft_file(the_repository, graft_file);
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
diff --git a/environment.c b/environment.c
index 87d9e52ffde..ab42346e563 100644
--- a/environment.c
+++ b/environment.c
@@ -316,11 +316,11 @@ char *get_index_file(void)
 	return the_repository->index_file;
 }
 
-char *get_graft_file(void)
+char *get_graft_file(struct repository *r)
 {
-	if (!the_repository->graft_file)
+	if (!r->graft_file)
 		BUG("git environment hasn't been setup");
-	return the_repository->graft_file;
+	return r->graft_file;
 }
 
 int set_git_dir(const char *path)
-- 
2.17.0.582.gccdcbd54c44.dirty

