Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28ACE1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 04:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbeKNOLe (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 09:11:34 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54388 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726517AbeKNOLd (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Nov 2018 09:11:33 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B0C256045B;
        Wed, 14 Nov 2018 04:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1542168605;
        bh=3N7t8v49lScQIw1MoztNb/XV9YmGgStHdgnGcXsCrOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=cFdLX2XqAIIBcRhRk2ZgnHt+4FyYvXvoiatCuT08AhaRQ0bKDjwvuPTTPKJlnohV0
         0aCrNmBJxdOFd3etBpV1xmDdQqaMCoz/f1mUPloKA/I9l5TzyTdSsIeFPVbeoGXhCg
         WuEgocS1ZcZ9WrkpKoUmwFuZCTjtnsxxOKMly3Grba3olIH4FHMMnVzSwZrXDBxceQ
         9rgo+TSStoL4lON+5nKPFVDoF1kpy1XU2yiKjMrRj0TPe7x7e/UOkuu4RVwKWe7dC/
         wz5Rqwt1QarDty7qot9d4s1+I/L4LI8Y0HwK0apStDogrPOtpO/C3KboyXjQ/x/UiE
         sMlS1EDEpKiPPN8MOaZ1nRls1Ut14fyoLHKLlEF1YhgsNj72lt5GBaSgla2lB9RBeW
         R9RV9JL/9n7uo2FIbl9hCnO+P5Z/I44FlrdBWFkacSL97dWpChQjwmq1PqDanBXN6W
         8uWrjEBH/3mFCDQ9GXLUjUOrLd241VQQ2Ru/oMfYIuzcKnkEdf9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 00/12] Base SHA-256 implementation
Date:   Wed, 14 Nov 2018 04:09:26 +0000
Message-Id: <20181114040938.517289-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245
In-Reply-To: <20181104234458.139223-1-sandals@crustytoothpaste.net>
References: <20181104234458.139223-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series provides a functional SHA-256 implementation and wires it
up, along with some housekeeping patches to make it suitable for
testing.

Changes from v5:
* Remove inclusion of "git-compat-util.h" in header.
* Remove "inline" from definition of hash_to_hex_algop_r.
* Switch perl invocations in t0015 to use -e instead of -E.
* Switch perl invocations in t0015 to use autoflush and postfix for.

Changes from v4:
* Downcase hex constants for consistency.
* Remove needless parentheses in return statement.
* Remove braces for single statement loops.
* Switch to +=.
* Add references to rationale for SHA-256.

Changes from v3:
* Switch to using inline functions instead of macros in many cases.
* Undefine remaining macros at the top.

Changes from v2:
* Improve commit messages to include timing and performance information.
* Improve commit messages to be less ambiguous and more friendly to a
  wider variety of English speakers.
* Prefer functions taking struct git_hash_algo in hex.c.
* Port pieces of the block-sha1 implementation over to the block-sha256
  implementation for better compatibility.
* Drop patch 13 in favor of further discussion about the best way
  forward for versioning commit graph.
* Rename the test so as to have a different number from other tests.
* Rebase on master.

Changes from v1:
* Add a hash_to_hex function mirroring sha1_to_hex, but for
  the_hash_algo.
* Strip commit message explanation about why we chose SHA-256.
* Rebase on master
* Strip leading whitespace from commit message.
* Improve commit-graph patch to cover new code added since v1.
* Be more honest about the scope of work involved in porting the SHA-256
  implementation out of libtomcrypt.
* Revert change to limit hashcmp to 20 bytes.

brian m. carlson (12):
  sha1-file: rename algorithm to "sha1"
  sha1-file: provide functions to look up hash algorithms
  hex: introduce functions to print arbitrary hashes
  cache: make hashcmp and hasheq work with larger hashes
  t: add basic tests for our SHA-1 implementation
  t: make the sha1 test-tool helper generic
  sha1-file: add a constant for hash block size
  t/helper: add a test helper to compute hash speed
  commit-graph: convert to using the_hash_algo
  Add a base implementation of SHA-256 support
  sha256: add an SHA-256 implementation using libgcrypt
  hash: add an SHA-256 implementation using OpenSSL

 Makefile                              |  22 +++
 cache.h                               |  51 ++++---
 commit-graph.c                        |  33 ++---
 hash.h                                |  41 +++++-
 hex.c                                 |  32 +++--
 sha1-file.c                           |  70 ++++++++-
 sha256/block/sha256.c                 | 196 ++++++++++++++++++++++++++
 sha256/block/sha256.h                 |  24 ++++
 sha256/gcrypt.h                       |  30 ++++
 t/helper/test-hash-speed.c            |  61 ++++++++
 t/helper/{test-sha1.c => test-hash.c} |  19 +--
 t/helper/test-sha1.c                  |  52 +------
 t/helper/test-sha256.c                |   7 +
 t/helper/test-tool.c                  |   2 +
 t/helper/test-tool.h                  |   4 +
 t/t0015-hash.sh                       |  55 ++++++++
 16 files changed, 595 insertions(+), 104 deletions(-)
 create mode 100644 sha256/block/sha256.c
 create mode 100644 sha256/block/sha256.h
 create mode 100644 sha256/gcrypt.h
 create mode 100644 t/helper/test-hash-speed.c
 copy t/helper/{test-sha1.c => test-hash.c} (65%)
 create mode 100644 t/helper/test-sha256.c
 create mode 100755 t/t0015-hash.sh

Range-diff against v5:
 1:  a004a4c982 <  -:  ---------- :hash-impl
 2:  cf9f7f5620 =  1:  fa21b5948c sha1-file: rename algorithm to "sha1"
 3:  0144deaebe =  2:  4e146c92af sha1-file: provide functions to look up hash algorithms
 4:  b74858fb03 !  3:  10e7893242 hex: introduce functions to print arbitrary hashes
    @@ -64,8 +64,8 @@
      }
      
     -char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
    -+inline char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash,
    -+					const struct git_hash_algo *algop)
    ++char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash,
    ++			  const struct git_hash_algo *algop)
      {
      	static const char hex[] = "0123456789abcdef";
      	char *buf = buffer;
 5:  e9703017a4 =  4:  6396a0ff57 cache: make hashcmp and hasheq work with larger hashes
 6:  ab85a834fd !  5:  a51a8b5638 t: add basic tests for our SHA-1 implementation
    @@ -33,7 +33,7 @@
     +	grep c12252ceda8be8994d5fa0290a47231c1d16aae3 actual &&
     +	printf "abcdefghijklmnopqrstuvwxyz" | test-tool sha1 >actual &&
     +	grep 32d10c7b8cf96570ca04ce37f2a19d84240d3a89 actual &&
    -+	perl -E "for (1..100000) { print q{aaaaaaaaaa}; }" | \
    ++	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" | \
     +		test-tool sha1 >actual &&
     +	grep 34aa973cd4c4daa4f61eeb2bdbad27316534016f actual &&
     +	printf "blob 0\0" | test-tool sha1 >actual &&
 7:  962f6d8903 =  6:  d50b040b33 t: make the sha1 test-tool helper generic
 8:  53addf4d58 =  7:  cbe15d32ed sha1-file: add a constant for hash block size
 9:  9ace10faa2 =  8:  dbb916ff26 t/helper: add a test helper to compute hash speed
10:  9adc56d01e =  9:  77a741aa3f commit-graph: convert to using the_hash_algo
11:  90544c504c ! 10:  ff7ec3b1ef Add a base implementation of SHA-256 support
    @@ -413,8 +413,6 @@
     +#ifndef SHA256_BLOCK_SHA256_H
     +#define SHA256_BLOCK_SHA256_H
     +
    -+#include "git-compat-util.h"
    -+
     +#define blk_SHA256_BLKSIZE 64
     +
     +struct blk_SHA256_CTX {
    @@ -492,10 +490,11 @@
     +	grep f7846f55cf23e14eebeab5b4e1550cad5b509e3348fbc4efa3a1413d393cb650 actual &&
     +	printf "abcdefghijklmnopqrstuvwxyz" | test-tool sha256 >actual &&
     +	grep 71c480df93d6ae2f1efad1447c66c9525e316218cf51fc8d9ed832f2daf18b73 actual &&
    -+	perl -E "for (1..100000) { print q{aaaaaaaaaa}; }" | \
    ++	# Try to exercise the chunking code by turning autoflush on.
    ++	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" | \
     +		test-tool sha256 >actual &&
     +	grep cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0 actual &&
    -+	perl -E "for (1..100000) { print q{abcdefghijklmnopqrstuvwxyz}; }" | \
    ++	perl -e "$| = 1; print q{abcdefghijklmnopqrstuvwxyz} for 1..100000;" | \
     +		test-tool sha256 >actual &&
     +	grep e406ba321ca712ad35a698bf0af8d61fc4dc40eca6bdcea4697962724ccbde35 actual &&
     +	printf "blob 0\0" | test-tool sha256 >actual &&
12:  467c86e878 = 11:  46f443809b sha256: add an SHA-256 implementation using libgcrypt
13:  73e4bc17d0 = 12:  6d358417d9 hash: add an SHA-256 implementation using OpenSSL
