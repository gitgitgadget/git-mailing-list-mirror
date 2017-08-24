Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4268C208DB
	for <e@80x24.org>; Thu, 24 Aug 2017 10:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbdHXKlt (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 06:41:49 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36101 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbdHXKls (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 06:41:48 -0400
Received: by mail-pg0-f68.google.com with SMTP id m7so3342939pga.3
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 03:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5RiGcSHTS9q5A3QRYBY4AoBPuUNcUlxUjRiBfNK+FJg=;
        b=XsmPK6beIn8Aoxikb79W7aXKafaRO/HHfeg5vgSXmvPFTb30vU2JYtQj/ui/M4qAoF
         pLlW17T5ZTt0mtZbQ1Y7OJoVw/EPL1E4gT0dmNd5aK5Qer8SRAyNNnEVccZjGqIWAqeS
         X85daLiAokusKMwmJYnKg32ebUBL5epq19AoGcMKDDNHekBadyv5OIEwHnxYPjD91JNF
         enHK29Hy/Alz2Or0U0UY1wR86/4Cl0YbSfdSEJpammUmc6a8pJEhEebl3AKCKYn1vsGU
         iaBsxgYhnxT7Xg7Q4a02XYwYk3rsv3PG0mSIE3M6Q653+7sIYVYyviwlPWcReoq1mso9
         dskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5RiGcSHTS9q5A3QRYBY4AoBPuUNcUlxUjRiBfNK+FJg=;
        b=pL54kpK4DYIRR84ypXYd8IOJTrs1WKdsvcB7LuHS/Np/F07TcBLTuthWW29Es8R2vn
         Rm8isi7tCER2P/a0W+nlA4dyUEiMB9TAf9K26eWq+DQxXBmTphASsDNKLJ104EDLrU0H
         nZHlPuywR/tSL9BBcNjFXV3jBQaLKs7WGQk//VpKWzSWkA9pQlLm/MapMjvFCiwiZp8K
         yZkCyC41pSQfbBHs5cM0h9MP2MWsKthVNy+77q0F4oJhWWIppQD4l8uhRMqtYAA+bCfh
         6o4LQ5u9WSR92opismu4WDuQaqEFlnjNvdyaQpkFckItoNkuIZsdCEs/YC+Qy2YN733u
         DYiQ==
X-Gm-Message-State: AHYfb5g/R3+sAtw7JweWX8zR39bkk99wXd9rXQA8D8T0lhtmJia8bDdo
        XtUcxsKu1mTOjQb5
X-Received: by 10.84.217.211 with SMTP id d19mr6497708plj.121.1503571307420;
        Thu, 24 Aug 2017 03:41:47 -0700 (PDT)
Received: from ash ([115.72.183.215])
        by smtp.gmail.com with ESMTPSA id 66sm5785564pgh.32.2017.08.24.03.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Aug 2017 03:41:46 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 24 Aug 2017 17:41:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, nish.aravamudan@canonical.com,
        me@ikke.info,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] Fix branch renaming not updating HEADs correctly
Date:   Thu, 24 Aug 2017 17:41:24 +0700
Message-Id: <20170824104124.6263-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170823201334.bz42s6t5ti4jdaqm@pitfall>
References: <20170823201334.bz42s6t5ti4jdaqm@pitfall>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two bugs that sort of work together and cause problems. Let's
start with one in replace_each_worktree_head_symref.

Before fa099d2322 (worktree.c: kill parse_ref() in favor of
refs_resolve_ref_unsafe() - 2017-04-24), this code looks like this:

    if (strcmp(oldref, worktrees[i]->head_ref))
            continue;
    set_worktree_head_symref(...);

After fa099d2322, it is possible that head_ref can be NULL. However, the
updated code takes the wrong exit. In the error case (NULL head_ref), we
should "continue;" to the next worktree. The updated code makes us
_skip_ "continue;" and update HEAD anyway.

The NULL head_ref is triggered by the second bug in add_head_info (in
the same commit). With the flag RESOLVE_REF_READING, resolve_ref_unsafe()
will abort if it cannot resolve the target ref. For orphan checkouts,
HEAD always points to an unborned branch, resolving target ref will
always fail. Now we have NULL head_ref. Now we always update HEAD.

Correct the logic in replace_ function so that we don't accidentally
update HEAD on error. As it turns out, correcting the logic bug above
breaks branch renaming completely, thanks to the second bug.

"git branch -[Mm]" does two steps (on a normal checkout, no orphan!):

- rename the branch on disk (e.g. refs/heads/abc to refs/heads/def)
- update HEAD if it points to the branch being renamed.

At the second step, since the branch pointed to by HEAD (e.g. "abc") no
longer exists on disk, we run into a temporary orphan checkout situation
that has been just corrected to _not_ update HEAD. But we need to update
HEAD since it's not actually an orphan checkout. We need to update HEAD
to move out of that orphan state.

Correct add_head_info(), remove RESOLVE_REF_READING flag. With the flag
gone, we should always return good "head_ref" in orphan checkouts (either
temporary or permanent). With good head_ref, things start to work again.

Noticed-by: Nish Aravamudan <nish.aravamudan@canonical.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 branch.c          |  5 +++--
 t/t3200-branch.sh | 13 +++++++++++++
 worktree.c        |  2 +-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/branch.c b/branch.c
index 36541d05cd..86360d36b3 100644
--- a/branch.c
+++ b/branch.c
@@ -357,8 +357,9 @@ int replace_each_worktree_head_symref(const char *oldref, const char *newref,
 
 		if (worktrees[i]->is_detached)
 			continue;
-		if (worktrees[i]->head_ref &&
-		    strcmp(oldref, worktrees[i]->head_ref))
+		if (!worktrees[i]->head_ref)
+			continue;
+		if (strcmp(oldref, worktrees[i]->head_ref))
 			continue;
 
 		refs = get_worktree_ref_store(worktrees[i]);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index dd37ac47c5..902cb87ea8 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -162,6 +162,19 @@ test_expect_success 'git branch -M baz bam should add entries to .git/logs/HEAD'
 	grep "^0\{40\}.*$msg$" .git/logs/HEAD
 '
 
+test_expect_success 'git branch -M should leave orphaned HEAD alone' '
+	git init orphan &&
+	(
+		cd orphan &&
+		test_commit initial &&
+		git checkout --orphan lonely &&
+		grep lonely .git/HEAD &&
+		test_path_is_missing .git/refs/head/lonely &&
+		git branch -M master mistress &&
+		grep lonely .git/HEAD
+	)
+'
+
 test_expect_success 'resulting reflog can be shown by log -g' '
 	oid=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
diff --git a/worktree.c b/worktree.c
index e28ffbeb09..c0c5a2b373 100644
--- a/worktree.c
+++ b/worktree.c
@@ -30,7 +30,7 @@ static void add_head_info(struct worktree *wt)
 
 	target = refs_resolve_ref_unsafe(get_worktree_ref_store(wt),
 					 "HEAD",
-					 RESOLVE_REF_READING,
+					 0,
 					 wt->head_sha1, &flags);
 	if (!target)
 		return;
-- 
2.11.0.157.gd943d85

