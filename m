Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF8FC433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 13:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A485B22CB2
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 13:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbhAWNCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 08:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbhAWNBt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 08:01:49 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D92DC06178B
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 05:01:09 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c128so6707356wme.2
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 05:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e4MVJFIcALWXtiqCpyDRveI5lqGSqtMFfVJBcMH/RDM=;
        b=HuYcfzSADOtfu2cLByvcw6Y0bSJZLoQpM8sOFnR0ac1E6uIbIdazth9CvV+74v4UCR
         s4S4G053Z2ReTquT3p4IJsmPssPN5Gw8Xh6yxymdg15jflrYMkBRmZjiLzVQDy8py2RB
         sI6LCMIowTIW6CAGKbfOYuFDRuyQneAXVXq3vtH8EIo7jS6OzUDOYZdLVYL+jCpu+KPL
         BsBsanOIv1auGsVWRXZwqENRPNHglYUos9n1l/ah/5p8qSpuqakjaWYBAQ98FYQyblSa
         jEJuMAjyoFvb1jtU/ROa5ODJbF49SwUJSUifuvUMCDb78kx2mWMofx74ZdPjCWwxVF2p
         /5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e4MVJFIcALWXtiqCpyDRveI5lqGSqtMFfVJBcMH/RDM=;
        b=Son20PrRoyOHOnJiURRtYMRZggfBO8tkR1S/41bxFhs3RNV60irRfP5+DyR68e9vTP
         O9BAzpFhFJdfZHKPMI2NFbhHyE3CGX8jKXBIBAejzQfuykeLE5pnE33Hz93ej3dncw8o
         eM2dMW7DChymgWhnHgrbunnRl+KqDGyqbkcwZPQ88shFNUvN+WRZI2k/QLqvwNdzWFZa
         ZtQUyGGXQJF4L8kYdFG12wWXDpPwGplw646sPjvsLI5c3X+NhWvgOXbnnJBXd3wk4hpx
         H9FxVc4rqFbPWLBo2z+eUelHnN8m8D5DqHewVhVxbmL9BB5+V2xcUQfuHaeVcfOgjhYp
         X2Xw==
X-Gm-Message-State: AOAM530/IUh5yqdCFoihqpRR64xA0tPhs0LrM4LRnjuOYoY6MKHOOGfx
        MXDl/+J04JA+pdk76pgP3i2nU/ROjdy+1Q==
X-Google-Smtp-Source: ABdhPJwKI6tbdlkynX4tP98qoBsm5OF1YVqKHvEbHZ08tCWPT1yaFersKOkDC6zUep1+A+l5SmoPaQ==
X-Received: by 2002:a1c:ddc6:: with SMTP id u189mr8355800wmg.172.1611406867702;
        Sat, 23 Jan 2021 05:01:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c7sm16750319wro.16.2021.01.23.05.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 05:01:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/10] cache-tree tests: explicitly test HEAD and index differences
Date:   Sat, 23 Jan 2021 14:00:40 +0100
Message-Id: <20210123130046.21975-5-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <87sg6s6lrs.fsf@evledraar.gmail.com>
References: <87sg6s6lrs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test code added in 9c4d6c0297 (cache-tree: Write updated
cache-tree after commit, 2014-07-13) used "ls-files" in lieu of
"ls-tree" because it wanted to test the data in the index, since this
test is testing the cache-tree extension.

Change the test to instead use "ls-tree" for traversal, and then
explicitly check how HEAD differs from the index. This is more easily
understood, and less fragile as numerous past bug fixes[1][2][3] to
the old code we're replacing demonstrate.

As an aside this would be a bit easier if empty pathspecs hadn't been
made an error in d426430e6e (pathspec: warn on empty strings as
pathspec, 2016-06-22) and 9e4e8a64c2 (pathspec: die on empty strings
as pathspec, 2017-06-06).

