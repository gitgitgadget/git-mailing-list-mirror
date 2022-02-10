Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF26C433FE
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244796AbiBJQsx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:48:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244849AbiBJQsG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:48:06 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2042.outbound.protection.outlook.com [40.107.102.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E27F1D
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:47:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/+XG525NND7hD7j8/eH00pnfdQvFeE5jKJ/4RsBIMCgx1yAsmPbC0FutIytMZno5yFv5AAJ4bbI9iZuOWaerPMgB+oXjKRo7tfzoS/wkfD90fD5bReV9+1vZ7sWUr3lFMsbnsiAoNCPw623nGC+O1Gib1UTMxSBf89RmEl2sJ4m+0auiigPJnrQjzcyYJxDkWPwtZDR6qKtSEZI4Lrux3BIjPFXZ/1Yc5GI5L/FC0ZxZtNOt9KTXKwR7ibnnqU5mKOQCF5KgNp5jxzU4NjjtFjIoEisUMrml+q+FvgisyzcLnepo3WBK5VnmFo8WHETulAsVfedobpI02q3tf5sjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyH8UfDgDYEdRIuKJqBerg9NPIsHssrk6M34My3TDjo=;
 b=jbY/aseU2rdnsxfdyJ9cON+oMxL7XrDNRSUxu9f+r13km8vwPYjExj1o2npFAwe9QJvMS0hjS9qUtDn0pQfH1xG/ecdSczFVl3P4WwwQYl1sXBnO7FKdAAB9gI2eiBZvfx18S5GR8ri44wff4pHGbLHfhr+uKwWw3uHGsSfNSIwneO+1yKaUTcqQLFmbPl3UTNcdWsMGZAgyt2FuJVibmbYzBMjlSVBBdcwzx8BnDbdPAYyQWmIrypFe/KuhEi8UJMicl7ZHGQQ2GDgv/bu5KOzSkSxY2p2LDKbdHf1Kbjf2msvlmSrGXi8Hr3ND8+xPQZ/3UWT3a3SXjiy/5bncKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyH8UfDgDYEdRIuKJqBerg9NPIsHssrk6M34My3TDjo=;
 b=L8YJFe8dWvCesmo9sSiAjr2kYsmm3pYYkvZyExk4fIEwvnUtJ4wSVXEcX4J4nEPzN9dJ8MXccT519egJm1rq6xtJkgkE5yHg5Tq0cDQUnWS1jgZjziayf6Dr+3dBEVymT7Cg/TCkB0AEt0ZJd1SagN0qJd5aQm4d5GgN3m2o0xd9hLwKhhDWu3nNJL0UaX6a7AytYerD1jPRjk5tcel6XmqnJPgMFvgItumHmwwpY5WHPH9Ig1KbGCAUsaVpiYpUe9OozrbVvKxuyXzOlOWb6/A0gtve0yhT5kL0jEHI3BDbLXDANwgA51TRALmGMyXIiLDc64v1JliwkHUSNfmUxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:47:35 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:47:35 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v4 21/22] git-p4: seperate multiple statements onto seperate lines
Date:   Thu, 10 Feb 2022 16:46:26 +0000
Message-Id: <20220210164627.279520-22-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220210164627.279520-1-jholdsworth@nvidia.com>
References: <20220210164627.279520-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0069.eurprd04.prod.outlook.com
 (2603:10a6:208:1::46) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33745a9f-d275-4fd3-5d74-08d9ecb50a2f
