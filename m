Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE87B1F406
	for <e@80x24.org>; Sun, 13 May 2018 02:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeEMCZA (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:25:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45186 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751851AbeEMCY7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 May 2018 22:24:59 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A2D8B60444;
        Sun, 13 May 2018 02:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526178289;
        bh=SlSI9YYhFOn2p6OBVb7wSYffk8imm6/47bxEJdwjjAQ=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xRNdsfSrGTRvj67fNceTKewGgwvBUIsgfmoScZzUYIPOFSPAJtDGcRQm5LRX5aB+i
         j61vlpZa2DDJGDFyJTZ01gkh5Q6t1SuJS1YRuW5jyxjnmeAXflDxXB69z4i2Oxu3VD
         UQCVC+Wt1SZ/BqQPjX+uGewyTOG9i79BX2bI3ohd6neKZi9un1Yfag9UduSMtR4sEp
         kPF5HcwjhdGkdrN69/eK6T5/ViK/JLmygGkOQqIqerRtc0OAaj5dtpGGpfvVCl9YQn
         gkrNEAwZo5HJyaFY1AEO6DWcvQ9RzZKvskWT0LE8AkFyGSY8+fO2bYgKRgo26pEGu+
         ibyNfX2M1QNtMmZWJZSnzRvpZcnUjk0sfhh7gE+FRmRqZ5TfOwqZfA8zDcyddhsTl1
         tL7gcU24TJQSh9m38YU8pgVdi4qjeymhIcHXNpz+KmiY55CEqTRCgqpp+RizIMIvGC
         C6fhoQGkX0MWPW3VcNyeLIWwIZLgmqVoO+tO4pZHMqbCLobTK4V
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 00/28] Hash-independent tests (part 2)
Date:   Sun, 13 May 2018 02:24:10 +0000
Message-Id: <20180513022438.60003-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is part 2 in the series to make tests hash independent.

This series introduces an SHA1 prerequisite which checks if the hash in
use is SHA-1, and can be used to skip the test if it is not.
Additionally, because NewHash will be 256-bit, I introduced aliases for
the test constants $_x40 and $_z40 which will be less confusing when the
hash isn't 40 hex characters long.  I opted to leave the old names in
place for the moment to prevent any potential conflicts with other
series and will clean up any stragglers later.

To address any concerns that might be present, I do plan to retrofit
tests marked with the SHA1 prerequisite and ensure that they are passing
or are not applicable (e.g. for pack formats supporting only SHA-1).  I
agree with concerns that shipping a NewHash-capable Git without a
complete, functional testsuite would be a bad idea.

Changes from v1:
* Amend commit message to indicate that we *will* be updating tests
  annotated with the SHA1 prerequisite to work with NewHash.
* Rename FULL_HEX to OID_REGEX.
* Regenerate patch for OID_REGEX.
* Update variable name from "link_oid" to "slink_id" for consistency
  while still preserving alignment.
* Restore blank line between tests.

tbdiff output below.

