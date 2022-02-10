Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA56BC4332F
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244766AbiBJQsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:48:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244790AbiBJQsB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:48:01 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2042.outbound.protection.outlook.com [40.107.102.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194C9EA8
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:47:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjMtwY2OX+kNMKrxjBKgVXSdd9NHB6IorZumbH/qfunKF8B19UYyeLGsVmjmkeBje2fPAXx4EFV3mB2yINaZ2nv9l71w1Mxl/Z+D7cx/HBFU8mNSWUgTHuex6L7cHtiHViRxdkhS/yCp61sY9S5YSTeeyUBm22AQIqTpkuZPiIdXIUXGJ+uRl/kuLy03+FUUDhvF2OfeNXnZZu04FZExvyHd50gL2Acfy+KfPJ5rhU3ImUZvXpuCHt5DOp3Qd8f6iuCcjlR0e3F0ql0s+4Pn+xx+NdmcFTUgbT7V/plYhM97f3rhOulkaaNomGg4ERB8imsgAlKARf0UIlceAtZPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8pC1VFIs83mhu4Jt0Z/uiG66WyQBroojIWHN/WRmJc=;
 b=Q2+UHJLXheFaUNBHz6rqaHCbb219rAQeZM5EZxaqr0nXZHqcWCY9KNRZ9x1agz8x0Iwzp6+x6RVZ9KrqKA+hGhn97i1dhr8WA4xjdkR4ALqu1WcEVBA2nkyIRlNEs470RNtMm5G2SdfNlaDKF09TjLFo4SvDtOnEDnTg4W8sZRTc/BoJfb7y2IaiDmXwjpfdDmo2XyxhzsJwkIpGLvW+cEsqp+sW5FRZ37oqP+/xvA1ZxBbburcucz97S9tgAQZomwcTFXk6TFohvz4DmqAg9vLgjxIwpvPMNSG51N00Cpb5d/k5MZyZxKdGqBucUifJoUSWGOtVyj8lV2A/WKpS/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8pC1VFIs83mhu4Jt0Z/uiG66WyQBroojIWHN/WRmJc=;
 b=dMGs0cGc3/ROdLA+yoYxN/ZK0o+fYrqW3UOdMRc31jQuD6acwVD11X215WFFlDsJZ1CoJarrtdVe73JWHMHHtN7ba/ecBrM2Xw12sdnce3fkBzU6jBQ39wgaBSAX52rtiLei2SSo2QKLcGF0mZMNdjAQkX8uwZux4ZRFQ4TyR3M++yj/agXDH9uJBAyg0YvMlIRXY4wiTw1dVrzvdI9813BBz7qkkS2aQLl1vJirvVAzecwRu/8rj02s9ynJnMazGAIhfrlo7oWTXhDYYSZFzEIpVYcASw7pTWS+RtohnAQVbvuHByh7RSSbzptk/y5Bxo9GwfIRXCuw9pE03u/Suw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:47:32 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:47:31 +0000
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
Subject: [PATCH v4 19/22] git-p4: only seperate code blocks by a single empty line
Date:   Thu, 10 Feb 2022 16:46:24 +0000
Message-Id: <20220210164627.279520-20-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: ec6b898c-4aab-4300-97c4-08d9ecb507e4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4101:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB41012C580EE27B59681D02F2C82F9@CH2PR12MB4101.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kG7J6a7wayH0T0j4Q+//iRG2WAs2kolv+RI6ko1Pt8WwP+5g98pCBSPy6SuUjd+gEIIm6dhiwp0Ca2Duk83YMI8J9Lxd7stBX/RfC383054Te/jlg2aX254V2aniAB+KX06/a40MgqfJSyzHVgNy3Pnr/YGiKi9LbRhzKHlf5tEJH6e4gDfSANPs153ru/MkHYTlEEMYEa1MHO6aRa3aEgvpCaY9OZwN8+VQUbqitibOXM8IKYE21vGcqt2jEG2JBtqEc53Xp0NUZO0vggl7ZuS+heIrT1OnQdZj/q6d8+BRgP7EiQqgeq99Qd3hMsLrVLhqSwFoYop7U6E4RDgllkQ+pprQ4eyFDXP7q419AU/P4CK39q1uEgvDYY26iv9DtDVYUf/03CQiCyPFWb9VWb7MxrNXrWrnzYyQWc+t1wh8XkTvjKdV2bcCwlndGZybyzdpl9rpbpkTnnsXd4YtlrFtFN0GvRWsSaT5diH1L0fKK72Ts+ji3+az7hUj5MYu3utpK0KK+nkSHdQ/WySGaeCPKLC4+GpkNWM7Ocl5CJke2zFDi+x1M2/Z7gNunZLzcp1rmdb5nmkwLIOEBzPtCxK2RmZq/8y+WHi8FX4pJv5oPRS7cz75zGqYDauucs5cUmjBVKp+AhlO/T1ysmapiCFeHf44zpB6ycvqc+ZaLJTQ39HYvPIL7hp67NnLdh2h1ucsyF+n45isFbTcrzupma1cKoLV0l2XUXnfoLQgjgMJOgaXxtcRLfzXcSNxm6e754havZu9XiDuZBM8C+sLJlIrW9BQeduFIYPeF8tJaXs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(6512007)(83380400001)(66476007)(66556008)(6666004)(66946007)(8936002)(38100700002)(38350700002)(8676002)(6506007)(55236004)(52116002)(86362001)(4326008)(5660300002)(107886003)(7416002)(2906002)(1076003)(26005)(186003)(508600001)(6486002)(966005)(110136005)(54906003)(2616005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r8XU5MaLvrTg1vGB3yTFLpxcu6MGD4RvRo+IL6gNNRhUUYEopC2ewRONs2bU?=
 =?us-ascii?Q?WDNhoazT+rz/08WARZhy6MVn+wmBisdVJWtlWLjilmhf9ziB+7HinT7W/BPj?=
 =?us-ascii?Q?rywDVBlVeaNBjSYF/SbTZQ+gPIuTuVYKezGNYfASQ89SKPM/aVbOiFcivYsc?=
 =?us-ascii?Q?qP/Y+HN9dZqrcyEwEOCaS9BOAoAxCsA1QUzDl09pr8vka2Q+Lp7Wdny5pRrL?=
 =?us-ascii?Q?6L9zFSUgrZxdSgWSl9IIdZ1yFB11Rg7g5WziICOFDOBPEOOqRyPwZ/yGhQF5?=
 =?us-ascii?Q?IePLAmLMtERQ+AYc3E8RNMKhXzhfodczkljYLrhbw92MIDBtaA6KLoM5sxqX?=
 =?us-ascii?Q?cyz4InBWUVeFwNs3TGVTZO3uBHWjymbnw6/a2TrT3DDkT2xFOCSbzcehsAWs?=
 =?us-ascii?Q?NhUlh8c9D5IdZxldATlpLRsyTJBhILBlCeuhpRkj7+YGbe6A58l6PMprKggS?=
 =?us-ascii?Q?jNVNX90PyYe7oJseQD9ripRNOdyTbHDa/Vhltq+eQAcQ8zg9AYDbHr2UX6V/?=
 =?us-ascii?Q?aC7GQZpSCRXD3Aa8HXijFW2b/0vR2Zly6tiSmWEBs5sigSC9oZWQFljHNlzY?=
 =?us-ascii?Q?jX+Lj//eROR2kABVNDByn5+nCxtBkSwvfngb1T6WarN0ShW2V4FaxKha51Tm?=
 =?us-ascii?Q?6bAFOK1p9vaiB6hCvYr6AtW1Ddx9CHYaQr9xXUvg+GJqElQgDvvGQtPN5t0B?=
 =?us-ascii?Q?g6JIp1Cuke03scZb+6nrvt+6Z5DjM9NgsBOwOSTcGyoIbWYnw4dNGdYsV23k?=
 =?us-ascii?Q?H00ijOMNVkYVdjoDiPWYZZElIHh4zIGSk1mlR1xjSHrYifBVJY5/QWrSHpHE?=
 =?us-ascii?Q?ikBa79OJk7wK6EXyhmfSloWBPC8RFAZuO+UqZ9tWN+MVe8TERpXFxecK5nxV?=
 =?us-ascii?Q?IpENcB2ltAxzZBa+xSSuJqBqfd3DU1mL2V3U5ouCR8wLKsvxwzLdHUeR85Vz?=
 =?us-ascii?Q?d7LieHh9wWT3xkgjKDM3PxXeJh96kgWoZFFK5x/Chv1ZlYbyMhrSBmHRXvQ3?=
 =?us-ascii?Q?EdVnvygzjQ3G7Oe7RO3t4SCoo0yyYi4cyCbBGNJofrm1rmrwcFXVH52FdFBo?=
 =?us-ascii?Q?A25KTAWX2x+PtAjpsPqB8ukkWa4IBXwvcSE2f41pq0ARYBDiofntRO4hRzEM?=
 =?us-ascii?Q?6/7fzeqFpYaKjyWSZUokFpMAPAJa5IOJp8LmekuKvJUbBMg1+3uJ60jpRN8v?=
 =?us-ascii?Q?fHqPoDT73vtDaX4vuEWvmdcUiJwciZoOU3AnkCXhIy/ai5D67sJTraymDoZ/?=
 =?us-ascii?Q?H33OjjGFMTEPmgbVGizN/3YDCZendqftOeXUlpt4ZLQdBNay35A9qhEgvIAn?=
 =?us-ascii?Q?ggEHpwe3OJM0/1UvJkPfx6DX4+WSdSxkrXhVl57/+C0xFUyylkolCJjluLOM?=
 =?us-ascii?Q?m+WAZi12HSLgJMJ76gSbA6BIsSgVEN+sYGwPGFyqBQbpwcml4/JSak7oZRWn?=
 =?us-ascii?Q?HKCWZNE9Oi3f7q4NWIP8KyrD/2D/uCQDraibbO7/k2+Tdwgr/NFyHPRN5s+A?=
 =?us-ascii?Q?9+ylaM9Ch+LQEVYJwCf4V7MRpKOcITnwzd3BisrLOCqeohN7Xs/dwVzoy4qY?=
 =?us-ascii?Q?Mj4h3mKpTpH3vnUesXRhk2KWI5IBS+nkAgYvGKhzXdSgi4iUXAIoAssYqY7w?=
 =?us-ascii?Q?tzxEYQpLKSf5/oh7VIqMy6A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6b898c-4aab-4300-97c4-08d9ecb507e4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:47:31.7946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iH4eKNVLSfrQXbOynNnNquYIb/q07qEFuaDppdEE6evJn0gUhwalvjBFt9A11aWzyJRvgggp+JNA+8yp7lv6ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that blank lines should be used sparingly to separate
sections in the "Blank Lines" section:

https://www.python.org/dev/peps/pep-0008/#blank-lines

This patch replaces all double blank-line separations with a single
blank line.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 2f2450f7d9..c003b6246d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3521,7 +3521,6 @@ def getBranchMapping(self):
                 if source not in self.knownBranches:
                     lostAndFoundBranches.add(source)
 
-
         for branch in lostAndFoundBranches:
             self.knownBranches[branch] = branch
 
@@ -3745,7 +3744,6 @@ def importHeadRevision(self, revision):
                 sys.stderr.write("p4 exitcode: %s\n" % info['p4ExitCode'])
                 sys.exit(1)
 
-
             change = int(info["change"])
             if change > newestRevision:
                 newestRevision = change
@@ -3773,7 +3771,6 @@ def importHeadRevision(self, revision):
             print("IO error details: {}".format(err))
             print(self.gitError.read())
 
-
     def importRevisions(self, args, branch_arg_given):
         changes = []
 
-- 
2.35.GIT

