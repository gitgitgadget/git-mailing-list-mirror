Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594AFC433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C32261B54
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbhKQJHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:07:30 -0500
Received: from mail-ve1eur01hn2212.outbound.protection.outlook.com ([52.100.7.212]:1921
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230064AbhKQJHY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 04:07:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5MEZ+HQeZm45cod+2zFhZCn6VlRsRBwJK4VA6uPsoaI44kDxXrbI0iwU0fdDn0TCU0MZOJyFh2DrZqkOYyBJwKHM3rmte2vRuSd5xsxjfWco74php2j7kXGSi+bSDh0ipVyTE3w7VwBUdfB99xXnGdmuG8yYyBWoChYgjg0e1z7YXIhZEUY8OSurf0T5ZrSwE8P4KSlTnq0Pvv8hNfS6V4WhKPU3qzEdnHe49KOClDYkzUlUNp6gDgZqBuq1htUGatNWtG5JXv3eAeYvuJOCIg6Bfoph8KePQ9sRO95CttdZ7r+TM+dFEDR3baszwVDU8SS8/L8u4Js/dX1MckjVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUJropcqEPF3Zq8STTSSrbFUc6Z0cajKISZOgGBZQX8=;
 b=dj659frPtXaJAYlxSDYMuO8J737leX2+LAohqR4lFPtZWX6MgBFwdy05j2OHEQlE4MW5zL2qJ3BaMPjAAlGR1x/imW2hod1Y1EtacvZMGxrVAvAAxjWFcvkF17fCa4ZXSLiT8ArKINhXVzvyn/mz4NPlLXdnzsVANbB0Sxhp2IUSe4bcdwKF+EKB/XIKEhWd1jrZC2Ulo9dqrYV81ueJOpFrly7AyQrXsArjzgUGZUDlAcbOvzxN74At5RBWPpBvpOobOsY05eaPqnInoklJBVa42EYab0EkqItN86zxGODpDgOKuz/t7m1A7OO/T4NbwKBKf0yQxf271B+hTKKHuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUJropcqEPF3Zq8STTSSrbFUc6Z0cajKISZOgGBZQX8=;
 b=ttNxJBvGo2RMrxVrsEWAQIpZl4m3qv/Mm7ghdg6zRPM5FbDTUa5CteWGR97maL0zmFGmO76g34xABJ22FX7A+qbU2z5WOtXvZozb20tKoBwaWAqkp5Sbo0hLu2wWpBQzImH5M/1SZ/0K3+ko10UAx5XF03U3UW/itdd31FL//eY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3849.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:43::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Wed, 17 Nov
 2021 09:04:24 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Wed, 17 Nov 2021
 09:04:24 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v2 2/2] test-lib: introduce required prereq for test runs
