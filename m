Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A571FC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8984C619E5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbhKQJjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:39:16 -0500
Received: from mail-db5eur01hn2234.outbound.protection.outlook.com ([52.100.6.234]:20915
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235309AbhKQJjL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 04:39:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmlw2lmYT0LikZeR9CaPZfabHT9oW8O8UgpGtyyTdXwJVMYK9MhPIyWRwtFMzdrbTA8YnEu6teXYGoZ5kfQ93g1WoKh95y61GVmw9hROombp4I+bQ7KMfV2nq5VaB+pw/PmQUI6C6ABx4FhmH+7SUXpcein/BsoIWBpFXiuompS2GvGDQIipqN2dhaZ7nOXnwdKcqN7/QuZSgFfZjAF8H1OvmKCvYOzGshh3cR6RVJC/kBHZQOR4Tt4FFtpW0XxrKJQvkJZHfufAhAoewAwRK2iYaITk604CdtzR7J87jHGbbTNoIrQiD6BrtYPl0zxU2zcQsCYiHpQAPkTYLNMHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofCgc7Y0xhUzCGLNoB3bXizmDJs8AbWooyZoXB41Lp0=;
 b=M+9//Wyw/UQgiTuFlNeT7RzSnK6422b/xIMyogA1PZgXyON0lfn11Tx4KFUvrQdNNxbgFqmGJ1HJn8Lw/e5lK3zDFQxXjd4X443JBYORNoIZY64l3n2Shk5b1FpE/fzoyYeB9cqUPlRrXpxnlr8yOayEDWLIhL1Nxk0HZ7G5lIQis2xGq6zSCCO9SGriSjy1HKinYhJCrH4x8eyo0R8c34XDUlpJNjcKokAmzv41pweWg+5T/v1bgzNMgdqPK0JDZUx47UL/ZbG9VLfhmnjUEU4zQ+S9u0F0i5CIgMZQJrnHReBtzJmYHLcvaYOvH6Ex9Xb6Q7HXjrurNkEBGYr0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofCgc7Y0xhUzCGLNoB3bXizmDJs8AbWooyZoXB41Lp0=;
 b=RGIFO6OxmHzgFo86RP9HVZNokmG/QhC1/04xuA2TTnpQvappAw5XOb0EwaduUCndF9tBQRRmdDcRrUgq5d9WWQavAnn6lFZrmX+ogeQw+1WRwPyNnfz7v6pU7M6D9E1kZ4BLCmy7mfQdQ58dp+4grw/J9FmHyCNAR+De9Fb3mmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3820.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:49::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Wed, 17 Nov
 2021 09:35:52 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Wed, 17 Nov 2021
 09:35:52 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v3 7/7] ssh signing: verify ssh-keygen in test prereq
