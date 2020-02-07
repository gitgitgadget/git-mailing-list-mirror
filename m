Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FCAC352A2
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB11214AF
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="QSXtvcdO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgBGAxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:53:34 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55512 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726509AbgBGAxe (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 19:53:34 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 602A160456;
        Fri,  7 Feb 2020 00:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581036811;
        bh=jJ8vImcvsnzqTqdyXh175kTAMB3h3f8tv1voGriAk4Y=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QSXtvcdO9zAjgplFq3kFEWz5Ip8+qHslOY8XD47Qk9f0ypFJOv6ztdiJzZpdU76N2
         2IcuxmhgdzTZIkGf1y/VeQZrV2UGpt2uTPka/vkTVFLlN52V190HLEKU8AWN88TYij
         EL6mi1mfq4o9yAxDtspYAxACL9qJKR/vAl5x2IuYAYAafP1Aw2yFxxn3dpF2GZioTN
         AEhp/rNLOTsE2AGrYusrv3dV3F7+dx3T36ZH340o935yMkT05v7+7pbeQLHUJKNwMD
         pk/I7lJ3WpQHpqZPy7gU0uHg9n5Pl7EZCxj/qOBNhFu619csX775Y3fBIMzPez+Uoe
         PlvNqWTj9jiAhRJJusnN8XSdB3U7XMG0eNexgIdJheLKxEA1jU0gmZKeODVDzkSK+K
         ja80C3afpfe3v2ctMwU2XV/vwe8yaI291nHXjO9sNPY3p7mfgb2ExFGFe5grZrpVv+
         p1Lok8A8QoCDGTVhKXCMS4EAwjB5U0AFU8mKM+lr9ltU/QsYBuD
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 00/21] SHA-256 test fixes, part 8
Date:   Fri,  7 Feb 2020 00:52:33 +0000
Message-Id: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is the penultimate series of SHA-256 test fixes.

v3 is a bit larger due to the increase in t4211 test cases, but
otherwise has shrunk in terms of patches from v2.

Changes from v2:
* Drop t3305 in favor of Johan Herland's patch series.
* Add underscores to variables in t4013.
* Add SHA-256 test cases to t4211 and restructure test accordingly.
* Adopt proposed fixes to t5302.
* Replace "sorted-sha1" with "sorted-hash" in t5313.
* Use a sed script in t5515 to make operations more efficient.
* Consolidated both patches for t5703 into one.

Changes from v1:
* Drop patch for t3404 in favor of Dscho's fix.
* Drop patch for t5616 in favor of Jonathan Tan's fix.
* Add missing sign-off.
* Move test_oid_init into the correct patch.