Date:   Wed, 17 Nov 2021 10:04:10 +0100
Message-Id: <20211117090410.8013-3-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211117090410.8013-1-fs@gigacodes.de>
References: <20211117090410.8013-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8P251CA0022.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:2f2::6) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS8P251CA0022.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:2f2::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Wed, 17 Nov 2021 09:04:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27e1a72d-cb6a-4295-b777-08d9a9a93ff9
X-MS-TrafficTypeDiagnostic: PR3PR10MB3849:
X-Microsoft-Antispam-PRVS: <PR3PR10MB3849A78D67695AA7E12EE96AB69A9@PR3PR10MB3849.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HYdQwVwOuyZq96mYDysXOxHVTNTEP600Ffod6HpYitoyDXD2MzRikPaiICBo?=
 =?us-ascii?Q?dw9YDxm43QrwwiI9TPzhKNPdrXqPG3xOMSSBWfJ66c5ilXsb/Ct0++FZ5g/h?=
 =?us-ascii?Q?NSgCTmmVh9HbNMFeu197kBCc0gsVKKI8wZE7K8yPs0lip+yf6wcwdDVt0PQz?=
 =?us-ascii?Q?3KThJ07qZxfD29Xl2FVXWa5QkOJKkxjUaHTClmbLm3ruXCfFRBEdPtxZBstz?=
 =?us-ascii?Q?wYqG8rs6agcVjy7kmKAFgMnJNlufuDujwRkP9BVGnNCjgffT/7eaen0pWj4E?=
 =?us-ascii?Q?oGO9/H0yZyWX0/rRi1w3lNTXSzcQ9dplBicgfRd+5pBivrfcz4E8vsiMHEHb?=
 =?us-ascii?Q?L2ftqXC+BqC+kMqVhpfK8c0CTtR9OgOC+aM1pHO+GtJBJtN4rjcf754agkVA?=
 =?us-ascii?Q?6PPSXVol52EMtHGRjf+Z1LDYWmtHJAeKxOUMjwQKWs3wvdG0tQCi+WcoNKrM?=
 =?us-ascii?Q?QfZoFuQIBFVOLYIyId01yql6QDY3QQM3WKrSouzGPBjPjulFoQ3ovQamkLwe?=
 =?us-ascii?Q?5xTSRfRf251XR1kRKhsgh8JF5JPa/qSDpcor7fbovlgnx3qsnQq+GpNkqNyP?=
 =?us-ascii?Q?HKzfUk0VmT+12dadJ5Da8iABwXFizZt+1jXYiDYHFMLt7IE7L5TaliL72bAA?=
 =?us-ascii?Q?ggTbFLrmBau7LKbal2HEOcLB5e0PmfQ4PKRFhfZeOOTB457j+v+u2D73nHo5?=
 =?us-ascii?Q?LqeTIA6aYWA/gHSJ6ZWKbhGQ51RSclWTm+JMTOu7yq0Ox4A3qpvgIRl7q8pL?=
 =?us-ascii?Q?wIkxWOxBSpRK/u6iifEHGlqKtgrKpbOFRcRgdn6d+qQeM28gp/oali4x5wow?=
 =?us-ascii?Q?aHG5ExIacRF5oZXFMIhiZvG3u4oCjmwwBogSrB0Obb5ICjwyhcb1CNSKCBNP?=
 =?us-ascii?Q?zSMfVdzsd8pits801dwuEBPsJRdrnUKos/zfHcj3eHwDCXnrbfXR5F2vx0iH?=
 =?us-ascii?Q?3K4VyZo4Zk5NlAhm7JG1Z6y/3vJ5lnbEL5/LT/X1XIKwCC9JT0yBQ6k8TdaJ?=
 =?us-ascii?Q?c4n3DYso98gqMs52VzmoI0fyXw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(366004)(39840400004)(136003)(396003)(346002)(376002)(66946007)(66476007)(66556008)(186003)(54906003)(38100700002)(107886003)(6666004)(508600001)(316002)(8676002)(8936002)(5660300002)(2616005)(36756003)(6916009)(6496006)(2906002)(86362001)(1076003)(52116002)(6486002)(83380400001)(4326008)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zX/2xrvD7exnGcRgrawjXWYvylPssjQRSIZ6IU/u4yHpZ+Dzy41pw/buSq02?=
 =?us-ascii?Q?AxDipuFzEfuoDXGi2LQ6e0AJJVLY2f44l+SxK4EFFbUS8h0TdDA86NbsNLua?=
 =?us-ascii?Q?jj77NL4hpqcleJJv0m4VAYvfr5VkWZzUm69i5I+wq4HUfxozu8pT8v3AqSpI?=
 =?us-ascii?Q?hUN7ArDfczhNz/rAo7tjGEudanQ+TtWoiiQycDrspNOXkLwbyE2pEJFgBM/C?=
 =?us-ascii?Q?SmlXkhG6jM5N9IUV/9V7QHYqLHF+oIygSbaSvGBJASCgpigcorfk1aRHlXds?=
 =?us-ascii?Q?92cRYpfAfNmbciYf3OEtgxeUPzHhBgW+IqTxNPj5Fr4Nx8D8eDtT9eGCjaKZ?=
 =?us-ascii?Q?z5Ua2650Eyy6osb2ZS8JzIRNBvm03wr8UubrbBKktAymcvGhUq+fzYogtK5+?=
 =?us-ascii?Q?RTAMsUKxqQ10PBEVVYnjNnRxMhZ+vPIlljjFqpgmdggH2P05oYKn4wBGfS4p?=
 =?us-ascii?Q?Cc0y12t+cBsF8lkaJ86PXaThyN5gWnRCyM7PxLHI/h6rlT+DOYd2RMLWU7pX?=
 =?us-ascii?Q?rZXfNLiXEsKyzFYeldXOGK7IDF1JS60FGbctmC7ai6SglBPBvAU4QgNSVx1m?=
 =?us-ascii?Q?XqjvUK55NqgDaiqA+xxpF1WPnCOjOKBkz/bzNNmtGhWtRGyem5/pKzQdfomx?=
 =?us-ascii?Q?1zPN0xJehLoE1+xRmuh2PYWQ2c4KYggyHJq8zN6L4Mq+fcsRyDctxqcxVH0U?=
 =?us-ascii?Q?aIoRId9MIFc5RZO0aQnto74fT4m5CxIYXE2I8oPb6RSb3haHujX2OdiDU5OX?=
 =?us-ascii?Q?O+pbdStc27nrA44IDpKKSCeIcwlWhMALuxeDF8VkwIj8zjLGeYK0wug9mfjP?=
 =?us-ascii?Q?28gyrHJ8DwTXJtrCj6wIPoET9kaHqeTVcbhyIzzvuJfCoWqN2Xo6yv7iyqj6?=
 =?us-ascii?Q?CybPGw9T94dagU0U1J3HcCAnNA/63nhMzY5EC2CMYTfAv5OKJ5TAlUvYCUmK?=
 =?us-ascii?Q?/n7wMwLkRGZZMa9bOaROL+NuUkoZj/5pXyKk1c2zNnq90FmYg6iiX8yz7Ffs?=
 =?us-ascii?Q?AFEvuN41+6u86H9/LdW3pNYRYnIHN014R+xzWjaFewQpof7XT47Vpx6voRJy?=
 =?us-ascii?Q?wMGwY5na4lV8qCqMjPDSZAtQRIlWj8RnRm8ufb0SEodGF0X0UkXOg1e351nB?=
 =?us-ascii?Q?+Tw6uSqt6fBhTnb55cy0qmsvXMfLVT4vTFPwXR8TYqzRA0Bgq3nW4OAmz72E?=
 =?us-ascii?Q?/An/eZz5LIwmTNg+oxs5FWjjOEDyNgJ5pyEgvLNY930AImJ5iJiMnpTBOcp2?=
 =?us-ascii?Q?DJfdeuYOS2FdCJC1C8GlYONWh82l5LT5HeZ+X5/mWPyoAZBUMRcVU2V15HO9?=
 =?us-ascii?Q?mDluAzjEXbQrXSQ8kIJeuQCfG3FW6CWo5cv85wixfNkknAY9MU8G7I61yjp6?=
 =?us-ascii?Q?6zx+tB+Q7VZXc4+vOdABfvB8T3tzcxGylq6PfQIcmN0jOJGr/Cb6hrM8YLgV?=
 =?us-ascii?Q?X4YFsn6/xJyCdl4wisMb2SxvgVd5oyzE5dswD+UfAq+3Oq9kkIEd6voH+iRz?=
 =?us-ascii?Q?Xhy1/7tKn0DsXhvcrUaKwArUKehC+Z7oBqCdvqtHWunXO17H+drHhjpB/011?=
 =?us-ascii?Q?/xhcwQB43e1g7yPoIZXdTo/HI9PGdFdt2n2GWcbvkjpni1pJy81mc9DTdf7V?=
 =?us-ascii?Q?1PZa7ohqM3tpraco8Rlg3jsapH0DdRZiCWKRyTAKOD/qOK0s/wqeHrICSjJp?=
 =?us-ascii?Q?tFlxXYXcLb28c5Ef1ugWMVlSQJNjRgM9FxwvDSro1S+jkjruWbxHn0XCnZes?=
 =?us-ascii?Q?+N//LS0OF42or+f+M8ObSsg0+oLLFOI=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e1a72d-cb6a-4295-b777-08d9a9a93ff9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 09:04:23.9265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OK1O72/dJCdKSOT61NsRkq0XrWimpmfwpOooUUroryxh/z/NaYNoGJ6J/YLo/Qqc+ym0sIAUhyc+JetzC7+/SYQKATHGwcAlO0NBWurs60Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3849
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In certain environments or for specific test scenarios we might expect a
specific prerequisite check to succeed. Therefore we would like to
trigger an error when running our tests if this is not the case.

