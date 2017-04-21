Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1E371FE90
	for <e@80x24.org>; Fri, 21 Apr 2017 10:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1037695AbdDUKpo (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 06:45:44 -0400
Received: from mout.gmx.net ([212.227.17.21]:65248 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S971323AbdDUKpn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 06:45:43 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M7DVi-1c7mY01eHW-00x3YE; Fri, 21
 Apr 2017 12:45:38 +0200
Date:   Fri, 21 Apr 2017 12:45:36 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v4 2/9] t0006 & t5000: prepare for 64-bit timestamps
In-Reply-To: <cover.1492771484.git.johannes.schindelin@gmx.de>
Message-ID: <4061101de2cea4e2b55b6b58bfd4bbd30fe5465e.1492771484.git.johannes.schindelin@gmx.de>
References: <cover.1492721487.git.johannes.schindelin@gmx.de> <cover.1492771484.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:osSHyIAaBJuriIb5QqUGiyuY0ac/OZkYFeZz6AQBg7yfoUmp/Jc
 VCsQG3Xqgaw3pfvVp1Uq8mXfz8T1DhG9MduOurdkheijbxZr1B3JmIbyJvtaU9/w5TaYkrH
 o+NY9Oiaq7msqyIIul2vwYCoBg3MOgaPDHhL2eQwpiWyKWASRxlrWa+oO0KocyoC67aFV+f
 hHi0UFCIq3kIo+byJaEmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7JjiWE7BK0A=:0RfpLJ/Z8n9Gc6iip/7Y2d
 52fSKwGnaWeVvZiWRzzgOVKZhLFsD6zj/vZtqmpYuYn4mU1mL1mGkxO7aGHKBFr5qVeaNZAld
 lQyqM79eKTHNsLvuIv2kPtUbI0grvCJvl48KekBNSyi9wflpAGtpXs5iogtR2lRIFNEXSZH+2
 Hy0OBpvuT/7sfBnMfitCJ8AFa3nttn1lyhk2xX/lAooevVs4km6E7sLlJqKEbWYPbBErbnnLn
 jWZh+4jp50+1TuUvbU24ZLSyhqie9wNtBzannNo1ubYaXoOb9egOZYb3Vq+4P6fwwqULn/D6u
 Cb2rNq6H55eRcpYdzPOVDWbtVscxKSH33SOywRQ1BiBCDgT+Yb9EhSByDbAj7761bdUHl1Ozf
 6wAaRV1kJmLmQNXOMurdSPHGxb8N8AHURngY9XJD6umBYYtYZ/f52y8tP4y+fZbNu0ayZoBLG
 emTZ0RJ4Cl4pFlg4h1wf1yLfpyDOAot/+RpNBG/b5J3exJKcNqq/Z47jpne5IA8c7lQyH+yce
 f8jJDXki7oC9hIeGdmAnr3v8zejoaPbbmwUXIqlLjuJ7bNLtBKqvwt13CHCmTn/2STT8DL+2L
 2wiNrEumjIrpYPLw9Fp3I1l9FyXl4/08Tl/sWTrz7XpEB3Pxn+Mzp1hvKZy5StNvYsg/PWXiD
 qjUi432aK/Vj8m7clGVHcvooaARc40ORQeMQkR82SGG18z9clh+qavtNr1HDir9VG2uaXcBKt
 iV9T/FlC3F1ShirB3BmA2thM1vEkneeptfbRmU6mBO3w26+AFqVsBT5Mv2BxDTkByB/irM49d
 KlS7jLN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git's source code refers to timestamps as unsigned longs. On 32-bit
platforms, as well as on Windows, unsigned long is not large enough to
capture dates that are "absurdly far in the future".

It is perfectly valid by the C standard, of course, for the `long` data
type to refer to 32-bit integers. That is why the `time_t` data type
exists: so that it can be 64-bit even if `long` is 32-bit. Git's source
code simply uses an incorrect data type for timestamps, is all.

The earlier quick fix 6b9c38e14cd (t0006: skip "far in the future" test
when unsigned long is not long enough, 2016-07-11) papered over this
issue simply by skipping the respective test cases on platforms where
they would fail due to the data type in use.

This quick fix, however, tests for *long* to be 64-bit or not. What we
need, though, is a test that says whether *whatever data type we use for
timestamps* is 64-bit or not.

The same quick fix was used to handle the similar problem where Git's
source code uses `unsigned long` to represent size, instead of `size_t`,
conflating the two issues.

So let's just add another prerequisite to test specifically whether
timestamps are represented by a 64-bit data type or not. Later, after we
switch to a larger data type, we can flip that prerequisite to test
`time_t` instead of `long`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-date.c | 5 ++++-
 t/t0006-date.sh      | 4 ++--
 t/t5000-tar-tree.sh  | 6 +++---
 t/test-lib.sh        | 2 ++
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 506054bcd5d..4727bea255c 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -4,7 +4,8 @@ static const char *usage_msg = "\n"
 "  test-date relative [time_t]...\n"
 "  test-date show:<format> [time_t]...\n"
 "  test-date parse [date]...\n"
-"  test-date approxidate [date]...\n";
+"  test-date approxidate [date]...\n"
+"  test-date is64bit\n";
 
 static void show_relative_dates(const char **argv, struct timeval *now)
 {
@@ -93,6 +94,8 @@ int cmd_main(int argc, const char **argv)
 		parse_dates(argv+1, &now);
 	else if (!strcmp(*argv, "approxidate"))
 		parse_approxidate(argv+1, &now);
+	else if (!strcmp(*argv, "is64bit"))
+		return sizeof(unsigned long) == 8 ? 0 : 1;
 	else
 		usage(usage_msg);
 	return 0;
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index c0c910867d7..9539b425ffb 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -53,8 +53,8 @@ check_show unix-local "$TIME" '1466000000'
 
 # arbitrary time absurdly far in the future
 FUTURE="5758122296 -0400"
-check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" LONG_IS_64BIT
-check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" LONG_IS_64BIT
+check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" TIME_IS_64BIT
+check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" TIME_IS_64BIT
 
 check_parse() {
 	echo "$1 -> $2" >expect
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 886b6953e40..997aa9dea28 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -390,7 +390,7 @@ test_expect_success TAR_HUGE,LONG_IS_64BIT 'system tar can read our huge size' '
 	test_cmp expect actual
 '
 
-test_expect_success LONG_IS_64BIT 'set up repository with far-future commit' '
+test_expect_success TIME_IS_64BIT 'set up repository with far-future commit' '
 	rm -f .git/index &&
 	echo content >file &&
 	git add file &&
@@ -398,11 +398,11 @@ test_expect_success LONG_IS_64BIT 'set up repository with far-future commit' '
 		git commit -m "tempori parendum"
 '
 
-test_expect_success LONG_IS_64BIT 'generate tar with future mtime' '
+test_expect_success TIME_IS_64BIT 'generate tar with future mtime' '
 	git archive HEAD >future.tar
 '
 
-test_expect_success TAR_HUGE,LONG_IS_64BIT 'system tar can read our future mtime' '
+test_expect_success TAR_HUGE,TIME_IS_64BIT 'system tar can read our future mtime' '
 	echo 4147 >expect &&
 	tar_info future.tar | cut -d" " -f2 >actual &&
 	test_cmp expect actual
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 13b5696822d..beee1d847ff 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1164,3 +1164,5 @@ build_option () {
 test_lazy_prereq LONG_IS_64BIT '
 	test 8 -le "$(build_option sizeof-long)"
 '
+
+test_lazy_prereq TIME_IS_64BIT 'test-date is64bit'
-- 
2.12.2.windows.2.406.gd14a8f8640f


