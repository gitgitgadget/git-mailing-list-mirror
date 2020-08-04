Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAD3C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 17:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84FC022B40
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 17:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Se/jzkYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgHDRAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgHDRAq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 13:00:46 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5CCC06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 10:00:45 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a26so17439952ejc.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 10:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7UT4blmOkL/SudWrh5eWZZV83P9zPoSb2sdeMtWgrxc=;
        b=Se/jzkYc04S3rprfFLrl+Sbvckafq6Fl1o7xIXGtUJkZwoVFfisY+C2tPTbBbOO+OE
         R+FjBalfQqKqp+0xBHNXUqQaWWI09378BaA9LHxyN1Ltk+fkW69l01E9hdrQG2+GwW7s
         S+lxw/P8Al8u6E962BMdRb+FI+LYHr1hZ43JnN2jssUnW07BDDEkG6YI83ZU2SlVIcGj
         /gWHWZipan9DHufH7Q7Br9Y3WhIKtIID5xYhDII68cvqmJQddFERxlKd9NCbC19kfmtU
         e5aHmSUXUjwBk8ppWrnx+WRBzrDhsHYzrXAuzAQQEzYHi7cjVOB1NHgg7oAEkRl4jBqW
         rAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7UT4blmOkL/SudWrh5eWZZV83P9zPoSb2sdeMtWgrxc=;
        b=FcPwPjhdy8OqrW2WkycDDgFQHROhX5M426ELnUURO3VixWcY4uvi9CikBHvnBJ7Bi1
         eB6xhOpWkQCJ6r6VXNHUExVLvE+13Mo96eiTYT9hcwIyhBUNLn9wsrlZ+im0Cnj6kKi6
         DDs5INxZJ3tl3r8PftvUrpV1odWKn66Y2ZIGTTndP3LsDT1krBV1GoDei3+I71fnL99T
         NWz4aonl1n+KQooxBZ7falHPjs/ae+5FhK+CKwuG47GqpoN6N8HYBUCJH/IcgmaOisM1
         ISN+RfV+FT+8Flm9u/3OY5NK8kDihGck3c+cMP+KBIf8GSIjd1WOtyAt+5sA+3MQ1uqd
         aS6g==
X-Gm-Message-State: AOAM532R6WMJII/296mX6Lo8BFu4Bk9Dml6xyvKLHC3swgFfHHbs4QZ8
        JgJYfpc+OJXlrZ9XZLUQBI8=
X-Google-Smtp-Source: ABdhPJyBOrmK0rw86EnOS7veYryGjn2zQ7dZXdawWs59ZMMbYj1Q1GiyON3iVHNLWLcXfWBrLAuXSg==
X-Received: by 2002:a17:906:1ec3:: with SMTP id m3mr22919978ejj.197.1596560443784;
        Tue, 04 Aug 2020 10:00:43 -0700 (PDT)
Received: from szeder.dev (94-21-29-171.pool.digikabel.hu. [94.21.29.171])
        by smtp.gmail.com with ESMTPSA id le20sm18810994ejb.96.2020.08.04.10.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 10:00:42 -0700 (PDT)
Date:   Tue, 4 Aug 2020 19:00:40 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 05/15] diff: halt tree-diff early after max_changes
Message-ID: <20200804170040.GB25052@szeder.dev>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
 <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
 <2d4c0b2da38632424c8bd31ccb2037e0676c3c74.1586192395.git.gitgitgadget@gmail.com>
 <20200804144724.GA25052@szeder.dev>
 <a08c26bb-54ec-13af-e503-fccd68727cf3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a08c26bb-54ec-13af-e503-fccd68727cf3@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 04, 2020 at 12:25:45PM -0400, Derrick Stolee wrote:
> On 8/4/2020 10:47 AM, SZEDER Gábor wrote:
> > On Mon, Apr 06, 2020 at 04:59:45PM +0000, Derrick Stolee via GitGitGadget wrote:
> > This counter is basically broken, its value is wrong for over 98% of
> > commits, and, worse, its value remains 0 for over 85% of commits in
> > the repositories I usually use to test modified path Bloom filters.
> > Consequently, a relatively large number of commits modifying more than
> > 512 paths get Bloom filters.
> 
> Thanks for finding this! The counter is only really tested in one
> place, and that test only considers _file adds_, which is a problem.
> 
> If I understand this correctly, the bug is a performance-only bug
> (since this is a performance-only feature), but it is an important
> one to fix.

