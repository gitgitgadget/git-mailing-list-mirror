Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A73FF20195
	for <e@80x24.org>; Fri, 22 Jul 2016 12:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942AbcGVMZJ (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 08:25:09 -0400
Received: from mout.gmx.net ([212.227.17.22]:54566 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753876AbcGVMZH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 08:25:07 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MGEv5-1bVoyQ0If1-00FCEu; Fri, 22 Jul 2016 14:24:53
 +0200
Date:	Fri, 22 Jul 2016 14:24:48 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v4 01/16] Verify that `git pull --rebase` shows the helpful
 advice when failing
In-Reply-To: <cover.1469187652.git.johannes.schindelin@gmx.de>
Message-ID: <37e2f36e4f982261a741e327f1b534cb67b65149.1469187652.git.johannes.schindelin@gmx.de>
References: <cover.1467902082.git.johannes.schindelin@gmx.de> <cover.1469187652.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RljCBc4bKrF19zruhv2n6S6TXZ9kF1uLJap6tX8qLImEQW56qe/
 qVgQokHfaQRJLtw2II90db5SFYfRnSk22LDrrLqbV2a6QIogoB7GbnSRoJIpWXSaLDJYNPu
 Ab2Rn+k0RKrbYJgyMPn+LPQOKxpwhZNc4rM7eAewn21jcvVfqfIQRu0I4r2mxdOzbLzlYNf
 LYZWfgCL3AXMULoVjTV2A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:VAliHYReNIQ=:poKRFm5i9KVdR2p2ph2/3s
 pQX84hsEgFt/hsjboEn3uEwE+89KIcbMpO3/p0ll+xsZgD5DEiCrCiL+WJoBp6f1UkrfUsFEZ
 bAgeIsG2+QkUx4myQOQAwIn6ikcimbrcf6dpHnDt7fxqkSchu/7q0t6UsRan/gl2NE/ln9p5g
 dgF0oEV5DVmGJ93Y7g8ooEnXK5W0+kvPoaHD7QJOdY1Rm63GP4aSiaObNPTcFlhTvP4rrpDGG
 pPI7DKoKpTEGtKNWLZnjjXG9I1ZsqB73+0dwJm/3lQwRZc/ADKuFGLbfDjL3Cnh3HeFqgP9Yw
 QUcZuh6xnFpZqRAL4dtZ0dlOC0USRbYILD5qyeGijAZK17ujwyd55/mU9FbG5uRDpWG/LhYQI
 7/eXVbnxuem6c9qk1f29farskhpHnlCeqdcGySff3XxlXlCJQ2PHj/iTPPOS2R7ojQgyRGjC/
 mvAwR7i9xv6JvovPTD1rrEjKcoo2O3UC2Pd4MtV2s7qLQcEN389QQVPCedVjd28O5VhgPJCtV
 I7vznCMIKmwm5TMc6xbsxWQtFLndy5/fRB/uNgbLfke4tz9Bv2tf743qTCKqDF6zu/jzR2OZw
 aBkHHV9++i5Qt06nhueEIVf92fo37HLJdd9bjrqoYZLrJi/UplF8j2FFOAvq2KFoOHwFalRw8
 urC7n2GCNiMO4Am3x2H0fJWF2jOt58/K6Yy/AI5FPH489gMzKRw69yZu5m4KN+kE5V3RdNWRP
 fbRFQQLRgUVuWkmc01yKFoE2dqA3TT39mUYvGAS+MigVkr98dF6Jch8oRHyoLFjM1sq2f3tQM
 zhPrivi
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
 t/t5520-pull.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 37ebbcf..d289056 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -255,6 +255,36 @@ test_expect_success '--rebase' '
 	test new = "$(git show HEAD:file2)"
 '
 
+test_expect_success '--rebase with conflicts shows advice' '
+	test_when_finished "git rebase --abort; git checkout -f to-rebase" &&
+	git checkout -b seq &&
+	printf "1\\n2\\n3\\n4\\n5\\n" >seq.txt &&
+	git add seq.txt &&
+	test_tick &&
+	git commit -m "Add seq.txt" &&
+	printf "6\\n" >>seq.txt &&
+	test_tick &&
+	git commit -m "Append to seq.txt" seq.txt &&
+	git checkout -b with-conflicts HEAD^ &&
+	printf "conflicting\\n" >>seq.txt &&
+	test_tick &&
+	git commit -m "Create conflict" seq.txt &&
+	test_must_fail git pull --rebase . seq 2>err >out &&
+	grep "When you have resolved this problem" out
+'
+test_expect_success 'failed --rebase shows advice' '
+	test_when_finished "git rebase --abort; git checkout -f to-rebase" &&
+	git checkout -b diverging &&
+	test_commit attributes .gitattributes "* text=auto" attrs &&
+	sha1="$(printf "1\\r\\n" | git hash-object -w --stdin)" &&
+	git update-index --cacheinfo 0644 $sha1 file &&
+	git commit -m v1-with-cr &&
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


