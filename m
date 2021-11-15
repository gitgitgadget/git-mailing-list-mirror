Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AB6C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 16:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5013661BA9
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 16:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhKOQLb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 11:11:31 -0500
Received: from mail-ve1eur03hn2229.outbound.protection.outlook.com ([52.100.16.229]:22981
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232281AbhKOQLU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 11:11:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfCRAvBhDc/vCHnI66ZlKT5TLwOR0lTMdnxr67sLNj+Blgn5m3FaGmE1ymrPqISFw7n90NaC+coFytfOtA8wPEsz15uK78+fIEYZXhuHyNa7HkwvpSy0Y2eQkSWRIffr/qirZhFxMbfhmTpgobceXPfHknfLQpcS0okzKS5EVLOgOiI/2dibSj1pCUGCqUffmd/yy7G+oqy8Un8gApuTOWlGAkBhKElzou1KnC7MY1ywUfpBXGCHMtjM7/Js0+Bi7aIPpIjegTlLcslNl5BCOOa6j0HF42KT9gZzcXfvEmrXV008VabfAsURmUqIIojuT0oMq3Zg5aB48gaeiAcj4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BECf3aWP54PAzmzxFa1LLFoVgNqLPk/Q4g7cZwQL0ls=;
 b=LDHuA4XYDSKnDYZw50Z2lTOocNLto73g+oqdH4pPqkoVpP9QaSmg2JDRG9A5gpeyt8Wfzq24B49pAcS8+0qawwqko4lyr+3tqfdCFYTSm8tyj35fyL3Tvpj1yLY3jm9VC5zRnYFdaDgFgS6U9K6M2JkpKg1eEgOOvHpDyJiqrJPicELXW+z51yw2+f8elsozrSZc8wMoPoaXkh8KgIq0sdOjXxwbl1vffTYOiQblFaAtsb2RUU/HtalE+5Z8yKGOQSCmplv+yhymmSLsd6n0af7T8Lb/JL3r/JSGwiOq1Hz0EIfgnqXRkcO1sYIWDbfS+SeJapoQSMP8iCwbI/AUFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BECf3aWP54PAzmzxFa1LLFoVgNqLPk/Q4g7cZwQL0ls=;
 b=KyqeB2X9QBttc0VDL4lz4jKCuSZPeGjWx6+V8qFXFEVvDdIgrwlLpCNRudGhyht2f5KxqZ/pQHb9SfrJeVHQB5HeTWdwXU0T4jzr5d2ZOb+4JgWSu2aR8Se7WGZZ455JaCldCnozbETAZ2phmCnJCe1+Ve/Jvn1UrAiBQYNLtEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3866.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25; Mon, 15 Nov
 2021 16:08:23 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%4]) with mapi id 15.20.4669.022; Mon, 15 Nov 2021
 16:08:23 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH 1/2] test-lib: show missing prereq summary
