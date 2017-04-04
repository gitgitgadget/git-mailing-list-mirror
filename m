Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BE3C20966
	for <e@80x24.org>; Tue,  4 Apr 2017 06:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752497AbdDDGgx (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 02:36:53 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:55204 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751173AbdDDGgo (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Apr 2017 02:36:44 -0400
X-AuditID: 12074412-4a3ff70000000b04-60-58e33ef9cba0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 1B.C6.02820.9FE33E85; Tue,  4 Apr 2017 02:36:43 -0400 (EDT)
Received: from bagpipes.fritz.box (p579063C2.dip0.t-ipconnect.de [87.144.99.194])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v346acsO000999
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 4 Apr 2017 02:36:40 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Daniel Ferreira <bnmvco@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v7 4/5] dir_iterator: refactor state machine model
Date:   Tue,  4 Apr 2017 08:36:35 +0200
Message-Id: <bfd5d9a07139dbc6eb1fd1dc82ffb38dbbefee1e.1491286711.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CAEA2_R+EBbrD1rbcrP598AKJAEZDZfGY-ED8g+ehgAaL9tLG8A@mail.gmail.com>
References: <CAEA2_R+EBbrD1rbcrP598AKJAEZDZfGY-ED8g+ehgAaL9tLG8A@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsUixO6iqPvb7nGEwa+f0haPP71ls+i60s1k
        cXvFfGaLzZvbWRxYPP6+/8DksXPWXXaPBZtKPT5vkgtgieKySUnNySxLLdK3S+DK+HrjCkvB
        Q5WKmQeWszYwLpTrYuTkkBAwkZjRdpW9i5GLQ0hgB5PE9bdXWUESQgInmCROTOYHsdkEdCUW
        9TQzdTFycIgIqEnM2mQIEmYWyJXYsO8UE4gtLOAmsePxdrBWFgFVic9Tj7OB2LwCURL7N+5n
        gtglL7Gr7SJYDadAoMT57UuYIVYFSGzc+JJpAiPPAkaGVYxyiTmlubq5iZk5xanJusXJiXl5
        qUW6Znq5mSV6qSmlmxghISK0g3H9SblDjAIcjEo8vB4OjyKEWBPLiitzDzFKcjApifLyWD6O
        EOJLyk+pzEgszogvKs1JLT7EKMHBrCTC+00BKMebklhZlVqUD5OS5mBREuf9uVjdT0ggPbEk
        NTs1tSC1CCYrw8GhJMG7ywaoUbAoNT21Ii0zpwQhzcTBCTKcB2h4hS3I8OKCxNzizHSI/ClG
        RSlx3tUgCQGQREZpHlwvLIZfMYoDvSLM+xqkigcY/3Ddr4AGMwENfnLnIcjgkkSElFQD4/aZ
        K1SL5EM1AhkF9NoPMMZpfk4JWzl1VVNbSdQO/aelOtr8+drsWjc59rMl1dwpqda4fD5f99hM
        GabHM+ZWnn54YH1hxM/d4bmzr674xJt49Y3HjuPG73ZHVC+4XeYjkSbyo/Nv3I9FuitXK617
        dtiiTCBch3GmiLfOzeYFbzISf8/2Ffq0QImlOCPRUIu5qDgRAPDtrhm8AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Daniel,

> Although it does make tests harder to understand, if we were to
> specify how to iterate with human-readable flags we'd add the getopt()
> + flag configuration overhead to this helper program to be able to
> handle all cases properly. Additionally, new flags added to
> dir_iterator would have to edit the test program as well, generating
> extra work.

I think you're exaggerating the amount of extra work. I think all you
need to do is squash the attached patch into your patch 4/5, for the
gain of only 14 lines of simple code, four of which could be deleted
if you don't care about supporting "--". Supporting hypothetical
future new options would cost exactly two more lines for each option.
Plus, this also fixes the handling of more than two args.

It might be even shorter if you use `parse_options()`, but that seems
like overkill here.

On the plus side, anybody can now change the `DIR_ITERATOR_*`
constants without breaking things, or grep for them to find all of the
places that they are used. Plus the test code is more readable.

In my opinion that is a win.

Michael

 t/helper/test-dir-iterator.c | 28 +++++++++++++++++++++-------
 t/t0065-dir-iterator.sh      | 10 +++++-----
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
index a1b8c78434..c2eb2ca1f9 100644
--- a/t/helper/test-dir-iterator.c
+++ b/t/helper/test-dir-iterator.c
@@ -4,18 +4,32 @@
 #include "dir-iterator.h"
 
 int cmd_main(int argc, const char **argv) {
+	const char **myargv = argv;
+	int myargc = argc;
 	struct strbuf path = STRBUF_INIT;
 	struct dir_iterator *diter;
-	unsigned flag = DIR_ITERATOR_PRE_ORDER_TRAVERSAL;
-
-	if (argc < 2) {
-		return 1;
+	unsigned flag = 0;
+
+	while (--myargc && starts_with(*++myargv, "--")) {
+		if (!strcmp(*myargv, "--pre-order")) {
+			flag |= DIR_ITERATOR_PRE_ORDER_TRAVERSAL;
+		} else if (!strcmp(*myargv, "--post-order")) {
+			flag |= DIR_ITERATOR_POST_ORDER_TRAVERSAL;
+		} else if (!strcmp(*myargv, "--list-root-dir")) {
+			flag |= DIR_ITERATOR_LIST_ROOT_DIR;
+		} else if (!strcmp(*myargv, "--")) {
+			myargc--;
+			myargv++;
+			break;
+		} else {
+			die("Unrecognized option: %s", *myargv);
+		}
 	}
 
-	strbuf_add(&path, argv[1], strlen(argv[1]));
+	if (myargc != 1)
+		die("expected exactly one non-option argument");
 
-	if (argc == 3)
-		flag = atoi(argv[2]);
+	strbuf_addstr(&path, *myargv);
 
 	diter = dir_iterator_begin(path.buf, flag);
 
diff --git a/t/t0065-dir-iterator.sh b/t/t0065-dir-iterator.sh
index ade3ee0e7e..4819e6181d 100755
--- a/t/t0065-dir-iterator.sh
+++ b/t/t0065-dir-iterator.sh
@@ -28,7 +28,7 @@ test_expect_success 'dir-iterator should iterate through all files' '
 	>dir/a/e &&
 	>dir/d/e/d/a &&
 
-	test-dir-iterator ./dir 1 | sort >./actual-pre-order-sorted-output &&
+	test-dir-iterator --pre-order ./dir | sort >./actual-pre-order-sorted-output &&
 	rm -rf dir &&
 
 	test_cmp expect-sorted-output actual-pre-order-sorted-output
@@ -44,7 +44,7 @@ test_expect_success 'dir-iterator should iterate through all files on post-order
 	>dir/a/e &&
 	>dir/d/e/d/a &&
 
-	test-dir-iterator ./dir 2 | sort >actual-post-order-sorted-output &&
+	test-dir-iterator --post-order ./dir | sort >actual-post-order-sorted-output &&
 	rm -rf dir &&
 
 	test_cmp expect-sorted-output actual-post-order-sorted-output
@@ -61,7 +61,7 @@ test_expect_success 'dir-iterator should list files properly on pre-order mode'
 	mkdir -p dir/a/b/c/ &&
 	>dir/a/b/c/d &&
 
-	test-dir-iterator ./dir 1 >actual-pre-order-output &&
+	test-dir-iterator --pre-order ./dir >actual-pre-order-output &&
 	rm -rf dir &&
 
 	test_cmp expect-pre-order-output actual-pre-order-output
@@ -78,7 +78,7 @@ test_expect_success 'dir-iterator should list files properly on post-order mode'
 	mkdir -p dir/a/b/c/ &&
 	>dir/a/b/c/d &&
 
-	test-dir-iterator ./dir 2 >actual-post-order-output &&
+	test-dir-iterator --post-order ./dir >actual-post-order-output &&
 	rm -rf dir &&
 
 	test_cmp expect-post-order-output actual-post-order-output
@@ -100,7 +100,7 @@ test_expect_success 'dir-iterator should list files properly on pre-order + post
 	mkdir -p dir/a/b/c/ &&
 	>dir/a/b/c/d &&
 
-	test-dir-iterator ./dir 7 >actual-pre-order-post-order-root-dir-output &&
+	test-dir-iterator --pre-order --post-order --list-root-dir ./dir >actual-pre-order-post-order-root-dir-output &&
 	rm -rf dir &&
 
 	test_cmp expect-pre-order-post-order-root-dir-output actual-pre-order-post-order-root-dir-output
-- 
2.11.0

