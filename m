Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0608CC433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 13:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353748AbiALNsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:48:01 -0500
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com ([40.107.243.43]:52832
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353710AbiALNrc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 08:47:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERQiqTfjAWtLvQFS8K/Kbz0W017w9jbfBL/oDCQWY4sOoN56SsYJlOWWnOmW+TRwf+MgqBIDyurJYeE6cK6hPm4VhAVp0yil0fguYc3Ppm3El5NGB50q3f5i7wasQHianOq6YGiglzxITyTo7ltLtATUuxYMyaOGgFKixn6KHDv6R1tSf3cB6i18WgkW2ZLNbQXZm+obXF0fWE4/KYEy+UkoWIkqTSOgZwVsh9pQzojdl7IS3W5jxUwiGLx75MV49L1Cj7YfmJ0Sww0d9vW65HUmc3H3uZygsgI8SvVxmQmOu+l+1bMZ2tbECcrLso6Lp24dz9Sjgzw9JYpHaaP6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dg05Ls94yjgWfK0ByAYBc5m6CxZC5mexyWzJGmJTS00=;
 b=i4IRnEVYgJxGRm5Vdcn+aFtC/6UXF4ItvOc+X8X8MDaZ/7h4WFygaef1XcqGJdeIn+Qf34+ybnx0AShnJlLuKj6EvXm+yu3rIK+3tawwx04hAWIc76IeRSsi7LNY0m5EcSpgUIGTceIgghHtnDDGkh9mJUPLDNcn1/KWIQkBIklPGXcyu4kyeOW7N1RiCgk0cRi2TytduYqI5yx9PWGJc8z9n46DQA1DfapPya20iGhq4Pz3ccCyNwRGGWdCCwDQ4/MvI4X6fCB3VdudfGRFPxh92RPgn8rd8h5l0pBE1HzhibQvcLqv0UQcWQux7gJ3E8Ig1473DX7FRzRIwc82kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dg05Ls94yjgWfK0ByAYBc5m6CxZC5mexyWzJGmJTS00=;
 b=bf7Ws8lE8aPSgxNzuJkvTb+sjljfXOwaarj/JeunOdt+nza58xaeN35pqs2PdIAZZiMpkubjM02B9UI6FnHyUO3Fh2brpgJIQa8vtWkzLfP1vKT+Jgth+H6fUfzWx8tzCrzov/4jx3GJRxo/IJUX+k2RuueuX8s+8xi0eoTAwTRueJoTBAYa3OoO64bWdkbjENS7/v/JUiJ3xha/ckJ6uxhSIvlO64Nx7/1lT45sUVwzK+5Jv/ycAWIwWh4wgw8cnmXwE8a1S8bjfPLmrE96B0ihqnAwtyD3PRLnLALk3aJHzEb9LrkgdpIBoPxTbOWexhcF6C2A0vTHmJEutGTKgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB1594.namprd12.prod.outlook.com (2603:10b6:4:e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Wed, 12 Jan 2022 13:47:22 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 13:47:22 +0000
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
Subject: [PATCH 07/20] git-p4: sort and de-duplcate pylint disable list
Date:   Wed, 12 Jan 2022 13:46:22 +0000
Message-Id: <20220112134635.177877-8-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112134635.177877-1-jholdsworth@nvidia.com>
References: <20220112134635.177877-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbcd5736-8e86-4a72-c4fc-08d9d5d20f05
X-MS-TrafficTypeDiagnostic: DM5PR12MB1594:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1594242A95D989A09276CDE9C8529@DM5PR12MB1594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8kmGVeBawEmCfbXcQbw1OfSmxgwcywwTKvKeEAoIAvqzdT1MWPnu/dVDBhKNM6LoTQX8OOcd7XfYZzzXcK8rePP+WWct5PYpyoPEh5gMPINVZ46HIclg7Knbe0s/pHB9SJXYEFPNpI0J9mCox2/PnCQK6XkebaMi5Nnp3RV7RmhDKDHzZxmBZVSvdi+HWyL6ERYzYS22p4Kg3c2huTVcE/FSIPQ6nR2hmzRRLBocQuchZ3AxRFGszbRrkK2QVIzcScYvxmjGpSCflzec8VSu36Q2/3n2LLsqGw5U6pUnQMXKNN6pQlTrHhrSqeCQ1y1BYb0GXtMB6MJX1zEKMSH90h2bHk1k1ZnvbW3XIWb2yXOwuoJZI8qUj1Vb2+8eIcCZ0Z6UM0V91VUE6ABjOv0yH+M+ABwj0pq1wGM1kIKwzKts0gazH7//bz+x2YH7vgoGcrwiPwLgSdKWwMGLesVKFfTPzfRFvMLeCaqFwM+19YD9ezXDJ63KrOlqtXtmmuduBBKQhBVaB8rYpGw1vGnsFThGiUNFPaqXCtUg2DUSXRl4+tn30obvyjv4CfETT1fkWxBnLUke7qYDVhjnk6Oif6PYxrNfssRfliq2ybIXETM0MYW08XMBeeubWuBfIaVUHsuUSkTlYEN1IcKKcs1rnil2HBLWLUUNhnRhvRjVuc2Jx9rzIEjgiTFGV4E5TL9hO+KEdgcoeonzBPBCqP0j2sNOVi77LE8EgyGPiwPPSJ2i6zSpOo6mMSy34Dye/2/z/28ma3ZnoYv/muqsgg7/gA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(5660300002)(1076003)(26005)(38350700002)(2616005)(55236004)(186003)(54906003)(66946007)(52116002)(38100700002)(8936002)(7416002)(83380400001)(8676002)(107886003)(66476007)(15188155005)(6512007)(16799955002)(508600001)(36756003)(316002)(86362001)(6506007)(2906002)(4326008)(110136005)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8yks1AR0UVlrBP25nB10HNrrT+Ex6NqRhiHN/gUzqE7ZTarupVqeea5xeEjS?=
 =?us-ascii?Q?4pghxN0IRFhf8Tm89zVzIqRZD3ErC1VaA++ZVyWLcH2UzSlbyH0FKjm0D0pL?=
 =?us-ascii?Q?BKhYaAuLkGTv5uURNDoHw10c38rElJh80GC6mKlLT8GpREgvE0PJN3wBOuVN?=
 =?us-ascii?Q?H5RyDefWTNTNmIU8/nVvHgzsj58uhO/vNgcKkb3PPn2ZAAwMgfFTap7FsAi8?=
 =?us-ascii?Q?C2nLHj/Hq+4qQM9ua4Y5wqngbNPInnXxtWFBIOr//qEOI4bFM4jcEjfPGdKU?=
 =?us-ascii?Q?4AtxY/+V9CXdyHyouSirFkQDBtihwYAEkxD+mUG8PisK7L+Kf7nmHOdKAvdT?=
 =?us-ascii?Q?jjyrPlB2oydOXTPx8KSNfSRQvfdsm7z8znEuJwJ5Oj82SscErXuMNS6bhF+T?=
 =?us-ascii?Q?TnNpG/C2PCOpp49+R677Afv5lQS/AVTY+Eem6Pzzi5R3eDulLGQaoE6UjFnC?=
 =?us-ascii?Q?DEXb3C+Gtrf+Ad1vMK802q/1PpYoSzHVt9z4OCJe49bY5MKWArtyxxGHOh2Q?=
 =?us-ascii?Q?kNElfE1y0Spu+DiRDuq7L3VeY1ZqFH6oJvVtBKA4VULRbBr+VMv8Wmcgo6z3?=
 =?us-ascii?Q?dIM8Z88X1HpV8LCDtzCfYMXWwh002zNk1omHxPQGmCDURKW9yyYRZfz4uLVh?=
 =?us-ascii?Q?m+xCUHIqjKPPgIWLUrzGdCf+PY2lUJ8zAY6GlsuqP3iwsM1akvR+EUSxly9F?=
 =?us-ascii?Q?48a+KNPRNKSriDLQXY2HQdgJH3i87AItVaU8qztZT4k69Rovcsa9f+s96BQf?=
 =?us-ascii?Q?42WBMcZpDV5R2UXnvquTar5d+ADWYPys9r6GWSXImYeQg52zEQCVWcnHasux?=
 =?us-ascii?Q?vJF17IzcxkNmKPZpRg60ATCH9eXVgwydGiKFyqWhdrYAyQHAnSd69q+ElDwb?=
 =?us-ascii?Q?dAYE3i3d5F94se94JBFn/qClDWq8AetpiG14+oww1FVN8wOLPkz6YT5C96Sn?=
 =?us-ascii?Q?qe3NKIGU3cavEZkEuZ/xOV+z8Qlj47IX1isv+WCD4Azp/BcpNZAA9RShhGfB?=
 =?us-ascii?Q?75GSfGBIGFKGQFkKAH5Kkfid8kDrRr1hKCzP1G1vCrq1FDnXmelIRKGL/1fC?=
 =?us-ascii?Q?7A8PBUnUxhsLgapg/ru0XLMfyBG0l9SPbBH3+7gC+pqaerTSGthtRxGt9dj0?=
 =?us-ascii?Q?Yxln/HdjgK4858PvwbQXBwtO9dSLVpP4yvIDC6mQx2SvSm+KaVfuP942DJOP?=
 =?us-ascii?Q?bXnY+Fb0489G0bUJrv/ve+TJ4x2NuXEk12q7AOIoqq55eam+t6pF/9y3cPq3?=
 =?us-ascii?Q?GsuV0FHiwxBkhXww1zCSqM90CkqYA+8RqF7EAu2t1pGQRygPMepeW6GylTVX?=
 =?us-ascii?Q?L9myH5az8w4RJRwIEFesvbB0W+h6pIJfOeLp+YxpvVYquTZxgBKZ9Pa9Ft3P?=
 =?us-ascii?Q?AOgNTYtvqoe0XNmupZLnsgta0+XI3zYOHTXt5PJ6CSYDigwsmQDSogvLV8ff?=
 =?us-ascii?Q?EgjHBg5JikFUmE1PvCGMdA2pEQ08Z64q05phmjyzsHseEcmKpLBr2JQeCeFH?=
 =?us-ascii?Q?RLE9ZPMBx4RJUjXQWBLPPXZEi1qb8FOvhFvt70QVXV2Egl/v1z37ys2AQaV3?=
 =?us-ascii?Q?ZWZ2sFQs+7lhnmdnvTy+WPE1gFsaehvTi3A19u3YzGFloeKjsRy/BkfmNmYQ?=
 =?us-ascii?Q?o2aab0blDGoUq9FuxpfLN/Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcd5736-8e86-4a72-c4fc-08d9d5d20f05
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:47:22.3238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkV90PMqjL0UWU1sfT8I50Cll4dMebaE6YICXRG8Oq4bWdO0vCv43WUVP0xBIglGcs8jQFHghaivVCD1amWNdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1594
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-p4 contains configuration commands for pylint embedded in the header
comment.

Previously, these were combined onto single lines and not alphabetically
sorted. This patch breaks each disable command onto a separate line to
give cleaner diffs, removed duplicate entries, and sorts the list
alphabetically.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index ad385d6919..2f05ec10ca 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -7,13 +7,28 @@
 #            2007 Trolltech ASA
 # License: MIT <http://www.opensource.org/licenses/mit-license.php>
 #
-# pylint: disable=invalid-name,missing-docstring,too-many-arguments,broad-except
-# pylint: disable=no-self-use,wrong-import-position,consider-iterating-dictionary
-# pylint: disable=wrong-import-order,unused-import,too-few-public-methods
-# pylint: disable=too-many-lines,ungrouped-imports,fixme,too-many-locals
-# pylint: disable=line-too-long,bad-whitespace,superfluous-parens
-# pylint: disable=too-many-statements,too-many-instance-attributes
-# pylint: disable=too-many-branches,too-many-nested-blocks
+# pylint: disable=bad-whitespace
+# pylint: disable=broad-except
+# pylint: disable=consider-iterating-dictionary
+# pylint: disable=disable
+# pylint: disable=fixme
+# pylint: disable=invalid-name
+# pylint: disable=line-too-long
+# pylint: disable=missing-docstring
+# pylint: disable=no-self-use
+# pylint: disable=superfluous-parens
+# pylint: disable=too-few-public-methods
+# pylint: disable=too-many-arguments
+# pylint: disable=too-many-branches
+# pylint: disable=too-many-instance-attributes
+# pylint: disable=too-many-lines
+# pylint: disable=too-many-locals
+# pylint: disable=too-many-nested-blocks
+# pylint: disable=too-many-statements
+# pylint: disable=ungrouped-imports
+# pylint: disable=unused-import
+# pylint: disable=wrong-import-order
+# pylint: disable=wrong-import-position
 #
 import sys
 if sys.version_info.major < 3 and sys.version_info.minor < 7:
-- 
2.34.1

