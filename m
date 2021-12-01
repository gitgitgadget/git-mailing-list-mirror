Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA1CC433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 08:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242293AbhLAI4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 03:56:47 -0500
Received: from mail-eopbgr130042.outbound.protection.outlook.com ([40.107.13.42]:29029
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242217AbhLAI4n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 03:56:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hu8ngqGkxOBReHGT+EBpscwDgHSpW8kIpoEfT9O8kElPI1stECZBDKmXcgCdh62VTAKaPI05+TV7CZKsJTJcquc1h447u2MbTwjeU7kpsFoOsekf7GC50vLQ4bSL+W+whS1o0Y/1Ju8UgMWzWt5J3Fe6Kvb2h2zft1KJQVgNfEMisyiAbjvBWBsTUSUVJyA6x/wawQ9wkgQTUeyB+gCo/eQHcggCMr1p1XmYG0SQ1OhXeDkCjMzyDi0tx0jz8Y19wyPUPcRAgCkGor1sLQyEYmvLiS6Xl+Y/FUFqLnzdghidkepnGXGTLBaqtGF0VAuvctAa/xGtoQfx+a7UWT+bow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTQZyVr/Mt4izHFXJqibmSEaAVZQTx/lcFbp4gqVu3Q=;
 b=jcTzpaj0zCv+3c3/eBAdTZo4RXU3w8XXwtgJTQxiU651NJ/M7oPT85hEqFYY/jGL9Yjez5NBr4jEJRlCWuu2Q1PpNr4104ZNGT4kfV8glGDGQouZitHRG6pbEjCcsXo3M7iuwN2M3duNrC0mmavkCJS0S6d5ciWrbIoDtoEZuo8bfGXO5Rbn5ucPCzNHugKs8v+vmCTF6Y8tpWFn7/Ngw3fsecx6oxjDNzsYqhLPThEcixoNQVG6c1VY6pgxGd8GQIvwIdpw/BY3ECiGzb9QMgzmH2VTIvZWMqc+RZ6cRfUNQDDtpYBcw4M5ZmZ22JjlIa3l2k7IzSTx1Se89muEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTQZyVr/Mt4izHFXJqibmSEaAVZQTx/lcFbp4gqVu3Q=;
 b=hoBN5rGBTmMaI8fO6LW8CsJ89Hid8e7oNPTAA84tnr/SN49UBsU6K7eJy0TKKT/G2eVss5oMqq7SSe6Awpv08fGVeDob83MjrvQnzfoECHn/ILJ599JldLJk8/PRgtt68Rz/gVSciF8bTWAx2fjLgVn/FrdNJQnaSOT+I2gpw60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4029.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Wed, 1 Dec
 2021 08:53:20 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Wed, 1 Dec 2021
 08:53:20 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v4 2/3] test-lib: introduce required prereq for test runs
