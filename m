Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E024D1F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 21:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbeJIFK6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 01:10:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49268 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725759AbeJIFK6 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Oct 2018 01:10:58 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8B3F36077F;
        Mon,  8 Oct 2018 21:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539035826;
        bh=RThIsdHZwWp12aJYtMof1da4qL8Qk4v3KIfqA00ggPY=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ElyKlh9dLl7JFGGRY4kGRczNJQ49n74tVrmhv94Ybc6emKaNJcWGi/17Tq6m4Gmr0
         IyUhgEOqAePUVYGqYJ2q74axStU5mzFjuArdne5cN/yXfWsaUB4laSOOBX+GSGLnAe
         ePPgsPd14y5TjWIvMji5NwuNmUrRe+u30s7XiG0NMokEWyhlAMwt9E/suTsRxqvzXl
         JN6jjg3NOcy7K7uhxLxn6BKVsnWcNbf4TbKDjIVUkNg1auMeC/78vYUSBfEPX7rUt2
         jgUVjg8hwB7VnF99OJV0kdhr67deSlHjQ1Qyx0bmeSg9PRkFG+ChfJeeDe/CD8MKak
         bd6qFNDXsqnJaj64iLodm+4goWLOi6LW/9GUQWWiZDNopfXrsMV3PMFd5gJAhY06Gk
         Ym4JJmEzszxSF8Ss258QMdYEr3pmI8LMfzY6cUncC/FgDMws7oa9WUxyHsTrihHzoK
         EeQ2bWxmw1z/UBc4o60qw9uGeJOP7yo7z/PqfTL9qQ4x70ySC4B
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/14] Hash function transition part 15
Date:   Mon,  8 Oct 2018 21:56:47 +0000
Message-Id: <20181008215701.779099-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the fifteenth series in the ongoing hash function transition.

This series includes several conversions to use the_hash_algo, combined
with some use of parse_oid_hex and GIT_MAX_RAWSZ.  None of the
transformations here are especially surprising.

brian m. carlson (14):
  pack-bitmap-write: use GIT_MAX_RAWSZ for allocation
  builtin/repack: replace hard-coded constant
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

 apply.c               | 50 +++++++++++++-------------
 builtin/fetch-pack.c  | 13 +++----
 builtin/mktree.c      |  2 +-
 builtin/repack.c      |  4 +--
 git-submodule.sh      |  7 +++-
 pack-bitmap-write.c   |  2 +-
 pack-revindex.c       |  9 ++---
 packfile.c            |  5 +--
 refs/packed-backend.c | 14 ++++----
 rerere.c              | 81 ++++++++++++++++++++++---------------------
 tag.c                 |  2 +-
 transport.c           |  7 ++--
 upload-pack.c         | 13 +++----
 13 files changed, 112 insertions(+), 97 deletions(-)

