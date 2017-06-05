Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FA411F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 22:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbdFEWi3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 18:38:29 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:53638
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751180AbdFEWi2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Jun 2017 18:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1496702306;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=NizgdknJHuA2R3Hr8Uvlw5sSWq8n2HJHCt2KW3Xhrus=;
        b=QwsSS89gUQqj6BbWrwSRqiRk7yyFo1m1eA80C6pHzN7TcOa6+AMr3Qqibx5eVvRn
        qXc7n3A8AFxDjI9KcgtweF2qZWJnk10bB3U09HjYxbgcPIgqb11yjlXiybZiOLNZpG1
        vGuU6QhTMjz/ydhxIjWW9blhoK2TzQ10B0oEiqdw=
From:   Sahil Dua <sahildua2305@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015c7a68c647-372a5a13-5412-4838-921d-66980bac4099-000000@eu-west-1.amazonses.com>
Subject: [PATCH] t3200: add test for single parameter passed to -m option
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 5 Jun 2017 22:38:25 +0000
X-SES-Outgoing: 2017.06.05-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds a test for the case when only one parameter is passed to '-m'
(move/rename) option.

For example - if 'git branch -m bbb' is run, it should rename the
currently checked out branch to bbb. There was no test for this
particular case with only one parameter for -m option. However,
there's one similar test case for -M option.

Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
---
 t/t3200-branch.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index fe62e7c775da6..7504f14bc52f8 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -100,6 +100,14 @@ test_expect_success 'git branch -m n/n n should work' '
 	git reflog exists refs/heads/n
 '
 
+test_expect_success 'git branch -m bbb should rename checked out branch' '
+	test_when_finished git branch -d bbb &&
+	test_when_finished git checkout master &&
+	git checkout -b aaa &&
+	git branch -m bbb &&
+	git reflog exists refs/heads/bbb
+'
+
 test_expect_success 'git branch -m o/o o should fail when o/p exists' '
 	git branch o/o &&
 	git branch o/p &&

--
https://github.com/git/git/pull/371
