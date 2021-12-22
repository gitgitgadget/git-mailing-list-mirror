Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BC1C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 14:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343603AbhLVO4P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 09:56:15 -0500
Received: from mail-co1nam11on2049.outbound.protection.outlook.com ([40.107.220.49]:15201
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237161AbhLVO4O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 09:56:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NX6UX/tLMt7Wb88pRdT+bHs0e6FKFM5lDKoZZxb3KmBe5NfQd2A3Kw2dVv+f8M9dWrSwVx1NwiFp5JunDIRpYC2mPaS/8/v2vSxA9+d4eZKHHg+ZuKX9Ob/bPTPgeRQU6craCftRmncW1KXnuZMtzODI7DjkVhLIdMgRINnIpFCKdDNoVwuzbQ56Xk/K1gHF1w0Lix1xnHtKIMZqkuD+8Wod9rozyvERUbTaJNcrU9344Pqb6JlAoxw2qvmWjzxSZYLB1xL+kYf/QUZDoe6iDCTI2ETiNbBqe+CymbPb90QbIE4IQ8apmrp3Op4WN8Ph9RIgGyG1NRDDCGEPsYrmBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gU3MF7gGQYtV4aF8/ecE33bN7jRFtySedVwflNQ9jU=;
 b=bqtn2ISVTsCZPVyaL9tMKI4KNKjjgsxUU4E5RxIcTr5Dt6+SeyXGmKitM3VhbFi10JI9jF7eLULw919Ek3dE8OgVvPvRVoXtLV2sJJIbBp0pGXVPBZEc4MagCRzN1RFMTL1l1fpNaz5XH1tX/H3UtpITM0XWqV2Xt6l5EttvCexL7+ETex9CFBB+5pFk96i7H2RhLeEeAH5Zzp2AxVJoscWB/FMBVX5D+/aAEr2b/zveefY2PjqAZgXOyEG4jPuKa6f6150J6qIk5Jb7jakpAI0k/ilWodht08vWyDwcvBOA7+MZ55/+0+RgwJSuUEzlh1ysZPh1hr8L2Q1MYlEltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gU3MF7gGQYtV4aF8/ecE33bN7jRFtySedVwflNQ9jU=;
 b=TZqIH2oP0F8SOszuz9DRtzBcc14+47AqfOSRjc2LE/ahiz+UFuMuV86HX2YWGICDZil3zCoHjBocjjjH0DUnOvRk68VJB7fLhy9pAH4NwBvPKJqmUy7PiAmP3HMeWyuiAfY1xAFcPakcuH88Xto1KJAPzXygwgkXewaKFAhJsT+a4YZtyCYtAIyt1TEjeMum7lVavM7zm4qIWx9VuHUtuDAWkhwQ4hyktJzWFn8HPUIAc567tCXT986a1wiBi2Dx1gbaPsTZoLaTmX1YVMCRwwIgv/CX0pHRw6HT0P5pFDXhveDnrlx1NokvAx2n/OWP72tlaKMreehM3KdD8DBPsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM5PR1201MB0105.namprd12.prod.outlook.com (2603:10b6:4:54::23)
 by DM5PR12MB2487.namprd12.prod.outlook.com (2603:10b6:4:af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Wed, 22 Dec
 2021 14:56:13 +0000
Received: from DM5PR1201MB0105.namprd12.prod.outlook.com
 ([fe80::d57d:8569:57b9:874e]) by DM5PR1201MB0105.namprd12.prod.outlook.com
 ([fe80::d57d:8569:57b9:874e%7]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 14:56:13 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v3 1/2] git-p4: remove "debug" verb
Date:   Wed, 22 Dec 2021 14:55:51 +0000
Message-Id: <20211222145552.93786-2-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211222145552.93786-1-jholdsworth@nvidia.com>
References: <20211222145552.93786-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0001.eurprd06.prod.outlook.com
 (2603:10a6:20b:462::31) To DM5PR1201MB0105.namprd12.prod.outlook.com
 (2603:10b6:4:54::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b83bb88-d4e0-49b7-0193-08d9c55b326c
X-MS-TrafficTypeDiagnostic: DM5PR12MB2487:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2487BB723BA1A6C58253B783C87D9@DM5PR12MB2487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KXg7PY+vyBeEhYTJqhpQ98RWMehCHMBmPjkZOnzH24Y3L9rGNUF4XobKiJKyKlTOJ28Q6nA1Qs5yt9koQzQuLlIwGZlQ6qi2Pk8NBKMqfkLdQiXUQWu0A5dKAmqBXxaPLjbcS4HTGhuo6CrRkmzEFVbwl1CDdB5RAQNjwFKXCAqY36en+QtjfFCebAc6HrpyHq6cg4b4N2YeapJT0CUorU7uAlHn+f0Kcg1isKpHXy5BYNzdEiBrUUBObbB1vBkUXuvOYnEPCd/JUwToOeUU5MbcEhM04YplbQabNn6BwiWokHzxTQhXM9hXC7UVghWImHfIjWVQSt5aj5mnqqvPIEPOKWMehgbcksDdOT0YYrs62hXCvrs7Yf0uaka1vK02hWNtJKHWLKzZnbIlzu/eWbruZdaa8T0+AvKLecGYS9AkUvIQc7RpRCz68c8h/0LN6TnG6TNW5Liw9IPJ0K6XaGIlTeuKg5SHrN3JHt3OAPBNQ+KLTPKzOEFggHr6DTBFuB3gVC7L9MWs0EKSgWcLdHYvEu7Dmn0SBTfQHzj6+MnAyN00l1xCcGzAVd5W7Tpn3A0Vxy/bpDXqm+0wiPV9vjMkGuZ2EE/GdHNok7+ToIuaypI98mS6bfsAuzcL9lVDYPOKEY1INEnJ2o2Q1O1FAR/fFHRIT8PF2S7rffSB36+axLFKFovzH9aAoDfvXnzbXx3rxv+nQRKX3whYaIsA1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0105.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(1076003)(4326008)(8936002)(6486002)(107886003)(6512007)(36756003)(38350700002)(508600001)(38100700002)(8676002)(66946007)(66556008)(66476007)(55236004)(2616005)(5660300002)(54906003)(2906002)(6916009)(26005)(186003)(86362001)(6666004)(6506007)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oaYpNoNLsERMr+ZLdlZRGCnV7W+nFFMHK3+D7tRzdPpDdWFIunrL0rez10O5?=
 =?us-ascii?Q?6JlU2Im0u+2LA+nlfWuZbe6uNowF/p14IdlGvBA4MX9ehHFi92fpeFr7b1X8?=
 =?us-ascii?Q?WjwHgePPoU7VPLBFXhWNNZNvzpOy0Sh8LgpKhQdLuWg8RS/Gt6PWmIPZSfo2?=
 =?us-ascii?Q?Wrp5t3xyeJQ0NOidtPAWGFTLIrUuQki+Opu4tNtkkv8RDduYbXmrkDbmW+Hw?=
 =?us-ascii?Q?KjPzLGoANU/qgazN1xhO7MpKV7n7lZGzF3bAcwRe1hSiMRtkyM/6MoBvlF4Q?=
 =?us-ascii?Q?WQEF+LbGnOBHaVG4xQIiucfLqfNa3LOWvW4ug7x7+gW9KZ8ANZFnXZqHRj1S?=
 =?us-ascii?Q?/Tcwh+DYmxXpr1fdB/u0d39VT7+YMZDVjDJwXKsmsjOc8+aqlycGAx7QcxOC?=
 =?us-ascii?Q?8ZA0qCeW0t1HOuWmTcv6j8EgMv1+4ekopFnlI8WuI2QFmQCg7Imiy7fbo9mA?=
 =?us-ascii?Q?3o9BENgRdkKNQjru2j32y1JL4/YdHE+k0PVBPVWTc2mSi+su11s4hRONbbry?=
 =?us-ascii?Q?a+V8YUpr7JyxRpi7R2p4VUTK9nyLqo7mILOl/+T9tfx/LMgS9W10NsyZYCmb?=
 =?us-ascii?Q?w2a+u/WnPfN7el0PELPVdAAa1e3kPu5dBA3nq3bwphSDbHI3vbu/LnKtV/Uf?=
 =?us-ascii?Q?m9qjqAbItdi3X8E5AI/Bxa37uuzMa6TcNdl4vCP8YvNYepAnCSlKFjQC4W0B?=
 =?us-ascii?Q?/ZVVhICKOskeoWEMBKaSFSwYYcfDO5gkZsL8B43x/Bm3AVVl/kh1g1yZGm7c?=
 =?us-ascii?Q?jILz47vxaRWlqVeRBsAQE8DKs5zcz4n7uQAoqXbSedLLlK2O2bld9MmDEeyZ?=
 =?us-ascii?Q?+rZJq4RiK8/h9PxNI1dJqottiSN3+8edRaNPEa2cY8ZTqQU9TxsGiEbLKSXC?=
 =?us-ascii?Q?bfGDiX62nADyuaSgveqKHZwSKG2fHdIR90BpOTlA93LR0vOWDlUKYkIQd10O?=
 =?us-ascii?Q?Ibrt3jQ0uRKI8Y6UUqzx/+89P1tCyldVNrLzyi/fa1NGNpCnt2XmxtXaLaov?=
 =?us-ascii?Q?0xnjCnZOZLc3qPcOU2BlibJ364KneCR0WgtLa8+ITsAGcOrFaVBkpflfHC9S?=
 =?us-ascii?Q?934nUudr2pGvdyPClVGOosT0B6K2uWNVZj3pxB3pQtgwYtfe0YbCadX4w54B?=
 =?us-ascii?Q?TqlRRN0V8nBax/Nd2NxMIqTU5PRYRG2/Ckh8zdo/H0SQE1ZpFEIoX3VhOAdw?=
 =?us-ascii?Q?VGl//H1KBgIsgkbdNYjuwwKvYBCS4NmDSS3Q0ZYfOa1mfoN9/FDEWRrN1Plf?=
 =?us-ascii?Q?ktYLnttfT1w36OJjG44oVQoiD3tgjtCCqz07veJUG9v3KLmuGgJMyaQ95phT?=
 =?us-ascii?Q?w7qTS5hwHCkt20pksfi/AA6RGf8a/XLHEOfSZFRHlAVpa27PEzKUOaSyeXZ/?=
 =?us-ascii?Q?8px+fMO2yDFUoJtYA5OSde0OQem9Ny8rxeuF0Lyj+UOh4cEt8YX6avFE+R9A?=
 =?us-ascii?Q?Ae2e7aOucWENwxkcdZxRAPvOvPlyLY/fGylRN9PCMP3IY8P6P8cYWt4L/Eaq?=
 =?us-ascii?Q?KUb/XzGqTcBoPZLwzgySxy4xowBAH8KSh/ja8emmi1FQJuJbtwB0tqKUgru9?=
 =?us-ascii?Q?zA+jWDrEVmMfewqG+xkgY6u4BziiY98l9To/Yzbt01vU0Z0uCaF+WC9iy9/c?=
 =?us-ascii?Q?1/8jbo0IByVYppOroKrQQy8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b83bb88-d4e0-49b7-0193-08d9c55b326c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0105.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 14:56:12.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQrooliGLOKqWMbt0d1J921NoyL6Aw3Cl+NUcR9zWzIndx+MRKEFiFjfJvrLXAwxqJGc/XBgegLEB8ahoCPpKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2487
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-p4 "debug" verb is described as "A tool to debug the output of
p4 -G".

The verb is not documented in any detail, but implements a function
which executes an arbitrary p4 command with the -G flag, which causes
perforce to format all output as marshalled Python dictionary objects.

The verb was implemented early in the history of git-p4, and may once
have served a useful purpose to the authors in the early stages of
development. However, the "debug" verb is no longer being used by the
current developers (and users) of git-p4, and whatever purpose the verb
previously offered is easily replaced by invoking p4 directly.

This patch therefore removes the verb from git-p4.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 2b4500226a..b7ed8e41ff 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1532,21 +1532,6 @@ def loadUserMapFromCache(self):
         except IOError:
             self.getUserMapFromPerforceServer()
 
-class P4Debug(Command):
-    def __init__(self):
-        Command.__init__(self)
-        self.options = []
-        self.description = "A tool to debug the output of p4 -G."
-        self.needsGit = False
-
-    def run(self, args):
-        j = 0
-        for output in p4CmdList(args):
-            print('Element: %d' % j)
-            j += 1
-            print(output)
-        return True
-
 class P4RollBack(Command):
     def __init__(self):
         Command.__init__(self)
@@ -4363,7 +4348,6 @@ def printUsage(commands):
     print("")
 
 commands = {
-    "debug" : P4Debug,
     "submit" : P4Submit,
     "commit" : P4Submit,
     "sync" : P4Sync,
-- 
2.34.1

