Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B65BC433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 13:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbhLQNsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 08:48:54 -0500
Received: from mail-bn7nam10on2077.outbound.protection.outlook.com ([40.107.92.77]:53920
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234468AbhLQNsx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 08:48:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+ImmCIJwRRzaDYKP4/cWqcKF/ZuAcPTq3ReAb+m4SLbZaPGGnY2TWAptfsYdrCEvKYnKoKE9Iyh4rXyC6ti6opd7yWHNchtJ73Fpvpf/+JM+NHHka6V2VmaYTedPgmPfY2j4LCsGBnc3VujgBymLxUesUMS/v/EKq1A5Ip7+nLWI5+VY3bb5EDa+yVb0mBvBXd+b7iZ3FX+dSSm4/TlrO+/tUDGM1LlD4vByk5nveJ16vPw49XgAm88eL5/+iwbOyEnBla0yDpIuqmB6xSbscpMES2eUrE9uvRO452tp/z7R7fw7eXNfrE0IH0tnrEaj7G4OkyMopUmhLkEYNcObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhfTlBqCfBsghurBZnYsD8qd8As325pjB3g5uRxDikw=;
 b=IqqeyfxfqgQSbgYMysxzn6FS3vpav5WuD1YaNTOL5dQREFHtwGgkli3CUKvOowzHBt9w7r4MQZhhU0urCSVYH6GmRb4QQH3YXp9l4ctrth79pYJCMUglKNKOOHtGynf7JLg/bovD9aalak/tA2eMd1AB0p7+zxzf2PEparLEUZxHVWZfka3uVTrTMDr7D9NZ0xzaOh2hIt23VUazY4HOKwMSv4j6yKKngQxXP0krqV+uo1e6bKHlxbQlI+D46LxYsormO9FnRbPMNenMnsYcoEOE/07xQTJptz5B1NKPeDTdReAwAGg27jQkzhKiRIqWasBmF02qzQIv8SwMsRFKdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhfTlBqCfBsghurBZnYsD8qd8As325pjB3g5uRxDikw=;
 b=iZLYUAJphZGKy4G+OZco8N3OyIZJv+TvJC4eEmq/a1s1zuX7Z+QXl8bf9PtvfWdPFLDBVd2//do9FTARx5U0En80AZj0NfrEP2bc48AMZZ59S0Y3aXH99/azTHgLtfTA1UUb65ARTnGBTYt1XfzAbcgNRJB+oR4q59MZPIgzcvzI35d8hgcfgbET/Wdx0XamAV9HvJvUT7KPO6/qhgV2+gKkLAqsyr2JmjkTXcs5iveWQVhlWwVjVhYA5M4MVJBPr6N/nR64VZYOcgEdBeWAefUHwSz4BcYinfha02p98oES/XyNLvuHX+XKQc5wXvQDNNtjDKKgmisd1mZKUQDqrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR1201MB0018.namprd12.prod.outlook.com (2603:10b6:405:54::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Fri, 17 Dec
 2021 13:48:51 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 13:48:51 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH 2/2] git-p4: remove "rollback" verb
