Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E13FF207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 20:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S946969AbdDTU63 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 16:58:29 -0400
Received: from mout.gmx.net ([212.227.15.19]:57876 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S943457AbdDTU62 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 16:58:28 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0Ppl-1c9M7W1yer-00uclC; Thu, 20
 Apr 2017 22:58:23 +0200
Date:   Thu, 20 Apr 2017 22:58:21 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 3/8] t0006 & t5000: skip "far in the future" test when
 time_t is too limited
In-Reply-To: <cover.1492721487.git.johannes.schindelin@gmx.de>
Message-ID: <31900a70120b443f90dd52b5fb653f62895b104d.1492721487.git.johannes.schindelin@gmx.de>
References: <cover.1491159939.git.johannes.schindelin@gmx.de> <cover.1492721487.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:oVInKAvl9C0D9FcdbczM9zxFPnMCYbZlMhSZq7Uc8LjCJ0AyXV5
 ezZ5XM8c+0nJWDqWdF8V0MUC4IVIoCPavDgsdOUhseK0E31LiX0ZgOCc4QFy5qxkTqrUMal
 7doYedTDXaUy3VO4hXdWESiQllbIofJyWEiLXjrvrNj3RoUbJiB/FrdOdvp/zuSOY5WTLGO
 9XRcc3yj4U3d4utGsKL4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uh5Mcje5GE0=:KPcBm2XTqh0xf9V+5YP5YA
 EUkJEgU0CrkhY9U0FlxZnFGHt3+ecFRFbztAJzd0RVVU4sEuxheLYIofqs8EL1LOK0cdfo7+U
 9BKPpj9OLn+b55vnYJwEkpbWN9CrfLTQwLXdU0h074Y7G4uye/OUsZXMZdGLYjLJrT3/a7gXk
 IaDbTnmb0fZ2SB6KdZBwnvdisY/oQ+1yf9r99UWh2Uh0qGsPIbvBEQuZuOX7JzOcrRRFsPg92
 3zEBUEMXPje5dv/x3Wre/R8P5swrw/7rEbXsJY7u2hEPKe7fKDmGKmrzUyFnXoNsvplkF3o/p
 6Wc8pPnS4BJN3IzPDlgGo20HFDdxfzmZqQJvvbjUCJdVAuc590OCEAkWvv8pDvLYVgPOLSG5g
 G1tJ+IoaK3q5lz287vTwNGiHjtZ58m10WWJbyDltwiNHzeT8/u3HP/pAq8JG+DM2vENaEdnnE
 BOGOZo7I5qw3g31K5nlHgFEkEOWm9OzPpHfZWg5ZE542KFpSBn1yMaT0A6WNKl5rC4XXLu4Vd
 5Peg1RhGJAuOO6iYXBp1R5ZlQLzefDOs2bL2767SIIIJiHWRNdDJOy81bBYg8AIsU86DzZZ1G
 ePhjl2n5X1dmc9NtqfLZEqkzJHOB1AJmTJjNBKlf0HWvw9rm3T+bwztZB7BjxZlVsKHkqZLHI
 t3ondEGWq13UmbZg1MdFioQscvq8E+N1JyADJoVZrlMQeCZFnbTePTz3I8/eUpgGs18hOA/A5
 H4JTdQ52ZsHtf+uYy2j1wGmYxwUx9Oz7ySAgW1MFewiWSHGncK47HPTtO4AOSD2ZT0pYiyiPg
 Z7mQ39p
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
2.12.2.windows.2.406.gd14a8f8640f


