Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EE1C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 14:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbhLQOGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 09:06:25 -0500
Received: from mail-dm6nam11on2049.outbound.protection.outlook.com ([40.107.223.49]:17684
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236939AbhLQOGY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 09:06:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwZPcwwAl42+ejglmRMr9vHr7p3A2KUZe8hciZdbA0yl6r0O/WQtt9KXmpLfPY5OkMMWBnAbJPgBepjggrXY+NoVhrhQn491elECkLuY35tEedSgvBhZwcn/+fj/fQD7Bvb1r6qQl7CP1SrxKSkZ3ERx0LOAhqQ3evLCRUI76XQojHOhyPKR8jFsrI0u3sEalXMBjj3dbuLFY0wBC+pQo3UxhRWzaaf9hGFSDgra3QjjEWdVrb9Clrq5KegJu48/M7gl/Y7G3P9itoawIEUJFsStT/aR+XruUK48SiFdEvOLzsY3bN1l+eO8jRPO7ZaEei0ZAcsTnTAnFAVJdhoreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INsjuEwnC6chDp3jW8Bb6FzbEuHSEcAEircv59sig+k=;
 b=RS4t4+Jc3c643em+P6ys7E6il9XdtBSZuPLbtOWF3LbKzKokuqhxPuUONA5oVAKsH0szMJGOclPyEGkpqQUXqmARXGFiPd4qBuErDyNiE1R3Ezu7O7WDaqmb5yR59jcXkK8AaHw8yQ5IqtLN5NeE5kctNKBagOfinBWroUx9y24Gkz/Gc9NVug+YmhtmY2KVeiPiJdA5QGCwuZ+FKlQn7rIJGLKesFtc4+MSoVveCqzqZsqY1A5BDtJluUw9bRid8v7Nyr7V8fp9LUy0/haafDBt6fwtrplyOdMKZ0Ezg53Ahm+silx1ju4P1qvbtDkLi5wonpEe6BZQAVl8I6B68A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INsjuEwnC6chDp3jW8Bb6FzbEuHSEcAEircv59sig+k=;
 b=Ajgil/LFKfeiXI26BCww+CQVcRim7sJTLjrZnOjZAlFVsEm4TqpDBtuG2lZZO7PKQNhqB/n1GHEg9YE+DgtlKmryyEMKvqn0TT/hnm23ynPqnJOfipn525mJebPUyK3ljS3ijffi51C5ifJrkIXmR2ukHfAIm8jRvBM7zOtN2wvpbeVl9DIYE7n2s2iC0a3hy/A1QE1xccfh/Yp/ZQEQwZ9VlhtJ36Evon7VofyVnde9lQicZ6vbsULl/xx2EgCILXG+xS2fGfqTVidkQaNVyN/zcmPcCH/iEnTp29TUaQdzyJaMOTRSOZVxQ3FRdszVSnXE7T4oJ/i9reCtF2tDtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR12MB1250.namprd12.prod.outlook.com (2603:10b6:404:17::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 14:06:21 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 14:06:21 +0000
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
Subject: [PATCH v2 2/2] git-p4: remove "rollback" verb
Date:   Fri, 17 Dec 2021 14:05:47 +0000
Message-Id: <20211217140547.2115095-3-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217140547.2115095-1-jholdsworth@nvidia.com>
References: <20211217140547.2115095-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0128.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::45) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06744757-1bcf-42f0-b2aa-08d9c1666763
X-MS-TrafficTypeDiagnostic: BN6PR12MB1250:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1250BE7B54F89042C67CBCCDC8789@BN6PR12MB1250.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:439;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DGB9wmJDPWA3yzVALCOFO1LKYk0wIgR/4oFWkOYFgaM82+DreArTJq2nxIjX0kpIage9puOUzoyLnIf5Furzn6G4NWNP0UJONX4uK2kmmyRVQFhwwA6psehsSE+ByMRHaohVZlphRWaYqcyyG+lasdQ/W3w26vXLVcYEXby7hZB4qLW+iBMJ4z8We6OEUNYBpku2k4GlmxMbRwm3yEZ7KRDXsiDu3694Tk/0h1q/6Qrne5700cQZdB1BVdN4LhRtEL0w7ANFDRGwiXvJF4xQX+hNz7EQrbKaWQnZFLDIDmLMbIHoD1ETn93nYeCMYhmw2K4RI+17uu27wXXCZ0baJUk5f3ojrdvSKcYnC4ioAT1P8Xu8Nh81sBFNTLDnoaknIjsTL7NipScmItuCpgtSRixWfj+pfLcqWUmI0Xmx27hvaJsT3eUT/C7AicTTVV2YNd7iYcx8J8mUrWgDe+Tp+sV2bVdMdb4BcvGIttjZ4XFAON4ILoCbqSVOTJOsosK/Tx6OG7n3vOCPFUS126XztvUgsmbGhsCfqR1jMLbFEAQ1QXqO90k+1d05ltFG4xCPrCa93JKbxTXpalygNxonGz3sqV2w9RprwwWW+GzoJdlTrIUI++pJhd20IktFz2ohMLYVY2qj9m1XOgpEPuI5nrQPOEMGfbheqM4y+K0yVnKqbknfyJh/GDHGBKW0iSFQ/fT0UI89q5KFbq07tRBULw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(38100700002)(8676002)(83380400001)(66946007)(6916009)(66476007)(36756003)(1076003)(6666004)(186003)(2906002)(8936002)(66556008)(107886003)(5660300002)(2616005)(6486002)(55236004)(6506007)(26005)(52116002)(4326008)(6512007)(86362001)(316002)(54906003)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eDhHUPsFZJdoBJG7iL6uvkakxILa1k8AUv1SMUi+y+0gn4t2D79Y1apUgIE3?=
 =?us-ascii?Q?obQr1CUGVy739TJuC4F5pYcRWIc+6oq3QXLYmEt/K+N80v41QWeW4ZaGPCvq?=
 =?us-ascii?Q?g5DaomqUhaJ5TqBH81SzY7VFLA6Ztj5FaSa0uSLjmIab8fA+GtcjiC+oH4pt?=
 =?us-ascii?Q?UYqom42T1KvWXIuiuNCHSjotbTxxTtWtz5bZyzbr/0S/CY8xlSxmtweeRICV?=
 =?us-ascii?Q?ereIcqkcxR1N0Sqb66QJZJOa4nniSHqaMD8r2YzEPByCNYptthvX1zBt2+Ym?=
 =?us-ascii?Q?0X2wW1ZuauyHvF2jyaZ+r/SKwytWon/NcOagBVutdvv70rqsowCYJJ3+tQoa?=
 =?us-ascii?Q?tb4MetzrwVoRlFZvQsoewFsg5eBe1kjJ9KEUUARemreV9IhRdb4tqxzGqNhx?=
 =?us-ascii?Q?k0gmC+eAZaQL4txBmOxVv8/SjrAc6/WLXo0BbwgG8XE3Sh2ZS1wbuSNg3D1O?=
 =?us-ascii?Q?r/qCO59KznAdVSsWvlR7m3Wfr5Qo5taC4NzxX2+Lik21OlrJXURLB9NMKRoq?=
 =?us-ascii?Q?ObI5QkGQrxxLOdV0MJpj1tyxa+cGG3dgbX6Ynz0aGBX0SnRmZ9RLj4oB3tIU?=
 =?us-ascii?Q?WYmw8IKrBh2vXqE4uTLxrUeZRgK2PA4wGTZRWjAxYxdaAK8TubbFcllR88Fd?=
 =?us-ascii?Q?sv6BhLystOsBx78vbQg/vF7Cqk4FIhX6ss3JPHnsdGXly4RGC4IOM5Jmveop?=
 =?us-ascii?Q?9BWhgqIkvNJphkhsDYWIefHDnUOBpB+xzEEu5V1E0QQrMXJoUJumCeZQItsv?=
 =?us-ascii?Q?bNaLBClIAAFr7eAcIkftBVpCkOdBDXIutAzA3Mi+RXSWwIrVIkYOgYrOoK9Z?=
 =?us-ascii?Q?wd/lPceByxpXW0wb3x6iBK9MoCFAZkE7y7n4FMLBO/2mNcXF9PHwI4wg7GCs?=
 =?us-ascii?Q?25OMsFO3B/TIEq2gXX4qor4nGEUqeCEnuHbGKgs4uy877TyJoHDB8N/k4FJ2?=
 =?us-ascii?Q?91xL051ntkrCrbDoGpDnhmqDgkXEWT16kFO9T/CI7Y3HeU1IvXLEb9Jx9eY3?=
 =?us-ascii?Q?HXcPS0yDg0UQvyunm4NaA9rSYrT7NpfxInXzrbYxoHulEfnv7wiyhL5v828Y?=
 =?us-ascii?Q?Kql5oCfuYi4Q3T6l227bkUdPdXeafDVljfWaVat8IuPehOGkDNVoYReTZZMw?=
 =?us-ascii?Q?4ksIflXPYgRq4kK/XOauZVXI27fic+2MhHXVEXBh7Zz2oAkeBGgediL0DKvY?=
 =?us-ascii?Q?T7ti1Mx2Z1lXOujzOxaeZKZBYI4F0N+9n+7Zny3kSzjjQcOibDAhAXPTFAvF?=
 =?us-ascii?Q?CJZyaA5Piv2HI7fVNGB8IpID5rAHTzGNgwAam0A+t+weIX9SAjMiMHKdpdsT?=
 =?us-ascii?Q?S0UnBBVsu3z6dHjkcOo7V3tL2BhTRxhARU3Q6wYS7OuNN6eofR0+Lp/ra8J+?=
 =?us-ascii?Q?f40eiBUv4MURAtVsI7dlLPP4opdlQdymBNJbxgxuWwOsGuZ+aB+wr3emccKO?=
 =?us-ascii?Q?e9v6fsa7OsBBmIgyjlORn53J9XGurRSo5m0GOXsE9Z6En5BEdtG88x2aYUP0?=
 =?us-ascii?Q?Rv12+yZaKvkTW70QOcIDhKF9ML+LQTRH74K7PdLNKkqyEmdGaVzRhjt+dtQV?=
 =?us-ascii?Q?0AfvD1uvKVZiRfW4oQqzcPaHEI/6x6hzvANoV5Hr936hfpSYxdqanOdLjws3?=
 =?us-ascii?Q?r5SvZIwpYHtwZ5BblANaAmw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06744757-1bcf-42f0-b2aa-08d9c1666763
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 14:06:21.6736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXo8c3RhDDbJ5lV4T4u0i1rVkmzZPLSWZ+3hTEraocP4tr5YFDmjHsrGLMXyy4ncD7auQGF0TCkaHmo09WhwoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1250
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-p4 "rollback" verb is described as "A tool to debug the
multi-branch import. Don't use :)". The implementation provided is of no
useful benefit to either users or developers.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
Adds Signed-off-by tag

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

