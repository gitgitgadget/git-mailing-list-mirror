Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6706A1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 21:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbeJLEr2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 00:47:28 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:53200 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJLEr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 00:47:28 -0400
Received: by mail-it1-f202.google.com with SMTP id n132-v6so10773196itn.2
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qKtvbI845QpG4mt5HUfjxux6SgHT7h+YObU2uyY4Oao=;
        b=QcoHEgTzG18BAB/ILwSG3AtLmt5wy/a/MUSrRskVBmjt9vqNlk55nUgyvgWFoq+B8o
         rlIaOZy1YsF/KlqtobMlpnpCJr+BDN4sU225EG11n1jdSgUbALThA9GMZKYdBO1YlLJB
         vpkYrmGvYxOArPbLNRx46Qlf3OSRzPMXKGGyRH+BM7FtP2IYSaiSWSRWXWPJWgKLfnK6
         UfEHIkeSdpZNv11I1Kx6b4rTFntN/DLS+0qkzxB8JTjvJG7uFg5ARgx8t6k4IxqAKy5y
         IttdVQ9WF/eG95NaUjJk4r6FgjZfAhIumKIp0LqcbtvR63p7xt3JZlHvcbgfJaMZmnj5
         Zc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qKtvbI845QpG4mt5HUfjxux6SgHT7h+YObU2uyY4Oao=;
        b=n3a5lahO1+pSuPn+mNtojOjmNZJxiysBoFl89E0Nivxl11Cd5dSbEr1lCqQfQFigvf
         6eKejxWkfVwJo36F8gcxJSRia4siOZFiepZH5AeBbf8Ztx7fTUioHN6NRhyrVyZR5x5/
         wEr6dZjgz9Dh23jkEz97WS2D+IQrEmuksZat6id44citSlnUDptLS6ZE6uW9LlYUGvmS
         vRpKnFi74mrIBOHUwKH+3QiITE/Cs+Zh9AghK4yVDuunfQ3u1gx2aht6bhsigoYOi4KZ
         cs3UoIGzLBGaUavfF2E8RzVkj300P2nZq8JWpBUEGcJpa9E4npHE8uYuVeqPXUDI6JLD
         C/IA==
X-Gm-Message-State: ABuFfojFnra189j7Ef/dp8hDHN/Sd4ioYL+/10GsED1ihI5ciQjLFxSB
        +tuZWy53lsHI69u5oG0p0EDYQH7fPjMN01z0e7ADh31vM2/X5ID0yEYpsKDz00LbOhPmAM0MSMr
        07LH4uJal4to9aDqu2+zzliq+vfa3RG5Wj+mUqrbf5JZCJAlVOtNwSJoOTR5s
X-Google-Smtp-Source: ACcGV61v4ajc8A7LjeQ0lMPkDpGsPVCnYqSBzoa1FO8faxBS5VgLlq+gAnHp5Y1Wx4t94ui1c9gU/t6jjsTX
X-Received: by 2002:a24:4243:: with SMTP id i64-v6mr3017520itb.8.1539292703128;
 Thu, 11 Oct 2018 14:18:23 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:17:46 -0700
In-Reply-To: <20181011211754.31369-1-sbeller@google.com>
Message-Id: <20181011211754.31369-12-sbeller@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 11/19] commit: prepare get_merge_bases to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similarly to previous patches, the get_merge_base functions are used
often in the code base, which makes migrating them hard.

Implement the new functions, prefixed with 'repo_' and hide the old
functions behind a wrapper macro.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c                                | 24 +++++++++++++----------
 commit.h                                | 20 ++++++++++++++-----
 contrib/coccinelle/the_repository.cocci | 26 +++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/commit.c b/commit.c
index b36c2aa0bf..2733bef019 100644
--- a/commit.c
+++ b/commit.c
@@ -1097,23 +1097,27 @@ static struct commit_list *get_merge_bases_many_0(struct repository *r,
 	return result;
 }
 
-struct commit_list *get_merge_bases_many(struct commit *one,
-					 int n,
-					 struct commit **twos)
+struct commit_list *repo_get_merge_bases_many(struct repository *r,
+					      struct commit *one,
+					      int n,
+					      struct commit **twos)
 {
-	return get_merge_bases_many_0(the_repository, one, n, twos, 1);
+	return get_merge_bases_many_0(r, one, n, twos, 1);
 }
 
-struct commit_list *get_merge_bases_many_dirty(struct commit *one,
-					       int n,
-					       struct commit **twos)
+struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
+						    struct commit *one,
+						    int n,
+						    struct commit **twos)
 {
-	return get_merge_bases_many_0(the_repository, one, n, twos, 0);
+	return get_merge_bases_many_0(r, one, n, twos, 0);
 }
 
-struct commit_list *get_merge_bases(struct commit *one, struct commit *two)
+struct commit_list *repo_get_merge_bases(struct repository *r,
+					 struct commit *one,
+					 struct commit *two)
 {
-	return get_merge_bases_many_0(the_repository, one, 1, &two, 1);
+	return get_merge_bases_many_0(r, one, 1, &two, 1);
 }
 
 /*
diff --git a/commit.h b/commit.h
index b8d1f6728f..f311911785 100644
--- a/commit.h
+++ b/commit.h
@@ -213,12 +213,22 @@ struct commit_graft *read_graft_line(struct strbuf *line);
 int register_commit_graft(struct repository *r, struct commit_graft *, int);
 struct commit_graft *lookup_commit_graft(struct repository *r, const struct object_id *oid);
 
-extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2);
-extern struct commit_list *get_merge_bases_many(struct commit *one, int n, struct commit **twos);
-extern struct commit_list *get_octopus_merge_bases(struct commit_list *in);
-
+struct commit_list *repo_get_merge_bases(struct repository *r,
+					 struct commit *rev1,
+					 struct commit *rev2);
+struct commit_list *repo_get_merge_bases_many(struct repository *r,
+					      struct commit *one, int n,
+					      struct commit **twos);
 /* To be used only when object flags after this call no longer matter */
-extern struct commit_list *get_merge_bases_many_dirty(struct commit *one, int n, struct commit **twos);
+struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
+						    struct commit *one, int n,
+						    struct commit **twos);
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define get_merge_bases(r1, r2)           repo_get_merge_bases(the_repository, r1, r2)
+#define get_merge_bases_many(one, n, two) repo_get_merge_bases_many(the_repository, one, n, two)
+#define get_merge_bases_many_dirty(one, n, twos) repo_get_merge_bases_many_dirty(the_repository, one, n, twos)
+#endif
+extern struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 
 /* largest positive number a signed 32-bit integer can contain */
 #define INFINITE_DEPTH 0x7fffffff
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index 7189a7293a..7814f8fa1c 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -35,3 +35,29 @@ expression E;
 + repo_parse_commit(the_repository,
   E)
 
+@@
+expression E;
+expression F;
+@@
+- get_merge_bases(
++ repo_get_merge_bases(the_repository,
+  E, F);
+
+@@
+expression E;
+expression F;
+expression G;
+@@
+- get_merge_bases_many(
++ repo_get_merge_bases_many(the_repository,
+  E, F, G);
+
+@@
+expression E;
+expression F;
+expression G;
+@@
+- get_merge_bases_many_dirty(
++ repo_get_merge_bases_many_dirty(the_repository,
+  E, F, G);
+
-- 
2.19.0

