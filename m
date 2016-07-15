Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 977E2203C2
	for <e@80x24.org>; Fri, 15 Jul 2016 23:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbcGOXXy (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 19:23:54 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:45098 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234AbcGOXXw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 19:23:52 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1bOCSR-0003B5-0t; Sat, 16 Jul 2016 08:23:47 +0900
From:	Mike Hommey <mh@glandium.org>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v3 2/2] t/t8003-blame-corner-cases.sh: Use here documents
Date:	Sat, 16 Jul 2016 08:23:46 +0900
Message-Id: <20160715232346.12176-2-mh@glandium.org>
X-Mailer: git-send-email 2.9.1.277.gdbc86c9.dirty
In-Reply-To: <20160715232346.12176-1-mh@glandium.org>
References: <xmqqr3auli2x.fsf@gitster.mtv.corp.google.com>
 <20160715232346.12176-1-mh@glandium.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Somehow, this test was using:

{
	echo A
	echo B
} > file

block to feed file contents. This changes those to the form most common
in git test scripts:

cat >file <<-\EOF
A
B
EOF

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 t/t8003-blame-corner-cases.sh | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index eab2e28..e48370d 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -41,12 +41,12 @@ test_expect_success setup '
 	test_tick &&
 	GIT_AUTHOR_NAME=Fourth git commit -m Fourth &&
 
-	{
-		echo ABC
-		echo DEF
-		echo XXXX
-		echo GHIJK
-	} >cow &&
+	cat >cow <<-\EOF &&
+	ABC
+	DEF
+	XXXX
+	GHIJK
+	EOF
 	git add cow &&
 	test_tick &&
 	GIT_AUTHOR_NAME=Fifth git commit -m Fifth
@@ -115,11 +115,11 @@ test_expect_success 'append with -C -C -C' '
 test_expect_success 'blame wholesale copy' '
 
 	git blame -f -C -C1 HEAD^ -- cow | sed -e "$pick_fc" >current &&
-	{
-		echo mouse-Initial
-		echo mouse-Second
-		echo mouse-Third
-	} >expected &&
+	cat >expected <<-\EOF &&
+	mouse-Initial
+	mouse-Second
+	mouse-Third
+	EOF
 	test_cmp expected current
 
 '
@@ -127,12 +127,12 @@ test_expect_success 'blame wholesale copy' '
 test_expect_success 'blame wholesale copy and more' '
 
 	git blame -f -C -C1 HEAD -- cow | sed -e "$pick_fc" >current &&
-	{
-		echo mouse-Initial
-		echo mouse-Second
-		echo cow-Fifth
-		echo mouse-Third
-	} >expected &&
+	cat >expected <<-\EOF &&
+	mouse-Initial
+	mouse-Second
+	cow-Fifth
+	mouse-Third
+	EOF
 	test_cmp expected current
 
 '
-- 
2.9.1.277.gdbc86c9.dirty

