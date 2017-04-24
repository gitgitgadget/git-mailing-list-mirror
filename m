Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF1E9207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 13:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1171919AbdDXN6S (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 09:58:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:55371 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1171493AbdDXN6H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 09:58:07 -0400
Received: from virtualbox ([95.208.59.55]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJXEd-1d0Bn73RRj-00328E; Mon, 24
 Apr 2017 15:58:02 +0200
Date:   Mon, 24 Apr 2017 15:58:02 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v5 3/8] t0006 & t5000: skip "far in the future" test when
 time_t is too limited
In-Reply-To: <cover.1493042239.git.johannes.schindelin@gmx.de>
Message-ID: <b914a7e5689991edd275086ba299894c2ba4e2f8.1493042239.git.johannes.schindelin@gmx.de>
References: <cover.1492771484.git.johannes.schindelin@gmx.de> <cover.1493042239.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0XY25YGGsim29/b2sp9SlF6hXKZHSXNJLtBOKpQl1+20YgljPwX
 3Et/n9M0+H/x19xdz4Mt8rawBPUlDAMIre4xvL0GYzV3vJhU610UwMfhnKxqnGuDa1WBL7H
 4jeTjH8YYAelvdVwaERdW1IC8tcdj8jT2/Yh6C7Gx231ddQcRiFTiWl1e6+7iMnupP8f+1i
 /o4z8zeBpgCVH/W5KWy8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b3Guwe3/tFw=:6v9E9u/n7jsbeWVBll0q6n
 Tw7q0ZVjU93G6aSbFOIK1toAy2MEbZAFgb8vSVqvngspYPBMgf89hvW8fcsXnG2FJMjqadqbX
 cHxSZ8dIMV6ODmSnBh3xi24s8+UijBRo8N9MTNCopF31+1WXc/qs9CRPVvdip+OrFbyVqm1Pb
 rTPoKklEn8QDeFaXCBwpsPp8kKkef97RRNKbayQDoHLdwX4HvgndOg4PMiDTO8oWHZKd1+t9d
 wk4SPH/agzjk6YD6u7DgGDcL4BAe7MenZuii/HjqMc4K6S34UmTfk4+yGsNN10fN9aVu+3Tzj
 wuTY5KRJSZe9L3ElfBCqE/n/tQSezos7VRb3vVB31aQeTl7N5e4MD7n/hvrXke5zLHXmdiC0s
 K9CMTyI0dA9T6LcF04omH7uo0RxH8MtYSB1fVLFBRTgXTN/y0rqcgXUDfYNXBHX9xmqpVOBWd
 khHtCB2AdWpkFoQYnuQhzbhpx3VOlOmYl5AR+8fnEgC1rIztBGbnKn/yOBk3oSFO5odV9GKgS
 MueQ82kVdFw0L4eaUMtwEnK2JzIQrRLeepC6TZMCgGM6E5lIcI3LnakQ0o/Osmz6aBKVpUrJ+
 HTgluQtDlS3X04flK8zYfmbtXd1n2pR58MSTlFYb5udmh164aIniAd7Kd6NDJD7Ts+4BsTKpD
 7UaP/Bw08HSvppZ4Z091j/U6xmDhjl1/0nF72l7VxaN6izqP2BT5fDAXCo55xpgXVlouWw4aF
 v4y53KVhZHQmgNASYUvapPqkabI1g73an5E9Mlk2fEbW5gsTX8bwf0hlTV3opcmuCpyAvQmQ1
 6/g2tMg
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


