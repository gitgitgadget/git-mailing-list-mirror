Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 424EF1FF40
	for <e@80x24.org>; Thu,  1 Dec 2016 03:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756235AbcLADER convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 30 Nov 2016 22:04:17 -0500
Received: from dmz-mailsec-scanner-8.mit.edu ([18.7.68.37]:61479 "EHLO
        dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755899AbcLADEQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Nov 2016 22:04:16 -0500
X-AuditID: 12074425-8c7ff70000000221-50-583f932acee0
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by  (Symantec Messaging Gateway) with SMTP id 5E.51.00545.A239F385; Wed, 30 Nov 2016 22:04:11 -0500 (EST)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id uB1349kW006879;
        Wed, 30 Nov 2016 22:04:09 -0500
Received: from localhost (buzzword-bingo.mit.edu [18.9.64.24])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id uB1347ZN029349
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 30 Nov 2016 22:04:08 -0500
Date:   Wed, 30 Nov 2016 22:04:07 -0500 (EST)
From:   Anders Kaseorg <andersk@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Define XDL_FAST_HASH when building *for* (not *on*) x86_64
Message-ID: <alpine.DEB.2.10.1611302202100.20145@buzzword-bingo.mit.edu>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsUixCmqrKs92T7C4O13DouuK91MFg29V5gt
        Vu5ayOTA7HHxkrLH3E+LWD0+b5ILYI7isklJzcksSy3St0vgyvj+bzZTwXO+igun5rI3MM7k
        6WLk5JAQMJG4/2UnUxcjF4eQQBuTxJbFm1ggnI2MEr37/rNDOLuZJDbM7GYEaWER0JaYtXQC
        M4jNJqAm8eHoV1YQWwTInth2iAXEZhawkXj/fjNYvbCAt8TmPS/ZQGxeAQ+J6R3HwGxRAV2J
        Q//+QMUFJU7OfALVqy5x4NNFRghbW+L+zTa2CYx8s5CUzUJSNgtJ2QJG5lWMsim5Vbq5iZk5
        xanJusXJiXl5qUW6Fnq5mSV6qSmlmxhBocjuorqDcc5fr0OMAhyMSjy8CbftIoRYE8uKK3MP
        MUpyMCmJ8paV2EcI8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuENngiU401JrKxKLcqHSUlzsCiJ
        8/53+xouJJCeWJKanZpakFoEk5Xh4FCS4C2dBNQoWJSanlqRlplTgpBm4uAEGc4DNDwXpIa3
        uCAxtzgzHSJ/ilGX482ulw+YhFjy8vNSpcR5n4BcIABSlFGaBzcHkkIcJF4xigO9JcyrAzKK
        B5h+4Ca9AlrCBLTk7WtrkCUliQgpqQbGIKbN7z5vW6vmuFvv9fa9azI2vJS/MtHHd6Wd0K03
        d8yiuPSZt/2ex7io0v9V+6xnBwX0AuY7vPvVdaPs5r8b1ayXr7Dpn4zPCuwxvsDvnyr1sDJH
        7WqL6P7LFjPa3Vo3/Q4NP+6xPHvaOgfmJednuslJWhxTuFRs81HCr6TvUfDdY9M9Mw2SlFiK
        MxINtZiLihMBZX2ChPwCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, XDL_FAST_HASH was defined when ‘uname -m’ returns x86_64,
even if we are cross-compiling for a different architecture.  Check
the __x86_64__ compiler macro instead.

In addition to fixing the cross compilation bug, this is needed to
pass the Debian build reproducibility test
(https://tests.reproducible-builds.org/debian/index_variations.html).

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 config.mak.uname | 5 -----
 xdiff/xutils.c   | 4 ++++
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index b232908f8..2831a68c3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -1,10 +1,8 @@
 # Platform specific Makefile tweaks based on uname detection
 
 uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
-uname_M := $(shell sh -c 'uname -m 2>/dev/null || echo not')
 uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
 uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
-uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
 uname_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')
 
 ifdef MSVC
@@ -17,9 +15,6 @@ endif
 # because maintaining the nesting to match is a pain.  If
 # we had "elif" things would have been much nicer...
 
-ifeq ($(uname_M),x86_64)
-	XDL_FAST_HASH = YesPlease
-endif
 ifeq ($(uname_S),OSF1)
 	# Need this for u_short definitions et al
 	BASIC_CFLAGS += -D_OSF_SOURCE
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 027192a1c..f46351fe4 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -264,6 +264,10 @@ static unsigned long xdl_hash_record_with_whitespace(char const **data,
 	return ha;
 }
 
+#ifdef __x86_64__
+#define XDL_FAST_HASH
+#endif
+
 #ifdef XDL_FAST_HASH
 
 #define REPEAT_BYTE(x)  ((~0ul / 0xff) * (x))
-- 
2.11.0