brian m. carlson (21):
  t/lib-pack: support SHA-256
  t3206: make hash size independent
  t3308: make test work with SHA-256
  t3309: make test work with SHA-256
  t3310: make test work with SHA-256
  t3311: make test work with SHA-256
  t4013: make test hash independent
  t4211: move SHA-1-specific test cases into a directory
  t4211: add test cases for SHA-256
  t4060: make test work with SHA-256
  t5302: make hash size independent
  t5309: make test hash independent
  t5313: make test hash independent
  t5321: make test hash independent
  t5515: make test hash independent
  t5318: update for SHA-256
  t5607: make hash size independent
  t5703: make test work with SHA-256
  t6000: abstract away SHA-1-specific constants
  t6006: make hash size independent
  t6024: update for SHA-256

 t/lib-pack.sh                                 |  35 ++-
 t/t3206-range-diff.sh                         |  14 +-
 t/t3308-notes-merge.sh                        |  83 ++++---
 t/t3309-notes-merge-auto-resolve.sh           | 228 +++++++++++-------
 t/t3310-notes-merge-manual-resolve.sh         |  84 +++++--
 t/t3311-notes-merge-fanout.sh                 |  60 +++--
 t/t4013-diff-various.sh                       |  44 +++-
 t/t4060-diff-submodule-option-diff-format.sh  | 126 +++++-----
 t/t4211-line-log.sh                           |   3 +-
 t/t4211/{ => sha1}/expect.beginning-of-file   |   0
 t/t4211/{ => sha1}/expect.end-of-file         |   0
 t/t4211/{ => sha1}/expect.move-support-f      |   0
 t/t4211/{ => sha1}/expect.multiple            |   0
 .../{ => sha1}/expect.multiple-overlapping    |   0
 t/t4211/{ => sha1}/expect.multiple-superset   |   0
 .../expect.parallel-change-f-to-main          |   0
 t/t4211/{ => sha1}/expect.simple-f            |   0
 t/t4211/{ => sha1}/expect.simple-f-to-main    |   0
 t/t4211/{ => sha1}/expect.simple-main         |   0
 t/t4211/{ => sha1}/expect.simple-main-to-end  |   0
 t/t4211/{ => sha1}/expect.two-ranges          |   0
 t/t4211/{ => sha1}/expect.vanishes-early      |   0
 t/t4211/{ => sha256}/expect.beginning-of-file |   6 +-
 t/t4211/{ => sha256}/expect.end-of-file       |   8 +-
 t/t4211/{ => sha256}/expect.move-support-f    |   8 +-
 t/t4211/{ => sha256}/expect.multiple          |  10 +-
 .../{ => sha256}/expect.multiple-overlapping  |  12 +-
 t/t4211/{ => sha256}/expect.multiple-superset |  12 +-
 .../expect.parallel-change-f-to-main          |  16 +-
 t/t4211/{ => sha256}/expect.simple-f          |   6 +-
 t/t4211/{ => sha256}/expect.simple-f-to-main  |   8 +-
 t/t4211/{ => sha256}/expect.simple-main       |   8 +-
 .../{ => sha256}/expect.simple-main-to-end    |   8 +-
 t/t4211/{ => sha256}/expect.two-ranges        |  10 +-
 t/t4211/{ => sha256}/expect.vanishes-early    |   6 +-
 t/t5302-pack-index.sh                         |  21 +-
 t/t5309-pack-delta-cycles.sh                  |  10 +-
 t/t5313-pack-bounds-checks.sh                 |  19 +-
 t/t5318-commit-graph.sh                       |   4 +-
 t/t5321-pack-large-objects.sh                 |   4 +-
 t/t5515-fetch-merge-logic.sh                  |  59 ++++-
 t/t5607-clone-bundle.sh                       |   2 +-
 t/t5703-upload-pack-ref-in-want.sh            |   7 +-
 t/t6000-rev-list-misc.sh                      |  13 +-
 t/t6006-rev-list-format.sh                    |   4 +-
 t/t6024-recursive-merge.sh                    |  15 +-
 46 files changed, 615 insertions(+), 338 deletions(-)
 copy t/t4211/{ => sha1}/expect.beginning-of-file (100%)
 copy t/t4211/{ => sha1}/expect.end-of-file (100%)
 copy t/t4211/{ => sha1}/expect.move-support-f (100%)
 copy t/t4211/{ => sha1}/expect.multiple (100%)
 copy t/t4211/{ => sha1}/expect.multiple-overlapping (100%)
 copy t/t4211/{ => sha1}/expect.multiple-superset (100%)
 copy t/t4211/{ => sha1}/expect.parallel-change-f-to-main (100%)
 copy t/t4211/{ => sha1}/expect.simple-f (100%)
 copy t/t4211/{ => sha1}/expect.simple-f-to-main (100%)
 copy t/t4211/{ => sha1}/expect.simple-main (100%)
 copy t/t4211/{ => sha1}/expect.simple-main-to-end (100%)
 copy t/t4211/{ => sha1}/expect.two-ranges (100%)
 copy t/t4211/{ => sha1}/expect.vanishes-early (100%)
 rename t/t4211/{ => sha256}/expect.beginning-of-file (75%)
 rename t/t4211/{ => sha256}/expect.end-of-file (77%)
 rename t/t4211/{ => sha256}/expect.move-support-f (77%)
 rename t/t4211/{ => sha256}/expect.multiple (79%)
 rename t/t4211/{ => sha256}/expect.multiple-overlapping (83%)
 rename t/t4211/{ => sha256}/expect.multiple-superset (83%)
 rename t/t4211/{ => sha256}/expect.parallel-change-f-to-main (78%)
 rename t/t4211/{ => sha256}/expect.simple-f (77%)
 rename t/t4211/{ => sha256}/expect.simple-f-to-main (79%)
 rename t/t4211/{ => sha256}/expect.simple-main (77%)
 rename t/t4211/{ => sha256}/expect.simple-main-to-end (78%)
 rename t/t4211/{ => sha256}/expect.two-ranges (79%)
 rename t/t4211/{ => sha256}/expect.vanishes-early (74%)

