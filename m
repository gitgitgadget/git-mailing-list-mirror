Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE3BC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244722AbiBJQrV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:47:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244717AbiBJQrN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:47:13 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5EFE9B
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:47:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwQIRQgr/jlvp7yu/QeNh13s23EKy83+qEDOycDI5GwvTgO+kbOKxQTNOZThvuVc13GYdddCeAg8YGNAcYl7VivJzm6X/FF37yVPpDG3qrL46oRvkOF1CNrW40QX105JYSBiVFEzRFgISK+kmolpDIXHVUGSsL2fArvHWWNO4VhWk/XEMvLkfm0d1Oe5rpnVpq7M9QKUJo9EZWofY283zgoxplpjXaWRb0ZGECPwnmafMASrtdNvdt6m6HqZdM++onMcp3OdGImJQO68jPSHfYxwplApfV3hslhL2bi1yJ6AOB75PbVrGcGvtxt63Tn4Rm4nnEGwXMpJXj+CeIPRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XpKwVsRstRtGI8XnK86JlZoieqv0v8iIDDONzsWvrM=;
 b=LXb3ueEKnNspYUelDtfSM9DVYI6+TgynEtfAEFaDUJV+GXms4QZzjUdIwgzJBNXQJRlYI65rauEh7AuC/DtVFoRWLbtiuh5phZSjChlHsUv/V6cYRO5jS2oidq/OfG/HBlhEI/z7TD6UR5M4z2xexuOyHkvhLYYU2dW6llnnXpJqTSD+nw5lO0MA8auoY5LZpPQ8EgWh6jFS744Y5DFLMJ6Cd2CddwzgUF46jk3EZtlon/vLrzC/+WS9xZsW6UKdI7t6oBS7Kxx1OZuMgs9zee0kSIZMTiA3Tn/s4lhEnDQRn9lASIxTjrPht9S4uM6xjBxxkLBrj3pwUlMQK6KGow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XpKwVsRstRtGI8XnK86JlZoieqv0v8iIDDONzsWvrM=;
 b=lTKn43CDTucEPcfJS5PsH/B3oO33Y2ei0+tfvCk3LrvP68OoCqxcnAujw0NEO2wJ7fJ0WDRND1onTmpxixR3qEUODpBGHCLyDu6eE6TRNm7jT+HJAV++Kodf9DiRlDIfjU1i/0U3FmfHcRrVxO3h9jIImptZZ3Jz+IkjMrPqM/UZiQjqIIUg7emu/USUIG26YV5z75h1sSxYNkEQcDygAo9TvEQ4cmOxQHGdEM9zBSo+dfwLvP11VQ42JPtRT3EowuB/dqa2ONCdrqQ3u6qbLMpVRbnUWW+QvD1airAt2aQFfuVG1kRozwJrkcpEDkn04Lonlwhjfhlkxyzk7Sy4WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB2421.namprd12.prod.outlook.com (2603:10b6:4:b4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:47:09 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:47:09 +0000
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
Subject: [PATCH v4 08/22] git-p4: remove padding from lists, tuples and function arguments
Date:   Thu, 10 Feb 2022 16:46:13 +0000
Message-Id: <20220210164627.279520-9-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: e552f5b0-743f-467e-2407-08d9ecb4facf
X-MS-TrafficTypeDiagnostic: DM5PR12MB2421:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2421DF82C64A76867B1EE0C9C82F9@DM5PR12MB2421.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JHtNhHs/wwP8VH4n71cJo7FLIGYBm3Td6CDgrq5hDD+ScUzenP7XiOsFRPVEwIAn6Nk2lH2dBwJXUGfpSS6iNExYMJEgEA1T2L2+h5RMgaBZnodAGRMbx9bVKfTfVe+tf0q2fuPxAut6EYDYRlAJoHs5FoKmwZhFv6IhVAgCuVoophD1C8nhyA1s9Q+XxU0maf6UgB0IVw9X9bZXv85wE1f+AR/G5ZMLmJLvA808o2ZUOb8UL0FcYpWxjNr5CDjr/K/d2+7Acc59kYbEWtZNcj51tf4PBfYvVFsMDL3MFJ06cKuuDs25/XvHsY5rvJFg+rYnWe7TYVd3h7iWY84dz0vGgBQ45/UXBk1Z4LiSVr0xDRI0YrplfPEyPIUKjss3qkfa8bpSSqWoJcNLaHy7dt63x94uji4DVYGVNjyVlO3k2vafSBytGOe0XMFH2X8PvjCo9hfZ72ZqgksB7CRlV5sCfbICGaH/t1fYugO/O0mPbfRxV0JVt94D1oV0HGp0OwLATVzBU6AouNjaE/tjWdMmSm63NFOimYvu9jCUuAxoUO+doSsW4yGRWw5+zk7ugeN1qH9UFUk/25jvy6hRRoG5wBq/c26IrwdPIrnlz0ArMVew/DmGL0rOAz9zJrgUXN9bqn4vjvhtHmS1NuQqhEoBKRupSGCqHpm4qMJVySI4r+vfY2OLETDFEaoNrUyQ0rUh2zpXOykCzuwvyiQxZvw3d3ykXAo9+09NadNjxEoI3JrnC7gFa0Ue/ZD5hltYcovsJx2bRX21XHgbeL7uYfSbcUqJcn3dv4Jb4vqA4Es=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(2906002)(52116002)(86362001)(6666004)(508600001)(6486002)(6512007)(55236004)(6506007)(186003)(8936002)(8676002)(66556008)(66946007)(7416002)(19627235002)(5660300002)(110136005)(1076003)(316002)(4326008)(36756003)(966005)(54906003)(83380400001)(66476007)(2616005)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Eq3EXslNoi8GEO1st2rbPO02B5YnP9svJy4RC2irhxebfSqnANO4kGCgfUvq?=
 =?us-ascii?Q?ppi4pIxEWxzpeVqbAB/NlR6bYNpvyT51+8AZ81Mr8aZLdJy9Q79uwD+dxZnQ?=
 =?us-ascii?Q?i2oF468No7v8RWELatOpEAxCC/igH+e3lUQg8HCTRw1k1Zw5/nbYvHWdQgW6?=
 =?us-ascii?Q?beQguFo1K0NmwM3FcXttZGYYftqCfRjGaksV243WvdDeoQZjfYfmKsOt82nx?=
 =?us-ascii?Q?TDkHB0ekqmvIwdlg/5UlLblhEq+2ZwlqSvaLacmjYsdK0PAaRx/YqQfQzAj2?=
 =?us-ascii?Q?V8bpqz/+z4GSNCYoDS05gbd6An+yyBQXuSoZLLmIsULKS0MSNZzK1lY9sA1m?=
 =?us-ascii?Q?avgXBv+KOL7BthWgEmzuE5WAx8euT3TWw2xMBAO9bPp+4iPY/XtdcefX5Pow?=
 =?us-ascii?Q?V+utsIPTOkewpAMdoXKu1VjtjUA5yhZui4mJA+iOCKOzk887c3CYTpmj8N/5?=
 =?us-ascii?Q?RThVbVLpTEt0jlJvxrQ67/91Kok+1ulc2XE/AFW50+JL/DjDoqK1IWZTCrHi?=
 =?us-ascii?Q?/zt7+X0lh4P6cOIBEuLzkoNMDwhKlCP/SCQSUP/om61i+LtNE+7Zq+NBagDv?=
 =?us-ascii?Q?btFJIHj4UIBOMAe0+ucPrrLLB8bXufa1jVZDIGoE33ZQOz3qSeslp3o3F4h2?=
 =?us-ascii?Q?G68DMH7fx8tP/6OSk7iIKBygYrz0OjWT3jztT1lePukSTRSIAo+B+W6IgoEz?=
 =?us-ascii?Q?ZAG0eaOyOuBK7Xcu6rfHeRG8CGQFvu8UkYJ4Y69pM5XCYZoOOblfUrytxY7A?=
 =?us-ascii?Q?ur9HNGuBJpeEw58MK5NkmjmOftFpj6ycBBEqvxKiTism3mtjEiE4JQdH0Pjx?=
 =?us-ascii?Q?3kiP98AmUGyWiv13JDndcna6Fsg0xBwtcTaBQeL6A2ZWHjT4/HaFAcn46zgm?=
 =?us-ascii?Q?M6lRxoi79yNKqmgSiEQjDWjTN0x3zQi/VxApn4U5yj56HMgDHXrKOv9ApMEW?=
 =?us-ascii?Q?SXml8POa0u+BOdj+9Y/BCnxe4l0EgjpOnnAPcL6tjMEVYIdk4J/DaP0BQM+R?=
 =?us-ascii?Q?MpEkdTA6UaPDc0P5B2g5NQwJMVl2sY8vrBWIyMQTsR7n5pUo/U3KPSnKMhpR?=
 =?us-ascii?Q?Fvt6ATkmkVVz4s7cHLnjtjR/3RU7H2pYa4344WwO2VHDu1gmoUYJE6jsNEQh?=
 =?us-ascii?Q?fBxOZG/QlAfJKP4KJJS6I6Bdp7HbHZEoTPPRWmnHMX/+lIz8PXajBMBtLFf3?=
 =?us-ascii?Q?+KMN3xnfeFd+xGSXcgTkDGMok3wfWAcOGwpsI5GjgFonVvH23kB9Tz+3H0xD?=
 =?us-ascii?Q?ZIyhWR1ZbnNcPgaZJga2NFSYBblZMblErfsGBI0L8iNQ+f1k9BWFKBlgv+pB?=
 =?us-ascii?Q?KXWCJgVBlwc5bleChbN6cNXJRrTw7/Om/OatJMk3LbT8E/bnF1hs2lg7Kghw?=
 =?us-ascii?Q?o4EJd45rylAPBEw84vk0cCZokdQaNaLZi/BMzYf+pERtMGE3VGOqOI5d//AP?=
 =?us-ascii?Q?O+6LxsVAfI62/Z0PNLmrbWPZOBDDZMAycSHcn4VhhtawXz3a9642jSSAomP+?=
 =?us-ascii?Q?FMepG76qev4z02i4KM8SkMIpBL78d5ULx0XotwGvwdU+gNnjzisITF+P7Jcj?=
 =?us-ascii?Q?8kE8Ss9KcnvSDHqbOmmVmKSkm5gvADmT6Y2REW7S/aFxMp016S+cR/QbHqik?=
 =?us-ascii?Q?4Eb6FbENySFjuWAP70c0asE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e552f5b0-743f-467e-2407-08d9ecb4facf
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:47:09.7814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MFTjdF/IXhU2/DEyYi6aOUX7SL5C7Pj32V4QSR7yGKV/hQnjh6rzLSXJsOdOukrg0xgIZGtukq9QR96oLbyxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2421
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
index 52c4cac683..f8d07cfd7f 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -952,10 +952,10 @@ def gitDeleteRef(ref):
 
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
@@ -974,7 +974,7 @@ def gitConfigBool(key):
 
 def gitConfigInt(key):
     if key not in _gitConfig:
-        cmd = [ "git", "config", "--int", key ]
+        cmd = ["git", "config", "--int", key]
         s = read_pipe(cmd, ignore_error=True)
         v = s.strip()
         try:
@@ -1030,7 +1030,7 @@ def p4BranchesInGit(branchesAreInRemotes=True):
 def branch_exists(branch):
     """Make sure that the given ref name really exists."""
 
-    cmd = [ "git", "rev-parse", "--symbolic", "--verify", branch ]
+    cmd = ["git", "rev-parse", "--symbolic", "--verify", branch]
     p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
     out, _ = p.communicate()
     out = decode_text_stream(out)
@@ -1246,7 +1246,7 @@ def getClientSpec():
     client_name = entry["Client"]
 
     # just the keys that start with "View"
-    view_keys = [ k for k in entry.keys() if k.startswith("View") ]
+    view_keys = [k for k in entry.keys() if k.startswith("View")]
 
     # hold this new View
     view = View(client_name)
@@ -1512,8 +1512,8 @@ def processContent(self, git_mode, relPath, contents):
 
 
 class Command:
-    delete_actions = ( "delete", "move/delete", "purge" )
-    add_actions = ( "add", "branch", "move/add" )
+    delete_actions = ("delete", "move/delete", "purge")
+    add_actions = ("add", "branch", "move/add")
 
     def __init__(self):
         self.usage = "usage: %prog [options]"
@@ -2521,7 +2521,7 @@ def run(self, args):
                     sys.exit(1)
             except Exception as e:
                 print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nThe hook failed "\
-                    "with the error '{0}'".format(e.message) )
+                    "with the error '{0}'".format(e.message))
                 sys.exit(1)
 
         #
