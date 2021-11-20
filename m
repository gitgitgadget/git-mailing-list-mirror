Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881FCC433EF
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 15:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbhKTPHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 10:07:30 -0500
Received: from mail-am6eur05hn2201.outbound.protection.outlook.com ([52.100.174.201]:55837
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237584AbhKTPH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 10:07:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N98k653dk3BeNNUyndP9yM0SKBfua2Aa484jhW6OqaKd7LHs6pN9HzXiF7HCxE8xmTgQZPjIMUAyprAhv3HLz1YJCA7IbofbDyFaZlyZpzzUasqjNP9DI5DxlZz2vgu/IHGY5tAxLw/poDpRWH93Ac8TWfQqykTGZA5rFn19M6oCl/j5PEU9to1F4akKijPn+s53pD52XreCR9i08uP65nNl8VErtddvF1EWi0K0o93FIqdHARhSV9O3i3c0+/HCrbDPY/OHo0Mg1GKTR9p7ZKjRkuaibwbjp1l9jbtYgxqmsW/+IDrT2zs4j7twgd9yJDm/kIV9+LVCvL1jRasDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LgFaoN6FCcupxPfPI5EUtDz4GucxIjm9Gepow4e8Hg=;
 b=SvXLmikiwPJppyzxbn4qZGveW0Ynii7bRuDsxpUwvhwu6Pi96OLEDJvRZYETmywbkpUDCeL5kUpY5nprY9v9NzynHeNkanX6EpttD8fSrgoTUN9pjLaHU6MzAM8ozxEkVGIONTv0VpdXWpTzVYWkl8zGT7cdUorMCMWBrdQKTg/QtAkCpJ9LbAqdmLt7PpPnqztuYC8sa2geggbnl4H3EClBopWQOD7hJIrQ+9EKXCRCSECzM1oRqR7eiKI8Mx9kXj+JzyVhF4IAiGdaOLBT/lLuH0soj+HAjk8FCry8eaYqyKAnIqLZ0T4A6zWBQw/pK+tN4H9uRZV6J7EmbN9fcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LgFaoN6FCcupxPfPI5EUtDz4GucxIjm9Gepow4e8Hg=;
 b=XQp0DdcLAPLKnlcH2SbRW1N5tTmd7zm/a2I34U0NnWGojzJdkD8i65o+lM1f/5xkhgR5+J94xtdquGf8ue+mfYNgjmRj+Ax1gs9vMxOnv2mI3BkVYc32YyPfqzRftkv6Dga4P6GCgjhxM62jqjoRtbRQIBDwFSJbMfsN5cy4z6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4799.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:156::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Sat, 20 Nov
 2021 15:04:16 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.024; Sat, 20 Nov 2021
 15:04:15 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v3 3/3] test-lib: make BAIL_OUT() work in tests and prereq
