Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D90DC433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 07:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 060DD60E96
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 07:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbhJMHxV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 03:53:21 -0400
Received: from mail-vi1eur05hn2214.outbound.protection.outlook.com ([52.100.175.214]:21889
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238716AbhJMHxR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 03:53:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G71dapP6jmbuTwVEPL8/fw7GCPyJtfynOFawYCbpN+l7lKKLriAOLhgrYwZczByVuiKwq4IJ6HRIg9CYgdN8yFtkc0YmIWhOYq5LkP27zBybEjuLojm2nZxZKCctPwffu3iKfcdYMRJ3uOVeURLaUtu/5xHoCR572wPu+ZbkbbGB5aTnRVjQzFwLSHTjaYXUK9o7pC45XBCNhYyzevYhYESIVthDxOfx0DD4ip1EqkejR1fqtNgutWltSYyQXH7u/lZ9TOPzcW84BzUXj2BUgQPD35qvL22e7iJFqEehB4BoNhA5PIjRuc3FmDOtphDe/tklaewsUbJYJctJF3R/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4ad0hS/1dBg3kJYIeEehLPggwlEoFiSP/aZIEAwUIM=;
 b=DpnjYL2bou+CFZBXVMdqpuegaMYqDRx8cuE/M4SPGz5abq0VY8DOGsxyYI6XtktWFSx3y04PqHreGi6b6OdRW2Sy/3nSqMJgM49OCSHCz3rYkwf2dKsSAh9fGL9BclBpPRcTvzurTfK6Qtk/e+AJa6vpxFpML2TZ7rduH7J7QH/2/8At/ZMm0yIuqkGL5F4TuDFxyAgsTkOa5C3pW8noqxWLlRfXoG9h9JC80Yu9utbM7fItYGfnKZVqSI8mBh5IJ/nncr7BG4tuf0ABqc/FUOeP4q7s6xGPCPGTKK7/eNEcL39GflwW0OYP9sfOxepSQJMC82VnnL+NX2pg1e+Npg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4ad0hS/1dBg3kJYIeEehLPggwlEoFiSP/aZIEAwUIM=;
 b=RRJcq3IeLp/2j1rHbWOM03wLnaKWSYCoqa0HDZKzzllH2tqwuHm3Uje6FhcAtIAWwglihZjcFklP+ZahvnKSI/QPEdvjBhs+Rxavxn/iVh32KrfHcrFxue1WZTYa9G//OaU0ZnIWsTQ2PBjge5rNOhv30iZMp6E9pqw8x2tLzN0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4813.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:152::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 13 Oct
 2021 07:51:12 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 07:51:12 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v2 2/2] ssh signing: clarify trustlevel usage in docs
