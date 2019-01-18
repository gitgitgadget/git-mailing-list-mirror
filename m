Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78B871F454
	for <e@80x24.org>; Fri, 18 Jan 2019 22:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbfARW0c (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 17:26:32 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:42770 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729933AbfARW0c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 17:26:32 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id A00991F453;
        Fri, 18 Jan 2019 22:26:31 +0000 (UTC)
Date:   Fri, 18 Jan 2019 22:26:29 +0000
From:   Eric Wong <e@80x24.org>
To:     David Turner <novalis@novalis.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] t1512: test ambiguous cat-file --batch and --batch-output
Message-ID: <20190118222629.3nvcos24gmi6xe4i@dcvr>
References: <20190118033845.s2vlrb3wd3m2jfzu@dcvr>
 <a7307f431e2231dd420a0190a22aa38094cd593f.camel@novalis.org>
 <20190118104519.fqpzirux5qulkcwa@dcvr>
 <672a6fb9e480becbfcb5df23ae37193784811b6b.camel@novalis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <672a6fb9e480becbfcb5df23ae37193784811b6b.camel@novalis.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <novalis@novalis.org> wrote:
> Let's try this version.

Thanks!

Tested-by: Eric Wong <e@80x24.org>

Not sure if t1512 would be the best place to put the test, but
having a repo with ambiguous data already at hand was easiest.

---------8<-------
Subject: [PATCH] t1512: test ambiguous cat-file --batch and --batch-output

Test the new "ambiguous" result from cat-file --batch and
--batch-check.  This is in t1512 instead of t1006 since
we need a repo with ambiguous object_id names.

Signed-off-by: Eric Wong <e@80x24.org>
---
 t/t1512-rev-parse-disambiguation.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index e4d5b56014..b0819630c9 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -388,4 +388,14 @@ test_expect_success C_LOCALE_OUTPUT 'ambiguous commits are printed by type first
 	done
 '
 
+test_expect_success 'cat-file --batch and --batch-check show ambiguous' '
+	echo "0000 ambiguous" >expect &&
+	echo 0000 | git cat-file --batch-check >actual 2>err &&
+	test_cmp expect actual &&
+	grep hint: err &&
+	echo 0000 | git cat-file --batch >actual 2>err &&
+	test_cmp expect actual &&
+	grep hint: err
+'
+
 test_done
-- 
EW
