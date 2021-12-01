Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B75C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 08:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbhLAI4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 03:56:45 -0500
Received: from mail-eopbgr00072.outbound.protection.outlook.com ([40.107.0.72]:3017
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242123AbhLAI4m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 03:56:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0RG+4EakLYIAxHWqG8nB9cHnMnUL3/u/ygRDwnowR4whGK1nLF2PTjzxko1q2I80Ax+J4IjjMEWf+sIOLQtCIjXohVcQ8hJZrcC1fklApE/XUUGmGrOXK3ZubHDNrjAj/eie3/Q1hwtWuou3zqNXHBGCiD7Aqq7rgJjCHEAi7XHIfx1ZgFxa2rbsJKBRY8dhzHife2+bI0mBWlt+epxylKoG0BUESZLGGv7/rrxSovGpCVwCqkLIfATx91ezF5iHzgbGIYDDoUYwhZX0v9RxNJ4u2kC/JFcx7R5cF46qHQ8grHUg3PmlpeX6u5xy0OBtf/9777SkVjvzCmGrP+7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XolakqfPWYWHKL+6wqf0S9fgpJNjIbDM11851SnP4ZY=;
 b=kQ0IF6GYlhvavzJJuJI+MoMm07+mjmCcSCWEqL5b2TJ90HN5qYkmyeSIkpO+kw4fYB+KNuFCFhY5NENeI28xHMga0oKu/Z+cL6Vh+FaQzCjeUT6xjvIhtNoopjO6zHXH7Y6B0PK1oYl13x4ok0Z1tNQ5z90zVb8FtaSNsRozpbDCDn/IlDYrmMBbuIUQNcPTtlm8lNaLxD/5YqP3+mILLncJLY4xuh3yv9w5Jk4Mc6Xwvt87EO1hhssAdRRIAwXD0Y00U9bOoaM31Qe/jO6jJb84GC+3VUqPkBITyCsMEz3ZvHyEdLvxvh4yPYiRH6IiunvnQPvmu4qO1FBd/zkVhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XolakqfPWYWHKL+6wqf0S9fgpJNjIbDM11851SnP4ZY=;
 b=p2TQXd036un+4doEVsjhAvKtHg/phb9NEG+X4DyBsJpMe5E2dGZT27A6sdVo0gfO/FmQWxL/jZ7s8U15FVHs25lgsSra77uNPfnwIn052HQe/ohgrcyTcWGvipWIAP7jxruWyTWBhdPSxqzT6QSiqEFK3V5O/URPCkdCUetGBMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4157.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Wed, 1 Dec
 2021 08:53:19 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Wed, 1 Dec 2021
 08:53:19 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v4 1/3] test-lib: show missing prereq summary
