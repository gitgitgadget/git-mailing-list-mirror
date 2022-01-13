Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE48C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbiAMNsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:48:25 -0500
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:26926
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235485AbiAMNsV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:48:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7HrS5sRSgRYbbN6Ctqx1MGTy6b7YDmSnUuL1VTen3gNMJz6NFm6Nn9TfHGvdPMo6GWgo+Ur5WA6SuV3gb4T94VJNJUeyvEMRRtfFmtObDUS84jx62AJPoDX0tL8SUsrZcrpJozXNbROUZ0JgDjt6xC54yv7nbFD/V66AD4KI9oBkv45+oWSsK12EKaBWyUur5NmlwmzCeSKoDC1CVs2rgP3lNMNwszy7dh5syO7aNVjoZ7s+1/2425uBghNK4w/lGPEsWyr98L8IpjimMqFhpoVlCbBFHLKpADEtlgSgzQVnj8yVoFtwqRhccDaIJmvvPVZYVCFHtQJfImZ3St/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihtF2ERONrVeP757tprI+DeSmg6qkw1b/ySl2Kg+oME=;
 b=LLIWSPz4MhG1GX3qVpiU8aW5Hw78+a7ipOn3xQtrxF5ACQ5Ss1P1IZEg9B7HNfNeJgcOcjwkJUUTwUFmxqbBUda0Drv5J3/Vr6PrPhjv+Yf43qUsgnPmVt+qaW22DgbDPc+SIPkyiOkvu9mBOZsdNeUp+qp/P4mX06eTKhsWzdOhFYLqHbJLJTYLm3ql6wiIxBo5tmYm8IoMe133s8dt1CtzAanTH3oLyM5gGfGxeUJgEfjeJ0yD120Flj4dAJ5uavBHIy5cRYN8ItQ2u/BnJQpZZnZYA9kTIja3DeNKo31vtUf49cHo9L5uSeQgIKwwGPCXBVk6DwhBhOc92I/qzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihtF2ERONrVeP757tprI+DeSmg6qkw1b/ySl2Kg+oME=;
 b=f2MuJ3atKKJWmP6gsyT489aRmw8NHRC+QwxzeZADU8ibfP6WvbDZQfJVBf39lzczJiV3Tn7Vd+2gxTvTwJaoLL7mpzomMid338Y3lbGeG+9In2R5lWS86bkkfFdZqfVkQ4rqrD1wZAnONKcI56DfesFofD1hRFRDLFkSDUJHhlVs1nhZFZJL3HtXT2CcJ40d7K6ZlEGVSvdhPN/4PTXjFOyDuDHOy5rXlqXGpVoXpbAIm1OWOSESSTNb4xwI2CGDu75X1FQZYLhXrgkLV4V+Q0LJskZmLio3DwoiMf0JeDjz2N0z9bWFBXIY7D6qGr5yYvWkl8ERnhl2O+F+qw2b0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 13:48:14 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 13:48:14 +0000
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
Subject: [PATCH v2 08/21] git-p4: remove padding from lists, tuples and function arguments
Date:   Thu, 13 Jan 2022 13:47:15 +0000
Message-Id: <20220113134728.23192-9-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113134728.23192-1-jholdsworth@nvidia.com>
References: <20220113134728.23192-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0101.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::42) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 580c5b16-d2ad-4062-3ef8-08d9d69b5879
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB24475AE42F99BEBC0D3E06C1C8539@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D09hbXRz14GSa2AwmeHncdK/+zOZ+qN1LC4PrG4DF/R67EJ6QXAPKsII0UnjeOV6elxIhBKAVf9SNVyjQ9b8A594m1TitMteKbi+9H2v4m4OxSdVIm1Upv68yweNp4exWBczy3m5scuOJEhstb5tcRtSNc2M2sGq4p5rCMbrqzUQTiQ+isQHbKTomKazqxaJSG9RFmII8JL7v0Ki1IE/DvGdRZOMImlam3QeqTeY2XjagC9KwtOzLOVPic+ON69qkHEYxP3E06SjTPoi41eZzAjclrx358AUmFSL5Ak6aN4s3N7Fh10qcSmcQeVcI8gQb9jSzJyh37iDAhGVpyMF31T1f4Jx7/CNgz0hwNKLGBXgMSMxNQr4eaE5QaFJVZOpOtbeHcIL2m5uQDGZHSJ11qiTih9fQOXYATI+5u3b7vt1oiJsUKwyp0tbWSlzyuVRdORheAUncmlsDjTYN4hlQUyPIxJaNP7EAUpodke206BP4Bkfj5TSEyIcygMCzrzGaBK3yUXaA2m6B6sYLMLS/L4DYHnx7ffcDJZwJ9uqAYoW7vD6jJEszO92A8ZN0bnCb3nbeC+q7yWmE0O4vjEV85QWBgoIlEHvJyfmibPqAH5m6pWCLpvmGNWBqmXRn6J1ZIAfzw2fAo/wNhHl4eC57i3D/XnBFvobMrA63TNCw6FRJ2pXbC1gTe7YX/q3iX248ZL4G8To98eqpnICSSyrL9f4wNMJsX1SG1lLJfXem8Uj+39T96UlwLr6dP7Lu5sxdkACOLHehA4PQQsZ+sfJ9HsD4v7HR/GpFVMpa3tRDKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(1076003)(8676002)(66946007)(8936002)(26005)(83380400001)(19627235002)(55236004)(2616005)(4326008)(107886003)(6512007)(36756003)(6486002)(186003)(54906003)(316002)(38350700002)(110136005)(38100700002)(7416002)(966005)(508600001)(66556008)(5660300002)(6506007)(2906002)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+4JQ/ZLar9vubkE8w9iwLMWvOjIoY0ybY0i9mUutZ6kPo7oPFqBI6wetSDhr?=
 =?us-ascii?Q?PsoAUoYG8Fgird2xTXhAMqIjihaUU2f70va4O5k9yBJWOA8c/HlassqEvQEV?=
 =?us-ascii?Q?IRfS8QuB/+cOggXVE+ANYnhXhJrpNQzG4OKHb4kJ9/ns08n8wnsXf3/PI3H/?=
 =?us-ascii?Q?BExVsEoxabK8lJs8HsGeo5inzHgD83YxTXiN4m95B7p2EOYAd9oBPZ+b0Z8J?=
 =?us-ascii?Q?FtBSgXlsp+zLzhISaAOkjKyZT1+j9BT18kKBFagUjiMqMZ6+NDBgtnHRaUFg?=
 =?us-ascii?Q?yGfJ+6cwJbUFPAt3VjPkdeb2HK8Lw40AEODJjy81iO04d9vMSfJAe6RoFotW?=
 =?us-ascii?Q?k0fYSwmSWXzMeoT7GuBDCMrN2QDXu2SeE7I6kkWTsjoB74W560f9JtwA/RaT?=
 =?us-ascii?Q?6Mjau1Hg4VruelEyBlJeECt2XzA/ekFy70K0pu8N4Mo9JYmGbcKDHx7l8QcH?=
 =?us-ascii?Q?yNN1L7sQLLR6mzxgixxZb6cRQZ/LAlEra4mv6hKXUqmTtAOLkfDMiN9j4Phg?=
 =?us-ascii?Q?5gEQTvbYKHjINDdJMPY0r6O9bPn+rIv5N1GDwxMpkEDJV0PcGCWWS2QVGdm+?=
 =?us-ascii?Q?lw9pyK8Vgf666EsXAOKTOXrCad/shoXRupQNs3JTvUtu1h+fT6Z8yYeQH2zd?=
 =?us-ascii?Q?oZq7t3HyQj7vQ04aDtYIufdMmwVs9R2A1NMDBgicmbmUG9JYUp+4oWzjyh32?=
 =?us-ascii?Q?xpvJ0ZjL7cy3YyMbQXoNK5dtXkFChEQE1FHo/3wtWbEL7u6lhUFBPXP0b3sa?=
 =?us-ascii?Q?BRWPvaCJlSbG8fZIodnLQZnQ7kBGxHFBHTgEGVtWT4Fv3uJin066lE3+Epz4?=
 =?us-ascii?Q?owuqzxClhU+69FC9NtrwujpiKbkzV8+FJmp2Ch6s4MncaSnuno40uoD4mS0c?=
 =?us-ascii?Q?V5cIgZiPEGsEioxO8mIGFucMAFcENdl72fKZlkbO5ZHQwcsB7Cc15dzQJoCw?=
 =?us-ascii?Q?tkZaN3/qm7gTYylF08G1ObPUPDdB0gSUPsyiaAfvWqvPmgypce0EXZFKKE+8?=
 =?us-ascii?Q?PakX/7HL/+gxi0j7xB1prYD08svPF8/NgIXXKDNTexoL94NgXig7ksTPXtkg?=
 =?us-ascii?Q?86ilfV7WqoFehcKXzxmKT0csYvRGAMtPGHfAnsI0wWbdTU+mA4Gz8KnENkYB?=
 =?us-ascii?Q?8uq4JPFCmUqd1ZpbcAiqAltyW7M0R7n55tGwApjc6LDlk9zN9V/miceTFiSf?=
 =?us-ascii?Q?rk4srq2Buz8sjgx62LDw3F5uWUp0PYPVpZnKWcZ4yT6nbohfLEcABBKINDqQ?=
 =?us-ascii?Q?QOQvO9ID8GqumnjdceUmeAs8vHdkmj457SGsg82AnrxGdSxu0/8VfDgw8FRZ?=
 =?us-ascii?Q?t3/Gya9NgNTNpOAGpgYW5k7EcKaLEOo08H+7wMfsWv8/80oqEsISwlibXkuA?=
 =?us-ascii?Q?bjwfRrZvUy6di5hJUVPSKpuFF6FTDkMzO4WYxMF2xd5s60UzIV0CrxNYo4lI?=
 =?us-ascii?Q?IjxwYtG633fZOrhsSwS5ePDTatlE9CGhMUwIrc0tHLOYNZRRVsL8qm2rgriQ?=
 =?us-ascii?Q?jlP0659MUfLIYeW4Ml7TPJyZesG08am9koZEpUtXrfv+5HYxlm44YGKew0NB?=
 =?us-ascii?Q?H/gQDOG99eL3NbI6S4dxdi/ioRHKDGV7RnJAF2+198IBXxH4rbwKmzV3s6Rj?=
 =?us-ascii?Q?AnTZQlhhfdTLHx9vUTMxpms=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 580c5b16-d2ad-4062-3ef8-08d9d69b5879
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 13:48:14.3813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKZPZfPOBKm6z8R42ihHcFauSXodVs/O4eBglHjmZaTg+SHWRPdrTttHeASWjV0I9adp+hj6BY3l1XyObibC5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
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
index 1560ad372c..e3898a7e28 100755
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
 
 
@@ -3096,7 +3096,7 @@ def streamOneP4File(self, file, contents):
             else:
                 if p4_version_string().find('/NT') >= 0:
                     text = text.replace(b'\r\n', b'\n')