brian m. carlson (28):
  t/test-lib: add an SHA1 prerequisite
  t/test-lib: introduce ZERO_OID
  t: switch $_z40 to $ZERO_OID
  t/test-lib: introduce OID_REGEX
  t: switch $_x40 to $OID_REGEX
  t0000: annotate with SHA1 prerequisite
  t1007: annotate with SHA1 prerequisite
  t1512: skip test if not using SHA-1
  t4044: skip test if not using SHA-1
  t: skip pack tests if not using SHA-1
  t2203: abstract away SHA-1-specific constants
  t3103: abstract away SHA-1-specific constants
  t3702: abstract away SHA-1-specific constants
  t3905: abstract away SHA-1-specific constants
  t4007: abstract away SHA-1-specific constants
  t4008: abstract away SHA-1-specific constants
  t4014: abstract away SHA-1-specific constants
  t4020: abstract away SHA-1-specific constants
  t4022: abstract away SHA-1-specific constants
  t4029: fix test indentation
  t4029: abstract away SHA-1-specific constants
  t4030: abstract away SHA-1-specific constants
  t/lib-diff-alternative: abstract away SHA-1-specific constants
  t4205: sort log output in a hash-independent way
  t4042: abstract away SHA-1-specific constants
  t4045: abstract away SHA-1-specific constants
  t4208: abstract away SHA-1-specific constants
  t5300: abstract away SHA-1-specific constants

 t/diff-lib.sh                       |  4 +-
 t/lib-diff-alternative.sh           | 12 ++++--
 t/t0000-basic.sh                    | 24 ++++++------
 t/t0090-cache-tree.sh               |  2 +-
 t/t1000-read-tree-m-3way.sh         |  2 +-
 t/t1001-read-tree-m-2way.sh         |  2 +-
 t/t1002-read-tree-m-u-2way.sh       |  2 +-
 t/t1006-cat-file.sh                 |  8 ++--
 t/t1007-hash-object.sh              | 16 ++++----
 t/t1012-read-tree-df.sh             |  2 +-
 t/t1400-update-ref.sh               |  2 +-
 t/t1407-worktree-ref-store.sh       |  8 ++--
 t/t1450-fsck.sh                     |  4 +-
 t/t1501-work-tree.sh                |  6 +--
 t/t1512-rev-parse-disambiguation.sh |  6 +++
 t/t1601-index-bogus.sh              |  2 +-
 t/t1700-split-index.sh              |  2 +-
 t/t2011-checkout-invalid-head.sh    |  2 +-
 t/t2025-worktree-add.sh             |  8 ++--
 t/t2027-worktree-list.sh            |  2 +-
 t/t2107-update-index-basic.sh       |  4 +-
 t/t2201-add-update-typechange.sh    | 16 ++++----
 t/t2203-add-intent.sh               | 14 +++----
 t/t3100-ls-tree-restrict.sh         |  2 +-
 t/t3101-ls-tree-dirname.sh          |  2 +-
 t/t3103-ls-tree-misc.sh             |  3 +-
 t/t3200-branch.sh                   |  4 +-
 t/t3510-cherry-pick-sequence.sh     |  8 ++--
 t/t3702-add-edit.sh                 |  7 ++--
 t/t3905-stash-include-untracked.sh  | 11 ++++--
 t/t4002-diff-basic.sh               |  2 +-
 t/t4006-diff-mode.sh                |  2 +-
 t/t4007-rename-3.sh                 | 17 +++++----
 t/t4008-diff-break-rewrite.sh       | 59 ++++++++++++++++-------------
 t/t4014-format-patch.sh             | 11 +++---
 t/t4020-diff-external.sh            | 18 +++++----
 t/t4022-diff-rewrite.sh             |  5 ++-
 t/t4027-diff-submodule.sh           |  6 +--
 t/t4029-diff-trailing-space.sh      | 38 ++++++++++---------
 t/t4030-diff-textconv.sh            |  5 ++-
 t/t4042-diff-textconv-caching.sh    | 16 +++++---
 t/t4044-diff-index-unique-abbrev.sh |  6 +++
 t/t4045-diff-relative.sh            |  6 ++-
 t/t4046-diff-unmerged.sh            | 14 +++----
 t/t4054-diff-bogus-tree.sh          | 12 +++---
 t/t4058-diff-duplicates.sh          | 12 +++---
 t/t4150-am.sh                       |  4 +-
 t/t4200-rerere.sh                   |  2 +-
 t/t4201-shortlog.sh                 |  2 +-
 t/t4205-log-pretty-formats.sh       |  8 ++--
 t/t4208-log-magic-pathspec.sh       |  3 +-
 t/t5150-request-pull.sh             |  2 +-
 t/t5300-pack-object.sh              |  8 ++--
 t/t5308-pack-detect-duplicates.sh   |  6 +++
 t/t5309-pack-delta-cycles.sh        |  6 +++
 t/t5516-fetch-push.sh               | 22 +++++------
 t/t5527-fetch-odd-refs.sh           |  2 +-
 t/t5571-pre-push-hook.sh            |  8 ++--
 t/t6006-rev-list-format.sh          |  4 +-
 t/t6012-rev-list-simplify.sh        |  2 +-
 t/t6111-rev-list-treesame.sh        |  2 +-
 t/t6120-describe.sh                 |  2 +-
 t/t6300-for-each-ref.sh             |  2 +-
 t/t6301-for-each-ref-errors.sh      |  2 +-
 t/t7009-filter-branch-null-sha1.sh  |  2 +-
 t/t7011-skip-worktree-reading.sh    |  2 +-
 t/t7064-wtstatus-pv2.sh             | 58 ++++++++++++++--------------
 t/t7506-status-submodule.sh         |  2 +-
 t/t9010-svn-fe.sh                   | 14 +++----
 t/t9300-fast-import.sh              |  6 +--
 t/test-lib.sh                       | 11 +++++-
 71 files changed, 331 insertions(+), 267 deletions(-)

