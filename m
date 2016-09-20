Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77C111F4F8
	for <e@80x24.org>; Tue, 20 Sep 2016 06:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753842AbcITGQP (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 02:16:15 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:14439 "EHLO bsmtp4.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751494AbcITGQO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 02:16:14 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp4.bon.at (Postfix) with ESMTPSA id 3sdXZN4380z5tlC;
        Tue, 20 Sep 2016 08:16:12 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9F9345312;
        Tue, 20 Sep 2016 08:16:11 +0200 (CEST)
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH tg/add-chmod+x-fix 1/2] t3700-add: create subdirectory gently
Message-ID: <cee3c784-8f03-c524-2f67-d35cb3755a41@kdbg.org>
Date:   Tue, 20 Sep 2016 08:16:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The subdirectory 'sub' is created early in the test file. Later, a test
case removes it during its clean-up actions. However, this test case is
protected by POSIXPERM. Consequently, 'sub' remains when the POSIXPERM
prerequisite is not satisfied. Later, a recently introduced test case
creates 'sub' again. Use -p with mkdir so that it does not fail if 'sub'
already exists.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t3700-add.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 0a962a6..16ab2da 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -380,7 +380,7 @@ test_expect_success 'no file status change if no pathspec is given' '
 '
 
 test_expect_success 'no file status change if no pathspec is given in subdir' '
-	mkdir sub &&
+	mkdir -p sub &&
 	(
 		cd sub &&
 		>sub-foo1 &&
-- 
2.10.0.85.gea34e30

