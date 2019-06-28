Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DFE01F461
	for <e@80x24.org>; Fri, 28 Jun 2019 22:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfF1W7h (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 18:59:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56278 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbfF1W7h (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Jun 2019 18:59:37 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f01a:2fd6:a95e:5f84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5022E60428;
        Fri, 28 Jun 2019 22:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1561762774;
        bh=t8kUdBPcuBRNi+5YL4mdZi0eemgoaP+6QDRYLc4UUfo=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=MtgRqBspOm+Zkuhzw+afAnRmJ8OE/pqQEL4L/aZZM0TQSRrTC1Vl/pLjPjF6+ZTJh
         DBZN06HFJ1IeVQvkOhd1dyZYaKOg4jzYSSB89neWcWh3D5TcHDfyEdczf0fFkQcwqz
         B6A/33ICtgVi1T13eixlWg37beQO/T700+sYt28mgf4NhqayunDzPDDlK5KY2JDapf
         iddLkA5aKzhdRUk+h8aF3ulCsTc/gYodZ9OzqpWzYCKr3lDZC8++23Kj6KIxkoiWiq
         UxrmJ8zg1hwdyCoid4lkPHraxJLCHMF4Pjfo1JqhFbkqkzXYKJvQEAJM6oBGN7g1y7
         Rc+f00aDxerG6PzDE+q28hEMGXn+ZWMR+ftdOop0jVlNX/sDyNQ//X1fEMxaSKV1+U
         ync0QhUnZYWUTXjoIDHYsgWGs/yhzhl5u9oQ8AiK6FMqqAp4w/QlbKyHAuChTzxd5b
         Vht/8HCkVThFxEhaxqDWPxDFBnRjmCRtAoJ8jKVVnuT0iYA0O3G
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 00/10] Hash-independent tests, part 4
Date:   Fri, 28 Jun 2019 22:59:18 +0000
Message-Id: <20190628225928.622372-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an additional series of fixes for tests to make them work with
SHA-256.

This series makes use of several constants, such as $ZERO_OID, which
will be replaced with appropriate values based on "test_oid" with later
work.

Changes from v2:
* Switch to using shell instead of sed in test_oid_to_path

brian m. carlson (10):
  t: add helper to convert object IDs to paths
  t1410: make hash size independent
  t1450: make hash size independent
  t5000: make hash independent
  t6030: make test work with SHA-256
  t0027: make hash size independent
  t0090: make test pass with SHA-256
  t1007: remove SHA1 prerequisites
  t1710: make hash independent
  t2203: avoid hard-coded object ID values

 t/t0027-auto-crlf.sh                          |   6 +-
 t/t0090-cache-tree.sh                         |   4 +-
 t/t1007-hash-object.sh                        |  58 ++++++++++--------
 t/t1410-reflog.sh                             |  16 ++---
 t/t1450-fsck.sh                               |  41 ++++++++-----
 t/t1700-split-index.sh                        |  51 ++++++++++-----
 t/t2203-add-intent.sh                         |   6 +-
 t/t5000-tar-tree.sh                           |  16 +++--
 ...8938e6999cb59b3ff66739902a => huge-object} | Bin
 t/t6030-bisect-porcelain.sh                   |  31 +++++-----
 t/test-lib-functions.sh                       |   6 ++
 11 files changed, 142 insertions(+), 93 deletions(-)
 rename t/t5000/{19f9c8273ec45a8938e6999cb59b3ff66739902a => huge-object} (100%)

