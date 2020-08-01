Return-Path: <SRS0=89BL=BL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB5AC433E1
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 23:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9999F20789
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 23:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHPYmt3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgHAXdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Aug 2020 19:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHAXdT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Aug 2020 19:33:19 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66586C06174A
        for <git@vger.kernel.org>; Sat,  1 Aug 2020 16:33:19 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id jp10so8442491ejb.0
        for <git@vger.kernel.org>; Sat, 01 Aug 2020 16:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=G/BMB0HBxfocsOLq+OVYWachPcOTI3U+OmfKEFu2JZU=;
        b=BHPYmt3wlLCqJZ87H55tiucTfcVwv6LQDZzUrouSgMDbwJAfTPo9eU87/fXNheMN0p
         o15iXz/ikAOz0cw+B0PWxELUFO9sOYCWEuyvFiGcvHKzdFNoYg3cOQWE1U+C0x6GSaTX
         W2rBIbzTN0zXJ+TxZCsyw5jBL775R5x825b+xyVz70jdXosRXCeSwfsMU/DJsz3BHiCH
         WkD4ir/S7fTUejNho4AWktBsr2SnWTWpd7j5EGKJtqjp0UgLkC4e/HeaO9Rk4GDvOvoj
         pWDhrQyro9G1DGhqL+yHpu2S285gzvv1Qa52dKRNRvuSSy9ghOShozzCmNPqFmgBgmLn
         /zUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G/BMB0HBxfocsOLq+OVYWachPcOTI3U+OmfKEFu2JZU=;
        b=IVDU6dbKrluXr0nFrCeJF3BwYdHwiOaCX6m7H1HD08gkRBYHl3No+drIyO0nz+iCxS
         kylPIWTnFjNcXkkZdN3W94boFTDSEw5kgvoOeGEe3W8sCwOy5IOlGQKVNLqtBBjzQWsG
         En5OjWL/kGwE2nbkBz2b2JS8GzBVd9netZAruBTcXsI5V9Hqasou57nXdBXjES1i0eDA
         eb+FtpdgFS4J/lbvUPMjIJ7aw44/99/C5AIx7OqIQRj5V5KFOoDTngUWparqAJImnC4S
         C7mnnXdBph/HDXs1UdY4YiA5i2XBaHSs0/ohLC1TxB1vbGfvv7mrx3UYGy9DJzwuop96
         G9ew==
X-Gm-Message-State: AOAM532RVVCv8NBMze7ADVz2dPN+qn8+M0ZBkLEIqH28UElvACLCIPQp
        QWxL4fuKHkCFqBscTbZGAxFFmvLW
X-Google-Smtp-Source: ABdhPJy4k86YopDi4Tw+LtnUTPskekaSKVgvhf+iBE/6kb6MLQtZzgBmQ3kSNRzc+T6eb//i/d9lZg==
X-Received: by 2002:a17:906:70c:: with SMTP id y12mr9693893ejb.231.1596324797778;
        Sat, 01 Aug 2020 16:33:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6sm11971711ejq.85.2020.08.01.16.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 16:33:17 -0700 (PDT)
Message-Id: <pull.689.git.1596324796918.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 01 Aug 2020 23:33:16 +0000
Subject: [PATCH] diff: teach --stat to ignore uninteresting modifications
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-689%2FROGERSM94%2Fzero-diffs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-689/ROGERSM94/zero-diffs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/689

 diff.c                     | 36 +++++++++++++++++++++++++++++-------
 t/t4015-diff-whitespace.sh |  8 +++++++-
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index d24aaa3047..9868f82ece 100644
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
 
@@ -3718,6 +3721,25 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
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
+			if (p->status == DIFF_STATUS_MODIFIED 
+				&& !file->added
+				&& !file->deleted) {
+				free_diffstat_file(file);
+				diffstat->nr--;
+			}
+		}
 	}
 
 	diff_free_filespec_data(one);
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 88d3026894..32c1b967f9 100755
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
@@ -799,6 +799,12 @@ test_expect_success 'whitespace-only changes not reported' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'whitespace-only changes not reported (diffstat)' '
+	# reuse state from previous test
+	git diff --stat -b >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'whitespace-only changes reported across renames' '
 	git reset --hard &&
 	for i in 1 2 3 4 5 6 7 8 9; do echo "$i$i$i$i$i$i"; done >x &&

base-commit: e8ab941b671da6890181aea5b5755d1d9eea24ec
-- 
gitgitgadget
