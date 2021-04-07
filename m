Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B216CC433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 18:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C20C6108B
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 18:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355084AbhDGSEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 14:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbhDGSED (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 14:04:03 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A07FC06175F
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 11:03:53 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o18so132685pjs.4
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 11:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OaCGMrUAXVjeG1JeOP+JZI5cWts0jAperfyGWvnP6wU=;
        b=lXDmnIn3vg0i3aMwsVuSTj5gKGs4WVX2EcItwP5PzC5G2tyy2BhMgkltjR9EymhCN4
         91yizZxv1+JDmarrz6wXLrvFFFaHhTRQVa3K1Qtea01rZdKwheQ1ITnu4VhPsEUzJeZ3
         sYC00J+X5q08t+OEt2/w6G/s3fEkM2/cwGX48tX1/4rNUuF0zldks/7IXPOaV88yibtn
         ocOr798s0BIITIiT2hVrFwoEfGVagdi6ZOZxHCJ+aF9kXBOOA1s21omc/+w+8VnXXitA
         +/k/1EwH6WX/ToQU4H3AD1UIk/j5KCXV47yCo+NhY5JL35AOYQ564qA6Ja0SCQZXh6yN
         Cj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OaCGMrUAXVjeG1JeOP+JZI5cWts0jAperfyGWvnP6wU=;
        b=rpw4W1xRUVrBmOoBgoMpU7/3asSezAl93JUhxsBgQUNkWUV27pmP31bd+h2w/XP/Ai
         2SzWLdIB654ih68Y2O5ykuS9ZlY6CMRMFuEOz8cXJsBpbULyho72O7Tz88hLhFcLxfIm
         wzjTz8PdIqgC2n06reSN2Hwl2rc4U14jcJKsoqxI6o7lAyltqqeB6x1vQWkgb/1R3FvD
         q7Y4NMQEF+GXBLnnMJfFZGEXC1F+w+FPo/+tnh+9YYsiO5hRB2us3LoFKF014w/dD2hN
         yvf7e5vc0mALhbBbTMBNBrPuv4k+Hdrmjcu43PQod1qSvOmaDHrC1FMyZk+wK4B3g1rR
         SNwQ==
X-Gm-Message-State: AOAM530LcAiwrsxBrqPgyFE9IiOLqePcbqNuKBv32O3CgiLIgHlXIgbA
        mDwjQS5S/yJur4j6n5AfDIDKtHKP02DQBkr8
X-Google-Smtp-Source: ABdhPJznPQGdlruL+hT8sN0aIbDz72qdeCcD73LDFzkedSrNICiLg8ZrNPiWryk97YIGUM8XDQE22A==
X-Received: by 2002:a17:902:9b92:b029:e6:b640:ad46 with SMTP id y18-20020a1709029b92b02900e6b640ad46mr4139686plp.56.1617818632673;
        Wed, 07 Apr 2021 11:03:52 -0700 (PDT)
Received: from jerry-desktop.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id v3sm2583844pjr.16.2021.04.07.11.03.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Apr 2021 11:03:52 -0700 (PDT)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com
Cc:     ross@skydio.com, abe@skydio.com, brian.kubisiak@skydio.com,
        Jerry Zhang <jerry@skydio.com>
Subject: [PATCH v4] git-apply: allow simultaneous --cached and --3way options
Date:   Wed,  7 Apr 2021 11:03:49 -0700
Message-Id: <20210407180349.10173-1-jerry@skydio.com>
X-Mailer: git-send-email 2.31.1.165.g9c72d21c07.dirty
In-Reply-To: <20210406024931.24355-1-jerry@skydio.com>
References: <20210406024931.24355-1-jerry@skydio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git apply" does not allow "--cached" and
"--3way" to be used together, since "--3way"
writes conflict markers into the working tree.

Allow "git apply" to accept "--cached" and
"--3way" at the same time.  When a single file
auto-resolves cleanly, the result is placed in the
index at stage #0 and the command exits with 0
status.  For a file that has a conflict which
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

Don't attempt rerere in this case since it depends
on conflict markers written to file for its database
storage and lookup. There would be two main changes
required to get rerere working:
1. Allow the rerere api to accept in memory object
rather than files, which would allow us to pass in
the conflict markers contained in the result from
ll_merge().
2. Rerere can't write to the working directory, so
it would have to apply the result to cache stage #0
directly. A flag would be needed to control this.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
 Documentation/git-apply.txt |  6 ++++--
 apply.c                     |  7 +++----
 t/t4108-apply-threeway.sh   | 24 ++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 9144575299c264dd299b542b7b5948eef35f211c..aa1ae56a25e0428cabcfa2539900ef2a09abcb7c 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -87,8 +87,10 @@ OPTIONS
 	Attempt 3-way merge if the patch records the identity of blobs it is supposed
 	to apply to and we have those blobs available locally, possibly leaving the
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
index 9bd4efcbced842d2c5c030a0f2178ddb36114600..0d1e91c88986433052e9b6e67c0dcbd04e6eb703 100644
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
@@ -4644,8 +4642,9 @@ static int write_out_results(struct apply_state *state, struct patch *list)
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
index 9ff313f976422f9c12dc8032d14567b54cfe3765..37ba4f6fa201c49a4bf2882d6b8345c1c2bedf0c 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -180,4 +180,28 @@ test_expect_success 'apply -3 with ambiguous repeating file' '
 	test_cmp expect one_two_repeat
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

