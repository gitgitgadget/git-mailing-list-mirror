Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D62C1F576
	for <e@80x24.org>; Mon, 12 Feb 2018 08:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932995AbeBLIJl (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 03:09:41 -0500
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:41342
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932993AbeBLIIz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Feb 2018 03:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1518422934;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=xatr2BJum8Cs6FBYVsFEDISBZl1tFpNScVLC/xkTOvU=;
        b=CTM9eoSZeE7fVXC0tmsYIyyL0vpPeW0Knl5wTdHNjBSNb0Bcdn44K2X5y5t7ZglV
        TzqrcUuTgK9jCF79OPC40gRMQ56KFtEzMPwNZmiZ77Q0AOz0Z+T/POSUR8EF1m1vkot
        fKXi7uKIkFEdXY8Al8iwvZSRyLRNjW7Fb5VqgETU=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020161890f438c-9d30a51c-129c-4721-a85a-a3d66a2270b6-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 21/23] for-each-ref: tests for new atoms added
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Feb 2018 08:08:54 +0000
X-SES-Outgoing: 2018.02.12-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for new formatting atoms: rest, deltabase, objectsize:disk.
rest means nothing and we expand it into empty string.
We need this atom for cat-file command.
Have plans to support deltabase and objectsize:disk further
(as it is done in cat-file), now also expand it to empty string.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 t/t6300-for-each-ref.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index c128dfc579079..eee656a6abba9 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -316,6 +316,24 @@ test_expect_success 'exercise strftime with odd fields' '
 	test_cmp expected actual
 '
 
+test_expect_success 'Check format %(objectsize:disk) gives empty output ' '
+	echo >expected &&
+	git for-each-ref --format="%(objectsize:disk)" refs/heads >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Check format %(rest) gives empty output ' '
+	echo >expected &&
+	git for-each-ref --format="%(rest)" refs/heads >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Check format %(deltabase) gives empty output ' '
+	echo >expected &&
+	git for-each-ref --format="%(deltabase)" refs/heads >actual &&
+	test_cmp expected actual
+'
+
 cat >expected <<\EOF
 refs/heads/master
 refs/remotes/origin/master

--
https://github.com/git/git/pull/452
