Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4662C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 22:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66C622068E
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 22:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+ivt6TB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHNWpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 18:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHNWpz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 18:45:55 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC036C061385
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 15:45:54 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z18so9595369wrm.12
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 15:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sb9mVHrZ6iVr7cqpUFD2eo3X1kyMyNd5q1N/XI0k0L0=;
        b=X+ivt6TB9d1KQB1r4L9IXVd2MTVnDYRfJR8t3qczfLjNfpVl9eF7uTbSNBFxSEGC//
         Eo2wOSAdFGaesZIxmKBI6D9JNTELPZQPkgaazh5THeDoKzm7erfiQtwiBCWkypE5dINB
         q1wANDeOEE1f5TEsY5/DymYXEHVOdkIyhJ5kSIfSAIfsk6pEV+/xlMDAyV7tQ0Y8+J+e
         hWi925sgdeN1K80Hd+fwv4OqM/z1NP+Uvt8uj3yqtwYT3EUGCrqD5DzqklrbZYfzpyPn
         8dMw0OXASoUj9x9S/e8iwceBpY6kBE53PLgP9zs96Lu0O/3muglWNGAi8KNUL2Im06Cm
         2gCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sb9mVHrZ6iVr7cqpUFD2eo3X1kyMyNd5q1N/XI0k0L0=;
        b=HKF0TPyYuEme33XYAs2QqcM8/oWPAA5Whll/9k99Cw6uLJ2A1CxxzwSIdmewczWe2M
         IwTYi97wdZk+tdkAYP89s49LN9ZtirHXepyeezTTI2Ir9VQGHcJIEVXFLhJtzlVMsgcz
         vRir/lxFiLbm70EPHTpJgT88FPDbKN3WBkzqFuOLS5+vq5YWWUJnTZR+T+qkpd/FAFWK
         AZOwzXTTHavS1uBIImk+wvvckeKGt8GaaRbRAPpTVEQqz2N2r71vqnrY3kA6fn7aGSwb
         QvwRw+LKnzlUguMQcuhqV9z5fvzNBPiE6KeKHIT/uVyQS8yEXDLRtMS9RfK48UXSoKkt
         hEWw==
X-Gm-Message-State: AOAM531HYyJyHLfPTAcdzaEppqKJ3sufPO969TiUS+bFcXKAxRJfX8DT
        a8UTWlbtD+GBD1bx8VEH9Mh2lW0f0EE=
X-Google-Smtp-Source: ABdhPJz1HQZhtT/Lm8fx7VlK4kA7XToKCW3rz8u9hfbpAMgzXO/NqjvTx3r1sj5IGRJzdPtpaYyKwg==
X-Received: by 2002:a5d:6a4e:: with SMTP id t14mr4529022wrw.135.1597445153282;
        Fri, 14 Aug 2020 15:45:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm19626431wrq.0.2020.08.14.15.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 15:45:52 -0700 (PDT)
Message-Id: <pull.689.v2.git.1597445151824.gitgitgadget@gmail.com>
In-Reply-To: <pull.689.git.1596324796918.gitgitgadget@gmail.com>
References: <pull.689.git.1596324796918.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Aug 2020 22:45:51 +0000
Subject: [PATCH v2] diff: teach --stat to ignore uninteresting modifications
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

Sometimes when diffing, files may show as being momdified even when
there are no interesting diffs to show.  This happens naturally when
using options such as --ignore-space-change.  We don't want to prevent
the display  of all files that have 0 effective diffs since they could
be the result of a rename, permission change, or other similar operation
that may still be of interest so we special case additions and deletions
as they are always interesting.

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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-689%2FROGERSM94%2Fzero-diffs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-689/ROGERSM94/zero-diffs-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/689

Range-diff vs v1:

 1:  640c864ac4 ! 1:  6c5db18618 diff: teach --stat to ignore uninteresting modifications
     @@ diff.c: static void builtin_diffstat(const char *name_a, const char *name_b,
      +			 * But note that we special-case additions and deletions,
      +			 * as adding an empty file, for example is still of interest.
      +			 */
     -+			if (p->status == DIFF_STATUS_MODIFIED 
     ++			if ((p->status == DIFF_STATUS_MODIFIED) 
      +				&& !file->added
     -+				&& !file->deleted) {
     ++				&& !file->deleted
     ++				&& one->mode == two->mode) {
      +				free_diffstat_file(file);
      +				diffstat->nr--;
      +			}
     @@ t/t4015-diff-whitespace.sh: test_expect_success 'whitespace-only changes not rep
       	test_must_be_empty actual
       '
       
     +-test_expect_success 'whitespace-only changes reported across renames' '
      +test_expect_success 'whitespace-only changes not reported (diffstat)' '
      +	# reuse state from previous test
      +	git diff --stat -b >actual &&
      +	test_must_be_empty actual
      +'
      +
     - test_expect_success 'whitespace-only changes reported across renames' '
     ++test_expect_success 'whitespace changes with modification reported (diffstat)' '
     ++	git reset --hard &&
     ++	echo >x "hello  world" &&
     ++	git update-index --chmod=+x x &&
     ++	git diff --stat --cached -b >actual &&
     ++	cat <<-EOF >expect &&
     ++	 x | 0
     ++	 1 file changed, 0 insertions(+), 0 deletions(-)
     ++	EOF
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'whitespace-only changes reported across renames (diffstat)' '
       	git reset --hard &&
       	for i in 1 2 3 4 5 6 7 8 9; do echo "$i$i$i$i$i$i"; done >x &&
     + 	git add x &&
     ++	git commit -m "base" &&
     ++	sed -e "5s/^/ /" x >z &&
     ++	git rm x &&
     ++	git add z &&
     ++	git diff -w -M --cached --stat >actual &&
     ++	cat <<-EOF >expect &&
     ++	 x => z | 0
     ++	 1 file changed, 0 insertions(+), 0 deletions(-)
     ++	EOF
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'whitespace-only changes reported across renames' '
     ++	git reset --hard HEAD~1 &&
     ++	for i in 1 2 3 4 5 6 7 8 9; do echo "$i$i$i$i$i$i"; done >x &&
     ++	git add x &&
     + 	hash_x=$(git hash-object x) &&
     + 	before=$(git rev-parse --short "$hash_x") &&
     + 	git commit -m "base" &&


 diff.c                     | 37 ++++++++++++++++++++++++++++++-------
 t/t4015-diff-whitespace.sh | 38 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index f9709de7b4..131903fa3a 100644
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
 
@@ -3718,6 +3721,26 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
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
+			 * But note that we special-case additions and deletions,
+			 * as adding an empty file, for example is still of interest.
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
