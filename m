Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90C2C433EF
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 15:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbhKTPHY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 10:07:24 -0500
Received: from mail-am6eur05hn2201.outbound.protection.outlook.com ([52.100.174.201]:55837
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236770AbhKTPHU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 10:07:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJUaZo9vpYc/M2S+e42uiJAwlcDynIOCCWNlFi4bRFOKMva48QKGLTbl/RKKwbVvF1/hNc/uZ2UMNlZoDXYmyrU1Wu87NpWk/MBgEwjzP3P+uqOOA9sQHw6rzZAf3Y4pMNK8+CrOKjajr2Gq+n+wLh1Oj39inaLODLzRfa9/ctbuKlZE5oxl3afTDG5RrVDehXEia0a4WAQAJP5ZjvdNVUXXBG/iZz9xLemrmhE1O7IXWHNJXIPPF2Sl1b6wAlhPSsk+y0lhVzJ05G1HYCguG2ena8wPLvSfVAUaUTBdjs/WSM06AUao01AGAu+Sf2rjLYR4sukTanAzb5abc/98dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4CODN1keFMLJ+xjhNOpdxv+3vbb/yspcqqM6AA7LDQ=;
 b=Dhbjc0iVKvY1e+rnOoErhy/d7W0WmbVlLx5IuXBaRirFdRkwrujdDIFJHas3qojW4/C91BAE2xsmkrU8jGI9EdYyz9XytM+PK5YJ5qI1fmOF5OdYhyrA1+61GQGEHZ03uMKp1GTfcBqYtUgZvk96pjGrvZpcRex8F4hN22Q6HcQ3Nm7nV6xxAPuhPkRfeFpgZGNHpAYktPtmBDQENq0+diC2tJ1frvMtZSI7FCy0S4hqiWbaGsQUefAgQvsNjaHMh1CFUIQMJlQW/imt51N/yZjwUtrvvobaYCO64/9Kt0NGcNxV2x4brtGeFDouGoM5Nx0gwTBc2Ns0FhyLaiunsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4CODN1keFMLJ+xjhNOpdxv+3vbb/yspcqqM6AA7LDQ=;
 b=HywG/x/ZJ7N67j/WZuAbyrFELIQRdxdOwvN9a4kmQQfzBux7FR9GO6xKhp2Xg+xZBECDdjbio6WxuKeJXMlwhHMux047zuO6Kp+UjQr6fey9G6whYsoAdLcNTU5v6LJBtdqP7CTChkzrYWxXwTlnkVfIdhoRnyl/tWqTzaRbf5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4799.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:156::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Sat, 20 Nov
 2021 15:04:13 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.024; Sat, 20 Nov 2021
 15:04:13 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v3 1/3] test-lib: show missing prereq summary
Date:   Sat, 20 Nov 2021 16:03:59 +0100
Message-Id: <20211120150401.254408-2-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211120150401.254408-1-fs@gigacodes.de>
References: <20211117090410.8013-3-fs@gigacodes.de>
 <20211120150401.254408-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P192CA0001.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::14) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by AM6P192CA0001.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:83::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Sat, 20 Nov 2021 15:04:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20fcca0b-b56e-49c1-dac1-08d9ac37036c