tbdiff output:

 1: 03ad090b53 !  1: 1a2e23b4f8 t/test-lib: add an SHA1 prerequisite
    @@ -12,7 +12,7 @@
         these cases.  These tests, too, will fail with a different hash.
         
         Add an SHA1 prerequisite to annotate both of these types of tests and
    -    disable them when we're using a different hash.  In the future, we can
    +    disable them when we're using a different hash.  In the future, we will
         create versions of these tests which handle both SHA-1 and NewHash.
         
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
 2: 6b39476f58 =  2: 809ac7d7c3 t/test-lib: introduce ZERO_OID
 3: 45ac938b66 =  3: 1394616579 t: switch $_z40 to $ZERO_OID
 4: a8677dbf35 !  4: adbbf8af80 t/test-lib: introduce OID_REGEX
    @@ -1,13 +1,13 @@
     Author: brian m. carlson <sandals@crustytoothpaste.net>
     
    -    t/test-lib: introduce FULL_HEX
    +    t/test-lib: introduce OID_REGEX
         
         Currently we have a variable, $_x40, which contains a regex that matches
         a full 40-character hex constant.  However, with NewHash, we'll have
         object IDs that are longer than 40 characters.  In such a case, $_x40
    -    will be a confusing name.  Create a $FULL_HEX variable which will always
    -    reflect a regex matching the appropriate object ID, regardless of the
    -    length of the current hash.
    +    will be a confusing name.  Create a $OID_REGEX variable which will
    +    always reflect a regex matching the appropriate object ID, regardless of
    +    the length of the current hash.
         
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
    @@ -18,7 +18,7 @@
      # Zero SHA-1
      _z40=0000000000000000000000000000000000000000
      
    -+FULL_HEX="$_x40"
    ++OID_REGEX="$_x40"
      ZERO_OID=$_z40
      EMPTY_TREE=4b825dc642cb6eb9a060e54bf8d69288fbee4904
      EMPTY_BLOB=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
    @@ -27,7 +27,7 @@
      u200c=$(printf '\342\200\214')
      
     -export _x05 _x35 _x40 _z40 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID
    -+export _x05 _x35 _x40 _z40 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID FULL_HEX
    ++export _x05 _x35 _x40 _z40 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID_REGEX
      
      # Each test should start with something like this, after copyright notices:
      #
 5: e9e9c1fa49 !  5: 77877cd04e t: switch $_x40 to $OID_REGEX
    @@ -1,12 +1,12 @@
     Author: brian m. carlson <sandals@crustytoothpaste.net>
     
    -    t: switch $_x40 to $FULL_HEX
    +    t: switch $_x40 to $OID_REGEX
         
    -    Switch all uses of $_x40 to $FULL_HEX so that they work correctly with
    +    Switch all uses of $_x40 to $OID_REGEX so that they work correctly with
         larger hashes.  This commit was created by using the following sed
         command to modify all files in the t directory except t/test-lib.sh:
         
    -      sed -i 's/\$_x40/$FULL_HEX/g'
    +      sed -i 's/\$_x40/$OID_REGEX/g'
         
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
    @@ -17,7 +17,7 @@
      :
      
     -sanitize_diff_raw='/^:/s/ '"\($_x40\)"' '"\($_x40\)"' \([A-Z]\)[0-9]*	/ \1 \2 \3#	/'
    -+sanitize_diff_raw='/^:/s/ '"\($FULL_HEX\)"' '"\($FULL_HEX\)"' \([A-Z]\)[0-9]*	/ \1 \2 \3#	/'
    ++sanitize_diff_raw='/^:/s/ '"\($OID_REGEX\)"' '"\($OID_REGEX\)"' \([A-Z]\)[0-9]*	/ \1 \2 \3#	/'
      compare_diff_raw () {
          # When heuristics are improved, the score numbers would change.
          # Ignore them while comparing.
    @@ -26,7 +26,7 @@
      }
      
     -sanitize_diff_raw_z='/^:/s/ '"$_x40"' '"$_x40"' \([A-Z]\)[0-9]*$/ X X \1#/'
    -+sanitize_diff_raw_z='/^:/s/ '"$FULL_HEX"' '"$FULL_HEX"' \([A-Z]\)[0-9]*$/ X X \1#/'
    ++sanitize_diff_raw_z='/^:/s/ '"$OID_REGEX"' '"$OID_REGEX"' \([A-Z]\)[0-9]*$/ X X \1#/'
      compare_diff_raw_z () {
          # When heuristics are improved, the score numbers would change.
          # Ignore them while comparing.
    @@ -39,7 +39,7 @@
      cmp_cache_tree () {
      	test-tool dump-cache-tree | sed -e '/#(ref)/d' >actual &&
     -	sed "s/$_x40/SHA/" <actual >filtered &&
    -+	sed "s/$FULL_HEX/SHA/" <actual >filtered &&
    ++	sed "s/$OID_REGEX/SHA/" <actual >filtered &&
      	test_cmp "$1" filtered
      }
      
    @@ -52,7 +52,7 @@
      
      check_result () {
     -	git ls-files --stage | sed -e 's/ '"$_x40"' / X /' >current &&
    -+	git ls-files --stage | sed -e 's/ '"$FULL_HEX"' / X /' >current &&
    ++	git ls-files --stage | sed -e 's/ '"$OID_REGEX"' / X /' >current &&
      	test_cmp expected current
      }
      
    @@ -65,7 +65,7 @@
      	sed -n >current \
      	    -e '/^--- /d; /^+++ /d; /^@@ /d;' \
     -	    -e 's/^\([-+][0-7][0-7][0-7][0-7][0-7][0-7]\) '"$_x40"' /\1 X /p' \
    -+	    -e 's/^\([-+][0-7][0-7][0-7][0-7][0-7][0-7]\) '"$FULL_HEX"' /\1 X /p' \
    ++	    -e 's/^\([-+][0-7][0-7][0-7][0-7][0-7][0-7]\) '"$OID_REGEX"' /\1 X /p' \
      	    "$1"
      	test_cmp expected current
      }
    @@ -78,7 +78,7 @@
      	    -e '2{/^index /d;}' \
      	    -e '/^--- /d; /^+++ /d; /^@@ /d;' \
     -	    -e 's/^\(.[0-7][0-7][0-7][0-7][0-7][0-7]\) '"$_x40"' /\1 X /' "$1"
    -+	    -e 's/^\(.[0-7][0-7][0-7][0-7][0-7][0-7]\) '"$FULL_HEX"' /\1 X /' "$1"
    ++	    -e 's/^\(.[0-7][0-7][0-7][0-7][0-7][0-7]\) '"$OID_REGEX"' /\1 X /' "$1"
      	test_cmp expected current
      }
      
    @@ -91,7 +91,7 @@
      checkindex () {
      	git ls-files -s |
     -	sed "s|^[0-7][0-7]* $_x40 \([0-3]\)	|\1 |" >current &&
    -+	sed "s|^[0-7][0-7]* $FULL_HEX \([0-3]\)	|\1 |" >current &&
    ++	sed "s|^[0-7][0-7]* $OID_REGEX \([0-3]\)	|\1 |" >current &&
      	cat >expect &&
      	test_cmp expect current
      }
    @@ -104,7 +104,7 @@
      
      test_output () {
     -    sed -e "s/ $_x40	/ X	/" <current >check
    -+    sed -e "s/ $FULL_HEX	/ X	/" <current >check
    ++    sed -e "s/ $OID_REGEX	/ X	/" <current >check
          test_cmp expected check
      }
      
    @@ -117,7 +117,7 @@
      
      test_output () {
     -	sed -e "s/ $_x40	/ X	/" <current >check &&
    -+	sed -e "s/ $FULL_HEX	/ X	/" <current >check &&
    ++	sed -e "s/ $OID_REGEX	/ X	/" <current >check &&
      	test_cmp expected check
      }
      
    @@ -130,16 +130,16 @@
      		git rev-list HEAD |
      		git diff-tree --root --stdin |
     -		sed "s/$_x40/OBJID/g"
    -+		sed "s/$FULL_HEX/OBJID/g"
    - 	} >actual &&
    - 	test_cmp expect actual
    - '
    -@@
    - 	{
    - 		git rev-list HEAD |
    - 		git diff-tree --root --stdin |
    --		sed "s/$_x40/OBJID/g"
    -+		sed "s/$FULL_HEX/OBJID/g"
    ++		sed "s/$OID_REGEX/OBJID/g"
    + 	} >actual &&
    + 	test_cmp expect actual
    + '
    +@@
    + 	{
    + 		git rev-list HEAD |
    + 		git diff-tree --root --stdin |
    +-		sed "s/$_x40/OBJID/g"
    ++		sed "s/$OID_REGEX/OBJID/g"
      	} >actual &&
      	cat >expect <<-\EOF &&
      	OBJID
    @@ -148,7 +148,7 @@
      		git rev-list HEAD |
      		git diff-tree --root --stdin |
     -		sed "s/$_x40/OBJID/g"
    -+		sed "s/$FULL_HEX/OBJID/g"
    ++		sed "s/$OID_REGEX/OBJID/g"
      	} >actual.log &&
      	test_cmp expect foo &&
      	test_cmp expect.log actual.log
    @@ -157,7 +157,7 @@
      		git rev-list HEAD |
      		git diff-tree --root --stdin |
     -		sed "s/$_x40/OBJID/g"
    -+		sed "s/$FULL_HEX/OBJID/g"
    ++		sed "s/$OID_REGEX/OBJID/g"
      	} >actual &&
      	cat >expect <<-\EOF &&
      	OBJID
    @@ -170,7 +170,7 @@
          # filesystem.
          sed <"$2" >.test-tmp \
     -	-e '/^:000000 /d;s/'$_x40'\( [MCRNDU][0-9]*\)	/'$ZERO_OID'\1	/' &&
    -+	-e '/^:000000 /d;s/'$FULL_HEX'\( [MCRNDU][0-9]*\)	/'$ZERO_OID'\1	/' &&
    ++	-e '/^:000000 /d;s/'$OID_REGEX'\( [MCRNDU][0-9]*\)	/'$ZERO_OID'\1	/' &&
          test_cmp "$1" .test-tmp
      }
      
    @@ -183,7 +183,7 @@
      . ./test-lib.sh
      
     -sed_script='s/\(:100644 100755\) \('"$_x40"'\) \2 /\1 X X /'
    -+sed_script='s/\(:100644 100755\) \('"$FULL_HEX"'\) \2 /\1 X X /'
    ++sed_script='s/\(:100644 100755\) \('"$OID_REGEX"'\) \2 /\1 X X /'
      
      test_expect_success 'setup' '
      	echo frotz >rezrov &&
    @@ -196,7 +196,7 @@
      	git format-patch --stdout v2..v1 >patch2 &&
      	grep "^From " patch2 >from &&
     -	grep "^From $_x40 Mon Sep 17 00:00:00 2001$" patch2 >filtered &&
    -+	grep "^From $FULL_HEX Mon Sep 17 00:00:00 2001$" patch2 >filtered &&
    ++	grep "^From $OID_REGEX Mon Sep 17 00:00:00 2001$" patch2 >filtered &&
      	test_cmp from filtered
      '
      
    @@ -209,7 +209,7 @@
      	file=$1 &&
      	sed "
     -			s/$_x40/OBJECT_NAME/g
    -+			s/$FULL_HEX/OBJECT_NAME/g
    ++			s/$OID_REGEX/OBJECT_NAME/g
      			s/$_x35/OBJID/g
      			s/^ \{6\}[CTa].*/      SUBJECT/g
      			s/^ \{8\}[^ ].*/        CONTINUATION/g
    @@ -222,7 +222,7 @@
      	#!/bin/sed -nf
      	s/$downstream_url_for_sed/URL/g
     -	s/$_x40/OBJECT_NAME/g
    -+	s/$FULL_HEX/OBJECT_NAME/g
    ++	s/$OID_REGEX/OBJECT_NAME/g
      	s/A U Thor/AUTHOR/g
      	s/[-0-9]\{10\} [:0-9]\{8\} [-+][0-9]\{4\}/DATE/g
      	s/        [^ ].*/        SUBJECT/g
    @@ -236,8 +236,8 @@
      	git log -1 --abbrev=5 --format="%H %H %H" HEAD >actual3 &&
     -	sed -e "s/$_x40/LONG/g" -e "s/$_x05/SHORT/g" <actual2 >fuzzy2 &&
     -	sed -e "s/$_x40/LONG/g" -e "s/$_x05/SHORT/g" <actual3 >fuzzy3 &&
    -+	sed -e "s/$FULL_HEX/LONG/g" -e "s/$_x05/SHORT/g" <actual2 >fuzzy2 &&
    -+	sed -e "s/$FULL_HEX/LONG/g" -e "s/$_x05/SHORT/g" <actual3 >fuzzy3 &&
    ++	sed -e "s/$OID_REGEX/LONG/g" -e "s/$_x05/SHORT/g" <actual2 >fuzzy2 &&
    ++	sed -e "s/$OID_REGEX/LONG/g" -e "s/$_x05/SHORT/g" <actual3 >fuzzy3 &&
      	test_cmp expect2 fuzzy2 &&
      	test_cmp expect3 fuzzy3 &&
      	! test_cmp actual1 actual2
    @@ -250,7 +250,7 @@
      
      unnote () {
     -	git name-rev --tags --stdin | sed -e "s|$_x40 (tags/\([^)]*\)) |\1 |g"
    -+	git name-rev --tags --stdin | sed -e "s|$FULL_HEX (tags/\([^)]*\)) |\1 |g"
    ++	git name-rev --tags --stdin | sed -e "s|$OID_REGEX (tags/\([^)]*\)) |\1 |g"
      }
      
      test_expect_success setup '
    @@ -263,7 +263,7 @@
      
      unnote () {
     -	git name-rev --tags --stdin | sed -e "s|$_x40 (tags/\([^)]*\))\([ 	]\)|\1\2|g"
    -+	git name-rev --tags --stdin | sed -e "s|$FULL_HEX (tags/\([^)]*\))\([ 	]\)|\1\2|g"
    ++	git name-rev --tags --stdin | sed -e "s|$OID_REGEX (tags/\([^)]*\))\([ 	]\)|\1\2|g"
      }
      
      test_expect_success setup '
    @@ -276,7 +276,7 @@
      
      sanitize_output () {
     -	sed -e "s/$_x40/HASH/" -e "s/$_x40/HASH/" output >output2 &&
    -+	sed -e "s/$FULL_HEX/HASH/" -e "s/$FULL_HEX/HASH/" output >output2 &&
    ++	sed -e "s/$OID_REGEX/HASH/" -e "s/$OID_REGEX/HASH/" output >output2 &&
      	mv output2 output
      }
      
    @@ -289,7 +289,7 @@
      		git rev-list HEAD |
      		git diff-tree --root --stdin |
     -		sed "s/$_x40/OBJID/g"
    -+		sed "s/$FULL_HEX/OBJID/g"
    ++		sed "s/$OID_REGEX/OBJID/g"
      	} >actual &&
      	git show HEAD:greeting >actual.blob &&
      	git show HEAD^:greeting >actual.target &&
    @@ -298,7 +298,7 @@
      		git rev-list HEAD |
      		git diff-tree --root --stdin |
     -		sed "s/$_x40/OBJID/g"
    -+		sed "s/$FULL_HEX/OBJID/g"
    ++		sed "s/$OID_REGEX/OBJID/g"
      	} >actual &&
      	{
      		git cat-file commit HEAD | nul_to_q &&
    @@ -307,7 +307,7 @@
      		git rev-list HEAD |
      		git diff-tree --root --stdin |
     -		sed "s/$_x40/OBJID/g"
    -+		sed "s/$FULL_HEX/OBJID/g"
    ++		sed "s/$OID_REGEX/OBJID/g"
      	} >actual &&
      	git show HEAD:greeting >actual.blob &&
      	git show HEAD^:greeting >actual.target &&
    @@ -316,7 +316,7 @@
      		git rev-list HEAD |
      		git diff-tree --stdin |
     -		sed "s/$_x40/OBJID/g"
    -+		sed "s/$FULL_HEX/OBJID/g"
    ++		sed "s/$OID_REGEX/OBJID/g"
      	} >actual &&
      	test_cmp expect actual
      '
    @@ -325,25 +325,25 @@
      		git rev-list HEAD |
      		git diff-tree --root --always --stdin |
     -		sed "s/$_x40/OBJID/g"
    -+		sed "s/$FULL_HEX/OBJID/g"
    - 	} >actual &&
    - 	test_cmp expect actual
    - '
    -@@
    - 	{
    - 		git rev-list HEAD |
    - 		git diff-tree --root --stdin |
    --		sed "s/$_x40/OBJID/g"
    -+		sed "s/$FULL_HEX/OBJID/g"
    - 	} >actual &&
    - 	test_cmp expect actual
    - '
    -@@
    - 	{
    - 		git rev-list HEAD |
    - 		git diff-tree --root --stdin |
    --		sed "s/$_x40/OBJID/g"
    -+		sed "s/$FULL_HEX/OBJID/g"
    ++		sed "s/$OID_REGEX/OBJID/g"
    + 	} >actual &&
    + 	test_cmp expect actual
    + '
    +@@
    + 	{
    + 		git rev-list HEAD |
    + 		git diff-tree --root --stdin |
    +-		sed "s/$_x40/OBJID/g"
    ++		sed "s/$OID_REGEX/OBJID/g"
    + 	} >actual &&
    + 	test_cmp expect actual
    + '
    +@@
    + 	{
    + 		git rev-list HEAD |
    + 		git diff-tree --root --stdin |
    +-		sed "s/$_x40/OBJID/g"
    ++		sed "s/$OID_REGEX/OBJID/g"
      	} >actual &&
      	test_cmp expect actual &&
      	git show HEAD:postimage >actual.3 &&
    @@ -356,7 +356,7 @@
      	git rev-list read-empty |
      	git diff-tree -r --root --stdin |
     -	sed "s/$_x40/OBJNAME/g" >actual &&
    -+	sed "s/$FULL_HEX/OBJNAME/g" >actual &&
    ++	sed "s/$OID_REGEX/OBJNAME/g" >actual &&
      	test_cmp expect actual
      '
      
    @@ -365,7 +365,7 @@
      	git rev-list N-delete |
      		git diff-tree -r --stdin --root --always |
     -		sed -e "s/$_x40/OBJID/g" >actual &&
    -+		sed -e "s/$FULL_HEX/OBJID/g" >actual &&
    ++		sed -e "s/$OID_REGEX/OBJID/g" >actual &&
      	test_cmp expect actual
      '
      
    @@ -374,7 +374,7 @@
      	git rev-list done-ends |
      	git diff-tree -r --stdin --root --always |
     -	sed -e "s/$_x40/OBJID/g" >actual &&
    -+	sed -e "s/$FULL_HEX/OBJID/g" >actual &&
    - 	test_cmp expect actual
    - '
    - 
    ++	sed -e "s/$OID_REGEX/OBJID/g" >actual &&
    + 	test_cmp expect actual
    + '
    + 
 6: 266d018808 =  6: 41c01b5fcf t0000: annotate with SHA1 prerequisite
 7: 6fea58fcc2 =  7: c175f5d565 t1007: annotate with SHA1 prerequisite
 8: 57722629fa =  8: 936a8d90fd t1512: skip test if not using SHA-1
 9: e17c66bbb0 =  9: 18a2c50777 t4044: skip test if not using SHA-1
