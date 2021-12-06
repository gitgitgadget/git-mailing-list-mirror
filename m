Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6510FC433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 16:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358940AbhLFQOc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 11:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389100AbhLFQNq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 11:13:46 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8EAC0D940E
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 07:56:08 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a9so23351627wrr.8
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 07:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Y3sRj9BcOkWbh+b8jgq9VmCE85Gg045cO6ZEqcMJtB4=;
        b=C7Kp3mXsUWlUgSbmWY5fv0kSOv6DHqGhdi6Y6bs6xPi9PnQoXJIrPpLionUaeZKovy
         vLoqq4KTnrQwkrT113yWejxnrI7nPTyfQ2Kt5TvUlBwftEWXTh6siS0DS8BJrEdg2EGV
         0eZYncF4heTfDtaOm4Yev479JfNJn/u2QroBBF8HER2YlmBbkGN/mVx5Cbt5nLrZqQmM
         3UgdUQQgyAcBBPkDGcHZ17wUKRDcWNUbPNszCRJoUlGrVIpBHc08iOvjjxVOnQZMC+UW
         xR5JWiVRiqbDtlrn4Met8bC+/RU7HI2okPDU+ONrfJFywCPySEU4yFO25KWojP3AEGnN
         WbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Y3sRj9BcOkWbh+b8jgq9VmCE85Gg045cO6ZEqcMJtB4=;
        b=6LO4of8CS7sLVrjOPlqa5EF0AjJPI30G30SFRAQK6augolWkYxJb2xq3UqpbbAl7qu
         nToMcXCHL1gldQYMpm1XPiLCsnXD89oNQ82AVfrmZbK/P1dRqSgftlKhOrjL3dQigWXV
         BRS5Pjh45ZcefdWAo10wTnkGPRiSPuvo6kN3K6k+D7pXQC3NmN9UGIPxAEY+yODZSFL0
         LmtxqMF2UpFoN5lS3Ob125cxxOjlPz+JWJc9bN1qO9WvBgSkv9NpNI9sNux1yKHnIdPO
         ROQMzFgHe+utrOfkmFgPjTJ5wwXcLw9051HK0Jl6HsrFL2L0/q0O06LnNr/juB0qjUCV
         C32A==
X-Gm-Message-State: AOAM530dZceR6yyyAJgp+irAvv9M+d5kmdp6+wccj5fkYuRBte102COc
        wMFBmGZxc+GQJjuFcvIZPVjtZlqZ0l4=
X-Google-Smtp-Source: ABdhPJz63FM+hD6E+pix7Pg3Kcc1787E8qWsHb0z8QzhtSEV3yZFo3LJ6EfKfPbnY131tca6m/wm+Q==
X-Received: by 2002:adf:e54a:: with SMTP id z10mr42697488wrm.328.1638806167418;
        Mon, 06 Dec 2021 07:56:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17sm12830392wmq.11.2021.12.06.07.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:56:06 -0800 (PST)
Message-Id: <897611682af64ba6bd0d2dfcfeae56cfe953c45e.1638806161.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v6.git.1638806161.gitgitgadget@gmail.com>
References: <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
        <pull.1050.v6.git.1638806161.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Dec 2021 15:56:00 +0000
Subject: [PATCH v6 6/7] diff: enable and test the sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Enable the sparse index within the 'git diff' command. Its implementation
already safely integrates with the sparse index because it shares code
with the 'git status' and 'git checkout' commands that were already
integrated.  For more details see:

d76723ee53 (status: use sparse-index throughout, 2021-07-14)
1ba5f45132 (checkout: stop expanding sparse indexes, 2021-06-29)

The most interesting thing to do is to add tests that verify that 'git
diff' behaves correctly when the sparse index is enabled. These cases are:

