Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FEEC1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeJQH3G (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:29:06 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:57298 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJQH3G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:29:06 -0400
Received: by mail-qk1-f201.google.com with SMTP id l75-v6so25348569qke.23
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ITi3CUeG+Fw1uRxnQr+Xhmbstp7jF99+55WE3tvDj3Q=;
        b=J2TrsmYM11eEVTQUlUfq89s+PA4PXcAULdLtAe6E5N85gRbHd1C743erCj7UVI0hce
         hqOAhLgeJZ7DX4djixg1jLThBe/qfmGulU7l3d21rDMfR4mWa9pabRWnMfvW6ClY3jVs
         C/LcRJBSIl6Ah0XNFss+yeaxXWER8Wvsmie/nLJxs+4as+xVa4zy9CWmp3LGDmi+HnuU
         Bh3Ly0UVprf+l+evtzCGRWWrjjZnT4q21UHXylsgdkhmMxEbDghpWaGBx1/HXB+sgpyF
         XCGfqx5FeDSD5CaVjl2ndjvSDdZ7PJi7ZI7SiYKe7vYGEexXDHxG+82U+xzVIch2IG6L
         Az7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ITi3CUeG+Fw1uRxnQr+Xhmbstp7jF99+55WE3tvDj3Q=;
        b=sJXWr8w5ptfPaDM3fjXNR12xQWJCTItZstcpET+oiLF+3O2VxajPy2D83NHcKqfEiy
         YdUtv05K/Veu1xKvAqB7uTYPGNqRPww/Yr8R90xkZ0moyfR9winb9JKzWe8B+9Pot9Yi
         pEsoO4E+IAqydwGshNVpUrZPlXoC+Fx6sK5eyn5lRH5FadSB6ZuZJJy27kJrC9A7oXJd
         dfTS61NMB5ir2h1PvQk82IPVpXdZSlfW49vsgJpzDGO4NzOPszihLYt9Az4Xi42RTvbe
         diRZytfNC1p14bZIH1Vcc2IKpq7qhwwCHgCoLxJ6v9dxxRh1AgzowXNnuTvhuQ+1/IzT
         M5mw==
X-Gm-Message-State: ABuFfogItZhK6QmG6HtLDZdYd5Nt9n2kVaIPjWJvBdwpJCnYG8UWMSxU
        ws6W9BY1yryL2nrrKKBlVZsJt+SXAvXqJPjDu59FkoFzR2oaxOaLrnPH1nJJNPfmXWwKVubFhdl
        SeMy0g58g+wwE1HTO8LSfqVma1uk8NGlgTkT08JvGoe5opn1FucdNYqRGzNk0
X-Google-Smtp-Source: ACcGV63R9wIqdoSrcd++Er2s7lrMrwpSsHc9PgLyHCyZL3Qf15L2wOB2inQYPVmztN11ZDBQHK/6NVy50PDu
X-Received: by 2002:ac8:396b:: with SMTP id t40-v6mr19274220qtb.16.1539732981236;
 Tue, 16 Oct 2018 16:36:21 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:35:42 -0700
In-Reply-To: <20181016233550.251311-1-sbeller@google.com>
Message-Id: <20181016233550.251311-12-sbeller@google.com>
Mime-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 11/19] commit-reach.c: allow get_merge_bases_many_0 to handle
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit-reach.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index bce4169f1f..df93274966 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -213,7 +213,8 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
 	return filled;
 }
 
-static struct commit_list *get_merge_bases_many_0(struct commit *one,
+static struct commit_list *get_merge_bases_many_0(struct repository *r,
+						  struct commit *one,
 						  int n,
 						  struct commit **twos,
 						  int cleanup)
@@ -223,7 +224,7 @@ static struct commit_list *get_merge_bases_many_0(struct commit *one,
 	struct commit_list *result;
 	int cnt, i;
 
-	result = merge_bases_many(the_repository, one, n, twos);
+	result = merge_bases_many(r, one, n, twos);
 	for (i = 0; i < n; i++) {
 		if (one == twos[i])
 			return result;
@@ -246,7 +247,7 @@ static struct commit_list *get_merge_bases_many_0(struct commit *one,
 	clear_commit_marks(one, all_flags);
 	clear_commit_marks_many(n, twos, all_flags);
 
-	cnt = remove_redundant(the_repository, rslt, cnt);
+	cnt = remove_redundant(r, rslt, cnt);
 	result = NULL;
 	for (i = 0; i < cnt; i++)
 		commit_list_insert_by_date(rslt[i], &result);
@@ -258,19 +259,19 @@ struct commit_list *get_merge_bases_many(struct commit *one,
 					 int n,
 					 struct commit **twos)
 {
-	return get_merge_bases_many_0(one, n, twos, 1);
+	return get_merge_bases_many_0(the_repository, one, n, twos, 1);
 }
 
 struct commit_list *get_merge_bases_many_dirty(struct commit *one,
 					       int n,
 					       struct commit **twos)
 {
-	return get_merge_bases_many_0(one, n, twos, 0);
+	return get_merge_bases_many_0(the_repository, one, n, twos, 0);
 }
 
 struct commit_list *get_merge_bases(struct commit *one, struct commit *two)
 {
-	return get_merge_bases_many_0(one, 1, &two, 1);
+	return get_merge_bases_many_0(the_repository, one, 1, &two, 1);
 }
 
 /*
-- 
2.19.0