Date:   Fri, 17 Dec 2021 13:48:14 +0000
Message-Id: <20211217134814.2112631-3-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217134814.2112631-1-jholdsworth@nvidia.com>
References: <20211217134814.2112631-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0113.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::10) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02fdc290-91ac-4b46-0ed5-08d9c163f57c
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0018:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00187DD17EDEC267E1C20283C8789@BN6PR1201MB0018.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:327;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANKsNNwmw5OWZJKgykVK8yHMpEyN9TFU14ENM6pI25z7HSUyPSpQ3ZSp94okK4qwDYy4JVXN94RD8fUzI/EqQXaF3C/Ci71rJG7hsPqPUA84uMz3Qhhkxdt0hEptIjGqhd9f9g82lZaHAzIKPqxmrBkvtDPpCsFES6+HpXwunyLpTFarCTq3o4cdTGRJauwPcrJYzqEm9dOV5FQhJw9F7rKzRLD++ZO9ut2Ps5TRpSVZDCxCE8jDYzoyxvHvdGsWUhUN+/r9V0SMuUHAH6cI7ijeXTIgt1KnMpUZM51T5C7OckMQ0RdIORrL06E3LyHj4D/+ogluEL9Yd3AMPvdXPU10oDwFkOLgJdbS6hG0OzM+BANp8Ml+9AUVpb3Aw5NtZTksa5ZvO3oPgE8YQwI2Skn2S70af9ko2eJpKp3xB/OMdSbOokkw/FUD0Abmlu9QhBjAu+3xkNRpKX5Wj5cpUolv4ff8u/NpHKNTnxFYBfq/zuPhNV+Gphmakde4ByoAVDXzPd7X2/jWB+BwU7bdlj/6HxVLDoGRM3FLuthRcjGmbiOL++fNf+8xO+j4occUxZe2DXlxTbYgKkm8kZf64AzAwTYLyhfEPEyLJY8V7qhy1a0iBBGppX6yZmwC0Lv+WGrX4p9HK8h/CIJLSs/Lw6xPorNk600uOOLi8Am+hjcxOTXdEebB6p2UGbZaHnHOMvWPuvtqJo/ZwodTG+ABgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(1076003)(4326008)(6512007)(316002)(36756003)(54906003)(66556008)(26005)(5660300002)(66946007)(6666004)(2906002)(83380400001)(8936002)(508600001)(107886003)(38350700002)(38100700002)(86362001)(52116002)(186003)(6916009)(6486002)(2616005)(6506007)(55236004)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9lZJlg8dd8+Mj45OH6b/CyWO+fZuA/rFi5gFXbD8/J8AnMjXz4R46J8cVSVX?=
 =?us-ascii?Q?8pMFXlWPQJuOTWxxFYkGQX3rvtWeik9CVZDus2loNO45M1kNlqjBKDqAb+2/?=
 =?us-ascii?Q?qyplF4ccrGt8XLhupGNaZNPov1wN6qZ2yXgAyWkoA2Oy5BKT9PyU2Vxy6TSi?=
 =?us-ascii?Q?G6D+v6ZSQHz8tf/pRktfur4KlxfGJqZC/fjRWYS4E6/RAsNCLD5pEn0Apz9H?=
 =?us-ascii?Q?xWQ0Izrc/2olV0cihY9y4LWPTTRU8fOL6UXD+ucpL9Ad/y5E4qwmPe2sU/ms?=
 =?us-ascii?Q?cEYQ21nJRZIGdbB0smUBINrB4aQeEMJiD5X3DJu73lPqNSUp4hYqUQKR8fxW?=
 =?us-ascii?Q?/ZyB9MbdwVnwyX7b+bZjsrmqUZkCx6Q2jnmQsgd9+qdFZxqC84HJDS3Xyw9x?=
 =?us-ascii?Q?DTnDBllLASEXNQ1sOAKfRgP29uj/SJiq10KlGB01hVjieCnmE5a7/QvJFaYY?=
 =?us-ascii?Q?munCEVqOgujcFYQnLPk68SUlhAJ6bjEbLp23/h8fr3qg/gojsqbcwhYF9eWs?=
 =?us-ascii?Q?uuSIWkPVg7mMfS+MX76e9heVkCD65yYKZ75nKM3e4nCB2UP4yricLOypsjOc?=
 =?us-ascii?Q?MA2PIPgsaY6JVHuyvad9PBshO+667Dg0Ubr/yXc4WF++/37XpWYqDPkRjHun?=
 =?us-ascii?Q?hkMQSrXMahaYTuPDlX58rVGDoo0fE7PiXlAjCTVewRcjCwocNpEIA68MXwye?=
 =?us-ascii?Q?wvAyih4FdtfQF3fW8a2ZnrSNDfSmfl0PWI5UU6YT2MSbsJ3exL3x4FacdK19?=
 =?us-ascii?Q?ofLDDisGK1APfWEDznkcl+hk0MH//u0nHjBS5RE70D8r/iMmXfgeEv6HPi+7?=
 =?us-ascii?Q?xRDl9aDlhhvg4J70VpsFjMajkZImVUY05dR/dzy8Hq4YhVV2IXyUGVaNoyRK?=
 =?us-ascii?Q?Du7A2cRV//CSl1Vy/Bz6nJNXGtUssbDGDw3MKNIc0sfzS8wJMv7qTGYEZRrO?=
 =?us-ascii?Q?+ipPBqCHE/1bbGku+43CxM+l43xH+anJxTmhPBBrBwGYe+iWsPg7qVKaV3NX?=
 =?us-ascii?Q?VrpOW+dKpEcvzcnAVrIWjWY9J2DPQ0N20PzG5/k/f3FIw9v7ewKh8udCb0Ns?=
 =?us-ascii?Q?Loj94XSDYqDgtNLWmAptEGBTua9PKnl9/UKsn6A41MHyScy4O189ioa2qasY?=
 =?us-ascii?Q?KltRDhrmbKAj3Yq/ehhxRianl1frHMxniCM7KXF6rNDxXywRwHoaTEFRyTXg?=
 =?us-ascii?Q?ZXbTRtibBgYNSZOYQeQyud9S/pjcHCTCCz6ejfGgw5hMBlbCDZIsIPTh9xs6?=
 =?us-ascii?Q?S074P137WDCCwk8pjSBL2sjsQT2dQ0Fn/bMkhusaGl6DYp49FF4tsmvvmY18?=
 =?us-ascii?Q?WLp4L7Z4vi5PAJ7czHqbKh/KTbIv5qII6d5qi9i5naDLkOUZQQMvzSzMYW87?=
 =?us-ascii?Q?dNhU2ewzoUUwnGiqIavvZ5Ju1rJC0qxGCxzXZUngiZLrMpXO0pnwetjYYOlF?=
 =?us-ascii?Q?bRqM5Jz5MHep/5wE/iH6gCaIssDvKuGQJNxJz5eBSes2JRM3rn45qYQzQbGV?=
 =?us-ascii?Q?mPOoCoxwa18KC2s6Hb4bIPLIv1fmRkR/vayOySLuUUiYc+sR1bhVOVdN27pv?=
 =?us-ascii?Q?6nWm/0oZwwyMURFxgaDoeC+oDBeG3hNEE2TL9y+P8d3juXPz8GyeaJbdXBFe?=
 =?us-ascii?Q?jLYyX1mzoIxLkSFBhOTF0d0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fdc290-91ac-4b46-0ed5-08d9c163f57c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 13:48:51.5166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +p9zJCQIuFGqZPknSaURdFJuSclbVeawtzMC8WyDOE7R6zWptjhCHj6bYsklduKHaShBU1KWKb1eZDwBixac4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0018
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-p4 "rollback" verb is described as "A tool to debug the
multi-branch import. Don't use :)". The implementation provided is of no
useful benefit to either users or developers.
---
 git-p4.py | 60 -------------------------------------------------------
 1 file changed, 60 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index b7ed8e41ff..a7cb321f75 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1532,65 +1532,6 @@ def loadUserMapFromCache(self):
         except IOError:
             self.getUserMapFromPerforceServer()
 