1. The index is not expanded for 'diff' and 'diff --staged'
2. 'diff' and 'diff --staged' behave the same in full checkout, sparse
checkout, and sparse index repositories in the following partially-staged
scenarios (i.e. the index, HEAD, and working directory differ at a given
path):
    1. Path is within sparse-checkout cone
    2. Path is outside sparse-checkout cone
    3. A merge conflict exists for paths outside sparse-checkout cone

The `p2000` tests demonstrate a ~44% execution time reduction for 'git
diff' and a ~86% execution time reduction for 'git diff --staged' using a
sparse index:

Test                                      before  after
-------------------------------------------------------------
2000.30: git diff (full-v3)               0.33    0.34 +3.0%
2000.31: git diff (full-v4)               0.33    0.35 +6.1%
2000.32: git diff (sparse-v3)             0.53    0.31 -41.5%
2000.33: git diff (sparse-v4)             0.54    0.29 -46.3%
2000.34: git diff --cached (full-v3)      0.07    0.07 +0.0%
2000.35: git diff --cached (full-v4)      0.07    0.08 +14.3%
2000.36: git diff --cached (sparse-v3)    0.28    0.04 -85.7%
2000.37: git diff --cached (sparse-v4)    0.23    0.03 -87.0%

Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
Reviewed-by: Elijah Newren <newren@gmail.com>
---
 builtin/diff.c                           |  5 +++
 t/perf/p2000-sparse-operations.sh        |  2 ++
 t/t1092-sparse-checkout-compatibility.sh | 46 ++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/builtin/diff.c b/builtin/diff.c
index dd8ce688ba7..fa4683377eb 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -437,6 +437,11 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
 	prefix = setup_git_directory_gently(&nongit);
 
+	if (!nongit) {
+		prepare_repo_settings(the_repository);
+		the_repository->settings.command_requires_full_index = 0;
+	}
+
 	if (!no_index) {
 		/*
 		 * Treat git diff with at least one path outside of the
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index bfd332120c8..5cf94627383 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -113,5 +113,7 @@ test_perf_on_all git checkout -f -
 test_perf_on_all git reset
 test_perf_on_all git reset --hard
 test_perf_on_all git reset -- does-not-exist
+test_perf_on_all git diff
+test_perf_on_all git diff --cached
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 203a594fa45..abfb4994bb9 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -846,6 +846,52 @@ test_expect_success 'sparse-index is not expanded: merge conflict in cone' '
 	)
 '
 
+test_expect_success 'sparse index is not expanded: diff' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	# Add file within cone
+	test_sparse_match git sparse-checkout set deep &&
+	run_on_all ../edit-contents deep/testfile &&
+	test_all_match git add deep/testfile &&
+	run_on_all ../edit-contents deep/testfile &&
+
+	test_all_match git diff &&
+	test_all_match git diff --cached &&
+	ensure_not_expanded diff &&
+	ensure_not_expanded diff --cached &&
+
+	# Add file outside cone
+	test_all_match git reset --hard &&
+	run_on_all mkdir newdirectory &&
+	run_on_all ../edit-contents newdirectory/testfile &&
+	test_sparse_match git sparse-checkout set newdirectory &&
+	test_all_match git add newdirectory/testfile &&
+	run_on_all ../edit-contents newdirectory/testfile &&
+	test_sparse_match git sparse-checkout set &&
+
+	test_all_match git diff &&
+	test_all_match git diff --cached &&
+	ensure_not_expanded diff &&
+	ensure_not_expanded diff --cached &&
+
+	# Merge conflict outside cone
+	# The sparse checkout will report a warning that is not in the
+	# full checkout, so we use `run_on_all` instead of
+	# `test_all_match`
+	run_on_all git reset --hard &&
+	test_all_match git checkout merge-left &&
+	test_all_match test_must_fail git merge merge-right &&
+
+	test_all_match git diff &&
+	test_all_match git diff --cached &&
+	ensure_not_expanded diff &&
+	ensure_not_expanded diff --cached
+'
+
 # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
 # in this scenario, but it shouldn't.
 test_expect_success 'reset mixed and checkout orphan' '
-- 
gitgitgadget

