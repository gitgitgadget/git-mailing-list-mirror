Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4D351F97F
	for <e@80x24.org>; Tue,  9 Oct 2018 18:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeJJB7G (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 21:59:06 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:53450 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJJB7G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 21:59:06 -0400
Received: by mail-io1-f73.google.com with SMTP id t22-v6so2219141ioc.20
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 11:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/OyocjDuBAhJCghRcuzEjo9oJ6iiTZEQgXiEohxbzqY=;
        b=bgTOeSaFJujtpk6KuOdhOnJVkldDDLHadQTLoDNpbxZYg8hBjvet7UvTNLsXmIMcCF
         CzxyKfAquhU8KVEsOiBG4gwJRWkvBf+kP3i8Xwfc9TXLUDw8mQKK7+jFCwbZ8na01LM6
         5qbKqzcETP9cAEgsQn2gEzjPV0eyYWmA2D1JEXh9ihGYD0CKHtIIG3CO1q5ENSX44wBI
         ZbjkTTIWeVlKaiJorbRz9pt18sMb3T8e4jEVgxeywNE0GpUzC1QqHwo82Rczt/wHWgNc
         r15m8miGiXlaILyy/U7d4PmRN4BPJ1VOG8E0xcjhqq1yIJUswcJjoLhzfEFF1w13CRbH
         nPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/OyocjDuBAhJCghRcuzEjo9oJ6iiTZEQgXiEohxbzqY=;
        b=Jgx1+KOnFB2UGEEqGarn8YIz1h5swoh29ssVbVaY7yNylx6b/3LxysH3Nq0ijHQxj+
         6N2EHSk3VzV0BlGt9O6t/qHJzcoMoO+uGuW0ls31ijc6pYLi90G5XfSRzQxmMhpBfMk3
         YjFtuaLagpYGDIfjL6F3zOZCuPh6NThTjbcej12rZZA2efZRcVFWUyNuzNwS8oHgwOvO
         1tZaWWNTLZT21lmWOtSKWA+xeJGNFpGm0XCYRjYYKyUsadoISzSbqTRVhgFMS1IIov90
         UtofuVFCfO47ilzWt4bAp6hhsQJGHpHRhW6xc+/993TDm3Gg45hgT96rjHqMFhTaJGiS
         w96g==
X-Gm-Message-State: ABuFfoiJ5nkA//uo3N0bx7zuOZ3Dtdb09pN4eL1sdit0hzi7h0T/pYBu
        EH/Jm/IDON4NiDaKAq6DEPWQBsE9OEa4oucCv0KMIifv1s5speTfYZ9w0Et7Q+DUv9YMAiELXtK
        O9daY8H6ZcF9sE+4um2D3D9YZaVolYFlpi89q3ZfSgj5NZmTeOBYU++mPNSfsolcN6ZCW/756+K
        GI
X-Google-Smtp-Source: ACcGV62SyX0qGn2jDbKpZwvQTQ31vpn48efEeMSBG3zPYCOo8++aoq0qfgZlOXoPR3mOarAV+pHjDjoj9VwGjOJJoDeO
X-Received: by 2002:a24:2153:: with SMTP id e80-v6mr21774887ita.1.1539110446315;
 Tue, 09 Oct 2018 11:40:46 -0700 (PDT)
Date:   Tue,  9 Oct 2018 11:40:37 -0700
In-Reply-To: <20181008214816.42856-1-jonathantanmy@google.com>
Message-Id: <20181009184037.246871-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181008214816.42856-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2] cache-tree: skip some blob checks in partial clone
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peartben@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a partial clone, whenever a sparse checkout occurs, the existence of
all blobs in the index is verified, whether they are included or
excluded by the .git/info/sparse-checkout specification. This
significantly degrades performance because a lazy fetch occurs whenever
the existence of a missing blob is checked.

This is because cache_tree_update() checks the existence of all objects
in the index, whether or not CE_SKIP_WORKTREE is set on them. Teach
cache_tree_update() to skip checking CE_SKIP_WORKTREE objects when the
repository is a partial clone. This improves performance for sparse
checkout and also other operations that use cache_tree_update().

Instead of completely removing the check, an argument could be made that
the check should instead be replaced by a check that the blob is
promised, but for performance reasons, I decided not to do this.
If the user needs to verify the repository, it can be done using fsck
(which will notify if a tree points to a missing and non-promised blob,
whether the blob is included or excluded by the sparse-checkout
specification).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Changes from v1:

After feedback, I restricted this to partial clone. Once restricted, I
agree with Ben that this can be done for all users of
cache_tree_update(), not just unpack-trees, so I have removed the
ability to control the behavior using a flag.

I also took the opportunity to simplify the missing check by using a
variable.
---
 cache-tree.c                     |  6 +++++-
 t/t1090-sparse-checkout-scope.sh | 33 ++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index 5ce51468f0..f210481f9b 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -326,6 +326,7 @@ static int update_one(struct cache_tree *it,
 		unsigned mode;
 		int expected_missing = 0;
 		int contains_ita = 0;
+		int ce_missing_ok;
 
 		path = ce->name;
 		pathlen = ce_namelen(ce);
@@ -355,8 +356,11 @@ static int update_one(struct cache_tree *it,
 			i++;
 		}
 
+		ce_missing_ok = mode == S_IFGITLINK || missing_ok ||
+			(repository_format_partial_clone &&
+			 ce_skip_worktree(ce));
 		if (is_null_oid(oid) ||
-		    (mode != S_IFGITLINK && !missing_ok && !has_object_file(oid))) {
+		    (!ce_missing_ok && !has_object_file(oid))) {
 			strbuf_release(&buffer);
 			if (expected_missing)
 				return -1;
diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-scope.sh
index 25d7c700f6..090b7fc3d3 100755
--- a/t/t1090-sparse-checkout-scope.sh
+++ b/t/t1090-sparse-checkout-scope.sh
@@ -63,4 +63,37 @@ test_expect_success 'return to full checkout of master' '
 	test "$(cat b)" = "modified"
 '
 
+test_expect_success 'in partial clone, sparse checkout only fetches needed blobs' '
+	test_create_repo server &&
+	git clone "file://$(pwd)/server" client &&
+
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	echo a >server/a &&
+	echo bb >server/b &&
+	mkdir server/c &&
+	echo ccc >server/c/c &&
+	git -C server add a b c/c &&
+	git -C server commit -m message &&
+
+	test_config -C client core.sparsecheckout 1 &&
+	test_config -C client extensions.partialclone origin &&
+	echo "!/*" >client/.git/info/sparse-checkout &&
+	echo "/a" >>client/.git/info/sparse-checkout &&
+	git -C client fetch --filter=blob:none origin &&
+	git -C client checkout FETCH_HEAD &&
+
+	git -C client rev-list HEAD \
+		--quiet --objects --missing=print >unsorted_actual &&
+	(
+		printf "?" &&
+		git hash-object server/b &&
+		printf "?" &&
+		git hash-object server/c/c
+	) >unsorted_expect &&
+	sort unsorted_actual >actual &&
+	sort unsorted_expect >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.19.0.271.gfe8321ec05.dirty

