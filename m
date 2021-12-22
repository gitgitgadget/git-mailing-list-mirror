Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6DEC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 14:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343607AbhLVO4T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 09:56:19 -0500
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:7784
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343606AbhLVO4R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 09:56:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvkH0v5MJWxZvqAsWTJGqP7z75DRRRhgwNPGB4TkE8UWOWLgR98cchAJkPEtCYYwzBc8WmblfwkyXiS7Xr1AJ4D/IQOFyKzEVhg2RReSrnW94BiU70UxnFmg35GtSKtM7EOV0KYZYXG/H+2pByCYLK2f+nNaripNz2Mw9w3x1HVj6+EnDuNDwPVyJ3dO+oiouViex+eifWMaT7yDZs5OM7arxLPQh+cmPzigZvGjJoWqRAIm9RhCmZftgi45G7i9gwUUftl0FuvxYtZUk1octy3WH0KKilI5o9+jxP9eY9wtGVOQJRmP/aA9hcQwgqYLGp+UGy1/6SCSBylq9mMRDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMRgCVUxSYr4FxEekHbbXBu5e5eF1dO2x28eBVe479A=;
 b=fn2lfS1fWfjKkCWCJPa8ie7KlEsNJBupK61yngmC5UHmdiKH5llD67Z8PyVpy0qgBNywZYoJTJN5rA82zll5nDK+VKUoLU+TOUZHCC+IYoIyMXuXqGhKasAGBfTxLP3jq8Rlv82sJg0/KrY+IE5J1mNFwTf+yXFno88gBVaIHzQhPmTqUXH+do7eIIUS3A+vYLLX0Zta3rWaLQhhaub5ycdRnKqnXHVcu4YVQZ1KtVTpjY80XXD8FLt+6h8SOLu+CsvxqNZ+ZWPjuiU2UcfvJ9EHbzWlQTzaNPcek4IWreppVtYEOQ8iQ7ahRyQPjcJyUF1/zDsT5OvWp2MTVUnwFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMRgCVUxSYr4FxEekHbbXBu5e5eF1dO2x28eBVe479A=;
 b=R5/NqLuYu+KLm4tP5+irgNKXN/OSmSd0Fm0wvFopYQfIxFBbUiAzc0H7/BNYm6tWPr1bmlW2bGaFo44C8MXYwziZ5LQIZeK0hS/rC6VeP8pJq1x+50kUogtOvTPrqM0d0cC/GiQMnk5fUp6Ihd4amsYOTkYpg5OURlgKQCLgRc37wlk4Yo2nxbsCXJ1uHOa6rDOonUQ0YMIgoWrIH+t1UGHFWB+SX32N/22WhPtwJ8bhf5LttvEn+q4sSxk5EoETs+9XGOnsEcSikXCULf7Zpv49iOqb8ycV0TsnY596vSwkb6ll+dCrtyx/z/IpQoqNOzNtcjxRGb/Ltzt+D0+z8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM5PR1201MB0105.namprd12.prod.outlook.com (2603:10b6:4:54::23)
 by DM5PR12MB2487.namprd12.prod.outlook.com (2603:10b6:4:af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Wed, 22 Dec
 2021 14:56:15 +0000
Received: from DM5PR1201MB0105.namprd12.prod.outlook.com
 ([fe80::d57d:8569:57b9:874e]) by DM5PR1201MB0105.namprd12.prod.outlook.com
 ([fe80::d57d:8569:57b9:874e%7]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 14:56:14 +0000
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
Subject: [PATCH v3 2/2] git-p4: remove "rollback" verb
Date:   Wed, 22 Dec 2021 14:55:52 +0000
Message-Id: <20211222145552.93786-3-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2fb58106-1242-4b74-77c9-08d9c55b338c
X-MS-TrafficTypeDiagnostic: DM5PR12MB2487:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB248770A9D67B3C87DBBF4E0CC87D9@DM5PR12MB2487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QUt99jVxSF4SO/l+p7jpkuibRN0jExmOXQK3uk89BvbbsliHcvLhM7eY9pPsAnUxwAV5ohenRy5Gqt/AlCaNXfuTCQBTLhxW9Y1+9u/CgexP11eLJP30TrJCvMwAoZT1XhrJAuqR87hqypRKmSwMSIX55SKGiroyC/vC9AnqaZT+QJFn33/e/FG90K8ebhVFSU2LlvyP6CYgw0k0Mo3eGZb72b8NaclixegRoPbFL/BlA/b2fa70Ehgyiw/N9V+B6jsAraKcrDNvfbu+G2kULXrd1ptwCiiPaksosmXsUzcLmYZQooe7xoDPun9ZfD7hF5ah0XdIg6kUDt0HkfYIRXcL+Bom+LdkQeyWA7ah5ouxZbzaFyE5GmgfSGCzZ+uO1z95zmBYZhDvY39y0JkdMfAme56NVxlZoCCELXR+N2E5vYJs4iS78+Mt/JzfAjBx9IvfrqtE9mt4XjRnq3nKxht6bto3r2U3X6gAklAhdt6161FrWWBaRWFpnu5ywkID7Y2EUhBfnUbHV57H3OLHEw9OCymg+MzNuui5V5jpCEC4/RhNtJVJ3aruYkGghiRTuz/NEEyARxBV8A3SzUbAKoJeg6iAA4v5XypA8teKDEKZe0S09IkH1liqNtzkMEcle1oSEcJJHwOovgKWMncRcA3+PSEo2bYqPYD/hFYI+kHXCKcTL+/7p8QnyttE6Fh8oiXMO/sNEIMZmFtlCcLvXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0105.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(1076003)(4326008)(8936002)(6486002)(107886003)(6512007)(36756003)(38350700002)(508600001)(38100700002)(8676002)(66946007)(66556008)(66476007)(55236004)(2616005)(5660300002)(54906003)(2906002)(6916009)(26005)(186003)(86362001)(6666004)(6506007)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n48gw9dzK9wOAz2Jz124OskyiGVSwPvD117eQysy3y4f00aCPC5OYJxodtj0?=
 =?us-ascii?Q?wknJBd9p5/oFSNAZiD3eFQ0h1g99f7MXhop03vQ4qNgh3/nMlWttGXMVrfkA?=
 =?us-ascii?Q?vEETF4ZLsuNXrFy++hix8bHqZHLNrAozxlcyGxm4XHXuBZujKkL/u86468Yb?=
 =?us-ascii?Q?27obWipcyL/X8ufM7YOzZGu+VJ7o61ryXrIazg5FAngNqeYgnUSdxSmtBdVI?=
 =?us-ascii?Q?6K6NhmF12X6H4puyXA92cTk2kJDGxQy0u+Dftlg4aJ26vcpeL4PP0sgi6ZN4?=
 =?us-ascii?Q?opotZnRc+QJyNlgwRFKfOBDbeglS+RZel2aMKBEN5Sb5paJe8Yz+2MuKiZdO?=
 =?us-ascii?Q?P8Qw7wJ1H363iEkW5AGuUM9sNoOYWwfqxJi5LVYpBzOPFSQ908gfbDI1V4du?=
 =?us-ascii?Q?vENvBjTFapGXRydZ+tU3Xc8+lGDPgJ7lf3fYpX0qFAU/GocWfdxRmP/hKVN4?=
 =?us-ascii?Q?b4i5pEdrD3oX9y07ih6lwEJVC+IkiEFz84YAtxZ3i5YEsZVTdeRQykKxGs5g?=
 =?us-ascii?Q?VtSXzZ1EChAMvM/5KjIdi3isT+4PiaHZQhkskiJWBCvbf8Cu4nrl1CZfd/+y?=
 =?us-ascii?Q?iLmWbS1Xll5lQisaBdWl9ZZYfVVGlrJKsFitvEOGBF77DmA2rnp3zdA4GPkE?=
 =?us-ascii?Q?RK3bsH4TXD1FjbfqqwRMP//V+lN7aZ7k5fNW07HDI5ZW6gypUc1NP7tKDhTK?=
 =?us-ascii?Q?pIGyJdUkAa8QrS+9hIapondxkncvEe8km1dYo+DFbWPx8CYrn9eFYpYqoBi5?=
 =?us-ascii?Q?gHkM0qTjqPzvrirsURPxvRoAQSrG3LMLOc6omWKKHNlsillSwyKMk1voQ7CK?=
 =?us-ascii?Q?kRI/A95snDg5DG96eE3A6KZtsJomy3uAEK7b2F5bx4brBocdhvr/kUIb6pcu?=
 =?us-ascii?Q?nm44RMQ4iCSRcL8AfjAjkqJy5TfMpoPQQDf/hdHwuLsKTin6NPJPjFo7U+fk?=
 =?us-ascii?Q?lL+ctS0g1mpbZeH97p/t5SfXeM1Lxgn02ir4pMTkLp66lTf2El3MH4s9J0ww?=
 =?us-ascii?Q?5ja5tD3vIiOmTEY6bk1vsK+eFTI3s6pA3brKpl/4KhyHc8nWSv+NI02WM0lr?=
 =?us-ascii?Q?lV+TeZROJvdh9NruBMq7NrSH3bRZG4FxM3QveQ+qzIi6Ewhu5KDKwT3IxI7y?=
 =?us-ascii?Q?BvkMp7pFv9wnHGMAPlkoo/mt6bN2YDLvZTgpsxQpXkLgjx+d3epg3RBryKwo?=
 =?us-ascii?Q?oGm8rftH0Slp6dykP00VSojN6WLXLAnkwPm/LVHpblmNUvbsCkhTDDf2PyL4?=
 =?us-ascii?Q?0OWdhubd2iiYzz6zQTLI17eBT6hGg30v7u0eY6wFMEzLvyMhgBONAwv6fYWx?=
 =?us-ascii?Q?A3c08yzQMVPD3B+MG+5nQTxF0kIIc/g69eCG4k/3E2n1frblznyZpgTpoONI?=
 =?us-ascii?Q?e8fETYiOY/Yc+AdBL9WjwarN/7WPSkPvVTln5/X/o7pFEc+oGPmWPKgiwUE1?=
 =?us-ascii?Q?RMNiGjlvOa9rw3q/yHiwSRGakKY9+CVdHFiA36etzmwbHX1v8EfAP2y1pNaK?=
 =?us-ascii?Q?zDMTR0zhNy76TNngzPAazh+3/dTpF6bXoc6cqlmEP34cvPTCZNkFbts/8fX+?=
 =?us-ascii?Q?JHrpyTO1e0AMx66jDmhvHc6T4ZfRSxhE+YDGrgQhhqO5nD5Rx1zddDhrG09T?=
 =?us-ascii?Q?HL0fIV2XLltiU3oQa2cNhCo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb58106-1242-4b74-77c9-08d9c55b338c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0105.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 14:56:14.9518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aw7c8dVLKMxLL69PgQ49nCH9qr8AUlfXhKLIX2hGunHQfYQhDesVdIJdjmVj3fVZKCRF4P75phzz3bi/1hM9wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2487
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "rollback" verb implements a simple algorithm which takes the set of
remote perforce tracker branches, or optionally, the complete collection
of local branches in a git repository, and deletes commits from these
branches until there are no commits left with a perforce change number
greater than than a user-specified change number. If the base of a git
branch has a newer change number than the user-specified maximum, then
the branch is deleted.

In future, there might be an argument for the addition of some kind of
"reset this branch back to a given perforce change number" verb for
git-p4. However, in its current form it is unlikely to be useful to
users for the following reasons:

  * The verb is completely undocumented. The only description provided
    contains the following text: "A tool to debug the multi-branch
    import. Don't use :)".

  * The verb has a very narrow purpose in that it applies the rollback
    operation to fixed sets of branches - either all remote p4 branches,
    or all local branches. There is no way for users to specify branches
    with more granularity, for example, allowing users to specify a
    single branch or a set of branches. The utility of the current
    implementation is therefore a niche within a niche.

Given these shortcomings, this patch removes the verb from git-p4.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
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

