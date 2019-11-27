Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21640C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D732F20835
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtNajnPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfK0TxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:53:04 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33577 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfK0TxE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:53:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id y206so3002255pfb.0
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=85Nu/L7ntJCR+Xk35atqr/vJhcuRoHhHEjIBceD/+mw=;
        b=LtNajnPr4xnm2Ml/n6sPdJ0AxHIiNCxiS859/cyMaawWveoPruHzdMMXgBNV3F8ZzJ
         8346TOPfe/vIHwvukH36/ELQjId9Dwg81LxxyQzc2kK84dfzS302TkFd7Qjtyad8d7FR
         VAdF5Tf4xcLjL9/EO6hapi3WMnM5B5VdN3ByuFweNbGmkhDNI7kteImGn2KgztsQw0x6
         DVEuyFPjaN6AM9UuNhGdwRcHeadXPWIP61ldBUL9wtsSrB5OjD/laaH2zoe6g3zgvYHQ
         TXsCKCEUwMVCNY6aZ1OjjiEjx+RApqJ2LiqUzZIyy9YOVW3WnIHsg9JSohgoS4uaCyK6
         xq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=85Nu/L7ntJCR+Xk35atqr/vJhcuRoHhHEjIBceD/+mw=;
        b=M7K7dRS5Tm/JdHajB34VnbAUsYrC8AoY1se0M9v8/fPfdzj9YdJzwRuTZ53iWJ5a1A
         7PPniRXXRF7zAN5sNn+2gwrX9CM94nQwbj8ow7XsI6bCbeCG1i3ZAV9jhhW5UJcO5Naf
         751OGqODMCFv59xqIVNQyZD5iWA6LtqjodGd8GmFPEdrq6Qw9iMTRWGy4LwV8fVkV5vG
         HRFiBq5xYL37l5u15xnFIH+tGCfQM7AEuw8cHhq9n4wpuYMWKFYjubNZ11Rhcwl1QqHs
         syEKZyG1VOf1pOju0iSkWAjpXda3sCC34gNHIUkYzjwXxKFgqnLCPDASf0/MPZNtA67/
         dOzQ==
X-Gm-Message-State: APjAAAUXaz4Yk63gt/ZV+wy9Gkutr4Nc/oxI0RH4kTvglTHg1nx72Xlp
        zp2gUYOhWxiwCFzHlfGi3gXyhTvT
X-Google-Smtp-Source: APXvYqwsmN5itjTf5cFVInusVMbEOBLTpMVrI2/GJ9OoVXyFfFczq9alH5e4AsSWsoFaQdk9ul/QbA==
X-Received: by 2002:a62:5485:: with SMTP id i127mr41325131pfb.186.1574884383130;
        Wed, 27 Nov 2019 11:53:03 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id h4sm7405958pjs.24.2019.11.27.11.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:53:02 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:53:00 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 00/26] t: test cleanup stemming from experimentally
 enabling pipefail
Message-ID: <cover.1574884302.git.liu.denton@gmail.com>
References: <cover.1574731022.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574731022.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches perform some general test cleanup to modernise the style.
They should be relatively uncontroversial. The reason these tests were
identified for cleanup was because they failed under `set -o pipefail`.

I've gotten rid of the RFC part that actually enables `set -o pipefail`
on supported platforms. As Peff pointed out, there are a lot of
opportunities for racy SIGPIPE failures so that part still needs a lot
of work to be ironed out.

Those changes shouldn't hold back the first part of the series, however.
Let's try to get this test cleanup merged in sooner than later so that
any new test cases done by copy-paste will have their changes
represented.

Changes since v4:

* Squash in "squash! t7700: consolidate code into test_no_missing_in_packs()"

* Fix typo in "t7700: consolidate code into test_no_missing_in_packs()"

* Use "oid" and "packid" instead of "objoid" and "packoid" in "t7700:
  make references to SHA-1 generic"

Changes since v3:

* More commit message update

* Clean up "apply-one-time-sed.sh: modernize style" more according to
  Junio's suggestions

* Clean up the t7700 leftover bits

Changes since v2:

* Update commit messages according to Eric's suggestions

* Add "apply-one-time-sed.sh: modernize style"

Changes since v1:

* Removed the `set -o pipefail` changes