If that was still allowed this code could be simplified slightly:

	diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
	index 9bf66c9e68..0b02881f55 100755
	--- a/t/t0090-cache-tree.sh
	+++ b/t/t0090-cache-tree.sh
	@@ -18,19 +18,18 @@ cmp_cache_tree () {
	 # test-tool dump-cache-tree already verifies that all existing data is
	 # correct.
	 generate_expected_cache_tree () {
	-       pathspec="$1" &&
	-       dir="$2${2:+/}" &&
	+       pathspec="$1${1:+/}" &&
	        git ls-tree --name-only HEAD -- "$pathspec" >files &&
	        git ls-tree --name-only -d HEAD -- "$pathspec" >subtrees &&
	-       printf "SHA %s (%d entries, %d subtrees)\n" "$dir" $(wc -l <files) $(wc -l <subtrees) &&
	+       printf "SHA %s (%d entries, %d subtrees)\n" "$pathspec" $(wc -l <files) $(wc -l <subtrees) &&
	        while read subtree
	        do
	-               generate_expected_cache_tree "$pathspec/$subtree/" "$subtree" || return 1
	+               generate_expected_cache_tree "$subtree" || return 1
	        done <subtrees
	 }

	 test_cache_tree () {
	-       generate_expected_cache_tree "." >expect &&
	+       generate_expected_cache_tree >expect &&
	        cmp_cache_tree expect &&
	        rm expect actual files subtrees &&
	        git status --porcelain -- ':!status' ':!expected.status' >status &&

1. c8db708d5d (t0090: avoid passing empty string to printf %d,
   2014-09-30)
2. d69360c6b1 (t0090: tweak awk statement for Solaris
   /usr/xpg4/bin/awk, 2014-12-22)
3. 9b5a9fa60a (t0090: stop losing return codes of git commands,
   2019-11-27)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0090-cache-tree.sh | 45 ++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 5bb4f75443..9bf66c9e68 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -18,26 +18,28 @@ cmp_cache_tree () {
 # test-tool dump-cache-tree already verifies that all existing data is
 # correct.
 generate_expected_cache_tree () {
-	dir="$1${1:+/}" &&
-	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
-	# We want to count only foo because it's the only direct child
-	git ls-files >files &&
-	subtrees=$(grep / files|cut -d / -f 1|uniq) &&
-	subtree_count=$(echo "$subtrees"|awk -v c=0 '$1 != "" {++c} END {print c}') &&
-	entries=$(wc -l <files) &&
-	printf "SHA $dir (%d entries, %d subtrees)\n" "$entries" "$subtree_count" &&
-	for subtree in $subtrees
+	pathspec="$1" &&
+	dir="$2${2:+/}" &&
+	git ls-tree --name-only HEAD -- "$pathspec" >files &&
+	git ls-tree --name-only -d HEAD -- "$pathspec" >subtrees &&
+	printf "SHA %s (%d entries, %d subtrees)\n" "$dir" $(wc -l <files) $(wc -l <subtrees) &&
+	while read subtree
 	do
-		(
-			cd "$subtree" &&
-			generate_expected_cache_tree "$dir$subtree"
-		) || return 1
-	done
+		generate_expected_cache_tree "$pathspec/$subtree/" "$subtree" || return 1
+	done <subtrees
 }
 
 test_cache_tree () {
-	generate_expected_cache_tree >expect &&
-	cmp_cache_tree expect
+	generate_expected_cache_tree "." >expect &&
+	cmp_cache_tree expect &&
+	rm expect actual files subtrees &&
+	git status --porcelain -- ':!status' ':!expected.status' >status &&
+	if test -n "$1"
+	then
+		test_cmp "$1" status
+	else
+		test_must_be_empty status
+	fi
 }
 
 test_invalid_cache_tree () {
@@ -126,6 +128,7 @@ test_expect_success 'second commit has cache-tree' '
 '
 
 test_expect_success PERL 'commit --interactive gives cache-tree on partial commit' '
+	test_when_finished "git reset --hard" &&
 	cat <<-\EOT >foo.c &&
 	int foo()
 	{
@@ -152,7 +155,10 @@ test_expect_success PERL 'commit --interactive gives cache-tree on partial commi
 	EOT
 	test_write_lines p 1 "" s n y q |
 	git commit --interactive -m foo &&
-	test_cache_tree
+	cat <<-\EOF >expected.status &&
+	 M foo.c
+	EOF
+	test_cache_tree expected.status
 '
 
 test_expect_success PERL 'commit -p with shrinking cache-tree' '
@@ -243,7 +249,10 @@ test_expect_success 'partial commit gives cache-tree' '
 	git add one.t &&
 	echo "some other change" >two.t &&
 	git commit two.t -m partial &&
-	test_cache_tree
+	cat <<-\EOF >expected.status &&
+	M  one.t
+	EOF
+	test_cache_tree expected.status
 '
 
 test_expect_success 'no phantom error when switching trees' '
-- 
2.29.2.222.g5d2a92d10f8