Date:   Wed, 17 Nov 2021 10:35:29 +0100
Message-Id: <20211117093529.13953-8-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211117093529.13953-1-fs@gigacodes.de>
References: <xmqqsfwmus5g.fsf@gitster.g>
 <20211117093529.13953-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0208.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::33) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS8PR04CA0208.eurprd04.prod.outlook.com (2603:10a6:20b:2f3::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Wed, 17 Nov 2021 09:35:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 669631ae-8169-4781-f662-08d9a9ada4f3
X-MS-TrafficTypeDiagnostic: PR3PR10MB3820:
X-Microsoft-Antispam-PRVS: <PR3PR10MB3820FA8696A58849ABCD6146B69A9@PR3PR10MB3820.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hVrUSY3Q8s0Q7Bqw3JNqFk/CitgSvFcOvJsPWktAXhJL6mMK2pcfYxOXIKkz?=
 =?us-ascii?Q?VUcfeMa6MF+902LEU3OUuO+BFGsE//iQzRH7fzu6yK8mgC7A7nxOtlSXTP/0?=
 =?us-ascii?Q?8qPfD86vaK5BV27A1QwkMR5NurW5I8OYeoQBp7dCRJGmq+vFS9TPNxYDEhnj?=
 =?us-ascii?Q?yarg/TXfBWFV2YLhB3kO+jclj0Ol8lZ5tOToQXTBQ97KIMXCASnWs9SQGC8N?=
 =?us-ascii?Q?XQ8uXer0O9Y7kEc15KlOcE+OdnCpvUpOydmGuW+QTQ5FOYLhvsJrLjLWmU9+?=
 =?us-ascii?Q?aBCvp6CF1D7jQrA7f1yIq9TITKgxPeZrgMV3cNWJPObJZAFaxIUCRavGLhC8?=
 =?us-ascii?Q?m/lKCwXChwtVWJLusG2wD3cNzAWgLlZ7wunq/9u+IRAW+GRLL6gztuc/3/1f?=
 =?us-ascii?Q?PqkqrFNW9kDKKCu/e2eyumkImvHqUCu7cbjGqlyEnlyfUZ0bMgf6QQIG+hsI?=
 =?us-ascii?Q?kgfWDkkY3xwu5LEfpuIxf19zUWqCSYwkdPw2mw+Iosi6SVd2IgHMF/ubNomx?=
 =?us-ascii?Q?rLUYJi1jfWHgp9wnDWlvQ+NZhKMoCgGZcLrcEl9DXKta0Bawf3LpLbzflrxW?=
 =?us-ascii?Q?mF6beYCzU1POW+xpp9ejdpoz7zkJiZ+vwXdkouWMtVscjr2uY5F2Fvw0lYFu?=
 =?us-ascii?Q?bPCPI82QmwVa/nOGrRIN427/mDuoZksMCl52pdw4JEltOqumB2EuRtzFtE4y?=
 =?us-ascii?Q?f0AeKWHefjpvuS/adj5f4cuTUrECH5yaM+VuxSi+GHxGf4eVmj96XDpp1sAw?=
 =?us-ascii?Q?IBv96T2Y2bwgQ6dVra8hVTSgZyQYkt3gIc0BqCHrSTD8iWDdO1CkoY60Cp5Q?=
 =?us-ascii?Q?XyULY46bLEpK7sRkYxXUa7xdkg5w1w/jxsUah0PIh9pjhJj2ntR1HL6imNtm?=
 =?us-ascii?Q?SQVKnv25uqpNKycChuXfKsnTURcxZNkG5PViBVjDA2POSXFMjF/98BVtusLk?=
 =?us-ascii?Q?90BsYXFzqjwDoELJx2fKcCSHkDERoDua8LTZ0kKv2BXgR6U13oh407hIRBno?=
 =?us-ascii?Q?lXfifmbsHsaBUw1R7gOsM+xQKQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(136003)(376002)(346002)(39840400004)(396003)(366004)(66556008)(316002)(8676002)(1076003)(66476007)(66946007)(38100700002)(8936002)(83380400001)(86362001)(5660300002)(36756003)(54906003)(15650500001)(186003)(2906002)(6486002)(2616005)(6666004)(107886003)(6496006)(6916009)(52116002)(4326008)(508600001)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mlO6ZiaczZeAAm7wuIFDnYKabLa0j48NHxr8sK1kVM9Gdt/ZuDxjcUu4oG/N?=
 =?us-ascii?Q?ehkiJ35tUYS2m5TnRswsiAj0wdNJXGfMWR14reEhphgAcn9dk/P38yDf5gan?=
 =?us-ascii?Q?J3UftYkL5OmAjPAfYNvuLwrt3U0CNoL/ZOYolwTl2vtFZXbO60A0B4hFak5Y?=
 =?us-ascii?Q?I701plnos+1qw6HM+XOgWvGvWnxkoba9tD/yTjaqFvRMWFU1hUP8wxdS2krU?=
 =?us-ascii?Q?yo+ZJsaOwAqdDCrKUlHyhAXVFFWzjLGjS4hBXXlQY0BXdD2aoXAfMxTXrDgQ?=
 =?us-ascii?Q?jQiQczm0cP3bELINktRw093ePKq+x6WWLl07YCha2YZEvkapnx611GkI07p/?=
 =?us-ascii?Q?najPgjpca0/9ueuzW7JKWvkjMV9OGiwOZNcD3GcAhwv3s45F43r62OAtK/jG?=
 =?us-ascii?Q?SKVM+04ST1WCVHsQRP/Y42WMs505u/GmkPzYpkvEKY/fT1h9tuDmCyns4pVe?=
 =?us-ascii?Q?6r/r2qU1Zryvr4kTS+ShK9L3V1A5zG6egFKLVUWQ8cnrPF5fi/PBqf1ghXz/?=
 =?us-ascii?Q?rJ/3YS5rc9gZ6PMX3Pd/Nsh9m79OXJAP2VLtb32Cs5KSFJKoBIA/qzek6zGm?=
 =?us-ascii?Q?EMH6iDN2c6IFskdkKBdkyY7k0guPxG2T/8P7zZuNjoaWghY2/GSSeQo9TXKr?=
 =?us-ascii?Q?Gf0O37ZQLXlPFy2evqq4pv9T2QEej2eV2puGblxPsefqCxh+DzRQYBi+cq6a?=
 =?us-ascii?Q?Ka6sYNoKWh1vL9ilrIddBddWS3HDuI/HJdCQDe3bUR2pzPPt5Ix+jq6wFYgq?=
 =?us-ascii?Q?5pKFxPv4aF2ShY2WRLiaxdujHhTO/KoHykY+dwyxDs2MCSMripeUD1ANimhF?=
 =?us-ascii?Q?CuvCG/+jxE3q6fD+0oCvHyqy2bmotOYwxEXhvZhBILw1HcOeOxdIciEwcoTA?=
 =?us-ascii?Q?hsaaWYdoSb/PzXC0pftfGXudt3bx1UuxJwinRnwwmy2NOzCoSrKfWxm9bfgr?=
 =?us-ascii?Q?mWfhDggEholYZLSDW+EVAWPB6wW2tbF7RZJiJv7JrvbE7aQLa7V0r4YhxC0K?=
 =?us-ascii?Q?ldiHuhNuK++au2dZqJhc5NXEBhTVY6nklDw2AcwCnTyKD4fYG/iqpI9FOslQ?=
 =?us-ascii?Q?mwgO+z76jgONFIRN6lqWL0xcdaawBgXvTZ0ouqCzp6A6xVyBKqIsXeDQZX4n?=
 =?us-ascii?Q?jt7diyklI/pKpTKYcUOROhRQRcoaE8tUP3oP/bH7IClT1ya3d24UcDwwbN0a?=
 =?us-ascii?Q?+MZvasFMqdt7VYlmhu+4Tj7kBxWMBkyjx89nntkZKoQcscZ1CnVNZB5E0zep?=
 =?us-ascii?Q?Pih1kpjPkD/pTgnTWRydbn59O8OXN13HtMZ0ApkTEn3EoLRxyHsGCdC8QyOe?=
 =?us-ascii?Q?pep0wXOhFZTAyME6c1NOzkkq+QPW55m6wAC7+hGxe5YkjWMNCCZjwjARVNqF?=
 =?us-ascii?Q?A01xYD+EWp4eKvmu7+p0qSFFlB3x/cRHJik6A5EflmiS4b3kAH1SE9aQOp9S?=
 =?us-ascii?Q?wMq0u/g76OHNkMIEOrOIG2znpYu/XeWVIXw4M+pMdMYEl0i+KQ/b5WDuaSVG?=
 =?us-ascii?Q?c12JgNcNkp8+F1YbvEy9SPlI+MBqSBwlxhu06HIay5Uu67urY2dxvbEcAHGb?=
 =?us-ascii?Q?ttZVkTuhFYS3T915tSfwuWeGh8/MWts7at7O7j5Hbo1C0pzGlaeTrAS73q/Z?=
 =?us-ascii?Q?YXlPWI8XgnDCKEDXvaay89fi8EnSMLZPjCyk362DJfCYxnchdMjHUKYrNggR?=
 =?us-ascii?Q?0GOiP0UOTaQvVyQ5wjlZY9/yyeAxGJ093TM4FXQCdKg7uIlmKrR90xZ6yk0W?=
 =?us-ascii?Q?j5UBAHVL1A=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 669631ae-8169-4781-f662-08d9a9ada4f3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 09:35:51.2320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99i/vWIQIxtA3fxyJXmtIv7KPeV/VqGITZYIy68D3g4TiPDvJVw/s8Z1khdFMFaeeYUlPlqtvji5LyN65s3Bi/cPvEvp1iZCP40naTQKxUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3820
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do a full ssh signing, find-principals and verify operation in the test
prereq's to make sure ssh-keygen works as expected. Only generating the
keys and verifying its presence is not sufficient in some situations.
One example was ssh-keygen creating unusable ssh keys in cygwin because
of unsafe default permissions for the key files. The other a broken
openssh 8.7 that segfaulted on any find-principals operation. This
extended prereq check avoids future test breakages in case ssh-keygen or
any environment behaviour changes.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/lib-gpg.sh | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index fc03c8f89b..96cf0efebc 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -109,11 +109,7 @@ test_lazy_prereq GPGSSH '
 	echo $ssh_version | grep -q "find-principals:missing signature file"
 	test $? = 0 || exit 1;
 
-	# some broken versions of ssh-keygen segfault on find-principals;
-	# avoid testing with them.
-	ssh-keygen -Y find-principals -f /dev/null -s /dev/null
-	test $? = 139 && exit 1
-
+	# Setup some keys and an allowed signers file
 	mkdir -p "${GNUPGHOME}" &&
 	chmod 0700 "${GNUPGHOME}" &&
 	(setfacl -k "${GNUPGHOME}" 2>/dev/null || true) &&
@@ -123,12 +119,19 @@ test_lazy_prereq GPGSSH '
 	echo "\"principal with number 2\" $(cat "${GPGSSH_KEY_SECONDARY}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
 	ssh-keygen -t ed25519 -N "${GPGSSH_KEY_PASSPHRASE}" -C "git ed25519 encrypted key" -f "${GPGSSH_KEY_WITH_PASSPHRASE}" >/dev/null &&
 	echo "\"principal with number 3\" $(cat "${GPGSSH_KEY_WITH_PASSPHRASE}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
-	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null
+	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null &&
+
+	# Verify if at least one key and ssh-keygen works as expected
+	echo "testpayload" | ssh-keygen -Y sign -n "git" -f "${GPGSSH_KEY_PRIMARY}" > gpgssh_prereq.sig &&
+	ssh-keygen -Y find-principals -f "${GPGSSH_ALLOWED_SIGNERS}" -s gpgssh_prereq.sig &&
+	echo "testpayload" | ssh-keygen -Y verify -n "git" -f "${GPGSSH_ALLOWED_SIGNERS}" -I "principal with number 1" -s gpgssh_prereq.sig
 '
 
 test_lazy_prereq GPGSSH_VERIFYTIME '
 	# Check if ssh-keygen has a verify-time option by passing an invalid date to it
 	ssh-keygen -Overify-time=INVALID -Y check-novalidate -s doesnotmatter 2>&1 | grep -q -F "Invalid \"verify-time\"" &&
+
+	# Set up keys with key lifetimes
 	ssh-keygen -t ed25519 -N "" -C "timeboxed valid key" -f "${GPGSSH_KEY_TIMEBOXEDVALID}" >/dev/null &&
 	echo "\"timeboxed valid key\" valid-after=\"20050407000000\",valid-before=\"200504100000\" $(cat "${GPGSSH_KEY_TIMEBOXEDVALID}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
 	ssh-keygen -t ed25519 -N "" -C "timeboxed invalid key" -f "${GPGSSH_KEY_TIMEBOXEDINVALID}" >/dev/null &&
@@ -137,6 +140,10 @@ test_lazy_prereq GPGSSH_VERIFYTIME '
 	echo "\"principal with expired key\" valid-before=\"20000101000000\" $(cat "${GPGSSH_KEY_EXPIRED}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
 	ssh-keygen -t ed25519 -N "" -C "not yet valid key" -f "${GPGSSH_KEY_NOTYETVALID}" >/dev/null &&
 	echo "\"principal with not yet valid key\" valid-after=\"29990101000000\" $(cat "${GPGSSH_KEY_NOTYETVALID}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}"
+
+	# and verify ssh-keygen verifies the key lifetime
+	echo "testpayload" | ssh-keygen -Y sign -n "git" -f "${GPGSSH_KEY_EXPIRED}" > gpgssh_verifytime_prereq.sig &&
+	! (ssh-keygen -Y verify -n "git" -f "${GPGSSH_ALLOWED_SIGNERS}" -I "principal with expired key" -s gpgssh_verifytime_prereq.sig)
 '
 
 sanitize_pgp() {
-- 
2.31.1