Date:   Wed,  1 Dec 2021 09:53:13 +0100
Message-Id: <20211201085315.576865-2-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201085315.576865-1-fs@gigacodes.de>
References: <20211120150401.254408-1-fs@gigacodes.de>
 <20211201085315.576865-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0227.eurprd06.prod.outlook.com
 (2603:10a6:20b:45e::16) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9PR06CA0227.eurprd06.prod.outlook.com (2603:10a6:20b:45e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Wed, 1 Dec 2021 08:53:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8bbc7bd-1847-497b-1737-08d9b4a805cc
X-MS-TrafficTypeDiagnostic: PR3PR10MB4157:
X-Microsoft-Antispam-PRVS: <PR3PR10MB4157AEDD66A7689E99051BD0B6689@PR3PR10MB4157.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y6ZyTSClqF5CjyAcEE2D5YaEKG/82Rdo82M66pmITi5POf1KyFmEHHgmvSm/mLL0bQOMMA5L7zT5iD/q6pc/F9C7QCJ9rFDMWRhObxNxXvzwdr5Jhh+FF2ZNWkQcpHiJ6YON0zwYI+hRKZnXJ4S3/l1jCQJLqsFpIrO5GM0NaIYCdMHxa6Om4uigCalhHITnN5UChMCtHeUZpJCbNawvN4XdsJ5DwEB+ZF1iYfUeCdlFYePw8uznYmSQtVQPCLtDWKnV7hwgdRxciRpgcBUzCJXwQ0rDAet23r6tUeNJpJ2UMC6/vIK/jaBCt68GPxfQ7F5FRwHhQnnE69mNNw0v9eyrHOG59EduKV6tmogVXgRgYeW0yj/YUOGhpJLHjgE7vRnaJ7Yw3hmI9XqlQqzv/3BiBUrjUIeEWH3B0iRtl81OdLM4F4YFjiSGjuAXR24Zz1YeW72/aW6ZmXhDIZ1sc1gFUka8AAxJi+HePvE34PrfWDeQQ2DuBYA5x1OftFNu2nAXMvYa1q3xGGoHnXsgyFpx2+qWO6/arAqxZ/hQRDyh8VCfPemDr57ovMuDgueRmhOuCMOXyeFvYzCwiVMe0Q5IK5xrfNWeVc+OfjiU6Gx5GJwgXLlszYzRRXOMAGRz1P2IHQrJ+3WJSG5umiWlpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(136003)(39830400003)(376002)(508600001)(66476007)(6666004)(36756003)(66946007)(66556008)(4326008)(38100700002)(2616005)(186003)(6496006)(6916009)(1076003)(83380400001)(2906002)(107886003)(5660300002)(8676002)(316002)(54906003)(6486002)(8936002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oITQ7bU1iEO8n+tbM7DVAqrUf+zbLM24cljQQ72JbTYfBPZNdNLMVzHjLlpo?=
 =?us-ascii?Q?U70UjTz8RUAOQ80jg8mi7npWYF+3ejdGKRIm26zpec+sgsAXo2ZKHDHE8Uw6?=
 =?us-ascii?Q?tRXuwfvRfEQWs0AWdAqhIO2umkpzPkhQHlNI+MEeAiTEm6NPsYi9YvnMbVbz?=
 =?us-ascii?Q?RfL34wSGCETjqdY0jIXyjUB1EwQRMbFox67h2C2SnGbi0Der1R5cks33jHix?=
 =?us-ascii?Q?B7f/j47dO8lCxAfB3UndjVuXQkbn4PEnGLdDX4RiH/fTD2qyiFvS7LlRSaSP?=
 =?us-ascii?Q?+qKhhAlZDiw1EtF4XbkFytU7B/anbdJiziCrqsP4P41crdTMzDCGkssYRiKF?=
 =?us-ascii?Q?VE7ebzyzVu1qVikR5cfEwacb84sRjqQJr+j81+KL4r9E5ldgsSnmGH4xNuyj?=
 =?us-ascii?Q?whxFMigZqn4KI2ha7oCLwdpcEx29N1Q5S7z9ivxsU9znw9a1t0nRiqczipx+?=
 =?us-ascii?Q?M0S8kne3uAq4yEDshY+wGC3yUHLguJaorZ5Msjoi5JOgaBqYqMlxrojT3nEP?=
 =?us-ascii?Q?vq17BrhU9upYQTMgVqjtJslvATZdUz3sXxkkfqk0vQVBQVE+APkXAhYg1j+C?=
 =?us-ascii?Q?698shQGeNmtrvSNOgQPG95oKXVUIZuKLJ2J/lwLUeWQoxSCLXqi+q2thjcOK?=
 =?us-ascii?Q?a1YIc6hiVMGAcK7zV9P/35LaCIQqyMKTFXDNfpOKndofPuXFJjB5m7b5jISo?=
 =?us-ascii?Q?bh2zTV7ZzwH1btpjCJWeX+eAl8+I0QPHZPrL1jG8V1zJ9ubTvZRlZLsmzleU?=
 =?us-ascii?Q?r2fw19qSyK0lrBixo2f1DbB/nIiAR+4Qoq3F8WaT/CLp+2OYipZpOvrcoLdw?=
 =?us-ascii?Q?T4spZl75JdMy73XmgQlJhqHwzZR4Rgg9csWi2Uxwalt21/La6GkAkrJIVMJf?=
 =?us-ascii?Q?q4ScbCOlLY2h5909Zc5t9f3QCuLgZNZYEfU+BBPGV82llX7bfkq/C7o/a3nJ?=
 =?us-ascii?Q?cOwVoffsPk0DTq/IwFtGg/3ItqV3rQNkXRrCb0JwNOI6EGDrMhyZMT41PBuK?=
 =?us-ascii?Q?2rjEd7Q6ClTwDOzJdXX1IWIsy//3B8Y6Qh+oc3XxbOsyC3cYj6japGFCag/j?=
 =?us-ascii?Q?YupH2wtTZ5sy4Nw+lDsT30+yMhJfgxxNHLYHQR+PrSsl7gDK53qqz7hGZH0b?=
 =?us-ascii?Q?hHEFu8gyiDM6O2HcfPuaDCHoChgCx4PFKLirTCpk7dSzo92gexRi+WYuB4nY?=
 =?us-ascii?Q?lKl155s2aqcdca1VtVrSN0JEhfGC4oW54cRdpx4PK65OPBTPzQqzKJlqsfF4?=
 =?us-ascii?Q?BUe6F0OvLHUczDaSNoS6FENx7LRYNUo+XqQ2Ex3Jf6oq8SvCmoQzUVWXjc0y?=
 =?us-ascii?Q?j+VGkHksHoQDEDXnOIiFFbIgBSxAV2mTP4BCPYZ6EO6HVEUgHUUBXLN57nmw?=
 =?us-ascii?Q?Q5Wa9hIELC1ccnxAnX288aMK7p/JmIKIVywCYBOlH5PQvXo1izUnMDqvUmW5?=
 =?us-ascii?Q?T6jPexT/iSPuoqdjp+n1BeZn2+hmEhHnr6PDTRYTx3fZeyO6Ki/3C1PJNJRS?=
 =?us-ascii?Q?HH83JsotxpdYeB8NTYuiR1RT5JG99Q55s5TPpGJEkzI7b//i3af2oAM/OHc+?=
 =?us-ascii?Q?f24Hp3dcL0lCjEvT+g05hsD4cPXRPWgnQ98IqSy5dnP85sIU1VONw2Fgriyu?=
 =?us-ascii?Q?EWybuS80rqL1uK4d3/I4unuzxjwbu8W2ns9wDECo6soInrEJ4MshtJcEn07B?=
 =?us-ascii?Q?GOjEg1EKDskZSNZANldsXnpCr4imYptc0/me9PCrPjbBSmD4v0PcmrChJ4r8?=
 =?us-ascii?Q?ZLwqf8d3VYJ3VcxpWfelRCvKCYl01yU=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bbc7bd-1847-497b-1737-08d9b4a805cc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 08:53:19.5089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rjh7TpADTGtwkMs3sG6cCVOjBKFsm97Vyg0hTy7sDEEU4dPsOiNQ3hjEMphzqte51fCmEveq7FIo8tRJr3MaFzhf3IXg3iVjZ/L0WOXlFFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4157
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
index 7913e206ed..7f2b83bdc8 100755
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
+		paste -s -d ' ')
+	if test -n "$unique_missing_prereq"
+	then
+		printf "\nmissing prereq: $unique_missing_prereq\n\n"
+	fi
+fi
+
 if test -n "$failed_tests"
 then
 	printf "\nfailed test(s):$failed_tests\n\n"
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 57efcc5e97..9090ce1225 100644
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

