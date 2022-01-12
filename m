Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F171AC433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 13:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353715AbiALNsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:48:05 -0500
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com ([40.107.243.43]:61056
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353714AbiALNrg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 08:47:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihxMWZNKVvzH61yJJsXRcxCh0gtHNAIXT0SP/ZSg0+ju+KRfJ6JIBzP1fONtYIi4ajy+oW4d4F9iZaOFKM7mx5Ab4/hLhoqGWxX91yd72L5RrLuoEoxYVjzUHkPBbL/f8L6m3Xispau7i4lwPbOl7p5xVxQ1HT6NU7W540W7FKLhvluJIYnq2cUaW1PqCqtabR4iZ9PxYBfLX0Q+KV10uAMJVLscIgK7Ev2X21APwXqb08gxubImSlUtmSs/tWSAEq0m3Xu38VeAk1DTygYPG0x+LCsKGwQUY4JQ9vzJeyKxXhJ4/ixzkSyMTME+otoyZL5JAOO23MfAD+Q0Wr2QqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8du1CFglnpG9HTACMEmF3YVp8Irz4r75xEqFeCrwUmI=;
 b=l7f/zdcj+Q9zsigPxo58uASQTnpUeBlawTcXq2M3fcuTVH+7wLuY9Gvd6v5mgfNoCVeqQ6stlzqC/+YlWLiH04wCU+JwVl3SnGrCFDzi03HvJWQ6xI29EBt+InlaqhBG1xIz0cdsnbX4cE6rIpfjOASFWKTEjYXPnotJ8yhh+AKYyuxjZHwEn1qd6tBPzqCCAIsu3rN/XUdwuYFn4P8rB1NBGwp+3/m9KLkpuBpv9XTACbrdzmz2OMzfs37kk8CubQOZYJkhAKx0snQCElP82XupTzcw61RLiFHEPlI/5ADPIxd41sqvF2R5rbt1ocsSp3l33db54h6OT0++rARhVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8du1CFglnpG9HTACMEmF3YVp8Irz4r75xEqFeCrwUmI=;
 b=JNauHQfNEt7bHK0ZiR2/812Svve+dOQlKooXO22Tq5AhjwSXY4NrA9CMnevXZXqB3Xnr4eLs9o8sXlNi4RAEDyRUYiySwyrgobVJL8dwCdei9sA+QhRoJIbOe5CMozlBW15p24xXNjsbbgGdS1fLdrXpgl12GfkV4sodhRU6xOcYbH1jLtvcRiqf/sr0xG2kFZmcAzUqaNcocKj2GgKzdRphQB2B7Ru1eZpzZdsl5ZMXvpzdZ6nhNJUWwU7oFJHONmhqyFrJ0JZUbgVszNk8TZ/8tzXlekzmX73dduYuv0S+sIqMceiJW8gRoIQYyhMYs1duTzNtxjohKSocNi8vVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB1594.namprd12.prod.outlook.com (2603:10b6:4:e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Wed, 12 Jan 2022 13:47:24 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 13:47:24 +0000
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
Subject: [PATCH 08/20] git-p4: remove padding from lists, tuples and function arguments
Date:   Wed, 12 Jan 2022 13:46:23 +0000
Message-Id: <20220112134635.177877-9-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112134635.177877-1-jholdsworth@nvidia.com>
References: <20220112134635.177877-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afb5e91c-59a6-4bd4-eeed-08d9d5d2104e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1594:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB15948D286F0866428EBF0756C8529@DM5PR12MB1594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KsRl8ENVAYdRcQO+zMUlvWkl3/Ew6KQ0eJO9GyneJ/k+PZiDcFxX/FtCd+4+xAiCk9vkZGrxM5tn+nKraQvGo6hyOREllrzdlFfFhZ/DfUnBQaHu+Pc5wl5tW3uZkn2rZhyXldrzFLWSEoFEoKJvCikrRhlOHbNlHWZNI6Iy1hTAlS28UKKsiDf3Sb+YRc2xqgDR9hwDdC1ELXcSdgZB3VVs6ENDAOYu9nVSfs9jqnpdBG8N2R7jQgNRM1hpAW8QBu2rrq+40wxmflFZX4YUZKAi0kBebqlqGdt7AWws/mkEReqdTTDTYYMUnlsLBafT+rVO66IQLobC9ap5n2sgMZDw5A0nKoMP5aBmr4l3TIRJRb3MGxX+5CmJd6XRZQlg22KeCW04An4ieZh8g8jwFbXqAdyLw7S+x7+i8Ol88AhQTrv/GWgpLXlCO/0y1Dw3UtcybJNvj79UKwUTO4Le49A6P9Av4WAkHvp/iAqoCAnyRdcfFYLgulvHq3u6kqgqfI78//5glA18vFuZwdAHMktizV5TuOgyI0kpe1r2kWvi2hETIdL31eFaC7fH0EE4DsLkMILAWOC2IpXpVpxA2urfhTuEbuAR0rvGiLD+/HEmYAyUj7u/pzIE15aZZTR5o5yi+Zg5mih2bpkLs5+Qh/NgEzbBbfhVlmWyHk1CRty9at5/kwKCH2iXcqcmcZBToDye9OphogG570F/LJ5qdvYM5hgToUZG184kjRVeyyRmAu1undxiu81v16SZWUJdko3vV2xoKkMzCn3oHSlC1QOMvUr0IQT2DveHuI6DOLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(5660300002)(1076003)(26005)(38350700002)(2616005)(55236004)(186003)(54906003)(66946007)(52116002)(38100700002)(8936002)(7416002)(83380400001)(8676002)(107886003)(66476007)(19627235002)(6512007)(508600001)(36756003)(316002)(86362001)(6506007)(2906002)(4326008)(110136005)(66556008)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2yS6/bEH6MWnruz7ZMFfyoF6jjopQd0oYtMOSY96dz5q9Gk0/WjVh5DYFj4i?=
 =?us-ascii?Q?ERhRyqO9LBmZEOE6Nqs1OoF9Lhr5rHzTN//9if1eR0AKB6tTzdXLtk0DlXek?=
 =?us-ascii?Q?EKhmqw3blx2r1dHWhNovqSjepQlVUi/lv+3R5bzZcNmv1MAK9e4oRjzD8flk?=
 =?us-ascii?Q?yTJKT2fuqrAEaMj3ouf8q+PBngByydM0BfcQDY9/S/fqQwk2yL0b3AFA3tzc?=
 =?us-ascii?Q?xUO0whdwX/hkugEVJGzIecx3iIkxtZbr5ul8rH44q3abkIDDtR2l9CYS3itq?=
 =?us-ascii?Q?8BCqpJgxStfcrLuWE7PaAYeZGZW8OnN8z7PpmG2Gu1DE+NLcVd1RtXTIVUEt?=
 =?us-ascii?Q?FUaFEJDsGG+lF5lvhcxKcFRqn1YQ0HIZdnaddMEJ2LuyY+RWTUCvqyLI2veG?=
 =?us-ascii?Q?a1gU5wsCESw5a3mJIy+eCOJMRyFkynrZ+z+nka4AY56Udwjae8q/i6d1+7xi?=
 =?us-ascii?Q?wH85t6SVioUWUUiORU9gV7nLhIEfGT9t87ZpjiwetY4cj8XGNKdptkn9Rjhm?=
 =?us-ascii?Q?3nH19puTDok2vdoQGz0GyH9o6HGs7HjYN016C6iqsrihDVulro7QlkEVaOTn?=
 =?us-ascii?Q?6vfK3KBesfKAUy9nUXEjaJke+RB+R7JOekkkIIgzBGE2SVu7P4JY3RrNAaW+?=
 =?us-ascii?Q?sDawwBPer44WECECAqA9u+dOWjqNsZ7EYHX48nq1na4TAwxofNYR7a+U6cJl?=
 =?us-ascii?Q?3GHeOigwyOz19s0jtEJOzaLpnx51Dzap3300iwJZOl+gzvgizQqhXzY4OiN0?=
 =?us-ascii?Q?i//b+vYEibL7CtAOkU+h45+SD19Oz/z1FrOt5gMDFij+a7+QdBvjdPPhOMuN?=
 =?us-ascii?Q?L8tzttaDJl4HteWGrq085LnOH2rfmuqmEZmRbxHhREnZfqh164knwAwsA2ak?=
 =?us-ascii?Q?GFQxcYXyAxBaT5x1oOYUPhjeWo8ZY0F+clmiEKHcPgDE9tAbT5wGMH8npEJ9?=
 =?us-ascii?Q?U45O/9eCSwysSmSix/AChDOMbk/s4BiliVtiu3tfwz6lnYG+BlX8xH7WH+UA?=
 =?us-ascii?Q?8mkNMOmCqa9tZjCB3/dcy4n/GY5VYvus7l+Qz5vHiEi42Kk3GFJ0G0IfAiQW?=
 =?us-ascii?Q?ST/bJi/0OFxFM/Pp+6wLUbpP4C4ctnJcDllwJSoRdU/axn9/jABh8HD1+bvR?=
 =?us-ascii?Q?6YOaEyaN7kzYlt6c1MxljDCGoguVM9/M6rFTLhmumBEDRVUkVPCFrypI0I5L?=
 =?us-ascii?Q?HhH+9XBLGRKUIqFR3l/RztgFjgKRwlSZxDYP9haAcHmUwvKXuPj3+NNu8qon?=
 =?us-ascii?Q?0Fme1ZkDg0z1jYtOJPqhhCjxNJyjquBCSKiJ/QeO1WcU4S+Z6YJHaeGDi7cF?=
 =?us-ascii?Q?pIkoXQDosFoq81fep71QqhByxTE6YvV/WwOER5j7aIy0LTtiVh+fL9D2o+Y6?=
 =?us-ascii?Q?gEMHJRqGq73W1HXSPaWDqtgYikv8sG49TGlvvTKDzuAS2nE2f/bAmuw3YfeT?=
 =?us-ascii?Q?JhsRdWj0KZa2qEl7tzAEEOspLfFs42NdDq8DwAsrCJHTycD5EZGQkL7C++hc?=
 =?us-ascii?Q?bjPA5FOG2ijP1FPmbj2NB91WSGjHO+Qz/VruE1dFiEYzowR8dONRZX9h2Uxl?=
 =?us-ascii?Q?vOR23/Ns/HQ9FfT5Drk4mA92YtVqRvpfxmWtSCtgG+zrugBHtDJVdl+IbD2S?=
 =?us-ascii?Q?Bv42QgWO30IZfTUIX5Lb3fI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb5e91c-59a6-4bd4-eeed-08d9d5d2104e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:47:24.4654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lO2qD1QPS+hLvnQ7JJLylh6L5PCRdCYby22CnJ6iAtzTWfLQRBa/dOa9W9ot73RI7+SdE00hwpmRtiWI+5S0gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1594
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 discourages use of extraneous padding inside any parenthesis,
brackets or braces in the "Pet Peeves" section:

https://www.python.org/dev/peps/pep-0008/#pet-peeves

This patch removes all cases of these.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 2f05ec10ca..39c1fb7d4c 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1025,10 +1025,10 @@ def gitDeleteRef(ref):
 
 def gitConfig(key, typeSpecifier=None):
     if key not in _gitConfig:
-        cmd = [ "git", "config" ]
+        cmd = ["git", "config"]
         if typeSpecifier:
-            cmd += [ typeSpecifier ]
-        cmd += [ key ]
+            cmd += [typeSpecifier]
+        cmd += [key]
         s = read_pipe(cmd, ignore_error=True)
         _gitConfig[key] = s.strip()
     return _gitConfig[key]
@@ -1047,7 +1047,7 @@ def gitConfigBool(key):
 
 def gitConfigInt(key):
     if key not in _gitConfig:
-        cmd = [ "git", "config", "--int", key ]
+        cmd = ["git", "config", "--int", key]
         s = read_pipe(cmd, ignore_error=True)
         v = s.strip()
         try:
@@ -1103,7 +1103,7 @@ def p4BranchesInGit(branchesAreInRemotes=True):
 def branch_exists(branch):
     """Make sure that the given ref name really exists."""
 
-    cmd = [ "git", "rev-parse", "--symbolic", "--verify", branch ]
+    cmd = ["git", "rev-parse", "--symbolic", "--verify", branch]
     p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
     out, _ = p.communicate()
     out = decode_text_stream(out)
@@ -1319,7 +1319,7 @@ def getClientSpec():
     client_name = entry["Client"]
 
     # just the keys that start with "View"
-    view_keys = [ k for k in entry.keys() if k.startswith("View") ]
+    view_keys = [k for k in entry.keys() if k.startswith("View")]
 
     # hold this new View
     view = View(client_name)
@@ -1585,8 +1585,8 @@ def processContent(self, git_mode, relPath, contents):
 
 
 class Command:
-    delete_actions = ( "delete", "move/delete", "purge" )
-    add_actions = ( "add", "branch", "move/add" )
+    delete_actions = ("delete", "move/delete", "purge")
+    add_actions = ("add", "branch", "move/add")
 
     def __init__(self):
         self.usage = "usage: %prog [options]"
@@ -2593,7 +2593,7 @@ def run(self, args):
                     sys.exit(1)
             except Exception as e:
                 print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nThe hook failed "\
-                    "with the error '{0}'".format(e.message) )
+                    "with the error '{0}'".format(e.message))
                 sys.exit(1)
 
         #
@@ -2798,7 +2798,7 @@ def map_in_client(self, depot_path):
         if depot_path in self.client_spec_path_cache:
             return self.client_spec_path_cache[depot_path]
 
-        die( "Error: %s is not found in client spec path" % depot_path )
+        die("Error: %s is not found in client spec path" % depot_path)
         return ""
 
 
@@ -3093,7 +3093,7 @@ def streamOneP4File(self, file, contents):
             else:
                 if p4_version_string().find('/NT') >= 0:
                     text = text.replace(b'\r\n', b'\n')
-                contents = [ text ]
+                contents = [text]
 
         if type_base == "apple":
             # Apple filetype files will be streamed as a concatenation of
@@ -3717,7 +3717,7 @@ def importChanges(self, changes, origin_revision=0):
                     for branch in branches.keys():
                         ## HACK  --hwn
                         branchPrefix = self.depotPaths[0] + branch + "/"
-                        self.branchPrefixes = [ branchPrefix ]
+                        self.branchPrefixes = [branchPrefix]
 
                         parent = ""
 
@@ -3825,7 +3825,7 @@ def importHeadRevision(self, revision):
             if info["action"] in self.delete_actions:
                 continue
 
-            for prop in ["depotFile", "rev", "action", "type" ]:
+            for prop in ["depotFile", "rev", "action", "type"]:
                 details["%s%s" % (prop, fileCnt)] = info[prop]
 
             fileCnt = fileCnt + 1
@@ -3978,7 +3978,7 @@ def run(self, args):
             if branch_arg_given:
                 short = self.branch.split("/")[-1]
                 if short in branches:
-                    self.p4BranchesInGit = [ short ]
+                    self.p4BranchesInGit = [short]
             else:
                 self.p4BranchesInGit = branches.keys()
 
@@ -4259,7 +4259,7 @@ def run(self, args):
             os.makedirs(self.cloneDestination)
         chdir(self.cloneDestination)
 
-        init_cmd = [ "git", "init" ]
+        init_cmd = ["git", "init"]
         if self.cloneBare:
             init_cmd.append("--bare")
         retcode = subprocess.call(init_cmd)
@@ -4271,9 +4271,9 @@ def run(self, args):
 
         # create a master branch and check out a work tree
         if gitBranchExists(self.branch):
-            system([ "git", "branch", currentGitBranch(), self.branch ])
+            system(["git", "branch", currentGitBranch(), self.branch])
             if not self.cloneBare:
-                system([ "git", "checkout", "-f" ])
+                system(["git", "checkout", "-f"])
         else:
             print('Not checking out any branch, use ' \
                   '"git checkout -q -b master <branch>"')
@@ -4404,7 +4404,7 @@ def run(self, args):
 class P4Branches(Command):
     def __init__(self):
         Command.__init__(self)
-        self.options = [ ]
+        self.options = []
         self.description = ("Shows the git branches that hold imports and their "
                             + "corresponding perforce depot paths")
         self.verbose = False
-- 
2.34.1

