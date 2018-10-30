Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C96351F453
	for <e@80x24.org>; Tue, 30 Oct 2018 22:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbeJaHEW (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:04:22 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:45718 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbeJaHET (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:04:19 -0400
Received: by mail-pg1-f202.google.com with SMTP id q143-v6so10053331pgq.12
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=D60Fa8xjxoteOpd09eFgbkBLqSxTQwO03sBuEGOWa58=;
        b=GoNWPkHmiqD3T3IXOSBWUiRVqBokVHv//U6ANW66p8zU8ccLYNhbR2h8W2fFBT++tB
         ZBC7TTLHMBjSo84apiTWojaBuHau99XjNCPs5gOOtZ2Xy+GNOhCUZhTHBGyFGNMpVpnJ
         v9AqV7cBsbL0ziW/psUBJSYZ2au+F0lsOkhBpWylbuwDSjriaFSoosV3UOaII6Qc5Qcm
         oM4iB8JXGOMPrJ2KgRg6+F0/nOMWWTjCnTJYFmIlKTVN0xi9+2YMK7vruF3r2SipAx3v
         vE6ceYTcci/p+Z9x3FjPL5HPL68TpkuQg0DbyglRVBzFzEefh6d085Qu3CX4S+RJTqV5
         IQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D60Fa8xjxoteOpd09eFgbkBLqSxTQwO03sBuEGOWa58=;
        b=aL94wPCcc2eGvx928aKuiqQnl46UZb2uOMPjONWyHu71ej6hSiTKUJb5u5rCFsZVW4
         VWGCLjl/du+Oo6rBaguNqucvtVS8ZuxlzY1ZCcyzzFWNXm7xm8aOH6st5dYfU57Xwj3p
         /EUCfHBBZPqwkmhwK2VOzmdF8xAyrHPDDsYOay7T2kAuMw4eMRpIfi2Ct2gCTtzliAY/
         hikOU7OfrX65wg2GBifKhBcIfFPk+Go1e/kTRWzotQ5aBy+9Bni9ePNiJAtZP6/ZFc8k
         4RoidbHGrOVfuVUsjXh/zxQO5Cfm6ctBOoL88cQKRJ+mIRh1amjRxOgpFPz25PSsFmfZ
         neQA==
X-Gm-Message-State: AGRZ1gI4/PfgHatG4bkkWV9dQFHNdJuItbOeo0XkG1EEgNca322zq61t
        jxgNK39XjKVuLxR23AJJCrV9kY9Nff8lt+FIXqn69U/pc44O8tgRyRCqWKC3t3TWgfQFn+9SUbI
        MQsaOznMuwFq/Dm9mZkamnbLT9GRuQxw1t/yoLU5rio4OLPjkDttgVYhjdUAK
X-Google-Smtp-Source: AJdET5dqzNoM8KbyYSrnbZJHSxmeUKtOSWrBlbO2ywFJkX3HJpbtJh0YF9E0KJk/oL9Xobb+9y0c+5Hi8vrp
X-Received: by 2002:a17:902:8f94:: with SMTP id z20-v6mr204919plo.142.1540937344177;
 Tue, 30 Oct 2018 15:09:04 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:08:06 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-14-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 13/24] commit-reach: prepare get_merge_bases to handle
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
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
 commit-reach.c                                | 24 ++++++++++-------
 commit-reach.h                                | 26 +++++++++++-------
 .../coccinelle/the_repository.pending.cocci   | 27 +++++++++++++++++++
 3 files changed, 57 insertions(+), 20 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index bf7a513991..3be5526957 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -258,23 +258,27 @@ static struct commit_list *get_merge_bases_many_0(struct repository *r,
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
diff --git a/commit-reach.h b/commit-reach.h
index 122a23a24d..c647447263 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -8,17 +8,23 @@ struct commit_list;
 struct contains_cache;
 struct ref_filter;
 
-struct commit_list *get_merge_bases_many(struct commit *one,
-					 int n,
-					 struct commit **twos);
-struct commit_list *get_merge_bases_many_dirty(struct commit *one,
-					       int n,
-					       struct commit **twos);
-struct commit_list *get_merge_bases(struct commit *one, struct commit *two);
-struct commit_list *get_octopus_merge_bases(struct commit_list *in);
-
+struct commit_list *repo_get_merge_bases(struct repository *r,
+					 struct commit *rev1,
+					 struct commit *rev2);
+struct commit_list *repo_get_merge_bases_many(struct repository *r,
+					      struct commit *one, int n,
+					      struct commit **twos);
 /* To be used only when object flags after this call no longer matter */
-struct commit_list *get_merge_bases_many_dirty(struct commit *one, int n, struct commit **twos);
+struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
+						    struct commit *one, int n,
+						    struct commit **twos);
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define get_merge_bases(r1, r2)           repo_get_merge_bases(the_repository, r1, r2)
+#define get_merge_bases_many(one, n, two) repo_get_merge_bases_many(the_repository, one, n, two)
+#define get_merge_bases_many_dirty(one, n, twos) repo_get_merge_bases_many_dirty(the_repository, one, n, twos)
+#endif
+
+struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 
 int is_descendant_of(struct commit *commit, struct commit_list *with_commit);
 int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit **reference);
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index b185fe0a1d..5e037fe428 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -64,3 +64,30 @@ expression E;
 - parse_commit(
 + repo_parse_commit(the_repository,
   E)
+
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
2.19.1.930.g4563a0d9d0-goog