Date:   Wed, 13 Oct 2021 09:51:07 +0200
Message-Id: <20211013075107.8584-3-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013075107.8584-1-fs@gigacodes.de>
References: <20211013075107.8584-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0045.eurprd04.prod.outlook.com
 (2603:10a6:20b:312::20) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS8PR04CA0045.eurprd04.prod.outlook.com (2603:10a6:20b:312::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Wed, 13 Oct 2021 07:51:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77c764be-a2cf-424c-a439-08d98e1e39cd
X-MS-TrafficTypeDiagnostic: PAXPR10MB4813:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PAXPR10MB48137D60540F979E39E799F6B6B79@PAXPR10MB4813.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/pWyvaskdYKsBGLsy25i/98y12QtIdnL1v6KCBO+dNuyUyADbwwNZcvpzaAc?=
 =?us-ascii?Q?pd2Notnnb1Y0Hl3dUuZogXTJ9+HxtYXOeXlUhOXxfJCsi2EB352dAkEDOj/Q?=
 =?us-ascii?Q?RcvPN5aY+Jpz1TKeALFSi30d4kY2uJgaFwdNev2CZlXMb9uaDK2Q3rXKObi0?=
 =?us-ascii?Q?liOdmAcOx1MU73hhBOMmUCAmhP1itYG2zsNprMjYlX6jNpCAlsCAaRXyk30L?=
 =?us-ascii?Q?yae125jWsm6okoqFGMFsxM4JEzJD4+lqvMrREVf0/L19hjwWXQcIlLFwTGlb?=
 =?us-ascii?Q?4NQNpS3svRgKoIfbjZUAdUxrkZONVlZvygZFTzturo/GMSrkJI7B1icAo/Ei?=
 =?us-ascii?Q?GsA1M+j64Yzhdh+LD1NmT6+9mSBrVqSDgbDqbQe0Yh7ROJMNrgv0+z7/1ngm?=
 =?us-ascii?Q?6CodYC+9aTGx9amyrOBbQ1naPy14DxSZiTlr79n9OjPKtA+AcC32yOimtGpM?=
 =?us-ascii?Q?9d1iwEHTYr8jYs9vXT1KS8lRP6v4JQksCSY43r+QEiQnlEU4jc9wUwO9PWce?=
 =?us-ascii?Q?yW7FHWRPJWUndtlneBN7CS/Hs1jJzIH9v4hl4jXnE9CMmmrheWAOP8Ze4AjW?=
 =?us-ascii?Q?60XZF43UF9+kxkRup2llvyj6gkBifIn/mLnrYIxqcg9NrJTWUj9pxfYL2vF6?=
 =?us-ascii?Q?Q6HEOsgkri0h3SmrbGrR+MaiDHtWEuwHyWaVZcc0XDJrMTdprFlZKu3swe7Z?=
 =?us-ascii?Q?hE/OO1P6Uj13DtAzdvst3iVFCMz9CCkH0ESNoG/ZM0tlTxJYHKMaI1SwH/I/?=
 =?us-ascii?Q?fyYJEx2YQ6l38jNdlFowYMHeaLZjCZdOk4WSwRSQv1T3nzU0qhdctya1KemR?=
 =?us-ascii?Q?L0nSEhgPV47gcNunAfntF4b7naAHUEBrLq1vkkO3Y0WSYmBkBMc2+WoMImA1?=
 =?us-ascii?Q?8TSo9pZaHmblZh239SDj2Q5/wd0gaksBCuumlIhwLKAbcsnfxlS+yxOseLDW?=
 =?us-ascii?Q?vkk2aB52JT/Kd3pzwk8AuVELrnGLFlNWt+rxNzQAETbatBncxU8bZxEEHfx+?=
 =?us-ascii?Q?tiSTQsjDVIHLNr5YxE2goMDsRQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(376002)(346002)(136003)(396003)(39840400004)(366004)(66556008)(5660300002)(66476007)(66946007)(8936002)(6486002)(8676002)(6666004)(316002)(508600001)(2906002)(6496006)(52116002)(1076003)(36756003)(107886003)(38100700002)(83380400001)(186003)(6916009)(4326008)(2616005)(86362001)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N2bvkVfCf6xDerGSofp/FZOfUbt28U1wCADxs+My0g3dm1WnZb74OPy/K1Jg?=
 =?us-ascii?Q?2uCpITd9fygREZb+9oE/4GwgUV6vtzeDU3SCcefGxrRLsWNX4qRsUrZY5OjB?=
 =?us-ascii?Q?NbKU2PJxGmujKx0b53G9+q8JJWJUbX/MoXia/Q7LszMD+gTCyz4RVHPMd1XR?=
 =?us-ascii?Q?zEi3XVCObHH7QBzz8UHbTd/lPYYdQazmxdl//8pNc1dCCC+ICBzDTN3gL30L?=
 =?us-ascii?Q?si3XwA6g3kbWG/v+lTkbZgUp/wq7OAokGDKEYP6/BVaq+56hBhgVJLwZ02fu?=
 =?us-ascii?Q?mhnP4fcwRljr/6C7jFn37RIZdmHCnqyCy+jr5AhOb+ui0DF00YiluHTPeFkr?=
 =?us-ascii?Q?ajGLwD0cXXkRJYXC3HOnAerXTvsYfcLFdDpMfGuwuOZBIvaYzMCysCFhAs8j?=
 =?us-ascii?Q?S9KF/VyQmgbihAoD3/JitHaMiLv8lmXD+wvfWBn5vcC6CjzM7WgdssHv1/P4?=
 =?us-ascii?Q?LrhAQ6FyPxZ2q3NbMhUE5UR9fVp3RtKB2S/B3ax6a608mLvNaPDoxAVKO3Xj?=
 =?us-ascii?Q?jSSLoKjboYnJR9RJNB1ojS4hQGj4UxXsctOlPVgNEOYprGhcgnqGCVJ07oXb?=
 =?us-ascii?Q?T9z7bZc7Uw6Wu4RT6UmOaHiCc/cefrqgMn2lq+chUkOozSg2LSFYo3g2pMAo?=
 =?us-ascii?Q?xjfSYPWRZwnWHf+fS1PFB7MxTIfpS15FkWXjJkeemSQPzD6A4LzZfglBVPOB?=
 =?us-ascii?Q?WVHlQ0Q1vb8ZDTv3YRSjJQmhLWQxJ2DTgJapRlReyvnC/U1ADXwEQl2UBNlR?=
 =?us-ascii?Q?111h5PRkmmYxaafuCNAwyCSdeB3OlSrpfklsj0EuDdW+3kiu3Lsbm9Pte57T?=
 =?us-ascii?Q?UoRautjFcqGD/TlM1aRyAce8lMyg0pUnb3B+OYGcNOTBNbiC5fX4NwaiH6C0?=
 =?us-ascii?Q?vbWUfJp2zRdMWb5rpZY3uFlPRLW52fv//3H3sNefaYRmqmUDSAEDbiig19ut?=
 =?us-ascii?Q?kThzDQdWdJcxHhDBearXEtaVh+Y3p1F/w/7Wd7mpHefqD72zdpr5+BFNM1RM?=
 =?us-ascii?Q?KCs9PqTvmGiAyZVxcPqWvdbJ6jKugzPc8v03OhBVYjy0LWsk3yt7/9cTQBDR?=
 =?us-ascii?Q?Lc86PiTgF5NszIgVIsaVmpYzpdtDkDm0rk+Cxa3cZy6L4KLQ2EssrrsSydt1?=
 =?us-ascii?Q?IzZkkbYTkdEnOepX0fSTkP4zhNDXv4yv98qjVkl17rGtYJ+7vW6CiAo4iEKz?=
 =?us-ascii?Q?/Ih3NL53QAcJqAFH3clwHYozq6+ao8kH9jFhHm0rZdCZFAo+DWtdiASx+uCs?=
 =?us-ascii?Q?DlrSrGYOLItlxB14gzCQnbvB4X0RgsyIm6zc8dVq5i55sKn9PKMt0fm4PBeK?=
 =?us-ascii?Q?e5AVQzMCcDTKo45Pcf+zlI6oym/TMPP2+rGbA2lP3OXAQkO7s+rA2DvEwreB?=
 =?us-ascii?Q?zR3QQaopqRK+W+EQ5yu3OkHaej7X?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c764be-a2cf-424c-a439-08d98e1e39cd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 07:51:12.0333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTfNbzVAn5hu40k5vaNjkjX2Dy+2/YKfvbAebp6gox+nXH66Hd9pcYsFghebdh1SgblhoV7gIdso7L3qfeQvi9FwuuMWSNqg878bfDhnlr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4813
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

facca53ac added verification for ssh signatures but incorrectly
described the usage of gpg.minTrustLevel. While the verifications
trustlevel is stil set to fully or undefined depending on if the key is
known or not it has no effect on the verification result. Unknown keys
will always fail verification. This commit updates the docs to match
this behaviour.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 Documentation/config/gpg.txt | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index 51a756b2f1..4f30c7dbdd 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -52,9 +52,7 @@ gpg.ssh.allowedSignersFile::
 SSH has no concept of trust levels like gpg does. To be able to differentiate
 between valid signatures and trusted signatures the trust level of a signature
 verification is set to `fully` when the public key is present in the allowedSignersFile.
-Therefore to only mark fully trusted keys as verified set gpg.minTrustLevel to `fully`.
-Otherwise valid but untrusted signatures will still verify but show no principal
-name of the signer.
+Otherwise the trust level is `undefined` and git verify-commit/tag will fail.
 +
 This file can be set to a location outside of the repository and every developer
 maintains their own trust store. A central repository server could generate this
-- 
2.31.1

