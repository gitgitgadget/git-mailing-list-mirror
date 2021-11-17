Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ED7C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3763861BC1
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbhKQJHZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:07:25 -0500
Received: from mail-ve1eur01hn2212.outbound.protection.outlook.com ([52.100.7.212]:1921
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233046AbhKQJHX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 04:07:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8covZ/LFytHuBGsCR5R0kdGy+P59gQNFc9wT28jCmI+DOofpnzYbNedg0ejrynH3PAPd4JtwzaTywCeuOu+Jg1xZi/Ze9V8xZCFm/OIt00r38gzOYUi9TyJ55wzC1sxPSetMfT7lzfwRBkjT5cJ8cdH+EqDa4P628S1Fd8nLy8s0yo4emBjGgHJzLqNAoweoqOWSchS/SHNrnRJwTjY3AMFruwYMWir7wIttiUWBvaXrt0lDem7Lm/mhZ6qU3UzFxL63BRJ8WFCMPG7pwpjPettRgXE2I9lfcwaN+Twwv5+Urys6prgjFRsa9oFbxzN2FFG1b+C9S/mN44sQNxAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjBgYgfwlF4KxFyFSDqBz1Faeop6ykZ2ISzQgaSPc9s=;
 b=aHKERHdGeadzU6rNA9ilfAgHmTg82MRedp0eByfvr5JFvs7c6cN3dPLDPkvaHehF0NzTWWc6ukiM6GfyTXPfc1mr1V3kLxjtjNURyoVOfM7Ku2r5mUftx8ummsbxNgGTK8oFTDh/YPukBnnAGYpJ0iD+BnHMALwKaPz864wC8q0pXhrEnuQo1HTIv2iXXq/J9sOU0lx17SLUufyEsPamcjmZ+Xt/+hvvg9ozlXBoV2QdjodXt5xWtyEXVpReQJdnqm41WG1ZJMS31BBQdjDjoST42Ueic9IKW+Hzb8dcTFnhn1N8Ny2+L4tN9E3sbMZ/xzz3rwYH/aypNURKwzTXTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjBgYgfwlF4KxFyFSDqBz1Faeop6ykZ2ISzQgaSPc9s=;
 b=Iz+qeRdoOjVqruYj02dNWiEWqls0sM8voRL1MU6PZ9NBP1DC5yyqwzTso9nQd0/x0bmY2PHMY60ZG3Hkg40TqGb3q0zcZOGXr0+z+pdVDcBlqEP0vW02LudanD6fBLM607pljkhDV2R0Dxbd/ll3A9cLHch699X3o+wnP0pvjkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3849.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:43::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Wed, 17 Nov
 2021 09:04:22 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Wed, 17 Nov 2021
 09:04:22 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v2 1/2] test-lib: show missing prereq summary