10: 2d2baa9729 = 10: bdb27df589 t: skip pack tests if not using SHA-1
11: 0b50c02784 = 11: d09b454988 t2203: abstract away SHA-1-specific constants
12: 6de266bf25 = 12: 61c93d4d8a t3103: abstract away SHA-1-specific constants
13: a36512bfed = 13: 2fdf7883c2 t3702: abstract away SHA-1-specific constants
14: edc0e12cca ! 14: 9e99a40aa1 t3905: abstract away SHA-1-specific constants
    @@ -11,10 +11,9 @@
     --- a/t/t3905-stash-include-untracked.sh
     +++ b/t/t3905-stash-include-untracked.sh
     @@
    - 	git status --porcelain >actual &&
      	test_cmp expect actual
      '
    --
    + 
     +tracked=$(git rev-parse --short $(echo 1 | git hash-object --stdin))
     +untracked=$(git rev-parse --short $(echo untracked | git hash-object --stdin))
      cat > expect.diff <<EOF
15: cd84d00f27 = 15: ad45ab6bed t4007: abstract away SHA-1-specific constants
16: 5b49fc4b62 ! 16: 56a69fbe23 t4008: abstract away SHA-1-specific constants
    @@ -77,7 +77,7 @@
      test_expect_success 'make file0 into something completely different' '
      	rm -f file0 &&
      	test_ln_s_add frotz file0 &&
    -+	link_oid=$(printf frotz | git hash-object --stdin) &&
    ++	slink_id=$(printf frotz | git hash-object --stdin) &&
      	git update-index file1
      '
      
    @@ -87,7 +87,7 @@
     -	:100644 120000 548142c327a6790ff8821d67c2ee1eff7a656b52 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
     -	:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 548142c327a6790ff8821d67c2ee1eff7a656b52 M100	file1
     +	cat >expect <<-EOF &&
    -+	:100644 120000 $blob0_id $link_oid T	file0
    ++	:100644 120000 $blob0_id $slink_id T	file0
     +	:100644 100644 $blob1_id $blob0_id M100	file1
      	EOF
      	compare_diff_raw expect current
    @@ -100,7 +100,7 @@
     -	:100644 120000 548142c327a6790ff8821d67c2ee1eff7a656b52 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
     -	:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 548142c327a6790ff8821d67c2ee1eff7a656b52 C	file0	file1
     +	cat >expect <<-EOF &&
    -+	:100644 120000 $blob0_id $link_oid T	file0
    ++	:100644 120000 $blob0_id $slink_id T	file0
     +	:100644 100644 $blob0_id $blob0_id C	file0	file1
      	EOF
      	compare_diff_raw expect current
    @@ -113,7 +113,7 @@
     -	:100644 120000 548142c327a6790ff8821d67c2ee1eff7a656b52 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
     -	:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 548142c327a6790ff8821d67c2ee1eff7a656b52 M	file1
     +	cat >expect <<-EOF &&
    -+	:100644 120000 $blob0_id $link_oid T	file0
    ++	:100644 120000 $blob0_id $slink_id T	file0
     +	:100644 100644 $blob1_id $blob0_id M	file1
      	EOF
      	compare_diff_raw expect current
17: a723e189cd = 17: 11c545cd51 t4014: abstract away SHA-1-specific constants
18: 970a3016ed = 18: fcca4074e6 t4020: abstract away SHA-1-specific constants
19: 4640ef9170 = 19: ad252e46c4 t4022: abstract away SHA-1-specific constants
20: f1f66b513b = 20: 4046eecebd t4029: fix test indentation
21: 9a8a9b6762 = 21: 56896e45f0 t4029: abstract away SHA-1-specific constants
22: 6573352174 = 22: 27609ec546 t4030: abstract away SHA-1-specific constants
23: e79d9ab24e = 23: 8c782009bf t/lib-diff-alternative: abstract away SHA-1-specific constants
24: d0bab817d4 = 24: 2f0da3e1b8 t4205: sort log output in a hash-independent way
25: 3b2719de86 = 25: 3e913f2526 t4042: abstract away SHA-1-specific constants
26: f3034dd64a = 26: 2261c64650 t4045: abstract away SHA-1-specific constants
27: fbf4568271 = 27: 458006036a t4208: abstract away SHA-1-specific constants
28: a1c8324b74 = 28: 8da8c65428 t5300: abstract away SHA-1-specific constants
