Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6B581F404
	for <e@80x24.org>; Thu,  1 Feb 2018 02:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932192AbeBACTA (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 21:19:00 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58534 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932159AbeBACS7 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 Jan 2018 21:18:59 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4D8656096E;
        Thu,  1 Feb 2018 02:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517451537;
        bh=+hWd3W96JsL3/Ol6LCFAcRDhAL7ahGLIgE1hR2/0Mz0=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=kU46P0Y/+rng9rMJ2CCF+etUq2wiYPL0tPEtdMhyqslEKJIYn2rpagP5h+lmmNm09
         FzyxwJjD0eYK30iaongE62LyteRnILxhPg4EL+JowpgSxXKYb4AdsDH2AEJu6J0iWj
         CELUVXc0Kb/dYL5rPWveXOo7hb2AZeiCzI6ccfvTILDzBxoenehMnSaGiKLk7sUhYx
         RRFcWSVbtUbnkD5cB26HbVfK8V4ZGiCqj8ueG4IRlkc/EzOTYrrphFB76O9R0ouh/A
         vnvJ974yeY0B0UClJmMtVPWFEZ7TjP6RkWemcZ1PD34u42B9YiolXxuPMgJQ5/Lk2C
         gbHym3rdXFDSK47PKSrUVfBY8xAOfsOiKteiUYEqTd6JTdwWivhmvLuzCitUIg3+eU
         LhhIeYu4jumYcIdisAHuRTmQMJVGl+v3a8aSa7nX0BTjeL54C8ZtqOIhM95/H/qjh2
         mAzXw9s1kkzwfAS5pt5vtVSWs3GCJcMkXiUZ0VSQCE9rsrYQ1q5
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 00/12] object_id part 11 (the_hash_algo)
Date:   Thu,  1 Feb 2018 02:18:36 +0000
Message-Id: <20180201021848.533188-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.315.g94e5d3ead4
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series includes various changes to adopt the use of the_hash_algo
for abstracting hash algorithms away.

Changes from v1:
* Fix comments referring to SHA-1.
* Switch hash function wrappers to take git_hash_ctx *.
* Use a const int variable for a constant value.
* Wrap an overly long line.

brian m. carlson (12):
  hash: move SHA-1 macros to hash.h
  hash: create union for hash context allocation
  builtin/index-pack: improve hash function abstraction
  builtin/unpack-objects: switch uses of SHA-1 to the_hash_algo
  sha1_file: switch uses of SHA-1 to the_hash_algo
  fast-import: switch various uses of SHA-1 to the_hash_algo
  pack-check: convert various uses of SHA-1 to abstract forms
  pack-write: switch various SHA-1 values to abstract forms
  read-cache: abstract away uses of SHA-1
  csum-file: rename sha1file to hashfile
  csum-file: abstract uses of SHA-1
  bulk-checkin: abstract SHA-1 usage

 builtin/index-pack.c     | 108 +++++++++++++++++++++++------------------------
 builtin/pack-objects.c   |  52 +++++++++++------------
 builtin/unpack-objects.c |  18 ++++----
 bulk-checkin.c           |  28 ++++++------
 cache.h                  |  25 -----------
 csum-file.c              |  46 ++++++++++----------
 csum-file.h              |  38 ++++++++---------
 fast-import.c            |  70 +++++++++++++++---------------
 hash.h                   |  40 +++++++++++++++---
 pack-bitmap-write.c      |  30 ++++++-------
 pack-check.c             |  32 +++++++-------
 pack-write.c             |  77 ++++++++++++++++-----------------
 pack.h                   |   4 +-
 read-cache.c             |  58 ++++++++++++-------------
 sha1_file.c              |  72 +++++++++++++++----------------
 15 files changed, 351 insertions(+), 347 deletions(-)

