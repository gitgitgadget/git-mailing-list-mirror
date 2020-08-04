Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CA5C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 16:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D445F2177B
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 16:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJSYLBlM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgHDQZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729620AbgHDQZr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 12:25:47 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86932C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 09:25:47 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 77so6620231qkm.5
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 09:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gkWcsBiJkSf1Y+aEd3wNCyjUkKQJLk65Vsm4EAHv75Y=;
        b=eJSYLBlMhhqMUp6bLoh0xXAxKcCdqsChP2eWT7yY8HcAVYQ8jV0suEZuaJbz/wnnpt
         NUHdyDq6epAlh9bEcof4+kdD293kh2ETQJkOPAYkMhZfX8mfHlOMA1pFzDXUHCj8q5My
         KLnxJ2qtLhScXxMgZYfH5MDdfyN122r4WnRO9h4vGfFq+aen9w95nxx+SyZgkozdFgrN
         h6K05nfRIhLhMHIdz1F3VhLu4/QX72GAcF7UFAoGnnTscri+NqIrGBrmIyUSdlrvvkGB
         93i/hoTLM292xR3alubN8GgS66PCRfabxmJkkb1BKCEC+9Iq8KdLMH4JB2jMskABvY3H
         qftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gkWcsBiJkSf1Y+aEd3wNCyjUkKQJLk65Vsm4EAHv75Y=;
        b=qwDXCXEQvbnZj5a+nq+jMy+IUvRMiyt3z2Z8Fu3iELYbAMXb5Kr2NYunuGcr1kgDCE
         t1f+Mi1MxfgK82jgn1/mZU0O58KE445B5UVNeytxerTGmRKSf5FBhl0qgoE++MgTW0jY
         aes10aGcc99CN9tpCDEqqFMtoVeW5rouyjQIf7FIgbKXjCZ4YD51puuEfcATnodRKJgP
         7Sjy+DGPllPGUY4cB7YGTE22vC9fepJLayYyE4lgTqpbv/o8qDddVfK2sBBXEF8SqUD2
         QxAXG05E0+GhzWfgtglr1YVWmclDWKN7Taoo9UV7F2TC+MZS4oCX199uKLv+ga+beRDm
         Z6nA==
X-Gm-Message-State: AOAM531VjMkrDPv13jnkv7CPuEnQw0VewO6XB3du4xkHWmFkZhkv9thV
        /0jm+q0DvZPmdhg1GF5NGXU=
X-Google-Smtp-Source: ABdhPJzVTojHucz9qKfG1kdPyO1C7qaGHMgvY/ivcNBqft0M6BufoxcWRYT5mYUMehkXfNUH3Mpozw==
X-Received: by 2002:a05:620a:2:: with SMTP id j2mr20806365qki.497.1596558346563;
        Tue, 04 Aug 2020 09:25:46 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:359e:33e7:c1bc:799? ([2600:1700:e72:80a0:359e:33e7:c1bc:799])
        by smtp.gmail.com with ESMTPSA id 9sm24536345qtg.4.2020.08.04.09.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 09:25:46 -0700 (PDT)
Subject: Re: [PATCH v4 05/15] diff: halt tree-diff early after max_changes
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
 <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
 <2d4c0b2da38632424c8bd31ccb2037e0676c3c74.1586192395.git.gitgitgadget@gmail.com>
 <20200804144724.GA25052@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a08c26bb-54ec-13af-e503-fccd68727cf3@gmail.com>
Date:   Tue, 4 Aug 2020 12:25:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200804144724.GA25052@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2020 10:47 AM, SZEDER Gábor wrote:
> On Mon, Apr 06, 2020 at 04:59:45PM +0000, Derrick Stolee via GitGitGadget wrote:
> This counter is basically broken, its value is wrong for over 98% of
> commits, and, worse, its value remains 0 for over 85% of commits in
> the repositories I usually use to test modified path Bloom filters.
> Consequently, a relatively large number of commits modifying more than
> 512 paths get Bloom filters.

Thanks for finding this! The counter is only really tested in one
place, and that test only considers _file adds_, which is a problem.

If I understand this correctly, the bug is a performance-only bug
(since this is a performance-only feature), but it is an important
one to fix.

