Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A83C4332F
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbiAMNsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:48:23 -0500
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:26926
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235486AbiAMNsT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:48:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sl7VENeXeOC0NJrb2E6Z16IPuNrOFCtLCEtpRq2f/US1DMNnnHEeSbX/X0ppvXuayM3/8tNhi3Skmc6M/ci6/sMK4bGrdB+/rLI3vifVfec9vjAzZ/ZvpzDuMyv9188ulNGf4JJneD6UnzPxze+cpkE8xp3bXmfQU6RQt5n0T6Z8ph7nedWisS+ant8btR38yy4j2Uw5zvTuyYKxGoHy4KxD6elkWOpPhchD/z0vNmN53qasXjSr0T7RKgSqYuD35GsKL2a7AtIWN1Ewtr0m2aeQgrXiQfAlqFD6Xz2bHYamXnC/P25jzh9XACvRoa3OoLwEe/PyVYqmx+rhXXL06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5MUQ3hem1cFLAXvTtL2nAGdjr5GraxSsgvHm/XkaBI=;
 b=Lfq9qd2R7vcmmgZOE7reiH+uZzzn99XExpS60bMgi79p+l0kNHctaAFUtN16Sjy8vlHkIMMJFRykH3WEX2FAVv8gCQD2nM4BaM3yZ0Y0mM7d+JRUHMqvekZWdGvFLkj/pI+IYr5LvotkpXZoi4cKduzXwdDJ2wfTxbCOSZ4UHsGgWW4YYMMZQbkeEm9l0in3V4v0B5JU3RWOpTud1scDLcogbGN5prREzPMEO8S4zZSQxb+Pk/XRcVvppgEKiJjl/sKJgprB2DUYxQ0BMdJUydtp7roWeF/nghK4ZJKc+knoM6fw1q1bmOQQp0U4vzFWy5BeOtAj9Tpsg6iNdKSxbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5MUQ3hem1cFLAXvTtL2nAGdjr5GraxSsgvHm/XkaBI=;
 b=eaWpeLcZj4kN7BL2FuGDGsP3VZmCvxqHmiZLw/harmL8jmkPnz5XW4bh2IEDv+2KutBHPxEsDx8RY/DzcZ+I/6XeijrZxuzKT+l1Pcz86HAv8QUhbu//3ACfduCG5MfL5xXzYgm2c5ssIsiQT8fLhumlqh04i2eJp3dzHHLHh4B5PO0rqRCeRWJUTtcJmIG1Bm7bdWFwm9GqHcS3FNpCrA6ywdImmps/7jteg8d5zQHJ1vw5sUc4q0dlC7fi6lcjbc7Jqe+KBHdZg4R5lhie+qAq73j6q6BSz/fEmR4WkT30QXW9HN7IDirLHVDrEfwcqshi74zEk8kg4l6yFNVXqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 13:48:12 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 13:48:12 +0000
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
Subject: [PATCH v2 07/21] git-p4: sort and de-duplcate pylint disable list
Date:   Thu, 13 Jan 2022 13:47:14 +0000
Message-Id: <20220113134728.23192-8-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113134728.23192-1-jholdsworth@nvidia.com>
References: <20220113134728.23192-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0101.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::42) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c34748f-2744-4754-5042-08d9d69b5769
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB24474F7DA30536D3EE004126C8539@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSBgpAUuPdev5smppqnmdFUficrpt0C8HTaMkXMUwRQN7Hkm71HjSb2/xULX0wJ2X7ikbien1D3R/pAUz8TiRgD6k+nEgA6K/m+FEiAarGWzEamqwqDpLvcFcaGlAq6z9gqtxqSOeoRiSD0DmDuUN6c7GSTOux3p57jZkxW0EnLwEm1ApAh3y1bjNm5OXJPEqUYiifZ4EKHWSj8LLuVIBNxOYdcH0Q8aGaem0Yx/MYWHdGZTmAtCTr/rzl1TYurejfGs8/vBOUOr7Jkl+EkUgEHR8aHZ0mNJArcZGLuo9Y2jvmiqP17V3xRmYdKHFKow+iqDVF9e/pnldBGHE7AbCG8ydHjBAmrqBJkdidQZp1iyHsnV939mPfn8lrGRKKSw+C4td3fLQZqLowFSKH9fi2qwDJKj5/UWDx61nw7SA/okAkfLiFr5Eq31B3cAmKUFgafdNpNUctdnc/emxQJCGZt2AXfq4IalG7fizf64Ad2qY7h2wlP9l8GOMXRtobspfBR5MEQZwStos1JfxcU+GyHofo205q2wk6/mxsRx0kCRGcQ8dyjVhZ4/+FVjIxweaqflxis3LwkBc5My5lowy7IGu4CKcQOSfQTJcc4aAynf7+C+miGyunSQ99ebT+1g4fLf1sozpQsferGnAKOX6Bhp0Tf9bSjcP1dTPxlUyvWgSKGFhPpzIM1jHDcSfcJdeDTt63p/+ynP0ctBM+KNPMC3cx4SlzUEeiN0y8HsIEEPuzWgdl5I1VB0FxMINCH6YVUUSEijTz1Sr6/uazLcnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(1076003)(8676002)(66946007)(8936002)(26005)(83380400001)(55236004)(2616005)(16799955002)(4326008)(107886003)(6512007)(36756003)(6486002)(186003)(54906003)(316002)(38350700002)(110136005)(38100700002)(7416002)(508600001)(15188155005)(66556008)(5660300002)(6506007)(2906002)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sz/xuEb9VY9A2XDpS0ZXZYZXrb1kVnBLiqC6H9VLd8yX0ACPKJbqdQhOrvVJ?=
 =?us-ascii?Q?Rdpf5ZacSFNckSzPLc71cJyZ+sVeYM5bxZ9p/s+moreaYhDtst4UvmuPtQZr?=
 =?us-ascii?Q?L3UuQ7OWf8vzEf8yIkLHeiafAAWe+jzDUR16u0Isx4Hl8JOcuDW9chuesp0+?=
 =?us-ascii?Q?iSC+1ny8J82AuQymuOQjfmMjSDc3a1HHNglScdCFXMFiFiAN0IlinzMqz9uT?=
 =?us-ascii?Q?ihWyZhts7v/7UfEOpjEuWdjC7Y4b7bxSEQa5Y8R3oLt/08XG5BAnrm6jnneB?=
 =?us-ascii?Q?lZ5jjROnMLfswjU6t7IMegg82IZ8hajjqyRRsyD9ZrcDuCYh53D5+2on9tBe?=
 =?us-ascii?Q?fz9fvGPr7qxumD3Sp84SrZy2+BsJb1pNga0APlCvop27d93xskV2MnuYt8CE?=
 =?us-ascii?Q?buvNxLEKct0RpBO+96zLqEFNRc4FKMMiRD7yzsS2OKU0beczpoPeHAOh0CWx?=
 =?us-ascii?Q?6S9tQkUiXHsYP0GNpY7Ydul7LzBRW0xcwSn2ot4vkvniqx75RbD7lW8HETGr?=
 =?us-ascii?Q?4o0bh0Wvc2J7qh72IfrqeRCnBhpRphCgNcsDzJWKbI7TaFmvaDVZTQGeclID?=
 =?us-ascii?Q?3IdWayUGmiM6Hiv4sYd9corLAHOF9nPWMDtOUa/h80zoHZOiWzyk/Mg5wxcz?=
 =?us-ascii?Q?W0O5Tpz6iPgto6QPdjT9E+2X8AgkTtu0NiChxHKkj05muQ14BELQsu2i/rta?=
 =?us-ascii?Q?r2RIOhDjLfxtpiWW8WpsRMj2KWxXNwoLyErAWlBs9UrTgmqGYaY9M1mK7eSO?=
 =?us-ascii?Q?TC61ydixxguGjS2abl30nL6w9lv5Lh+wpph15Awqm6+VXORO098yIyR4lVsp?=
 =?us-ascii?Q?dEP330EsZ9Yp4fjQ2rMXn52vm+pRnt1nPf8VyNdwbaEcgAgToW4zb9cuP3pe?=
 =?us-ascii?Q?ZVL8B0IpGbOVOtRjL6zMar36rjricvMb9wEJe512Wz7MoNWQyitHTkQ1O5rm?=
 =?us-ascii?Q?zsTvQ5GAoBJbZE8OUKpEr0Orkj3svxIlghN4NfeycHh2d2jzdZCd+FCHq8AQ?=
 =?us-ascii?Q?CmOA63TujWdkZMYP2imkUlijqemymW4u9nXSTICOmjV3vwl39yAVfp0SazRq?=
 =?us-ascii?Q?F+FmmzJU7LURcYQW52y7zxaWduKCu39Fu4wKdJdRE6qulWX0Q0S40VvY11+I?=
 =?us-ascii?Q?DCgcUywKfxmxdUbzpNyLaXQNOyz1j20R3G9K4QuRtcOHl+Ri7isQppNZxg+8?=
 =?us-ascii?Q?KtcclFnj55YiM6W5mQQQvDe23Vq2EYpNwBFN7Z+7SZc0wBvSkCuNGf94ulsl?=
 =?us-ascii?Q?kDQYhhXHTAOzOAQ08HKdlbk1ZIJ2wY75LyNyg53Wi2q+nlkzdLCabu8ExsbU?=
 =?us-ascii?Q?51EB3wyB11CwDrnlE6Tym5E25EXTt5tLqrIHIPLRn4n6cllzi7JIX/uaWFPs?=
 =?us-ascii?Q?YMyfDddGOC+F5EcuYSe+0E1bkYD8BGNLoHkSbMGC9IunT3CzrHHn4+jYZmyL?=
 =?us-ascii?Q?J4zOanUvkyqki8EnD78wtDZQ3LeNd2sjC5k/WUCVEw6yTEJI2mTT2mt3DzKL?=
 =?us-ascii?Q?zm9Yg3WJex0I8ZYOZoxFNyoAQ0t58uCuL3c5k44dMdU4GpU2t0zup1+Owi3T?=
 =?us-ascii?Q?73gXoZbY8xQyV+B0S29AqLagq+mlU57dMjuVtHCZQckYDqhgwAiRGt5tys45?=
 =?us-ascii?Q?FNYrPeqDWCvAYp+M24CZPtM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c34748f-2744-4754-5042-08d9d69b5769
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 13:48:12.5992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXr7OYKfJNoT3BiFicJZnC2LSDb9bsc7WQFqTqtWsNubmaxI7OyOfUMjOs1bMIJeDqGxMQdl2ABoi9PGyJY6FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
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
index b598144fad..1560ad372c 100755
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