-                contents = [ text ]
+                contents = [text]
 
         if type_base == "apple":
             # Apple filetype files will be streamed as a concatenation of
@@ -3720,7 +3720,7 @@ def importChanges(self, changes, origin_revision=0):
                     for branch in branches.keys():
                         ## HACK  --hwn
                         branchPrefix = self.depotPaths[0] + branch + "/"
-                        self.branchPrefixes = [ branchPrefix ]
+                        self.branchPrefixes = [branchPrefix]
 
                         parent = ""
 
@@ -3828,7 +3828,7 @@ def importHeadRevision(self, revision):
             if info["action"] in self.delete_actions:
                 continue
 
-            for prop in ["depotFile", "rev", "action", "type" ]:
+            for prop in ["depotFile", "rev", "action", "type"]:
                 details["%s%s" % (prop, fileCnt)] = info[prop]
 
             fileCnt = fileCnt + 1
@@ -3981,7 +3981,7 @@ def run(self, args):
             if branch_arg_given:
                 short = self.branch.split("/")[-1]
                 if short in branches:
-                    self.p4BranchesInGit = [ short ]
+                    self.p4BranchesInGit = [short]
             else:
                 self.p4BranchesInGit = branches.keys()
 
@@ -4262,7 +4262,7 @@ def run(self, args):
             os.makedirs(self.cloneDestination)
         chdir(self.cloneDestination)
 
-        init_cmd = [ "git", "init" ]
+        init_cmd = ["git", "init"]
         if self.cloneBare:
             init_cmd.append("--bare")
         retcode = subprocess.call(init_cmd)
@@ -4274,9 +4274,9 @@ def run(self, args):
 
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
@@ -4407,7 +4407,7 @@ def run(self, args):
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

