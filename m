Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CD581F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeJQH3J (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:29:09 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:53515 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJQH3J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:29:09 -0400
Received: by mail-vk1-f201.google.com with SMTP id y199-v6so2800214vkd.20
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=90I3ZaHEDfqV9PlVbEeEV15eRRK2DkNuwP+KtUDdzOI=;
        b=eopI4VH1m2267dXEoJVkrxEA5eyZR3dbTfUqb4Zcg57qwEUB1AYrNQbJZDcKSfNo/b
         JU+KZC+B4mJeqgzbewktJRVoCvmwb0LMN+m19u8VAZQtoFCLsEfrUlxoBQhU52nqdW7c
         pytKlQZ550MN8MFMi4bxVqyy6p2AvURbeC3pgRHVULqp4RCgAOjwt4OKi4jN/BVGOSwC
         1YLA4OEECecA9zzCxXzRlBjTEh13PIgwSYE7/4nfSB6ttGaXgVcJ+4WLhJe8+6kY6+UK
         abipHTCrVoCFzfOGM2AAgZyRK+LG2QKINBahx6X1xPCZFCL9YeyDR3sNADxe06/LXoLj
         HXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=90I3ZaHEDfqV9PlVbEeEV15eRRK2DkNuwP+KtUDdzOI=;
        b=aJ1BnF52KNArwXv9shgBkDgtzPwMM9U/CUn26pJpJ7L3jTFt/FYMmzluMPZZ+6Jt7M
         FXkn0rERQCr29jUtUehyV2MlQ+XUG4ra2q/TCFl+55LrY3bE+9V2ITG5GwDYaxj7/Ghz
         /gkzj4bRQuVcJhMZn+1sYmYKywUYjz6JJX4sCLIZA6xtLks3mPMv5QVvNlbHebqYmp0W
         XedUrWK3W/UvS/MrTj1a+sbUkeyKB1flWsfx6Jtsi8e0uj8EKRxmhjZokCcfoxuNmowU
         +AU8vzRiIx5sbhzKTxziogdX7Wi24UJbPr2yIJ2R+iphfu4wNOJUmsCQ+NdnVoTWNchm
         tkmA==
X-Gm-Message-State: ABuFfojCAlNP7n/I2zoBrfVRF4TMmM34SDoWR1u87P46N+JRPiEXFTQg
        2yjfI4fBNHCLdHZ8OHIZYX5K4hsvwGPvKkR9qrxt+orp0UiXsSs/nyu/oYYeMM1oKi21U6/0GmY
        giCEX19RMJfnHk/JRX93F+bzCNFVeEb+AtfixlqQI5zxw1Tca9a8HCnTb7drm
X-Google-Smtp-Source: ACcGV60tN8aqo8/VYUv0wPCDgzorazla0TRPlm1NdNBY2nUZdMJPjKch5VxxAQ6tjosQJiUUmX/71AHAcWi5
X-Received: by 2002:ab0:2916:: with SMTP id v22mr22302732uap.23.1539732983601;
 Tue, 16 Oct 2018 16:36:23 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:35:43 -0700
In-Reply-To: <20181016233550.251311-1-sbeller@google.com>
Message-Id: <20181016233550.251311-13-sbeller@google.com>
Mime-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 12/19] commit-reach: prepare get_merge_bases to handle
 arbitrary repositories
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
 commit-reach.c                          | 24 +++++++++++++---------
 commit-reach.h                          | 26 +++++++++++++++---------
 contrib/coccinelle/the_repository.cocci | 27 +++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 20 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index df93274966..aa3cde5c8a 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -255,23 +255,27 @@ static struct commit_list *get_merge_bases_many_0(struct repository *r,
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
index 7d313e2975..52667d64ac 100644
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
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index b185fe0a1d..5e037fe428 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
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
2.19.0

