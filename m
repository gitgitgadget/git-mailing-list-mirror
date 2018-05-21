Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 271671F51C
	for <e@80x24.org>; Mon, 21 May 2018 02:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeEUCCr (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 22:02:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50880 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752643AbeEUCCn (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 May 2018 22:02:43 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:fc4d:8d90:22bd:91d8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BB0A360747;
        Mon, 21 May 2018 02:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526868162;
        bh=XEKVT3yPmx3r4ENn87G2DLpPzpqiCkYlXAwj93wMTso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=KYHkVaCI7uxDQq3jVfegLRb2zM4WIVSx55Ndu/MuWnxL6pwDMkY1YweNfOnCupSwG
         zNal4SVqeq4caysXadloW7wVm4DJUiBk6QLwqcHHwVkb0JqWRXDUjQbxasF7O+fswl
         rVLGFTrCpTRcY1UOte1XS3q1F8Wb/TBaSGnvvO/xVImjBk5P/pzoH+jNCyRbDBNUf5
         c86CGFSndRkB/ra0lwsaZM/X0mB1kWcUMWkitpFtABUtl21vX/1BA1mKUdLl0OE6xP
         +Zop+S1Km73STm3klCQzMS9/WVxvHFMVCJD4H5pW734ojWHLTGCR1CuNiKEI51hqPS
         zVW92p75ffd3jquEVTkJCBnRQdlMonVNy/tXRvWux7g/AZXuU3ZvYXC5fPqReeXrqZ
         RoyAHNxWfdKrsEGZoBE1PmZaqKg3lQ9xqW3JOkpfOy0gKi+tqv5kkZdAKeTGctnmRw
         dzC36KvmBAs+EbmTbNB4PEf+ZSy+TNnXHjccbm/HKkfYBLJK5UJ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 09/28] t4044: skip test if not using SHA-1
Date:   Mon, 21 May 2018 02:01:28 +0000
Message-Id: <20180521020147.648496-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180521020147.648496-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
 <20180521020147.648496-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test relies on objects with colliding short names which are
necessarily dependent on the hash used.  Skip the test if we're not
using SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4044-diff-index-unique-abbrev.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t4044-diff-index-unique-abbrev.sh b/t/t4044-diff-index-unique-abbrev.sh
index d5ce72be63..647905e01f 100755
--- a/t/t4044-diff-index-unique-abbrev.sh
+++ b/t/t4044-diff-index-unique-abbrev.sh
@@ -3,6 +3,12 @@
 test_description='test unique sha1 abbreviation on "index from..to" line'
 . ./test-lib.sh
 
+if ! test_have_prereq SHA1
+then
+       skip_all='not using SHA-1 for objects'
+       test_done
+fi
+
 cat >expect_initial <<EOF
 100644 blob 51d2738463ea4ca66f8691c91e33ce64b7d41bb1	foo
 EOF
