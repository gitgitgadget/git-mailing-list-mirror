Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD6C9211B5
	for <e@80x24.org>; Wed, 30 Jan 2019 21:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732190AbfA3Vdu (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 16:33:50 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:49756 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730971AbfA3Vdu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 16:33:50 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id DD3FB1F453;
        Wed, 30 Jan 2019 21:33:49 +0000 (UTC)
Date:   Wed, 30 Jan 2019 21:33:49 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: [PATCH v2] t1512: test ambiguous cat-file --batch and --batch-output
Message-ID: <20190130213349.h5xiujbbtw4o3i35@dcvr>
References: <20190118033845.s2vlrb3wd3m2jfzu@dcvr>
 <a7307f431e2231dd420a0190a22aa38094cd593f.camel@novalis.org>
 <20190118104519.fqpzirux5qulkcwa@dcvr>
 <672a6fb9e480becbfcb5df23ae37193784811b6b.camel@novalis.org>
 <20190118222629.3nvcos24gmi6xe4i@dcvr>
 <20190123111117.GS840@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190123111117.GS840@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> wrote:
> The 'git cat-file's error message and hints are translated, so they
> should be checked by 'test_i18ngrep' instead of plain old grep.

Thanks, here's v2 with test_i18ngrep

--------8<------
Subject: [PATCH] t1512: test ambiguous cat-file --batch and --batch-output

Test the new "ambiguous" result from cat-file --batch and
--batch-check.  This is in t1512 instead of t1006 since
we need a repo with ambiguous object_id names.

Signed-off-by: Eric Wong <e@80x24.org>
---
 t/t1512-rev-parse-disambiguation.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index e4d5b56014..c19fb500cb 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -388,4 +388,14 @@ test_expect_success C_LOCALE_OUTPUT 'ambiguous commits are printed by type first
 	done
 '
 
+test_expect_success 'cat-file --batch and --batch-check show ambiguous' '
+	echo "0000 ambiguous" >expect &&
+	echo 0000 | git cat-file --batch-check >actual 2>err &&
+	test_cmp expect actual &&
+	test_i18ngrep hint: err &&
+	echo 0000 | git cat-file --batch >actual 2>err &&
+	test_cmp expect actual &&
+	test_i18ngrep hint: err
+'
+
 test_done
-- 
EW