Range-diff against v2:
 1:  3cf0a234b5 =  1:  0c219d6dc3 t/lib-pack: support SHA-256
 2:  174fb9325d =  2:  427d42c03f t3206: make hash size independent
 3:  ce9f103b2c <  -:  ---------- t3305: annotate with SHA1 prerequisite
 4:  294cdb98a3 =  3:  387b1ef0a1 t3308: make test work with SHA-256
 5:  8c3c7975aa =  4:  3ff1f44a6f t3309: make test work with SHA-256
 6:  09cc75b2e0 =  5:  42cca3b5d2 t3310: make test work with SHA-256
 7:  368f4f07f8 =  6:  38ecd05cb3 t3311: make test work with SHA-256
 8:  1626574e2e !  7:  9c0d2209cc t4013: make test hash independent
    @@ t/t4013-diff-various.sh: test_expect_success setup '
      EOF
      
     +process_diffs () {
    -+	x04="[0-9a-f][0-9a-f][0-9a-f][0-9a-f]" &&
    -+	x07="$_x05[0-9a-f][0-9a-f]" &&
    ++	_x04="[0-9a-f][0-9a-f][0-9a-f][0-9a-f]" &&
    ++	_x07="$_x05[0-9a-f][0-9a-f]" &&
     +	sed -e "s/$OID_REGEX/$ZERO_OID/g" \
     +	    -e "s/From $_x40 /From $ZERO_OID /" \
     +	    -e "s/from $_x40)/from $ZERO_OID)/" \
    @@ t/t4013-diff-various.sh: test_expect_success setup '
     +	    -e "s/^$_x40 $_x40$/$ZERO_OID $ZERO_OID/" \
     +	    -e "s/^$_x40 /$ZERO_OID /" \
     +	    -e "s/^$_x40$/$ZERO_OID/" \
    -+	    -e "s/$x07\.\.$x07/fffffff..fffffff/g" \
    -+	    -e "s/$x07,$x07\.\.$x07/fffffff,fffffff..fffffff/g" \
    -+	    -e "s/$x07 $x07 $x07/fffffff fffffff fffffff/g" \
    -+	    -e "s/$x07 $x07 /fffffff fffffff /g" \
    -+	    -e "s/Merge: $x07 $x07/Merge: fffffff fffffff/g" \
    -+	    -e "s/$x07\.\.\./fffffff.../g" \
    -+	    -e "s/ $x04\.\.\./ ffff.../g" \
    -+	    -e "s/ $x04/ ffff/g" \
    ++	    -e "s/$_x07\.\.$_x07/fffffff..fffffff/g" \
    ++	    -e "s/$_x07,$_x07\.\.$_x07/fffffff,fffffff..fffffff/g" \
    ++	    -e "s/$_x07 $_x07 $_x07/fffffff fffffff fffffff/g" \
    ++	    -e "s/$_x07 $_x07 /fffffff fffffff /g" \
    ++	    -e "s/Merge: $_x07 $_x07/Merge: fffffff fffffff/g" \
    ++	    -e "s/$_x07\.\.\./fffffff.../g" \
    ++	    -e "s/ $_x04\.\.\./ ffff.../g" \
    ++	    -e "s/ $_x04/ ffff/g" \
     +	    "$1"
     +}
     +
 -:  ---------- >  8:  b26cda12e1 t4211: move SHA-1-specific test cases into a directory
 -:  ---------- >  9:  2c9d7bed6c t4211: add test cases for SHA-256
 9:  293a7de6c5 = 10:  aef4e633c0 t4060: make test work with SHA-256