Or a performance-only feature in a performance-only feature, because
those additional modified path Bloom filters can improve the runtime
of pathspec-limited revision walks (assuming that the false positive
rate is low enough).

> There is certainly some dark magic happening in this tree-diff logic,
> so instead of trying to get an accurate count we should just use the
> magic global diff_queued_diff to track the current list of file changes.
> 
> Note: diff_queued_diff does not track the directory changes, so it
> is an under-count for the total changes to track in the Bloom filter.
> This is later corrected by the block that adds these leading directory
> changes.
> 
> > The makeshift tests in the patch below demonstrate these issues as
> > most of them fail, most notably those two tests that demonstrate that
> > modifying existing paths are not counted at all.
> 
> I adapted your diff along with ripping out 'num_changes' in favor
> of diff_queued_diff.nr. This required modifying some of your expected
> values in the test script (losing the leading directories in the
> count).
> 
> I'll work with Taylor to create a fix, and include proper testing
> of the logic here. We'll stick it in the v2 of his max-changed-paths
> series [1]. He already has some helpful logging that can help create
> tests that ensure this logic is performing as expected.

Don't forget to include a check of the hashmap's size, to make sure.

FWIW, the patch below does result in the correct count (read: the same
as in my implemenation) for all but 4 commits in those repositories I
use for testing, without adding any memory allocations and extra
strcmp() calls.

  ---  >8  ---