X-MS-TrafficTypeDiagnostic: PAXPR10MB4799:
X-Microsoft-Antispam-PRVS: <PAXPR10MB4799742A15EE8A7FCD2DBD63B69D9@PAXPR10MB4799.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?igPzVupZu+DAyGoCjFJfWYHuTJZvPEPRWEitOhEN7MDjrOEJOW5PN6k7jVMm?=
 =?us-ascii?Q?VEbpkVqGL6/1or3Iaz4t14Vu8NGKgDy39mw5EzTwtSGsEgg5rRNBDNLqDvop?=
 =?us-ascii?Q?ulNygFSULdnqMbP4+wErGhL8MMVDmxt/fn6IQ/KvRnww5Cwtp6lKB8JHI73/?=
 =?us-ascii?Q?lPucgLLSVtyt4LmNfqpcN1jezxG49OgIZ/zTtcmtLjQVP7kZ0yp6nRIRvKH2?=
 =?us-ascii?Q?VcthK7OFZXN27OZxUk6DtpY/mORZDMtl72tsYUqml+gJjWaCwBlIQSEGjhmF?=
 =?us-ascii?Q?M9RYd6fWN87nS72A4p6CKXame7PPX70Rr2aeeXTCJp5VCl1B6h2IpF9Mxxcq?=
 =?us-ascii?Q?9oskdBjq/5J6r8xwMT6Jcu6Agddv0pSJ7o+WqkSoWtZ/xgxZe3DMGrmAd+Pq?=
 =?us-ascii?Q?JDwt6lnZBuhoma2aqQHIp/GOBXbrafl7Tejck4sBOnOUE3dMdMdGVOHj4PXu?=
 =?us-ascii?Q?3Bq9stxrEaLj+9oysh0UxjX10oYpMmBWwPT8zFeruO9u6I7tkZzF/asZkDpG?=
 =?us-ascii?Q?TAj0F0H3b39WD6rey7uhAsGI09YPwS6lsbwHdx/6CT06DmQAd29S+IMxv9oi?=
 =?us-ascii?Q?d+qAb3soBSMCRaRt6GElaGrS1RYW53dF7URbKVIZ0ACnboJr78RqNjhI2E7V?=
 =?us-ascii?Q?SM5GUcGtIAILcBxQgpZsCqNrP3n15jehNayibe0ygOHHQz05J+wbUPsrEo4L?=
 =?us-ascii?Q?kvKvhFRgr8OxpIaWbFlKw/jRJkowncprzsxB+Q7i9AhTT26GbZS9yXgzmh9d?=
 =?us-ascii?Q?BUjFiYGalCKHIPS2OpDYFYJGpUActpmMUG9cbeVFfiXT042FIkr9QKeh/HQD?=
 =?us-ascii?Q?WMOe9zIr/h3wt5kBrp/LKDm0y7o8nwkPIjBecyvkRry8lBwBaokrfysmwgtI?=
 =?us-ascii?Q?U9sfmzS8PXuPWBK27tYZxZGHbjus0EL/gUku7z5OJ3LdlmNI0z2suBcT9WUe?=
 =?us-ascii?Q?Au1hkCU0/eA3Hbri512TIDlDK4zMqaDuMeOwLooNzog14BeVTqWGG1Y23bgw?=
 =?us-ascii?Q?UKLqOt/Fuy76QFvn/hRafah/mQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39830400003)(6666004)(107886003)(2906002)(66476007)(316002)(6486002)(2616005)(83380400001)(66946007)(66556008)(186003)(5660300002)(38100700002)(36756003)(8676002)(54906003)(4326008)(6496006)(86362001)(8936002)(508600001)(1076003)(6916009)(52116002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ebFTc+rThYkKxQLo84xRJpjG7vhyTmKaMBvDgAvK/MpgV872qZ/40NPzEYMv?=
 =?us-ascii?Q?X5rb3WhyLgOsYhxazdcvrXSXN2umSZfGRgXcmtH2+r1/99bp8XkzD6XPJY7i?=
 =?us-ascii?Q?Jt/AscMWX+dZ09kb3AHNDNkUmmonJ3ZnSOAKNGibZWvqWU7hf3rzpr4onCvZ?=
 =?us-ascii?Q?+AiS1MfpU3WTG/xZODWaX15Vg8Nusk5tl/fZ4N57VKcDXALTYgavYhu2xqEu?=
 =?us-ascii?Q?h4AFuE1l+ioWKSXp6cWwHp8lw63gAySsLyFrzJckZyBF/1oqTydDcj9ObzNm?=
 =?us-ascii?Q?VGiZKbxAREVB6+ai01tYsMnXtlLRRpOUbjV2DpnYzAMx0n6iiuoTQr/xBcdC?=
 =?us-ascii?Q?v31vDycTMSRntZq6EnNS8qKETCvmC6DdkmLdclAXBm6H9icAqARyHrQ6E+Ot?=
 =?us-ascii?Q?2iqR8hFRIvzg6omVAx7YkkK6p1Yz7PYepvxsJeMseHFFAFLB/CMYhCWnFUTB?=
 =?us-ascii?Q?A1Wsrj7sQFUHQx909UOCOr/FxFw2TEv8/vs1JVcVHgmxr+qPLEwB0IEd6CZa?=
 =?us-ascii?Q?LdzIJB/NMOQ3HAwjQotEC8VXcKaOpc4o7vbMFnDHp8rwSOXD6k+Ht52NjuAG?=
 =?us-ascii?Q?TFVi/grUpweLcSAQ0rEytOliWIpJE/77+jj9bKathY+8x7k3mu+O2GOfUlC9?=
 =?us-ascii?Q?vw1bKy8qZuZ25pCgUv308KvtJnthdHnsRWJmxCT+yXteXwNEzLSFZLmCfB2Q?=
 =?us-ascii?Q?UghkUPikeZLDpDEqAfMrK5KMU0LkuZy84PHzpQkEHNS+lcCUBC9NnhAkt8OQ?=
 =?us-ascii?Q?56LDxWGbcn8k3WEHfDFCC5B++e7BWErg2WiKsaZhKpXhlAdYzv52Tr88t6rm?=
 =?us-ascii?Q?LQ5XKoBp7n41h8EsgEK3HPjyvSdsNnQwpJDE+Qn75IgLfPSlZwpEpFBxd6mP?=
 =?us-ascii?Q?BDhK4ux9WF4Soz/t3qpUlzmuy6wy7SeTzNj3fbCeM4yRMjOZwSDLjSGRRGQ3?=
 =?us-ascii?Q?isfs/+T3DdVDfZZY4jZtNQHOFxCmlLgcIUt5beZxcn6l3nC3GTRGgnAXaP6k?=
 =?us-ascii?Q?S/T8YMvDtoA5dEckichm+3kSIGnBDhbtQQiPdF+yUji3Ebo10IQnqNXL1vF1?=
 =?us-ascii?Q?uMVDuaj/XmvpgQWyem0hdZ9UhOh8nYRzRsUOequufs6z0R5hDoSwl6Z8CAI8?=
 =?us-ascii?Q?yaOnpRNv98x4MPnmug4GeTlIxnZb+evueU6z2aoQ/8RmiNwc7i/OAQfvWRYw?=
 =?us-ascii?Q?igcjyKKawDEelNOjz+RFi+U1E4A4fG84DdQAHRdkuu0fegRwTgVJ+0G/lG07?=
 =?us-ascii?Q?P52aHDs6LjsyMgmkm4zhQPt4m4ZJn5AsC3lSC2XCsGc0bIirS5iAGuZ8Px9e?=
 =?us-ascii?Q?wRZz28mHYI9UygeGyiXBbo/qWOH369f4A5HEqaZXSRxuPLukfl3/qHKpEGlC?=
 =?us-ascii?Q?gYAxBlgQr482cJ7mcmsSuKF1a9qPoAyhU432mmvbKyf4Yd6Fp3nUklQgYBjx?=
 =?us-ascii?Q?mSc5UO2/b34f9/jTSUvSpvvFNJ9Fy1cmKQCxmpjicQ19uVAOktqV8dKjtQm6?=
 =?us-ascii?Q?7EM74zP1y8FskeL9xY9FEsbMWWP4QmuVuIm69+VVKXcIK/sYY7saAArZkRwb?=
 =?us-ascii?Q?t/utQbPgYsN5DK4VTxjQl0Kckt+z8hmqSAPKOQKBB+Yn+m8Udj3vg2MNlxf1?=
 =?us-ascii?Q?9YGMDdQPNzhFPROLMPWudDtJF4QT+f8I3lP1mfb2XC+gug7KAp+ivO8aWp9p?=
 =?us-ascii?Q?uTmrN4LE2EVoJQUDDq+oDDNfOuryuzU9SFGOrq9NaKXMx/4a5TV+njHKSyRH?=
 =?us-ascii?Q?TPKeHn9CAA=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fcca0b-b56e-49c1-dac1-08d9ac37036c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2021 15:04:13.1315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4XZwbakD2cfR5oj1rDCnSSAJo8KJv8DCtf49TXs4AmYdZnRWSQN5xdq/0LHnVC0epOlDBhp2/kVYIobEWFBS7Wc14s28bX9A1cv/7J6/heU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4799
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

