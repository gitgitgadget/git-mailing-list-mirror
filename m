Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54181C433F5
	for <git@archiver.kernel.org>; Sat, 25 Dec 2021 07:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhLYH7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Dec 2021 02:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhLYH7d (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Dec 2021 02:59:33 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E28EC06175C
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 23:59:29 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t18so21308649wrg.11
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 23:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uFn0YpYd3Eh+frnhRc060AzdYD3+dI7y0pQZ85/ons8=;
        b=X+VgekbbhEhpAR63SSmayPT68JAvAEAB95Ov4auV7EYKz0eNFPv0khEZGRjzRgLg6r
         FBMsFUTH4SEogxvxaIESPNgrQbmxHiowl+OSzk4YkVeZo+rVcF18XMPezMrVw6CgSkFT
         ER5QvEzALL6fAjVJ9rR39/yrNz/4aTUSaUse7HBTtHMlDlWfKD2D/QEe4/mWJ5mkA0UX
         P1w7Lqz9ZQWymaYM7DdDZNZG3Zhcrb+M+qislKlTVWjwCeXRMcS0hu4MBh4gYKTddt5J
         KeYvdp+pvnWKpUnBf5kFlebTBv4qomRYUFIFmdw7ZynwfoSR0o3K0WaQRMDRamUrZ+gR
         QKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uFn0YpYd3Eh+frnhRc060AzdYD3+dI7y0pQZ85/ons8=;
        b=1L7itaaRMEB4oFztElWzufmaTIsTgWICO10d7zz3H9BTGchGfbMERHMMWtbqwGs/U3
         o2bED4Qce8l+8DD7zZSrG4AYPsY2w6mKh8yPpxzY7TnkJnDbaxqUCFHjt42v3GimeeQW
         JJQi9IM7tVH/cDqk+lZHSCjEMVxmH9jwkCPP32uJuq9yOJoLQQCCNwwEDwoBQisI3AiC
         hK6q3H5ygpviVdASti8Ydy5A9CBTeJr+NZ+udPPtI5DcOGW88rRY/Puidn9rcAbTKVzn
         NLOeAFm8sdE46H+zX3u/Y2h1aEvPqodnyKtQVcLHLV/73UTIawP6izhYLIVhVkRfva7E
         0bRA==
X-Gm-Message-State: AOAM531uduX4LlN1QGEJ51OwzKubeQjGYlf3PXzR62VHgvnWPP5vP0n/
        GPAiXw1/fss+m2ES90wbsP2dx4N4UMM=
X-Google-Smtp-Source: ABdhPJyBG/jm+6XEoH3lXy/HJvZcNkCBD18o9BrasZiSO4u+HzJx0wQtjYm79sMumHLjkfbhenuviQ==
X-Received: by 2002:a5d:610c:: with SMTP id v12mr6566087wrt.410.1640419167776;
        Fri, 24 Dec 2021 23:59:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o64sm9725285wme.28.2021.12.24.23.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 23:59:27 -0800 (PST)
Message-Id: <4cc53c55a6ea1531342b23bc9343890a576d9f1c.1640419160.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
        <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Dec 2021 07:59:19 +0000
Subject: [PATCH v2 8/8] show, log: include conflict/warning messages in
 --remerge-diff headers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Conflicts such as modify/delete, rename/rename, or file/directory are
not representable via content conflict markers, and the normal output
messages notifying users about these were dropped with --remerge-diff.
While we don't want these messages randomly shown before the commit
and diff headers, we do want them to still be shown; include them as
part of the diff headers instead.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 log-tree.c              |  3 ++
 merge-ort.c             |  1 +
 merge-ort.h             | 10 +++++
 t/t4069-remerge-diff.sh | 86 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+)

