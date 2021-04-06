Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96269C433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 02:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 607B2613A7
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 02:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243488AbhDFCtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 22:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbhDFCtq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 22:49:46 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396C5C06174A
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 19:49:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso8844210pji.3
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 19:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zs3opUXUD5wpPyjh8J//WOSfIztiUcieeV45b2m5pNc=;
        b=k+uRMdq4StLBIqZb8AmUhzxD8MY+jWZfzlDOhN26hwnx47mmmvvorhyWpJ8ynYwbCJ
         39kMIxXCJ1hSNUX3uku5szJbwuk7OPIWa4H2eQKKx44XAOksZbzPn8r1vgsSeJR+w8rW
         W1D5zyKGotOIQAKm24+ei8jcL/AFkQXCKLnxN+nD1nQWDKvcYr92MRkkI5ZHavFC+V+j
         OCQ8Kzezg9Bwx6MxqsJueawuUQNRfdH81bN7Y0uw+bR0mtdT2BqOv0A+2lMRV/Xj+h1l
         NDb6htb9coEC7+W+MzEF1Fq34GF7509KyVKuLI5e6TLkwmehGc7VMNzirDef0CL/BVS2
         Lmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zs3opUXUD5wpPyjh8J//WOSfIztiUcieeV45b2m5pNc=;
        b=s2JDeSwGrtjnm3aPAAvIJAKLjjwGKlsEXXnh71Exq+rh4hhOYQBn6EVv0bzUTBcH3Y
         ddoh30piSJSb1M0WuZOf+yJl3M3R1wiTMwBFdouhmbAzKsDPAho4yLB/8+Wsaw0ap0B7
         srQV1odR/+H1uuRSlJ7NR5Jz11hjlPgLLxu3XW+rRBhoSToppfqH4u1FzfYxNfprD6m/
         CfWVxc/NJ/tsHuXiGuwQ6iLdjXw7HEUO+ElmnL9EUg/COhb1dinWOWPVzecHMbXynfZ/
         qL0yh8KXgKC0Aj43MiEF6rIQj9gKzcONlwxZyHuM5IiWAQiMvJjiKEmGfG+sESl24pee
         anVA==
X-Gm-Message-State: AOAM532WdzO/49Y4PFXLuNJoUDnSu0QUq/K/yyaIkkFl8P941MZQdTar
        kVC2RKxLVuFjURq+plqiYzbdlJYygoI6usIP
X-Google-Smtp-Source: ABdhPJykwC366jUxmavwJrLOqd1Y8/3t7UnbYT3aRZUXDOs9MgGlWX0stms7CXq6i0LLs3YkkbcxlQ==
X-Received: by 2002:a17:902:6845:b029:e4:4d0f:c207 with SMTP id f5-20020a1709026845b02900e44d0fc207mr26854752pln.36.1617677377291;
        Mon, 05 Apr 2021 19:49:37 -0700 (PDT)
Received: from jerry-desktop.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id v25sm16746272pfn.51.2021.04.05.19.49.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Apr 2021 19:49:36 -0700 (PDT)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com
Cc:     ross@skydio.com, abe@skydio.com, brian.kubisiak@skydio.com,
        Jerry Zhang <jerry@skydio.com>
Subject: [PATCH v3] git-apply: allow simultaneous --cached and --3way options
Date:   Mon,  5 Apr 2021 19:49:31 -0700
Message-Id: <20210406024931.24355-1-jerry@skydio.com>
X-Mailer: git-send-email 2.31.1.165.g83e21c9f89
In-Reply-To: <20210405221902.27998-1-jerry@skydio.com>
References: <20210405221902.27998-1-jerry@skydio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git apply" does not allow "--cached" and
"--3way" to be used together, since "--3way"
writes conflict markers into the working tree.