10:  6d145eb073 <  -:  ---------- t4211: make test hash independent
11:  eb7ce42e0e ! 11:  34870c3e84 t5302: make hash size independent
    @@ Commit message
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## t/t5302-pack-index.sh ##
    -@@ t/t5302-pack-index.sh: test_description='pack index with 64-bit offsets and object CRC'
    +@@
    + test_description='pack index with 64-bit offsets and object CRC'
    + . ./test-lib.sh
      
    - test_expect_success \
    -     'setup' \
    +-test_expect_success \
    +-    'setup' \
     -    'rm -rf .git &&
    -+    'test_oid_init &&
    ++test_expect_success 'setup' '
    ++     test_oid_init &&
    ++     rawsz=$(test_oid rawsz) &&
     +     rm -rf .git &&
           git init &&
           git config pack.threads 1 &&
    @@ t/t5302-pack-index.sh: test_expect_success \
      	 git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
           } >obj-list &&
     -     git update-ref HEAD $commit'
    -+     git update-ref HEAD $commit &&
    -+     rawsz=$(test_oid rawsz)
    ++     git update-ref HEAD $commit
     +'
      
      test_expect_success \
          'pack-objects with index version 1' \
     @@ t/t5302-pack-index.sh: test_expect_success \
    -     '[index v1] 2) create a stealth corruption in a delta base reference' \
    -     '# This test assumes file_101 is a delta smaller than 16 bytes.
    -      # It should be against file_100 but we substitute its base for file_099
    -+     offset=$((rawsz + 4)) &&
    -      sha1_101=$(git hash-object file_101) &&
    -      sha1_099=$(git hash-object file_099) &&
           offs_101=$(index_obj_offset 1.idx $sha1_101) &&
    -@@ t/t5302-pack-index.sh: test_expect_success \
    +      nr_099=$(index_obj_nr 1.idx $sha1_099) &&
           chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
    ++     recordsz=$((rawsz + 4)) &&
           dd of=".git/objects/pack/pack-${pack1}.pack" seek=$(($offs_101 + 1)) \
              if=".git/objects/pack/pack-${pack1}.idx" \
     -        skip=$((4 + 256 * 4 + $nr_099 * 24)) \
     -        bs=1 count=20 conv=notrunc &&
    -+        skip=$((4 + 256 * 4 + $nr_099 * offset)) \
    ++        skip=$((4 + 256 * 4 + $nr_099 * recordsz)) \
     +        bs=1 count=$rawsz conv=notrunc &&
           git cat-file blob $sha1_101 > file_101_foo1'
      
12:  3d38f92e0c = 12:  c0746ca94e t5309: make test hash independent
13:  b44f4ccb19 ! 13:  1d0e795639 t5313: make test hash independent
    @@ t/t5313-pack-bounds-checks.sh: test_expect_success 'bogus offset inside v2 exten
      	#
      	# Note that the value is important here. We want $object as
     -	# the second entry in sorted-sha1 order. The sha1 of 1485 starts
    -+	# the second entry in sorted-sha1 order. The hash of this object starts
    ++	# the second entry in sorted-hash order. The hash of this object starts
      	# with "000", which sorts before that of $object (which starts
      	# with "fff").
     -	second=$(echo 1485 | git hash-object -w --stdin) &&