diff --git a/log-tree.c b/log-tree.c
index 33c28f537a6..97fbb756d21 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -922,6 +922,7 @@ static int do_remerge_diff(struct rev_info *opt,
 	/* Setup merge options */
 	init_merge_options(&o, the_repository);
 	o.show_rename_progress = 0;
+	o.record_conflict_msgs_as_headers = 1;
 
 	ctx.abbrev = DEFAULT_ABBREV;
 	format_commit_message(parent1, "%h (%s)", &parent1_desc, &ctx);
@@ -938,10 +939,12 @@ static int do_remerge_diff(struct rev_info *opt,
 	merge_incore_recursive(&o, bases, parent1, parent2, &res);
 
 	/* Show the diff */
+	opt->diffopt.additional_path_headers = res.path_messages;
 	diff_tree_oid(&res.tree->object.oid, oid, "", &opt->diffopt);
 	log_tree_diff_flush(opt);
 
 	/* Cleanup */
+	opt->diffopt.additional_path_headers = NULL;
 	strbuf_release(&parent1_desc);
 	strbuf_release(&parent2_desc);
 	merge_finalize(&o, &res);
diff --git a/merge-ort.c b/merge-ort.c
index 9142d56e0ad..07e53083cbd 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4579,6 +4579,7 @@ redo:
 	trace2_region_leave("merge", "process_entries", opt->repo);
 
 	/* Set return values */
+	result->path_messages = &opt->priv->output;
 	result->tree = parse_tree_indirect(&working_tree_oid);
 	/* existence of conflicted entries implies unclean */
 	result->clean &= strmap_empty(&opt->priv->conflicted);
diff --git a/merge-ort.h b/merge-ort.h
index c011864ffeb..fe599b87868 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -5,6 +5,7 @@
 
 struct commit;
 struct tree;
+struct strmap;
 
 struct merge_result {
 	/*
@@ -23,6 +24,15 @@ struct merge_result {
 	 */
 	struct tree *tree;
 
+	/*
+	 * Special messages and conflict notices for various paths
+	 *
+	 * This is a map of pathnames to strbufs.  It contains various
+	 * warning/conflict/notice messages (possibly multiple per path)
+	 * that callers may want to use.
+	 */
+	struct strmap *path_messages;
+
 	/*
 	 * Additional metadata used by merge_switch_to_result() or future calls
 	 * to merge_incore_*().  Includes data needed to update the index (if
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index 192dbce2bfe..a040d3bcd91 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -4,6 +4,15 @@ test_description='remerge-diff handling'
 
 . ./test-lib.sh
 
+# --remerge-diff uses ort under the hood regardless of setting.  However,
+# we set up a file/directory conflict beforehand, and the different backends
+# handle the conflict differently, which would require separate code paths
+# to resolve.  There's not much point in making the code uglier to do that,
+# though, when the real thing we are testing (--remerge-diff) will hardcode
+# calls directly into the merge-ort API anyway.  So just force the use of
+# ort on the setup too.
+GIT_TEST_MERGE_ALGORITHM=ort
+
 test_expect_success 'setup basic merges' '
 	test_write_lines 1 2 3 4 5 6 7 8 9 >numbers &&
 	git add numbers &&
@@ -55,6 +64,7 @@ test_expect_success 'remerge-diff with both a resolved conflict and an unrelated
 	git log -1 --oneline ab_resolution >tmp &&
 	cat <<-EOF >>tmp &&
 	diff --git a/numbers b/numbers
+	CONFLICT (content): Merge conflict in numbers
 	index a1fb731..6875544 100644
 	--- a/numbers
 	+++ b/numbers
@@ -83,4 +93,80 @@ test_expect_success 'remerge-diff with both a resolved conflict and an unrelated
 	test_cmp expect actual
 '
 
+test_expect_success 'setup non-content conflicts' '
+	git switch --orphan base &&
+
+	test_write_lines 1 2 3 4 5 6 7 8 9 >numbers &&
+	test_write_lines a b c d e f g h i >letters &&
+	test_write_lines in the way >content &&
+	git add numbers letters content &&
+	git commit -m base &&
+
+	git branch side1 &&
+	git branch side2 &&
+
+	git checkout side1 &&
+	test_write_lines 1 2 three 4 5 6 7 8 9 >numbers &&
+	git mv letters letters_side1 &&
+	git mv content file_or_directory &&
+	git add numbers &&
+	git commit -m side1 &&
+
+	git checkout side2 &&
+	git rm numbers &&
+	git mv letters letters_side2 &&
+	mkdir file_or_directory &&
+	echo hello >file_or_directory/world &&
+	git add file_or_directory/world &&
+	git commit -m side2 &&
+
+	git checkout -b resolution side1 &&
+	test_must_fail git merge side2 &&
+	test_write_lines 1 2 three 4 5 6 7 8 9 >numbers &&
+	git add numbers &&
+	git add letters_side1 &&
+	git rm letters &&
+	git rm letters_side2 &&
+	git add file_or_directory~HEAD &&
+	git mv file_or_directory~HEAD wanted_content &&
+	git commit -m resolved
+'
+
+test_expect_success 'remerge-diff with non-content conflicts' '
+	git log -1 --oneline resolution >tmp &&
+	cat <<-EOF >>tmp &&
+	diff --git a/file_or_directory~HASH (side1) b/wanted_content
+	similarity index 100%
+	rename from file_or_directory~HASH (side1)
+	rename to wanted_content
+	CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.
+	diff --git a/letters b/letters
+	CONFLICT (rename/rename): letters renamed to letters_side1 in HASH (side1) and to letters_side2 in HASH (side2).
+	diff --git a/letters_side2 b/letters_side2
+	deleted file mode 100644
+	index b236ae5..0000000
+	--- a/letters_side2
+	+++ /dev/null
+	@@ -1,9 +0,0 @@
+	-a
+	-b
+	-c
+	-d
+	-e
+	-f
+	-g
+	-h
+	-i
+	diff --git a/numbers b/numbers
+	CONFLICT (modify/delete): numbers deleted in HASH (side2) and modified in HASH (side1).  Version HASH (side1) of numbers left in tree.
+	EOF
+	# We still have some sha1 hashes above; rip them out so test works
+	# with sha256
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
+
+	git show --oneline --remerge-diff resolution >tmp &&
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