Date:   Wed,  1 Dec 2021 09:53:14 +0100
Message-Id: <20211201085315.576865-3-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201085315.576865-1-fs@gigacodes.de>
References: <20211120150401.254408-1-fs@gigacodes.de>
 <20211201085315.576865-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0231.eurprd06.prod.outlook.com
 (2603:10a6:20b:45e::28) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9PR06CA0231.eurprd06.prod.outlook.com (2603:10a6:20b:45e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Wed, 1 Dec 2021 08:53:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82198e2e-bbbc-4bca-9dc6-08d9b4a8064c
X-MS-TrafficTypeDiagnostic: PR3PR10MB4029:
X-Microsoft-Antispam-PRVS: <PR3PR10MB402900DD15CE4AF795BD5A04B6689@PR3PR10MB4029.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JZ/c33bdHyWK+GV6LmOlMAdrwXR3Q5P/vM2JMW5rzKOCFVAf6sWWSzT8MaBf/sW4401r+uqYAAAeaV8uvfiDoiEzpWKcuJ460hiSVfeLB4XQcN8u/6/4LmT3D2Vq0OQSBzy2EmFbffk34KAZ33Uqyr/qYrmnggkB4M5H25oLg3NRflAKCgOONhDnn8gylz1qE7dnABbjj/uIileh+ZrU5B3hZGJa+wXNmvYTIKNAChDnQTlpPeNIzalGXHAfPcenP0L1GxqnTaLyHFjoRiSeo/CkYEC6En5FEqAE5UNXquqjNJwng0Deppg3kViTFSWf0kpsVkmzJtQZ+6LxOw3r3NQBh2Vo3if+x4ai/bNAZMEFBc4gT92MDlQGwyeZYaLbQ+nAmdTy8T0vLJySWgMMmjdgdFVKm/ZdXiBHVbzZau7pJaRpFMlM2iK9yzgMXeEyqiswx2zEfCH6Ce2S6pn2WWmP1zMFaTeZraLXsUJvb9+aI//ipVYt7/cFBByQtyEP1OAMm3TJ5JxCDlxiK/otdzlBI5CDBC0HcXiUVO+p4zfCf0un8u5+mNssmqQ/0IeV32SiPJZ/zuGstk8hDtiYgW3rB5H0CHNBJOuz4rnnfw80JWqL+f0NBHSzRqBOP+Ebdy9wQ1Lq2BMxoV5hOKQktA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(136003)(376002)(366004)(346002)(66476007)(66556008)(6496006)(8936002)(508600001)(8676002)(5660300002)(6486002)(6666004)(2616005)(38100700002)(2906002)(316002)(54906003)(36756003)(1076003)(186003)(83380400001)(86362001)(6916009)(66946007)(107886003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gt2Qp4efcYkaBeWttuna7QweP8MVCJ0rnGVaAoLxw02wYBPBBIlJu/3AhsDh?=
 =?us-ascii?Q?+yf0Iv/9MpWsvnix7W98VZfJt4IXsyPDLWJlTgp5cCZGSPcdAwdmC9OSb4Y5?=
 =?us-ascii?Q?akGSvH4PzLXqPKdAuZb36Zjkoo0tHAteduygVpbg2QcV/hJ1sX7GqvRDId7j?=
 =?us-ascii?Q?QO52BytpCJQEcVag01/JviZavMQpvSoqotZYstQhUJ2gqQPJeJnJHmzyk5iU?=
 =?us-ascii?Q?zN/vpUW+v07IQ8XLn6AxHFkwwWfiCL33deGJcUwGDsVsXW+A6K4BqXYWbuE2?=
 =?us-ascii?Q?l8Fv35wp64m0YKqNi8Sv2QH/hGfQU9n5YIoR5NL7WwZmJRaBZzSca1WV2PGc?=
 =?us-ascii?Q?ZYmn032w7joJ6WB8jgF+wjGhLqC9NrHkKx7tRPVV3eVq82qdm+LxkB2v6uOY?=
 =?us-ascii?Q?Vh7WtsIO5bv3Ii5p6N93a6JwSF1LZUBD8XFfAHgTLQ12+CR3jkwCfzEou8jx?=
 =?us-ascii?Q?esI+DPJiIL6qjlUthcx1FOHfAqf+qAnZmKW41gKEKltVt1I/C+Vh5TDXEhgN?=
 =?us-ascii?Q?z+6DzU0x4jvNrrVInDGPHplfa2C3xCFCL6mXLEA3nCe620eGAQjNlQBdWUWM?=
 =?us-ascii?Q?NGck26Nj1qF8pobwxtF3GJOdLvZqh6Rx47kdl5tUnb2aqCSLxaY0v30LCqVp?=
 =?us-ascii?Q?jlb49YCWiD5ADnWaXXED+f4qdTmKjX+MeGgv73NAGeeQwBgiUBPEvniJXboh?=
 =?us-ascii?Q?XmkwTMVOMCpib3gW9exzJ2U5QjXlGfMeKjughFfhB/PuXRkLRknfm7miFa5v?=
 =?us-ascii?Q?V2uDIU/7FVQhWnizIHX/PmnNf+ZXddLoW15Q/XT26ipKaOIHzpeaMHQ/Iujn?=
 =?us-ascii?Q?dCb4dJFu43MG7ywAG7qhFnBsxutJhl7Ax2OiaisV0OroTCZiLYiIf5XaXs/G?=
 =?us-ascii?Q?/StmxZm0PyPgPNGcEUK1LHnjxjTrScLrascxrd+4HeeaYUoXHZxVKTtuQoGJ?=
 =?us-ascii?Q?Pvv0DZXRcnzu7QHDeg/SlV86AMhR7a4sqNwZtyznhz82FPCmRYYMbI5mJdiw?=
 =?us-ascii?Q?0Tu1HrKynaMyUAXi1j34yvi3Ln3rnMZG4bjkQjNO0kggkDRtdn1u1+bLK9kg?=
 =?us-ascii?Q?2xavQB8+vOfEusKBf3qJcNukm83xO7BQlJGrlTCkiU5mZgzO2JWSxhEsk8GM?=
 =?us-ascii?Q?IMMzjVik5PJZ/laBqcnK4kU/oB5KrdIN7FG1cst1RIQL0R66ItjnhlxK7p4K?=
 =?us-ascii?Q?/x1xpCVP6etkjnM9AeQhgaYqzPJ+eq7EDyyQlL+nlB7mAIcXSYuDtKG7grK4?=
 =?us-ascii?Q?rIlFaRF+Hejj8WZ2k/AIsxuWmt2iYBiV6ai5T9zJ60ijd8kKzoR1TGionFT9?=
 =?us-ascii?Q?T58eC9TZv3+S3gjIYwj2f1BQ4mmWHjbCU7SjM8uioDpGEOxO4mpWLbbV/amB?=
 =?us-ascii?Q?xpkISZuG9wi/OEgXQH1SDOFf0c9yn1BYwEoSzOmUaGSqpPRWeG8qyEkNCiia?=
 =?us-ascii?Q?BWTvP9Yj71wGCy7yRCuOYCJzDzQALp8XmyhfmoX6lB35iOQP73HkU6HQk0F4?=
 =?us-ascii?Q?t90gXNx/wCN883Ydcv0IO76+Ddk9WNQZqedhuIgcymzPnWGA0TIbNwC7MhzX?=
 =?us-ascii?Q?u0d0VzOJxHorqDm2Ux6wKP06MDiBTtBWQ8FejAgRq9pv1JE0xoSXgjxtGXzT?=
 =?us-ascii?Q?T66b4zJAnM1P6fA9s6NJ3I0lNbpbU9OuhyDRFZa1d6r8QRwD6PaUvO1MJqyY?=
 =?us-ascii?Q?9JQRsNiQ1nTNuu+N1KcPBPdtdLk+XsNVVPVkuW/Fh6g+pDxVhnFg3Olli+qT?=
 =?us-ascii?Q?YxR6CSGI7vpd13Pi1O5lueBBiwSZGTk=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 82198e2e-bbbc-4bca-9dc6-08d9b4a8064c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 08:53:20.3801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xl1FmOwsmcg/V2H6Vs3MhXAPEvs52krqkrvc3xNPZmom5xsYC1imC4B3/0bZKLTPY/bHTCqenO97aBKaDDzrRdYccFv6OLUYzZxhpZ01p70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4029
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In certain environments or for specific test scenarios we might expect a
specific prerequisite check to succeed. Therefore we would like to abort
running our tests if this is not the case.

To remedy this we add the environment variable GIT_TEST_REQUIRE_PREREQ
which can be set to a space separated list of prereqs. If one of these
prereq tests fail then the whole test run will abort.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/README                |  6 ++++++
 t/test-lib-functions.sh | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/t/README b/t/README
index 29f72354bf..2353a4c5e1 100644
--- a/t/README
+++ b/t/README
@@ -466,6 +466,12 @@ explicitly providing repositories when accessing submodule objects is
 complete or needs to be abandoned for whatever reason (in which case the
 migrated codepaths still retain their performance benefits).
 
+GIT_TEST_REQUIRE_PREREQ=<list> allows specifying a space speparated list of
+prereqs that are required to succeed. If a prereq in this list is triggered by
+a test and then fails then the whole test run will abort. This can help to make
+sure the expected tests are executed and not silently skipped when their
+dependency breaks or is simply not present in a new environment.
+
 Naming Tests
 ------------
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index eef2262a36..389153e591 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -680,6 +680,17 @@ test_have_prereq () {
 			# Keep a list of missing prerequisites; restore
 			# the negative marker if necessary.
 			prerequisite=${negative_prereq:+!}$prerequisite
+
+			# Abort if this prereq was marked as required
+			if test -n "$GIT_TEST_REQUIRE_PREREQ"
+			then
+				case " $GIT_TEST_REQUIRE_PREREQ " in
+				*" $prerequisite "*)
+					BAIL_OUT "required prereq $prerequisite failed"
+					;;
+				esac
+			fi
+
 			if test -z "$missing_prereq"
 			then
 				missing_prereq=$prerequisite
-- 
2.31.1

