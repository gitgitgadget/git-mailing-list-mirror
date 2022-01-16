Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A18BC433EF
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 16:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiAPQHg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:07:36 -0500
Received: from mail-mw2nam12on2081.outbound.protection.outlook.com ([40.107.244.81]:55521
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235564AbiAPQHb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 11:07:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YH0T/xKODfBzIuHwkUJS4/5h882MfBh1wAd62M0TX26xchjDDZrqCsOZmT5a8gDJEp4EqOcs21VUMvfUR/Uq0bgvrjxScs1zgORJR5z1E6G5VuXQCfYjSsC/wF3+vXYPvQHRzpAcKpcg3tYTmt0qqyufIEkVNqzVICrL8s61CCPTUDXzb5etz28HbdrX4lPcqlRhJi/NkvWxPvayA95aM3RX6EYjVAu3UulFIe4E61rVuyPkPINtN1PqAPzHeH1STN0bmhIzSnuqjNxdDfOoW21xH2td8YoJ2TP+r9YTahkAyAkLtYD57COJr/sRKgPox1uabosClLBwUKk1PuuHcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXEZ0BDGkOSlm5I07VmCDH/KL37uBRlAg6JaxnwMqFQ=;
 b=jqd1bKQFVM4aO+kylYDgu1M6/nsWFti8MTjRwgU3ftAmCm0Pa5UnWPxb8Nvnhb4yJZacUF2bASviPdfGFu2nfPEG0JNIZ1zBkWqqgcA5GhkVVKTu/g+q0sa0Ff5qek1mJnc0q/tXsK5d5JdDHkQNFZYJNRR6im6OhIXPY2BTuoaX8O7lh5q/nSKLiBw2FIi0e0LoaWLANaMpduCl5HwnwQabeugXishcVHM17qkrXKzycoMYPy7QI2IojEOaLGCzBZpEq4rdl8S0sgHSCzYG9IVKg36eIJUGgOa9PzAhZCRWF6xAwTEln3XR1jeAn7QrVUhMGDLLryxtE5yWlFExOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXEZ0BDGkOSlm5I07VmCDH/KL37uBRlAg6JaxnwMqFQ=;
 b=WyCabOTzq60yAKfyKDBkHy54GjvaQjFrLB+NO9hHevzNqqIXi3tK2YyVdcs+qgkPb/PTJ1l+/DcX7Xmfwwf4sfP6F6TBdNTMDDKwHZSVydwqSrdAjYOFWJIhUXy962/j/NpOIeJoIMKEH7tUI5NwXqBoMo3sP6z4jkax9e6YWi3ysCW7tPhivvkAlG0ERGrmDfiUbzcJLhsVSh2IprtKMAJgVQGAVVxHEqxVV3Dj5YLYrR4j5W5Sx02jWFrzA/o49OOSdLe3cvIbomNeGpbEvtNt30qmu+5Y5hPFhr3aR5rsQbqz8cmutKyvCWAqNAW9uilwomKPBJT8rOpsuhRHzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BYAPR12MB2597.namprd12.prod.outlook.com (2603:10b6:a03:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sun, 16 Jan
 2022 16:07:29 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 16:07:29 +0000
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
Subject: [PATCH v3 08/21] git-p4: remove padding from lists, tuples and function arguments
Date:   Sun, 16 Jan 2022 16:05:37 +0000
Message-Id: <20220116160550.514637-9-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0dfc9c74-0d53-476c-f5e1-08d9d90a4bb7
X-MS-TrafficTypeDiagnostic: BYAPR12MB2597:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB259771EEF5089E424B34F27DC8569@BYAPR12MB2597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +DOJMHcvwv++NdfwdkyCX3F8zcoLY7U720c4yt8IKzLf7XMuWPSLJDwC76j+yVgVVLcvGXenEndd9gTEGf2WZdKgQeNI+mydBNnMlFZtj5vF4EuMBONGj3zfYtzfQ35mQI1KJPb4awL2CVYx8kbD37exO/whTf1VZrNqrfDTRHiPpUPuz1HwvyPgvzSMF3n4mQaqqg9SbyUzWwo5+uA2+3ukgsnkHoMRvD4v974yzlTGtBRR5MLuMEglrIinduhwhlNTKir4VU8TeHFwcnQroRltFVYgFNM+I7LMk/fTgggCsL6mqYZdO+8ye/qfT/SH9QKMoF9vDR4tq946xgRc/Q2Tw0wSXdhkHcN1w7EDF/QVrOouyBgUlqJwvzuob+SH3tOr2giEcyOhg0yyZ0Aa7stL9LMf5DciOwig1FKBz6FBnvDVsfaGqbZqv/g7QTrD9rD+g1zn10o4xxXDaxzHELxW6sPzSbzC6G27XSLmbWTgV+ZUjzdODIpwsJmSkq53DDJUrlIjbADljydjz9bkpmumgQRXh5WIyvTBUolaLrSJ3LeeECwb7bGLD7ej2jzKfTdQ3u3zEGjEepDNHxMZVFqaapFQKTn7BjIS0Wum5C+Ft9EMVZQNScDlf+tadNuddwAK+FwqI5DIgqA6ZnSfHQPMDLXPCF7rkdolQPYfSwbdCgjZXAhEZFrEeOxOA1cm7OGbGxj/17lX1hRtMQhWi/hGdBASRocKmtQHLSuveKYShHhucZwVDzQOXELS+BehRn9LjvgXBgPTddKpjn99QuMceAuTt4CkgTJDY6mTsa0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(966005)(38350700002)(38100700002)(8936002)(4326008)(83380400001)(186003)(1076003)(6512007)(110136005)(54906003)(107886003)(8676002)(5660300002)(19627235002)(316002)(66556008)(66476007)(55236004)(6506007)(52116002)(86362001)(36756003)(508600001)(66946007)(2906002)(26005)(7416002)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oNZWsDUwtUgGJgxizPM4q0ITDqSVQfzdtTTtWKUHvymB9tYJyt5mQtKb6nDH?=
 =?us-ascii?Q?pr2lkF9oIH9TA0MCFs10lcn+2M5Gkz31OsA+4PB6Fm+R3KjED69xfamOlIZD?=
 =?us-ascii?Q?NSjIUEhaVxaU4PfNCz9p3T5P+WKyP7CzBykEW7N5QRm+ipUEpa3iUozFrp4D?=
 =?us-ascii?Q?aWp26gGc75I9JhPI58do0/XlfT2qXJt+0Nw4cvdaonf/+Y9Y5L8DdIGVJ1Vg?=
 =?us-ascii?Q?VVzTcwRdiTtqDFds2RpP02HcYp7ZpJDX4LPyACBKeGvuUlNGCinSsUuyGXz/?=
 =?us-ascii?Q?DxcIB5gZSnTtEhq6gt5JjwSw+4nUzjBFRfwbT7Mt9Wmt2zLfDbCsfRRGIAPy?=
 =?us-ascii?Q?0kGrfgfmmnN+ug9ufYCUhl8G+SOFk1044ZTC8DwsLgyMLZcFc7h8jDa9eii8?=
 =?us-ascii?Q?8BsGtsfwYtV/YJl0cTJLU0Iu1saDMEbIbTVse4neTSfsct1pBF6U25PmSv2+?=
 =?us-ascii?Q?tpGCQnPTCy7nvPf4iesNZ/o6+syBM3tZTiqDWWZcGqhD9N94MNM/0rW/5L5a?=
 =?us-ascii?Q?hosbbQ4jHRk/eIOv+4l5701lnLdlrxmP3Mx3vcH1fqBEXlLr2AT+XbHB0BxJ?=
 =?us-ascii?Q?1fh/kkcfKlS5fyfr0wegfyo6g/LiRsTulW/Ec2C5WvS56LoPK5AhU1xmrzfy?=
 =?us-ascii?Q?d/0TGI1cYaUpDFKV7NcnHRk/oGxv6ziKV36XMNBpMf4FRsn9nq+tKnE0mIbz?=
 =?us-ascii?Q?wkd8T0hNhOJbClHPrE3RG285E5FlLFhEzxDFI7SbXDhQ3iLvXzhjtVayXoVc?=
 =?us-ascii?Q?pANoeeV0g4UFeykgn5uRGelrtCJCLnbEzA+v5zC3hoFeruYz7aKo2m4Tw2k2?=
 =?us-ascii?Q?HnHBXBmru/Qqd9lOhbX3m6SSNPR9Pg1nTTQQ86jQrTXxhIrxc5BrYY5qiLwv?=
 =?us-ascii?Q?qlMF0hITnP28hZq+6ben9CKD/a/UUQ48jEca/zAsnUfxjcjt3QSbVHxa+VjR?=
 =?us-ascii?Q?uiiWRNlkbqtSp8m13oMCUB0xOGtI84Jb1DGx7faqgRggTIOohxhYczdswgRY?=
 =?us-ascii?Q?tn5jujoGqUCt8C2gfP+0opvH2Qx6re0Ifq+xnWo+tyzde7gvpa010bgNtwpU?=
 =?us-ascii?Q?tzq1T7SgaLIG+GkT9v7xSLXrJ5nDr/tYQLNsx807fNWDYX7zbdehv6CDZm9W?=
 =?us-ascii?Q?GL5HVS5g5Ng6ML7+u+phKCNPLCQUnL4boiwK58fiVbNrOOJOn1LwvT1RUzBk?=
 =?us-ascii?Q?ld/eZY9tHZQDAWoTrAdlobXIZygBwbtKOg9RSjI6i3sIiRwMn051XhkEPZzh?=
 =?us-ascii?Q?cKe8QIG9C7aztxx80dtmnlcXEQejs2y9StCIWJxV0EJ7ZmLi1nmEhhwvRtFJ?=
 =?us-ascii?Q?DL/ILCpniNsZ1tYk0ZSBfOxZSQdS/6S82Ya3S+uttg+qE/qOxz/FxEDwt/2R?=
 =?us-ascii?Q?zFyyL++sIxICZsNoT3u6MNBGcCfkouOksQe+E1N589OOOqlRlsRhsTOm/08V?=
 =?us-ascii?Q?t6Zz1f8xkRNqFnklQLsJKIVn1dKXj7OKxeNliKy8SbqUT/r8VZFXa1yWFs5i?=
 =?us-ascii?Q?evtFOIhFew6Id+lVpw91iYgPA6BQx4wQu7Qf2ZFDHhWJu0u/y7JR/hejpx5q?=
 =?us-ascii?Q?dp/mMCegc5rmyJ0Bt3OMPUwKDkPCQNLnOrgWDHZRzbsKSaaydkKMGOV9jKeB?=
 =?us-ascii?Q?sHTP/xJIR3rTLunSa2BgvoQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfc9c74-0d53-476c-f5e1-08d9d90a4bb7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 16:07:29.4133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o79WWh+rB0hJRACkvaTqBO64hUlQDrvfSbNC8Q8A6PrT70anT/Fctf+b/KMoNPx21zp6cbyV2occc+ptEAH8lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2597
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
index 814a92c5fb..df15aaf9d4 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1010,10 +1010,10 @@ def gitDeleteRef(ref):
 
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
@@ -1032,7 +1032,7 @@ def gitConfigBool(key):
 
 def gitConfigInt(key):
     if key not in _gitConfig:
-        cmd = [ "git", "config", "--int", key ]
+        cmd = ["git", "config", "--int", key]
         s = read_pipe(cmd, ignore_error=True)
         v = s.strip()
         try:
@@ -1088,7 +1088,7 @@ def p4BranchesInGit(branchesAreInRemotes=True):
 def branch_exists(branch):
     """Make sure that the given ref name really exists."""
 
-    cmd = [ "git", "rev-parse", "--symbolic", "--verify", branch ]
+    cmd = ["git", "rev-parse", "--symbolic", "--verify", branch]
     p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
     out, _ = p.communicate()
     out = decode_text_stream(out)
@@ -1304,7 +1304,7 @@ def getClientSpec():
     client_name = entry["Client"]
 
     # just the keys that start with "View"
-    view_keys = [ k for k in entry.keys() if k.startswith("View") ]
+    view_keys = [k for k in entry.keys() if k.startswith("View")]
 
     # hold this new View
     view = View(client_name)
@@ -1570,8 +1570,8 @@ def processContent(self, git_mode, relPath, contents):
 
 
 class Command:
-    delete_actions = ( "delete", "move/delete", "purge" )
-    add_actions = ( "add", "branch", "move/add" )
+    delete_actions = ("delete", "move/delete", "purge")
+    add_actions = ("add", "branch", "move/add")
 
     def __init__(self):
         self.usage = "usage: %prog [options]"
@@ -2579,7 +2579,7 @@ def run(self, args):
                     sys.exit(1)
             except Exception as e:
                 print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nThe hook failed "\
-                    "with the error '{0}'".format(e.message) )
+                    "with the error '{0}'".format(e.message))
                 sys.exit(1)
 
         #
@@ -2784,7 +2784,7 @@ def map_in_client(self, depot_path):
         if depot_path in self.client_spec_path_cache:
             return self.client_spec_path_cache[depot_path]
 
-        die( "Error: %s is not found in client spec path" % depot_path )
+        die("Error: %s is not found in client spec path" % depot_path)
         return ""
 
 
@@ -3082,7 +3082,7 @@ def streamOneP4File(self, file, contents):
             else:
                 if p4_version_string().find('/NT') >= 0:
                     text = text.replace(b'\r\n', b'\n')
-                contents = [ text ]
+                contents = [text]
 
         if type_base == "apple":
             # Apple filetype files will be streamed as a concatenation of
@@ -3704,7 +3704,7 @@ def importChanges(self, changes, origin_revision=0):
                     for branch in branches.keys():
                         ## HACK  --hwn
                         branchPrefix = self.depotPaths[0] + branch + "/"
-                        self.branchPrefixes = [ branchPrefix ]
+                        self.branchPrefixes = [branchPrefix]
 
                         parent = ""
 
@@ -3812,7 +3812,7 @@ def importHeadRevision(self, revision):
             if info["action"] in self.delete_actions:
                 continue
 
-            for prop in ["depotFile", "rev", "action", "type" ]:
+            for prop in ["depotFile", "rev", "action", "type"]:
                 details["%s%s" % (prop, fileCnt)] = info[prop]
 
             fileCnt = fileCnt + 1
@@ -3966,7 +3966,7 @@ def run(self, args):
             if branch_arg_given:
                 short = self.branch.split("/")[-1]
                 if short in branches:
-                    self.p4BranchesInGit = [ short ]
+                    self.p4BranchesInGit = [short]
             else:
                 self.p4BranchesInGit = branches.keys()
 
@@ -4248,7 +4248,7 @@ def run(self, args):
             os.makedirs(self.cloneDestination)
         chdir(self.cloneDestination)
 
-        init_cmd = [ "git", "init" ]
+        init_cmd = ["git", "init"]
         if self.cloneBare:
             init_cmd.append("--bare")
         retcode = subprocess.call(init_cmd)
@@ -4260,9 +4260,9 @@ def run(self, args):
 
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
@@ -4393,7 +4393,7 @@ def run(self, args):
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