@@ -2726,7 +2726,7 @@ def map_in_client(self, depot_path):
         if depot_path in self.client_spec_path_cache:
             return self.client_spec_path_cache[depot_path]
 
-        die( "Error: %s is not found in client spec path" % depot_path )
+        die("Error: %s is not found in client spec path" % depot_path)
         return ""
 
 
@@ -3024,7 +3024,7 @@ def streamOneP4File(self, file, contents):
             else:
                 if p4_version_string().find('/NT') >= 0:
                     text = text.replace(b'\r\n', b'\n')
-                contents = [ text ]
+                contents = [text]
 
         if type_base == "apple":
             # Apple filetype files will be streamed as a concatenation of
@@ -3646,7 +3646,7 @@ def importChanges(self, changes, origin_revision=0):
                     for branch in branches.keys():
                         ## HACK  --hwn
                         branchPrefix = self.depotPaths[0] + branch + "/"
-                        self.branchPrefixes = [ branchPrefix ]
+                        self.branchPrefixes = [branchPrefix]
 
                         parent = ""
 
@@ -3754,7 +3754,7 @@ def importHeadRevision(self, revision):
             if info["action"] in self.delete_actions:
                 continue
 
-            for prop in ["depotFile", "rev", "action", "type" ]:
+            for prop in ["depotFile", "rev", "action", "type"]:
                 details["%s%s" % (prop, fileCnt)] = info[prop]
 
             fileCnt = fileCnt + 1
@@ -3908,7 +3908,7 @@ def run(self, args):
             if branch_arg_given:
                 short = self.branch.split("/")[-1]
                 if short in branches:
-                    self.p4BranchesInGit = [ short ]
+                    self.p4BranchesInGit = [short]
             else:
                 self.p4BranchesInGit = branches.keys()
 
@@ -4190,7 +4190,7 @@ def run(self, args):
             os.makedirs(self.cloneDestination)
         chdir(self.cloneDestination)
 
-        init_cmd = [ "git", "init" ]
+        init_cmd = ["git", "init"]
         if self.cloneBare:
             init_cmd.append("--bare")
         retcode = subprocess.call(init_cmd)
@@ -4202,9 +4202,9 @@ def run(self, args):
 
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
@@ -4335,7 +4335,7 @@ def run(self, args):
 class P4Branches(Command):
     def __init__(self):
         Command.__init__(self)
-        self.options = [ ]
+        self.options = []
         self.description = ("Shows the git branches that hold imports and their "
                             + "corresponding perforce depot paths")
         self.verbose = False
-- 
2.35.GIT