* Addressed Junio and Eric's comments on the first part of the series

Denton Liu (26):
  lib-bash.sh: move `then` onto its own line
  apply-one-time-sed.sh: modernize style
  t0014: remove git command upstream of pipe
  t0090: stop losing return codes of git commands
  t3301: stop losing return codes of git commands
  t3600: use test_line_count() where possible
  t3600: stop losing return codes of git commands
  t3600: comment on inducing SIGPIPE in `git rm`
  t4015: stop losing return codes of git commands
  t4015: use test_write_lines()
  t4138: stop losing return codes of git commands
  t5317: stop losing return codes of git commands
  t5317: use ! grep to check for no matching lines
  t5703: simplify one-time-sed generation logic
  t5703: stop losing return codes of git commands
  t7501: remove spaces after redirect operators
  t7501: stop losing return codes of git commands
  t7700: drop redirections to /dev/null
  t7700: remove spaces after redirect operators
  t7700: move keywords onto their own line
  t7700: s/test -f/test_path_is_file/
  t7700: consolidate code into test_no_missing_in_packs()
  t7700: consolidate code into test_has_duplicate_object()
  t7700: replace egrep with grep
  t7700: make references to SHA-1 generic
  t7700: stop losing return codes of git commands

 t/lib-bash.sh                          |   6 +-
 t/lib-httpd/apply-one-time-sed.sh      |   8 +-
 t/t0014-alias.sh                       |   4 +-
 t/t0090-cache-tree.sh                  |   5 +-
 t/t3301-notes.sh                       | 230 ++++++++++++++++++-------
 t/t3600-rm.sh                          |  14 +-
 t/t4015-diff-whitespace.sh             | 123 +++++++------
 t/t4138-apply-ws-expansion.sh          |  16 +-
 t/t5317-pack-objects-filter-objects.sh |  34 ++--
 t/t5703-upload-pack-ref-in-want.sh     |  53 +++---
 t/t7501-commit-basic-functionality.sh  |  83 +++++----
 t/t7700-repack.sh                      | 172 ++++++++----------
 12 files changed, 425 insertions(+), 323 deletions(-)

Range-diff against v4:
 1:  d5e769af39 =  1:  9085cc00af lib-bash.sh: move `then` onto its own line
 2:  31434dfb4b =  2:  86f625c65e apply-one-time-sed.sh: modernize style
 3:  e4443a6358 =  3:  3844e00367 t0014: remove git command upstream of pipe
 4:  712354f90c =  4:  7d33586b21 t0090: stop losing return codes of git commands
 5:  adef902872 =  5:  df6b3393c4 t3301: stop losing return codes of git commands
 6:  a79cfe261a =  6:  d541a8d4d4 t3600: use test_line_count() where possible
 7:  bfbb8bde3a =  7:  a8aeca6795 t3600: stop losing return codes of git commands
 8:  714da9e618 =  8:  e3db06578d t3600: comment on inducing SIGPIPE in `git rm`
 9:  4d5f40f3b0 =  9:  22ea5d736e t4015: stop losing return codes of git commands
