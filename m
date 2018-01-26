Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 582D61F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeAZTnz (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:43:55 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:34822
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752195AbeAZTnl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jan 2018 14:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1516995820;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=xatr2BJum8Cs6FBYVsFEDISBZl1tFpNScVLC/xkTOvU=;
        b=JCVn7bByRQeKkOk/rlK8FsmHn+MmShfQVVZDtJGdijo8dRgwLqvciVwbG7mvcn5C
        imcMdoCjssWdmVo0BXUqtDtXvVhoBpzSCXll6zRnPNqHzojDzYN1z0LHK2mItEbppRJ
        0Qc2+qFRsA6GlZCI31O6m9bCTCEITGeJd5gTBBqI=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016133ff3b7d-d733e1b6-eb98-4033-ba86-83fc6323887b-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 22/24] for-each-ref: tests for new atoms added
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Jan 2018 19:43:40 +0000
X-SES-Outgoing: 2018.01.26-54.240.7.17
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
