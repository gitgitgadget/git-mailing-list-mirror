Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9C6C433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8ABA206DB
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="urvWeY27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgFENAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgFENAm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 09:00:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12222C08C5C4
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 06:00:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d128so9030892wmc.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 06:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=5y12Vv4tcA8nt2cWBn1HR41BrCvwx+6I06Aj7OsEFAo=;
        b=urvWeY27FZhTnEmKDP/589NBCKKjCXGlZjwvKXezLTcEnmhHF6QSywuVDw0bh0zym2
         Zp7XMsMhfTp3nqTcNi+dAfqSn4dloP7mdqnO+YOkprFiuzYUnlWyfP9LANanb+cRaRuc
         pk9sfb58nHjP7UOcXlzVNreX1ap3/hA/+914nuJrepnO3W9tp2RUsxJgykXBMBLgG309
         m4NE+imVG30PokMMmXVQuxQBffCl5vDTTnLK0gbqqZKK47rttLpBjgpvT7KAdsUBh3r8
         8E5IHP86Fk9/xSLk+B2YPzEGsDueQBgk86aR6HF2IxsqWx2/NiAQ9kBt4rY7YyoDsEjT
         K08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=5y12Vv4tcA8nt2cWBn1HR41BrCvwx+6I06Aj7OsEFAo=;
        b=jPbm7ufH2/h5B3HVbx3npIPkWznHNgZeAn5o5G6WVHQUfefhmGa2UDj/gbKkaPh/hH
         fdUjyCxp0TckQM+xeyGKhGIupBMbrzq+8XgMmCXstRCFWlm6XDrvNC396ERNVm9mNNGY
         CPHzDYfcuEk0PpijRAukVf6723ZU2arQqmclv7ynOd9S/DSlk9gsehrRk5UFqPe3kE2L
         7n4WoqN02E+KRpEx7hIj8SV0gAy7kTQKcR2K4k805ZuVvI4y8yNlIs01uWnHM0WymhJH
         rGRnXz516OX+bTyhbUjAxvUfM7zSmSZoVTMPWG1Akvb8U/gqBjyZYZZIFasRypBscU9j
         +VMQ==
X-Gm-Message-State: AOAM533SVf7tMjvSKhrmZrEM3z8F5sLegZ8xyI2Rdfj3aTSOlWrIKbUj
        4i4IWVrc4eN8vNVyA1KscqM1mO1o
X-Google-Smtp-Source: ABdhPJyNKYqEUtAb+fx+DfifKrXjBhRinoLqw3nBMrRTV6rLohZKD7wEF0RWI7Kzopkof0vhMbyY9Q==
X-Received: by 2002:a1c:3d05:: with SMTP id k5mr2607098wma.160.1591362040424;
        Fri, 05 Jun 2020 06:00:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z132sm12232874wmc.29.2020.06.05.06.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 06:00:39 -0700 (PDT)
Message-Id: <1a70ff05aea11cb479d9ba7529ccad6dcd79e23d.1591362033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.650.git.1591362032.gitgitgadget@gmail.com>
References: <pull.650.git.1591362032.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 05 Jun 2020 13:00:27 +0000
Subject: [PATCH 05/10] diff.h: drop diff_tree_oid() & friends' return value
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, jnareb@gmail.com,
        peff@peff.net, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

ll_diff_tree_oid() has only ever returned 0 [1], so it's return value
is basically useless.  It's only caller diff_tree_oid() has only ever
returned the return value of ll_diff_tree_oid() as-is [2], so its
return value is just as useless.  Most of diff_tree_oid()'s callers
simply ignore its return value, except:

  - diff_root_tree_oid() is a thin wrapper around diff_tree_oid() and
    returns with its return value, but all of diff_root_tree_oid()'s
    callers ignore its return value.

  - rev_compare_tree() and rev_same_tree_as_empty() do look at the
    return value in a condition, but, since the return value is always
    0, the former's < 0 condition is never fulfilled, while the
    latter's >= 0 condition is always fulfilled.

So let's drop the return value of ll_diff_tree_oid(), diff_tree_oid()
and diff_root_tree_oid(), and drop those conditions from
rev_compare_tree() and rev_same_tree_as_empty() as well.

[1] ll_diff_tree_oid() and its ancestors have been returning only 0
    ever since it was introduced as diff_tree() in 9174026cfe (Add
    "diff-tree" program to show which files have changed between two
    trees., 2005-04-09).
[2] diff_tree_oid() traces back to diff-tree.c:main() in 9174026cfe as
    well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 diff.h      | 10 +++++-----
 revision.c  |  9 +++------
 tree-diff.c | 30 ++++++++++++++----------------
 3 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/diff.h b/diff.h
index 9443dc1b003..e0c0af6286b 100644
--- a/diff.h
+++ b/diff.h
@@ -431,11 +431,11 @@ struct combine_diff_path *diff_tree_paths(
 	struct combine_diff_path *p, const struct object_id *oid,
 	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt);
