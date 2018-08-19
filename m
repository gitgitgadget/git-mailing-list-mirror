Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E3141F954
	for <e@80x24.org>; Sun, 19 Aug 2018 17:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbeHSVG1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 17:06:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55000 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbeHSVG1 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Aug 2018 17:06:27 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EF5F76047A;
        Sun, 19 Aug 2018 17:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1534701248;
        bh=LGN7E3RoDuSCfPSzQghe69soB0XnMwzQXdZOiEGriow=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=KNdusrhPfQuQ78zwATaxqvk7oSOM6zWRb8/RVe1tgWy8hzVZuR9nvPqR2QmPDG9pw
         73hvyQ0sCtPx3m6SfRElpgRYf8CroFwURZNEpVqwsiPJa3s3aWGqeA7ygMArbP4DuY
         PIrH+SZwEWWBqlPzljBWt8hB/tPeJsgxqiZIxcnNHFicG8xxMjebCEOa3mag+VLDwj
         yJBe5P+2StakHnR3yfDCSoCydVuRhXxnYyBQbkDLSNEE9taf7OHetgUY1Wx4KnydpW
         h6S7i5tbKEIINorhvPyKgapkEdR8lDBLutZJpsWhoIoyVmks7wlvzRNbI7EHzvQcA4
         BHWFYn3lm+JYimNPaAfwX48NeVtgSV4X/M1FawWwGFoWELjZw+nmhasLG7kit4Hs+r
         KOt+ua0uYwk768LYKTu/35vTQzL7bAizupHh90uVbzqUJxqV8Dnp57Xx6QfpCGvtCG
         9C/lpCDJC2pnOECpUOWwcjqcbmsej6lZibt6qnqyFM+CyW+B88l
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 00/11] Hash-independent tests (part 3)
Date:   Sun, 19 Aug 2018 17:53:40 +0000
Message-Id: <20180819175351.449973-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.1017.ga543ac7ca45
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is next in the series of improvements to make tests
hash-independent.

This round modifies the helpers to more closely follow the
lighter-weight design that Eric Sunshine suggested in v1, at the cost of
requiring lookup keys to be shell identifiers.  If that's judged to be
undesirable, I can always hash the key before use.

Since we've decided on SHA-256, I put in an extra commit to update t0000
and remove the use of the SHA1 prerequisite.  As described in the commit
message, I wrote a Ruby script to synthesize the SHA-1 and SHA-256 blobs
and then used a second one to generate the trees, using the same
methodology for both algorithms. I did this specifically to ensure that
the object IDs are exactly the ones we think they are.

Changes from v1:
* Adopt pure shell approach for helper.
* Add tests for the helpers.
* Explicitly refer to SHA-256 now that we know it will be NewHash.
* Updated t0000 to remove SHA1 prerequisite.
* Change name of helper from test_translate to test_oid.
* Add helper to cache information in the shell.
* Simplified lookup of HEAD in t0002.
* Switched to using existing helper function in t0027.
* Simplified handling of IDs in t0064.

brian m. carlson (11):
  t: add tool to translate hash-related values
  t0000: use hash translation table
  t0000: update tests for SHA-256
  t0002: abstract away SHA-1 specific constants
  t0027: make hash size independent
  t0064: make hash size independent
  t1006: make hash size independent
  t1400: switch hard-coded object ID to variable
  t1405: make hash size independent
  t1406: make hash-size independent
  t1407: make hash size independent

 t/oid-info/hash-info           |   8 ++
 t/oid-info/oid                 |  29 ++++++
 t/oid-info/t0000               |  38 ++++++++
 t/t0000-basic.sh               | 168 ++++++++++++++++++++-------------
 t/t0002-gitfile.sh             |  26 ++---
 t/t0027-auto-crlf.sh           |   3 +-
 t/t0064-sha1-array.sh          |  49 +++++-----
 t/t1006-cat-file.sh            |   6 +-
 t/t1400-update-ref.sh          |   2 +-
 t/t1405-main-ref-store.sh      |   4 +-
 t/t1406-submodule-ref-store.sh |   6 +-
 t/t1407-worktree-ref-store.sh  |   4 +-
 t/test-lib-functions.sh        |  36 +++++++
 13 files changed, 267 insertions(+), 112 deletions(-)
 create mode 100644 t/oid-info/hash-info
 create mode 100644 t/oid-info/oid
 create mode 100644 t/oid-info/t0000

