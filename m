Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271C0C433FE
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 16:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiAPQIJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:08:09 -0500
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com ([40.107.223.54]:56160
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235565AbiAPQIC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 11:08:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVbNfYZaZPkoGCGKS8gT2odjFULpk20jAGhu+LUn9ahQnpgDcfJZz7HDh3t+ReodVbDzFQqMTr4xvj667Y0xBpoOsdi7RW66XdvMT1s0V03Lotw6k/zy9HnLRtNbdg518y05woKdP/7VVFKThioLlLBUHqAAvQYS19xm3pwWPFvmfLG3XCLygFFysfpBW4HG9yg9cUN95WIEytDla1xftdEFSWnUggd8q37XNv9ClRymj+ILG7PJO3waQ6hUg8WAeLq/V55dpsUt1tLY02qLPFJuCtM6wLv40t5FXxormyfC8MzBSiIwV26BpojFZwdNTSIpo1VygMIUNCoZZj0rLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkNkVLJ4IbKCZGxIfVs7s13NCtdKDk4VpHbUZD/lG+8=;
 b=aAG+6nRgcnfbPWo+v/Xlg3CiT8nazq6CiNY8MoCTjoBX8OB7ojefhV9KquFjZsqYpQ4Q6fJV9OXOEwc+mfnBF/ezEzzYFOT5QyX/djtByiDJLNT4VTthMWBzJ4in/UIp0w7hypA5H2sBnAAC/qfrnRsqP84TPWWy4e4cvKJc336DRoByNF/QHXPX86mXmCNbC4UHC+dN8/3pS8yyNcUkzOiZiYRr1hYK7HU0tuoe4wSTtvHFd+mM9HrjecIOBDXRi76ngDLZ73rnVJUvM6F9B7FV3/MBbPu8zkraqeCKZJD5jUZszywPXl1sNvZ65/TxzIjcFL33ofug2KBGoF+h5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkNkVLJ4IbKCZGxIfVs7s13NCtdKDk4VpHbUZD/lG+8=;
 b=d5sHq7GAShpkqa2Gms/NxP5ESalvM8xp0GJZM88d3kH8rhF+GE7q3bFCe+hOAJcBi188mLI3243Q1ja9qxUgjMAX9WQ1i2IdxItjSFMAnt5d0vZW1Nh5WxhQhUoi58jHC0NToF4ZHa8quDo8VwyC4mqdtid14oulnlFghHb4wBAfzD0LbMBSylKLkrUY1UV6xDzTF32TgDp8LxtrioJ3FiVTUJo0V+wJpmvdlpFqoPIREarFfhjQjVdiXmjV2K0uQBixIC7G7uju+MN/Gij+YVWzaZ3DSHk5Ud+MK6l/eeV9mduAPF0sMgSVfpg2vhMhh9lU0+Z+GZlK5T8434vl/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BYAPR12MB2597.namprd12.prod.outlook.com (2603:10b6:a03:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sun, 16 Jan
 2022 16:07:46 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 16:07:46 +0000
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
Subject: [PATCH v3 17/21] git-p4: normalize indentation of lines in conditionals
Date:   Sun, 16 Jan 2022 16:05:46 +0000
Message-Id: <20220116160550.514637-18-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 77f70b87-b0b9-4dfe-69cf-08d9d90a55bc
X-MS-TrafficTypeDiagnostic: BYAPR12MB2597:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB25978116987052DC8B4B7719C8569@BYAPR12MB2597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lnSvnXxpKOjeIdkfqGA6OUeL2Uc+GJWwwBvmo5rLMszH8PmHjgeHV5DYFTc0DGcV+LaJYuQbUpDOpWLyboYa3wjsrw0G4AzBvXqQnr1AfQ0jLU+5Dpdmb0yKsYBSDaTHI4KmY4euFFyCRbBrHyhZYUHQtxaFJInGypggcLA/MdRIB1xEbS1EYcRGFOQlQRGssoqg9N53MpMX/GNNHM5XJj52RQ8xhPu0pRIqVnLBisXRxpEo+wmuGXDda63htprlOgFnxaBJnXWzT8uLeOt/Nv957PDDjtnWK5JlrEbLT48ezgbhF+NMfCS7XogYqg9hku7tQtvkfTpx62FycoAmjUKwfEHfyFvj2/EqqI84b05E9p85VYFQk4OOtwZoOPRv1BN50tpTqaeV7TKdK1Db+4IjOA+ck81SG+Yw/s6Uj9ixRTAP3zSzkqO0ueKpu3SDwYIHtm1WIxKYeVXfmplKeIZVCgRkBRmFSHi7xxqWiUIhX495+qk+GM6kmYVTblD39IPNM/2ka2h9mJ+ewiG0aGEgBv3Rtnu28iuvo/oZvPfAKZoIEkx1oJlItjzxLUmf/BvAHZ78eJmCISVXswyfdyFWjvxQsAvpvUFdMoPTD5+eT3Zd+qMTSsYAy9LU2wxByWMBscBn2Iiyuww5pXWAtsqKrGbDCnZCeRgIer6S0LbJ4G3n2oICHMbcTvfYta4rQE2TtUF5Ljc/agTARPSokhIIOT5tS7a8o0JrZ1Byq0Zx4Vpgx8SoD1OVXPtrmXo25VbvHkMZz9QtK+FhBiyPaxh0Cdh/9lns9zUvjTDIk2k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(38350700002)(38100700002)(8936002)(4326008)(83380400001)(186003)(1076003)(6512007)(110136005)(54906003)(107886003)(8676002)(5660300002)(316002)(66556008)(66476007)(55236004)(6506007)(52116002)(86362001)(36756003)(508600001)(66946007)(2906002)(26005)(7416002)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Kt9a0OolsbFWaTUC7F7aq6TuldOdEBzL/kp0+DHX6UmZubX1OrYrFsVL+x3?=
 =?us-ascii?Q?Tc5f+Zk6JsbkkvQEiC6orQkETsHAVMMusC+T4fbRIsT90nCxuIhisnXyQDat?=
 =?us-ascii?Q?7CsLG1o3YWsXWgVsv8cn4y4hL/pBxsGXrMPcALNnOOipWxClDI2cZJxgUDzb?=
 =?us-ascii?Q?y3GYf8r/j3vsle7cpB+p7CrO7GCanvX0eLJb7KyqdJPi3mkpAtV2uvJb55t9?=
 =?us-ascii?Q?CcZtOy1d44GX+MCR3i1atP2fi/4gWAtEsiqeymrBa+qAgOLV7aOwz4YSXpx5?=
 =?us-ascii?Q?NoakMPu61exAz76Tl9XvI4vvC119WVgiRZZsMveTTsXYJ9p8js9k7+gg5whD?=
 =?us-ascii?Q?/V2MbLjdzc3P53p8WNDcgqZqUSgKrroGPk8AOTt84dH1EzLYnj2s+Q2+cl2N?=
 =?us-ascii?Q?FxyPN/6kBc2lQ1lPEf5auZ5WIGVnhciX0Xqq7qBkdOicSlcgIzWrQiG/3vQE?=
 =?us-ascii?Q?mM1w90YIZvQ/S5HCsgwFSsqevQOFNqGOselOEJI3p+YVPrqgPK+juWqThEWF?=
 =?us-ascii?Q?x3806o5wx06tK4tJoZwWXr8Hs9ZipYnkAKCKKEqCme69qMjkbJ9OW1X4MxcY?=
 =?us-ascii?Q?7gEWrOHyR/aQHvIlquQLjToLewCbU5vB7S4wA8ZYg4IJgydPUsn6bolGRW3r?=
 =?us-ascii?Q?Uvo+rMnBw0i8a4wtqhaSkFy7/P3Mg5BgwOL6UzN2p3pZUZ0x0j3s6mQ5XZZs?=
 =?us-ascii?Q?BDEHWoTh1W/FvaJSh2NZW3clLhIk9A3e+J6J2c0ggySUuCmTQB4O5q/sxUpc?=
 =?us-ascii?Q?bIR/Kgkd1gAqpgc9zDuK0nSi/x/iBkJwntCV97rM4a/FYuCTKpq2YPgOWMLS?=
 =?us-ascii?Q?/V7r6s/CIYoRG5HMxUbitedRrtLWMCYStHzo7vQI0gqrsuwbYmA236EehER5?=
 =?us-ascii?Q?VIkNcZ/CNMc+9W3VqQJvo93JCPvos+lyiA34BF0qo+tGiUIBA2Crkb0o5oIY?=
 =?us-ascii?Q?R0TTcCL7nzhK+3oPPFrjOBLEjc0fR/wdzYhlJogTYSp1vbCnwX9eoHkNlsqN?=
 =?us-ascii?Q?Ra7zZe2XRM/x/+rs2ljHvaYnnCUAFd/Fpvf+lKD+drJ2MHD+bLXTEFBvsxma?=
 =?us-ascii?Q?+Jg9deHlSrSI0Wx0bkOUCe5zGtBOzSWxb3cpqzl8FJxZFbxycwu5sNJCukm3?=
 =?us-ascii?Q?uVOBw9XyZ4ZiqiGr7+1iFORfY1pZeLqhGQCtZ860zBm+lwV8ltH9hvcixivu?=
 =?us-ascii?Q?2mV7t9hsN1ZMFXxUqRfVZJIQJGH5fBF/y+isUTpFOxh/NEXBhhdjuCf/Ac22?=
 =?us-ascii?Q?CffV6zPblgQBFdCwWP94HzOo4MmfGBDFS4yWy/6PcPHrQhj+sT/vc/Hcr5b5?=
 =?us-ascii?Q?XtYkLWQ4wppL+qp5Inoc4KJG2qT1g81VnyUdrqHrfXbR6lfVfvSXoKD4yUiz?=
 =?us-ascii?Q?r6aLEf9+CMXZlaDdCzzI2e7G6CaNo7ytDBhIgBfg0APssgAm4nv7jEux9V6I?=
 =?us-ascii?Q?xNRrcQak6lA8P2JqcYz7/x+3E5ouL01iPCSVxpY4Xh6sS777QP+oxaGXLrll?=
 =?us-ascii?Q?ydlkq0ncxFLcwMePmmsndTJHGUMPcmdysi2fZn54OBEe40BeSkXa3Du4x615?=
 =?us-ascii?Q?R65uu/2s9UeMbL+wqzjZC1iEF6a9DdgH0ZA/ha6KhR227uBxNMnQxAfHeRmg?=
 =?us-ascii?Q?zNLrmBlSuCpBLDNQ1yJ01EA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f70b87-b0b9-4dfe-69cf-08d9d90a55bc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 16:07:46.2665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPB1W+cuhwop54xbnNvVe7Ub5oXkxLwYMCeuLUkKcnlGPNea0sEKcrVMA/oZih8afbrRXTRxRoQpw/dVxe2+0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2597
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that when wrapping the arguments of conditional
statements, an extra level of indentation should be added to distinguish
arguments from the body of the statement.

This guideline is described here:
https://www.python.org/dev/peps/pep-0008/#indentation

This patch either adds the indentation, or removes unnecessary wrapping.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index b5cda50af0..d71bb7acff 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1143,8 +1143,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix="refs/remotes/p4/", silent=T
         originHead = line
 
         original = extractSettingsGitLog(extractLogMessageFromGitCommit(originHead))
-        if ('depot-paths' not in original
-            or 'change' not in original):
+        if 'depot-paths' not in original or 'change' not in original:
             continue
 
         update = False
@@ -2156,8 +2155,8 @@ def applyCommit(self, id):
                     if regexp:
                         # this file is a possibility...look for RCS keywords.
                         for line in read_pipe_lines(
-                            ["git", "diff", "%s^..%s" % (id, id), file],
-                            raw=True):
+                                ["git", "diff", "%s^..%s" % (id, id), file],
+                                raw=True):
                             if regexp.search(line):
                                 if verbose:
                                     print("got keyword match on %s in %s in %s" % (regex.pattern, line, file))
@@ -3170,9 +3169,9 @@ def streamP4FilesCb(self, marshalled):
                 self.stream_file[k] = marshalled[k]
 
         if (verbose and
-            'streamContentSize' in self.stream_file and
-            'fileSize' in self.stream_file and
-            'depotFile' in self.stream_file):
+                'streamContentSize' in self.stream_file and
+                'fileSize' in self.stream_file and
+                'depotFile' in self.stream_file):
             size = int(self.stream_file["fileSize"])
             if size > 0:
                 progress = 100*self.stream_file['streamContentSize']/size
@@ -3988,8 +3987,7 @@ def run(self, args):
                 settings = extractSettingsGitLog(logMsg)
 
                 self.readOptions(settings)
-                if ('depot-paths' in settings
-                    and 'change' in settings):
+                if 'depot-paths' in settings and 'change' in settings:
                     change = int(settings['change']) + 1
                     p4Change = max(p4Change, change)
 
-- 
2.34.1

