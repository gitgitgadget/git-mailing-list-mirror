Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638DBC433EF
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 19:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiAUTMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 14:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiAUTMc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 14:12:32 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C78C06173D
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 11:12:31 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q22so1411540wrc.5
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 11:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TQX4ItZuNiKm8OI0It4i2/2ZCmlC3lFDheQASMMIr7c=;
        b=k9B1oHWO12gPovIwpgciEkvSSAhEr957ap+hbfQD2cRq0vNMqa04zJfkdouYeBOw+E
         w7yQUU1o+SIBozkOUZKY0hVzxfXnbxMlTNs4xT/lQyWApS/5fbHx17+lHncYjFo+fXWk
         vD947If8AUEUu46jWhk+oDXov5VeWOZnOS6pLm9PnutQzMu0Mx5posMXATyG67LCVfVB
         ita7l6pMVzfT30saipup04wQ4UZzK1voigAux/11DswN1aHi2ho4A5gTjJer5QHoSkAx
         MZRnAQhMXsA97mH0lQ65YpnpN2hMSL3TKamvG8yD7OcZxdlKCUdTSsZAqm8xF77EtHSb
         bQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TQX4ItZuNiKm8OI0It4i2/2ZCmlC3lFDheQASMMIr7c=;
        b=SzfNt8WTTLppe6VyK29mqQnzby8olcfCASgnOjaXSobMQtVp6DybekNof5040fafXb
         EsLAhC7LRYixaAjtkofg9/a1lI3759Kld/5XoHk8kFiSigdxGVwt3kdH4yjUxJgHYnLs
         NPOwauZaTG7BJZLv9l4qWYFq5uXVYV6aI4gtsdb0vTn4TEbQYc1iRSpVupS/W8xA37dM
         riLSX1wKeB0Ji15bUDibq5JiNX+t0vfw2o3bc9kgs9FbjiranQtcUbGQ/+1FuGCHyb10
         qdlTmi8D075uXiQav1tyIPHPMutdS943hw3ff2i0+QjrQcsqd0oE2iCKmuV614Pjiy6q
         YXZA==
X-Gm-Message-State: AOAM5311lOLgSz00zg98k/+bDnaydDCV1CXCVd2Ib+wZLAUcOjiRveVL
        A8ZVEXfv6t7a+7QbuvyJEYT5CVkCpX0=
X-Google-Smtp-Source: ABdhPJx9OCnFP3W9TUxdfs3o4bEU4AE8VbVm6KgsJYgAd0k2UQE+KkTFyTnVQVP5UXw1TC6O8QGSww==
X-Received: by 2002:a5d:5985:: with SMTP id n5mr4916150wri.309.1642792349983;
        Fri, 21 Jan 2022 11:12:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15sm7751896wrd.22.2022.01.21.11.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:12:29 -0800 (PST)
Message-Id: <17eccf7e0d6daed2c0934c481d6a52c5a77a0d34.1642792341.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
References: <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
        <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Jan 2022 19:12:18 +0000
Subject: [PATCH v4 08/10] show, log: include conflict/warning messages in
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
        Johannes Altmanninger <aclopte@gmail.com>,
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
 log-tree.c              |  51 ++++++++++++++
 merge-ort.c             |   1 +
 merge-ort.h             |  10 +++
 t/t4069-remerge-diff.sh | 144 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 206 insertions(+)

diff --git a/log-tree.c b/log-tree.c
index 33c28f537a6..85bfd9e50d8 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -19,6 +19,7 @@
 #include "line-log.h"
 #include "help.h"
 #include "range-diff.h"
+#include "strmap.h"
 
 static struct decoration name_decoration = { "object names" };
 static int decoration_loaded;
@@ -905,6 +906,52 @@ static int do_diff_combined(struct rev_info *opt, struct commit *commit)
 	return !opt->loginfo;
 }
 