-class P4RollBack(Command):
-    def __init__(self):
-        Command.__init__(self)
-        self.options = [
-            optparse.make_option("--local", dest="rollbackLocalBranches", action="store_true")
-        ]
-        self.description = "A tool to debug the multi-branch import. Don't use :)"
-        self.rollbackLocalBranches = False
-
-    def run(self, args):
-        if len(args) != 1:
-            return False
-        maxChange = int(args[0])
-
-        if "p4ExitCode" in p4Cmd("changes -m 1"):
-            die("Problems executing p4");
-
-        if self.rollbackLocalBranches:
-            refPrefix = "refs/heads/"
-            lines = read_pipe_lines("git rev-parse --symbolic --branches")
-        else:
-            refPrefix = "refs/remotes/"
-            lines = read_pipe_lines("git rev-parse --symbolic --remotes")
-
-        for line in lines:
-            if self.rollbackLocalBranches or (line.startswith("p4/") and line != "p4/HEAD\n"):
-                line = line.strip()
-                ref = refPrefix + line
-                log = extractLogMessageFromGitCommit(ref)
-                settings = extractSettingsGitLog(log)
-
-                depotPaths = settings['depot-paths']
-                change = settings['change']
-
-                changed = False
-
-                if len(p4Cmd("changes -m 1 "  + ' '.join (['%s...@%s' % (p, maxChange)
-                                                           for p in depotPaths]))) == 0:
-                    print("Branch %s did not exist at change %s, deleting." % (ref, maxChange))
-                    system("git update-ref -d %s `git rev-parse %s`" % (ref, ref))
-                    continue
-
-                while change and int(change) > maxChange:
-                    changed = True
-                    if self.verbose:
-                        print("%s is at %s ; rewinding towards %s" % (ref, change, maxChange))
-                    system("git update-ref %s \"%s^\"" % (ref, ref))
-                    log = extractLogMessageFromGitCommit(ref)
-                    settings =  extractSettingsGitLog(log)
-
-
-                    depotPaths = settings['depot-paths']
-                    change = settings['change']
-
-                if changed:
-                    print("%s rewound to %s" % (ref, change))
-
-        return True
-
 class P4Submit(Command, P4UserMap):
 
     conflict_behavior_choices = ("ask", "skip", "quit")
@@ -4353,7 +4294,6 @@ def printUsage(commands):
     "sync" : P4Sync,
     "rebase" : P4Rebase,
     "clone" : P4Clone,
-    "rollback" : P4RollBack,
     "branches" : P4Branches,
     "unshelve" : P4Unshelve,
 }
-- 
2.34.1

