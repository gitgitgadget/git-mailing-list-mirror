Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B7E71F462
	for <e@80x24.org>; Sun,  9 Jun 2019 22:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfFIWoM (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 18:44:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37536 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729304AbfFIWoM (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 Jun 2019 18:44:12 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1504:7263:609b:f73f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D789F61B2D;
        Sun,  9 Jun 2019 22:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1560120249;
        bh=RPGfPuvDymegjnq1/Win6VIudGMrbAx4qt7Y7+78/4s=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=i2EA6CVLY+/n01A1ZAh12d2SY3SW8UgBpzveRqW/v0BapghYI6NdG7QMcdDYKVVNr
         NkkE6JZ091pVlR7vXgge4i6duW1xfmR+MFardzPaEoLbA/vqQAjeMQoWSJMr0hJAEa
         CWBb9WEBRp304wh8YeWSdvIgWgofeLyCoqYpQT3dH8ydBu7XjE46YOZhxDT944dqOt
         oMFC+YIbZ4yOIAoPX785cZm6emDKYqHilwZ4bSBbPwhtopMx4Wz1yTQevYtI9ToahY
         1phlsAvrC2aAKqu7X+bKOOc+rawm1xHeowfEaJDPJhBdq52+D26XB5eEn4khS7tpd8
         6Wm23gdxooclqJenHlpSt1b/0dQNXIWa0xQRzMe2TIDxtpkZJwj8EMTYmmtps/pPiJ
         Sk2ZXnZTBTwd04Rkph5sVxon+5HaPfLa+OjMKLWn5tNOcIac29dZtvH7UeE64D00Iv
         BMIrhDc5n/ROr/KhUHbcYRi+C1N2DWelCOS0uKEJ5UguOuppsYk
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 00/10] Hash-independent tests, part 4
Date:   Sun,  9 Jun 2019 22:43:50 +0000
Message-Id: <20190609224400.41557-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an additional series of fixes for tests to make them work with
SHA-256.

Mostly, this series introduces a helper function and fixes tests. There
is one test (t1410) which adds an SHA1 prerequisite. I wasn't able to
get the math to work out when trying to compute the proper values for
SHA-256, and the test doesn't test what it's supposed to test without
changes, so I opted to mark it with a prerequisite. Suggestions on how
to make it functionally useful under SHA-256 would be appreciated.

My hope is to introduce several small series of patches for tests that
are mostly independent of one another and can be picked up reasonably
quickly.

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
 t/t1450-fsck.sh                               |  44 ++++++++-----
 t/t1700-split-index.sh                        |  51 ++++++++++-----
 t/t2203-add-intent.sh                         |   6 +-
 t/t5000-tar-tree.sh                           |  16 +++--
 ...8938e6999cb59b3ff66739902a => huge-object} | Bin
 t/t6030-bisect-porcelain.sh                   |  31 +++++-----
 t/test-lib-functions.sh                       |   6 ++
 11 files changed, 144 insertions(+), 94 deletions(-)
 rename t/t5000/{19f9c8273ec45a8938e6999cb59b3ff66739902a => huge-object} (100%)

