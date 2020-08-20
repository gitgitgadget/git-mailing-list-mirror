Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278B8C433E1
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 00:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9E9E2078D
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 00:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4kyPrW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgHTAli (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgHTAlh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 20:41:37 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26153C061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 17:41:37 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x5so144451wmi.2
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 17:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qX2oJScoX7MK6DgkSPpeQ4GKMZihoNPlqIv0ZlYd8RE=;
        b=l4kyPrW5ysJ5ktMGOjetCxbiiGBg28XOv/yXeNHv0n7fOqGR/cRrgqb2sGwionz11K
         fFnHhjjA11KtTcbbxrBUr2x4DELKSsMupoQnOG674noQo133qStChLUjdi3Ew8nAW2ki
         a6F+goHoSaPHYhtGTRY71aOPQWZZFvupGGx1Gng0qJcJOfaW92vTI297zuH+UnTrzU30
         MRZOXaMI9RkEZKFvrvIQj6PgOrx6MAHwfQ16kpca/wETso6hjJdE8F+FMlCoy2zv2zLa
         SWJT5l/EzzL2IOUFmGv707M7h2t0nvrU8EzHsK7yFzmH95ynhpyk5WUvcxgorIODyYHh
         AR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qX2oJScoX7MK6DgkSPpeQ4GKMZihoNPlqIv0ZlYd8RE=;
        b=Q6nEVgVSjJ37VDEav7IG32bf7THr8u6z2rTVs0DCqMUNHTtDfCQ67rq7DKEqRC47dR
         QfMFNdAxB5rlYFjXSFzEmQC2zCtzrLLhylKq23JOkBtclqsnrKCXyxVXskYFb8Ku9tEZ
         J34gLnv4Vo6nUYxaWKKTYAaAEpWGSQO0oSJkGmOxRQEpZoDprpj64QbjJzTuGMSfNHHa
         ZZe++bpMywGJnhEflPan51+M7n4lWL33MCKzUXTvPJZ2Kge29ArsLJ5V9yZrIJrNUASQ
         7IvHeTBD8mGo2bJWOGlMoxMqRzH2k3nFO6NboiRBsfA7qcqNlUGdeO6BqWrpIH4V+uC7
         sOew==
X-Gm-Message-State: AOAM533MzaHhAcFhm+TNdcGVnO6KSpfEZ96cvUWn8sDD/+41ThYQtuuw
        fykLEPpusPEHMUtBeCoeTnn/MMA5GPI=
X-Google-Smtp-Source: ABdhPJyUNr0ujBDYLViJB7TV5YZKp9M9VI0O5lU5OacHs9KqIuvwbOvoPVNqUJ3YvsXBRDzDhrh+Dg==
X-Received: by 2002:a1c:a553:: with SMTP id o80mr799585wme.50.1597884095311;
        Wed, 19 Aug 2020 17:41:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c194sm1033863wme.8.2020.08.19.17.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 17:41:34 -0700 (PDT)
Message-Id: <pull.689.v3.git.1597884092580.gitgitgadget@gmail.com>
In-Reply-To: <pull.689.v2.git.1597445151824.gitgitgadget@gmail.com>
References: <pull.689.v2.git.1597445151824.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Aug 2020 00:41:32 +0000
Subject: [PATCH v3] diff: teach --stat to ignore uninteresting modifications
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Matthew Rogers <mattr94@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

When options such as --ignore-space-change are in use, files with
modifications can have no interesting textual changes worth showing.  In
such cases, "git diff --stat" shows 0 lines of additions and deletions.
Teach "git diff --stat" not to show such a path in its output, which
would be more natural.

However, we don't want to prevent the display  of all files that have 0
effective diffs since they could be the result of a rename, permission
change, or other similar operation that may still be of interest so we
special case additions and deletions as they are always interesting.

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
---
    diff: teach --stat to ignore uninteresting modifications
    
    This patch is based on the discussion these email threads:
    
    https://lore.kernel.org/git/1484704915.2096.16.camel@mattmccutchen.net/
    https://lore.kernel.org/git/CAOjrSZtQPQ8Xxuz+7SGykR8Q-gFDEZANSE5yQASqKjpbUAq_5Q@mail.gmail.com/
    
    With the code mostly taken from this specific message:
    https://lore.kernel.org/git/20170118111705.6bqzkklluikda3r5@sigill.intra.peff.net/
    
    The summary is that when running git diff --stat in combination with
    --ignore-all-space or similar options, you'll see many lines of the
    form:
    
    some-file.txt | 0
    
    which can be misleading when you are explicitly telling git to "ignore
    all space" or something similar. To rectify this issue, this patch
    categorizes all files that are modified but have no effective changes as
    not fit to display to the user.
    
    New in V2:
    
     * I've added a test covering the rename case with whitespace-changes
       and permissions changes
     * I've also updated the logic in builtin_diffstat to include that logic
       as well

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-689%2FROGERSM94%2Fzero-diffs-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-689/ROGERSM94/zero-diffs-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/689

Range-diff vs v2:

 1:  6c5db18618 ! 1:  7c3113846e diff: teach --stat to ignore uninteresting modifications
     @@ Metadata
       ## Commit message ##
          diff: teach --stat to ignore uninteresting modifications
      
     -    Sometimes when diffing, files may show as being momdified even when
     -    there are no interesting diffs to show.  This happens naturally when
     -    using options such as --ignore-space-change.  We don't want to prevent
     -    the display  of all files that have 0 effective diffs since they could
     -    be the result of a rename, permission change, or other similar operation
     -    that may still be of interest so we special case additions and deletions
     -    as they are always interesting.
     +    When options such as --ignore-space-change are in use, files with
     +    modifications can have no interesting textual changes worth showing.  In
     +    such cases, "git diff --stat" shows 0 lines of additions and deletions.
     +    Teach "git diff --stat" not to show such a path in its output, which
     +    would be more natural.
     +
     +    However, we don't want to prevent the display  of all files that have 0
     +    effective diffs since they could be the result of a rename, permission
     +    change, or other similar operation that may still be of interest so we
     +    special case additions and deletions as they are always interesting.
      
          Signed-off-by: Matthew Rogers <mattr94@gmail.com>
      
     @@ diff.c: static void builtin_diffstat(const char *name_a, const char *name_b,
      +			 * Even if !same_contents, this might be the case due to
      +			 * ignoring whitespace changes, etc.
      +			 * 
     -+			 * But note that we special-case additions and deletions,
     -+			 * as adding an empty file, for example is still of interest.
     ++			 * But note that we special-case additions, deletions,
     ++			 * renames, and mode changes as adding an empty file, 
     ++			 * for example is still of interest.
      +			 */
      +			if ((p->status == DIFF_STATUS_MODIFIED) 
      +				&& !file->added


 diff.c                     | 38 +++++++++++++++++++++++++++++++-------
 t/t4015-diff-whitespace.sh | 38 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index f9709de7b4..4f54b41395 100644
--- a/diff.c
+++ b/diff.c
@@ -3153,16 +3153,19 @@ static void show_dirstat_by_line(struct diffstat_t *data, struct diff_options *o
 	gather_dirstat(options, &dir, changed, "", 0);
 }
 
+static void free_diffstat_file(struct diffstat_file *f)
+{
+	free(f->print_name);
+	free(f->name);
+	free(f->from_name);
+	free(f);
+}
+
 void free_diffstat_info(struct diffstat_t *diffstat)
 {
 	int i;
-	for (i = 0; i < diffstat->nr; i++) {
-		struct diffstat_file *f = diffstat->files[i];
-		free(f->print_name);
-		free(f->name);
-		free(f->from_name);
-		free(f);
-	}
+	for (i = 0; i < diffstat->nr; i++)
+		free_diffstat_file(diffstat->files[i]);
 	free(diffstat->files);
 }
 
@@ -3718,6 +3721,27 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		if (xdi_diff_outf(&mf1, &mf2, discard_hunk_line,
 				  diffstat_consume, diffstat, &xpp, &xecfg))
 			die("unable to generate diffstat for %s", one->path);
+
+		if (DIFF_FILE_VALID(one) && DIFF_FILE_VALID(two)) {
+			struct diffstat_file *file = 
+				diffstat->files[diffstat->nr - 1];
+			/*
+			 * Omit diffstats of modified files where nothing changed. 
+			 * Even if !same_contents, this might be the case due to
+			 * ignoring whitespace changes, etc.
+			 * 
+			 * But note that we special-case additions, deletions,
+			 * renames, and mode changes as adding an empty file, 
+			 * for example is still of interest.
+			 */
+			if ((p->status == DIFF_STATUS_MODIFIED) 
+				&& !file->added
+				&& !file->deleted
+				&& one->mode == two->mode) {
+				free_diffstat_file(file);
+				diffstat->nr--;
+			}
+		}
 	}
 
 	diff_free_filespec_data(one);
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 88d3026894..8bdaa0a693 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -789,7 +789,7 @@ test_expect_success 'checkdiff allows new blank lines' '
 	git diff --check
 '
 
-test_expect_success 'whitespace-only changes not reported' '
+test_expect_success 'whitespace-only changes not reported (diff)' '
 	git reset --hard &&
 	echo >x "hello world" &&
 	git add x &&
@@ -799,10 +799,44 @@ test_expect_success 'whitespace-only changes not reported' '
 	test_must_be_empty actual
 '
 
-test_expect_success 'whitespace-only changes reported across renames' '
+test_expect_success 'whitespace-only changes not reported (diffstat)' '
+	# reuse state from previous test
+	git diff --stat -b >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'whitespace changes with modification reported (diffstat)' '
+	git reset --hard &&
+	echo >x "hello  world" &&
+	git update-index --chmod=+x x &&
+	git diff --stat --cached -b >actual &&
+	cat <<-EOF >expect &&
+	 x | 0
+	 1 file changed, 0 insertions(+), 0 deletions(-)
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'whitespace-only changes reported across renames (diffstat)' '
 	git reset --hard &&
 	for i in 1 2 3 4 5 6 7 8 9; do echo "$i$i$i$i$i$i"; done >x &&
 	git add x &&
+	git commit -m "base" &&
+	sed -e "5s/^/ /" x >z &&
+	git rm x &&
+	git add z &&
+	git diff -w -M --cached --stat >actual &&
+	cat <<-EOF >expect &&
+	 x => z | 0
+	 1 file changed, 0 insertions(+), 0 deletions(-)
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'whitespace-only changes reported across renames' '
+	git reset --hard HEAD~1 &&
+	for i in 1 2 3 4 5 6 7 8 9; do echo "$i$i$i$i$i$i"; done >x &&
+	git add x &&
 	hash_x=$(git hash-object x) &&
 	before=$(git rev-parse --short "$hash_x") &&
 	git commit -m "base" &&

base-commit: 878e727637ec5815ccb3301eb994a54df95b21b8
-- 
gitgitgadget