X-MS-TrafficTypeDiagnostic: CH2PR12MB4101:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4101672CA693CD20E8A5BAE6C82F9@CH2PR12MB4101.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z5+/u+EtfH/I6oBhOluzougYLxS1+SmaAgCWil9wmgKKs1uOLoUeyWhKpTCF1lKUV+YrW1WJ0xt4uQIDIiT/rMsQwtRpiEC7BPpnzC6wHimZr442HMi+u/Hov4wB5T64v6g5bjAc6GMWAJP2pAkRdwvDOLfHiZ8Zwia/FnW+uUDXepxuzExoGJJg5QcyDTzpI1fenREdFitSy87yJhZFJtSgNylkuD6MYY3BDV4EfeDC8yUKTW7EmLIOI56AQ8oD9r7Egt8ite8vHqrE1znI5uXKr7hfgDszPH4f+SZHo/Drla45bVKAakamoJspetypGHCf3xLpyywgO7nI5gQuZUF1zHpvgmlJudSPGJT0uIMsOQwVaIKftIBDDM3ZqHJCF9swTyEqia/xWOYbHefaHWPDzFGcaHQOA4logfz4e4wNC7RQsRq1fo/o17JCodIm+EmUTtDea2Vk9omKpuq2Aae+AJCSXJHcUnfPB8HklCPxUUjV7Fphlw5KbHcJwDxHm+DMjtetk/yGg7AF6x9YK6RMtJ+OQOnagkfkQY2u4TJIgx28gxoCac9uhs1oR0Qc5oDyl0r/4H1KwSs0F3vOdxDFJU9MM6cZhYp9XlKoMw+ugly45ncDT+mw4jk7TvXwxGTC2IZoGR/H1md4w2uXoaz4/m2ESBdnwRQsTWBcPPbRMz0gpMQJup2pdlEy09pG0D4Z5U1BHFKOJ8CwrpL1inbcwiV1jvKYeoByFUFrdskFyi4s03FW7HqlsIAKghKJ7iLAyLttChtt4KUnRq47m4csuq28rjA7byagcvpD3Ww=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(6512007)(83380400001)(66476007)(66556008)(6666004)(66946007)(8936002)(38100700002)(38350700002)(8676002)(6506007)(55236004)(52116002)(86362001)(4326008)(5660300002)(107886003)(7416002)(2906002)(1076003)(26005)(186003)(508600001)(6486002)(966005)(110136005)(54906003)(2616005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N5ot5V9iXJyXZWZ71CMH3JkGlNtI5Qoz17tpSLomJHxwkMhhBGhTAuPlG1W1?=
 =?us-ascii?Q?zvHY3L+w6V2pkXONiNaBV7ETBpHcv+rAF4nvwGsiwH0OwknfShfmDj70Eis0?=
 =?us-ascii?Q?jKbPfPTtzR7BtGKcKwlXmXqbx/ac8iwMLU1EURAzQiMWUv8wU2Yiz1/iEUKn?=
 =?us-ascii?Q?zVPvjBuirQsHGGp6P2DbYJeo/+Waag+vbUqnNIkQYPJviFKEBAD4KSzlefkp?=
 =?us-ascii?Q?7dubdAIAMk2pqTgiw2If9z1X83uBEz84ISV9o23NOin6OriaU/i3id2NoSvO?=
 =?us-ascii?Q?mAkNov40S+zTfj4fJh3DS8NwkNE6+5mRT5knnVv4/m73qILjWkZ6Q8bfQjT7?=
 =?us-ascii?Q?AXHcqw9QfALn6v2MfWHTdOD4ENzdvXMT2+2/cJXTOzdNIpHw0NtONmxV2kZC?=
 =?us-ascii?Q?+De4v5TEwKbR2jtYl1SIP+JpxYmmflpI/YGVBL3EvH0VBTHBN7U+g+XG+Iht?=
 =?us-ascii?Q?nMOXia18S2yqSvhbf77LofRoxDvf0abfLGsjTi2pZSlF8bIPssC9KE10fvVI?=
 =?us-ascii?Q?KVIUD/3S+wXsxSZJ5s9wHG40xw2fzcyzvKB866sKvDzWJbco/xrC7jHVFwRT?=
 =?us-ascii?Q?XP5RSAaXTKWnoSdm9icmE0k48AM3aKg6UHDJnZogo1bJAPP+iHsGccsSrcMa?=
 =?us-ascii?Q?f9LSE08N6HD47lIjKOyTKWy2FXRr8TBVi7lClJxWmdtRNaPi9ZhntcvyIi98?=
 =?us-ascii?Q?jWZ7x/tTPwnPZYywfbe36/ynPIwQuznm9QoGcVJV/yDZ33tYGV61e/GqIeU2?=
 =?us-ascii?Q?603N56/hruJhaWKTN0sgfJK8xiJP7aVRbkPgHPqbjt+xp7pq5Ak7V3P4KckC?=
 =?us-ascii?Q?wUZQs8IK6n0GKHyy1UeRfkIz7jyocncCSOzBmU3yZmcujnG/gQTMNoV2/RVj?=
 =?us-ascii?Q?oKstMr9/6dK2dvh8Gnf1O72yvg1ldNVSbv+IcgBvzxdhXsAWC+p5owVSEiju?=
 =?us-ascii?Q?bAoto+7DdBzP7MtuZTB/C/Zi0wHER6vH4378psPkNRIKAiwi9E+TM1H5C2Cv?=
 =?us-ascii?Q?CmCirwDvgFeSp6WaM/S9bBIERWIShDZWqzav4q6D8CIB51yg0DI3c2MW89Lr?=
 =?us-ascii?Q?Y+NZ0HnAROGymJuXa4sWE4TSIor6L6bw8jLPJGpwYkv2iCBqt4daFD/3KzBT?=
 =?us-ascii?Q?7Ly+UaBJgkZOVAI/5NDxwZr45xXZVC4Dbk1jfBg187eN+tT2POxqqT/JI7+o?=
 =?us-ascii?Q?uqmmAzaWQIljpwJDoCA/vITCBLKEtCTJaUlLwo4D+iDmUrYdUvhBRbM+B0qg?=
 =?us-ascii?Q?OXF8uqsxnGu2NBvlK1czsy2j4geOmk6+r08NnTsHtGqSJJ3MsyoF7iTk7AWC?=
 =?us-ascii?Q?nSuHtEMh/QtuWNsRQiNfn0tUSseQVSA7P2hOMTgN/uFFSx4QA0L4t1yY6Syi?=
 =?us-ascii?Q?Y7rJVaYnUd/oDKngmQAiQ1B01UXY2ksE3OfEMJ3+zsrH+ohEV5n2DKfw9NRm?=
 =?us-ascii?Q?yHrrReOtJlrrXRYQpTTkKp6EJXKEiw01HBcTDouuMn2dtTL5DRIj2sDijy5H?=
 =?us-ascii?Q?qTYWCAz4XzAz0QLm6y4O/c/dMxMuFP1dhnE1AsIpZJ6DLSjHWmkkOBgcLa61?=
 =?us-ascii?Q?AlGqCCZF3ZsEKszYaATXnKlGY9BQEJYsiR6ZQLZz8B+t+iiqe84xRVD93Qhu?=
 =?us-ascii?Q?Pr6zlaqKT8bVvEfSCvB2Zyw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33745a9f-d275-4fd3-5d74-08d9ecb50a2f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:47:35.5153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3DezXEZHYhweCAmg74vEEd2vZ8UWReycE9P+mjdUS4EiXfUoAwMq5mnICnE6m0LTV00JwdCgcEFt/B5+kRsoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 discourages the use of compound statements where there are multiple
statements on a single line in the "Other Recommendations" section:

https://www.python.org/dev/peps/pep-0008/#other-recommendations

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 524a7a5c99..c3239cdabc 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1191,7 +1191,8 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
             else:
                 block_size = max(2, block_size // 2)
 
-            if verbose: print("block size error, retrying with block size {0}".format(block_size))
+            if verbose:
+                print("block size error, retrying with block size {0}".format(block_size))
             continue
         except P4Exception as e:
             die('Error retrieving changes description ({0})'.format(e.p4ExitCode))
@@ -1818,7 +1819,9 @@ def modifyChangelistUser(self, changelist, newUser):
                 (changelist, newUser))
 
         c = changes[0]
-        if c['User'] == newUser: return   # nothing to do
+        if c['User'] == newUser:
+            # Nothing to do
+            return
         c['User'] = newUser
         # p4 does not understand format version 3 and above
         input = marshal.dumps(c, 2)
-- 
2.35.GIT

