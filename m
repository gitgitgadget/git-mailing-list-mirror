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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35CEC433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 13:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96A7B22CAF
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 13:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbhAWNBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 08:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbhAWNBq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 08:01:46 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF037C06174A
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 05:01:05 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c128so6707255wme.2
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 05:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iCsCsidZp7uDULi3hjkRDx7WlgoSomRSFvHOPmLCfHE=;
        b=NC6RgiO6/ztLUTN08Sl5jumIG4sgP5afgUJ98bbX0icbMmWCMo1VS4Uj133sQafdZT
         UX54DhE/JEKlhYVijPip/L8R2C58QdMqnteIozRdl6z6jnglyYIeHvNwOtmmL6tcvoor
         wtk6fRB1iUgzWR9Y4wzdPvTcmXrRDY0Bmr3FaUssnyv8GeLa/vE/iKWo2w2U2lzidtnS
         1fbWvaxd7ZRTZIzNFF7DFDoakrMXZe1CKcRaCE51BnVv5kOZELW1dzXxYh7jz7kCRGXd
         iAdFgfefKehKWSaxe8z9F904mEdGuSmJALJUuRoPHL6oKVu81wFHU4MkWFAeBDmChqmD
         MDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iCsCsidZp7uDULi3hjkRDx7WlgoSomRSFvHOPmLCfHE=;
        b=REdvaDcqUnQlbrFH9Q/EGWgtrkNej73crvpIdk2hnLL7uzA35AndRMzHF7gDZiaU3B
         0l32lm01kU3/IBBh4jEgW8LKgM3vCesrmLipOB0agVjjErxDiXnDnw8LJgAIAn46wPoQ
         85JQ9SJApoM2GOFUgxYYvvL7aeFbVJVROcYVxU21Cegu2qZvFCYSMAdj5aGpjtfi/BtV
         xfppPgGjXp5xnaOHk1ecrTe6e30zvGopxb1hfBISScyjyqo19x3wWGwz5W4arJVhMYs+
         SQzU5MEYOkvOvwLQt2XRbg1rQDBu2frUIu/GtMZd9U7LnpUPpUFL3W1ONAmLRCwnMMVA
         G6Fg==
X-Gm-Message-State: AOAM5300oWotUINZXCg6c8JmM5DqU5d6XhnWu3FxVyDSWzvbQJft7pd+
        XFyMfs6e8/g99aGUW61eiYKDGuTD5/k=
X-Google-Smtp-Source: ABdhPJwmV5W/Vf0VyGF3pya1962eD1rhp6uboybyG/x9E/1AmFbiKjCGYpyGnMe60YaaJxi6rpODpg==
X-Received: by 2002:a1c:99d1:: with SMTP id b200mr611361wme.37.1611406864018;
        Sat, 23 Jan 2021 05:01:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c7sm16750319wro.16.2021.01.23.05.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 05:01:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/10] Miscellaneous "set -o pipefail"-related test cleanups 
Date:   Sat, 23 Jan 2021 14:00:36 +0100
Message-Id: <20210123130046.21975-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <87sg6s6lrs.fsf@evledraar.gmail.com>
References: <87sg6s6lrs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This started as an attempt to add a bash "set -o pipefail" test mode,
but now comes without that. Junio suggested dropping it in
<xmqq5z3o5n8c.fsf@gitster.c.googlers.com>.

The "cache-tree tests" part is mostly rewritten. I'd removed the index
dependency of the tests, but the point of the tests is to test the
index. Now we do that again in a more readable way.

The "git rm" test at the end fixes the current CI failure in this
topic, and does some version of what I suggested in
<87sg6s6lrs.fsf@evledraar.gmail.com>. Junio, I think that makes sense
as a fix while we're at it, but if you don't like it just drop it.

Jeff King (1):
  git-svn tests: rewrite brittle tests to use "--[no-]merges".

Ævar Arnfjörð Bjarmason (9):
  cache-tree tests: refactor for modern test style
  cache-tree tests: remove unused $2 parameter
  cache-tree tests: use a sub-shell with less indirection
  cache-tree tests: explicitly test HEAD and index differences
  git svn mergeinfo tests: modernize redirection & quoting style
  git svn mergeinfo tests: refactor "test -z" to use test_must_be_empty
  upload-pack tests: avoid a non-zero "grep" exit status
  archive tests: use a cheaper "zipinfo -h" invocation to get header
  rm tests: actually test for SIGPIPE in SIGPIPE test

 t/t0090-cache-tree.sh              | 82 +++++++++++++++---------------
 t/t3600-rm.sh                      | 16 +++++-
 t/t5004-archive-corner-cases.sh    |  3 +-
 t/t5703-upload-pack-ref-in-want.sh |  3 +-
 t/t9151-svn-mergeinfo.sh           | 43 ++++++++--------
 5 files changed, 80 insertions(+), 67 deletions(-)

