Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E49C1F97E
	for <e@80x24.org>; Mon, 15 Oct 2018 00:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbeJOHoy (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 03:44:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50502 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725792AbeJOHox (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Oct 2018 03:44:53 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E3CA861B73;
        Mon, 15 Oct 2018 00:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539561727;
        bh=4YmtHt99ftGlEFDnaHZUng7ZwSGUpXBKihEazEs7nR0=;
        h=From:To:Cc:Subject:Date:Content-Type:From:Reply-To:Subject:Date:
         To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=nGNU/zzrq8min6cpWmF8PCTrmbFlVXn485BlIkuN+N4Zx1nhdY9PX6ZiiZe+wKAFL
         MO1cG//HH69rDEX+UtrO3xMUJ701UvMpG/WMmc1SQLNRDppyN16dEOm3ynaNuWKlil
         6SN4awXRwIHc+RR15yqITBgfDQWYquUoOu+tYy/yMl06oTXx3KgoETciaFfvXtG73E
         hMH8L6S2mTH8W+UfCPj2N7NBvVks0F2NelAN1KzKw4F438yxO2PLwIDEK3AhGhsRpJ
         yWXwoWkw5ClQb3Js26LSEDhbIl19ZdwDYXBkOOtUFSghmE/KU8U2cctdxyML4EEMaF
         pONOFy0nGHChJm6Aon2/tX951Xx7WZLzixiqdSFNAEePqVowF94xrbSXikuhlukSm6
         WZvlnjNHe/e928LBkShNPGNm3NUYSNx2PVhRuAjvlsPUxmrQxmn25aIfHtoJiRWXo1
         OP7MQif8gDpmhlMwS10x6IyZ84sysRGI+doLxnmKlw0Vx7e59K5
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 00/15] Hash function transition part 15
Date:   Mon, 15 Oct 2018 00:01:47 +0000
Message-Id: <20181015000202.951965-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the fifteenth series in the ongoing hash function transition.

This series includes several conversions to use the_hash_algo, combined
with some use of parse_oid_hex and GIT_MAX_RAWSZ.

Changes from v1:
* Fix several other substantially similar issues in builtin/repack.
* Fix a comment style issue.
* Improve commit message as suggested by Stefan.
* Pull in Gábor's patch and place it at the beginning of the series.

SZEDER Gábor (1):
  object_id.cocci: match only expressions of type 'struct object_id'

brian m. carlson (14):
  pack-bitmap-write: use GIT_MAX_RAWSZ for allocation
  builtin/repack: replace hard-coded constants
  builtin/mktree: remove hard-coded constant
  builtin/fetch-pack: remove constants with parse_oid_hex
  pack-revindex: express constants in terms of the_hash_algo
  packfile: express constants in terms of the_hash_algo
  refs/packed-backend: express constants using the_hash_algo
  upload-pack: express constants in terms of the_hash_algo
  transport: use parse_oid_hex instead of a constant
  tag: express constant in terms of the_hash_algo
  apply: replace hard-coded constants
  apply: rename new_sha1_prefix and old_sha1_prefix
  submodule: make zero-oid comparison hash function agnostic
  rerere: convert to use the_hash_algo

 apply.c                            |  50 ++++++------
 builtin/fetch-pack.c               |  13 ++--
 builtin/mktree.c                   |   2 +-
 builtin/repack.c                   |  13 ++--
 contrib/coccinelle/object_id.cocci | 117 ++++++++++++++++-------------
 git-submodule.sh                   |   7 +-
 pack-bitmap-write.c                |   2 +-
 pack-revindex.c                    |  10 ++-
 packfile.c                         |   5 +-
 refs/packed-backend.c              |  14 ++--
 rerere.c                           |  81 ++++++++++----------
 tag.c                              |   2 +-
 transport.c                        |   7 +-
 upload-pack.c                      |  13 ++--
 14 files changed, 181 insertions(+), 155 deletions(-)

Range-diff against v1:
 -:  ---------- >  1:  35d9cefd9a object_id.cocci: match only expressions of type 'struct object_id'
 1:  223d6f6695 !  2:  bb2a15a6e9 pack-bitmap-write: use GIT_MAX_RAWSZ for allocation
    @@ -2,6 +2,7 @@
     
         pack-bitmap-write: use GIT_MAX_RAWSZ for allocation
     
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
 2:  bbdb147d8d <  -:  ---------- builtin/repack: replace hard-coded constant
 -:  ---------- >  3:  95bdac161e builtin/repack: replace hard-coded constants
 3:  bf7b55fe4e =  4:  2a28675cfc builtin/mktree: remove hard-coded constant
 4:  155451f608 =  5:  7941bb0060 builtin/fetch-pack: remove constants with parse_oid_hex
 5:  9ec7065d62 !  6:  2ec9a22ea7 pack-revindex: express constants in terms of the_hash_algo
    @@ -3,7 +3,9 @@
         pack-revindex: express constants in terms of the_hash_algo
     
         Express the various constants used in terms of the_hash_algo.
    +    While we're at it, fix a comment style issue as well.
     
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      diff --git a/pack-revindex.c b/pack-revindex.c
    @@ -37,7 +39,8 @@
      	}
      
     -	/* This knows the pack format -- the 20-byte trailer
    -+	/* This knows the pack format -- the hash trailer
    ++	/*
    ++	 * This knows the pack format -- the hash trailer
      	 * follows immediately after the last object data.
      	 */
     -	p->revindex[num_ent].offset = p->pack_size - 20;
 6:  5e8576c6e4 !  7:  3ccb2b7217 packfile: express constants in terms of the_hash_algo
    @@ -5,6 +5,11 @@
         Replace uses of GIT_SHA1_RAWSZ with references to the_hash_algo to avoid
         dependence on a particular hash length.
     
    +    It's likely that in the future, we'll update the pack format to indicate
    +    what hash algorithm it uses, and then this code will change.  However,
    +    at least on an interim basis, make it easier to develop on a pure
    +    SHA-256 Git by using the_hash_algo here.
    +
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      diff --git a/packfile.c b/packfile.c
 7:  4c7b6471db =  8:  39eb7e1069 refs/packed-backend: express constants using the_hash_algo
 8:  8318dcb630 =  9:  55269d5fc2 upload-pack: express constants in terms of the_hash_algo
 9:  16916c9fa2 = 10:  d30536a3bd transport: use parse_oid_hex instead of a constant
10:  9d8e2bc4ae = 11:  2139fe1fe1 tag: express constant in terms of the_hash_algo
11:  58f91f2167 = 12:  af815c4215 apply: replace hard-coded constants
12:  6899dfc4af = 13:  f651b226c8 apply: rename new_sha1_prefix and old_sha1_prefix
13:  cc974651cb = 14:  bf1d450aa5 submodule: make zero-oid comparison hash function agnostic
14:  b373f16c12 = 15:  d984036c1c rerere: convert to use the_hash_algo
