Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8A5720A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbeLOAKP (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:10:15 -0500
Received: from mail-oi1-f201.google.com ([209.85.167.201]:50379 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729985AbeLOAKP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:10:15 -0500
Received: by mail-oi1-f201.google.com with SMTP id u63so3438961oie.17
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SNdzTqvEPRUuy2MlNDNeLQoA3wta3rvPiVpwNcE1FR0=;
        b=rALuuXdAIpxuYEAZ6bqxb2Uh16DF7qsgiyK2i4JcMwzKGWA3P37ok89+Zljd1Duay1
         FjXlgTZo4vmiUQOYhH3rdyPQqaqcWjL6Tkt1NmqeWnlU8OVwu7Vrdx5AN5oLOX6uz1Gr
         XLuSpBAAb2QTjcr2AN804/87AuDHMqcG60RnUg6UA0O0e8RoPH1qc6eU+GA+Rcr2lCDT
         2qS6/HQ0eJZ8sUh9VNdN4E3+YuwdLhDcPHGV7IbTHuXSESpwD1IUxz1DupBmXZWM0FM3
         nHhT05hYjalp2hPNKBCRfqXIBbZi+Dd2Qk8UKmzZtq0ynAz627S2Kg4h/C1QmJVwYg02
         PC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SNdzTqvEPRUuy2MlNDNeLQoA3wta3rvPiVpwNcE1FR0=;
        b=SOPiLdJh2zeZzmd8s0it5jzxW1CgxDZ/wMM3m8M8dNCd/HmQ1xZuo3bfWldLes8cWl
         Qsp6saEMtUIUYsSeCNb2pTU/h76UW3ETLPjTIKpL6mmHPMTwMHrSClvmCIqmNgJDyOkg
         p/GPu9XkGXz9tQLl9ZbsRvJYhSYpVl/NZpdnzQpYarkhFarK//Kmhv1kka772xi/G0wd
         xpoUaTRybK6OPqeVVmHrdZUxTz22yH0QDcVlPkG0Fbl8zy0ScoUG0cji+dJXFVP03YT2
         +6PlWmA9kXFgh82AWRtXCUU3N+Da3OSUpoh7ztFDDS7NWyshru71WyKc0gtXRSXgx3hD
         NwWA==
X-Gm-Message-State: AA+aEWZrEMbxhVqvh4MjhCUu3Np6gAVKcLhR6/sM2yAad67ybt2gaCRz
        SSx1AA6eXgQdt6J30c3ChW8r8HbjFq2QIhXJo2KZX0Lim/YK/OZyv+cFC3wnW7cuif6Tc0T3JvD
        VIykD2W1RmkagzGRLnkAAPM1tepy/cjwfGD9UsgfjwZg9/aBxsKK0uQTAj+S0
X-Google-Smtp-Source: AFSGD/Wm9o/vwbq05BpFYFEW+pZw/14+mjpA6gWIcFH6oI1RUIZVAMydqvpRmOazM4DsV+M+wzxoGZYUnboV
X-Received: by 2002:aca:47c9:: with SMTP id u192mr4172131oia.14.1544832614438;
 Fri, 14 Dec 2018 16:10:14 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:09:31 -0800
In-Reply-To: <20181215000942.46033-1-sbeller@google.com>
Message-Id: <20181215000942.46033-13-sbeller@google.com>
Mime-Version: 1.0
References: <20181215000942.46033-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 12/23] commit-reach: prepare get_merge_bases to handle any repo
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit-reach.c                                | 24 ++++++++++-------
 commit-reach.h                                | 26 ++++++++++++-------
 .../coccinelle/the_repository.pending.cocci   | 26 +++++++++++++++++++
 3 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index b3b1f62aba..657a4e9b5a 100644
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
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index b185fe0a1d..f6c2915a4e 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -64,3 +64,29 @@ expression E;
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
-- 
2.20.0.405.gbc1bbc6f85-goog

