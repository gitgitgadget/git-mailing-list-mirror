Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F5C820136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934466AbdBQOUz (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:20:55 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35609 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934383AbdBQOUu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:20:50 -0500
Received: by mail-pg0-f66.google.com with SMTP id y6so3967609pgy.2
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OPo8ItH07UUm5UqGzeU2Bho7Q6PecDREfiGovttpzmE=;
        b=LneT7Nea9jnUZlA7MPmdTQhzTGJwUsceXtmhqdQqJrg6NFn8gij7t6eO4KKXOVNXIg
         7A6ENeXF8/rGvKFm8/WIig6UBdQYsjATsy4SQGLpeBnnOYxncKxjV1JAmQt8IDUqujhz
         gPRvMWs+pbtcxxixghrExtwnGUY4S8aF9qHfCSxEB2pLF3VAs9+CPgDU4MDoYKzpMFh9
         DUG3u1I2uf081RjorTXjyMh/C9XWAjciZ8ize8GLyQt3aru+ya5+uqI4/pvAh1/+BtLt
         ZDjv9URIP1ehFVXviDYqu5bACEgmsFWY0dYcOKyJmo5SqEht7fXEfVhvSixg4JasgsjX
         KIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OPo8ItH07UUm5UqGzeU2Bho7Q6PecDREfiGovttpzmE=;
        b=oP/8wV9QTbHDd9uNsZ/9L3GG6MYOrWoaiBW7WjGSX9KUg25imHXP1Qif3a65kiHrBw
         EY9W9ASvhRdgmBQ8n6LUduq8WTcj1+mqDg4UdG2+yVeGfTW/Kni9tXfnmfPR8G5q+ZxQ
         pLVK7oxSeMYWZ0oaJ6GbIEl3XgUU83/PFk5pQE1xqRGeuuEat2MViwVTDdlM+QEfaNS8
         FYEXNnMmWLpql73wkhW81hlzCS1cirJgwhuUvGkuw5aL2S/1bB/iIeHBzE3cMrV+mque
         +zc1rRVv5XeEifr5SqZuOK7FcBsP5jdF272blCVik2ZpM9SWXaR7BdYVmC1prlFbrzBL
         lBLw==
X-Gm-Message-State: AMke39nO6M237OrH6NgmXXEqIDfRoRjGupWHZFYi8Z8g9n3LyNAuZYTqS5B3YXlg+S6iUw==
X-Received: by 10.98.50.66 with SMTP id y63mr9736408pfy.21.1487341244718;
        Fri, 17 Feb 2017 06:20:44 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id d69sm20092986pfd.11.2017.02.17.06.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:20:44 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:20:39 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/15] revision.c: --reflog add HEAD reflog from all worktrees
Date:   Fri, 17 Feb 2017 21:19:07 +0700
Message-Id: <20170217141908.18012-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217141908.18012-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note that add_other_reflogs_to_pending() is a bit inefficient, since
it scans reflog for all refs of each worktree, including shared refs,
so the shared ref's reflog is scanned over and over again.

We could update refs API to pass "per-worktree only" flag to avoid
that. But long term we should be able to obtain a "per-worktree only"
ref store and would need to revert the changes in reflog iteration
API. So let's just wait until then.

add_reflogs_to_pending() is called by reachable.c so by default "git
prune" will examine reflog from all worktrees.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c       | 28 +++++++++++++++++++++++++++-
 t/t5304-prune.sh | 16 ++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 8ee929cef..ecfd6fea6 100644
--- a/revision.c
+++ b/revision.c
@@ -1134,6 +1134,7 @@ struct all_refs_cb {
 	int warned_bad_reflog;
 	struct rev_info *all_revs;
 	const char *name_for_errormsg;
+	struct ref_store *refs;
 };
 
 int ref_excluded(struct string_list *ref_excludes, const char *path)
@@ -1169,6 +1170,7 @@ static void init_all_refs_cb(struct all_refs_cb *cb, struct rev_info *revs,
 {
 	cb->all_revs = revs;
 	cb->all_flags = flags;
+	cb->refs = NULL;
 }
 
 void clear_ref_exclusion(struct string_list **ref_excludes_p)
@@ -1237,17 +1239,41 @@ static int handle_one_reflog(const char *path, const struct object_id *oid,
 	struct all_refs_cb *cb = cb_data;
 	cb->warned_bad_reflog = 0;
 	cb->name_for_errormsg = path;
-	for_each_reflog_ent(path, handle_one_reflog_ent, cb_data);
+	refs_for_each_reflog_ent(cb->refs, path,
+				 handle_one_reflog_ent, cb_data);
 	return 0;
 }
 
+static void add_other_reflogs_to_pending(struct all_refs_cb *cb)
+{
+	struct worktree **worktrees, **p;
+
+	worktrees = get_worktrees(0);
+	for (p = worktrees; *p; p++) {
+		struct worktree *wt = *p;
+
+		if (wt->is_current)
+			continue;
+
+		cb->refs = get_worktree_ref_store(wt);
+		refs_for_each_reflog(cb->refs,
+				     handle_one_reflog,
+				     cb);
+	}
+	free_worktrees(worktrees);
+}
+
 void add_reflogs_to_pending(struct rev_info *revs, unsigned flags)
 {
 	struct all_refs_cb cb;
 
 	cb.all_revs = revs;
 	cb.all_flags = flags;
+	cb.refs = get_main_ref_store();
 	for_each_reflog(handle_one_reflog, &cb);
+
+	if (!revs->single_worktree)
+		add_other_reflogs_to_pending(&cb);
 }
 
 static void add_cache_tree(struct cache_tree *it, struct rev_info *revs,
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 683bdb031..6694c19a1 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -304,4 +304,20 @@ test_expect_success 'prune: handle HEAD in multiple worktrees' '
 	test_cmp third-worktree/blob actual
 '
 
+test_expect_success 'prune: handle HEAD reflog in multiple worktrees' '
+	git config core.logAllRefUpdates true &&
+	echo "lost blob for third-worktree" >expected &&
+	(
+		cd third-worktree &&
+		cat ../expected >blob &&
+		git add blob &&
+		git commit -m "second commit in third" &&
+		git reset --hard HEAD^
+	) &&
+	git prune --expire=now &&
+	SHA1=`git hash-object expected` &&
+	git -C third-worktree show "$SHA1" >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.11.0.157.gd943d85