There is certainly some dark magic happening in this tree-diff logic,
so instead of trying to get an accurate count we should just use the
magic global diff_queued_diff to track the current list of file changes.

Note: diff_queued_diff does not track the directory changes, so it
is an under-count for the total changes to track in the Bloom filter.
This is later corrected by the block that adds these leading directory
changes.

> The makeshift tests in the patch below demonstrate these issues as
> most of them fail, most notably those two tests that demonstrate that
> modifying existing paths are not counted at all.

I adapted your diff along with ripping out 'num_changes' in favor
of diff_queued_diff.nr. This required modifying some of your expected
values in the test script (losing the leading directories in the
count).

I'll work with Taylor to create a fix, and include proper testing
of the logic here. We'll stick it in the v2 of his max-changed-paths
series [1]. He already has some helpful logging that can help create
tests that ensure this logic is performing as expected.

We plan to have that fix available by later today or early tomorrow.
Will you be available to help validate it?

[1] https://lore.kernel.org/git/cover.1596480582.git.me@ttaylorr.com/

Thanks,
-Stolee

  --- >8 ---

diff --git a/bloom.c b/bloom.c
index 1a573226e7..b8d6cb9240 100644
--- a/bloom.c
+++ b/bloom.c
@@ -218,8 +218,9 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	else
 		diff_tree_oid(NULL, &c->object.oid, "", &diffopt);
 	diffcore_std(&diffopt);
+	printf("%s  %d\n", oid_to_hex(&c->object.oid), diff_queued_diff.nr);
 
