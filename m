Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF98BC433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 12:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbiADMfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 07:35:02 -0500
Received: from mail-bn8nam12on2060.outbound.protection.outlook.com ([40.107.237.60]:38528
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233008AbiADMfA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 07:35:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHl7xtnFJC6jAEL2z9U5ReALWZobjZ1y9U4KSNZS2hQV5+vbJZ+PBKvttA2TDnfxSLoHpdvXCQoeJmuAOJI7JiJJ2SyizCD3nLrnmTh7qcpE8jcOglNyQWPXe8EI9jfUQiGnNbtH8pi9f5db4nKxtZQ7iTdj8lRn0NTJPQDjcwrkg4KGx1Lg4gp73JGSJFp1Q43nEKt5PBPPWfEn8tH2XJ8bGaaPyL/q5IQ6Xmrb0oC3vYxAcI+y+OxVvblYJu/NhtFE+h/thES2xSlcWfMwqDRzXtwswqaTpueFCyvXEW/tt4cmZVoiD063iWAymsGr9pB0rVph40xj9wtparlR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMRgCVUxSYr4FxEekHbbXBu5e5eF1dO2x28eBVe479A=;
 b=jUamfXlT2P+vatT1a+kx8BQSAir8Xz+lggwXWOt0PRymnT+T6v9A/GWEetPTO/HrrV5sZbucdlJow6xrLHmbtcBV0KLP+vas1/hV7raJ+QGwe5pkFYk9CNVPPW4m/hkJiDGGOPmvJV92pDcQF8Dms7jFYTncXhFluxg2YNHS+7ob0v+JxuKp3NPMVm/8MpmFB5aEpHaKqwne+KQ8iM5qeWffAT5ZlF2lGZ92TGnpHsFhiFcsMZ3ZT/IBL+8syEABclYlT1vo9gMzqmtsrzAZPwZG0tp49hRCFi2hmK/gWAoYXT5CK8jyAGgCAuCfEizLpKK/5YL81MKTinrDA5083g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMRgCVUxSYr4FxEekHbbXBu5e5eF1dO2x28eBVe479A=;
 b=rJd5htYLhfo/6ZmAzoifNPD+I2PdZ4IwdcOiWAe2N72o6Ck728GIDCZPLdTSSJphThTJncXHYQgf4/fC7qTrhNUZCW+V0AN+OnBNO+PleMQuCcgnbydShriMmQI99LlbeN2nG76bdwj2d2wZZQE527EW5mIRitEQD0v7Z21vHegiczp/yY0sEdAzV5+DDSmBAdkHJU2dr6Ca3jnd3bxGmpzwOFPolhsljVAWnT8TJvVo8IzcKbKHxnO/y6sOpUzU4kqW4WJoUwrrDrVzU5tkzQVmH8BBMMHxZ1zpvG9mhxPDpLjpCYh28gjOiFJrgNtYzjFyHWbeQxh9wTiUXfeVsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BL0PR12MB4866.namprd12.prod.outlook.com (2603:10b6:208:1cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 12:34:59 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6%5]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 12:34:58 +0000
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
Subject: [PATCH v3 RESEND 2/2] git-p4: remove "rollback" verb
Date:   Tue,  4 Jan 2022 12:34:31 +0000
Message-Id: <20220104123431.1710-3-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220104123431.1710-1-jholdsworth@nvidia.com>
References: <20220104123431.1710-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8P250CA0010.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:330::15) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dee13228-13d1-4167-3ed3-08d9cf7e9ed5
X-MS-TrafficTypeDiagnostic: BL0PR12MB4866:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4866F42B937589F83AD8BBC1C84A9@BL0PR12MB4866.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nxeiRWeKCiKeqIc292XeEJpmXwxuPzH+uRmVRbevcrmkLD93sGtwFfPHonjmGSX5wjGPe25U4iBcEQG433BhPfMzQwUF+otA2wo14f+dqZsguyEwzTjn0W7lsaJqTxdl5DBA/Vu2GqenUHRYTXWmeECPNBuBtIgUgQlSK5AgWGvmBrW/1rsqFY9bzcrkNzsGEJCzhPpWmqvIOygWfY/M5eL2NRFlANVvVFoBMkmUdrLzGVOviXWTDtHZN/tK+1jfNVQ7d6deOHcJeBloCk+IpA/N11wJmSwvVmwQgfthrn+4Y2kpXBIEGFQqnFTHk35Oj/Ajy3gt0ICVxoiD5MqZCjwiMHIPOr4rH2e34kwJgFafsaKf5+Xycpj5qBUFVyeUKIxj57bgux0WNxoOc/jUk5Uct7Abbdof1Zkhrh9wCKovFF+6NBLfQ/W7EDFE0dO4U4lQJdKXGZs4+wBYxwbA8C/dL6SBBiw/myg+6gz0LBfFmxL0VugyWoqBF/knKFoQrdOqYhsiwAgrGsi//BuePzfwa9W/xOTCzKRodWHnjy5kbUZM4mHfZ9mVv5cyNF6kMtZF8F3y8POi0pmt6U2rPZfbtXUaDDG/RhEfoSyBJvEG4aJHkcWCjEwJxlihZIDHArzVcpoj8G5pHx6w/lPBG1R2TopwC5EsRvzhozd1X75B3YvyJKiY08mC7tz/pgtFFNDrDDVWnZ9rasVkxAYyQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(55236004)(38350700002)(26005)(6666004)(508600001)(2616005)(8936002)(6916009)(8676002)(36756003)(38100700002)(1076003)(316002)(186003)(66946007)(83380400001)(6512007)(52116002)(5660300002)(4326008)(66476007)(6486002)(6506007)(54906003)(107886003)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p/9/+K0QnLUxR+yp6lVmMdJEgiZ4eItGXba6ZBbH7UFRY4PQw/E58x+LHxjc?=
 =?us-ascii?Q?ORWJKo7bRH4G7rtGmTXt3+oZ3GOWBprn3q/bIU7/hJPu5r/9CxhsCJVTm1W2?=
 =?us-ascii?Q?xSx2UWaJ2a+TCMVpiMJEe+syL8X4a3gcEB5r0jEMCgQrkFIp5ga+peB6vgsP?=
 =?us-ascii?Q?Z148NTyyc4huLNv7RHvi88rEXvdlMdP66hIXeAxOqV9lYe2rZjK3OZsvZWjK?=
 =?us-ascii?Q?cIS3odM0FeCb5Y9xFHVeEEAApxpxHdjtIVUZDOg3Z+NUrK1s25yDBbG9yKr8?=
 =?us-ascii?Q?JNJhtKH8VG3h7ZVG7NjkCdO0t1rORq4lVbNSgcNwz9PqSVh9JqoPsqaeMzeb?=
 =?us-ascii?Q?bOYxOLjXl7qWapRKjS7u0v5aUzRGMEPjKtPKzgwDi8RM6eQgMIfffpSC1CWV?=
 =?us-ascii?Q?4HYeJ72xPCegLmicbtonrrTWXKFJcWWTHlxLSoh0+wYTOWBpe8h7LT1Eur3E?=
 =?us-ascii?Q?+njhn9LCr6PaTN+DfFn1XwVN9QpiQ9LOb3MSdWREIBUycIvXXISo/DO/vjRC?=
 =?us-ascii?Q?MOZws3mfeMpguGgcNlktwkFTwcQdR9JZ3Ha63PsU3ggoS149KhX/hmtQGkCM?=
 =?us-ascii?Q?Q+RCrjXF3g/vbRLZXN6PPJ0ilSxciuU4mXczNoCqSa+LJgGjSxBAWlHmDHh7?=
 =?us-ascii?Q?QxOzEtMgV3rqw4S48vIONm5/Jc5Uf0buOkKKhM5XnXoOsEmNSJu1ODFTse8l?=
 =?us-ascii?Q?De9o1mzn1y/QBLm5Oo18X7zrA4w1WP6lxKEh21MIiKH58ZUtYzcDDxIdXl4T?=
 =?us-ascii?Q?EBYncGBo+Xo6k7NEOrs5spQQvOqnbfDZXq/6rvO4z1PG6Wkx4eyIzisRuFEx?=
 =?us-ascii?Q?JTLphrzQD0GFFJiu+mjULVag4JXNlo7u+H8FGm4nP4dXXODF5G/axFERazkA?=
 =?us-ascii?Q?s3DRKKdfXtYkv8adfwbCFeh+YsVqFWEl6k9eLmi3wH4ajRMc60rSLH+vRmR7?=
 =?us-ascii?Q?VbTqSEFHrfd9CdYdJUHWEuuX54Y0FHBLbbahsufMEaew0FfdZEOBQ/6rzNdW?=
 =?us-ascii?Q?ASh0LG6M5bDfjVGOl6tkkdM2Bx0KSo6YRAiorGd/ohS87WaKLta3/fjWiSy5?=
 =?us-ascii?Q?JTsuJQHHLTTg3y4uQa5+FtmVx2vxZTPHGnosN5rRsMlPTkye3IyKT1RsOpOt?=
 =?us-ascii?Q?Q6KWUWsdg6F9v1388dCQivNcuOGIa3mL1H5Ii2mvlQq9y7RwNcsowJedBCmP?=
 =?us-ascii?Q?OnzLaW9E7ii1I/bsHa3xQdVa/FAxmYz/0daja69wefSDnJlLs6X0QKCsSIaX?=
 =?us-ascii?Q?Rh31yV0BHo7I8miFk8G/PoXEoglHOzm7rH6Y+nfv4GFiMVD/wKWda1V3X7s+?=
 =?us-ascii?Q?BXRIP+CStiY4dIkK2UkAnTh8sHs+OV8b7GIhEMI8MXnYNxkcHA++iq+jnsna?=
 =?us-ascii?Q?0fmmv7um5GLz8RaaG4AZ7iEprfWvFJYIQs9CkREfmvVJHWbg8q9OR90vf1ya?=
 =?us-ascii?Q?ILXjLSGKqBsjSRSF8FHe51aN8uc0G5/F8EKNJOUuj+U8vTrMqg65oBG5U0ya?=
 =?us-ascii?Q?zLb1J26TsKMtWXz0ibf6XthOTOQKsP1siHOeuPaKe47Pc4mlrRd8i27y7mm6?=
 =?us-ascii?Q?cXhFS9VAyrqrZbxoDT0+wsbOqRFDA/O2dCk9GFBLFIFxrJWBdQS3fqNjlQ13?=
 =?us-ascii?Q?d1iBpFNUl5FNmJwGR6XmLn8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee13228-13d1-4167-3ed3-08d9cf7e9ed5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 12:34:58.9271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZ5yrvbh5CsdroUsvELgeI5frR4nCd/f0Dl7arEeHEq8HSg6vTYQASjXeq+jxVkyTO0GSpH3IuBwr1DWYnRjoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4866
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

