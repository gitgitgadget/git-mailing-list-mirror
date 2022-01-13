Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE8AC433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbiAMNtL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:49:11 -0500
Received: from mail-dm6nam10on2078.outbound.protection.outlook.com ([40.107.93.78]:10304
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235570AbiAMNsq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:48:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfplkRaqaMqGSExKpvyt6KVNdrTt/vH0ZvFbr3usJf1DMfOgG+fnh1PMb64Ttj4fK+ysf7pzWFzTgsgRyCr/F6O67nmkLjhq4JWLKFMS8WXk4cDN3sSIGJYhyV46++5j3SFw6u5NodRDjbwoRL7WqwO597Ko74fPIr8LOB9dyp6MXRIgyFMBX2s6op/BQFGW1+UqpTBtYRO0WstogAUYtS1VYhiS1CM7nRubK9HtZImTv9OZL9GqPcDEg/4UOl8mwM7Ii0SH2ShX83av7+BX94jXLUk82/pA8CokonhLTv03O2LAy/FqmC8biTEws7vBD4dkhXxSbBuCuNj/7vDRVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrrekvGFKZLWFQFHcCposOXdEcrOZvjOo8qHmJenrss=;
 b=Di8U4msIhaE/DDj+P+DopjCSd265BKoqAQN8Yo+84CCM+ySN/WnuWOlQbzGgm/bCv1sw5BJEfJvgaa4TPi1jKCXgHQbr1MBHyeywoVsmYqpE4Zagmuktn8iJ9ISMW1e7PYo7BnS2HiVdSAFYpR0R72zr3IkI2PDxhAigg8uGXZ1wje9erVa88EDcVuiXfeZwzWI8ggbTfV2Cxp2HDDjjF8PzMS/ShY3nLQNzoGv06T6aEL43cvrkfrhGZh/rw9hmi7ykFLA8IK17DTFWntTP5coPJyhvUMRcxFMSRHgQKl8mmtrkE5QZCo41iFeOwWrZefSPebBtzJ31PHUQXuSjpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrrekvGFKZLWFQFHcCposOXdEcrOZvjOo8qHmJenrss=;
 b=DVZlMzFiKgXXpz54g/7A6BajXCWC5p8EsdThQ5MBd366XRCTpfjb1XW4b4eVZ0AQ6+VSePE7l1yJukvAV1QfUUfwJBbkQ0FMQAcW9P7g7tPGwiOSf7b/t1HI0D0lGBMolo7aCfDSXS6uTf5OXXtnm40URWdQk1eCY07ouM6y/zq6A6ObyM2kydoiP+q4pD5fgOEaZV5lQNnK677Sp0g+E93hkb037N6U09aXDYfljCGY+07vHtuwOzVUx7fCCwtgQChHx8Go7rkgakcBb7TYmSqmthukjf5ZuZiAawUSxB3rHtuU3REpL5J9yTvl2dO0OG1yWxArlPGGKjKSwFRVRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB3791.namprd12.prod.outlook.com (2603:10b6:208:167::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 13 Jan
 2022 13:48:38 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 13:48:38 +0000
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
Subject: [PATCH v2 21/21] git-p4: seperate multiple statements onto seperate lines
Date:   Thu, 13 Jan 2022 13:47:28 +0000
Message-Id: <20220113134728.23192-22-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 624b9bf5-63e7-4c06-dd5f-08d9d69b66a0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3791:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB37913517D18F35769F824565C8539@MN2PR12MB3791.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CHlZJpfCEDG6Ts/Xv7MF45CO+r21tXU1lYqNJuol2pKztNlEqPXRO646lvi9rlG+uGLAv7ecCIdtNL+2F8eAFn5xKUXyf+P22R4Mjeql0xs2z/K+7veL9cg8YGkwy1GQYwFdKDO5gIPyEiSzjmtZSRW6YR5PplcZILc09NyOhYSpX5COiEqVbcCnHtcDvyEEZS8tGjqsuasWbVJF3i2TmOhSFry10P03B0zCJhkEGVlYJkenPLtzsNkDtfHK9mJ6lk9+146iAmrMbhh7ZxOwuzbTfRR+RW8+oBiC6sa2ER4pY3r1EIRVhbQYK5UevZLdRNyyTvG+VeN/X/nLn2KivF+nRLVWbHvzj1wA8njbq3U4P/X6Hn9hdF04WW373MhyBY94PXHb7JIcKn0mQF/9iqoOr7tK4xmPJaQFYk/1DgkBG0cWsHCM/dX8MV/wLvB3gvb/WCfvLSwJQ5DtXcSbPoSEz4AwLs4DVUUNk1OTiVVIdUX18bBBIYcGZINIB+VvlNwIMU2oMbwbOt1UzMbWssrvp0exOx/EXQeMQwojbaY+Pt7YwXyKN7dPb0UmbXfPOyGSMcGtWcj3culNWnSO6eBfvJTifYBtsk2NFbA+4/MTOhnqSxrnmBA+OGk146SU77VTHiOvoJs9Z7NLGkVAoD63Dc1mUNLlp3qdTkLSx28G9R0uoECl9BQj2riXd4K5OSggdYk0vvfuXxvz7fIwWRuvtfuq85Ts1XT1FqFgeOT5DRUEGBINIZ6LkuyEbjw2QB1hugJM33mXLZenVuT6UYw341/1AczBIhdje4sknwE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(6666004)(5660300002)(2906002)(8676002)(186003)(66946007)(66476007)(6486002)(66556008)(7416002)(52116002)(38350700002)(110136005)(508600001)(36756003)(8936002)(83380400001)(1076003)(4326008)(86362001)(6512007)(966005)(2616005)(107886003)(6506007)(54906003)(38100700002)(55236004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5MucCOMI9xZDqfyFj4BZjz8ujcQIOM5K/fIrpQGN0WtJsLswbgT1Yg8E5J0Y?=
 =?us-ascii?Q?9MNUsUFH89/gf2fS14Dn9X/fHU2gyeAw+Wl69Osd0hlLBvtTgJduWjFJe85h?=
 =?us-ascii?Q?5PCQwFpLdDzXIzYCC+dWIh51/BBSJrcmvq7d2DQ0yPRRnqj+caJcrRQ6Uk/a?=
 =?us-ascii?Q?3eJoIsGLhQyl2kxce8Nsy2sVdL2OrABIq8mE5OZlM+ji3X1Yq6JVpyBfXSCF?=
 =?us-ascii?Q?5nfmSP2PDXRd9EMCCxThuvvUqIYrdMVT3Vamxi1te0UhBSWTB4piwBd9iucA?=
 =?us-ascii?Q?eqtqiTtMcWcmVm/fa3lzI5Ewns1k7Mhv+Fg+IaZtWh8Jqsu0K5Tjjvn6Jg9W?=
 =?us-ascii?Q?2KXgPagxMWsfJKqn3jMSUM38KPnS2S1PnvpvcvYCXTxg5iiVzXzwWIyoowYk?=
 =?us-ascii?Q?ZHdXLbacQh15P0mC18LqF3ztB0cO5XSNT1Knr+JYNzvZMkPeZ6zmjVRCzDb2?=
 =?us-ascii?Q?jn3c65VKxBPR9tD7jVDaIectdAYM9oDUU7EzAUYYyhpLt+2Oy+4ECGz9X7FS?=
 =?us-ascii?Q?SQ1wNenHh713K6CtVYymSeWWiq5Kp8KEVg9MjON9oUZ9OqgGexIhV/R/A02e?=
 =?us-ascii?Q?8rn1xnwCn5LMdowEWX5HKyH2cfFnD0WXFNyS8dPDffZMzHbMRTavpkIYDtyU?=
 =?us-ascii?Q?qAE4HKLNhWzlc9YyBJHIQCHFRkIyVDbCgXXuCFzYKPiL2MUHcHfE7uXthtlx?=
 =?us-ascii?Q?QBbqn3mkcgRBo2SJ30+t7pnLpu8TxT0JUpZJmn6VEoklR5vNF3TVvBjvc2+B?=
 =?us-ascii?Q?MRIAXzRDHYM39bMCP1gUu8UVDmt4hL7dc4WM5b2IiuiAs6gh22x8pCoy7hOs?=
 =?us-ascii?Q?oFPgOmBrbjp5WgkJ9kYy0lqQSQ0EVE3cG0sl6DZhi48SPjQkGSUohWwn3h7D?=
 =?us-ascii?Q?o7wcvk+zgyAqhEcRMHZuOTElIC+j0UhT5XV4sCsxwnr8k6tMac97kaUfbSC1?=
 =?us-ascii?Q?+4uVaBF0khyMdfa8i0QVCMT74GQB4jUZ7Aw98bTv6uxFBBxWzUCx0BCLXP4N?=
 =?us-ascii?Q?WMO/Buq+V8gGRppU8ucmS5AKHWWG/ssxSDSX7E232OkC3HSVBsRLaFJ791hi?=
 =?us-ascii?Q?aPwhSD0fWAlubUTMqHLBzEUpHrFH/mEuFBGOqfqnMfYk6lw6//ekuOzWf596?=
 =?us-ascii?Q?IUo2VKwmPSPJCNcGYSoVf5cxp4IRTA3gx9LqzASB/GVs/Z+2uNxSLWoq9+1u?=
 =?us-ascii?Q?J9deq07Y8tZnm7MmdAtQoVYjlGojFsPX18pPt2LwWjbFdO0quqvWGEbmgTS5?=
 =?us-ascii?Q?aoNVmhuvz0DN6b8Mc1IkLU0SOVz4Xj4FEd0swPv/aYauEfJLy8Ve8L6eKNoM?=
 =?us-ascii?Q?InWRdR8GEdXX8S6tEo7cP3Z/jl+4vbM7mDYcKxE2HBU40/j1TcAoKbgCv2QG?=
 =?us-ascii?Q?hXCDJIIr0h3CSOWBfmZTrI+HkwfvsVU6/AyxFU7DubnJ6UAzKa1GLEjy+0SG?=
 =?us-ascii?Q?TtLiGHlBNp/6xxzsHQfpWC5RlFZv9oVniqq2Rho83PsRMTPybjYR5WpmOhPo?=
 =?us-ascii?Q?wc49Kj1RTrFcEwf9xuNZ0QuF4X0pGoFRonCFECV9SIqbcNr6dVM8cCdEw/hl?=
 =?us-ascii?Q?PiSYSalnn1Uh9ps3xjXuLaXPW4STsTsFLWdN702MpX8nJkmrhpK0HNG01ENz?=
 =?us-ascii?Q?G1BU135hT8kQv3W7AnceOKE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624b9bf5-63e7-4c06-dd5f-08d9d69b66a0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 13:48:38.0510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXaWtvSG0k+vTuRTYw1L1g3jWZBJqIXOyZIHUisLmzoYjMYdEXUrAuiBdsfh2uT/XBNqIM4AYWta8D+GrHR9hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3791
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
index 7789989ec7..7cdc98dfa6 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1264,7 +1264,8 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
             else:
                 block_size = max(2, block_size // 2)
 
-            if verbose: print("block size error, retrying with block size {0}".format(block_size))
+            if verbose:
+                print("block size error, retrying with block size {0}".format(block_size))
             continue
         except P4Exception as e:
             die('Error retrieving changes description ({0})'.format(e.p4ExitCode))
@@ -1891,7 +1892,9 @@ def modifyChangelistUser(self, changelist, newUser):
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
2.34.1