Allow "git apply" to accept "--cached" and
"--3way" at the same time.  When all changes
auto-resolve cleanly, the result is placed in the
index at stage #0 and the command exits with 0
status.  If there is any path whose conflict
cannot be cleanly auto-resolved, the original
contents from common ancestor (stage #1), our
version (stage #2) and the contents from the
patch (stage #3) are left at separate stages.
No attempt is made to resolve the conflict at
the content level, and the command exists with
 non-zero status, because there is no place
(like the working tree) to leave a half-resolved
 merge for the user to resolve.

The user can use `git diff` to view the contents
of the conflict, or `git checkout -m -- .` to
regenerate the conflict markers in the working
directory.

Since rerere depends on conflict markers written
to file for its database storage and lookup, don't
attempt it in this case. This could be fixable
if the in memory conflict markers from the ll_merge
result could be passed to the rerere api.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
 Documentation/git-apply.txt |  6 ++++--
 apply.c                     |  7 +++----
 t/t4108-apply-threeway.sh   | 24 ++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 91d9a8601c8c316d4649c405af42e531c39991a8..9c48863c47287208850e8376f43453ecec595444 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -88,8 +88,10 @@ OPTIONS
 	the patch records the identity of blobs it is supposed to apply to,
 	and we have those blobs available locally, possibly leaving the
 	conflict markers in the files in the working tree for the user to
-	resolve.  This option implies the `--index` option, and is incompatible
-	with the `--reject` and the `--cached` options.
+	resolve.  This option implies the `--index` option unless the
+	`--cached` option is used, and is incompatible with the `--reject` option.
+	When used with the `--cached` option, any conflicts are left at higher stages
+	in the cache.
 
 --build-fake-ancestor=<file>::
 	Newer 'git diff' output has embedded 'index information'
diff --git a/apply.c b/apply.c
index 6695a931e979a968b28af88d425d0c76ba17d0d4..02d13ea6db7f9a4066dec3d33d7ddbe11b616f33 100644
--- a/apply.c
+++ b/apply.c
@@ -133,8 +133,6 @@ int check_apply_state(struct apply_state *state, int force_apply)
 
 	if (state->apply_with_reject && state->threeway)
 		return error(_("--reject and --3way cannot be used together."));
-	if (state->cached && state->threeway)
-		return error(_("--cached and --3way cannot be used together."));
 	if (state->threeway) {
 		if (is_not_gitdir)
 			return error(_("--3way outside a repository"));
@@ -4645,8 +4643,9 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 				fprintf(stderr, "U %s\n", item->string);
 		}
 		string_list_clear(&cpath, 0);
-
-		repo_rerere(state->repo, 0);
+		/* rerere relies on conflict markers which aren't written with --cached */
+		if (!state->cached)
+			repo_rerere(state->repo, 0);
 	}
 
 	return errs;
diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index d62db3fbe16f35a625a4a14eebb70034f695d3eb..75eb34b13d0024046fd2a510c00c5af1f7bfc52d 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -160,4 +160,28 @@ test_expect_success 'apply -3 with add/add conflict (dirty working tree)' '
 	test_cmp three.save three
 '
 
+test_expect_success 'apply with --3way --cached' '
+	# Merging side should be similar to applying this patch
+	git diff ...side >P.diff &&
+
+	# The corresponding conflicted merge
+	git reset --hard &&
+	git checkout main^0 &&
+	test_must_fail git merge --no-commit side &&
+	git ls-files -s >expect.ls &&
+
+	# should fail to apply
+	git reset --hard &&
+	git checkout main^0 &&
+	test_must_fail git apply --cached --3way P.diff &&
+	git ls-files -s >actual.ls &&
+	print_sanitized_conflicted_diff >actual.diff &&
+
+	# The cache should resemble the corresponding merge
+	test_cmp expect.ls actual.ls &&
+	# However the working directory should not change
+	>expect.diff &&
+	test_cmp expect.diff actual.diff
+'
+
 test_done
-- 
2.29.0

