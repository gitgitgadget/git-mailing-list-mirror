Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BDEC433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 16:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A61861163
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 16:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbhKOQLg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 11:11:36 -0500
Received: from mail-ve1eur03hn2229.outbound.protection.outlook.com ([52.100.16.229]:22981
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232470AbhKOQLW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 11:11:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2ICj05q51YcxKltFqaak5JFCf4BYLkwTdzT0ecyx7pkznV/DTXmdjfHve3Gz4WJ5QsWKUZtP5QCfWBgo3FaAy0WA7FOkWF0yB17/38yyV+95boDwz3Hif3SXZ9IDeHczRo6MxSsndpAM6bwCegIX6k+iWWF7/2numcL5KUCJ0zeNtZsJsYtf5z6R2k+SMTa5K48cv6Xr0XjVDjzV21hKTf3Z8Okh/dR+/XEXuGPeYHTrm4EUiDfrkznid6mMm+JYLDQKogedfen6pdqEqikSPjl9Jt8dJWVjJZVaVbi8gScOLDZA9ry7UXy31l2B4ckCm4bN3XRXg31gXFWyVku9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TFI2o2dsUsTk2KYNoy7lf3FAkcqS22uclHziaas+Lo=;
 b=CFynz/fqmq5iSvyaO9Y3u6jGkG4SKwik40d8iQ9UHr0KRflBKOVr8iVcGKejxMrcPoS4n8wwZYuufUR7BVfXSNUA0mC4/gjj0iEyKK5RVjl2Mke646h6e6UvXAveESgM1MycCWmfEyU9L7V1fPJMEI4YTg9GadkXCImXfA9RTuU0cRBZFdI5c70vNkWr7F5UJT73t1TGmWr+GaR+Cf5TgdFDwO4Sgl03J4y5Ve+vcEhdUi5KTxdyQu0p7uDh/PsQnitvowHnhZPnUO29LxHPUQ+CuLJ156mtBw0tojGJf9gksmdij9NigH8rki1mbJCBJtv88pMGerrziQaejHlVAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TFI2o2dsUsTk2KYNoy7lf3FAkcqS22uclHziaas+Lo=;
 b=a6fPvaU3RFhA8kMDnh5dk2611ob6hlq8IWMcAi/De0oesAbha4EzaMfKjrki6pKprnLR/hdPUBRdMo9iOFWVx9zGmJtKcOIiyJDFopwkcFPzkG9rJhzLanewCSXYnzxWel3/JbECQ/0s6RYq8/FU+0kL2HxQI9ADBZS/s3guRzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3866.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25; Mon, 15 Nov
 2021 16:08:25 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%4]) with mapi id 15.20.4669.022; Mon, 15 Nov 2021
 16:08:25 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH 2/2] test-lib: introduce required prereq for test runs
