Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE11EC433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 08:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A75464F09
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 08:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhCQImL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 04:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhCQIlz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 04:41:55 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE460C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 01:41:54 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id p8so1210100ejb.10
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 01:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=zDXMdDHCCbxZOCgL0h2cnpv1QUa8EmMr9DdZJ7jUD5E=;
        b=nP6gSgmIwtDsKteNvj1HvTHNScrLhC2/u1tNH6+BzcKi6Cvasms6SStUxyjIRj5/QS
         P55sRZZ9DrCVoKLyXkTM1OfB4Y7ypxH2sxuvR948dSpkAQ6hldvtbgqNqV86aRrSE7EC
         J+Xjgx1aBmu98K2ixvsjOsw/F43aeTcF0CPtHe9D92KQ9h2F1qp8bfhJjn9aInjGOeHG
         W/228Jsd6JMQzHYcN9C6Jp3f2QH0cUl2HnNluCQeFf4xpIb6+N9z/2tdJlYZmPEHT3T8
         EI1yq0qbBNpWdJUQkiPriMrhpqz4XZGkfaCVBPjwXeJknofL51h8yhnTc2Nv/VO/LMqr
         cqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=zDXMdDHCCbxZOCgL0h2cnpv1QUa8EmMr9DdZJ7jUD5E=;
        b=YaPy1bK2+p5fb4qJ5QtyKMGqIExXyNtoLNXrPIp2I0OsI8KAegjc4OT6UkDLm9Bx1H
         0tBcIsECifS0XA2mccgCBr+QnZBcPoZ2nvjdcmVNhA7lShp5KdW+pV2dT+d9EVnSSIT8
         9xDRjH25mBp53a9Flf+Rwq3q4Nbw4Md3V2yh4AMTv1peLqwwTds2KS6+XZZV+h5lAaBE
         gr9MTRCI9ZaM1hCe4HrNNmpyPhb/7aV+h0zTZHLEsv38as6xhyL1DvMp8bEVzUwwuqp5
         nGmkWK16U+OpGBlIKbuzlYCMXEQ4RrI6blogomNGaLjZoTD/ZKhfp1KFw9IstX2SdAcw
         RQDw==
X-Gm-Message-State: AOAM5326KFPUgF4ULNqhMRTbph4P2bx0V+MMRkcRKDq2Xrhq/J0gERAW
        aK92qco1YX2ywRevcusFRkZ4POslGbkt+Q==
X-Google-Smtp-Source: ABdhPJxWLY5xDKdTc8zp/M2Zin9RKBFef05oTTAW8F0X3ze70vUJxEISlsLawZN1fKqIwXUg+zZbhA==
X-Received: by 2002:a17:906:5450:: with SMTP id d16mr23730746ejp.274.1615970513137;
        Wed, 17 Mar 2021 01:41:53 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id pg2sm10792780ejb.49.2021.03.17.01.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:41:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        pclouds@gmail.com, jrnieder@gmail.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 02/20] t/perf: add performance test for sparse
 operations
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
 <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
 <d2197e895e4d4160fa369e2ba7d82e2e5a7fbc01.1615912983.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <d2197e895e4d4160fa369e2ba7d82e2e5a7fbc01.1615912983.git.gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 09:41:51 +0100
Message-ID: <87tupadve8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 16 2021, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Create a test script that takes the default performance test (the Git
> codebase) and multiplies it by 256 using four layers of duplicated
> trees of width four. This results in nearly one million blob entries in
> the index. Then, we can clone this repository with sparse-checkout
> patterns that demonstrate four copies of the initial repository. Each
> clone will use a different index format or mode so peformance can be
> tested across the different options.
>
> Note that the initial repo is stripped of submodules before doing the
> copies. This preserves the expected data shape of the sparse index,
> because directories containing submodules are not collapsed to a sparse
> directory entry.
>
> Run a few Git commands on these clones, especially those that use the
> index (status, add, commit).
>
> Here are the results on my Linux machine:
>
> Test
> --------------------------------------------------------------
> 2000.2: git status (full-index-v3)             0.37(0.30+0.09)
> 2000.3: git status (full-index-v4)             0.39(0.32+0.10)
> 2000.4: git add -A (full-index-v3)             1.42(1.06+0.20)
> 2000.5: git add -A (full-index-v4)             1.26(0.98+0.16)
> 2000.6: git add . (full-index-v3)              1.40(1.04+0.18)
> 2000.7: git add . (full-index-v4)              1.26(0.98+0.17)
> 2000.8: git commit -a -m A (full-index-v3)     1.42(1.11+0.16)
> 2000.9: git commit -a -m A (full-index-v4)     1.33(1.08+0.16)
>
> It is perhaps noteworthy that there is an improvement when using index
> version 4. This is because the v3 index uses 108 MiB while the v4
> index uses 80 MiB. Since the repeated portions of the directories are
> very short (f3/f1/f2, for example) this ratio is less pronounced than in
> similarly-sized real repositories.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/perf/p2000-sparse-operations.sh | 85 +++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100755 t/perf/p2000-sparse-operations.sh
>
> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
> new file mode 100755
> index 000000000000..2fbc81b22119
> --- /dev/null
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -0,0 +1,85 @@
> +#!/bin/sh
> +
> +test_description="test performance of Git operations using the index"
> +
> +. ./perf-lib.sh
> +
> +test_perf_default_repo
> +
> +SPARSE_CONE=f2/f4/f1
> +
> +test_expect_success 'setup repo and indexes' '
> +	git reset --hard HEAD &&
> +	# Remove submodules from the example repo, because our
> +	# duplication of the entire repo creates an unlikly data shape.
> +	git config --file .gitmodules --get-regexp "submodule.*.path" >modules &&
> +	git rm -f .gitmodules &&
> +	for module in $(awk "{print \$2}" modules)
> +	do
> +		git rm $module || return 1
> +	done &&
> +	git commit -m "remove submodules" &&

