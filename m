Return-Path: <SRS0=Nv7C=AP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797D1C433DF
	for <git@archiver.kernel.org>; Sat,  4 Jul 2020 17:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F9A920748
	for <git@archiver.kernel.org>; Sat,  4 Jul 2020 17:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dq8F8538"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgGDR1O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jul 2020 13:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGDR1N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jul 2020 13:27:13 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D526C061794
        for <git@vger.kernel.org>; Sat,  4 Jul 2020 10:27:13 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id n26so23734527ejx.0
        for <git@vger.kernel.org>; Sat, 04 Jul 2020 10:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ONw6lfeb0uS2EjsaYB902EKCcPrLAd8D6xkg42pAVgM=;
        b=dq8F8538H9pAyluY8jZnCuyS27leFrtzJR/4XyYJRCTttIX7XdN9zhvxyRC66382sn
         knWCzo+QQVP/OpvS/dWeO/TC/442s/Y1PUx4GvknDuAWFFecEZv+1PuZ0RZ1GJQubsyw
         iNT4iPY6e+Tp++Yu56FaZw6B6qNr6vgkCXw2RARWdI69EB78+lVPTyucvmoWIBia+uhs
         fCSE+Zrl29B1DwkNjVBKY+45zQjHdD0UhxFp2b5XoyMu14e3zldwHa+XLlXeL5+qdxhL
         Izm6Rh/n55Yyt79E0PH1aHC+GpB2zQeVRPwQtQBwWGOdGu+Uw3+G5VMtEuEieTdNH3T4
         m1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ONw6lfeb0uS2EjsaYB902EKCcPrLAd8D6xkg42pAVgM=;
        b=E9Ggni1tlrJDcaJe/MnhDiIgmLe05VcF+dKSpZNt2JzG5XJvt45zhrx4mwIXNHEv6i
         UHiR2qpLtq9gPlicx/KDyT5cvzjxuH7tST6yWyLTzmY5vme9EOLQtAC2iAo3B5YbHKyp
         avgFCyXpbahrzynk2QL9wd9tCJYzdkrYXQrEuu0i3NTx1Fbix2z2fkVmz9bjbmpvPUZb
         iyeH3iqHapEhgEZcVtArJzmZiD3Z76yRTNxISPR07XzMzUk2Hteqmx4VnBhB1UYgwtTA
         QiB8v7m5c1PtAHc+UR6aSjbZjavzvQX2GClkg1N4kTm34btUhiCrz4uQduBAHkRxdJPG
         QpLg==
X-Gm-Message-State: AOAM530pzYWgK79uuKeGJe6Lt5pmcQqdK8l23hfH3zKDVc1xUDmYwDfR
        ds7CDGvRlSVBNRINxzL9FGA=
X-Google-Smtp-Source: ABdhPJz8vmwq4roLHnxo85ou6eVk/bX96O2q+ivTwgPeQCDyGOnZo46f+duD3vc13rBEEq2pI/+Zng==
X-Received: by 2002:a17:906:e210:: with SMTP id gf16mr27797308ejb.386.1593883631998;
        Sat, 04 Jul 2020 10:27:11 -0700 (PDT)
Received: from szeder.dev (84-236-109-193.pool.digikabel.hu. [84.236.109.193])
        by smtp.gmail.com with ESMTPSA id d26sm15939676edz.93.2020.07.04.10.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jul 2020 10:27:11 -0700 (PDT)
Date:   Sat, 4 Jul 2020 19:27:08 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Brandon Williams <bwilliamseng@gmail.com>
Subject: Re: [PATCH v12 5/5] read-cache: speed up has_dir_name (part 2)
Message-ID: <20200704172708.GC11341@szeder.dev>
References: <20170419170618.16535-1-git@jeffhostetler.com>
 <20170419170618.16535-6-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170419170618.16535-6-git@jeffhostetler.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 19, 2017 at 05:06:18PM +0000, git@jeffhostetler.com wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Teach has_dir_name() to see if the path of the new item
