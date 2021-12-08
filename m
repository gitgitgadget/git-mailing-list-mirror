Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65908C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 16:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbhLHQhl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:37:41 -0500
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:45379
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237152AbhLHQhh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 11:37:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7jVHbg7x8pFtWqP//QgHRdGp4Xca9wm9Z383eXZSUd+7L+T+Vk9KSXD2w/zecSGaALddqsHUm1YhaqJvteAMnc7hExBjOoxOBi4ICGUDwTaI6pMd92Bs2kpz+32xqZZ6IAnIBzvUvbxs93pkHkPFmpdfCaQvLjSmgkEAUPzhYuLOk7LIpzQSEnYIdb7roYVeHYJQfITUgqUnLI0+2vJT+vBygdgu0vphJL53809yOdbUw7ESfF+rxfToYCf+mZPcQ9osKHHkGo3XysunArR5xL8uJKW6Sul+F6SLQzWlEM4tzTUutCFAmkupRJmRdREQdb5TYz6X1rBKLXklZf5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2//R/JvpBYlHHF6SW42QbTHoCJ6ZpVo0aDm8Sswc3HM=;
 b=LBjUQFweuxsQ8Wolyg3GGLGcErM53Fzw4aT+xfvNbMNZ+5nvzAhHFZ1fTOcHkwB9gU88fnFfM8oVmn7TL5VmDrN+Q4By/3ScKbfYbp/5DRa5C5xbl+WCLHrdZVSyHQTpcHktdkFMCzoNGXJXtJm+Lmwr9f+3mLcQebnqS3PaYP1R99lCXQ8xGxc833Ms7QaAdYxwqhWp7xG6NYofsDN4T+/yasb4TzwNgGCmc8YrleCCAWzbAwzEnLiiTUpyrwmAdkmvxubDaQTWiKrK4SowBSyV0ZHil5ofX6el2XpUBWqEsWbSQflcPtkk6E3O+0VYk0dJyiC2ozjwc/UDsDB8jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2//R/JvpBYlHHF6SW42QbTHoCJ6ZpVo0aDm8Sswc3HM=;
 b=sE8j4heCPXubcf0Os7Xb5mRfvaOdURn+MDkGghpya+QauWepLLsthg5q8bYZEbOwzH09g4RZGzDA0ikKIJljdO/S14fUYuinN8tWo3lW/sIxuTZd9jgg2qfBU97uI2ZVh0eBHsDYmWgRDhf7nqe8bUrYDnkX4tI76/V51n6ewNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3914.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 16:33:57 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Wed, 8 Dec 2021
 16:33:56 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v5 8/8] t/fmt-merge-msg: make gpg/ssh tests more specific
