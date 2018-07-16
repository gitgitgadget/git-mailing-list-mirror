Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FAED1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 01:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbeGPBxP (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jul 2018 21:53:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58916 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727046AbeGPBxO (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Jul 2018 21:53:14 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:78f3:848c:e199:5398])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8453660734;
        Mon, 16 Jul 2018 01:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531704496;
        bh=GQHt9bGbmTPMX1bImn31cEsgxT3MzNS9xe14y3vZFKk=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Wr8OYf7qR5k4GdSjc5yObmRJmYrr/xxMlSwofBNpDYcV8uMSZz2FLbyPUlyp2Mc8o
         gD7Of0X61fFkpLiZpNHgUkmpf0gbzh8CRn+kHenTQJfDIuvU1HR3J747NZ0JsWZBLf
         nPqHJHZTzZ3NIjhTyCSdJRTymmaZSvDe/q4UIcbTKNmjSKDy/OjkMl5dpipcmqd32M
         oTUTtFRaKtGbyHXpzfj8ZeCMpbjlatTg36cTeNqwncpYTnWgSoPOVXw+VQVHhgzhg1
         Z19OIlv2FJgefeKMd5cA9ak99aWuuBnye4yNlMyTFgmXjnTs8lcZUSEZFFBo6V0gGp
         5Im3QlSrQ0p/hmtmlrSxypBXm+tcmBkYFZWIsLY0NgXS2OZMyZ0hL37J+1e6Yehfs3
         putaRqE3GOGnhYfPPLcGbABn7hAg/jcO6DXkIFA+AO2Vya3JzTccbn3fbuUK4fleJJ
         ExDogjEshYpVp3OG6HKiwMZlSISN1CUHzTzw/0a014/CPAJ82Wq
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 00/16] object_id part 14
Date:   Mon, 16 Jul 2018 01:27:52 +0000
Message-Id: <20180716012808.961328-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the fourteenth series of patches to switch to using struct
object_id and the_hash_algo.  This series converts several core pieces
to use struct object_id, including the oid* and hex functions.

All of these patches have been tested with both SHA-1 and a 256-bit
hash.

Most of these patches are fixes for things that will clearly cause
segfaults or other very obvious breakage on a Git with a 256-bit hash.

Changes from v1:
* Drop patch that's been replaced by one from Ben Peart.
* Update patch handling hash* and oid* functions.

tbdiff output below.

brian m. carlson (16):
  cache: update object ID functions for the_hash_algo
  tree-walk: replace hard-coded constants with the_hash_algo
  hex: switch to using the_hash_algo
  commit: express tree entry constants in terms of the_hash_algo
  strbuf: allocate space with GIT_MAX_HEXSZ
  sha1-name: use the_hash_algo when parsing object names
  refs/files-backend: use the_hash_algo for writing refs
  builtin/update-index: convert to using the_hash_algo
  builtin/update-index: simplify parsing of cacheinfo
  builtin/fmt-merge-msg: make hash independent
  builtin/merge: switch to use the_hash_algo
  builtin/merge-recursive: make hash independent
  diff: switch GIT_SHA1_HEXSZ to use the_hash_algo
  log-tree: switch GIT_SHA1_HEXSZ to the_hash_algo->hexsz
  sha1-file: convert constants to uses of the_hash_algo
  pretty: switch hard-coded constants to the_hash_algo

 builtin/fmt-merge-msg.c   | 19 ++++++++++---------
 builtin/merge-recursive.c |  4 ++--
 builtin/merge.c           | 11 ++++++-----
 builtin/update-index.c    | 14 ++++++++------
 cache.h                   |  6 +++---
 commit.c                  |  4 ++--
 diff.c                    |  6 +++---
 hex.c                     |  6 +++---
 log-tree.c                |  2 +-
 pretty.c                  |  4 ++--
 refs/files-backend.c      |  4 ++--
 sha1-file.c               |  8 ++++----
 sha1-name.c               | 12 +++++++-----
 strbuf.c                  |  2 +-
 tree-walk.c               |  3 ++-
 15 files changed, 56 insertions(+), 49 deletions(-)

tbdiff output:

 1: e8209cc180 !  1: cad74b3d9b cache: update object ID functions for the_hash_algo
    @@ -2,10 +2,18 @@
     
         cache: update object ID functions for the_hash_algo
         
    -    Update the hashcpy and hashclr functions to use the_hash_algo, since
    -    they are used in a variety of places to copy and manipulate buffers that
    -    need to move data into or out of struct object_id.  Update oidcmp so
    -    that it is implemented on its own and similarly uses the_hash_algo.
    +    Most of our code has been converted to use struct object_id for object
    +    IDs.  However, there are some places that still have not, and there are
    +    a variety of places that compare equivalently sized hashes that are not
    +    object IDs.  All of these hashes are artifacts of the internal hash
    +    algorithm in use, and when we switch to NewHash for object storage, all
    +    of these uses will also switch.
    +    
    +    Update the hashcpy, hashclr, and hashcmp functions to use the_hash_algo,
    +    since they are used in a variety of places to copy and manipulate
    +    buffers that need to move data into or out of struct object_id.  This
    +    has the effect of making the corresponding oid* functions use
    +    the_hash_algo as well.
         
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
    @@ -14,13 +22,13 @@
     +++ b/cache.h
     @@
      
    - static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
    + static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
      {
    --	return hashcmp(oid1->hash, oid2->hash);
    -+	return memcmp(oid1->hash, oid2->hash, the_hash_algo->rawsz);
    +-	return memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
    ++	return memcmp(sha1, sha2, the_hash_algo->rawsz);
      }
      
    - static inline int is_null_sha1(const unsigned char *sha1)
    + static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
     @@
      
      static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
 2: d0bf993bc5 =  2: 2d2229b112 tree-walk: replace hard-coded constants with the_hash_algo
 3: 718ff26cb3 =  3: e2ea848e69 hex: switch to using the_hash_algo
 4: 9c387dc7b4 =  4: a2ba0e70ac commit: express tree entry constants in terms of the_hash_algo
 5: efbae0c278 =  5: 7cd0a1600e strbuf: allocate space with GIT_MAX_HEXSZ
 6: e37fa26cf7 =  6: b89147f48b sha1-name: use the_hash_algo when parsing object names
 7: b7ef5b65fc < --:  ------- commit: increase commit message buffer size
 8: 309c452bd7 =  7: 6d2efbfdb0 refs/files-backend: use the_hash_algo for writing refs
 9: 08684a629e =  8: 745d8c1e5f builtin/update-index: convert to using the_hash_algo
10: 36c7de8d9a =  9: a9e4fe9a49 builtin/update-index: simplify parsing of cacheinfo
11: cfa93658a1 = 10: 3618c468cb builtin/fmt-merge-msg: make hash independent
12: cdc2507c68 = 11: 83c8c1881a builtin/merge: switch to use the_hash_algo
13: b728ff86d4 = 12: eac8c307e1 builtin/merge-recursive: make hash independent
14: 04e69f589b = 13: 5da6c63e78 diff: switch GIT_SHA1_HEXSZ to use the_hash_algo
15: a75208a598 = 14: c179e8c3db log-tree: switch GIT_SHA1_HEXSZ to the_hash_algo->hexsz
16: d4ebee341a = 15: d6437a47d6 sha1-file: convert constants to uses of the_hash_algo
17: 68b95089d7 = 16: 6313f07df0 pretty: switch hard-coded constants to the_hash_algo