> is greater than the last path in the index array before
> attempting to search for it.
> 
> has_dir_name() is looking for file/directory collisions
> in the index and has to consider each sub-directory
> prefix in turn.  This can cause multiple binary searches
> for each path.
> 
> During operations like checkout, merge_working_tree()
> populates the new index in sorted order, so we expect
> to be able to append in many cases.
> 
> This commit is part 2 of 2.  This commit handles the
> additional possible short-cuts as we look at each
> sub-directory prefix.
> 
> The net-net gains for add_index_entry_with_check() and
> both had_dir_name() commits are best seen for very
> large repos.
> 
> Here are results for an INFLATED version of linux.git
> with 1M files.
> 
> $ GIT_PERF_REPO=/mnt/test/linux_inflated.git/ ./run upstream/base HEAD ./p0006-read-tree-checkout.sh
> Test                                                            upstream/base      HEAD
> 0006.2: read-tree br_base br_ballast (1043893)                  3.79(3.63+0.15)    2.68(2.52+0.15) -29.3%
> 0006.3: switch between br_base br_ballast (1043893)             7.55(6.58+0.44)    6.03(4.60+0.43) -20.1%
> 0006.4: switch between br_ballast br_ballast_plus_1 (1043893)   10.84(9.26+0.59)   8.44(7.06+0.65) -22.1%
> 0006.5: switch between aliases (1043893)                        10.93(9.39+0.58)   10.24(7.04+0.63) -6.3%
> 
> Here are results for a synthetic repo with 4.2M files.
> 
> $ GIT_PERF_REPO=~/work/gfw/t/perf/repos/gen-many-files-10.4.3.git/ ./run HEAD~3 HEAD ./p0006-read-tree-checkout.sh
> Test                                                            HEAD~3               HEAD
> 0006.2: read-tree br_base br_ballast (4194305)                  29.96(19.26+10.50)   23.76(13.42+10.12) -20.7%
> 0006.3: switch between br_base br_ballast (4194305)             56.95(36.08+16.83)   45.54(25.94+15.68) -20.0%
> 0006.4: switch between br_ballast br_ballast_plus_1 (4194305)   90.94(51.50+31.52)   78.22(39.39+30.70) -14.0%
> 0006.5: switch between aliases (4194305)                        93.72(51.63+34.09)   77.94(39.00+30.88) -16.8%
> 
> Results for medium repos (like linux.git) are mixed and have
> more variance (probably do to disk IO unrelated to this test.
> 
> $ GIT_PERF_REPO=/mnt/test/linux.git/ ./run HEAD~3 HEAD ./p0006-read-tree-checkout.sh
> Test                                                          HEAD~3             HEAD
> 0006.2: read-tree br_base br_ballast (57994)                  0.25(0.21+0.03)    0.20(0.17+0.02) -20.0%
> 0006.3: switch between br_base br_ballast (57994)             10.67(6.06+2.92)   10.51(5.94+2.91) -1.5%
> 0006.4: switch between br_ballast br_ballast_plus_1 (57994)   0.59(0.47+0.16)    0.52(0.40+0.13) -11.9%
> 0006.5: switch between aliases (57994)                        0.59(0.44+0.17)    0.51(0.38+0.14) -13.6%
> 
> $ GIT_PERF_REPO=/mnt/test/linux.git/ ./run HEAD~3 HEAD ./p0006-read-tree-checkout.sh
> Test                                                          HEAD~3             HEAD
> 0006.2: read-tree br_base br_ballast (57994)                  0.24(0.21+0.02)    0.21(0.18+0.02) -12.5%
> 0006.3: switch between br_base br_ballast (57994)             10.42(5.98+2.91)   10.66(5.86+3.09) +2.3%
> 0006.4: switch between br_ballast br_ballast_plus_1 (57994)   0.59(0.49+0.13)    0.53(0.37+0.16) -10.2%
> 0006.5: switch between aliases (57994)                        0.59(0.43+0.17)    0.50(0.37+0.14) -15.3%
> 
> Results for smaller repos (like git.git) are not significant.
> $ ./run HEAD~3 HEAD ./p0006-read-tree-checkout.sh
> Test                                                         HEAD~3            HEAD
> 0006.2: read-tree br_base br_ballast (3043)                  0.01(0.00+0.00)   0.01(0.00+0.00) +0.0%
> 0006.3: switch between br_base br_ballast (3043)             0.31(0.17+0.11)   0.29(0.19+0.08) -6.5%
> 0006.4: switch between br_ballast br_ballast_plus_1 (3043)   0.03(0.02+0.00)   0.03(0.02+0.00) +0.0%
> 0006.5: switch between aliases (3043)                        0.03(0.02+0.00)   0.03(0.02+0.00) +0.0%
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  read-cache.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index 9af0bd4..c252b6c 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -965,7 +965,7 @@ static int has_dir_name(struct index_state *istate,
>  	}
>  
>  	for (;;) {
> -		int len;
> +		size_t len;
>  
>  		for (;;) {
>  			if (*--slash == '/')
> @@ -975,6 +975,67 @@ static int has_dir_name(struct index_state *istate,
>  		}
>  		len = slash - name;
>  
> +		if (cmp_last > 0) {
> +			/*
> +			 * (len + 1) is a directory boundary (including
> +			 * the trailing slash).  And since the loop is
> +			 * decrementing "slash", the first iteration is
> +			 * the longest directory prefix; subsequent
> +			 * iterations consider parent directories.
> +			 */
> +
> +			if (len + 1 <= len_eq_last) {
> +				/*
> +				 * The directory prefix (including the trailing
> +				 * slash) also appears as a prefix in the last
> +				 * entry, so the remainder cannot collide (because
> +				 * strcmp said the whole path was greater).
> +				 *
> +				 * EQ: last: xxx/A
> +				 *     this: xxx/B
> +				 *
> +				 * LT: last: xxx/file_A
> +				 *     this: xxx/file_B
> +				 */
> +				return retval;
> +			}
> +
> +			if (len > len_eq_last) {
> +				/*
> +				 * This part of the directory prefix (excluding
> +				 * the trailing slash) is longer than the known
> +				 * equal portions, so this sub-directory cannot
> +				 * collide with a file.
> +				 *
> +				 * GT: last: xxxA
> +				 *     this: xxxB/file
> +				 */
> +				return retval;
> +			}
> +
> +			if (istate->cache_nr > 0 &&
> +				ce_namelen(istate->cache[istate->cache_nr - 1]) > len) {
> +				/*
> +				 * The directory prefix lines up with part of
> +				 * a longer file or directory name, but sorts
> +				 * after it, so this sub-directory cannot
> +				 * collide with a file.
> +				 *
> +				 * last: xxx/yy-file (because '-' sorts before '/')
> +				 * this: xxx/yy/abc

This is problematic, because the index can already contain 'xxx/yy' as
a file, when adding 'xxx/yy/abc', but since 'xxx/yy' as a file sorts
before 'xxx/yy-file', the short-circuiting here doesn't see it and
thus leaves the d-f collision undetected.  Consequently, even Git
porcelain commands can create tree objects with duplicate entries, as
demonstrated in the tests below.

Before this patch the collision is noticed, the colliding file entry
is removed, and these tests succeed.  Removing this condition make
them succeed as well, and FWIW the test suite still passes, but I
haven't thought it through and haven't checked the impact on
performance.

  ---  >8  ---

diff --git a/t/t9999-test.sh b/t/t9999-test.sh
new file mode 100755
index 0000000000..4c802d5940
--- /dev/null
+++ b/t/t9999-test.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+test_description='test'
+
+. ./test-lib.sh
+
+test_expect_success 'file to dir breakage' '
+	>file-to-dir &&
+	# This sorts between "file-to-dir" as a file and "file-to-dir"
+	# as a directory (with the trailing / appended implicitly.
+	>file-to-dir.uh-oh &&
+	git add file-to-dir file-to-dir.uh-oh &&
+	git commit -m "add a file" &&
+
+	# Not "git rm", to preserve "file-to-dir" in the index.
+	rm file-to-dir &&
+	mkdir file-to-dir &&
+	>file-to-dir/file &&
+
+	# It is important to add the file in the directory; adding only
+	# the directory doesnt trigger the bug.
+	git add file-to-dir/file &&
+
+	git diff --cached --no-renames --name-status >actual &&
+
+	cat >expect <<-\EOF &&
+	D	file-to-dir
+	A	file-to-dir/file
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'is it committed as-is?' '
+	git commit -m "replace file with a dir" &&
+	git ls-tree HEAD >actual &&
+
+	# Hardcoded SHA-1 oid :(, because with this bug present
+	# "git rev-parse HEAD:file-to-dir" doesnt show the oid of
+	# the tree, but the oid of the blob that shouldnt be there.
+	cat >expect <<-EOF &&
+	100644 blob $EMPTY_BLOB	file-to-dir.uh-oh
+	040000 tree df2b8fc99e1c1d4dbc0a854d9f72157f1d6ea078	file-to-dir
+	EOF
+	test_cmp expect actual
+'
+
+test_done

  ---  8<  ---

The first test fails with:

  + test_cmp expect actual
  --- expect      2020-07-04 16:52:07.173296314 +0000
  +++ actual      2020-07-04 16:52:07.173296314 +0000
  @@ -1,2 +1 @@
  -D      file-to-dir
   A      file-to-dir/file
  error: last command exited with $?=1
  not ok 1 - file to dir breakage
  
And the second:

  + test_cmp expect actual
  --- expect      2020-07-04 16:52:07.185296659 +0000
  +++ actual      2020-07-04 16:52:07.181296544 +0000
  @@ -1,2 +1,3 @@
  +100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391   file-to-dir
   100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391   file-to-dir.uh-oh
   040000 tree df2b8fc99e1c1d4dbc0a854d9f72157f1d6ea078   file-to-dir
  error: last command exited with $?=1
  not ok 2 - is it committed as-is?


> +				 */
> +				return retval;
> +			}
> +
> +			/*
> +			 * This is a possible collision. Fall through and
> +			 * let the regular search code handle it.
> +			 *
> +			 * last: xxx
> +			 * this: xxx/file
> +			 */
> +		}
> +
>  		pos = index_name_stage_pos(istate, name, len, stage);
>  		if (pos >= 0) {
>  			/*
> -- 
> 2.9.3
> 
