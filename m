Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C67C433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 18:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344637AbiAKSGv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 13:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350382AbiAKSGB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 13:06:01 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A5AC034001
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:05:16 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p18so4905701wmg.4
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ElsfdI2q5RCVU5uBInipvFW5LNSBqOXQEdux36eTkF4=;
        b=PKQT2ztbW/RVKOyt+K3mIezIrA1v/CAdki9iDEAEJM4zmgoLk3qx+Fr8ZFxgcha2En
         3H3Q5sKOstlhBYokhX6LrH/GTFm/IKkG0HVMybVj7fBE7oqrOqXi3epZEs+PZ9TrMVnn
         M3+aCHzWQniWls4Ci3tqVIDGriMRNeF54QGUJHwWDIRD/octrckTqdQ9xpybnXft1yJO
         dIltD8cyvpSeeqkR8yXv1GfFdHKYI3BYyQoV4dZa7LARrlxctTszEVeLT7W/xtcN+OQ7
         lkN0a30uWmpA0NF5A0/fHJpnKm8s+5YcMqBu+BWTuCQpuI2ZYDK4Cet480nkNpdnNP3q
         e9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ElsfdI2q5RCVU5uBInipvFW5LNSBqOXQEdux36eTkF4=;
        b=LBVh4amJP/Kv4WkV8/CUUEPoqP01lobhpKRoml3VxM0+xMc99S/kyqpIGBjjtFmj9y
         gRWX+KrfEdgR0MdAu+GAxq5nnl9cqvhx88HFe1HdRfCc5hRdpgpRKUiPs7wvj1nEeHEN
         Q+QuTieJzY3m7ukHRgNGB6hXYPimnI65Hv/jL7pLj5Kpd+GE9ohEdxjmcM0oH7Gcwu6q
         Ct4rzgoHAXcYCzdkkUXvw9lYZOBXgGidgu6CQIVoDTisEGV+ShBwrUNMGuKld18Qp6au
         A203z9ZOumVspAc2p+T2xXmUKxCkuPj9ebItpeJnQ5pTTLoyWFZlk8l748LdVV1EQJPj
         b2Mw==
X-Gm-Message-State: AOAM5337kYpPwbKNM/jVtjR3DqZHtQkBAgkfltdlLdnNAgw3K/7nnBKv
        0UuxB7iVVncrNgIVDgAptBwYEIa24Go=
X-Google-Smtp-Source: ABdhPJw/q3bNJIjowspiBe2HY0qy9mOrbXVD/tbSzW1LXriaLnKRcxo536owpxd8YoQ/AOBlQHm8Ow==
X-Received: by 2002:a1c:f002:: with SMTP id a2mr3540655wmb.29.1641924314479;
        Tue, 11 Jan 2022 10:05:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bk2sm9523931wrb.65.2022.01.11.10.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 10:05:14 -0800 (PST)
Message-Id: <b4b9086dcdc62eff27f9520b9495e3b273946e39.1641924306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1109.v2.git.1641924306.gitgitgadget@gmail.com>
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
        <pull.1109.v2.git.1641924306.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Jan 2022 18:05:03 +0000
Subject: [PATCH v2 6/9] checkout-index: integrate with sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add repository settings to allow usage of the sparse index.

When using the `--all` option, sparse directories are ignored by default due
to the `skip-worktree` flag, so there is no need to expand the index. If
`--ignore-skip-worktree-bits` is specified, the index is expanded in order
to check out all files.

When checking out individual files, existing behavior in a full index is to
exit with an error if a directory is specified (as the directory name will
not match an index entry). However, it is possible in a sparse index to
match a directory name to a sparse directory index entry, but checking out
that sparse directory still results in an error on checkout. To reduce some
potential confusion for users, `checkout_file(...)` explicitly exits with an
informative error if provided with a sparse directory name. The test
corresponding to this scenario verifies the error message, which now differs
between sparse index and non-sparse index checkouts.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/checkout-index.c                 | 28 ++++++++++++++++++++++--
 t/t1092-sparse-checkout-compatibility.sh | 11 +++++++++-
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 615a118e2f5..97e06e8c52c 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -67,6 +67,7 @@ static int checkout_file(const char *name, const char *prefix)
 	int namelen = strlen(name);
 	int pos = cache_name_pos(name, namelen);
 	int has_same_name = 0;