-int diff_tree_oid(const struct object_id *old_oid,
-		  const struct object_id *new_oid,
-		  const char *base, struct diff_options *opt);
-int diff_root_tree_oid(const struct object_id *new_oid, const char *base,
-		       struct diff_options *opt);
+void diff_tree_oid(const struct object_id *old_oid,
+		   const struct object_id *new_oid,
+		   const char *base, struct diff_options *opt);
+void diff_root_tree_oid(const struct object_id *new_oid, const char *base,
+			struct diff_options *opt);
 
 struct combine_diff_path {
 	struct combine_diff_path *next;
diff --git a/revision.c b/revision.c
index cbf4b61aa67..c644c660917 100644
--- a/revision.c
+++ b/revision.c
@@ -791,9 +791,7 @@ static int rev_compare_tree(struct rev_info *revs,
 
 	tree_difference = REV_TREE_SAME;
 	revs->pruning.flags.has_changes = 0;
-	if (diff_tree_oid(&t1->object.oid, &t2->object.oid, "",
-			   &revs->pruning) < 0)
-		return REV_TREE_DIFFERENT;
+	diff_tree_oid(&t1->object.oid, &t2->object.oid, "", &revs->pruning);
 
 	if (!nth_parent)
 		if (bloom_ret == 1 && tree_difference == REV_TREE_SAME)
@@ -804,7 +802,6 @@ static int rev_compare_tree(struct rev_info *revs,
 
 static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
 {
-	int retval;
 	struct tree *t1 = get_commit_tree(commit);
 
 	if (!t1)
@@ -812,9 +809,9 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
 
 	tree_difference = REV_TREE_SAME;
 	revs->pruning.flags.has_changes = 0;
-	retval = diff_tree_oid(NULL, &t1->object.oid, "", &revs->pruning);
+	diff_tree_oid(NULL, &t1->object.oid, "", &revs->pruning);
 
-	return retval >= 0 && (tree_difference == REV_TREE_SAME);
+	return tree_difference == REV_TREE_SAME;
 }
 
 struct treesame_state {
diff --git a/tree-diff.c b/tree-diff.c
index f3d303c6e54..6ebad1a46f3 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -29,9 +29,9 @@ static struct combine_diff_path *ll_diff_tree_paths(
 	struct combine_diff_path *p, const struct object_id *oid,
 	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt);
-static int ll_diff_tree_oid(const struct object_id *old_oid,
-			    const struct object_id *new_oid,
-			    struct strbuf *base, struct diff_options *opt);
+static void ll_diff_tree_oid(const struct object_id *old_oid,
+			     const struct object_id *new_oid,
+			     struct strbuf *base, struct diff_options *opt);
 
 /*
  * Compare two tree entries, taking into account only path/S_ISDIR(mode),
@@ -679,9 +679,9 @@ static void try_to_follow_renames(const struct object_id *old_oid,
 	q->nr = 1;
 }
 
-static int ll_diff_tree_oid(const struct object_id *old_oid,
-			    const struct object_id *new_oid,
-			    struct strbuf *base, struct diff_options *opt)
+static void ll_diff_tree_oid(const struct object_id *old_oid,
+			     const struct object_id *new_oid,
+			     struct strbuf *base, struct diff_options *opt)
 {
 	struct combine_diff_path phead, *p;
 	pathchange_fn_t pathchange_old = opt->pathchange;
@@ -697,29 +697,27 @@ static int ll_diff_tree_oid(const struct object_id *old_oid,
 	}
 
 	opt->pathchange = pathchange_old;
-	return 0;
 }
 
-int diff_tree_oid(const struct object_id *old_oid,
-		  const struct object_id *new_oid,
-		  const char *base_str, struct diff_options *opt)
+void diff_tree_oid(const struct object_id *old_oid,
+		   const struct object_id *new_oid,
+		   const char *base_str, struct diff_options *opt)
 {
 	struct strbuf base;
-	int retval;
 
 	strbuf_init(&base, PATH_MAX);
 	strbuf_addstr(&base, base_str);
 
-	retval = ll_diff_tree_oid(old_oid, new_oid, &base, opt);
+	ll_diff_tree_oid(old_oid, new_oid, &base, opt);
 	if (!*base_str && opt->flags.follow_renames && diff_might_be_rename())
 		try_to_follow_renames(old_oid, new_oid, &base, opt);
 
 	strbuf_release(&base);
-
-	return retval;
 }
 
-int diff_root_tree_oid(const struct object_id *new_oid, const char *base, struct diff_options *opt)
+void diff_root_tree_oid(const struct object_id *new_oid,
+			const char *base,
+			struct diff_options *opt)
 {
-	return diff_tree_oid(NULL, new_oid, base, opt);
+	diff_tree_oid(NULL, new_oid, base, opt);
 }
-- 
gitgitgadget

