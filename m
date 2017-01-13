Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E4C420756
	for <e@80x24.org>; Fri, 13 Jan 2017 16:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbdAMQPa (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 11:15:30 -0500
Received: from aserp1040.oracle.com ([141.146.126.69]:35279 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752079AbdAMQP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 11:15:28 -0500
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v0DGFKYX020815
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2017 16:15:21 GMT
Received: from t460.home (dhcp-ukc1-twvpn-3-vpnpool-10-175-225-84.vpn.oracle.com [10.175.225.84])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v0DGFF6W022180;
        Fri, 13 Jan 2017 16:15:19 GMT
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 3/3] t/t4051-diff-function-context: improve tests for new diff -W behaviour
Date:   Fri, 13 Jan 2017 17:15:12 +0100
Message-Id: <1484324112-17773-3-git-send-email-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1484324112-17773-1-git-send-email-vegard.nossum@oracle.com>
References: <1484324112-17773-1-git-send-email-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We now include non-empty lines immediately before (and after) a function
as belonging to the function.

We can test this new functionality by moving the "// Begin" markers on
each function to the previous line.

This commit is intentionally not part of the previous commits in order
to show that the tests do not break even when changing the behaviour of
'diff -W' in the previous commits.

Cc: René Scharfe <l.s.r@web.de>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 t/t4051-diff-function-context.sh | 2 +-
 t/t4051/appended1.c              | 3 ++-
 t/t4051/dummy.c                  | 3 ++-
 t/t4051/hello.c                  | 3 ++-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
index 6154acb..d1a646f 100755
--- a/t/t4051-diff-function-context.sh
+++ b/t/t4051-diff-function-context.sh
@@ -72,7 +72,7 @@ test_expect_success 'setup' '
 
 	# overlap function context of 1st change and -u context of 2nd change
 	grep -v "delete me from hello" <"$dir/hello.c" >file.c &&
-	sed 2p <"$dir/dummy.c" >>file.c &&
+	sed 3p <"$dir/dummy.c" >>file.c &&
 	commit_and_tag changed_hello_dummy file.c &&
 
 	git checkout initial &&
diff --git a/t/t4051/appended1.c b/t/t4051/appended1.c
index a9f56f1..8683983 100644
--- a/t/t4051/appended1.c
+++ b/t/t4051/appended1.c
@@ -1,5 +1,6 @@
 
-int appended(void) // Begin of first part
+// Begin of first part
+int appended(void)
 {
 	int i;
 	char *s = "a string";
diff --git a/t/t4051/dummy.c b/t/t4051/dummy.c
index a43016e..db227a8 100644
--- a/t/t4051/dummy.c
+++ b/t/t4051/dummy.c
@@ -1,5 +1,6 @@
 
-static int dummy(void)	// Begin of dummy
+// Begin of dummy
+static int dummy(void)
 {
 	int rc = 0;
 
diff --git a/t/t4051/hello.c b/t/t4051/hello.c
index 63b1a1e..75eac1d 100644
--- a/t/t4051/hello.c
+++ b/t/t4051/hello.c
@@ -1,5 +1,6 @@
 
-static void hello(void)	// Begin of hello
+// Begin of hello
+static void hello(void)
 {
 	/*
 	 * Classic.
-- 
2.7.4

