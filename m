Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A4A91F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 20:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbcG3UT6 (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 16:19:58 -0400
Received: from mout1.wup.tal.de ([195.8.227.225]:54354 "EHLO mout1.wup.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753295AbcG3UT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 16:19:57 -0400
Received: from point.localnet (mue-88-130-73-059.dsl.tropolys.de [88.130.73.59])
	(Authenticated sender: ib@wtal.de)
	by smtp.tal.de (Postfix) with ESMTPA id 3F92F8001529;
	Sat, 30 Jul 2016 22:19:53 +0200 (CEST)
Received: from ib by point.localnet with local (masqmail 0.2.30) id
 1bTajg-0hk-00; Sat, 30 Jul 2016 22:19:52 +0200
Message-ID: <579d0a83.7ea9341c.bm001@wupperonline.de>
From:	=?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
To:	git@vger.kernel.org
Subject: [PATCH v3 2/3] t3700: merge two tests into one
Date:	Sat, 30 Jul 2016 22:13:48 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: blueMail/Linux 1.5
Cc:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Depending on the underlying platform a chmod may be a noop. Although it
wouldn't harm the result of the '--chmod=-x' test, there is a more
robust way to make sure the --chmod option works both ways.

Merge the two separate tests for the --chmod option into one, checking
both permissions on the same file.

Signed-off-by: Ingo Brückl <ib@wupperonline.de>
---
 t/t3700-add.sh | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 494f5b8..1fa5dfd 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -332,24 +332,18 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file out
 	test_i18ncmp expect.err actual.err
 '

-test_expect_success 'git add --chmod=+x stages a non-executable file with +x' '
+test_expect_success 'git add --chmod=[+-]x stages correctly' '
 	rm -f foo1 &&
 	echo foo >foo1 &&
 	git add --chmod=+x foo1 &&
 	case "$(git ls-files --stage foo1)" in
 	100755" "*foo1) echo pass;;
 	*) echo fail; git ls-files --stage foo1; (exit 1);;
-	esac
-'
-
-test_expect_success 'git add --chmod=-x stages an executable file with -x' '
-	rm -f xfoo1 &&
-	echo foo >xfoo1 &&
-	chmod 755 xfoo1 &&
-	git add --chmod=-x xfoo1 &&
-	case "$(git ls-files --stage xfoo1)" in
-	100644" "*xfoo1) echo pass;;
-	*) echo fail; git ls-files --stage xfoo1; (exit 1);;
+	esac &&
+	git add --chmod=-x foo1 &&
+	case "$(git ls-files --stage foo1)" in
+	100644" "*foo1) echo pass;;
+	*) echo fail; git ls-files --stage foo1; (exit 1);;
 	esac
 '

--
2.9.2
