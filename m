Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CBCE1F4F8
	for <e@80x24.org>; Tue, 20 Sep 2016 06:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754097AbcITGS3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 02:18:29 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:21886 "EHLO bsmtp4.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752731AbcITGS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 02:18:27 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp4.bon.at (Postfix) with ESMTPSA id 3sdXcx6krTz5tlP;
        Tue, 20 Sep 2016 08:18:25 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id B281A5312;
        Tue, 20 Sep 2016 08:18:25 +0200 (CEST)
Subject: [PATCH tg/add-chmod+x-fix 2/2] t3700-add: protect one --chmod=+x test
 with POSIXPERM
To:     Thomas Gummerer <t.gummerer@gmail.com>
References: <cee3c784-8f03-c524-2f67-d35cb3755a41@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5effaf36-d017-3ff1-1de1-d9b303c04f23@kdbg.org>
Date:   Tue, 20 Sep 2016 08:18:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <cee3c784-8f03-c524-2f67-d35cb3755a41@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A recently introduced test checks the result of 'git status' after
setting the executable bit on a file. This check does not yield the
expected result when the filesystem does not support the executable bit
(and core.filemode is false). Skip the test case.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 I am surprised that add --chmod=+x changes only the index, but not
 the file on disk!?!

 t/t3700-add.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 16ab2da..13e0dd2 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -361,7 +361,7 @@ test_expect_success 'git add --chmod=[+-]x changes index with already added file
 	test_mode_in_index 100644 xfoo3
 '
 
-test_expect_success 'file status is changed after git add --chmod=+x' '
+test_expect_success POSIXPERM 'file status is changed after git add --chmod=+x' '
 	echo "AM foo4" >expected &&
 	echo foo >foo4 &&
 	git add foo4 &&
-- 
2.10.0.85.gea34e30

