Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB119C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 13:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353693AbiALNrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:47:18 -0500
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com ([40.107.243.64]:18753
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230018AbiALNrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 08:47:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeaFbzpEHOybbyVgz7ddkKwRD70/0EQbb6r4xlnJuPKyyaO9+NIcQ6B21+xzusQKKq7ERV5kTZXosei8q15nfhNbBMnGkW+fhPxcMZ9MJJcQxtZAF0iH8SG18yG3VOhVHTTLl05rAIPnxnZCp4Vs6VKa5doyfCfWI+4y4ehRbGiiBtOFwxMRv1rBOKLReWEEu5kYm2UpwsEEFV+EaoiwtWplBaKhp58vq8gp+Of7dcC/FSpuxokwrlIYcM8SYrVh3Rg7fVwxIGf8FEz62OQsQ6GczTBATU1J+PNffG5pKLdampQ1tYSelaNhML8YryY7mKZmomzC+awUnVslJRmYjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLfKxbWnKm09SFhwPVMDILn1CWNKU5C4eEDFRi9JYXU=;
 b=W33cHFxxYoxk5Jz/7hnLSJEIhCsk+C6mv1pmX6CxwXxzlOLdgBoGQN5GP1TVTVfrP+b5/IRi3dxbXrkCUDo/wQzY+xx3RgOlIZEXxTfpaNVvI25Z4tlTy3wfmazP+2qIWHaB9nzUKmrPO/ZnqVFhokB8SceKql9x4cv8s3/0XU6Vez6K8MHJE+QPRKVaxo5h0C9X7JTb1m7mIf4xanLp90dM5UiPXP2siWhkvlBbmQxa7RYXVXW226CgiZoX98acAnMyWzpe60v4rCAVq6Jj3mU3QkZzDi4hJpGrPuhG0RMuoRHfq9MZIMX5aagCw6hr1g9CWrwFlZgKkuQc7KadkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLfKxbWnKm09SFhwPVMDILn1CWNKU5C4eEDFRi9JYXU=;
 b=tI5PZOskCBaFQ1r+ifLGT4pre0rYm0kN6GuXeIDrciVJX06WrCNGGFBjZeWfJ+Xe0leMqUEe2jkseqihgng3tyvi2wY5FGdzZi6Ny0mrIqvWztYITP6SkvkF/bjXsuqDwXQ1I61TMb0pWJyQDO9T5j/B+gylIa+Q75nr2rH3Lz0DeFqdwSr9bqOMNAZSFbfaamFdi+4qx8A83V3WKj0ZzhDCB//RneWTt5YnoZsTFjwtdFfkfNm8VHPQGP5ubRMTn+Zwwr/sFyYoUWjOtmuKgMXZ77c3GorNBIltc8ft7HOArNuPP3UtFZrGqmWnNhB9CAqjfQdsOI05GErP7dGf4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 12 Jan
 2022 13:47:07 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 13:47:07 +0000
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
Subject: [PATCH 00/20] git-p4: Various code tidy-ups
Date:   Wed, 12 Jan 2022 13:46:15 +0000
Message-Id: <20220112134635.177877-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0108728-4cc3-42b7-9530-08d9d5d20624
X-MS-TrafficTypeDiagnostic: CH2PR12MB4279:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB427979E46B5445187C6A970BC8529@CH2PR12MB4279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bNNdQaz/U/glqqAVPlpm5iIik4KvaCr+naUQm2GdrRMH2Ovoosp0Rm0kqdIm/fC8FXZxtkCC9n2EHx98ppGVvJ6wykGvfzK/DtY4Tu2yAgo2JNb3vO1lo+ofxcm1zOBdfLPED0HPzQkPt1qcXOWg4oJ9RKoLaFf4rMRZTY4/8IxMRmULJAVUrbzYTR4Hs9qApLj0xgpdnOit2ZuoGEgM+cC4MSXa66KW1oxo6gbSGTXceayy9nlgtlbwnFH1Eoeh+IEApT6FpyT/pw5ZIS8pFKSSLdtzmxZtAZI63iFuutl2U6+JemzljdliQXfdk7CnJQbilK4lVsV4+7YtI5C5pGUNckx/sBQYU21pHjP2LyG3KwsOeguRjxsZBrd0uA0uZgKTzqJ1EkZ0xt7aHGKeYhQzz1mNFjJm3o0NMt1ScHl6yQn8Ndt5jejKii6GZuCPgFBIM77y7se64DbUxl3pW8rbYMjPJOnF2laBDDkjRHQzCK/p42f+b38pXRVjzzSMy2FJAq0KKBosX5i5kFu7yTiBnjB7jRn5rwvflq6MrZ4WzYPmJ0G/AVU6v1ZASt7g4Do+tMSK/j7x5IqMPm7kHxB5EuyiiJdxj7Ns3anbXbeDqgLFPo6NiRviWnCRZFTB/Oedu8DoN3Gh7Rtq4DLrbKPxG/QqSPc6eYNciuvJPwcWrlL6TaqiC7UiS7yaXDOq8fj99kCyW9x+ToOZNO7Lww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(55236004)(7416002)(4326008)(38100700002)(38350700002)(508600001)(6506007)(86362001)(54906003)(6486002)(26005)(110136005)(6512007)(186003)(8676002)(2616005)(5660300002)(66476007)(83380400001)(8936002)(2906002)(66946007)(36756003)(6666004)(66556008)(107886003)(316002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CfHN2lVoCvfZtIT1iHIJ0yvGxtYVxV9wt3PSh5b8TNRbQcrW84nI9VyZ7wTA?=
 =?us-ascii?Q?Ux+VdF1MJwabzk6fOpzNiiwwk6ksrMDs8F+bvlcH0bXyFEqSjhLOd//Cv6bF?=
 =?us-ascii?Q?PkrBCrh9fh1HEtzQXQ5gNJm1YNdfdHFPIOAZQuXGvZkpRqWmu4m5uOWJJ8zS?=
 =?us-ascii?Q?3KAjEYBUBIduZCHbGiZQat92VD2EwlQRm3sPio7l9hM2FcXV1aCbCTFQFBJm?=
 =?us-ascii?Q?XSJQKcn/FAFAQiupsIdE3kTly7ETTzn9fdK3Ke1qenXJ2yxbmCkS6VYz+RQm?=
 =?us-ascii?Q?LQ1UtmGhq9pcBeH6aFOt0Mc6kevWtV/wf/Twkcdms+QJl9IhgJL0nu8MSSXS?=
 =?us-ascii?Q?o4KfWV3TYjrCoViFU6YACKDKDULUteyDU6kyXNdy9tjFQwP32IyeN1PXP5XG?=
 =?us-ascii?Q?hboI34KM5s5fivr7itcyqeLAZlY3rRNlILhX2biXLK+FqHnsHc50WEl4wja2?=
 =?us-ascii?Q?fD0nw/E7mqdodtepVtrwGk2rzmifzj18Mw1ZAIpinA2RtyWVbgDh6z54M6TI?=
 =?us-ascii?Q?xqerpe1PUsP5e7/JNM7TpYdb3o9Q2GY+MFxh+CsuYF7lgiJlop9NJizzmjob?=
 =?us-ascii?Q?EvfhYJYWpHWN1Fm96n0tbh2Yt7QpmLJsaaDzQFFuUxgTCLArjtKWGVhsX4z/?=
 =?us-ascii?Q?PfYKR8BVtORyF60arKWyTuGVILHs0GvK8VNe/vNroCNmEpVmbvgpWqGLOWwx?=
 =?us-ascii?Q?Na/ooaH8Nv6IOpkHmAHfGtn3AWqcTsILUM30uEw61jO5+oKIDGY/FxaE2WtQ?=
 =?us-ascii?Q?gMUepKCXZShKIeNSJvJuN96BAkQxpuiYba6gfNmmo1RPh9eDqbweUMyUwc6u?=
 =?us-ascii?Q?fUCUn6wyAVvKvTv3A5WMP2Znf5LvnH6xoJIga1Yv+H2p1hmaCm4+ArHQaF28?=
 =?us-ascii?Q?ToimR2sJVEKwts3+djp0g8/wNSfIsQXKf0ztUCMpMQVtqLUVRFKUH8flDfZi?=
 =?us-ascii?Q?/5XQY0bT4+cXmd2v9+1GJ956sqw3ivggPCG3rgJ7KXBhQsZyLAx2Z03Frb5k?=
 =?us-ascii?Q?slpZ5cWHsGef6T7FbKMZyHluqD389iNFxtFECyPK0rdYsj5ObOsWfS/XcsbM?=
 =?us-ascii?Q?xvj0KbkzquMeItDglb3FUX10JYKTrvAaIZIH3DWGn0kWFhk7p4/UorjcM07C?=
 =?us-ascii?Q?hQY8bgH90OV3klIW9Ht9aCPYAP9jTW75ewO8o4KzbhdS7GCPrfIdMa2pQEu9?=
 =?us-ascii?Q?H0sWGb4HV+qvz7xrjQGklLt4NUZpd9UK4Kq0q1Eki1FUTsp51AwM6TgV5ZpZ?=
 =?us-ascii?Q?jgi7uUwbB+SGK1Oi9i7N0RMsIzUyKudBGddlVRX4hngsBRcbFjrAMZCrvpVL?=
 =?us-ascii?Q?b+oimXAxLg7Xcq6KwiYGXYe0uq6dg9pBkO3KGn0otXkL6RirxNDv1qcRyv5c?=
 =?us-ascii?Q?lEys+k2x9VFlM9alsKuhLfvP2FQ9Xhnxg7iI1INHALzsYuV7hrbUWdnba1sZ?=
 =?us-ascii?Q?FhdXPmMTiO0a3B0bVKq6H3RAfzkklkchyq5mdZKBeSqyO6HqR8FwWk5zNEW/?=
 =?us-ascii?Q?zmrr9m6ZjUxe/TpPcdy0osFnWxntaBAN1If1a3bwI+L/2FbNHvTvWRSOmCQd?=
 =?us-ascii?Q?fKLLkuS/E7gVwJzO5USA8MJqHmt+LWc+8D8H8q3lP/VJ61BK8kjggHy4LMwm?=
 =?us-ascii?Q?w66+g+zuTY5jS/ZEKVIrwso=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0108728-4cc3-42b7-9530-08d9d5d20624
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:47:07.7712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7G3cgBkZtubhbIkCB4YKf4is88KMSM5MXp45HZzooohC81Q9I2En4NTmFRQtw03QfI2kBn/MHq1yMMboZz8Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch set contains multiple patches to improve consistency and
tidyness of the git-p4 script's code style.

Many of these patches have been driven by the guidlines contained in the
Python PEP8 "Style Guide for Python Code" and were applied using a
mixture of human intervention, and tools including autopep8 and
pycodestyle.

This patch-set stops short of bringing git-p4 into full PEP8 compliance,
most notably in regard to the following items:

  - There is no patch to apply the recommended column limit of
    79-characters,
  - There is no patch to correct hanging indents of multi-line
    declarations such as multi-line function delcarations, function
    invocations, etc.

Patches to correct these items may be provided later.

Joel Holdsworth (20):
  git-p4: add blank lines between functions and class definitions
  git-p4: remove unneeded semicolons from statements
  git-p4: indent with 4-spaces
  git-p4: improve consistency of docstring formatting
  git-p4: convert descriptive class and function comments into
    docstrings
  git-p4: remove commented code
  git-p4: sort and de-duplcate pylint disable list
  git-p4: remove padding from lists, tuples and function arguments
  git-p4: remove spaces around default arguments
  git-p4: place a single space after every comma
  git-p4: remove extraneous spaces before function arguments
  git-p4: remove redundant backslash-continuations inside brackets
  git-p4: remove spaces between dictionary keys and colons
  git-p4: ensure every comment has a single #
  git-p4: ensure there is a single space around all operators
  git-p4: tidied visual indented lines of conditionals
  git-p4: compare to singletons with "is" and "is not"
  git-p4: only seperate code blocks by a single empty line
  git-p4: move inline comments to line above
  git-p4: seperate multiple statements onto seperate lines

 git-p4.py | 851 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 507 insertions(+), 344 deletions(-)

-- 
2.34.1

