Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAFFC433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 18:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242496AbiAQS0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 13:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242467AbiAQSZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 13:25:58 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B246C061574
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 10:25:58 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k5so13242603wmj.3
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 10:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wTG2RNPqHo8g3j3IiothrZaWVGdqheNq+vmvUhUkS54=;
        b=FDMTwyToaKQNsnJfSxCh81f7Y31q1oneXmYxiqYUNSTttXDXOkcGBORh1g4jAkyH/V
         hEoYxZqmDbuqJL/w3A+ER09tyN3A9ZxE1CH9Q4WZk3eNK3SIpFti1ulW/qjfsajewEzo
         3PCRE3bOo5hQZ5KUJQLIsk5Xcg440rn6vzVaOZYjc/0L6UoRkdjvESNxvhEw5TlKdoIN
         n3tEE58cFLieaXlX9rkARRu7/VsYngIqfGXJGlj+4s5084o9stDCA9OGGHIJU5wqSnLM
         YKJHOhzg/KNIA7JxcQyG4pEkgx0JIOPdDc7/QJuivRBulJPS8NGFrPwRrPQJK6cjwQcP
         ngmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wTG2RNPqHo8g3j3IiothrZaWVGdqheNq+vmvUhUkS54=;
        b=B/RQrV/ZYa38+0fE4vdRFKLnbeWct6uqZgAYTBxUXQjjVnmEiw+amdUa2XjUeL7DJ/
         JFdFdfycbWboxYcuyZ9VQJXHtBr7h0n8GP+P2u94T6eAbY1iOPkhfaBly41s4TkZUhGs
         2rJpB9HCvHGwBvfexs9QrZNGiHEGhujp24KOW0x/TdBT8SCxfqyLUqbGhAqY8l5tYrhB
         qo3wb5Wx+JwacQHwZnnNaPQ4s0OSzmCyBOSdYwsdgU6frq237aJukcYbCrvf9QAjyUCu
         lq6z98TyXNlhX5dJFnORQN3P8NFstkTXg9V+pRt6lCc8cXp9QsxmnMQKu16dFxw/q3CQ
         YbTg==
X-Gm-Message-State: AOAM530gcjfIdf2dQ2mGKMomoOG7WIMgv0zqmW2UHfIKnF8Y2X25z7iF
        yFUm1+Ja7IKcgv1Yv/PesmBEqZ7ITU0=
X-Google-Smtp-Source: ABdhPJwZqYyZr5yGVvL0brD+cHG+szRLbXjSkjgc7ty0pWMMJDnbeeY4cfkaumktl+VtpVZe9wdOpQ==
X-Received: by 2002:a7b:cb55:: with SMTP id v21mr21190863wmj.77.1642443956829;
        Mon, 17 Jan 2022 10:25:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c185sm108966wma.24.2022.01.17.10.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 10:25:56 -0800 (PST)