Date:   Mon, 15 Nov 2021 17:07:49 +0100
Message-Id: <20211115160750.1208940-2-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211115160750.1208940-1-fs@gigacodes.de>
References: <20211115160750.1208940-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR01CA0044.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::21) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by AM6PR01CA0044.eurprd01.prod.exchangelabs.com (2603:10a6:20b:e0::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19 via Frontend Transport; Mon, 15 Nov 2021 16:08:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36aa94c0-538d-46cc-2303-08d9a8522685
X-MS-TrafficTypeDiagnostic: PR3PR10MB3866:
X-Microsoft-Antispam-PRVS: <PR3PR10MB38667F46AAF59A4987D83F65B6989@PR3PR10MB3866.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uf9WT+uYUUYekGMSls6L4urOE0IYR2+GD14JOLSRxhcnrqdT03upMi0mC7dt?=
 =?us-ascii?Q?TfXY+LBRQC1goulHNaiZf/GfJc6tBuRDoaFxYOMqlLt7wVrC4hD+7J4uHrtL?=
 =?us-ascii?Q?bIcu5cTLBnuDPQn3HJK5zhPUBcISjEmUgE7gGk26E2DKDkcOkZwedNbbxfSU?=
 =?us-ascii?Q?drMb6CeMi5jvMC+ybDp7Tw66JXxWjRzA+Y1HRe7yaVZHOHgwvArbqxB7Hk38?=
 =?us-ascii?Q?NqJsV348HQLY6sE10eY/0ZNzTfcf9zyY2uUQ0X01TQR6NXr/GWWFFshyjtfF?=
 =?us-ascii?Q?BOa/7Zv/QsmPXsYY5m/lgkVP98fIOQt6A/89+qu3Tw7M/zfs2phJKjeM4mQ8?=
 =?us-ascii?Q?CTWvvdpcALdeamnqTWckh+ZE4wa0MQWR0o6WOdgfHkTvYuFMK4MI6J4i/ihT?=
 =?us-ascii?Q?U3v+Nwj4eZlSAMsOMzOIG4EbqMyO7Z43pELOsIiBqGG9GTmtY1P/4v+xN01W?=
 =?us-ascii?Q?aZfV7Z9BCMwdyUv9tarYkxrm1JOySdozYmrvd89CEjt3XPCAyaoPYDEakiaK?=
 =?us-ascii?Q?wzWwvrwzQbM8Thf6mm5UjAvgjvSHYG1Rkm8hGvnOuR7a7yvMYw7dxSlOUizh?=
 =?us-ascii?Q?6mmdzu9DKvcxOh9djfkIBUj8tFTYEgoV+SiWSbVdiuJyUPQPOzTnyG3HobRW?=
 =?us-ascii?Q?GIubHVB/49mPc+R1g0IPcSyy7F3ZfNeTCX6g6XuwYggsvQg9uSvKY1nLlXGt?=
 =?us-ascii?Q?3i5Y3+yfEZpcDC+nWsSNYfzdAcSAIdGq/RUFnge7W3ipipvKxkj5vcSKCT6O?=
 =?us-ascii?Q?mucKMBlb33urIDdDBl3MUSLviGoJSrIQqNhpWFOzGyj7ZdUa14stD34ax7Rn?=
 =?us-ascii?Q?mYKY/dyE5297WwwVfb2M9PlXpIwRqps7WsnR6XtIYZvSHoZel04mMp9CLQBD?=
 =?us-ascii?Q?6JtG1o6OAcZMedF1EhxhxpFqOgLMGj9IYpIOVIKo+eXG/AIM5CugzG3SbxEP?=
 =?us-ascii?Q?lIUzgsYRG4ETrxmug+aStocIL98GglH1CAyG57CK7e0/ORgSuakD9o8IA83J?=
 =?us-ascii?Q?AlvEAfGppS7ewjb7U3W3PdZm0A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(346002)(396003)(39840400004)(136003)(366004)(376002)(2906002)(66946007)(6486002)(86362001)(66556008)(186003)(8936002)(316002)(1076003)(6666004)(38100700002)(2616005)(8676002)(508600001)(52116002)(66476007)(107886003)(83380400001)(5660300002)(6916009)(36756003)(4326008)(54906003)(6496006)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k9jTBvM8xpvUYIreMECJmdcNrpiZcnXX5QW9G8eYYN2ykS9eGzlTOuxt7+p6?=
 =?us-ascii?Q?piOjwr6pQlY1XLaC6eRXuf/T0LMTMisSrf/U+iqb2JuuxUBJzGKn/ZN/Kun7?=
 =?us-ascii?Q?OjHXGGb9+xeKJUkW+CaVE+DvQS3iufhVMF1dWl5PkPtUtBHpg7IkNx1gHmXf?=
 =?us-ascii?Q?j9ahkNdLEqp0pNVuuUO4hIoTMGzOeR9F3RGA5EtXRAN+u386gaWArvSzEOZj?=
 =?us-ascii?Q?6jWmtYt5FNlNFW2uPCN7C7jqfsNBeoQcgm4Y87ZRqY+Wz2ICyf5Tizaf71TW?=
 =?us-ascii?Q?xqPFEDIxkwzMVXOSu5cmF9TxKzWK/oVAN08ftg23PvCn8yL6jz9bAq4lsxOz?=
 =?us-ascii?Q?y8L8hG2zq48SM5Pa43++QqO72tgHxYvKb6960C44UqxtBK7Z2Cju7pblpy1R?=
 =?us-ascii?Q?PBMuJW3eKLRaaAF2LCzhh6ivIFRtihJ9oMvmrSc9HnRRNczqG4YbdsLlvAUX?=
 =?us-ascii?Q?sm1t+Zllv4vykOL3X+SWphxtU/Sn/xC74CwQvALe4PrjAu+02s3/Yh+ddm4F?=
 =?us-ascii?Q?5/W5ODlSRD2inWIBEHiyDLJcF+ryd2viXGvjRI0NEGlu8X3d3POo7WBAdceP?=
 =?us-ascii?Q?dNFzV1+iUttZH+VM1EYyOgJnX7/YcnQ97KeZEahBzbCYYgVnqz490jzmOk5E?=
 =?us-ascii?Q?OIE4+wKBhXV3yvqDOP0wJcHQdQuKNOXLJ42dEpWv9Idyqftl1shX52oGQ0K0?=
 =?us-ascii?Q?ahkCukBm6gR3aks8W5oFzaLPqiFdVvFFVDqTQ7SRpxeqAVV82RwIRmkARjH8?=
 =?us-ascii?Q?CTR204/xjzGWR7w0PytizikwtJdEnQjOdr1x4Yy7mmj7tbitZcyzdV2d2Z7k?=
 =?us-ascii?Q?UvFQxjuc97uaFb8XmAeCnld+vnhDr4n3XoYy9FeHFIJ+iCeH4FC+nf9+vw+K?=
 =?us-ascii?Q?EuyC4m2DHNJDRpxrDoq0ys400l5/HFmPCQ0j9Fbr+66HRgRNlU+nVmRdbxzs?=
 =?us-ascii?Q?2iTk95NmlZ8wwZ4lBGEFRgI2viRRQdv8AAZvdpCY+nl2s817/8QviP6xdlJH?=
 =?us-ascii?Q?fFzHODWxYYCV+o4h75oUW82yorVhvlM7EC6rOdHTCRMxI+GDDX1/NSayDY/C?=
 =?us-ascii?Q?S4YOjrgM+6CCE30NNdy7Xr+pCSHnAZ0EkczLnkmgHHCs2sLLs9yREPI4U+80?=
 =?us-ascii?Q?UhLvyoiu9Xa45PrzRPi8OOIJmmwqd4mYeDID3PFzpzvrr67OuHUmZNQw4CEl?=
 =?us-ascii?Q?o+cpMSaGueKC8dh1Ls0hcGMoZOQZ+ZbTYaXfyYh+7UzXZ3bBlqpV9xSCdht+?=
 =?us-ascii?Q?3Ny3XYpGvxhs4S6nUfTSosklAhl+QQ/CyBK2rrqxmMy8tsLKtXViWPPW7Zra?=
 =?us-ascii?Q?bdJFFKhE1YFXJ7gq4MaJ4giqhnBe+eTXb5W5qpMr9UUusDNaS9QQq7C8nuGU?=
 =?us-ascii?Q?n/+MyPHzrsqgfR9r8+Q8A05Vt1+ACGuwaXyPSyh/1YIHd5gTSN7WQY673fMK?=
 =?us-ascii?Q?UgABloTNtYeMoI5yTC9zvcNRLV8jcioeKC/tIkpR6Pvv4T42XwR0keiayWZ1?=
 =?us-ascii?Q?gkDOtwaxhSKez4ogW1EAYFdiEpl9F4PnTlGEeKmvSdhep/I+u03kZlQNEaG+?=
 =?us-ascii?Q?GwjCSXD5MLlMlpWqn6Qaj09Vu5U7JyHtLK0eUYoKyTbY3DayIAmm8ceQptHD?=
 =?us-ascii?Q?BKMxnnG0Rnv9X6OBtjTmjMiIBqSVmg9LqzVchPea6+Ah+DNGSR3/1D8nYWMz?=
 =?us-ascii?Q?dWn72iFCnEK+ZhLVmq29IKwjEddyru+WqGfOP9EWqjaDz10/Ry/E6eUYInPQ?=
 =?us-ascii?Q?ZQ6SoNzE6g=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 36aa94c0-538d-46cc-2303-08d9a8522685
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 16:08:23.7585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACfBnk66xS6vDBQI30JEQTi2DMsUVKtJ35qBWqWXw5lC+op+jMipAc1Im3T94UX4FJAUK+8jdRE8/uk5GCZ8iARGfRqKWf1r8xxsVJfT+wY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3866
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
index 7913e206ed..87c16fcee1 100755
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
+		tr -s "," "\n" |
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