-	if (diffopt.num_changes <= max_changes) {
+	if (diff_queued_diff.nr <= max_changes) {
 		struct hashmap pathmap;
 		struct pathmap_hash_entry *e;
 		struct hashmap_iter iter;
diff --git a/diff.h b/diff.h
index e0c0af6286b..1d32b718857 100644
--- a/diff.h
+++ b/diff.h
@@ -287,8 +287,6 @@ struct diff_options {
 
 	/* If non-zero, then stop computing after this many changes. */
 	int max_changes;
-	/* For internal use only. */
-	int num_changes;
 
 	int ita_invisible_in_index;
 /* white-space error highlighting */
diff --git a/t/t9999-test.sh b/t/t9999-test.sh
new file mode 100755
index 00000000000..1f35aa8e2c5
--- /dev/null
+++ b/t/t9999-test.sh
@@ -0,0 +1,142 @@
+#!/bin/sh
+
+test_description='test'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_tick &&
+
+	echo 1 >file &&
+	mkdir -p dir/subdir &&
+	echo 1 >dir/subdir/file1 &&
+	echo 1 >dir/subdir/file2 &&
+	git add file dir &&
+	git commit -m setup &&
+
+	echo 2 >file &&
+	git commit -a -m "modify one path in root" &&
+	mod_one_path=$(git rev-parse HEAD) &&
+
+	echo 2 >dir/subdir/file1 &&
+	echo 2 >dir/subdir/file2 &&
+	git commit -a -m "modify two file two dirs deep" &&
+	mod_four_paths=$(git rev-parse HEAD) &&
+
+	>new-file &&
+	git add new-file &&
+	git commit -m "add new file in root" &&
+	new_file_in_root=$(git rev-parse HEAD) &&
+
+	git rm new-file &&
+	git commit -m "delete file in root" &&
+	delete_file_in_root=$(git rev-parse HEAD) &&
+
+	>dir/new-file &&
+	git add dir/new-file &&
+	git commit -m "add new file in dir" &&
+	new_file_in_dir=$(git rev-parse HEAD) &&
+
+	git rm dir/new-file &&
+	git commit -m "delete file in dir" &&
+	delete_file_in_dir=$(git rev-parse HEAD) &&
+
+	echo 1 >d-f &&
+	git add d-f &&
+	git commit -m foo &&
+	git rm d-f &&
+	mkdir d-f &&
+	echo 2 >d-f/file &&
+	git add d-f &&
+	git commit -m "replace file with dir" &&
+	file_to_dir=$(git rev-parse HEAD) &&
+
+	>d-f.c &&
+	git add d-f.c &&
+	git commit -m "add a file that sorts between d-f and d-f/" &&
+	git rm -r d-f &&
+	echo 3 >d-f &&
+	git add d-f &&
+	git commit -m "replace dir with file" &&
+	dir_to_file=$(git rev-parse HEAD) &&
+
+	bin_sha1=$(git rev-parse HEAD:dir/subdir | hex2oct) &&
+	# leading zero in mode: the content of the tree remains the same,
+	# but its oid does change!
+	printf "040000 subdir\0$bin_sha1" >rawtree &&
+	tree1=$(git hash-object -t tree -w rawtree) &&
+	git cat-file -p HEAD^{tree} >out &&
+	tree2=$(sed -e "s/$(git rev-parse HEAD:dir/)/$tree1/" out |git mktree) &&
+	different_but_same_tree=$(git commit-tree \
+		-m "leading zeros in mode" \
+		-p $(git rev-parse HEAD) $tree2) &&
+	git update-ref HEAD $different_but_same_tree &&
+
+	git commit-graph write --reachable --changed-paths >out &&
+	cat out  # debug
+'
+
+test_expect_success 'modify one path in root' '
+	git diff --name-status $mod_one_path^ $mod_one_path &&
+	echo "$mod_one_path  1" >expect &&
+	grep "$mod_one_path" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'modify two file two dirs deep' '
+	git diff --name-status $mod_four_paths^ $mod_four_paths &&
+	echo "$mod_four_paths  2" >expect &&
+	grep "$mod_four_paths" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'add new file in root' '
+	git diff --name-status $new_file_in_root^ $new_file_in_root &&
+	echo "$new_file_in_root  1" >expect &&
+	grep "$new_file_in_root" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'delete file in root' '
+	git diff --name-status $delete_file_in_root^ $delete_file_in_root &&
+	echo "$delete_file_in_root  1" >expect &&
+	grep "$delete_file_in_root" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'add new file in dir' '
+	git diff --name-status $new_file_in_dir^ $new_file_in_dir &&
+	echo "$new_file_in_dir  1" >expect &&
+	grep "$new_file_in_dir" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'delete file in dir' '
+	git diff --name-status $delete_file_in_dir^ $delete_file_in_dir &&
+	echo "$delete_file_in_dir  1" >expect &&
+	grep "$delete_file_in_dir" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'replace file with dir' '
+	git diff --name-status $file_to_dir^ $file_to_dir &&
+	echo "$file_to_dir  2" >expect &&
+	grep "$file_to_dir" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'replace dir with file' '
+	git diff --name-status $dir_to_file^ $dir_to_file &&
+	echo "$dir_to_file  2" >expect &&
+	grep "$dir_to_file" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'leading zeros in mode' '
+	git diff --name-status $different_but_same_tree^ $different_but_same_tree &&
+	echo "$different_but_same_tree  0" >expect &&
+	grep "$different_but_same_tree" out >actual &&
+	test_cmp expect actual
+'
+
+test_done
diff --git a/tree-diff.c b/tree-diff.c
index 6ebad1a46f3..7cebbb327e2 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -434,7 +434,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 		if (diff_can_quit_early(opt))
 			break;
 
-		if (opt->max_changes && opt->num_changes > opt->max_changes)
+		if (opt->max_changes && diff_queued_diff.nr > opt->max_changes)
 			break;
 
 		if (opt->pathspec.nr) {
@@ -521,7 +521,6 @@ static struct combine_diff_path *ll_diff_tree_paths(
 
 			/* t↓ */
 			update_tree_entry(&t);
-			opt->num_changes++;
 		}
 
 		/* t > p[imin] */
@@ -539,7 +538,6 @@ static struct combine_diff_path *ll_diff_tree_paths(
 		skip_emit_tp:
 			/* ∀ pi=p[imin]  pi↓ */
 			update_tp_entries(tp, nparent);
-			opt->num_changes++;
 		}
 	}
 
@@ -557,7 +555,6 @@ struct combine_diff_path *diff_tree_paths(
 	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt)
 {
-	opt->num_changes = 0;
 	p = ll_diff_tree_paths(p, oid, parents_oid, nparent, base, opt);
 
 	/*
