Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 226551F991
	for <e@80x24.org>; Wed,  2 Aug 2017 10:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbdHBKpB (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 06:45:01 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:46790 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752757AbdHBKov (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 06:44:51 -0400
Received: from lindisfarne.localdomain ([92.22.28.33])
        by smtp.talktalk.net with SMTP
        id cr8nd8nSUiSHacr90dwio6; Wed, 02 Aug 2017 11:44:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1501670690; bh=encTC7oAJjJFUTVh5T6oQGy+eLBJ+ZHt/CftngfGRtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=naBoXopI/fBV6fbjj/GV5GqCP5AqwgSxAaERsL28C2Qnblkcwaoa58PLhwgQmseiZ
         0W+1mi4ml+dBh4RPaNML4KzmScUb2RWRNTEP/7/b25z2AVXfVa6etnRO20nHRbP+L3
         AWbr85vmWE/7gIj4OOYVEWqcx1IKesNOQcR+4tUA=
X-Originating-IP: [92.22.28.33]
X-Spam: 0
X-OAuthority: v=2.2 cv=UoATD64B c=1 sm=1 tr=0 a=BeSdjzhxhZnKGFP9cxuqMA==:117
 a=BeSdjzhxhZnKGFP9cxuqMA==:17 a=evINK-nbAAAA:8 a=9MXahgpz6xUu425BIzAA:9
 a=dXnhgfItdGqR5gIV:21 a=jcX2Oo9QQSeCK6DK:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 4/6] t3504: use test_commit
Date:   Wed,  2 Aug 2017 11:44:18 +0100
Message-Id: <20170802104420.12809-5-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170802104420.12809-1-phillip.wood@talktalk.net>
References: <20170802104420.12809-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfGFgNDPmHmHxbaa6KO3FNj8ydScWMeFLeEPctnOWT+5K227wVrwj9LUGxnVnV+YNfx6QyJB5omdtwrUczAQ1isL599QPrsA5edWE8No8x8QjLQIoD5wW
 aFJQqdyryPuocn5IzV/Puv5q2pn4kF0H7hYRZXmEJQEvV/TkkHCYnGeL0xGaQmt/Hm0woWjhZ8DxhP4q9cSXzieCcslf1E2ppIdVEg+fd5nBTap6BaZWREna
 99E2GIwkZGPiazsOy5QyXA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Using test_commit is simpler than chaining echo && git add &&
test_tick && commit. Also having tags makes it clearer which commit
is being selecting by reset.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3504-cherry-pick-rerere.sh | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
index e6a64816efef0e53018c7a56784d1af62602e9d3..33f902b1b0d8eb651e0e6857f8f5b86ef633ef4a 100755
--- a/t/t3504-cherry-pick-rerere.sh
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -5,14 +5,11 @@ test_description='cherry-pick should rerere for conflicts'
 . ./test-lib.sh
 
 test_expect_success setup '
-	echo foo >foo &&
-	git add foo && test_tick && git commit -q -m 1 &&
-	echo foo-master >foo &&
-	git add foo && test_tick && git commit -q -m 2 &&
+	test_commit foo &&
+	test_commit foo-master foo &&
 
-	git checkout -b dev HEAD^ &&
-	echo foo-dev >foo &&
-	git add foo && test_tick && git commit -q -m 3 &&
+	git checkout -b dev foo &&
+	test_commit foo-dev foo &&
 	git config rerere.enabled true
 '
 
@@ -21,10 +18,10 @@ test_expect_success 'conflicting merge' '
 '
 
 test_expect_success 'fixup' '
-	echo foo-dev >foo &&
-	git add foo && test_tick && git commit -q -m 4 &&
-	git reset --hard HEAD^ &&
-	echo foo-dev >expect
+	echo foo-resolved >foo &&
+	git commit -am resolved &&
+	cp foo expect &&
+	git reset --hard HEAD^
 '
 
 test_expect_success 'cherry-pick conflict' '
-- 
2.13.3

