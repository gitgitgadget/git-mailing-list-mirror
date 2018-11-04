Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02E4F1F453
	for <e@80x24.org>; Sun,  4 Nov 2018 23:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbeKEJBv (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 04:01:51 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53204 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729402AbeKEJBv (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Nov 2018 04:01:51 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7F0ED6077B;
        Sun,  4 Nov 2018 23:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1541375104;
        bh=ZYJuNvu4M4fTE/4WwXksI2aMBbpdjoSgsNwZVKveebE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=O63wly1JcLENlYOos6xAZYA1yPy3aTpWHuYzPHKFJ3ayx207XHs1rFma3fsRSU6tr
         4dHxagm9arDWgsg1edc5RfDMYrbIQB+x0bNr9+tVAW4KLYmv1nbfTyxNxEKCLou9Bm
         sEJABnP1MyFDnpMOpc5aWQq8b1k5MJbu9HjYo6tZbsbp8bUHI2IcFsQRhbIjziUbzC
         OLnfD9nCP8xyOA9xNi+/B5N7zgbeq67/6Xd43SaLmDPaGTnGMbmiCjP5VInitqk3s8
         iNxZBQqOdPJMLWAkK+gW/uzN1w9DtIw9zbCqIOEI3U3eBHZ5gm9uLRCJdjB+nw9O+3
         981+cTt3K+sH8PYWWb2s8lEmMlOJTxLWPND7Po3mYxqVSWld6MWXuFVFx1YURuhWI0
         TgO41M9ilqruQAkxEby+wj7GkGgrvOE6VgAqcSYBxK0xtFQU8xW0Rez8wv6zVNERA1
         FRW8b/NZvZULVcJmvrS5Fw1HchTd4FSVBI42qCJmOdH7H98MJiQ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 00/12] Base SHA-256 implementation
Date:   Sun,  4 Nov 2018 23:44:46 +0000
Message-Id: <20181104234458.139223-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0
In-Reply-To: <20181025024005.154208-1-sandals@crustytoothpaste.net>
References: <20181025024005.154208-1-sandals@crustytoothpaste.net>
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

Changes from v4:
* Downcase hex constants for consistency.
* Remove needless parentheses in return statement.
* Remove braces for single statement loops.
* Switch to +=.
* Add references to rationale for SHA-256.
* Remove inclusion of "git-compat-util.h" in header.

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
 sha256/block/sha256.h                 |  26 ++++
 sha256/gcrypt.h                       |  30 ++++
 t/helper/test-hash-speed.c            |  61 ++++++++
 t/helper/{test-sha1.c => test-hash.c} |  19 +--
 t/helper/test-sha1.c                  |  52 +------
 t/helper/test-sha256.c                |   7 +
 t/helper/test-tool.c                  |   2 +
 t/helper/test-tool.h                  |   4 +
 t/t0015-hash.sh                       |  54 +++++++
 16 files changed, 596 insertions(+), 104 deletions(-)
 create mode 100644 sha256/block/sha256.c
 create mode 100644 sha256/block/sha256.h
 create mode 100644 sha256/gcrypt.h
 create mode 100644 t/helper/test-hash-speed.c
 copy t/helper/{test-sha1.c => test-hash.c} (65%)
 create mode 100644 t/helper/test-sha256.c
 create mode 100755 t/t0015-hash.sh

Range-diff against v4:
 1:  a004a4c982 <  -:  ---------- :hash-impl
 2:  cf9f7f5620 =  1:  cf9f7f5620 sha1-file: rename algorithm to "sha1"
 3:  0144deaebe =  2:  0144deaebe sha1-file: provide functions to look up hash algorithms
 4:  b74858fb03 =  3:  b74858fb03 hex: introduce functions to print arbitrary hashes
 5:  e9703017a4 =  4:  e9703017a4 cache: make hashcmp and hasheq work with larger hashes
 6:  ab85a834fd =  5:  ab85a834fd t: add basic tests for our SHA-1 implementation
 7:  962f6d8903 =  6:  962f6d8903 t: make the sha1 test-tool helper generic
 8:  53addf4d58 =  7:  53addf4d58 sha1-file: add a constant for hash block size
 9:  9ace10faa2 =  8:  9ace10faa2 t/helper: add a test helper to compute hash speed
10:  9adc56d01e =  9:  9adc56d01e commit-graph: convert to using the_hash_algo
11:  f48cb1ad27 ! 10:  90544c504c Add a base implementation of SHA-256 support
    @@ -4,7 +4,9 @@
     
         SHA-1 is weak and we need to transition to a new hash function.  For
         some time, we have referred to this new function as NewHash.  Recently,
    -    we decided to pick SHA-256 as NewHash.
    +    we decided to pick SHA-256 as NewHash.  The reasons behind the choice of
    +    SHA-256 are outlined in the thread starting at [1] and in the commit
    +    history for the hash function transition document.
     
         Add a basic implementation of SHA-256 based off libtomcrypt, which is in
         the public domain.  Optimize it and restructure it to meet our coding
    @@ -20,6 +22,8 @@
         SHA-256 in Git.  Additional patches are needed to prepare the code to
         handle a larger hash algorithm and further test fixes are needed.
     
    +    [1] https://public-inbox.org/git/20180609224913.GC38834@genre.crustytoothpaste.net/
    +
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      diff --git a/Makefile b/Makefile
    @@ -216,14 +220,14 @@
     +{
     +	ctx->offset = 0;
     +	ctx->size = 0;
    -+	ctx->state[0] = 0x6A09E667UL;
    -+	ctx->state[1] = 0xBB67AE85UL;
    -+	ctx->state[2] = 0x3C6EF372UL;
    -+	ctx->state[3] = 0xA54FF53AUL;
    -+	ctx->state[4] = 0x510E527FUL;
    -+	ctx->state[5] = 0x9B05688CUL;
    -+	ctx->state[6] = 0x1F83D9ABUL;
    -+	ctx->state[7] = 0x5BE0CD19UL;
    ++	ctx->state[0] = 0x6a09e667ul;
    ++	ctx->state[1] = 0xbb67ae85ul;
    ++	ctx->state[2] = 0x3c6ef372ul;
    ++	ctx->state[3] = 0xa54ff53aul;
    ++	ctx->state[4] = 0x510e527ful;
    ++	ctx->state[5] = 0x9b05688cul;
    ++	ctx->state[6] = 0x1f83d9abul;
    ++	ctx->state[7] = 0x5be0cd19ul;
     +}
     +
     +static inline uint32_t ror(uint32_t x, unsigned n)
    @@ -233,12 +237,12 @@
     +
     +static inline uint32_t ch(uint32_t x, uint32_t y, uint32_t z)
     +{
    -+	return (z ^ (x & (y ^ z)));
    ++	return z ^ (x & (y ^ z));
     +}
     +
     +static inline uint32_t maj(uint32_t x, uint32_t y, uint32_t z)
     +{
    -+	return (((x | y) & z) | (x & y));
    ++	return ((x | y) & z) | (x & y);
     +}
     +
     +static inline uint32_t sigma0(uint32_t x)
    @@ -268,19 +272,16 @@
     +	int i;
     +
     +	/* copy state into S */
    -+	for (i = 0; i < 8; i++) {
    ++	for (i = 0; i < 8; i++)
     +		S[i] = ctx->state[i];
    -+	}
     +
     +	/* copy the state into 512-bits into W[0..15] */
    -+	for (i = 0; i < 16; i++, buf += sizeof(uint32_t)) {
    ++	for (i = 0; i < 16; i++, buf += sizeof(uint32_t))
     +		W[i] = get_be32(buf);
    -+	}
     +
     +	/* fill W[16..63] */
    -+	for (i = 16; i < 64; i++) {
    ++	for (i = 16; i < 64; i++)
     +		W[i] = gamma1(W[i - 2]) + W[i - 7] + gamma0(W[i - 15]) + W[i - 16];
    -+	}
     +
     +#define RND(a,b,c,d,e,f,g,h,i,ki)                    \
     +	t0 = h + sigma1(e) + ch(e, f, g) + ki + W[i];   \
    @@ -353,10 +354,8 @@
     +	RND(S[2],S[3],S[4],S[5],S[6],S[7],S[0],S[1],62,0xbef9a3f7);
     +	RND(S[1],S[2],S[3],S[4],S[5],S[6],S[7],S[0],63,0xc67178f2);
     +
    -+
    -+	for (i = 0; i < 8; i++) {
    -+		ctx->state[i] = ctx->state[i] + S[i];
    -+	}
    ++	for (i = 0; i < 8; i++)
    ++		ctx->state[i] += S[i];
     +}
     +
     +void blk_SHA256_Update(blk_SHA256_CTX *ctx, const void *data, size_t len)
12:  fe8f2ba01c = 11:  467c86e878 sha256: add an SHA-256 implementation using libgcrypt
13:  38142d8fc6 = 12:  73e4bc17d0 hash: add an SHA-256 implementation using OpenSSL