Date:   Sat, 20 Nov 2021 16:04:01 +0100
Message-Id: <20211120150401.254408-4-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211120150401.254408-1-fs@gigacodes.de>
References: <20211117090410.8013-3-fs@gigacodes.de>
 <20211120150401.254408-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0053.eurprd06.prod.outlook.com
 (2603:10a6:20b:463::15) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by AS9PR06CA0053.eurprd06.prod.outlook.com (2603:10a6:20b:463::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Sat, 20 Nov 2021 15:04:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f37e792c-711e-42a4-263b-08d9ac370485
X-MS-TrafficTypeDiagnostic: PAXPR10MB4799:
X-Microsoft-Antispam-PRVS: <PAXPR10MB4799B1F0D65A438608E003C8B69D9@PAXPR10MB4799.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XzRE483nedJLKKO+zXwLQk+wbDXupPd13Kv5IpkbjvE/UYX9A6UT6fsbHWHg?=
 =?us-ascii?Q?F6YL2J2hZQa+Ry/KLGlaLAANyW21Cq5laca3pO86h570Km4+burxgT7VHcfV?=
 =?us-ascii?Q?aSBrhrADe/vm7Dwk0JapCdiTLAmm3m4SDJmn1kedQGXSbVVN51msZJ4PhN6z?=
 =?us-ascii?Q?mFHNgGJcGtKZkw+qTcHPlnxC9Ank/0XLG3IsF7GYDLZ3DwXTRUwur6PG4hGm?=
 =?us-ascii?Q?VfAbQp/UXRI5HAHFEprt5twDMVXqN7tV1yKEEm/372GFTaeP6+n/Qrb7I1w+?=
 =?us-ascii?Q?zKdFtNQUUj7N43h+LhTDvK/EjhWp4aiRsTP0kGUm+xUEach7CUlclal6A/DJ?=
 =?us-ascii?Q?JW+Gt9ZCDFQjNXo5okM1EV8Uut/x/rrklAZzuDVV+YPYi+KY50TILSK+ENOu?=
 =?us-ascii?Q?odkSCt1D/ibuTkfz98nP17jUROrpdrzgPvt5bMT0SnPkZhB+52I+09NM1Y4c?=
 =?us-ascii?Q?e+WKRO8pxiR/xOFP3T9KW6n6vrGlisK+vJhFeAeiuUX+y7dGab+d8zHRFE97?=
 =?us-ascii?Q?xVFJ7knlZaRkjo9X75HwOIYrXDOEwDQ09FW2KXkquT6LiMeyiucBSWdwtrdc?=
 =?us-ascii?Q?bwryXRXYjv7A6GLZ6r0fiiqIwb8ZiVv6CxCe2D9CVGe81jcYLcyOCKU/iGR2?=
 =?us-ascii?Q?X1JgFVbOeXtWIGGSgsS8TCuEWIGMrSjgy9GSstYfFgezRmPl+anyty2hq5wf?=
 =?us-ascii?Q?Ov+Q75Lj5s0uHYGdUnnabHf9cW+rk9ES363YkbjtOjTMmFkE7RMPKe019UlW?=
 =?us-ascii?Q?kzohoCS4Du6Jryf7PWcyDZX5VpJ4b3Rpg/VkYhV/q2AubKT5sPNSfZjfaiGx?=
 =?us-ascii?Q?G5x3LA+aD89KjnHdCht4uUn+7eCBdIuMvmjeqM3xyUT4ad+Fj3BdMYRZU697?=
 =?us-ascii?Q?81syESgY6j8JtyC2zba+FQWg6Str6awo1H/Cs+7dSCPrGOV8E0NOiN0gZEok?=
 =?us-ascii?Q?lmC9+l3H7+QwLjcY/y4puAWrc5/shTsAL/GCLYwVJFatlIDTgfRmztfl8bOW?=
 =?us-ascii?Q?pMK/UZCaWPfNFg7RIqxAxq/BBw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39830400003)(6666004)(107886003)(2906002)(66476007)(316002)(6486002)(2616005)(83380400001)(66946007)(66556008)(186003)(5660300002)(38100700002)(36756003)(8676002)(54906003)(4326008)(6496006)(86362001)(8936002)(508600001)(1076003)(6916009)(52116002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UpPq+RjG/c4+pj4q0lqsFbVxiJXfsCB2PNLnVOE7lSKp+ZdTL6ScpVqslV+2?=
 =?us-ascii?Q?pflY/0u85Wqp/FpJag6DLRzTS75iZHjH2YAsFwecWktyPVxrbI/Cy2ITzzJN?=
 =?us-ascii?Q?SeRa9YWM+0HjokXc4TlCC7btdq886nBmahg51T4A8pngBFak0Ydu0H29en6k?=
 =?us-ascii?Q?6RIbmKWMN0k5VEMe3+yKdPbZkQOi/B+fXHmXutWy7o+al4HaICJ//lhoKkEO?=
 =?us-ascii?Q?iYh7792IuuWdl/oKTmoa3HYMwPFRmyU52MGoweIFPNHtuH4U1eT0dQXFKFLj?=
 =?us-ascii?Q?9y/3UOS1c1Wn8jcuAvJOqZM9ODMozFyWkCLvyZxIHfkod8ZY/ALVkap6XT9L?=
 =?us-ascii?Q?6MFB2+SZzx+TxXVak/OB78lk/lEDLBS+u8Y3VXfYzkvTUOAkqg80gbRlJKdi?=
 =?us-ascii?Q?KXihR4DkZ+ySLiOTpLXdnMLAYGzbbHOwae7NSLXeBKeQG+RNx6w2FF5+QEle?=
 =?us-ascii?Q?6l51XYvjw5cBEjLycLB1Ol8DcZcvDPGau8YcJwsVTfcVjDuVfP1wwjcwbcyQ?=
 =?us-ascii?Q?dW72NHRNLpSVIpwybPpV+qanqXPuW/I51taG7PxIP2VPGp5x4RVv11uwx8mK?=
 =?us-ascii?Q?rgqjbpDgU58TVnK0kbhpZ5iKdK+1CbtRkBlcbPZOB0LzCueVrG0eWmpdrqyi?=
 =?us-ascii?Q?SCAtSo4EPw3VUQVDgH+4h3ZwaBXdEiwac+zKQWpU6a4dhD7aWTjRP4gJ4+AP?=
 =?us-ascii?Q?1s7q+0xav6k8Qb+KrDwGlqZkmL1y71IGLHiPZYzNdBOQfzdnKeSpdzbKPV2R?=
 =?us-ascii?Q?E1bjbWUPWTKcVxOQCqxPPk5kUXITo4jialeZfDvcr/cvyTZwU03tJDLk5vLW?=
 =?us-ascii?Q?Joi+8FoK5Tzel3l11ifg3yPAxjaXY+6pgvQY/otc5vrCi1TG2Z1bGuOgXmh2?=
 =?us-ascii?Q?ciP4O+Oh7SgG+i519y7X3bJH30Prf4tPTeg1HY/q2yCQJwn3oL3oawsxsjLg?=
 =?us-ascii?Q?JFlrzURsUddhGHCergjHsHxBR34KQYzdcDk91x0W0iq8uyUgzsjAEGvt18rC?=
 =?us-ascii?Q?Wow/5zoZWPNLNPe+r4fYJvzlQmusGS47UNo13wrIlNdqgYXXSUx+XBZ7V5Sl?=
 =?us-ascii?Q?oNDFaJ9qkrgfVlVmcQSNiTwYQYrej0djk8t/Kt8k5F9gk+eP43i6AVDInjTi?=
 =?us-ascii?Q?+LUs6K61UsyFJJt7bpQCYqoS2RzE7zphnGp8dNYrQpRDrn6AucckXYAJJVRz?=
 =?us-ascii?Q?vsPUJQn3Mst7lvObfkRufgNGHP4XOrU/wcFldjpVO/KY63R6ZzCscuzQkWdx?=
 =?us-ascii?Q?bFHcrYhQeahW4AaCeIRAC9CbVnyg2ETIKDyde3vyyWMCVZaUt7f5DygNbF6H?=
 =?us-ascii?Q?HUP8iQMVtJVLKuaORXgepaoGArSETsK4+hbIr0QiutKl0is3B47oQ0UwKhBu?=
 =?us-ascii?Q?6b702DEpMQout3PT/2HIx9PvUz/8WeQ7nLgfRkYFnchyucA77uYLHe3nkQMX?=
 =?us-ascii?Q?dv7I5Pg7zPpT5fxDRSF33RL6KkViYuUNq/E0gmineluXMdbRsBIwHX0fbsxV?=
 =?us-ascii?Q?oS9UiS527O0u8F6Lh6AHXeVpMFxkxrO949RJ3n1T+Qiwh6odn/Hwxdf8kRam?=
 =?us-ascii?Q?OQrjcCn7mumX5db1sKEk3xEs/iUPj3UJDhhNPmxyXfbOAGG5WX1E2qmuPUEo?=
 =?us-ascii?Q?6CgJ0rSqBGsOiswmPUpqQpcJmOn0xw+7iMraxRt8b5ZX8eTjzdc76hoF8+FG?=
 =?us-ascii?Q?V2SoQ1ZhtY9IpHnWXPmzgTe1CSNLy7gw2PP6d0BO/WIVz3ctf9BqPO7GhuLg?=
 =?us-ascii?Q?bxPc/N9bZA=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f37e792c-711e-42a4-263b-08d9ac370485
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2021 15:04:14.9545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itZTIkU6jpdtmRX9ziLO0sFLPMWXYyBm3gROccae8juNJKcnyl9IwI5tvGVkoQGEC45Lu9ketU/KX5dCuLbJKLQ+0HQXAWPq0Pbm7dXdSDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4799
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

BAIL_OUT() is meant to abort the whole test run and print a message with
a standard prefix that can be parsed to stdout. Since for every test the
normal fd`s are redirected in test_eval_ this output would not be seen
when used within the context of a test or prereq like we do in
test_have_prereq(). To make this function work in these contexts we move
the setup of the fd aliases a few lines up before the first use of
BAIL_OUT() and then have this function always print to the alias.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/test-lib.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index f61da562f6..96a09a26a1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -589,6 +589,11 @@ USER_TERM="$TERM"
 TERM=dumb
 export TERM USER_TERM
 
+# Set up additional fds so we can control single test i/o
+exec 5>&1
+exec 6<&0
+exec 7>&2
+
 _error_exit () {
 	finalize_junit_xml
 	GIT_EXIT_OK=t
@@ -612,7 +617,7 @@ BAIL_OUT () {
 	local bail_out="Bail out! "
 	local message="$1"
 
-	say_color error $bail_out "$message"
+	say_color error $bail_out "$message" >&5
 	_error_exit
 }
 
@@ -637,9 +642,6 @@ then
 	exit 0
 fi
 
-exec 5>&1
-exec 6<&0
-exec 7>&2
 if test "$verbose_log" = "t"
 then
 	exec 3>>"$GIT_TEST_TEE_OUTPUT_FILE" 4>&3
-- 
2.31.1