Date:   Wed,  8 Dec 2021 17:33:35 +0100
Message-Id: <20211208163335.1231795-9-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208163335.1231795-1-fs@gigacodes.de>
References: <20211130141112.78193-1-fs@gigacodes.de>
 <20211208163335.1231795-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0197.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::22) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AS8PR04CA0197.eurprd04.prod.outlook.com (2603:10a6:20b:2f3::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend Transport; Wed, 8 Dec 2021 16:33:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b99b7fa-0223-4406-2b3f-08d9ba6887d9
X-MS-TrafficTypeDiagnostic: PR3PR10MB3914:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB3914F437466CCC12B44859E9B66F9@PR3PR10MB3914.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R93HCLtgMGKnaHxkcDB6Pv5rQp+LNqgk/tM3biOO8mINXWOYVAfFDsxYjXYLl2V9hNY12VLQ2BF59DnHgNlLJTU3J1aNWuYSnyEbr7ezQbNDj3SaWlHDptnG8LsUlmdsuvzHdik8Nob/8g3ajHuJQ4QIuC9x3Zs2OKUnaEg0IYVJ7EyhEI1ernqMCM3mD4pgrbw2kHPIszxjny31LFjeaBqXh7dXFtlC00H095UWmXEn0V4dsUneZl+YcH5LQ1jDXKislvjozeEZylPY5zg+jtMKz7rRxL2+L9QFdbCSZVojQedCWfNYQG11iHpv6N6tohMfpASo0K2AffCIlf3VPug3qPr8Tm4lq1Bp6QDUJ+eY7Qron9AyAU8wYK60oBVlKJ3nXpm6hR1bHiK5gv39dJz4bKb6RfoFHb+H+uPXTN36dOIcF7Yb+Si0jO2mjbHfMxB4zHTfpjrOSk3Zqhw0uO+Y+oh4PC0AHF7XEhhzRV1Mr7WFL2Og80tRmhHzZYrXGgC1h5tqiuo8Wt8lebDaGU6HAFTBR4iMvP46mKsAE9Ub0Z1YFC6HLKlO20dREadCjMZN80qHhQDQ6qtKgb7sbO6wvJRzl+hMLdwze/F8QWFFHlPUPwndmc23GCM+iRlqOwXj3TSHHXqhMCyAL+HNaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39840400004)(508600001)(2906002)(6916009)(2616005)(186003)(6496006)(36756003)(38100700002)(83380400001)(66946007)(8676002)(66476007)(8936002)(6666004)(1076003)(86362001)(66556008)(5660300002)(107886003)(54906003)(4326008)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H4UoED2xchLap4dL6OMaumlmVHXqu5VLPPFj2coViuvTyS/UepWTXO/pomLm?=
 =?us-ascii?Q?86/viAXAwzHKjZxfyMqe2l4vCO/BDfQ2n85bZkw2YdHevA2oeD2BihEeKvxp?=
 =?us-ascii?Q?O1JeXEI54ajBhdAkn4MK9qF9vFxG6AKVgXcFA9z0ZM50XPIVCyugtGvOlePS?=
 =?us-ascii?Q?71Pmlg0z26f9FhJa/0ROT56jEbnKnBokMu2vRks+7KBBQ6SQ2tL7t4hCR5Fg?=
 =?us-ascii?Q?R/0nV5PycWfK7PWRZeggpkop1WGlAY5yyFxvOOOVDCctMVQJXbx1l+cqB0hL?=
 =?us-ascii?Q?BWcqJa0dZpvrjDlpSUgLdqNAH2n+hUh2S0fo11rd3bgx4m7tzTX5QmS6XJo6?=
 =?us-ascii?Q?fwHokIvYk4fkDzGgnf4YB6hF5e8+OmMoo5jnsPbIabeoilxYXl6DmbTSiBCR?=
 =?us-ascii?Q?nGSbFuRXj76cKTaG/jyeNukxQVEtLxk5LvExRmf7m1fU6wXZvXE2dwMAcf41?=
 =?us-ascii?Q?zmoX4m1AW9grLCFllcv/0j8DV88eKuxAvIhLgf5lZiuxMexIjryf8ZdjQK7h?=
 =?us-ascii?Q?X7fXCCR00dNzQpU23dmWdGIE79kMi18eIo3GEpTb6YefZ6WsUr/ycR6xpokF?=
 =?us-ascii?Q?ui+nH3SCAgs4CSKbLNL0m9/1rJprpZK1D2tAQzi91L8uRlspjkJpIHbafdJq?=
 =?us-ascii?Q?7OyZxZX3V+ZRXxXSp+CnINliQc8/VBZRORSU7dS9/VvrzX7duxw51SC5FB6h?=
 =?us-ascii?Q?fljtcLB4Oc/zPbVD3M2jy5xYdtEcIP+5A4SCueBDHCtVfwuU0KwH7iBVKbNY?=
 =?us-ascii?Q?a0jta+GURM1//eDyCoHU4u1yMa+QQnVOCXdKO/DsgUnQbqHFYM2elWQCZ5T9?=
 =?us-ascii?Q?FCkAR3EHbOZJn2NpEL6o2yRrIdNC39bmQNmcSxhkHNIjIdmuaprd3xy2CNo/?=
 =?us-ascii?Q?N7ExVLzFu2ycq/+pJ2cej7k+78tS6ykLKvgcjp6i0muaUQXCfScKW1Aj1p5/?=
 =?us-ascii?Q?BBsw3ZGNna8thvEo8d7/7ItOm5aGul7qpcLzaNUt+rrYaXv1n2eybE+zyrR7?=
 =?us-ascii?Q?vgELH6lWyzBLOwE7psw8M1TTYriBPcXeeuz027TbjzeQUvx5FhhWa8mOYxwa?=
 =?us-ascii?Q?s/xO6/Pl58uo1qhhT2129io/VS9MkjyXv6qsEvyufPyyHkPKgnO4BFLoeqTX?=
 =?us-ascii?Q?LEbrnzjb1kypErqWRukZVGqtuWgq3hRnkr6jYeUwkXE07imGzSybtnVHBIA9?=
 =?us-ascii?Q?/HAKA8lIp39wHDu/CeL+sl8wT7V3XNJJVACGTljUWprLUOp9iltnpS7hzv6L?=
 =?us-ascii?Q?PW62oUY0f/JecbZGpur1Lf2C1IV4KwtQH9I2C9lwgnnmYaKeZfno+5wadiLk?=
 =?us-ascii?Q?AyG20e+lz1PUQReliKaxqvUuO18q7wm6Q/odu/16ZP14cV99m1GCfe1wa0GR?=
 =?us-ascii?Q?o57I4DZ/GZMVarb03gZytPxqKOYe4v/wVmZXXNZxoohv7kUBdc9iWGS4zBu0?=
 =?us-ascii?Q?7squlPUy+DxqfsWDQQsISmeFwBNutIOFyr53sagJx5a1pX6BDwMCN/0/ieiM?=
 =?us-ascii?Q?ue7KZUjfzus+ozdIEgbJFgcagGgeLpQmDQ2MRr2yrIqRGknfS9QkPPP4nqk5?=
 =?us-ascii?Q?iQ/nidOiY0I9JCbo6QmcJLIlKXPKaKbYy3fDeFuYYKQBHB/+BhHIbBycBIzN?=
 =?us-ascii?Q?zqeTDNdk23R3sdRftI1l4IPpix2hwa2Dearp5dxDOKMhoUNpL7RDYeLo3ZUe?=
 =?us-ascii?Q?sEXAPpiL30dZtDyxdYyfv7RjQpy8EHXZvz/bUZ2fIDdFhC2IR9NISo53p83S?=
 =?us-ascii?Q?vxTiNqj5VA=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b99b7fa-0223-4406-2b3f-08d9ba6887d9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 16:33:56.8884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VaCBIrEznEBHVU29ie7psH0qsDLGXgSjW+GGg+DT8w8eu9jqdKFUtywgnOVsc1jhmdmPnaeWQlP8yJM6RhoKr/FPK3CNfZYdDAYlrD3/2T8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3914
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All the GPG, GPGSSH and the new GPGSSH_VERIFYTIME tests are redirecing
stdout as well as stderr to `actual` and grep for success/failure over
the resulting flie. However, no output is printed on stderr and we do
not need to include it in the grep. The newer SSH signing based tests
are also missing a grep for the merged tag to make sure the merge
message is correct.

