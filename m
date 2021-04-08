Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23CFC433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 02:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DBE96103D
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 02:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhDHCOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 22:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhDHCN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 22:13:59 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC1AC061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 19:13:49 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g15so693898pfq.3
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 19:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=npR0/98Flef0ivOpyZ4toj5UgrjjSkZE52Keam8Mg4U=;
        b=3PE6zc59TUkJfIDqmij9GvRiXBMSHSFx+VWzgQ/0W/8Mt33yHOmO3oi4PgN9u+Magz
         iawWX4eyd+KVWd6vk18MRPhgzsZ1wjuFIuVgTlydZU0tLbQJ4K5mD7nJF4bvWSCez+Us
         j6fOhRere7vHF6R9on+H/OCWdKNXABjnYXczs2hR0bo9kLqLDOs1baJORJ1Lk+QqEpo8
         e3BbuOrawh0TqDyp8cq/W0+t9BMuHgNsIA8Ec1i/Qh0OyGs+X14ZVG1N/4yQE2ZEgGf3
         zLPWGssHsckJyYeczxv+4JkRkkQb459jeJFWWkpqw1jfafl1iha94efVrL5Mmk7ulFBk
         +tyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=npR0/98Flef0ivOpyZ4toj5UgrjjSkZE52Keam8Mg4U=;
        b=Bw17iJtedX4mZ8Yd4RgXS3SIHfkwPgY3MAbYOq6tmoXf8Gk4Z8d253fSmMeu/bHWU1
         oE5WEIomU3+13+DII1y54b7s5m8kpeBehV1dVqaGJi0kQsjkhhBHxF8DO3W1inHMd5hi
         ZZos8cKnHT3i+hooJzt78bB+OPa0cB7H+3JUPXvhAMRGAiOkELS06wFKQx52Yic2MDH5
         OAhlKAya5jnUcFZACIqPdf9IxF2cNWQmDLHFk3143Fek8AZ7tE/nBTuMWh4/GfSr457I
         vaOO9uN9YfFh8gkyp/QTMkTysy+YnxapRxKrX5s/n20KPpLCvJ8Tvpqem71RjdBdSruz
         JEeA==
X-Gm-Message-State: AOAM5322MKoox3smRLj3YrcvZV8CFNHIbCyChO/8d8fWLV7HWf6qsQVT
        Rnc7RqVhcfSbHNGawvHtti2sE0t2IOh7T55t
X-Google-Smtp-Source: ABdhPJwQRFyzBp38t1Apx7NOTPFEfsdSHTQnIaIFLjyP3KIAgkWuPcfJpn6tmuQlxq4th7m5k4x+0g==
X-Received: by 2002:a65:57cb:: with SMTP id q11mr4348640pgr.183.1617848028542;
        Wed, 07 Apr 2021 19:13:48 -0700 (PDT)
Received: from jerry-desktop.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id i17sm3684964pfd.84.2021.04.07.19.13.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Apr 2021 19:13:48 -0700 (PDT)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com
Cc:     ross@skydio.com, abe@skydio.com, brian.kubisiak@skydio.com,
        Jerry Zhang <jerry@skydio.com>
Subject: [PATCH v5] git-apply: allow simultaneous --cached and --3way options
Date:   Wed,  7 Apr 2021 19:13:44 -0700
Message-Id: <20210408021344.8053-1-jerry@skydio.com>
X-Mailer: git-send-email 2.31.1.165.g5ed4bf6382
In-Reply-To: <20210407180349.10173-1-jerry@skydio.com>
References: <20210407180349.10173-1-jerry@skydio.com>
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
Patch applies on top of
"[PATCH v2] git-apply: try threeway first when "--3way""
Main merge conflict is the addition of multiple
tests at the bottom of the file.

v4->v5:

Updated in file comment about rerere
Added test for cleanly applying patch (should return 0)
Previous test captured case where patch fails to apply
due to 1 conflicting file and 1 cleanly applying file
(returns 1).

 Documentation/git-apply.txt |  6 +++--
 apply.c                     |  9 ++++---
 t/t4108-apply-threeway.sh   | 50 +++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 6 deletions(-)

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
index 9bd4efcbced842d2c5c030a0f2178ddb36114600..dadab80ec967357b031657d4e3d0ae52fac11411 100644
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
@@ -4644,8 +4642,11 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 				fprintf(stderr, "U %s\n", item->string);
 		}
 		string_list_clear(&cpath, 0);
-
-		repo_rerere(state->repo, 0);
+		/* Rerere relies on the partially merged result being in the working tree
+		 * with conflict markers, but that isn't written with --cached.
+		 */
+		if (!state->cached)
+			repo_rerere(state->repo, 0);
 	}
 
 	return errs;
diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index 9ff313f976422f9c12dc8032d14567b54cfe3765..65147efdea9a00e30d156e6f4d5d72a3987f230d 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -180,4 +180,54 @@ test_expect_success 'apply -3 with ambiguous repeating file' '
 	test_cmp expect one_two_repeat
 '
 
+test_expect_success 'apply with --3way --cached clean apply' '
+	# Merging side should be similar to applying this patch
+	git diff ...side >P.diff &&
+
+	# The corresponding cleanly applied merge
+	git reset --hard &&
+	git checkout main~ &&
+	git merge --no-commit side &&
+	git ls-files -s >expect.ls &&
+
+	# should succeed
+	git reset --hard &&
+	git checkout main~ &&
+	git apply --cached --3way P.diff &&
+	git ls-files -s >actual.ls &&
+	print_sanitized_conflicted_diff >actual.diff &&
+
+	# The cache should resemble the corresponding merge
+	# (both files at stage #0)
+	test_cmp expect.ls actual.ls &&
+	# However the working directory should not change
+	>expect.diff &&
+	test_cmp expect.diff actual.diff
+'
+
+test_expect_success 'apply with --3way --cached and conflicts' '
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
+	# (one file at stage #0, one file at stages #1 #2 #3)
+	test_cmp expect.ls actual.ls &&
+	# However the working directory should not change
+	>expect.diff &&
+	test_cmp expect.diff actual.diff
+'
+
 test_done
-- 
2.29.0

