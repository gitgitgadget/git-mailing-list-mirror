Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 554E520966
	for <e@80x24.org>; Sun,  2 Apr 2017 19:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbdDBTGl (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 15:06:41 -0400
Received: from mout.gmx.net ([212.227.15.15]:64675 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751618AbdDBTGk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 15:06:40 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mbwm6-1cejso0ZFO-00JFsC; Sun, 02
 Apr 2017 21:06:36 +0200
Date:   Sun, 2 Apr 2017 21:06:20 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/8] t0006 & t5000: skip "far in the future" test when
 time_t is too limited
In-Reply-To: <cover.1491159939.git.johannes.schindelin@gmx.de>
Message-ID: <f78a0270f1cadd3228006ce81c217ad5c3f9bedb.1491159939.git.johannes.schindelin@gmx.de>
References: <cover.1488231002.git.johannes.schindelin@gmx.de> <cover.1491159939.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iGBWwtqoXNyDonPJ+TtUac48H02SM94hHRDPbuO8cP0Ln+KW3ea
 uJlDixLfe3f5VX9UyHGJ+M/2oheR1q3nB5DTLhrS0jO3x/QzmT23mwM8eSQkFUulLmtwJZ+
 glnA1O8XFITn+PNkAH4Fo+BK67xZ9qvmbGgglLZ9jqmYHSGgr8BUd3hswvbJpXpHkpopl2G
 RP7ID+WPJgLPzKp8WTHxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KV8+05bCUUI=:62mX8kbOG9F+spveI/x30V
 VdrSq5B/vtFhGaMqIw9ezQClzjrtkD4fjDsd6O0Ac94H8oTyhPiWW79j6UxqpTNdafKxJQ2bt
 xl0jeBQ5Z9IFbFUiRp+uE7gGpc7TVz1QcaYRRmEN9t5nJ9yzInP7HBgaChQhYQ26C04zgpd/e
 qwuxCx7JlHNZoxXOxBIf2Q2t9X2J/qXp8SR482USe4AxdV+TaNjwvdj2Yglk1NKLybnxA3tiU
 JEqj3JC3yjxESIJCkWiMT1X8CntKTJD7m6bZX8qKpiqBJJByKZpH+S/1F3psqxOSBTkHNaLfI
 LdfNM3sqeSaKF66WKjPkqLQMOMjNsHXmz3dBjsqoqQ5nRG+JWkLiMIFX1bY0LnTu7pdUY5EnX
 pyZK41bN7uHvDPAkreW9J0xoHnvmLkMOXed2Zl912Se81UchU5R7UAvWm8Ubb+9g7tTJdW6hU
 m/mnwtqx5goinhWS9rTXwdB2yaoRsaSkJml4QI/Z1Drystkfs3LNDOO6arB1fuT04DkgDgfxk
 GD8I2ufDSlEakwQ6ZR9kQ7N4ky+2Zrpy5yjQ9scwWHfIQ81NYMk8vZvdrTj3gc6sTVtiBSKxu
 S6TG+RC/iFKu/gZOLJw4rEW7VI9gM8B6V/WosA3XCc4MkyksRSdssabazxu7SxssPy7m67Sy8
 xf081C+uDUG7Tnr0RxiwLsyZStgyv73GzfJtQ5Gc6VGD1ctWLMXMPUMVgyLKjPsciYwOTlow+
 oXsCWLKwWuIigJ2nDuBMMX+dI1ypkCt7JX3QOeF3FK07hdqEmCpnEIeZA4XzXhUl0IsgXBVmv
 OVWeKtt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git's source code refers to timestamps as unsigned long, which is
ill-defined, as there is no guarantee about the number of bits that
data type has.

In preparation of switching to another data type that is large enough
to hold "far in the future" dates, we need to prepare the t0006-date.sh
script for the case where we *still* cannot format those dates if the
system library uses 32-bit time_t.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 t/helper/test-date.c | 5 ++++-
 t/t0006-date.sh      | 4 ++--
 t/t5000-tar-tree.sh  | 2 +-
 t/test-lib.sh        | 1 +
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 4727bea255c..ac7c66c733b 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -5,7 +5,8 @@ static const char *usage_msg = "\n"
 "  test-date show:<format> [time_t]...\n"
 "  test-date parse [date]...\n"
 "  test-date approxidate [date]...\n"
-"  test-date is64bit\n";
+"  test-date is64bit\n"
+"  test-date time_t-is64bit\n";
 
 static void show_relative_dates(const char **argv, struct timeval *now)
 {
@@ -96,6 +97,8 @@ int cmd_main(int argc, const char **argv)
 		parse_approxidate(argv+1, &now);
 	else if (!strcmp(*argv, "is64bit"))
 		return sizeof(unsigned long) == 8 ? 0 : 1;
+	else if (!strcmp(*argv, "time_t-is64bit"))
+		return sizeof(time_t) == 8 ? 0 : 1;
 	else
 		usage(usage_msg);
 	return 0;
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 9539b425ffb..42d4ea61ef5 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -53,8 +53,8 @@ check_show unix-local "$TIME" '1466000000'
 
 # arbitrary time absurdly far in the future
 FUTURE="5758122296 -0400"
-check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" TIME_IS_64BIT
-check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" TIME_IS_64BIT
+check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" TIME_IS_64BIT,TIME_T_IS_64BIT
+check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" TIME_IS_64BIT,TIME_T_IS_64BIT
 
 check_parse() {
 	echo "$1 -> $2" >expect
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 997aa9dea28..fe2d4f15a73 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -402,7 +402,7 @@ test_expect_success TIME_IS_64BIT 'generate tar with future mtime' '
 	git archive HEAD >future.tar
 '
 
-test_expect_success TAR_HUGE,TIME_IS_64BIT 'system tar can read our future mtime' '
+test_expect_success TAR_HUGE,TIME_IS_64BIT,TIME_T_IS_64BIT 'system tar can read our future mtime' '
 	echo 4147 >expect &&
 	tar_info future.tar | cut -d" " -f2 >actual &&
 	test_cmp expect actual
diff --git a/t/test-lib.sh b/t/test-lib.sh
index beee1d847ff..8d25cb7c183 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1166,3 +1166,4 @@ test_lazy_prereq LONG_IS_64BIT '
 '
 
 test_lazy_prereq TIME_IS_64BIT 'test-date is64bit'
+test_lazy_prereq TIME_T_IS_64BIT 'test-date time_t-is64bit'
-- 
2.12.2.windows.1