+	int is_file = 0;
 	int is_skipped = 1;
 	int did_checkout = 0;
 	int errs = 0;
@@ -81,6 +82,9 @@ static int checkout_file(const char *name, const char *prefix)
 			break;
 		has_same_name = 1;
 		pos++;
+		if (S_ISSPARSEDIR(ce->ce_mode))
+			break;
+		is_file = 1;
 		if (!ignore_skip_worktree && ce_skip_worktree(ce))
 			break;
 		is_skipped = 0;
@@ -112,6 +116,8 @@ static int checkout_file(const char *name, const char *prefix)
 		fprintf(stderr, "git checkout-index: %s ", name);
 		if (!has_same_name)
 			fprintf(stderr, "is not in the cache");
+		else if (!is_file)
+			fprintf(stderr, "is a sparse directory");
 		else if (is_skipped)
 			fprintf(stderr, "has skip-worktree enabled; "
 					"use '--ignore-skip-worktree-bits' to checkout");
@@ -130,10 +136,25 @@ static int checkout_all(const char *prefix, int prefix_length)
 	int i, errs = 0;
 	struct cache_entry *last_ce = NULL;
 
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr ; i++) {
 		struct cache_entry *ce = active_cache[i];
+
+		if (S_ISSPARSEDIR(ce->ce_mode)) {
+			if (!ce_skip_worktree(ce))
+				BUG("sparse directory '%s' does not have skip-worktree set", ce->name);
+
+			/*
+			 * If the current entry is a sparse directory and skip-worktree
+			 * entries are being checked out, expand the index and continue
+			 * the loop on the current index position (now pointing to the
+			 * first entry inside the expanded sparse directory).
+			 */
+			if (ignore_skip_worktree) {
+				ensure_full_index(&the_index);
+				ce = active_cache[i];
+			}
+		}
+
 		if (!ignore_skip_worktree && ce_skip_worktree(ce))
 			continue;
 		if (ce_stage(ce) != checkout_stage
@@ -225,6 +246,9 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	prefix_length = prefix ? strlen(prefix) : 0;
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	if (read_cache() < 0) {
 		die("invalid cache");
 	}
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 434ef0433c0..0c72c854d84 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -801,7 +801,14 @@ test_expect_success 'checkout-index with folders' '
 	test_all_match test_must_fail git checkout-index -f -- deep/ &&
 
 	# Outside checkout definition
-	test_all_match test_must_fail git checkout-index -f -- folder1/
+	# Note: although all tests fail (as expected), the messaging differs. For
+	# non-sparse index checkouts, the error is that the "file" does not appear
+	# in the index; for sparse checkouts, the error is explicitly that the
+	# entry is a sparse directory.
+	run_on_all test_must_fail git checkout-index -f -- folder1/ &&
+	test_cmp full-checkout-err sparse-checkout-err &&
+	! test_cmp full-checkout-err sparse-index-err &&
+	grep "is a sparse directory" sparse-index-err
 '
 
 test_expect_success 'checkout-index --all' '
@@ -972,6 +979,8 @@ test_expect_success 'sparse-index is not expanded' '
 	echo >>sparse-index/untracked.txt &&
 	ensure_not_expanded add . &&
 
+	ensure_not_expanded checkout-index -f a &&
+	ensure_not_expanded checkout-index -f --all &&
 	for ref in update-deep update-folder1 update-folder2 update-deep
 	do
 		echo >>sparse-index/README.md &&
-- 
gitgitgadget

