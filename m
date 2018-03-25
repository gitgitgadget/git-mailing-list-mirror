Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ED1D1F404
	for <e@80x24.org>; Sun, 25 Mar 2018 19:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeCYTVL (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 15:21:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42470 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750782AbeCYTVK (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Mar 2018 15:21:10 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C79C160988;
        Sun, 25 Mar 2018 19:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1522005668;
        bh=iR1aBkC/ZWTWksgWH66Ac8mSKM4Ahaa+kj1iKi2Y4gU=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uCSYPCR5Gtwpe06nSPdehVq3bc8cybko+fQwf17rlN2bJq6cJVMUIkaKiQpWIjD6X
         W01mH1NxLiaZr1gint7FTViBbDvPGcB8HkYQ5k/eMhB3SVfpspXotaW1L6fRq74bgR
         3gqGzEuq0w/7/4ez0s8uDKVbwqQi/wuRjSV7uAufAo5Iju/nBPQ9Liv5tpGuG1gYCw
         aTNyLXTs7tAi3p8jJ0YH/g74l8LTmjmi5wzHmrt3bwlhTaCfoAwWvfq6a4cpq9IwXs
         kqcKP3oGZDZPi7PgvAiMLBTK5pawlLh91zFQQnrc6r7OFnRbZ9vcx12WOPIHul+pV1
         QLeuh1R+rl7wVyumhCXbX0nQWXOAi528RZvFrUAQmqaVnnnmNyDP/Ek76jvAgO1WAu
         rFvU0H/MNreXZlQdf+jCGa6pdTrAhPf5Cvj/kQsaAzCkKZW7pCTyI2hiMLTg2IkheU
         ZfJ6ttGVf4gDiYUuZhRYFXeKoEwbJKriCOHTkP9gaVmiw8YmFFr
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 00/10] Hash-independent tests (part 1)
Date:   Sun, 25 Mar 2018 19:20:45 +0000
Message-Id: <20180325192055.841459-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.rc1.317.g4a561d2cc9
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a series to make our tests hash-independent.  Many tests have
hard-coded SHA-1 values in them, and it would be valuable to express
these items in a hash-independent way for our hash transitions.

The approach in this series relies on only three components for hash
independence: git rev-parse, git hash-object, and EMPTY_BLOB and
EMPTY_TREE.  Because many of our shell scripts and test components
already rely on the first two, this seems like a safe assumption.

For the same reason, this series avoids modifying tests that test these
components or their expected SHA-1 values.  I expect that when we add
another hash function, we'll copy these tests to expose both SHA-1 and
NewHash versions.

Many of our tests use heredocs for defining expected values.  My
approach has been to interpolate values into the heredocs, as that
produces the best readability in my view.

These tests have been tested using my "short BLAKE2b" series (branch
blake2b-test-hash) and have also been tested based off master.

Comments on any aspect of this series are welcome, but opinions on the
approach or style are especially so.

brian m. carlson (10):
  t1011: abstract away SHA-1-specific constants
  t1304: abstract away SHA-1-specific constants
  t1300: abstract away SHA-1-specific constants
  t1405: sort reflog entries in a hash-independent way
  t1411: abstract away SHA-1-specific constants
  t1507: abstract away SHA-1-specific constants
  t2020: abstract away SHA-1 specific constants
  t2101: modernize test style
  t2101: abstract away SHA-1-specific constants
  t2107: abstract away SHA-1-specific constants

 t/t1011-read-tree-sparse-checkout.sh |  7 ++-
 t/t1300-repo-config.sh               |  6 +-
 t/t1304-default-acl.sh               |  2 +-
 t/t1405-main-ref-store.sh            |  4 +-
 t/t1411-reflog-show.sh               | 21 ++++---
 t/t1507-rev-parse-upstream.sh        |  5 +-
 t/t2020-checkout-detach.sh           | 40 +++++++-----
 t/t2101-update-index-reupdate.sh     | 91 +++++++++++++++-------------
 t/t2107-update-index-basic.sh        |  6 +-
 9 files changed, 100 insertions(+), 82 deletions(-)

