Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8717CC433EF
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 16:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiAPQI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:08:27 -0500
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:61889
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235668AbiAPQIW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 11:08:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3+q8UanVcVjNwR98YwHfAoHRmltqoN6Ag/9cv2KCi7wXGlfl7iDW/iZ8KA3pbK6JTA/AfBzuRDrlf5U65gM2uYPytIZ0PPNmsIaZzS4ytISTdRCjCHyygFm84pB+Qb0bRcQ7A+GW6h06MwGBIrFCChHvCNt2egEP5MrKHJnmwqJEUp6mDXSU40KW4HH5JCKXusRNLWwo//uFbDJyhqH/0uFhff3pouBF+P4V2icbsL+pIOcKFaeWoC9U24g89TNBc+Mcu6f0HJMNTKvOUCU2Y9Gu67lLWOCQTbISmHSENPcSnfHxi7MDKjAfHUnHvU0pvuFomfdYpc/2K5R8PQp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PChfyPSOBUo3xFsu9QSwmadDsqWilI+Cs3DhFwfnoJU=;
 b=UnEjcDMIkyyaCsNiUwg4/4nheL+J8nJj+6Ev3RKhBExfjBPaU6oIkguRsFUEA3lHHOfnBNFaPM3GM2t1/r5ICXE1tD1SZ3QCsP1MyX89aNgTsoIWf9R19Df+Jbx7C7ZdGDhtpd5pg5iPEt3FfKuZ5CXGxgzrS52cjPjfiraQtsbWb3/pr/rwXWFPDTdwYEJklfwgA+r1OXvlfvCdKMD5DStOmHt0B4OrqbhzuSK/QSI4XB7/8hCtnwZfO23H39DzdA4YrlrbRu+OtUGGsPtLBxZJsc90UjgaPWZElJP1T4ERrhRcAEMGmADQcfVmIhf2QHUXEJxVg4aIu5eJxblJzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PChfyPSOBUo3xFsu9QSwmadDsqWilI+Cs3DhFwfnoJU=;
 b=pWFLxz/sXWimFG7u2SirGAwGcZkLU2JgRX1IQAVjQMGezoEpfWBhQWm7ICXP9qJyLOHg+4T15+RuBo4iMdxij/iJmsMfmqc2cefpIpiSxi/eP6vmFaqRKwjf7DgjGMkPukgZ3OwnYnVDbh/VDjIBG2izMfh7EnmF5GedZGiSYc+zPGPze4xzZtkBbB9jypQz99EfH2YE/v6YLoRZ7WbSpRFrbgKDvsMig7bEAB1WWvxoci5KVP5UfCCgluz3/UjNlJy4pHusAJxPSHVtpn1ZMYag0TCYUUP2R9aMm8Xa7scuLXF6xT6c4vTydCyFwE1GvGBdAEVX04a5KJ/jPglQ6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BYAPR12MB2597.namprd12.prod.outlook.com (2603:10b6:a03:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sun, 16 Jan
 2022 16:07:50 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 16:07:49 +0000
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
Subject: [PATCH v3 19/21] git-p4: only seperate code blocks by a single empty line
Date:   Sun, 16 Jan 2022 16:05:48 +0000
Message-Id: <20220116160550.514637-20-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220116160550.514637-1-jholdsworth@nvidia.com>
References: <20220116160550.514637-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR08CA0019.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::31) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 029bfd60-3a29-4899-da71-08d9d90a57e5
X-MS-TrafficTypeDiagnostic: BYAPR12MB2597:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB25973A61701F5547037B6773C8569@BYAPR12MB2597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USMYZLbvNYCUBt9kWuDqKnsWdaxzdQBVJo5SiUZ2/uOBYmapcHSioxq/v/TRCSac6EajPSyIjn9bHsYyxUT4+49intPstCh3ooZFw1ulFtdegcVfjQ2bNQJUeqKy5sjxbaJYiS8BysWwbuVJggEFGPCVhfE3wT1vbcSo3W1hLuihzh69v20BRTXVZMsi7/LnHFu3Ndi0EU1G5N8YqpReD7nPQuYfUxdNOCQN+HoR02ceONBfkRUKcflBGARHmvfXM1XmejUaZwMvM18GLHotEfcGARHl1erirDLzd+U+3ZVixsepemX9uoKyEHxSjjW1nsz1aGu19CYNsr9kRZkGs8VtXR75ySdlhCm6OicgJ9NHY+XdDXZ2+1/uOYu//8mQDsvDYKXUF/QWzuI6d0aoe/hY2QmO7WhIROukGnUq4BGSvZpqC/IU58eqSjQR9ZUKgShTNIMLVVDkwMbtmvNbWDdjg+4l7aOJF1xSajC9POgtCzEPqxUwlaeQ8ffmNDnIZkqy4NTzGIfQVXhuxWh1PPxqpCZZ7/2JZQTNeKp++LtY+1ZgV0XAyC6ehFEInpxmXMnQ9Xa9ckv5ZFbfhhGKB380/19xIIa4FyIndI1KgzHy7rp08ZeWZsyvyXFLAcIQo4Qu6Ae0TAK6sX9nDMk1e+H09TcNkHkTctnqA0KvJUXSWULHwE8nEK5MriJokIxbDjOmOxGWXZcCl51Y43nBiqmuRINvfB8tttBcJuzefkzPDQCJ9eO5oMfF7quqvfu5xTyjeNKensYNfin9QZlNuL5sB2E7cp1/QahWyE1e4GM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(38350700002)(38100700002)(8936002)(4326008)(83380400001)(186003)(1076003)(6512007)(110136005)(54906003)(107886003)(8676002)(5660300002)(316002)(66556008)(66476007)(55236004)(6506007)(52116002)(86362001)(36756003)(508600001)(66946007)(2906002)(26005)(7416002)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I5IXa1DbORsB9jc8wmijxPz3k/kAunvntOdgCJEEGxefEVjgCvkG9ROqV31o?=
 =?us-ascii?Q?7GGLfgQkPUJxwg0VHEC50aQq+/WvAOVfbJ06MyoNegT8MPzG2RRcHuq59mlP?=
 =?us-ascii?Q?8t3Yoeg1hrVnvWJCUM/K/fOmuUoSgyEQMBGS8rfMH1wBiJilXahQGWNguB1f?=
 =?us-ascii?Q?g1DeGIjRqEeuzvP91PkqE7OeXR9zSPGphoEtA6wRapk4z7SqoxK/vGT57nxS?=
 =?us-ascii?Q?w43NOmMBwCVPQIwHqh0a43mwa3xB3K77NMmewUAYcVDJVHRMC3/cltsdSoDX?=
 =?us-ascii?Q?PvzUD2ElOVIcNi78CpHbbGmFD61WlvUKN67Ltb4X4Az2jafnHpp8Ke/T5D2V?=
 =?us-ascii?Q?GwyKEt5ayVJQ5nVhgti9y2CzO6Mc9Iyw4L6xAJYWdcnn3R4z2MX5GYn0wGLF?=
 =?us-ascii?Q?godsUl4tsyO2Vd6QvtiCUGD1rz7VVxFQUfQUhWr754jEhXlLJqbPwm2wTMGc?=
 =?us-ascii?Q?rcFHVec/eG9KbSI1KyD+3MOhK/lnsw38buwTXUXeGHZjKGrn9uQZStNAaXPz?=
 =?us-ascii?Q?YesNNF+6qdQH4Z8y2IEshDIFKFjBT88rp7CjFWfr9seb1HCwxB3RSuN1+kMm?=
 =?us-ascii?Q?4azuCTz34Q6HuVBK9bYJVrWBD+xNsMlguXrMlhSXo2p9udqBMG7M5LQw8Dqa?=
 =?us-ascii?Q?FziLcH+BSZMZd8oNO2GHMw3ykJ6nyrCvJmsmCKgkp92IbhZJiB3fJM6HPjTc?=
 =?us-ascii?Q?DjIrRXXshNWqaIhkEwhwsYzqHh2V7IV8vTcTs20Vjo3YJI79gYgaWH98dYQk?=
 =?us-ascii?Q?H2CzPdAehDH4mwnc+04y11Wvx00FvxHjnlaXSRnejMAb9XrLkYvNofHhwyJw?=
 =?us-ascii?Q?JBl2qWwekO/NAaJ7YoI+Jt2+BP3XlFV58cGo5G4xbcfkDGegTjRHl2xITTeU?=
 =?us-ascii?Q?AxV1H0dFGyarf1fHAiK7kPUpBcYroPy4CD8jcaTqL15qm6hAyYE32gLnFTD6?=
 =?us-ascii?Q?PUzauMXiWvMs2PTUcTNc5j+NPRubZWjBtNHMXS/Jjeq4sRAWl1MxAhs8DTL5?=
 =?us-ascii?Q?nFN20KJ2WyY9CyMhJJuBIOS0qG0PT8f4nS7B/7IACisxQ5vOllmz0VgBVs8S?=
 =?us-ascii?Q?EL+/6hyTz/cXFDdNySYp1e9Fu69h/K3M1hjO9AiDhkRcP94sY6kwq+BBesRY?=
 =?us-ascii?Q?9KZN6x+XM2zZW5cIO9RzrYEZniAiuKw2uHeWWK8Fnw/8rWZL2bnuC8X/QpMW?=
 =?us-ascii?Q?x7tGNG5MTC39c27EETiPHtm0zhK9PPiofukYrx3ifi6IG0QK3RbCRDQ5ilJg?=
 =?us-ascii?Q?W/ObZPLA2NKHdGhe17Gr3S9OVF0Cr7XVB3Nwg8XlTrRmA1dvPXIoz1J89M6c?=
 =?us-ascii?Q?oHs/Q32i0YIkEt1wu+aknvWAxhUpy3zXozMbLg+92bldWShSuNLCh9Da9RGq?=
 =?us-ascii?Q?vwUGV2erdmR2No1N/oAHJujP+5EupNulV/fWCctwF+nNPFC/DGrZnmlqFlQt?=
 =?us-ascii?Q?4RCbHNFQ8isAcUxfDJC3LNF+W2dFjupnCCgKGPodbhnMXX/hXoFv9xIbFvxq?=
 =?us-ascii?Q?n7fDurVlnNnYfvRjv4qj88ySSLA6C3Tv2bZn+rB+o41o5KwePhK8fld3YyNf?=
 =?us-ascii?Q?H0SkeQmJbygdLXa1mxHckn4d894I1h/RSoNvJy7tjO8+6Ng8sl6/CRtu/brT?=
 =?us-ascii?Q?jkWWf9DGLSyIu4iciVAojcc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029bfd60-3a29-4899-da71-08d9d90a57e5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 16:07:49.9404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A2HTNhNN8DGmy/p95VUquGmn0mltB9MO0qAElDRQxxcCxnMm4VjIVHpbb4up0/qs+UblpZPEV+X5CQU8X3zxgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2597
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
index d98ed09f84..accb1b0f1d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3579,7 +3579,6 @@ def getBranchMapping(self):
                 if source not in self.knownBranches:
                     lostAndFoundBranches.add(source)
 
-
         for branch in lostAndFoundBranches:
             self.knownBranches[branch] = branch
 
@@ -3803,7 +3802,6 @@ def importHeadRevision(self, revision):
                 sys.stderr.write("p4 exitcode: %s\n" % info['p4ExitCode'])
                 sys.exit(1)
 
-
             change = int(info["change"])
             if change > newestRevision:
                 newestRevision = change
@@ -3831,7 +3829,6 @@ def importHeadRevision(self, revision):
             print("IO error details: {}".format(err))
             print(self.gitError.read())
 
-
     def importRevisions(self, args, branch_arg_given):
         changes = []
 
-- 
2.34.1