Date:   Mon, 15 Nov 2021 17:07:50 +0100
Message-Id: <20211115160750.1208940-3-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211115160750.1208940-1-fs@gigacodes.de>
References: <20211115160750.1208940-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5P194CA0024.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::34) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by AM5P194CA0024.EURP194.PROD.OUTLOOK.COM (2603:10a6:203:8f::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Mon, 15 Nov 2021 16:08:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f47421fb-f067-4677-e721-08d9a85227ae
X-MS-TrafficTypeDiagnostic: PR3PR10MB3866:
X-Microsoft-Antispam-PRVS: <PR3PR10MB38667F34F93719DE74AD6075B6989@PR3PR10MB3866.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LKz617jMWenGnpBuzcvSGNTcaWhyACQ9fNKVi7IqzobDzlFQybeSuEPuXvb3?=
 =?us-ascii?Q?96kkWnuNPT4by37R47Sc7boI+kwU6ZSzHnb+dn7ctvklbcch2UWcVD3IF5XN?=
 =?us-ascii?Q?YsahvAk7bUpH3lk9uIX6HLPdvERfhxqFnRRK1+bsD9TcNp5hAY6JXMdp+JQ8?=
 =?us-ascii?Q?vvHlH96pdh6/Ipf8GiSZ4z2P+H+5HuK16qf4otB6WzmfRs07/tkqlZvefiSY?=
 =?us-ascii?Q?ZQttkXqjf2IwBU4ArW0w1k0j1uKOhokzK/9JhJQzD7J+yu4YZkhsCr26/4yd?=
 =?us-ascii?Q?ZsOVEDI3MfBrDNAm/Uv2WuOdd22HfYQLvX7cEGAjVF9DiDbo73HyJTjAI8QM?=
 =?us-ascii?Q?RgfuBhI/teqsVHhpN0OtSA/9hnCMmkQ1EYwzYd2Prij9gpRNkuVWMCx+ZVQ6?=
 =?us-ascii?Q?/xmuDAiMOgwl+v2G+z31ZvLzpl8KDCotBdztd+AW8k+xK5AGT1HRymALkQnk?=
 =?us-ascii?Q?uRiOZNwobuH4ZbHwjEaD8yqFqsYv0lP17AcCkqMcDybtHZdxkD7gYGO6EG+m?=
 =?us-ascii?Q?TqOLXy46a9KYdwDjjkTDi5AGZu+QxoNXqjikyZaMJs5laizr3UmAM4/6PDsV?=
 =?us-ascii?Q?R92z2dSuKALHA4deDzHv8Ou7mLjAtB2nQymd0Z6mkgLFo74bTybKyrSPzKRf?=
 =?us-ascii?Q?+uAt/rL1xm4zSCZ9hlsHJ3R4z87Dp2PMFeGA6A4bUG4R70HiwYhUqDOCqdvQ?=
 =?us-ascii?Q?G3ZvDSXmw4gvm/rSaCAqYMuB+2Pdhx0nDTKkqFFSJ7flBfZOjLIyCXQgsO5H?=
 =?us-ascii?Q?D16c5ZoahC5c+JUeQSjgI0ily79xQpkmV7aVjOUny+Rt/TnTq3UXySrNq56u?=
 =?us-ascii?Q?Rk8YNIgL+WeV+TTU+GQE8BV6b5IfRnUb2CkCs5rGIMGuo+cUYj/QP88Iz4FC?=
 =?us-ascii?Q?8pxK8nNcsgNdRnCiNIi+oCph0N5PbYL3w9Ab0Lig1qbmv/Z5hVsPnfYIIb1c?=
 =?us-ascii?Q?hkaLxxxZxvKQ2BnHtafl4tD471RryuojBC9QJNdWXEJkOKD0KfNFvH8d7WZD?=
 =?us-ascii?Q?Eah0Jbdr+i/+OpnMsKw7lZg3yQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(346002)(396003)(39840400004)(136003)(366004)(376002)(2906002)(66946007)(6486002)(86362001)(66556008)(186003)(8936002)(316002)(1076003)(6666004)(38100700002)(2616005)(8676002)(508600001)(52116002)(66476007)(107886003)(83380400001)(5660300002)(6916009)(36756003)(4326008)(54906003)(6496006)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e022EglUFqWKjAwg9EZO/zvWr1IPY5lx03tBqJzYtr9mtXq4e1UDeiGh+k3b?=
 =?us-ascii?Q?YR5QfSAZvg9XqxLlwCRVaOSk5RrSamtpeWfgPmPStW53rFpxVHSnhIQd+j7P?=
 =?us-ascii?Q?iFyh7iM+qa59LHVKO2HRlXWzzWMS+M6DJvGdZKzSELiFmtPGq/inlDreVuZ9?=
 =?us-ascii?Q?MXvSwFsX60l8nuzlUtCb9vcB4u+9HnF2RAx0F0JFBtGfZbbWl9ys5D4fhro5?=
 =?us-ascii?Q?bM0LnnefB+j86YUMJN3veFsRvToWS2TFGujrL4gHaJnbkouNJ4OgqAxC+0la?=
 =?us-ascii?Q?RtaixrVcojs/MVPOXI3KI8EdxTwt6aBTlBLd1agBMelOFJ6JWgvo+PBfn6B9?=
 =?us-ascii?Q?82MWnTslLLnspJlUD9DIbQm/+1w9fekIYV65mGzDt3X0Ev/lDQ2+n9E2ivbF?=
 =?us-ascii?Q?mFf2E8g6ks2dPsx3PZd3nGYHMN9Obg4wBtEJwp4gyj+DAaf+Mbb37w5TZtoC?=
 =?us-ascii?Q?gswzkLfpa449j3KZ7RTdcKqI2F3nDn1tu/5mZ9jDmZWxZd6O7Dq/5I5q881V?=
 =?us-ascii?Q?EQgCpKXvPt8xqRIER+DpddFXmeUTigJH8svrd1H1ZU8k8e2+NEuSjyaY4Taq?=
 =?us-ascii?Q?xWdk/8snfVl4Jq74BGDrzZnPa0vn6/mRmvFkdQZ4/mQF1SLEADtySXOTOyCd?=
 =?us-ascii?Q?34Gwq3k5WvVjZ+iZUZmGYaBzrB6rkgZgJUFsBKHxpgVmQifYofKyC7s1rMqT?=
 =?us-ascii?Q?n0PAjxwELmfDFENCKD6Ti0cg3ydKE2MjLiZHWP+u7stp1eltK3O/ehyyoUNw?=
 =?us-ascii?Q?IefE7jryjnACqaMHukPMbmWV+qKN23MUjxxvwOPxjYKj0NPpYikikn5qEWyF?=
 =?us-ascii?Q?uX8l9jIDHx8pqgIgKvbe/SvsenxGXOaTbi33H6CLQu68tqr77qgNvrA1FG/8?=
 =?us-ascii?Q?XGCMOfyuk9BOk0/HmSevKjfKeRJQ2nyKXtaveTEsINOqO6KAA/bQzEuAqE79?=
 =?us-ascii?Q?7dFhrfMlkIZcpt0yNei3z+YM7b0w14+9yq6Fqpn7kKg/un3bywzRRrbFCI0q?=
 =?us-ascii?Q?2IwkfX0KazDu3V1MDbHKoUiGzU8JbQgM4BFVvN1YpDfgNj/CWeeduKgLZGjS?=
 =?us-ascii?Q?o/wfq4VqD09vFw/sdlEtGRixTdvfUL0LKqYPh8B2vv4jnp83YdH4xiRH385c?=
 =?us-ascii?Q?wOZrg4FYUfJi32TMy3AFdcMAVnTADQMQLHll35bn6NwddbWAVRIahzUDIiq8?=
 =?us-ascii?Q?6Lhc/ZRX+8DA5jWzKE4+RCs+MSvR7gEXqlIVSP8iYeXqLvOroD58QpzRS12x?=
 =?us-ascii?Q?iy6lUFCsbYagasHcopOceKctIfIb97rxpqCMucGd/MHFrUPbp/nzgCBoJvk6?=
 =?us-ascii?Q?P2GB3WtuD3vdbH2ikgPjdHqeKtasrcWQdpirYkvsca6tRla0sa7sOvr1X1Yk?=
 =?us-ascii?Q?9tfNqtxHrnPBQnplaeVoDIbGmim7v+HrIfqQfbI3gMs34oI/5EEH/t/1zdh+?=
 =?us-ascii?Q?Ub74GbnQtV1/TrsuMwE36UbBcvCuXsiuD9XrHasryyq/FSR8XV9xW+D3uGgU?=
 =?us-ascii?Q?7crYWFprwKsga9evcHaScF9+OxLyItEfw5J+JimIrkxN8BA46fWRZ7gGRn+n?=
 =?us-ascii?Q?4QN+OfWAAC9vyXbArhVQhIslmSaQGnDFSWjYRSzMmGTDE+Fwa1GIAGLkrMiR?=
 =?us-ascii?Q?bfmU2SHjP8X3hOMZTsNVJ3ku6tsbTb86aGCc0nkF+UA2tWZpgoqj735OK7Ni?=
 =?us-ascii?Q?SWNUQFXEqJADpPcOJlDJQRf9bndVN0j42BIsqa1eqstIcCLk5FfPGxFg/Aox?=
 =?us-ascii?Q?iAQlgFo6jw=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f47421fb-f067-4677-e721-08d9a85227ae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 16:08:25.7528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHtmKvWhVQG6pADEkRphjojL/gx3o1P2gxrIk3iMo5DNzDQZxcMmupI8rFRRAC10cLYTgkbuUaQUG/iJ2XmH4x92azrjl/qUVJYDuGT9fzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3866
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In certain environments or for specific test scenarios we might expect a
specific prerequisite check to be succeed. Therefore we would like to
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

