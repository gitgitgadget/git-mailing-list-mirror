Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E54D7203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 16:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755771AbcGZQGS (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 12:06:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:60886 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753112AbcGZQGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 12:06:16 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MUTSJ-1brkiT2phz-00RLa1; Tue, 26 Jul 2016 18:05:58
 +0200
Date:	Tue, 26 Jul 2016 18:05:43 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v5 01/16] t5520: verify that `pull --rebase` shows the helpful
 advice when failing
In-Reply-To: <cover.1469547160.git.johannes.schindelin@gmx.de>
Message-ID: <cf805d9b0f48a475df4dcb98ab3f285d583f6e2a.1469547160.git.johannes.schindelin@gmx.de>
References: <cover.1469187652.git.johannes.schindelin@gmx.de> <cover.1469547160.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3NMD0WCy1xG1gmNEWNBEzSUAEwtZkeVryVSunL1WLkM2PnTpt8n
 bbxP6k+3EOlJSPLhRHQ7O2G3gRK66TaBCgMhk8L9wLuYlp0pI5lll+RDqHha39rcH3O84JI
 IE/opkUdfrQZP+ZI2X/j26Llu18QeYxpvHxx4ciqE7tFjdd6vpX/gyTdSkzKN+igOo+MjE0
 2Zvuhl1W0fqi62vj7T1Ow==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:fI7wqFKiXZs=:i+fyJkyTMrQESQprCZBxn7
 M5FYCYuQbsXmpYsd/Y9ABnJ5kUzq389bXOf4Tea5/P3Eq+lrANbYRWmbvdCI/wK93Lm0+3e1x
 Q/MsUE70jApfqR/KnaoSBZttyn5FxtaseeQJkcoME/Omx9p+npd4p21okzWPKdYIAZNlE+uwg
 drg+LyyBgkL7+HLtIA5/7bdKwfTOiePwxGDnQhrT2KFFYAwibD26/15fqxihBVa2aCYvJX/Yw
 5bFKwkX4r3ail+oav5wzHtUJJSUq7/da2dnmt29RA56m9K8lFPmVs76IbRi9e8570Rj0Ch/UO
 VDUW/QQS83kde+2gobrgAjNWbtnPLngQSeaCwV69DBMGN3dtymv04RLn5ksFjCGFBWXwSVPln
 8PEXdvN802+faDD03COSk+7qEyBQoZyoUXcgM4/QGKvtZDIjK2E0r1IBsjVsGAUGohGqRj5vJ
 h3QejilUVKGmBeb2R1CgdGjhKhz1VV4F1LeMCnJQzBj5HYStKZ51Aw3CYwBJvQZol+5UJgbbR
 fq7yih2d3pP754nXzuid5H6prP6Jh0zPfnYWKtEZcPb0d+y+dudJaxXaXQ1VEoX3FlHQixIxN
 348oX2i5BDYThWNfa+3+Mul+VNgW37s8FjMG3O99fTSnjGXWisTbk69ZXFP/5Xi4dOwFsNIE8
 Dip8LVpaiY83fhJ1ma89bQxzcZJS1vGUBKwOo0dyvO3EVTcS8wQIHJj5W2pmwEWWN2fAuVUAS
 yDF/hmb0bN9dzKoPnIsEcGlP6Uj3poouLD/n7ncXys3Ww5yA5fM135OT/0OFxbh2DtuoPzUTn
 8NDeYB5
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It was noticed by Brendan Forster last October that the builtin `git am`
regressed on that. Our hot fix reverted to spawning the recursive merge
instead of using it as a library function.

As we are about to revert that hot fix, after making the recursive merge a
true library function (i.e. a function that does not die() in case of
"normal" errors), let's add a test that verifies that we do not regress on
the same problem which made the hot fix necessary in the first place.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5520-pull.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 37ebbcf..6ad37b5 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -255,6 +255,38 @@ test_expect_success '--rebase' '
 	test new = "$(git show HEAD:file2)"
 '
 
+test_expect_success '--rebase with conflicts shows advice' '
+	test_when_finished "git rebase --abort; git checkout -f to-rebase" &&
+	git checkout -b seq &&
+	test_seq 5 >seq.txt &&
+	git add seq.txt &&
+	test_tick &&
+	git commit -m "Add seq.txt" &&
+	echo 6 >>seq.txt &&
+	test_tick &&
+	git commit -m "Append to seq.txt" seq.txt &&
+	git checkout -b with-conflicts HEAD^ &&
+	echo conflicting >>seq.txt &&
+	test_tick &&
+	git commit -m "Create conflict" seq.txt &&
+	test_must_fail git pull --rebase . seq 2>err >out &&
+	grep "When you have resolved this problem" out
+'
+
+test_expect_success 'failed --rebase shows advice' '
+	test_when_finished "git rebase --abort; git checkout -f to-rebase" &&
+	git checkout -b diverging &&
+	test_commit attributes .gitattributes "* text=auto" attrs &&
+	sha1="$(printf "1\\r\\n" | git hash-object -w --stdin)" &&
+	git update-index --cacheinfo 0644 $sha1 file &&
+	git commit -m v1-with-cr &&
+	# force checkout because `git reset --hard` will not leave clean `file`
+	git checkout -f -b fails-to-rebase HEAD^ &&
+	test_commit v2-without-cr file "2" file2-lf &&
+	test_must_fail git pull --rebase . diverging 2>err >out &&
+	grep "When you have resolved this problem" out
+'
+
 test_expect_success '--rebase fails with multiple branches' '
 	git reset --hard before-rebase &&
 	test_must_fail git pull --rebase . copy master 2>err &&
-- 
2.9.0.281.g286a8d9


