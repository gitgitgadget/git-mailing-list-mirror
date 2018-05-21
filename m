Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0F271F51C
	for <e@80x24.org>; Mon, 21 May 2018 02:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeEUCCI (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 22:02:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50768 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751030AbeEUCCG (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 May 2018 22:02:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:fc4d:8d90:22bd:91d8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 85A8B6047A;
        Mon, 21 May 2018 02:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526868116;
        bh=9KflsPj9y7xdCSrnRVegBiXhMMuhYTQ4jxBDi0beG94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=p7/rrFARWn/OtPtq6GrwollbbV1/em9Dq7uVTpX5dxlICu9gBR2HagZ68MuArrFPj
         1OAf/kOXq1tmq9B75AehHwjaKoh+RqT0hpxe8YhodxpHkpuU90Ez7hR+7/Ym3F74k8
         V7znHM1lNwFYdzZ7F4wOxwbMTUZ6KQ0ebNWfK6iYeJ5t3Cfk2UFbVoLprpYL+ViZIK
         P93m44QtVLxEOIpHLNFJgq+04KvMb+heMeAjvHCXNwKB6qV/qmLZU+1JJwyLYPpavk
         14l9nA4aXj+SM4xOvU6fBAvNOOgu0jmpMWYyjQ9/gky6766ktA7jhF6TVjMNYMyjmL
         CHujVch1kBoS2Ud6q1gS9n/JzBNFbtwllYeOi/gJwbHUxCBcpC3lfOryS6v/q4dI/b
         lGMGM5tQh1cm3T63EJ4283toSM8qu7lx7t625zHl+i1H7pqUlq/UtuMBZ+PgYhdPer
         jRYpv3S4nCssNSvknfrduwoQKLnkF0gOP6LWUYM7EKacpNV4aG4
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 00/28] Hash-independent tests
Date:   Mon, 21 May 2018 02:01:19 +0000
Message-Id: <20180521020147.648496-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180516015630.661349-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
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

This version addresses the concerns raised about robustness in case git
hash-object fails in an unexpected way.  We now have better error
handling for that case by performing git rev-parse and git hash-object
in separate steps.

Changes from v3:
* Switch a use of egrep to grep.

Changes from v2:
* Split out git rev-parse --short and git hash-object into separate
  stages for better error handling.

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
 t/t4014-format-patch.sh             | 13 ++++---
 t/t4020-diff-external.sh            | 20 ++++++----
 t/t4022-diff-rewrite.sh             |  6 ++-
 t/t4027-diff-submodule.sh           |  6 +--
 t/t4029-diff-trailing-space.sh      | 40 ++++++++++---------
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
 71 files changed, 338 insertions(+), 267 deletions(-)

tbdiff output:

 1: 1a2e23b4f8 =  1: 1a2e23b4f8 t/test-lib: add an SHA1 prerequisite
 2: 809ac7d7c3 =  2: 809ac7d7c3 t/test-lib: introduce ZERO_OID
 3: 1394616579 =  3: 1394616579 t: switch $_z40 to $ZERO_OID
 4: adbbf8af80 =  4: adbbf8af80 t/test-lib: introduce OID_REGEX
 5: 77877cd04e =  5: 77877cd04e t: switch $_x40 to $OID_REGEX
 6: 41c01b5fcf =  6: 41c01b5fcf t0000: annotate with SHA1 prerequisite
 7: c175f5d565 =  7: c175f5d565 t1007: annotate with SHA1 prerequisite
 8: 936a8d90fd =  8: 936a8d90fd t1512: skip test if not using SHA-1
 9: 18a2c50777 =  9: 18a2c50777 t4044: skip test if not using SHA-1
10: bdb27df589 = 10: bdb27df589 t: skip pack tests if not using SHA-1
11: d09b454988 = 11: d09b454988 t2203: abstract away SHA-1-specific constants
12: 61c93d4d8a = 12: 61c93d4d8a t3103: abstract away SHA-1-specific constants
13: 2fdf7883c2 ! 13: 6feff69ca3 t3702: abstract away SHA-1-specific constants
    @@ -42,7 +42,7 @@
      	test_cmp orig-patch expected-patch &&
     -	git diff --cached > out &&
     +	git diff --cached >actual &&
    -+	egrep -v "^index " actual >out &&
    ++	grep -v index actual >out &&
      	test_cmp out expected
      
      '
14: 9e99a40aa1 = 14: 5757803c65 t3905: abstract away SHA-1-specific constants
15: ad45ab6bed = 15: 8c15820942 t4007: abstract away SHA-1-specific constants
16: 56a69fbe23 = 16: 64379d7965 t4008: abstract away SHA-1-specific constants
17: c47c098f00 = 17: 0cff429a92 t4014: abstract away SHA-1-specific constants
18: 73a639c361 = 18: 641b02a9a8 t4020: abstract away SHA-1-specific constants
19: 4bd0bae327 = 19: 230a1bd927 t4022: abstract away SHA-1-specific constants
20: 2d7c33aff5 = 20: fab02197f7 t4029: fix test indentation
21: 009f98c0ba = 21: d0efb5f67c t4029: abstract away SHA-1-specific constants
22: 97bbd51a80 = 22: 447f45d17b t4030: abstract away SHA-1-specific constants
23: 743fc9151d = 23: 3afc4fb173 t/lib-diff-alternative: abstract away SHA-1-specific constants
24: 8fd963968b = 24: efe882137b t4205: sort log output in a hash-independent way
25: 9bf0d6ef62 = 25: cbd17e556b t4042: abstract away SHA-1-specific constants
26: 42d9cfaa1a = 26: 188b5f7c73 t4045: abstract away SHA-1-specific constants
27: e66a684559 = 27: 527f8653d7 t4208: abstract away SHA-1-specific constants
28: 1ca2b3478d = 28: fd522b90fe t5300: abstract away SHA-1-specific constants