14:  a7025ea2b4 = 14:  62a11bfd93 t5321: make test hash independent
15:  fe5cfb2745 ! 15:  909fcd8d9f t5515: make test hash independent
    @@ t/t5515-fetch-merge-logic.sh: GIT_TEST_PROTOCOL_VERSION=
      
      . ./test-lib.sh
      
    -+convert_expected () {
    -+	file="$1" &&
    ++build_script () {
    ++	script="$1" &&
     +	for i in one three_file master master2 one_tree three two two2 three2
     +	do
    -+		sed -e "s/$(test_oid --hash=sha1 "$i")/$(test_oid "$i")/g" \
    -+			"$file" >"$file.tmp" &&
    -+		mv "$file.tmp" "$file"
    ++		echo "s/$(test_oid --hash=sha1 "$i")/$(test_oid "$i")/g" >>"$script"
     +	done
     +}
    ++
    ++convert_expected () {
    ++	file="$1" &&
    ++	script="$2" &&
    ++	sed -f "$script" "$file" >"$file.tmp" &&
    ++	mv "$file.tmp" "$file"
    ++}
     +
      test_expect_success setup '
      	GIT_AUTHOR_DATE="2006-06-26 00:00:00 +0000" &&
    @@ t/t5515-fetch-merge-logic.sh: GIT_TEST_PROTOCOL_VERSION=
      	echo >file original &&
      	git add file &&
      	git commit -a -m One &&
    +@@ t/t5515-fetch-merge-logic.sh: test_expect_success setup '
    + 		git config branch.br-$remote-octopus.remote $remote &&
    + 		git config branch.br-$remote-octopus.merge refs/heads/one &&
    + 		git config --add branch.br-$remote-octopus.merge two
    +-	done
    ++	done &&
    ++	build_script sed_script
    + '
    + 
    + # Merge logic depends on branch properties and Pull: or .fetch lines
     @@ t/t5515-fetch-merge-logic.sh: do
      	actual_r="$pfx-refs.$test"
      
      	test_expect_success "$cmd" '
     +		cp "$expect_f" expect_f &&
    -+		convert_expected expect_f &&
    ++		convert_expected expect_f sed_script &&
     +		cp "$expect_r" expect_r &&
    -+		convert_expected expect_r &&
    ++		convert_expected expect_r sed_script &&
      		{
      			echo "# $cmd"
      			set x $cmd; shift
16:  fdd54d76d0 = 16:  9c3de0ede2 t5318: update for SHA-256
17:  9b18e4b0e1 <  -:  ---------- t5616: use correct filter syntax
18:  8e6a811438 = 17:  13fd8132f5 t5607: make hash size independent
19:  275228768f <  -:  ---------- t5703: make test work with SHA-256
20:  cdc73103ef ! 18:  4a872b0096 t5703: switch tests to use test_oid
    @@ Metadata
     Author: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## Commit message ##
    -    t5703: switch tests to use test_oid
    +    t5703: make test work with SHA-256
     
    -    To make this test work correctly with SHA-256, switch the hard-coded
    -    invalid object IDs to use test_oid.
    +    This test used an object ID which was 40 hex characters in length,
    +    causing the test not only not to pass, but to hang, when run with
    +    SHA-256 as the hash.  Change this value to a fixed dummy object ID using
    +    test_oid_init and test_oid.
    +
    +    Furthermore, ensure we extract an object ID of the appropriate length
    +    using cut with fields instead of a fixed length.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## t/t5703-upload-pack-ref-in-want.sh ##
    +@@ t/t5703-upload-pack-ref-in-want.sh: get_actual_commits () {
    + 		}' <out | test-tool pkt-line unpack-sideband >o.pack &&
    + 	git index-pack o.pack &&
    + 	git verify-pack -v o.idx >objs &&
    +-	grep commit objs | cut -c-40 | sort >actual_commits
    ++	grep commit objs | cut -d" " -f1 | sort >actual_commits
    + }
    + 
    + check_output () {
     @@ t/t5703-upload-pack-ref-in-want.sh: check_output () {
      #             \ | /
      #               a
21:  d338d24661 = 19:  bd6905fe17 t6000: abstract away SHA-1-specific constants
22:  65bae45a5f = 20:  4131bdbeec t6006: make hash size independent
23:  a25605c259 = 21:  1f3c3bccf0 t6024: update for SHA-256