Paradoxically with this you can no longer use a repo that's not git.git
or another repo that has submodules, since we'll die in trying to remove
them.

Also you don't have to "git rm .gitmodules", the "git rm" command
removes submodule entries.

Perhaps just:

    for module in $(git ls-files --stage | grep ^160000 | awk -F '\t' '{ print $2 }')
    do
        git rm "$module"
    done

Or another way of guarding against rm getting the empty list && commit?

But it seems odd to be doing this at all, the point of the perf
framework is that you can point it at any repo, and some repos you want
to test will have submodules.

Seems like something like the WIP patch at the end on top would be
better.

> +	echo bogus >a &&
> +	cp a b &&
> +	git add a b &&
> +	git commit -m "level 0" &&
> +	BLOB=$(git rev-parse HEAD:a) &&

Isn't the way we're getting this $BLOB equivalent to just 'echo bogus |
git hash-object --stdin -w' why commit it?

> +	OLD_COMMIT=$(git rev-parse HEAD) &&
> +	OLD_TREE=$(git rev-parse HEAD^{tree}) &&
> +
> +	for i in $(test_seq 1 4)
> +	do
> +		cat >in <<-EOF &&
> +			100755 blob $BLOB	a
> +			040000 tree $OLD_TREE	f1
> +			040000 tree $OLD_TREE	f2
> +			040000 tree $OLD_TREE	f3
> +			040000 tree $OLD_TREE	f4
> +		EOF
> +		NEW_TREE=$(git mktree <in) &&
> +		NEW_COMMIT=$(git commit-tree $NEW_TREE -p $OLD_COMMIT -m "level $i") &&
> +		OLD_TREE=$NEW_TREE &&
> +		OLD_COMMIT=$NEW_COMMIT || return 1
> +	done &&
> +
> +	git sparse-checkout init --cone &&
> +	git branch -f wide $OLD_COMMIT &&
> +	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . full-index-v3 &&
> +	(
> +		cd full-index-v3 &&
> +		git sparse-checkout init --cone &&
> +		git sparse-checkout set $SPARSE_CONE &&
> +		git config index.version 3 &&
> +		git update-index --index-version=3
> +	) &&
> +	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . full-index-v4 &&
> +	(
> +		cd full-index-v4 &&
> +		git sparse-checkout init --cone &&
> +		git sparse-checkout set $SPARSE_CONE &&
> +		git config index.version 4 &&
> +		git update-index --index-version=4
> +	)
> +'

This whole thing makes me think you just wanted a test_perf_fresh_repo
all along, but I think this would be much more useful if you took the
default repo and multiplied the size in its tree by some multiple.

E.g. take the files we have in git.git, write a copy at prefix-1/,
prefix-2/ etc.

The whole point of test_perf_{default,large}_repo is being able to point
them at a local repo you're testing for performance and get numbers
representative of that repo.

So maybe that's not what's wanted here at all, but that brings us back
to test_perf_fresh_repo...

> +test_perf_on_all () {
> +	command="$@"
> +	for repo in full-index-v3 full-index-v4
> +	do
> +		test_perf "$command ($repo)" "
> +			(
> +				cd $repo &&
> +				echo >>$SPARSE_CONE/a &&
> +				$command
> +			)
> +		"
> +	done
> +}
> +
> +test_perf_on_all git status
> +test_perf_on_all git add -A
> +test_perf_on_all git add .
> +test_perf_on_all git commit -a -m A
> +
> +test_done

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index e527316e66..2c07b04159 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -4,22 +4,11 @@ test_description="test performance of Git operations using the index"
 
 . ./perf-lib.sh
 
-test_perf_default_repo
+test_perf_nosubodules_repo
 
 SPARSE_CONE=f2/f4/f1
 
 test_expect_success 'setup repo and indexes' '
-	git reset --hard HEAD &&
-	# Remove submodules from the example repo, because our
-	# duplication of the entire repo creates an unlikly data shape.
-	git config --file .gitmodules --get-regexp "submodule.*.path" >modules &&
-	git rm -f .gitmodules &&
-	for module in $(awk "{print \$2}" modules)
-	do
-		git rm $module || return 1
-	done &&
-	git commit -m "remove submodules" &&
-
 	echo bogus >a &&
 	cp a b &&
 	git add a b &&
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index e385c6896f..86b716ce8f 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -128,6 +128,15 @@ test_perf_large_repo () {
 	fi
 	test_perf_create_repo_from "${1:-$TRASH_DIRECTORY}" "$GIT_PERF_LARGE_REPO"
 }
+test_perf_nosubodules_repo () {
+	if test "$GIT_PERF_NOSUBMODULES_REPO" = "$GIT_BUILD_DIR"; then
+		echo "warning: \$GIT_PERF_NOSUBMODULES_REPO is \$GIT_BUILD_DIR." >&2
+		echo "warning: This will probably work, but it has a submodule!" >&2
+		echo "warning: point to another repo for representative measurements." >&2
+		# git rm dance here? optionally?
+	fi
+	test_perf_create_repo_from "${1:-$TRASH_DIRECTORY}" "$GIT_PERF_NOSUBMODULES_REPO"
+}
 test_checkout_worktree () {
 	git checkout-index -u -a ||
 	error "git checkout-index failed"
@@ -196,7 +205,7 @@ test_perf_ () {
 	else
 		echo "perf $test_count - $1:"
 	fi
-	for i in $(test_seq 1 $GIT_PERF_REPEAT_COUNT); do
+	for i in $(test_seq 1 $GIT_PERF_REP
 		say >&3 "running: $2"
 		if test_run_perf_ "$2"
 		then
