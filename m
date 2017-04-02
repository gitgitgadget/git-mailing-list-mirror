Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFAFE20966
	for <e@80x24.org>; Sun,  2 Apr 2017 19:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbdDBTGW (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 15:06:22 -0400
Received: from mout.gmx.net ([212.227.15.18]:50429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751541AbdDBTGV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 15:06:21 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LcSAg-1cEa2p1rOA-00joJK; Sun, 02
 Apr 2017 21:06:17 +0200
Date:   Sun, 2 Apr 2017 21:06:15 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/8] t0006 & t5000: prepare for 64-bit timestamps
In-Reply-To: <cover.1491159939.git.johannes.schindelin@gmx.de>
Message-ID: <83688a824b97d99b5a7476501b71b3d40eabe957.1491159939.git.johannes.schindelin@gmx.de>
References: <cover.1488231002.git.johannes.schindelin@gmx.de> <cover.1491159939.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:El+eE5H5sQuBm3tBpbl7wbgdAvyiJW+fm6wpA1TB+WybVsE9yeA
 MlGir+wJQXjRGsEAI3p7nFb0s7NrVAxClRNXLhNbOCQpQtYUuXZaigTi95h/t+TCWz4FwdM
 WBUMu1qX7xljH9KT0dUr/kBhelj6vjMmWzKmnIUrN2b8W7PHOtBcJBI1k1bfIqZElO6zS2D
 tij6FNJ/pFT73l5/hmrxw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3TJQceB0czE=:VtDhx+VvhIHQwGYjlJZ5fL
 cyBu5BkMI/BkZmdlbixZXvMcdG6wlQVYw+kc4KZRQq9TCFvgbI2zgCoIQtjGjcbFUdrzRsbqZ
 AGp3CK8YUB85LG5cp/yfU/fdjzQvxWaPDbbHOqYtPMY+zuTuBlB9aknMFgba8wPJA58AhIgZT
 b27NyEiWmO60/iXhEdj5g8NS9M7uyYlnWaG2rU8zGQrbvfspNRRRnHU88hdMHvAVukY1jQELE
 PuU0hi+PzjsJirO7fqiBweOWwkcOWYVRwzPVwGRwnXTBINtRbdUf/GHmgAjgKAMoQ2RrlaUkc
 qyMFhkUt+rkMiLwuWbIelzi2pNaUiZhQhzOJAmUgtTxgJqOBMtpZjee4qjX5iUVhD3QaiAkVu
 g8AFjg/zNNjW7HXogEC+Ll1OpqeeJf7a+xml+5AHt0SrG69H4YgyVa1Yf52+4J/YGpLuCvfon
 xRhbCvgcBYaupfDpADRc+9b8pW1iMyIqN7KEUrCTQ1xifQ7fnToN540FXRcU3/OKMsDmPxDJJ
 b6bYyw8usUbm/uvuYAuCeOOW/AVKoypOyseC4lXOjg0smGo1dkSaL/AzHGLFXBoFRrtYSEc2j
 8JGk2kLQfR2CGIxfU5CHKnoUFpn/Nd5QFPonZl++COr+zdMApFTxy/It3rvsJh5T6dQI7lChi
 AP9Jm5q7/ilqfSR6a5bcw0cd44kiqWfdnsb+CjeQwgZ1Hf40FaqJOgcS0/ZG15DOY0+l+El1J
 1xCfLd/Ygf26pZ/deRjAu2OaRXEROB1p12AKJsBIrGhJraoVA6HTLrBnhEJWlkOMAvKern5NR
 YPdYe+5
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
2.12.2.windows.1