Message-Id: <pull.1194.v2.git.git.1642443955836.gitgitgadget@gmail.com>
In-Reply-To: <pull.1194.git.git.1642212566346.gitgitgadget@gmail.com>
References: <pull.1194.git.git.1642212566346.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Jan 2022 18:25:55 +0000
Subject: [PATCH v2] merge-ort: avoid assuming all renames detected
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In commit 8b09a900a1 ("merge-ort: restart merge with cached renames to
reduce process entry cost", 2021-07-16), we noted that in the merge-ort
steps of
    collect_merge_info()
    detect_and_process_renames()
    process_entries()
that process_entries() was expensive, and we could often make it cheaper
by changing this to
    collect_merge_info()
    detect_and_process_renames()
    <cache all the renames, and restart>
    collect_merge_info()
    detect_and_process_renames()
    process_entries()
because the second collect_merge_info() would be cheaper (we could avoid
traversing into some directories), the second
detect_and_process_renames() would be free since we had already detected
all renames, and then process_entries() has far fewer entries to handle.

However, this was built on the assumption that the first
detect_and_process_renames() actually detected all potential renames.
If someone has merge.renameLimit set to some small value, that
assumption is violated which manifests later with the following message:

    $ git -c merge.renameLimit=1 rebase upstream
    ...
    git: merge-ort.c:546: clear_or_reinit_internal_opts: Assertion
    `renames->cached_pairs_valid_side == 0' failed.

Turn off this cache-renames-and-restart whenever we cannot detect all
renames, and add a testcase that would have caught this problem.

Reported-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    merge-ort: avoid assuming all renames detected
    
    Fixes https://lore.kernel.org/git/YeHTIfEutLYM4TIU@nand.local/
    
    Changes since v1:
    
     * Fixed a small style issue

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1194%2Fnewren%2Favoid-assertion-assuming-renames-found-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1194/newren/avoid-assertion-assuming-renames-found-v2
Pull-Request: https://github.com/git/git/pull/1194

Range-diff vs v1:

 1:  f1e9901ae67 ! 1:  239d3ba08c1 merge-ort: avoid assuming all renames detected
     @@ merge-ort.c: static int detect_and_process_renames(struct merge_options *opt,
       	trace2_region_enter("merge", "regular renames", opt->repo);
       	detection_run |= detect_regular_renames(opt, MERGE_SIDE1);
       	detection_run |= detect_regular_renames(opt, MERGE_SIDE2);
     -+	if (renames->needed_limit != 0) {
     ++	if (renames->needed_limit) {
      +		renames->cached_pairs_valid_side = 0;
      +		renames->redo_after_renames = 0;
      +	}


 merge-ort.c                              |  4 ++
 t/t6429-merge-sequence-rename-caching.sh | 67 ++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index c3197970219..b0ff9a72879 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3060,6 +3060,10 @@ static int detect_and_process_renames(struct merge_options *opt,
 	trace2_region_enter("merge", "regular renames", opt->repo);
 	detection_run |= detect_regular_renames(opt, MERGE_SIDE1);
 	detection_run |= detect_regular_renames(opt, MERGE_SIDE2);
+	if (renames->needed_limit) {
+		renames->cached_pairs_valid_side = 0;
+		renames->redo_after_renames = 0;
+	}
 	if (renames->redo_after_renames && detection_run) {
 		int i, side;
 		struct diff_filepair *p;
diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
index 035edc40b1e..f2bc8a7d2a2 100755
--- a/t/t6429-merge-sequence-rename-caching.sh
+++ b/t/t6429-merge-sequence-rename-caching.sh
@@ -697,4 +697,71 @@ test_expect_success 'caching renames only on upstream side, part 2' '
 	)
 '
 
+#
+# The following testcase just creates two simple renames (slightly modified
+# on both sides but without conflicting changes), and a directory full of
+# files that are otherwise uninteresting.  The setup is as follows:
+#
+#   base:     unrelated/<BUNCH OF FILES>
+#             numbers
+#             values
+#   upstream: modify: numbers
+#             modify: values
+#   topic:    add: unrelated/foo
+#             modify: numbers
+#             modify: values
+#             rename: numbers -> sequence
+#             rename: values -> progression
+#
+# This is a trivial rename case, but we're curious what happens with a very
+# low renameLimit interacting with the restart optimization trying to notice
+# that unrelated/ looks like a trivial merge candidate.
+#
+test_expect_success 'avoid assuming we detected renames' '
+	git init redo-weirdness &&
+	(
+		cd redo-weirdness &&
+
+		mkdir unrelated &&
+		for i in $(test_seq 1 10)
+		do
+			>unrelated/$i
+		done &&
+		test_seq  2 10 >numbers &&
+		test_seq 12 20 >values &&
+		git add numbers values unrelated/ &&
+		git commit -m orig &&
+
+		git branch upstream &&
+		git branch topic &&
+
+		git switch upstream &&
+		test_seq  1 10 >numbers &&
+		test_seq 11 20 >values &&
+		git add numbers &&
+		git commit -m "Some tweaks" &&
+
+		git switch topic &&
+
+		>unrelated/foo &&
+		test_seq  2 12 >numbers &&
+		test_seq 12 22 >values &&
+		git add numbers values unrelated/ &&
+		git mv numbers sequence &&
+		git mv values progression &&
+		git commit -m A &&
+
+		#
+		# Actual testing
+		#
+
+		git switch --detach topic^0 &&
+
+		test_must_fail git -c merge.renameLimit=1 rebase upstream &&
+
+		git ls-files -u >actual &&
+		! test_file_is_empty actual
+	)
+'
+
 test_done

base-commit: 1ffcbaa1a5f10c9f706314d77f88de20a4a498c2
-- 
gitgitgadget
