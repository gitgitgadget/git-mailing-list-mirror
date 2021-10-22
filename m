Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D05FC433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 02:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CC376138B
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 02:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhJVCag (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 22:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbhJVCae (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 22:30:34 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09994C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 19:28:17 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id q13so5011639uaq.2
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 19:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SNtVqQ65FFmxlYHZ2cqK+5Q1xgZP3DXocujjOuY2sP0=;
        b=NKZ5Vv/XYTd332J9/c13FcTF4PHyP7mpuyXsPPZELR/2hBTakKN6xGqn4nmudS9by/
         zrBbYUXQLqRvvLNH2ySuiicD5xrqA5X5QjhGDz0D2PyUlpVNqXQLz9n7BiVK3iXYKvXi
         Njv6Xcp5nFiWxW3zB9Q6UHHffpw1sH8rgYL+D6Yo4SA/rkew4x64Iao0Gc9w5+kWTVP2
         UnlM3OjipdjdqXGhODRtQcs9Uj25VDiBBB/XKfSp2DhslgkPndZO+RPANfkCFGySy1HW
         XiEN0ErGIYGidAF6c7pmWkRZ1+2Ru6mSpQZ40ZhuHhWb/qySlXlAhPxbGzSzQgD5OVlF
         a38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SNtVqQ65FFmxlYHZ2cqK+5Q1xgZP3DXocujjOuY2sP0=;
        b=rngfELP3GKyG0tJfCLvLgkEIUymlICpNVUepxZjv8FyTZg8ik9OkPQV8GKcdCFRhKd
         l2ladk00LIiOhL+bDu2VqMosGBb1q3CgjZT4kbAsTdT4FC6ZyGHJgLF6wEY8FJsJ0o2R
         U50Xk6Z1Mx8Nu44RBVJbZEf4Bqut71u1kD46GiA+ABEXbB0GnKvv8IwUlKjQW/xqIx8K
         fCbkFbohzlXM7KvxvxP09GDxBwe9RCNSQo4/NdY30S2c4894rCVrXqWk/pYu48pOnDeL
         idAuL68SpTr/KTile938QQMWVJeSQFT5HGupCA9S8KIj6fGOn6FbHB8oX4zFqAquI81S
         F7cw==
X-Gm-Message-State: AOAM531u1a7riUBEmIj7Wm9rucdzKWb/QsfPBbrSA2v/UB2sRXVcRU+V
        Lmn9dBFI6oKHf3H0wkXx9F+nZg==
X-Google-Smtp-Source: ABdhPJxPNi6qna+96z7nVExHfulWYRa0kqzkf41/ftfgNyXWV70j6OiW2M0/QLIqVqGpQNRh4/dy4Q==
X-Received: by 2002:a67:4307:: with SMTP id q7mr12032758vsa.54.1634869695693;
        Thu, 21 Oct 2021 19:28:15 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.116.19])
        by smtp.gmail.com with ESMTPSA id v1sm4335905uac.18.2021.10.21.19.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 19:28:15 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Sean Christopherson <seanjc@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        stolee@gmail.com, vdye@github.com, derrickstolee@github.com,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Subject: [RFC PATCH] add|rm|mv: fix bug that prevent the update of non-sparse