10:  68ed9ba7b6 = 10:  a44dd28b4d t4015: use test_write_lines()
11:  c1ce767a98 = 11:  d512319be0 t4138: stop losing return codes of git commands
12:  b5fa2ddb87 = 12:  1e08c2b68b t5317: stop losing return codes of git commands
13:  000126915e = 13:  fa238be28b t5317: use ! grep to check for no matching lines
14:  e18ab06152 = 14:  291caf9bc1 t5703: simplify one-time-sed generation logic
15:  42b63b4735 = 15:  edf7af76ae t5703: stop losing return codes of git commands
16:  e816d6e18d = 16:  5eb7117fbe t7501: remove spaces after redirect operators
17:  6147ec6e8f = 17:  bad732adc8 t7501: stop losing return codes of git commands
18:  7013c3a3c7 = 18:  c50c192429 t7700: drop redirections to /dev/null
19:  f421b35adb = 19:  58ae066d12 t7700: remove spaces after redirect operators
20:  7b8d5767fb = 20:  82bf24d06a t7700: move keywords onto their own line
21:  dafc8da2d2 = 21:  251de77677 t7700: s/test -f/test_path_is_file/
22:  1e8f239080 ! 22:  a99a45cb6f t7700: consolidate code into test_no_missing_in_packs()
    @@ Commit message
         exactly what grep is built for. Replace this invocation of sed with grep
         so that we use the correct tool for the job.
     
    +    Instead of verifying each file of `alt_objects/pack/*.idx` individually
    +    in a for-loop, batch them together into one verification step.
    +
         The original testing construct was O(n^2): it used a grep in a loop to
         test whether any objects were missing in the packfile. Rewrite this to
    -    use sort the files then use `comm -23` so that finding missing lines
    -    from the original file is done more efficiently.
    +    sort the files then use `comm -23` so that finding missing lines from
    +    the original file is done more efficiently.
     
         While we're at it, add a space to `commit_and_pack ()` for style.
     
    @@ t/t7700-repack.sh: test_description='git repack works correctly'
     +test_no_missing_in_packs () {
     +	myidx=$(ls -1 .git/objects/pack/*.idx) &&
     +	test_path_is_file "$myidx" &&
    -+	for p in alt_objects/pack/*.idx
    -+	do
    -+		git verify-pack -v $p >packlist || return $?
    -+		grep "^[0-9a-f]\{40\}" packlist
    -+	done >orig.raw &&
    -+	cut -d" " -f1 orig.raw | sort >orig &&
    ++	git verify-pack -v alt_objects/pack/*.idx >orig.raw &&
    ++	grep "^[0-9a-f]\{40\}" orig.raw | cut -d" " -f1 | sort >orig &&
     +	git verify-pack -v $myidx >dest.raw &&
     +	cut -d" " -f1 dest.raw | sort >dest &&
     +	comm -23 orig dest >missing &&
23:  4b70b92e1d <  -:  ---------- squash! t7700: consolidate code into test_no_missing_in_packs()
24:  b0e58908d9 = 23:  f79240e937 t7700: consolidate code into test_has_duplicate_object()
25:  6bd266035f = 24:  632a62f6e9 t7700: replace egrep with grep
26:  8193fee859 ! 25:  bf70cc5a0d t7700: make references to SHA-1 generic
    @@ Commit message
         t7700: make references to SHA-1 generic
     
         Make the test more hash-agnostic by renaming variables from "sha1" to
    -    "oid" (case-insensitively). Also, replace the regex, `[0-9a-f]\{40\}`
    -    with `$OID_REGEX`.
    +    some variation of "oid" or "packid". Also, replace the regex,
    +    `[0-9a-f]\{40\}` with `$OID_REGEX`.
    +
    +    A better name for "incrpackid" (incremental pack-id) might have been
    +    just "packid". However, later in the test suite, we have other uses of
    +    "packid". Although the scopes of these variables don't conflict, a
    +    future developer may think that commit_and_pack() and
    +    test_has_duplicate_object() are semantically related somehow since they
    +    share the same variable name. Give them distinct names so that it's
    +    clear these uses are unrelated.
     
      ## t/t7700-repack.sh ##
     @@ t/t7700-repack.sh: test_description='git repack works correctly'
    @@ t/t7700-repack.sh: test_description='git repack works correctly'
      	test_commit "$@" 1>&2 &&
     -	SHA1=$(git pack-objects --all --unpacked --incremental .git/objects/pack/pack </dev/null) &&
     -	echo pack-${SHA1}.pack
    -+	OID=$(git pack-objects --all --unpacked --incremental .git/objects/pack/pack </dev/null) &&
    -+	echo pack-${OID}.pack
    ++	incrpackid=$(git pack-objects --all --unpacked --incremental .git/objects/pack/pack </dev/null) &&
    ++	echo pack-${incrpackid}.pack
      }
      
      test_no_missing_in_packs () {
    @@ t/t7700-repack.sh: test_description='git repack works correctly'
      }
      
     -# we expect $packsha1 and $objsha1 to be defined
    -+# we expect $packoid and $objoid to be defined
    ++# we expect $packid and $oid to be defined
      test_has_duplicate_object () {
      	want_duplicate_object="$1"
      	found_duplicate_object=false
    @@ t/t7700-repack.sh: test_description='git repack works correctly'
      	do
      		idx=$(basename $p)
     -		test "pack-$packsha1.idx" = "$idx" && continue
    -+		test "pack-$packoid.idx" = "$idx" && continue
    ++		test "pack-$packid.idx" = "$idx" && continue
      		git verify-pack -v $p >packlist || return $?
     -		if grep "^$objsha1" packlist
    -+		if grep "^$objoid" packlist
    ++		if grep "^$oid" packlist
      		then
      			found_duplicate_object=true
      			echo "DUPLICATE OBJECT FOUND"
    @@ t/t7700-repack.sh: test_expect_success 'objects in packs marked .keep are not re
      		git pack-objects pack &&
      	# The second pack will contain the excluded object
     -	packsha1=$(git rev-list --objects --all | grep file2 |
    -+	packoid=$(git rev-list --objects --all | grep file2 |
    ++	packid=$(git rev-list --objects --all | grep file2 |
      		git pack-objects pack) &&
     -	>pack-$packsha1.keep &&
     -	objsha1=$(git verify-pack -v pack-$packsha1.idx | head -n 1 |
     -		sed -e "s/^\([0-9a-f]\{40\}\).*/\1/") &&
    -+	>pack-$packoid.keep &&
    -+	objoid=$(git verify-pack -v pack-$packoid.idx | head -n 1 |
    ++	>pack-$packid.keep &&
    ++	oid=$(git verify-pack -v pack-$packid.idx | head -n 1 |
     +		sed -e "s/^\($OID_REGEX\).*/\1/") &&
      	mv pack-* .git/objects/pack/ &&
      	git repack -A -d -l &&
    @@ t/t7700-repack.sh: test_expect_success 'objects in packs marked .keep are not re
      
      test_expect_success 'writing bitmaps via command-line can duplicate .keep objects' '
     -	# build on $objsha1, $packsha1, and .keep state from previous
    -+	# build on $objoid, $packoid, and .keep state from previous
    ++	# build on $oid, $packid, and .keep state from previous
      	git repack -Adbl &&
      	test_has_duplicate_object true
      '
      
      test_expect_success 'writing bitmaps via config can duplicate .keep objects' '
     -	# build on $objsha1, $packsha1, and .keep state from previous
    -+	# build on $objoid, $packoid, and .keep state from previous
    ++	# build on $oid, $packid, and .keep state from previous
      	git -c repack.writebitmaps=true repack -Adl &&
      	test_has_duplicate_object true
      '
    @@ t/t7700-repack.sh: test_expect_success 'loose objects in alternate ODB are not r
      	echo $(pwd)/alt_objects >.git/objects/info/alternates &&
      	echo content3 >file3 &&
     -	objsha1=$(GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w file3) &&
    -+	objoid=$(GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w file3) &&
    ++	oid=$(GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w file3) &&
      	git add file3 &&
      	test_tick &&
      	git commit -m commit_file3 &&
27:  456aeaa506 ! 26:  1f6d9a80ad t7700: stop losing return codes of git commands
    @@ t/t7700-repack.sh: test_expect_success 'objects in packs marked .keep are not re
     +	git rev-list --objects --all >objs &&
     +	grep -v file2 objs | git pack-objects pack &&
      	# The second pack will contain the excluded object
    --	packoid=$(git rev-list --objects --all | grep file2 |
    +-	packid=$(git rev-list --objects --all | grep file2 |
     -		git pack-objects pack) &&
    -+	packoid=$(grep file2 objs | git pack-objects pack) &&
    - 	>pack-$packoid.keep &&
    --	objoid=$(git verify-pack -v pack-$packoid.idx | head -n 1 |
    ++	packid=$(grep file2 objs | git pack-objects pack) &&
    + 	>pack-$packid.keep &&
    +-	oid=$(git verify-pack -v pack-$packid.idx | head -n 1 |
     -		sed -e "s/^\($OID_REGEX\).*/\1/") &&
    -+	git verify-pack -v pack-$packoid.idx >packlist &&
    -+	objoid=$(head -n 1 packlist | sed -e "s/^\($OID_REGEX\).*/\1/") &&
    ++	git verify-pack -v pack-$packid.idx >packlist &&
    ++	oid=$(head -n 1 packlist | sed -e "s/^\($OID_REGEX\).*/\1/") &&
      	mv pack-* .git/objects/pack/ &&
      	git repack -A -d -l &&
      	git prune-packed &&
-- 
2.24.0.504.g3cd56eb17d