diff --git a/cache.h b/cache.h
index 0f0485ecfe..3fc7e1b427 100644
--- a/cache.h
+++ b/cache.h
@@ -1574,6 +1574,7 @@ int repo_interpret_branch_name(struct repository *r,
 int validate_headref(const char *ref);
 
 int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
+int base_name_compare_df(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2, int *df);
 int df_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
 int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
 int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
diff --git a/read-cache.c b/read-cache.c
index aa427c5c17..041af19e60 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -460,13 +460,16 @@ int ie_modified(struct index_state *istate,
 	return 0;
 }
 
-int base_name_compare(const char *name1, int len1, int mode1,
-		      const char *name2, int len2, int mode2)
+int base_name_compare_df(const char *name1, int len1, int mode1,
+			 const char *name2, int len2, int mode2,
+			 int *df)
 {
 	unsigned char c1, c2;
 	int len = len1 < len2 ? len1 : len2;
 	int cmp;
 
+	*df = 0;
+
 	cmp = memcmp(name1, name2, len);
 	if (cmp)
 		return cmp;
@@ -476,7 +479,21 @@ int base_name_compare(const char *name1, int len1, int mode1,
 		c1 = '/';
 	if (!c2 && S_ISDIR(mode2))
 		c2 = '/';
-	return (c1 < c2) ? -1 : (c1 > c2) ? 1 : 0;
+	if (c1 == c2)
+		return 0;	/* TODO: is this even possible? */
+	if ((c1 == '/' && !c2) ||
+	    (!c1 && c2 == '/'))
+		*df = 1;
+	return (c1 < c2) ? -1 : 1;
+}
+
+int base_name_compare(const char *name1, int len1, int mode1,
+		      const char *name2, int len2, int mode2)
+{
+	int unused;
+	return base_name_compare_df(name1, len1, mode1,
+				    name2, len2, mode2,
+				    &unused);
 }
 
 /*
diff --git a/t/t9999-test.sh b/t/t9999-test.sh
index 8d2bd9f03f..4f08590b45 100755
--- a/t/t9999-test.sh
+++ b/t/t9999-test.sh
@@ -125,7 +125,7 @@ test_expect_success 'replace file with dir' '
 	test_cmp expect actual
 '
 
-test_expect_success 'replace dir with file' '
+test_expect_failure 'replace dir with file' '
 	git diff --name-status $dir_to_file^ $dir_to_file &&
 	echo "$dir_to_file  2" >expect &&
 	grep "$dir_to_file" out >actual &&
diff --git a/tree-diff.c b/tree-diff.c
index f3d303c6e5..e27f9c805e 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -46,11 +46,14 @@ static int ll_diff_tree_oid(const struct object_id *old_oid,
  *      Due to this convention, if trees are scanned in sorted order, all
  *      non-empty descriptors will be processed first.
  */
-static int tree_entry_pathcmp(struct tree_desc *t1, struct tree_desc *t2)
+static int tree_entry_pathcmp(struct tree_desc *t1, struct tree_desc *t2,
+			      int *df)
 {
 	struct name_entry *e1, *e2;
 	int cmp;
 
+	*df = 0;
+
 	/* empty descriptors sort after valid tree entries */
 	if (!t1->size)
 		return t2->size ? 1 : 0;
@@ -59,8 +62,9 @@ static int tree_entry_pathcmp(struct tree_desc *t1, struct tree_desc *t2)
 
 	e1 = &t1->entry;
 	e2 = &t2->entry;
-	cmp = base_name_compare(e1->path, tree_entry_len(e1), e1->mode,
-				e2->path, tree_entry_len(e2), e2->mode);
+	cmp = base_name_compare_df(e1->path, tree_entry_len(e1), e1->mode,
+				   e2->path, tree_entry_len(e2), e2->mode,
+				   df);
 	return cmp;
 }
 
@@ -410,7 +414,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 {
 	struct tree_desc t, *tp;
 	void *ttree, **tptree;
-	int i;
+	int i, df;
 
 	FAST_ARRAY_ALLOC(tp, nparent);
 	FAST_ARRAY_ALLOC(tptree, nparent);
@@ -463,7 +467,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 		tp[0].entry.mode &= ~S_IFXMIN_NEQ;
 
 		for (i = 1; i < nparent; ++i) {
-			cmp = tree_entry_pathcmp(&tp[i], &tp[imin]);
+			cmp = tree_entry_pathcmp(&tp[i], &tp[imin], &df);
 			if (cmp < 0) {
 				imin = i;
 				tp[i].entry.mode &= ~S_IFXMIN_NEQ;
@@ -483,10 +487,12 @@ static struct combine_diff_path *ll_diff_tree_paths(
 
 
 		/* compare t vs p[imin] */
-		cmp = tree_entry_pathcmp(&t, &tp[imin]);
+		cmp = tree_entry_pathcmp(&t, &tp[imin], &df);
 
 		/* t = p[imin] */
 		if (cmp == 0) {
+			int prev_num_changes = opt->num_changes;
+
 			/* are either pi > p[imin] or diff(t,pi) != ø ? */
 			if (!opt->flags.find_copies_harder) {
 				for (i = 0; i < nparent; ++i) {
@@ -506,6 +512,9 @@ static struct combine_diff_path *ll_diff_tree_paths(
 			/* D += {δ(t,pi) if pi=p[imin];  "+a" if pi > p[imin]} */
 			p = emit_path(p, base, opt, nparent,
 					&t, tp, imin);
+			if (!(opt->num_changes == prev_num_changes &&
+			      S_ISDIR(t.entry.mode)))
+				opt->num_changes++;
 
 		skip_emit_t_tp:
 			/* t↓,  ∀ pi=p[imin]  pi↓ */
@@ -518,10 +527,11 @@ static struct combine_diff_path *ll_diff_tree_paths(
 			/* D += "+t" */
 			p = emit_path(p, base, opt, nparent,
 					&t, /*tp=*/NULL, -1);
+			if (!df)
+				opt->num_changes++;
 
 			/* t↓ */
 			update_tree_entry(&t);
-			opt->num_changes++;
 		}
 
 		/* t > p[imin] */
@@ -535,11 +545,12 @@ static struct combine_diff_path *ll_diff_tree_paths(
 
 			p = emit_path(p, base, opt, nparent,
 					/*t=*/NULL, tp, imin);
+			if (!df)
+				opt->num_changes++;
 
 		skip_emit_tp:
 			/* ∀ pi=p[imin]  pi↓ */
 			update_tp_entries(tp, nparent);
-			opt->num_changes++;
 		}
 	}
 
  ---  >8  ---


Having said that, the best (i.e faster and accurate) solution to this
issue is probably:

  - Update the callchain between diff_tree_oid() and the diff callback
    functions to allow the callbacks to break diffing with a non-zero
    error code.

  - Fill Bloom filters using the approach presented in:

      https://public-inbox.org/git/20200529085038.26008-21-szeder.dev@gmail.com/

    but modify the callbacks to return non-zero when too many paths
    have been processed.

  - Drop this counter entirely, as there are no other users.

> We plan to have that fix available by later today or early tomorrow.
> Will you be available to help validate it?
> 
> [1] https://lore.kernel.org/git/cover.1596480582.git.me@ttaylorr.com/
> 
> Thanks,
> -Stolee
> 
>   --- >8 ---
> 
> diff --git a/bloom.c b/bloom.c
> index 1a573226e7..b8d6cb9240 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -218,8 +218,9 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
>  	else
>  		diff_tree_oid(NULL, &c->object.oid, "", &diffopt);
>  	diffcore_std(&diffopt);
> +	printf("%s  %d\n", oid_to_hex(&c->object.oid), diff_queued_diff.nr);
>  
> -	if (diffopt.num_changes <= max_changes) {
> +	if (diff_queued_diff.nr <= max_changes) {
>  		struct hashmap pathmap;
>  		struct pathmap_hash_entry *e;
>  		struct hashmap_iter iter;
> diff --git a/diff.h b/diff.h
> index e0c0af6286b..1d32b718857 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -287,8 +287,6 @@ struct diff_options {
>  
>  	/* If non-zero, then stop computing after this many changes. */
>  	int max_changes;
> -	/* For internal use only. */
> -	int num_changes;
>  
>  	int ita_invisible_in_index;
>  /* white-space error highlighting */
> diff --git a/t/t9999-test.sh b/t/t9999-test.sh
> new file mode 100755
> index 00000000000..1f35aa8e2c5
> --- /dev/null
> +++ b/t/t9999-test.sh
> @@ -0,0 +1,142 @@
> +#!/bin/sh
> +
> +test_description='test'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	test_tick &&
> +
> +	echo 1 >file &&
> +	mkdir -p dir/subdir &&
> +	echo 1 >dir/subdir/file1 &&
> +	echo 1 >dir/subdir/file2 &&
> +	git add file dir &&
> +	git commit -m setup &&
> +
> +	echo 2 >file &&
> +	git commit -a -m "modify one path in root" &&
> +	mod_one_path=$(git rev-parse HEAD) &&
> +
> +	echo 2 >dir/subdir/file1 &&
> +	echo 2 >dir/subdir/file2 &&
> +	git commit -a -m "modify two file two dirs deep" &&
> +	mod_four_paths=$(git rev-parse HEAD) &&
> +
> +	>new-file &&
> +	git add new-file &&
> +	git commit -m "add new file in root" &&
> +	new_file_in_root=$(git rev-parse HEAD) &&
> +
> +	git rm new-file &&
> +	git commit -m "delete file in root" &&
> +	delete_file_in_root=$(git rev-parse HEAD) &&
> +
> +	>dir/new-file &&
> +	git add dir/new-file &&
> +	git commit -m "add new file in dir" &&
> +	new_file_in_dir=$(git rev-parse HEAD) &&
> +
> +	git rm dir/new-file &&
> +	git commit -m "delete file in dir" &&
> +	delete_file_in_dir=$(git rev-parse HEAD) &&
> +
> +	echo 1 >d-f &&
> +	git add d-f &&
> +	git commit -m foo &&
> +	git rm d-f &&
> +	mkdir d-f &&
> +	echo 2 >d-f/file &&
> +	git add d-f &&
> +	git commit -m "replace file with dir" &&
> +	file_to_dir=$(git rev-parse HEAD) &&
> +
> +	>d-f.c &&
> +	git add d-f.c &&
> +	git commit -m "add a file that sorts between d-f and d-f/" &&
> +	git rm -r d-f &&
> +	echo 3 >d-f &&
> +	git add d-f &&
> +	git commit -m "replace dir with file" &&
> +	dir_to_file=$(git rev-parse HEAD) &&
> +
> +	bin_sha1=$(git rev-parse HEAD:dir/subdir | hex2oct) &&
> +	# leading zero in mode: the content of the tree remains the same,
> +	# but its oid does change!
> +	printf "040000 subdir\0$bin_sha1" >rawtree &&
> +	tree1=$(git hash-object -t tree -w rawtree) &&
> +	git cat-file -p HEAD^{tree} >out &&
> +	tree2=$(sed -e "s/$(git rev-parse HEAD:dir/)/$tree1/" out |git mktree) &&
> +	different_but_same_tree=$(git commit-tree \
> +		-m "leading zeros in mode" \
> +		-p $(git rev-parse HEAD) $tree2) &&
> +	git update-ref HEAD $different_but_same_tree &&
> +
> +	git commit-graph write --reachable --changed-paths >out &&
> +	cat out  # debug
> +'
> +
> +test_expect_success 'modify one path in root' '
> +	git diff --name-status $mod_one_path^ $mod_one_path &&
> +	echo "$mod_one_path  1" >expect &&
> +	grep "$mod_one_path" out >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'modify two file two dirs deep' '
> +	git diff --name-status $mod_four_paths^ $mod_four_paths &&
> +	echo "$mod_four_paths  2" >expect &&
> +	grep "$mod_four_paths" out >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'add new file in root' '
> +	git diff --name-status $new_file_in_root^ $new_file_in_root &&
> +	echo "$new_file_in_root  1" >expect &&
> +	grep "$new_file_in_root" out >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'delete file in root' '
> +	git diff --name-status $delete_file_in_root^ $delete_file_in_root &&
> +	echo "$delete_file_in_root  1" >expect &&
> +	grep "$delete_file_in_root" out >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'add new file in dir' '
> +	git diff --name-status $new_file_in_dir^ $new_file_in_dir &&
> +	echo "$new_file_in_dir  1" >expect &&
> +	grep "$new_file_in_dir" out >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'delete file in dir' '
> +	git diff --name-status $delete_file_in_dir^ $delete_file_in_dir &&
> +	echo "$delete_file_in_dir  1" >expect &&
> +	grep "$delete_file_in_dir" out >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'replace file with dir' '
> +	git diff --name-status $file_to_dir^ $file_to_dir &&
> +	echo "$file_to_dir  2" >expect &&
> +	grep "$file_to_dir" out >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'replace dir with file' '
> +	git diff --name-status $dir_to_file^ $dir_to_file &&
> +	echo "$dir_to_file  2" >expect &&
> +	grep "$dir_to_file" out >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'leading zeros in mode' '
> +	git diff --name-status $different_but_same_tree^ $different_but_same_tree &&
> +	echo "$different_but_same_tree  0" >expect &&
> +	grep "$different_but_same_tree" out >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_done
> diff --git a/tree-diff.c b/tree-diff.c
> index 6ebad1a46f3..7cebbb327e2 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -434,7 +434,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
>  		if (diff_can_quit_early(opt))
>  			break;
>  
> -		if (opt->max_changes && opt->num_changes > opt->max_changes)
> +		if (opt->max_changes && diff_queued_diff.nr > opt->max_changes)
>  			break;
>  
>  		if (opt->pathspec.nr) {
> @@ -521,7 +521,6 @@ static struct combine_diff_path *ll_diff_tree_paths(
>  
>  			/* t↓ */
>  			update_tree_entry(&t);
> -			opt->num_changes++;
>  		}
>  
>  		/* t > p[imin] */
> @@ -539,7 +538,6 @@ static struct combine_diff_path *ll_diff_tree_paths(
>  		skip_emit_tp:
>  			/* ∀ pi=p[imin]  pi↓ */
>  			update_tp_entries(tp, nparent);
> -			opt->num_changes++;
>  		}
>  	}
>  
> @@ -557,7 +555,6 @@ struct combine_diff_path *diff_tree_paths(
>  	const struct object_id **parents_oid, int nparent,
>  	struct strbuf *base, struct diff_options *opt)
>  {
> -	opt->num_changes = 0;
>  	p = ll_diff_tree_paths(p, oid, parents_oid, nparent, base, opt);
>  
>  	/*