- remove unneccessary 2>&1 redirects
- add grep for merged tag to gpgssh* tests

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/t6200-fmt-merge-msg.sh | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 2dd2423643..12a1e62bf0 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -124,7 +124,7 @@ test_expect_success 'message for merging local branch' '
 test_expect_success GPG 'message for merging local tag signed by good key' '
 	git checkout main &&
 	git fetch . signed-good-tag &&
-	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
 	grep "^# gpg: Signature made" actual &&
 	grep "^# gpg: Good signature from" actual
@@ -133,7 +133,7 @@ test_expect_success GPG 'message for merging local tag signed by good key' '
 test_expect_success GPG 'message for merging local tag signed by unknown key' '
 	git checkout main &&
 	git fetch . signed-good-tag &&
-	GNUPGHOME=. git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	GNUPGHOME=. git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
 	grep "^# gpg: Signature made" actual &&
 	grep -E "^# gpg: Can${apos}t check signature: (public key not found|No public key)" actual
@@ -143,7 +143,7 @@ test_expect_success GPGSSH 'message for merging local tag signed by good ssh key
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git checkout main &&
 	git fetch . signed-good-ssh-tag &&
-	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
 	! grep "${GPGSSH_BAD_SIGNATURE}" actual
 '
@@ -152,7 +152,8 @@ test_expect_success GPGSSH 'message for merging local tag signed by unknown ssh
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git checkout main &&
 	git fetch . signed-untrusted-ssh-tag &&
-	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	grep "^Merge tag ${apos}signed-untrusted-ssh-tag${apos}" actual &&
 	grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
 	! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
 	grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
@@ -162,7 +163,8 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag sign
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git checkout main &&
 	git fetch . expired-signed &&
-	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	grep "^Merge tag ${apos}expired-signed${apos}" actual &&
 	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
 '
 
@@ -170,7 +172,8 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag sign
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git checkout main &&
 	git fetch . notyetvalid-signed &&
-	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	grep "^Merge tag ${apos}notyetvalid-signed${apos}" actual &&
 	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
 '
 
@@ -178,7 +181,8 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag sign
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git checkout main &&
 	git fetch . timeboxedvalid-signed &&
-	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	grep "^Merge tag ${apos}timeboxedvalid-signed${apos}" actual &&
 	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
 	! grep "${GPGSSH_BAD_SIGNATURE}" actual
 '
@@ -187,7 +191,8 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag sign
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git checkout main &&
 	git fetch . timeboxedinvalid-signed &&
-	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	grep "^Merge tag ${apos}timeboxedinvalid-signed${apos}" actual &&
 	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
 '
 
-- 
2.31.1