Date:   Wed, 17 Nov 2021 10:04:09 +0100
Message-Id: <20211117090410.8013-2-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211117090410.8013-1-fs@gigacodes.de>
References: <20211117090410.8013-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8P251CA0019.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:2f2::22) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS8P251CA0019.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:2f2::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Wed, 17 Nov 2021 09:04:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23237929-fd0d-4fb8-defb-08d9a9a93f4f
X-MS-TrafficTypeDiagnostic: PR3PR10MB3849:
X-Microsoft-Antispam-PRVS: <PR3PR10MB3849A5996591E21A967BCB2EB69A9@PR3PR10MB3849.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?unEGr+zdhZ+GSOt59JNv0u9ZxlVPzb0vY7R7kpUdcErbbtqT46sPz3OzqMsz?=
 =?us-ascii?Q?FWpA5EvF0noKqRkSfrtnbbkmLOxZWfhikeHFbeHu8/dj1Q7jU5aq7IxZ3CAG?=
 =?us-ascii?Q?HTtlRzT7JTbMB9P9Rv+0UAmLEoKbIlxKOs0C8vU4lBHHeCG45XK7pGsVhzo5?=
 =?us-ascii?Q?wZtrFwjTwanHQSDfrrNQdH5EkzGIjfAB5Q2+gziDu+s0LZIRGBbX0w3d0vkk?=
 =?us-ascii?Q?sMpfdUlsPWzkJKjqaZbIRWiV2448Jk0P9fowvB89pYfR309T22WKpK6MWFZy?=
 =?us-ascii?Q?KYkUe3vMpYtWZye//STKnPHT+5MZQRASzki8FAF1eJ0UVAYpDaEegUGgyMFm?=
 =?us-ascii?Q?t/lws5Sg5yeAluHEECx5K8SVPoD1DizXgpcZn+G1dv0htrLstJsB1iYi1cw6?=
 =?us-ascii?Q?kgcO+An2xRKjGycBRyRkD45BpKjq8MAGH2KYbF6vOFJq57/GUg1OOZfbv54x?=
 =?us-ascii?Q?62JeXXuwuk+5qRefLyli4u58LaJ/38p9D8pcTgT/fzFGG07UXsdka+tovQDa?=
 =?us-ascii?Q?9/IbzD/qswt3QYE/4R2G7A1qzi0yRV1sysGxvJFMScp4c0SbhxM3ZRoO89qy?=
 =?us-ascii?Q?XWDPvDjQVJsnzeHLphdl/PsHG2afZVv4aHjjK5bcamLaF72e0dzrr34SwuGE?=
 =?us-ascii?Q?edMxf6a1YJSlyC+ZPaY1OYQEp6r02ggM3FItLg8u2lChOuXm3N7AR2KI51NL?=
 =?us-ascii?Q?14AtBxuhfQ92mgaqPt/LkJhcv/kAf5q8nXVeo1ohrelbXkuzEoMsH2DVJ0DC?=
 =?us-ascii?Q?bfb0eiew/cjuEaFQhr0UqbyI+ZKh9oMkhv7qc9597aWL03ATDTd8yjhzHgj9?=
 =?us-ascii?Q?pyAzCWA1XPQ4DZQVGEB7z/cGa4DPLEx8d06A57Dl3X8B2v0V3CCtFez4Y7ve?=
 =?us-ascii?Q?K8mrx+HikI1wpyKJlDvFbfijUbE8eaV0sb1+0DNBEm25r4j69+gjsXQuumjm?=
 =?us-ascii?Q?4TU4sm0tj6XWqZgmD5kPvZ62/Re+hc/+X/I8Ir/La4NHlMSLMhJA/nIY/MQv?=
 =?us-ascii?Q?mKO8fU1+Q2qGyHUB78lJHyHtQw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(366004)(39840400004)(136003)(396003)(346002)(376002)(66946007)(66476007)(66556008)(186003)(54906003)(38100700002)(107886003)(6666004)(508600001)(316002)(8676002)(8936002)(5660300002)(2616005)(36756003)(6916009)(6496006)(2906002)(86362001)(1076003)(52116002)(6486002)(83380400001)(4326008)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6rwz7gja6/RVjz4INUhcHKGn6105mnfrYYTSFFVm+TcTVNGoxNSFrhl2ea1W?=
 =?us-ascii?Q?NYK1DUxHXtsrmZsNg2gPu5MTtXG6AkuIyzXBnnRta2ecxQQudsuDC4RdyEOr?=
 =?us-ascii?Q?ElsZfCjMWe0ZiqNEsUuGl7e62DU6rZ2LJFHBxcLmnG8N/qgTO/lPVvMr/01W?=
 =?us-ascii?Q?tZY9aWEx//EsRq93gaqwthN01trKeK4vlHenWVGtWvVLmgP2+Kh4UIheM2Gd?=
 =?us-ascii?Q?FG2vY4UP+85iLHYWAWLE2Rke5dxaHLY4rfsoSkTC67eZ8h/Max0HmwnnPk1D?=
 =?us-ascii?Q?tIRVLQwG/qDm+uNBhU1yQwzi/w9m8NSLa4s4iLQjy0jYDgheJ3+oll9+6Gf/?=
 =?us-ascii?Q?p2IVlyTXQxnKKBmycKoWHxwYIqazRft5mSZk4G+TJj955wShc5fGREfJNc2F?=
 =?us-ascii?Q?H8maN6NBcpvU5rWmiB5HSjA5hvZ5V+cOXAU0FuCrUKVxj0MFDp1k5/n+LTE/?=
 =?us-ascii?Q?TR6De5sQ9+NmRAl2fBoBm6xy0idsik6BqHQSaefo4Oywu1LPiEKuiuRnoHwt?=
 =?us-ascii?Q?eiTSRhzq57xkvz/PQ3p7Y7L7knWEgn9dpNhmqXX/1f9vNSuxcxmhjK5AW6gJ?=
 =?us-ascii?Q?fRCETR2Qqqngr24VWLs4DsmUhNDx3yX88NwqJCYC+yHkXUS9mAns3XbER3vR?=
 =?us-ascii?Q?uEYHh5VbNLLyBg5NNm2xqI+Ae7i5Qrjatnh/WQzJbeVNlO/pWbTL+yC64QWj?=
 =?us-ascii?Q?QCkc391mIz/8v/oS3zKyxB0M9TI9KBURJ2V11HLgTwlWosD96mKpLUNQ8cjV?=
 =?us-ascii?Q?l4VLmDQHiQw74naFwpUeWChEpFQso3OG+7zxguUnEpGzDKortbEYUe6gLKg6?=
 =?us-ascii?Q?YeOYrTAyAg/43IEwp4WyXGta0RzXppmfXqF7lPcE0VgHM7a7R+3q0C+IMP0e?=
 =?us-ascii?Q?+pI7dc6+J4h4w5Vhcp+e9ribe7rKpl04TuuI2tO5EAZeDRDagc7pHV+7aZ9N?=
 =?us-ascii?Q?a9IvcPpvZOUWB9sCqKOCKHz5Kju4HKV1msSF4ko8RDdsb452WhQ4MjpYWBQj?=
 =?us-ascii?Q?QY4rFYwmskNoQD6+La4yIAk6ZBO+toe0BXUkJeX0S5CTBQE063D99dOeuFnx?=
 =?us-ascii?Q?9svfRNiTI4ZsK49Sl6jO0HcxOYzNrkmmSwP0JYSwyGd6ugAGJcCTEWbaxy1i?=
 =?us-ascii?Q?yz2NfCBkLXdEViMdx+b27wsfDSNiT4DCUXyDCLZmMARPvK9lXI4U511hqNy/?=
 =?us-ascii?Q?jUs6mp+wjVavS4hKeVcr5Qt8OpN3fSBk4hFxKtrCeOq8EEasUqI6KTH8ekt5?=
 =?us-ascii?Q?FRARkfifo8yi68ZSndStMqapLYeeQ7tA7zJGHiQ+ZLO4AY0/XPJ4/wXS4DMB?=
 =?us-ascii?Q?lctISAcB41I6PMQFGdM8sh5m7ztA481Wlr6jXm5JVMzrRr8xLP2QI8+X4dC2?=
 =?us-ascii?Q?ZCzPmm1H5CGSc+lB745sRsY4S/UuA3b/Y530gUh6zsLiAxvaN5P/enAhpmFS?=
 =?us-ascii?Q?ANIcFCTY9hoo/OdihmuoMMhh9+xdlN+82SgFfnEV827/8PyJKJokuaTCCEOp?=
 =?us-ascii?Q?ZoXorLPj28Ya+8zrJsWw5Q5VAJm3XXECwTaEBcq7lQkLnGkf1b9CbiD2S3nx?=
 =?us-ascii?Q?CZcmdswz0lw/TQnGKhXCatIKUbLVCQ7zZIQyBG7CvhO6OxBMt+wytZvg27im?=
 =?us-ascii?Q?K9cxcS+/ZpMaR0nAt9wu8tRgq/0r1knsKObdsvwxTI51Ql8JRRS+lmnRbFDw?=
 =?us-ascii?Q?Dhtypa+aOkDu4HZ935glUYBUmy64OcHs/KYw5yioW/FU1vlltwDo94ARWQ3v?=
 =?us-ascii?Q?f0u3a7aKGQ=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 23237929-fd0d-4fb8-defb-08d9a9a93f4f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 09:04:22.7497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2AiG5Tq3O15nHGsorqIgSli3GJSgNv0RJ2uSaJgyjCDDuRSyW9VpRtXXeFjl7jfg0ssX5k039FyjLZCUCgYQ0e9MpDGMtldSgvJOWfVyLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3849
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running the full test suite many tests can be skipped because of
missing prerequisites. It not easy right now to get an overview of which
ones are missing.
When switching to a new machine or environment some libraries and tools
might be missing or maybe a dependency broke completely. In this case
the tests would indicate nothing since all dependant tests are simply
skipped. This could hide broken behaviour or missing features in the
build. Therefore this patch summarizes the missing prereqs at the end of
the test run making it easier to spot such cases.

 - Add failed prereqs to the test results.
 - Aggregate and then show them with the totals.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/aggregate-results.sh | 17 +++++++++++++++++
 t/test-lib.sh          | 11 +++++++++++
 2 files changed, 28 insertions(+)

