Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F0BC43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 17:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbiGSRWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 13:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239015AbiGSRWD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 13:22:03 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2033.outbound.protection.outlook.com [40.92.19.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3A448C91
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 10:21:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFqGlFKG7bfH36oho5z2sCptkg3dLKLPmU3ZaRRKN6E5P/RxsG32pAXtp2iDDKXs7BqEf9YFfaIOv24ouEC4Vep9U42MXDvpufqiYm+NEfYiXd76cMgKl9WvIcK9SeUAQEQCzXxNp9Cb6Zj40Hs35IgAn8L+09FchUYLBD8n7A4tjbXgnRohy9QsJ8yRDrwAyzG/dTc1ElBzlLddD0KUCnOQxcjoqKoO8BCncdBJFFmaui6wbbs2s1HwMGF8w7g8Jwk9b0D5ReTGlfe+SPfNpr86HZzSSF3QTjDypohN//eTUOTeVYENfMrpkS3Js35Q34HIc5JaQXjgRb9dnNJLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frujaX2g/4oI0cF/jZSVMs4nzUxnFzbkD+tyE19Dwoo=;
 b=jQk/RxyUd9tvQb6fwqjcIE1IBN9UvByQLQLbLQE+NqUKO6jxUYxlYcNnWhpO3fEm8LIMCAOW/qonbZzfw2XPEqwpc9aC0jicz5xQizIg5igCGPOjQiD/CqHUtbqCXJIFYb+kKade/vq3yiEpxJsBy7GDykCb1U2Eg5qJ6CWVNQbEnJcnV9SFsdHPXFgwzQ4qDeuH0Vbzc7ByUR2OEMI2NSAFaJEGdcf+ZrE9qrxye/qvrIjGKL4oTQ0X9uWe3M153oe0un6b5O3LMUCG8jpGbcVR8V4oRyB91gi9oaNxucs3E4uj3ojeup937HEgHOQgYmzNl7fmrr8pJRkIIg1HGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frujaX2g/4oI0cF/jZSVMs4nzUxnFzbkD+tyE19Dwoo=;
 b=i584LNo95FAR6BxFymyx0csJ3fKBPLq8gtKl8atwADRs7XLJONgiFbHT1f9cjeuXJHaZBFugDileFEiFnZN4AArxQZPp0rY0pouD1CNn6c47uoe6f4Y1O8ktR4qFHBt7T8OP6vtaZ6Oal2lb9vc/9+VjaO5ZpLJfwzzItb9s3coxTP2pdMr34cqAB1JcndSdzzzAbhximO2NhitxsEWly6WeQXB2WxOTYQu6VO4miygvdOCAvJGWY+G7hbu5QAIeNFukc0ZCQGR+g1uw1phm7bwNWgpEkZD4rT4bIoUSm18PR2zgLUvEZXdkRyoluF0sSr2/v7h3PeqnJesQoLWymQ==
Received: from PH7PR14MB5594.namprd14.prod.outlook.com (2603:10b6:510:1f6::17)
 by BN8PR14MB4212.namprd14.prod.outlook.com (2603:10b6:408:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Tue, 19 Jul
 2022 17:21:51 +0000
Received: from PH7PR14MB5594.namprd14.prod.outlook.com
 ([fe80::9102:6337:5382:5f07]) by PH7PR14MB5594.namprd14.prod.outlook.com
 ([fe80::9102:6337:5382:5f07%9]) with mapi id 15.20.5438.014; Tue, 19 Jul 2022
 17:21:51 +0000
From:   Celeste Liu <coelacanthus@outlook.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Raman Gupta <rocketraman@gmail.com>,
        Celeste Liu <coelacanthus@outlook.com>
Subject: [PATCH v3] contrib/rerere-train: avoid useless gpg sign in training
Date:   Wed, 20 Jul 2022 01:21:44 +0800
Message-ID: <PH7PR14MB5594A27B9295E95ACA4D6A69CE8F9@PH7PR14MB5594.namprd14.prod.outlook.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [zWuTTWLlkjq8SzJzo3t+aRmob80eHU8mWn9SApEJwVLE+DRRq45MexXg9f9EYdx0]
X-ClientProxiedBy: TYWPR01CA0046.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::10) To PH7PR14MB5594.namprd14.prod.outlook.com
 (2603:10b6:510:1f6::17)
X-Microsoft-Original-Message-ID: <20220719172144.393519-1-coelacanthus@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09abed3f-531d-4ba9-5350-08da69ab2b53
X-MS-Exchange-SLBlob-MailProps: S/btQ8cKWiRL6ml4iGf9rtH8u2be02mKpj6E2ieoRWNfOuyCJszh6JebBr0dZDhXmZvAYoareVammeDZmrcvlF3jTTHE9A3r2GM55u1bg+AjL8qrDtZAcpurEirR+pjWHSj6igv377h8hBOWDMHagT3ksEu2G6KSk2CfglNCb9K5zQdycaLMQqG/gANYGm7zXhJrAzgsJW9h3MdkAkzVq9xMTuoY/vwhMHdMtaGQwcYbDiKZ7esmukxQVMBRRq+Oq/NRwdrwqo7/q4mj9UnnLjfC6MNcD7vQHSc+WsiYJA53msxaM+4jhBwSe0nXjQSlG7hftgVTrBQCQieoh/326a7AuyE+ZHjlN+VWIxNqe1S2LqlxvxzUkhoJpmGq6YQ7YK0p51FuyYmPy5fxM/IOZEtldmkrtx4/WQNc6RrTcQdu48fyfcvHWmKrZkNBZACJ2ChBDWyGNJJMgRDZRZ7en/M//fcpQbANLe+V/Ee9uSe4ptbbgx12WJJjbAIoD1enIQz1OmyX54A7pKGcaxJnPLLW7UFgJx4VfY7n83KvrDE1K4YSF+t1LIBLE0Hv3lY6PsYrxzd1FvwecOqa4nUtEs7/rZjIUnc59oqFSsQ4EALUxgfmBe1G7TZI65h8znrVhSpkP6+AuVoi5gSVw6OwC2xmbkarbKiXobgssqJeAG1+4tX/Iti4i1Jqk8PRqUXi8uVHM2CnpKa4HzbagtjiwLv0A57ljNZNRZdVX/Guac1L6PeT0Dof0pqBzxlmTY2Mzpd5THnuuyw=
X-MS-TrafficTypeDiagnostic: BN8PR14MB4212:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJBAd6+ZaDqyWlFxSictxRa1TeixW/AJvB2LoHvIWX4MNc0711xCRGmKfJRcpyw42KpgVHkVeBcIICKDfLL8fqi6mMYNatJRr3m8YQhvXsqHg1PR1nOkv5rZ5rK+eZNKPGZBRsQSosbWgClGQxW08Ss1bPa4vY31Oj3gfGUNcRmPbmJyJl1ERg7cF0OD4LBf2cWAqy1SJslpHJnthlSg6wEGl42RdGgRe+tFxXJZY4jzUNqvf3A+89XIxeWXdbyeWDoRL+9kNNYVmWptuIWGiwIeghacsp/RlvPEOcDmXKTBoIMzujpJPVKAKpbBxPFIXkJJ2Upf0W5yuYuKBgu6RQidyOmMaWjRDHjBGHGBz1CDTj6kN5uRqVkV4x4ftN6hCXjEqyXMRIqoJRvLKTQsQHGf8571yVZA9WdAZcSz6YcmW08KbwYYCvHDkr1UYBmxBECdGhZzd1KZkFlwSwU4MvHSz19skioF+rTnosIH2kFgxx0xAXq1IYtqfVanWtfCh8eF3+ahHyiY6m2SAZ7k311NPXLKCy9Cm+DO5Hvqr/omvxAfekfv01vtBeJY5Ys3JjivfHVVaLc47n9Vw10wJxJNf+UQmgsujCszFrXh1CZRh7/vSsrXa7CMSr7n2lhnOHR72Kw3dKyIXbJGwxWHrA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+zm1Wyaf8wDfAMEGu+94+OUEHwJ8xhoViiUz9QO86Jdy1lvLiT/GCk6EVu7q?=
 =?us-ascii?Q?CNNO4QSGnbiN86K+F4gHCJ1Tekios6O4UWdgStDmFRQdW75kUwEkmFLgK8XO?=
 =?us-ascii?Q?AMv89p2Nx8hS8Qc14Cwg8TvpTHOPnGRTrvZxxpc7LJYdNr/4eKB82XgMs9gN?=
 =?us-ascii?Q?hecI2Z0zXIPqR6eAusNDbudFq08d7bglUAsa0qFa6wazO4NaTBuDIqL5A1TK?=
 =?us-ascii?Q?XQhAtRcZvnJ02ESptG3GvmRtUlZzRqppHNeExK5+IrrVm/e8nZCBcfTYyin0?=
 =?us-ascii?Q?4Y62Yw6ptSnlRU/PYcrLZ91sFE+l/Kxi0vV5v1s39cvOq2qY3pPecP1641YJ?=
 =?us-ascii?Q?8HrrzqJwH5g580RdSljRmH03Fpm5oKwcR8zgD8l8SP1/GiulW6aqyMPYKc9i?=
 =?us-ascii?Q?3YAPJQVLDXScDUt2Q0QZ9l+pfqaaCUifbTY27yQGzzacoJaLVIOMmpvfUFyx?=
 =?us-ascii?Q?CX50752VpDPRQJ8us6HDK6vA8mISn+TdsHaHX6BzbE0s6zQcr5Xd+dR7bs7l?=
 =?us-ascii?Q?QvUo1BWW4m5K3eVCQaizQ2qP2tWy+GcsBPiCb1q1p/kj3ncBzCsUMv19IoPr?=
 =?us-ascii?Q?lPDSD9YObk9b1khGI0ZOoqCBRu+yniOtcsAMclgPqGN2mg/VQlygSng9qgSB?=
 =?us-ascii?Q?2PFOxJiL6oKeB2engmWrkpclrWgyBwk/G22ytlSu9lcNwMoisXEXDyi47KqA?=
 =?us-ascii?Q?dfHeD39AnxyHZFauuZUbmS94BsaiIVkmScutw2/xpF/r39yhLTeM1EL5TDB/?=
 =?us-ascii?Q?7EI6M+Bb4Fim6aJaSC2Gwkj8u5gZlAz0A/1u2SXrvqq9xK8cqjq2gUp6iOYl?=
 =?us-ascii?Q?8mZxzFiar66umWsI6wG2slhSHU4711CdwJ57iBL0ery3eUK1/7+wJ86F8Eh+?=
 =?us-ascii?Q?n9NA2GjN4FwDH6Kw8NCOkW0903vofYGiCGWsMnvJte9BL/K1YETCyG8L8H6L?=
 =?us-ascii?Q?H5q7pDAXG55x2epLkMsyzO+A11tRXlNzwzH/Ao++JizL9gUeZq6+Z2jqewSC?=
 =?us-ascii?Q?GAZqqzx57rSK+63hudaNEmwjnFnpIKFo+gEIGZbUYaDw7TRX8zf4u+mfukC8?=
 =?us-ascii?Q?+WHcL7xUYwNwYp9FBwbgFHKkIM/3o+FAf5ZVZMha6nVI+5mZUki7MbnNpxwI?=
 =?us-ascii?Q?OMpgDnN2EryCLSGBdUhCD3XSGB1peB//OPljHaRaBWiFMqa8pcrqRpKrQMMj?=
 =?us-ascii?Q?8FwqSruhP3pCDs0IgY/MiEoISdBQT929MvuvKFiwMkM1zyQvBlQbclh9EcsJ?=
 =?us-ascii?Q?iMansDdOpsmbDM6rdDjui6NNIwf5OT0O5y4DUXKkuApblLXeLAsm8d30sAZu?=
 =?us-ascii?Q?nyF8OqrRHfu7548knnHTtHgEG5D8JZtKxJLnlZo1N2NHX+inHuow52I8lIQs?=
 =?us-ascii?Q?Ibbk58o=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09abed3f-531d-4ba9-5350-08da69ab2b53
X-MS-Exchange-CrossTenant-AuthSource: PH7PR14MB5594.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 17:21:51.5738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR14MB4212
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users may have configured "git merge" to always require GPG
signing the resulting commits. We are not running "git merge" to
re-create merge commits, but merely to replay merge conflicts,
and we will immediately discard the resulting commits; there
is no point in signing them.

Override such configuration that forces useless signing from the
command line with the "--no-gpg-sign" option.

Signed-off-by: Celeste Liu <coelacanthus@outlook.com>
---
v2: add problem detail in commit message.
v3: more detailed reason

 contrib/rerere-train.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/rerere-train.sh b/contrib/rerere-train.sh
index 26b724c8c6..bd01e430ef 100755
--- a/contrib/rerere-train.sh
+++ b/contrib/rerere-train.sh
@@ -75,7 +75,7 @@ do
 		continue
 	fi
 	git checkout -q "$parent1^0"
-	if git merge $other_parents >/dev/null 2>&1
+	if git merge --no-gpg-sign $other_parents >/dev/null 2>&1
 	then
 		# Cleanly merges
 		continue
-- 
2.37.1