Range-diff:
 -:  ---------- >  1:  b30499c4e4 cache-tree tests: refactor for modern test style
 1:  8e8e03fa3d =  2:  af0b25a048 cache-tree tests: remove unused $2 parameter
 2:  828d25533c !  3:  09959568de cache-tree tests: use a sub-shell with less indirection
    @@ Commit message
         We did actually recover correctly if we failed in this function since
         we were wrapped in a subshell one function call up. Let's just use the
         sub-shell at the point where we want to change the directory
    -    instead. This also allows us to get rid of the wrapper function.
    +    instead.
    +
    +    It's important that the "|| return 1" is outside the
    +    subshell. Normally, we `exit 1` from within subshells[1], but that
    +    wouldn't help us exit this loop early[1][2].
    +
    +    Since we can get rid of the wrapper function let's rename the main
    +    function to drop the "rec" (for "recursion") suffix[3].
    +
    +    1. https://lore.kernel.org/git/CAPig+cToj8nQmyBCqC1k7DXF2vXaonCEA-fCJ4x7JBZG2ixYBw@mail.gmail.com/
    +    2. https://lore.kernel.org/git/20150325052952.GE31924@peff.net/
    +    3. https://lore.kernel.org/git/YARsCsgXuiXr4uFX@coredump.intra.peff.net/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t0090-cache-tree.sh ##
    +@@ t/t0090-cache-tree.sh: cmp_cache_tree () {
    + # We don't bother with actually checking the SHA1:
    + # test-tool dump-cache-tree already verifies that all existing data is
    + # correct.
    +-generate_expected_cache_tree_rec () {
    ++generate_expected_cache_tree () {
    + 	dir="$1${1:+/}" &&
    + 	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
    + 	# We want to count only foo because it's the only direct child
     @@ t/t0090-cache-tree.sh: generate_expected_cache_tree_rec () {
      	printf "SHA $dir (%d entries, %d subtrees)\n" "$entries" "$subtree_count" &&
      	for subtree in $subtrees
    @@ t/t0090-cache-tree.sh: generate_expected_cache_tree_rec () {
     -		generate_expected_cache_tree_rec "$dir$subtree" || return 1
     -		cd ..
     +		(
    -+			cd "$subtree"
    -+			generate_expected_cache_tree_rec "$dir$subtree" || return 1
    -+		)
    ++			cd "$subtree" &&
    ++			generate_expected_cache_tree "$dir$subtree"
    ++		) || return 1
      	done
      }
      
    @@ t/t0090-cache-tree.sh: generate_expected_cache_tree_rec () {
     -}
     -
      test_cache_tree () {
    --	generate_expected_cache_tree >expect &&
    -+	generate_expected_cache_tree_rec >expect &&
    + 	generate_expected_cache_tree >expect &&
      	cmp_cache_tree expect
    - }
    - 
 3:  fefdc570a5 !  4:  697b0084fd cache-tree tests: refactor overly complex function
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    cache-tree tests: refactor overly complex function
    +    cache-tree tests: explicitly test HEAD and index differences
     
    -    Refactor overly complex code added in 9c4d6c0297 (cache-tree: Write
    -    updated cache-tree after commit, 2014-07-13).
    +    The test code added in 9c4d6c0297 (cache-tree: Write updated
    +    cache-tree after commit, 2014-07-13) used "ls-files" in lieu of
    +    "ls-tree" because it wanted to test the data in the index, since this
    +    test is testing the cache-tree extension.
     
    -    Interestingly, in the numerous commits[1][2][3] who fixed commits bugs
    -    in this code since its introduction it seems not to have been noticed
    -    that we didn't need to be doing some dance with grep/cut/uniq/awk to
    -    extract this information. It can be done in a much simpler way with
    -    just "ls-tree" and "wc -l".
    +    Change the test to instead use "ls-tree" for traversal, and then
    +    explicitly check how HEAD differs from the index. This is more easily
    +    understood, and less fragile as numerous past bug fixes[1][2][3] to
    +    the old code we're replacing demonstrate.
     
    -    I'm also removing the comment, because I think now that this code is
    -    trivial to understand it's not needed anymore.
    +    As an aside this would be a bit easier if empty pathspecs hadn't been
    +    made an error in d426430e6e (pathspec: warn on empty strings as
    +    pathspec, 2016-06-22) and 9e4e8a64c2 (pathspec: die on empty strings
    +    as pathspec, 2017-06-06).
    +
    +    If that was still allowed this code could be simplified slightly:
    +
    +            diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
    +            index 9bf66c9e68..0b02881f55 100755
    +            --- a/t/t0090-cache-tree.sh
    +            +++ b/t/t0090-cache-tree.sh
    +            @@ -18,19 +18,18 @@ cmp_cache_tree () {
    +             # test-tool dump-cache-tree already verifies that all existing data is
    +             # correct.
    +             generate_expected_cache_tree () {
    +            -       pathspec="$1" &&
    +            -       dir="$2${2:+/}" &&
    +            +       pathspec="$1${1:+/}" &&
    +                    git ls-tree --name-only HEAD -- "$pathspec" >files &&
    +                    git ls-tree --name-only -d HEAD -- "$pathspec" >subtrees &&
    +            -       printf "SHA %s (%d entries, %d subtrees)\n" "$dir" $(wc -l <files) $(wc -l <subtrees) &&
    +            +       printf "SHA %s (%d entries, %d subtrees)\n" "$pathspec" $(wc -l <files) $(wc -l <subtrees) &&
    +                    while read subtree
    +                    do
    +            -               generate_expected_cache_tree "$pathspec/$subtree/" "$subtree" || return 1
    +            +               generate_expected_cache_tree "$subtree" || return 1
    +                    done <subtrees
    +             }
    +
    +             test_cache_tree () {
    +            -       generate_expected_cache_tree "." >expect &&
    +            +       generate_expected_cache_tree >expect &&
    +                    cmp_cache_tree expect &&
    +                    rm expect actual files subtrees &&
    +                    git status --porcelain -- ':!status' ':!expected.status' >status &&
     
         1. c8db708d5d (t0090: avoid passing empty string to printf %d,
            2014-09-30)
    @@ Commit message
     
      ## t/t0090-cache-tree.sh ##
     @@ t/t0090-cache-tree.sh: cmp_cache_tree () {
    + # test-tool dump-cache-tree already verifies that all existing data is
      # correct.
    - generate_expected_cache_tree_rec () {
    - 	dir="$1${1:+/}" &&
    + generate_expected_cache_tree () {
    +-	dir="$1${1:+/}" &&
     -	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
     -	# We want to count only foo because it's the only direct child
     -	git ls-files >files &&
    @@ t/t0090-cache-tree.sh: cmp_cache_tree () {
     -	entries=$(wc -l <files) &&
     -	printf "SHA $dir (%d entries, %d subtrees)\n" "$entries" "$subtree_count" &&
     -	for subtree in $subtrees
    -+	git ls-tree --name-only HEAD >files &&
    -+	git ls-tree --name-only -d HEAD >subtrees &&
    ++	pathspec="$1" &&
    ++	dir="$2${2:+/}" &&
    ++	git ls-tree --name-only HEAD -- "$pathspec" >files &&
    ++	git ls-tree --name-only -d HEAD -- "$pathspec" >subtrees &&
     +	printf "SHA %s (%d entries, %d subtrees)\n" "$dir" $(wc -l <files) $(wc -l <subtrees) &&
     +	while read subtree
      	do
    - 		(
    - 			cd "$subtree"
    --			generate_expected_cache_tree_rec "$dir$subtree" || return 1
    -+			generate_expected_cache_tree_rec "$subtree" || return 1
    - 		)
    +-		(
    +-			cd "$subtree" &&
    +-			generate_expected_cache_tree "$dir$subtree"
    +-		) || return 1
     -	done
    ++		generate_expected_cache_tree "$pathspec/$subtree/" "$subtree" || return 1
     +	done <subtrees
      }
      
      test_cache_tree () {
    +-	generate_expected_cache_tree >expect &&
    +-	cmp_cache_tree expect
    ++	generate_expected_cache_tree "." >expect &&
    ++	cmp_cache_tree expect &&
    ++	rm expect actual files subtrees &&
    ++	git status --porcelain -- ':!status' ':!expected.status' >status &&
    ++	if test -n "$1"
    ++	then
    ++		test_cmp "$1" status
    ++	else
    ++		test_must_be_empty status
    ++	fi
    + }
    + 
    + test_invalid_cache_tree () {
    +@@ t/t0090-cache-tree.sh: test_expect_success 'second commit has cache-tree' '
    + '
    + 
    + test_expect_success PERL 'commit --interactive gives cache-tree on partial commit' '
    ++	test_when_finished "git reset --hard" &&
    + 	cat <<-\EOT >foo.c &&
    + 	int foo()
    + 	{
    +@@ t/t0090-cache-tree.sh: test_expect_success PERL 'commit --interactive gives cache-tree on partial commi
    + 	EOT
    + 	test_write_lines p 1 "" s n y q |
    + 	git commit --interactive -m foo &&
    +-	test_cache_tree
    ++	cat <<-\EOF >expected.status &&
    ++	 M foo.c
    ++	EOF
    ++	test_cache_tree expected.status
    + '
    + 
    + test_expect_success PERL 'commit -p with shrinking cache-tree' '
    +@@ t/t0090-cache-tree.sh: test_expect_success 'partial commit gives cache-tree' '
    + 	git add one.t &&
    + 	echo "some other change" >two.t &&
    + 	git commit two.t -m partial &&
    +-	test_cache_tree
    ++	cat <<-\EOF >expected.status &&
    ++	M  one.t
    ++	EOF
    ++	test_cache_tree expected.status
    + '
    + 
    + test_expect_success 'no phantom error when switching trees' '
 4:  a16938e58d =  5:  5ede74a1ab git svn mergeinfo tests: modernize redirection & quoting style
 5:  b520656240 =  6:  c287f5a24a git svn mergeinfo tests: refactor "test -z" to use test_must_be_empty
 6:  f2e70ac911 !  7:  9bd6ad6e25 git-svn tests: rewrite brittle tests to use "--[no-]merges".
    @@ Commit message
         to figure out if a set of commits turned into merge commits or not.
     
         Signed-off-by: Jeff King <peff@peff.net>
    +    [ÆAB: wrote commit message]
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    -    Commit-message-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t9151-svn-mergeinfo.sh ##
     @@ t/t9151-svn-mergeinfo.sh: test_expect_success 'load svn dump' "
 7:  dcf001e165 <  -:  ---------- rm tests: actually test for SIGPIPE in SIGPIPE test
 8:  2212fa65eb !  8:  fd40e818a7 upload-pack tests: avoid a non-zero "grep" exit status
    @@ Commit message
         upload-pack tests: avoid a non-zero "grep" exit status
     
         Continue changing a test that 763b47bafa (t5703: stop losing return
    -    codes of git commands, 2019-11-27) already refactored. A follow-up
    -    commit will add support for testing under bash's "set -o pipefail",
    -    under that mode this test will fail because sometimes there's no
    -    commits in the "objs" output.
    +    codes of git commands, 2019-11-27) already refactored.
     
    -    It's easier to just fix this than to exempt these tests under a
    -    soon-to-be added "set -o pipefail" test mode. So let's do that.
    +    This was originally added as part of a series to add support for
    +    running under bash's "set -o pipefail", under that mode this test will
    +    fail because sometimes there's no commits in the "objs" output.
    +
    +    It's easier to fix that than exempt these tests under a hypothetical
    +    "set -o pipefail" test mode. It looks like we probably won't have
    +    that, but once we've dug this code up let's refactor it[2] so we don't
    +    hide a potential pipe failure.
    +
    +    1. https://lore.kernel.org/git/xmqqzh18o8o6.fsf@gitster.c.googlers.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/t5703-upload-pack-ref-in-want.sh: get_actual_commits () {
      	git index-pack o.pack &&
      	git verify-pack -v o.idx >objs &&
     -	grep commit objs | cut -d" " -f1 | sort >actual_commits
    -+	>actual_commits &&
    -+	if grep -q commit objs
    -+	then
    -+		grep commit objs | cut -d" " -f1 | sort >actual_commits
    -+	fi
    ++	sed -n -e 's/\([0-9a-f][0-9a-f]*\) commit .*/\1/p' objs >objs.sed &&
    ++	sort >actual_commits <objs.sed
      }
      
      check_output () {
 9:  8167c2e346 =  9:  5405062665 archive tests: use a cheaper "zipinfo -h" invocation to get header
10:  30c454ae7c <  -:  ---------- tests: split up bash detection library
11:  6f290f850c <  -:  ---------- tests: add a "set -o pipefail" for a patched bash
 -:  ---------- > 10:  b526b3cb24 rm tests: actually test for SIGPIPE in SIGPIPE test
-- 
2.29.2.222.g5d2a92d10f8