To remedy this we add the environment variable GIT_TEST_REQUIRE_PREREQ
which can be set to a comma separated list of prereqs. If one of these
prereq tests fail then the whole test run will abort.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/README                |  6 ++++++
 t/test-lib-functions.sh | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/t/README b/t/README
index 29f72354bf..18ce75976e 100644
--- a/t/README
+++ b/t/README
@@ -466,6 +466,12 @@ explicitly providing repositories when accessing submodule objects is
 complete or needs to be abandoned for whatever reason (in which case the
 migrated codepaths still retain their performance benefits).
 
+GIT_TEST_REQUIRE_PREREQ=<list> allows specifying a comma speparated list of
+prereqs that are required to succeed. If a prereq in this list is triggered by
+a test and then fails then the whole test run will abort. This can help to make
+sure the expected tests are executed and not silently skipped when their
+dependency breaks or is simply not present in a new environment.
+
 Naming Tests
 ------------
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index eef2262a36..2c8abf3420 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -680,6 +680,17 @@ test_have_prereq () {
 			# Keep a list of missing prerequisites; restore
 			# the negative marker if necessary.
 			prerequisite=${negative_prereq:+!}$prerequisite
+
+			# Abort if this prereq was marked as required
+			if test -n $GIT_TEST_REQUIRE_PREREQ
+			then
+				case ",$GIT_TEST_REQUIRE_PREREQ," in
+				*,$prerequisite,*)
+					error "required prereq $prerequisite failed"
+					;;
+				esac
+			fi
+
 			if test -z "$missing_prereq"
 			then
 				missing_prereq=$prerequisite
-- 
2.31.1