+static void setup_additional_headers(struct diff_options *o,
+				     struct strmap *all_headers)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	/*
+	 * Make o->additional_path_headers contain the subset of all_headers
+	 * that match o->pathspec.  If there aren't any that match o->pathspec,
+	 * then make o->additional_path_headers be NULL.
+	 */
+
+	if (!o->pathspec.nr) {
+		o->additional_path_headers = all_headers;
+		return;
+	}
+
+	o->additional_path_headers = xmalloc(sizeof(struct strmap));
+	strmap_init_with_options(o->additional_path_headers, NULL, 0);
+	strmap_for_each_entry(all_headers, &iter, entry) {
+		if (match_pathspec(the_repository->index, &o->pathspec,
+				   entry->key, strlen(entry->key),
+				   0 /* prefix */, NULL /* seen */,
+				   0 /* is_dir */))
+			strmap_put(o->additional_path_headers,
+				   entry->key, entry->value);
+	}
+	if (!strmap_get_size(o->additional_path_headers)) {
+		strmap_clear(o->additional_path_headers, 0);
+		FREE_AND_NULL(o->additional_path_headers);
+	}
+}
+
+static void cleanup_additional_headers(struct diff_options *o)
+{
+	if (!o->pathspec.nr) {
+		o->additional_path_headers = NULL;
+		return;
+	}
+	if (!o->additional_path_headers)
+		return;
+
+	strmap_clear(o->additional_path_headers, 0);
+	FREE_AND_NULL(o->additional_path_headers);
+}
+
 static int do_remerge_diff(struct rev_info *opt,
 			   struct commit_list *parents,
 			   struct object_id *oid,
@@ -922,6 +969,8 @@ static int do_remerge_diff(struct rev_info *opt,
 	/* Setup merge options */
 	init_merge_options(&o, the_repository);
 	o.show_rename_progress = 0;
+	o.record_conflict_msgs_as_headers = 1;
+	o.msg_header_prefix = "remerge";
 
 	ctx.abbrev = DEFAULT_ABBREV;
 	format_commit_message(parent1, "%h (%s)", &parent1_desc, &ctx);
@@ -938,10 +987,12 @@ static int do_remerge_diff(struct rev_info *opt,
 	merge_incore_recursive(&o, bases, parent1, parent2, &res);
 
 	/* Show the diff */
+	setup_additional_headers(&opt->diffopt, res.path_messages);
 	diff_tree_oid(&res.tree->object.oid, oid, "", &opt->diffopt);
 	log_tree_diff_flush(opt);
 
 	/* Cleanup */
+	cleanup_additional_headers(&opt->diffopt);
 	strbuf_release(&parent1_desc);
 	strbuf_release(&parent2_desc);
 	merge_finalize(&o, &res);
diff --git a/merge-ort.c b/merge-ort.c
index 481305d2bcf..43f980d2586 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4585,6 +4585,7 @@ redo:
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
index 5ef191f4fc9..86c5a33bd77 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -59,6 +59,7 @@ test_expect_success 'remerge-diff with both a resolved conflict and an unrelated
 	git log -1 --oneline ab_resolution >tmp &&
 	cat <<-EOF >>tmp &&
 	diff --git a/numbers b/numbers
+	remerge CONFLICT (content): Merge conflict in numbers
 	index a1fb731..6875544 100644
 	--- a/numbers
 	+++ b/numbers
@@ -87,4 +88,147 @@ test_expect_success 'remerge-diff with both a resolved conflict and an unrelated
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
+	remerge CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.
+	diff --git a/letters b/letters
+	remerge CONFLICT (rename/rename): letters renamed to letters_side1 in HASH (side1) and to letters_side2 in HASH (side2).
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
+	remerge CONFLICT (modify/delete): numbers deleted in HASH (side2) and modified in HASH (side1).  Version HASH (side1) of numbers left in tree.
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
+test_expect_success 'remerge-diff w/ diff-filter=U: all conflict headers, no diff content' '
+	git log -1 --oneline resolution >tmp &&
+	cat <<-EOF >>tmp &&
+	diff --git a/file_or_directory~HASH (side1) b/file_or_directory~HASH (side1)
+	remerge CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.
+	diff --git a/letters b/letters
+	remerge CONFLICT (rename/rename): letters renamed to letters_side1 in HASH (side1) and to letters_side2 in HASH (side2).
+	diff --git a/numbers b/numbers
+	remerge CONFLICT (modify/delete): numbers deleted in HASH (side2) and modified in HASH (side1).  Version HASH (side1) of numbers left in tree.
+	EOF
+	# We still have some sha1 hashes above; rip them out so test works
+	# with sha256
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
+
+	git show --oneline --remerge-diff --diff-filter=U resolution >tmp &&
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'remerge-diff w/ diff-filter=R: relevant file + conflict header' '
+	git log -1 --oneline resolution >tmp &&
+	cat <<-EOF >>tmp &&
+	diff --git a/file_or_directory~HASH (side1) b/wanted_content
+	similarity index 100%
+	rename from file_or_directory~HASH (side1)
+	rename to wanted_content
+	remerge CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.
+	EOF
+	# We still have some sha1 hashes above; rip them out so test works
+	# with sha256
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
+
+	git show --oneline --remerge-diff --diff-filter=R resolution >tmp &&
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'remerge-diff w/ pathspec: limits to relevant file including conflict header' '
+	git log -1 --oneline resolution >tmp &&
+	cat <<-EOF >>tmp &&
+	diff --git a/letters b/letters
+	remerge CONFLICT (rename/rename): letters renamed to letters_side1 in HASH (side1) and to letters_side2 in HASH (side2).
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
+	EOF
+	# We still have some sha1 hashes above; rip them out so test works
+	# with sha256
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
+
+	git show --oneline --remerge-diff --full-history resolution -- "letters*" >tmp &&
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