Date:   Thu, 21 Oct 2021 23:28:08 -0300
Message-Id: <80b5ba61861193daf7132aa64b65fc7dde90dacb.1634866698.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <YW3nAKAUj/HF15OR@google.com>
References: <YW3nAKAUj/HF15OR@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 18, 2021 at 6:28 PM Sean Christopherson <seanjc@google.com> wrote:
>
> $ cat .git/info/sparse-checkout
> !arch/*
> !tools/arch/*
> !virt/kvm/arm/*
> /*
> arch/.gitignore
> arch/Kconfig
> arch/x86
> tools/arch/x86
> tools/include/uapi/linux/kvm.h
> !Documentation
> !drivers
>
> $ git read-tree -mu HEAD
>
> $ rm arch/x86/kvm/x86.c
[...]
> $ git add arch/x86
> The following paths and/or pathspecs matched paths that exist
> outside of your sparse-checkout definition, so will not be
> updated in the index:
> arch/x86

I think the problem may be that we are performing pattern matching
slightly different in add, mv, and rm, in comparison to "git
sparse-checkout". On "git sparse-checkout init" (or reapply), we call
clear_ce_flags() which calls path_matches_pattern_list() for each
component of the working tree paths. If the full path gives a match
result of UNDECIDED, we recursively try to use the match result from
the parent dir (or NOT_MATCHED if we reach the top with UNDECIDED).

In Sean's example, we get UNDECIDED for "arch/x86/kvm/x86.c", but
"arch/x86" gives MATCHED, so we end up using that for the full path.

However, in add|mv|rm we only call path_matches_pattern_list() for the
full path and get UNDECIDED, which we consider the same as NOT_MATCHED,
and end up disallowing the path update operation with a warning message.

The commands do work if we replace the sparsity pattern "arch/x86" with
"arch/x86/" (with a trailing slash), but note that it only works
because the pattern is relative to the root (see dir.c:1297). If we
change it to "x86/", it would no longer work.

So far, the only way I could think of to fix this would be to perform
pattern matching for the leading components of the paths too. That
doesn't seem very nice, though, as it can probably be quite expensive...
But here is a patch for discussion:

-- >8 --
Subject: [RFC PATCH] add|rm|mv: fix bug that prevent the update of non-sparse dirs

These three commands recently learned to avoid updating paths that do
not match the sparse-checkout patterns even if they are missing the
SKIP_WORKTREE bit. This is done using path_in_sparse_checkout(), which
tries to match the path with the current set of sparsity rules using
path_matches_pattern_list(). This is similar to what clear_ce_flags()
does when we run "git sparse-checkout init" or "git sparse-checkout
reapply". But note that clear_ce_flags() has a recursive behavior,
calling path_matches_pattern_list() for each component in a path,
whereas path_in_sparse_checkout() only calls it for the full path. This
makes the function miss matches such as the one between path "a/b/c" and
the pattern "b/". So if the user has the sparsity rules "!/a" and "b/",
for example, add, rm, and mv will fail to update the path "a/b/c" and
end up displaying a warning about "a/b/c" being outside the sparse
checkout even though it isn't. Note that this problem only occurs with
non-cone mode.

Fix this by making path_in_sparse_checkout() perform pattern matching
for every component in the given path when cone mode is disabled. (This
can be expensive, and we might want to do some form of caching for the
match results of the leading components. However, this is not
implemented in this patch.) Also add two tests for each command (add,
rm, and mv) to check that they behave correctly with the said pattern
matching. The first test would previously fail without this patch, while
the second already succeeded. It is added mostly to make sure that we
are not breaking the existing pattern matching for directories that are
really sparse, and also as a protection against any future
regressions.

Note that two other existing tests had to be changed: one test in t3602
checks that "git rm -r <dir>" won't remove sparse entries, but it
didn't allow the non-sparse entries inside <dir> to be removed. The
other one, in t7002, tested that "git mv" would correctly display a
warning message for sparse paths, but it accidentally expected the
message to include two non-sparse paths as well.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 dir.c                          | 33 ++++++++++++++++++++++++------
 t/t3602-rm-sparse-checkout.sh  | 37 +++++++++++++++++++++++++++++++---
 t/t3705-add-sparse-checkout.sh | 18 +++++++++++++++++
 t/t7002-mv-sparse-checkout.sh  | 28 +++++++++++++++++++++++--
 4 files changed, 105 insertions(+), 11 deletions(-)

diff --git a/dir.c b/dir.c
index a4306ab874..225487a59c 100644
--- a/dir.c
+++ b/dir.c
@@ -1504,8 +1504,9 @@ static int path_in_sparse_checkout_1(const char *path,
 				     struct index_state *istate,
 				     int require_cone_mode)
 {
-	const char *base;
 	int dtype = DT_REG;
+	enum pattern_match_result ret = NOT_MATCHED;
+	const char *p, *last_slash = NULL;
 
 	/*
 	 * We default to accepting a path if there are no patterns or
@@ -1516,11 +1517,31 @@ static int path_in_sparse_checkout_1(const char *path,
 	     !istate->sparse_checkout_patterns->use_cone_patterns))
 		return 1;
 
-	base = strrchr(path, '/');
-	return path_matches_pattern_list(path, strlen(path), base ? base + 1 : path,
-					 &dtype,
-					 istate->sparse_checkout_patterns,
-					 istate) > 0;
+	if (istate->sparse_checkout_patterns->use_cone_patterns) {
+		const char *base = strrchr(path, '/');
+		return path_matches_pattern_list(path, strlen(path),
+				base ? base + 1 : path, &dtype,
+				istate->sparse_checkout_patterns, istate) > 0;
+	}
+
+	for (p = path; ; p++) {
+		enum pattern_match_result match;
+
+		if (*p && *p != '/')
+			continue;
+
+		match  = path_matches_pattern_list(path, p - path,
+				last_slash ? last_slash + 1 : path, &dtype,
+				istate->sparse_checkout_patterns, istate);
+
+		if (match != UNDECIDED)
+			ret = match;
+		if (!*p)
+			break;
+		last_slash = p;
+	}
+
+	return ret;
 }
 
 int path_in_sparse_checkout(const char *path,
diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
index ecce497a9c..6e127b966e 100755
--- a/t/t3602-rm-sparse-checkout.sh
+++ b/t/t3602-rm-sparse-checkout.sh
@@ -40,14 +40,20 @@ done
 test_expect_success 'recursive rm does not remove sparse entries' '
 	git reset --hard &&
 	git sparse-checkout set sub/dir &&
-	test_must_fail git rm -r sub &&
-	git rm --sparse -r sub &&
+	git rm -r sub &&
 	git status --porcelain -uno >actual &&
 	cat >expected <<-\EOF &&
+	D  sub/dir/e
+	EOF
+	test_cmp expected actual &&
+
+	git rm --sparse -r sub &&
+	git status --porcelain -uno >actual2 &&
+	cat >expected2 <<-\EOF &&
 	D  sub/d
 	D  sub/dir/e
 	EOF
-	test_cmp expected actual
+	test_cmp expected2 actual2
 '
 
 test_expect_success 'recursive rm --sparse removes sparse entries' '
@@ -105,4 +111,29 @@ test_expect_success 'refuse to rm a non-skip-worktree path outside sparse cone'
 	test_path_is_missing b
 '
 
+test_expect_success 'can remove files from non-sparse dir' '
+	git reset --hard &&
+	git sparse-checkout disable &&
+	mkdir -p w x/y &&
+	test_commit w/f &&
+	test_commit x/y/f &&
+
+	git sparse-checkout set w !/x y &&
+	git rm w/f.t x/y/f.t 2>stderr &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'refuse to remove non-skip-worktree file from sparse dir' '
+	git reset --hard &&
+	git sparse-checkout disable &&
+	mkdir -p x/y/z &&
+	test_commit x/y/z/f &&
+	git sparse-checkout set !/x y !x/y/z &&
+
+	git update-index --no-skip-worktree x/y/z/f.t &&
+	test_must_fail git rm x/y/z/f.t 2>stderr &&
+	echo x/y/z/f.t | cat sparse_error_header - sparse_hint >expect &&
+	test_cmp expect stderr
+'
+
 test_done
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 5b904988d4..63f888af12 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -214,4 +214,22 @@ test_expect_success 'add allows sparse entries with --sparse' '
 	test_must_be_empty stderr
 '
 
+test_expect_success 'can add files from non-sparse dir' '
+	git sparse-checkout set w !/x y &&
+	mkdir -p w x/y &&
+	touch w/f x/y/f &&
+	git add w/f x/y/f 2>stderr &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'refuse to add non-skip-worktree file from sparse dir' '
+	git sparse-checkout set !/x y !x/y/z &&
+	mkdir -p x/y/z &&
+	touch x/y/z/f &&
+	test_must_fail git add x/y/z/f 2>stderr &&
+	echo x/y/z/f | cat sparse_error_header - sparse_hint >expect &&
+	test_cmp expect stderr
+
+'
+
 test_done
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 545748949a..91a857bf05 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -143,8 +143,6 @@ test_expect_success 'recursive mv refuses to move (possible) sparse' '
 	cat >>expect <<-\EOF &&
 	sub/d
 	sub2/d
-	sub/dir/e
-	sub2/dir/e
 	sub/dir2/e
 	sub2/dir2/e
 	EOF
@@ -186,4 +184,30 @@ test_expect_success 'recursive mv refuses to move sparse' '
 	git reset --hard HEAD~1
 '
 
+test_expect_success 'can move files to non-sparse dir' '
+	git reset --hard &&
+	git sparse-checkout init --no-cone &&
+	git sparse-checkout set a b c w !/x y &&
+	mkdir -p w x/y &&
+
+	git mv a w/new-a 2>stderr &&
+	git mv b x/y/new-b 2>stderr &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'refuse to move file to non-skip-worktree sparse path' '
+	git reset --hard &&
+	git sparse-checkout init --no-cone &&
+	git sparse-checkout set a !/x y !x/y/z &&
+	mkdir -p x/y/z &&
+
+	test_must_fail git mv a x/y/z/new-a 2>stderr &&
+	cat sparse_error_header >expect &&
+	cat >>expect <<-\EOF &&
+	x/y/z/new-a
+	EOF
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr
+'
+
 test_done
-- 
2.33.0