diff --git a/t/aggregate-results.sh b/t/aggregate-results.sh
index 7913e206ed..ce217b4c0e 100755
--- a/t/aggregate-results.sh
+++ b/t/aggregate-results.sh
@@ -6,6 +6,7 @@ success=0
 failed=0
 broken=0
 total=0
+missing_prereq=
 
 while read file
 do
@@ -30,10 +31,26 @@ do
 			broken=$(($broken + $value)) ;;
 		total)
 			total=$(($total + $value)) ;;
+		missing_prereq)
+			missing_prereq="$missing_prereq,$value" ;;
 		esac
 	done <"$file"
 done
 
+if test -n "$missing_prereq"
+then
+	unique_missing_prereq=$(
+		echo $missing_prereq |
+		tr -s "," "\012" |
+		grep -v '^$' |
+		sort -u |
+		paste -s -d ',')
+	if test -n $unique_missing_prereq
+	then
+		printf "\nmissing prereq: $unique_missing_prereq\n\n"
+	fi
+fi
+
 if test -n "$failed_tests"
 then
 	printf "\nfailed test(s):$failed_tests\n\n"
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2679a7596a..f61da562f6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -669,6 +669,8 @@ test_fixed=0
 test_broken=0
 test_success=0
 
+test_missing_prereq=
+
 test_external_has_tap=0
 
 die () {
@@ -1069,6 +1071,14 @@ test_skip () {
 			of_prereq=" of $test_prereq"
 		fi
 		skipped_reason="missing $missing_prereq${of_prereq}"
+
+		# Keep a list of all the missing prereq for result aggregation
+		if test -z "$missing_prereq"
+		then
+			test_missing_prereq=$missing_prereq
+		else
+			test_missing_prereq="$test_missing_prereq,$missing_prereq"
+		fi
 	fi
 
 	case "$to_skip" in
@@ -1175,6 +1185,7 @@ test_done () {
 		fixed $test_fixed
 		broken $test_broken
 		failed $test_failure
+		missing_prereq $test_missing_prereq
 
 		EOF
 	fi
-- 
2.31.1

