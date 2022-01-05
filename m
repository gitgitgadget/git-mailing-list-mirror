Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1302C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 16:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241887AbiAEQPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 11:15:37 -0500
Received: from mail-dm6nam10on2068.outbound.protection.outlook.com ([40.107.93.68]:55777
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241882AbiAEQPa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 11:15:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6VASpwxTUsYCfweH5Fb5qaKURynzBYPfOCSv7/wdq62D3wsT3wHf4POnSr5Mw39ly1QYWrZpYoKlm4wroZn9mNH6AHZWFq3z1LmM4/HINQygFjWKIZwwLLyz+ePtSeCXCHWE4elh/Feo2dBYVIRzJjracDkwTkTDX3UaLSmlMW1YhGKUyIRMxBLxeQQrmX/rkTJo3vtpLn49MTt3nrvbRpFPReHCr+wB/YfpfB48OrRXsJi9uTWw+UbHePNUPeGJXdGpfEZF24vtBsCw276ZmcCTaWp/dEwsU2DGAJo4AdpIXneHho1r0MPILK6rhWIaWaTuAU4MQte41kbyN+i3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbAC/VpIh1XBdrrl4WOTTtD3ltSLaVc5AQltem0/XPM=;
 b=FRv9XDZjBtmzAFPfAcFZi+pqRYcjnVAXytPlZkOQW4rXBF6+pKODarAB5xCDg7beya2JoI6EgQMT6YSS4oakU8dLKSCS3DFLWnfxTE2TD8B0IVgmleQHQjgHyZAk/gE2VVJCA4L7+X6rlc9UmM3/WU+gz2uojX0lAwIpnMhVbpKKd8hemSa8pfVwi7brqT2KOI7IHQ0rxhGkueHuThABC8+lO5n5Q2ZzdWN4TnKNogpf6fl2k2BvpTNRZxo8vQXmTuAe58y7ZEXw+pdkKHBswoezky9YEOaonA5lROol/+VUOdbL51vk0T+PbmB6Vq6JTUdolW69SuO+J6LJF30klA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbAC/VpIh1XBdrrl4WOTTtD3ltSLaVc5AQltem0/XPM=;
 b=DMejRUK2/8+ayDrkkdr0UN8V235JCMd9gFLPenz8/RPmFO03IHjKKl7JKUYavvLbVVaVJY01GuN7vac3PQMUyGuJP7LkPL4ISOcr1ZqA6Zjoi1ZsQ5o/ccAeVuObUiLHZHnpWMaj7JIs7482KdxsQPvLVeSe7A6NyXnZyLp8xxXSo3mE7fDDWcAmIbx/itlp4Pu7w3zrK7Jzq7S/7WfKb78SY8OKrVjgclHXib321E1Qw3xTveK4buIq9dbPVVEXXNE2aH9k+0USdgPooHQJ/Z1mWriMyp1/GblfmwRwvPmFfj7RMbkwiIjI0efFP/mLKOM6FLx3sKjnmq6YFRoAzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 5 Jan
 2022 16:15:28 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6%5]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 16:15:28 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH 2/3] git-p4: pass command arguments as lists instead of using shell
Date:   Wed,  5 Jan 2022 16:14:50 +0000
Message-Id: <20220105161451.56378-3-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105161451.56378-1-jholdsworth@nvidia.com>
References: <20220105161451.56378-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P192CA0025.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::38) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e3ced6c-9b24-4c42-3231-08d9d06696b1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4423:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4423D27F88642EA3E5612752C84B9@MN2PR12MB4423.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:462;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NMDilLfCDNggF14Bq8ZstJkqKnognC8VSFKXNgDzfNFNDjQSMDSHU1QSa9jAAXFf//aNXmDAAkXH5ah8EhivX9BxaFlmUPB5LtdX21JG66k/d1nJDGn1b9qGXDadzgDy3ezdmqHUv/LcM2LF/b+j6BAZjDBLtCkFzokhUBKYPrJlVZWN3LafWpYOm1n21+EosPSnTlL7WC2t+opIVOXU1vTodJMpq0gPB3jOXZNA9cz0+G0RBRLtYU4EdTScvRT6zUVCELIIu5QvpniFjA+O4IK74EPYLzT89MOYpi8fsOwTBadWgP0d3wFzTpvP+C+Jk/WWM2KFAuspnulSG8JFRnWoitIBjWAcj1TgjZAsIT5oDEYKIiRo+u0YhDmfWvFSXAZAxWc86pG1FmFAeHnBTJCgHVNpdzKZMOM/Y59SLAYhmR+qZWrxWOFlB8Z54gY4XKgcak/FKi91iIzEKPbY0nifUvp0FkYVfm0OtSWeH45oM88UIvrxkJxEkyScHk4tJpHgdo6wS+58nimMvzcxUMMWsuCVyH7aJaIp1i/uYaGk8P3x53jqh74ee3noLxa4Oitoryg09BNwxlr1nfmU2BbtYiH5qYiXj3y9vh4RUSZH4RiWugXt/sHlKts7buSRgPY53fEZV7Ac5a6axuf2mjIkme1Hxmao6L407cgLFcsfG3QzxvZMWm03nQLaB1YJ8KS7sAhhBhPBJbnUQYyRFhQnVnXR+sgQjBbeHIBPsjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(6666004)(30864003)(66556008)(2616005)(1076003)(38100700002)(54906003)(4326008)(316002)(66946007)(110136005)(6486002)(186003)(66476007)(36756003)(38350700002)(7416002)(55236004)(6506007)(86362001)(52116002)(107886003)(8676002)(83380400001)(508600001)(26005)(2906002)(6512007)(8936002)(403724002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HmAYYWjAhoAx2u489qrORyifUcziOQ6/kEkI/58FSHMTl4WnjWLRu4//V+ID?=
 =?us-ascii?Q?F8St6XSrYdoPGzOyBTaG+DMskeSn3s9UZVqFIx2pFIa+RDXCxQMOBfzUEF2W?=
 =?us-ascii?Q?SnfD9nyzF2QJ0gb1AQgoAnMtjl6gqWH0glVlappqFVd303EScU0s1Hj+5Jm/?=
 =?us-ascii?Q?zADLih90zi/4mRryRmRzhj40AERpdBpSGL+oStXegrF8zFPFO/5qOvKSI7j6?=
 =?us-ascii?Q?JdHbPnuYaIoik89kS2dx2G+IrCG28OcOwPtBkP7DRmyDammehKy2vhamJso6?=
 =?us-ascii?Q?7yGtth2pJNd1ih5jabPgffNi4f1FxsjQzhcINByP7Pp3zlYnyCHgQbGaHQSZ?=
 =?us-ascii?Q?qq5WGZGIGUpxSBRb+9XJRBaQVhA2xD1KcN9l/KS1Y6ITyGp8aHrvutfeo1hR?=
 =?us-ascii?Q?mnzGBjYg2rHdUo4yTbXEGjuQyF/rpGYflmdt6416v4OlxfnDJ11Lf/tk12ov?=
 =?us-ascii?Q?z/tnlpn+liOwY8godta09ZMLB4EOqnlbABM5/AgaflCyWOOufwZHnE7Ur7Vr?=
 =?us-ascii?Q?toKUgRKrMB4uUOLMo8u8ume7Vm9X0uoT/NUfaISuIoIvBmMCR3MKBOLXG5M9?=
 =?us-ascii?Q?/BgfoqR+JV4c6UVkPof1194n+pUGtdTWsBAg65YdwAb6ooJo9tqJbOL7M/pA?=
 =?us-ascii?Q?/JF135cGX+KRGhJIOpYY69QHHmYxFAGKiGkuVgaSrZwMWFY/wmmUSBMDN9te?=
 =?us-ascii?Q?kF/b5MmrVJA6HzRQ1KKO6SgE9p2wdGismjQ1X12nebqpdSZ+mfjkxXzVp9z+?=
 =?us-ascii?Q?1MxhUxE60xCWqTCNu42iJUONWtk5lzG2sV5CmeNXVTUWk2EBW4v6jdImIlL0?=
 =?us-ascii?Q?CWQE+nnzOxmZHLH7tf88KzVT8v529DYB3aGViMcg1T8go4toA2io2jLxJK4H?=
 =?us-ascii?Q?zg8+h8yQclXBiCFsFjCn6ZSzfkjBmzIDBu/hfA+hdhn71PjibOCXR3/Zi7tG?=
 =?us-ascii?Q?hrlP0PhAY86WsJFI0J+ZUEwh9V7JQavy/wd9DjJuG0IO4mpUHaBCuZEhjMkr?=
 =?us-ascii?Q?fzXSwhgff3NKkQfySpGupdfCYb1oap+t1Bz7ooHGeDd9EYYgDdQePYHjgHNU?=
 =?us-ascii?Q?zgRIZL2d+pnzcfSYFdI81l74VRYeLihd7SKkeuAzNVawgJ4he1JOUTCjLMR9?=
 =?us-ascii?Q?MSuyJs64mrmJcCNg+hcz+yVM3OpsVySoQseT6198Mo6w3A3j7xV7JtxJqlpL?=
 =?us-ascii?Q?IF+UFcEPFF63fusuUjSP0jxndF8mA1uSFfr5kpHD2dNoYtZvinR5FcN/lufQ?=
 =?us-ascii?Q?u+kP9haeU3er4cio1sPUYlsX14dFVCI6ZmYdPgk6sIb/pfKJcVecAC1soe5M?=
 =?us-ascii?Q?Gp7KvFz6RIZooGkLClWZd0k2KcSq1iTce7W3NuIKn8wGuZVQkYR4+v/qgZJB?=
 =?us-ascii?Q?b/Nzln4S+W4aaIFg6maZnmTw0X/vcxDjMKVZiGtp+UgSRcScJqz7NoR7Rsux?=
 =?us-ascii?Q?gCyNNCjyPuCNcvocr1UPFp8RRnt0+wcE6CPSsIg5nbW1aGQV4HLmHUgrMu2h?=
 =?us-ascii?Q?hHKCLY5Hq1nUC++2lb6isN+Xi2WeXRpFVUZQMmeN1lp5auaOJIt/IrRqjRUV?=
 =?us-ascii?Q?6Or8KZtm5Od0rQC1u0mqZ24RUSZ9tuuXr6LdWENfWaA2PchAj2ROPzDXb49N?=
 =?us-ascii?Q?TUMtSDv9zh+QQTEaFjIUiak=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3ced6c-9b24-4c42-3231-08d9d06696b1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 16:15:28.4322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zq9vA5Pj27TPCZgd5o35SSPorbwqkJKe6CSxYVc8PdCVghO8ds3ViMclgCp17MuBPPeXsqRTwto+wHLyUeCIOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the majority of the subprocess calls where shell=True was used, it
was only needed to parse command arguments by spaces. In each of these
cases, the commands are now being passed in as lists instead of strings.

This change aids the comprehensibility of the code. Constucting commands
and arguments using strings risks bugs from unsanitized inputs, and the
attendant complexity of properly quoting and escaping command arguments.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 105 ++++++++++++++++++++++--------------------------------
 1 file changed, 43 insertions(+), 62 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 6a6aa4e928..7c1f238a56 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -108,10 +108,7 @@ def p4_build_cmd(cmd):
         # Provide a way to not pass this option by setting git-p4.retries to 0
         real_cmd += ["-r", str(retries)]
 
-    if not isinstance(cmd, list):
-        real_cmd = ' '.join(real_cmd) + ' ' + cmd
-    else:
-        real_cmd += cmd
+    real_cmd += cmd
 
     # now check that we can actually talk to the server
     global p4_access_checked
@@ -733,12 +730,7 @@ def isModeExecChanged(src_mode, dst_mode):
 def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
         errors_as_exceptions=False, *k, **kw):
 
-    if not isinstance(cmd, list):
-        cmd = "-G " + cmd
-    else:
-        cmd = ["-G"] + cmd
-
-    cmd = p4_build_cmd(cmd)
+    cmd = p4_build_cmd(["-G"] + cmd)
     if verbose:
         sys.stderr.write("Opening pipe: %s\n" % str(cmd))
 
@@ -861,7 +853,7 @@ def isValidGitDir(path):
     return git_dir(path) != None
 
 def parseRevision(ref):
-    return read_pipe("git rev-parse %s" % ref, shell=True).strip()
+    return read_pipe(["git", "rev-parse", ref]).strip()
 
 def branchExists(ref):
     rev = read_pipe(["git", "rev-parse", "-q", "--verify", ref],
@@ -967,13 +959,13 @@ def p4BranchesInGit(branchesAreInRemotes=True):
 
     branches = {}
 
-    cmdline = "git rev-parse --symbolic "
+    cmdline = ["git", "rev-parse", "--symbolic"]
     if branchesAreInRemotes:
-        cmdline += "--remotes"
+        cmdline.append("--remotes")
     else:
-        cmdline += "--branches"
+        cmdline.append("--branches")
 
-    for line in read_pipe_lines(cmdline, shell=True):
+    for line in read_pipe_lines(cmdline):
         line = line.strip()
 
         # only import to p4/
@@ -1036,7 +1028,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
 
     originPrefix = "origin/p4/"
 
-    for line in read_pipe_lines("git rev-parse --symbolic --remotes", shell=True):
+    for line in read_pipe_lines(["git", "rev-parse", "--symbolic", "--remotes"]):
         line = line.strip()
         if (not line.startswith(originPrefix)) or line.endswith("HEAD"):
             continue
@@ -1074,8 +1066,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
                               remoteHead, ','.join(settings['depot-paths'])))
 
         if update:
-            system("git update-ref %s %s" % (remoteHead, originHead),
-                shell=True)
+            system(["git", "update-ref", remoteHead, originHead])
 
 def originP4BranchesExist():
         return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
@@ -1189,7 +1180,7 @@ def getClientSpec():
     """Look at the p4 client spec, create a View() object that contains
        all the mappings, and return it."""
 
-    specList = p4CmdList("client -o", shell=True)
+    specList = p4CmdList(["client", "-o"])
     if len(specList) != 1:
         die('Output from "client -o" is %d lines, expecting 1' %
             len(specList))
@@ -1218,7 +1209,7 @@ def getClientSpec():
 def getClientRoot():
     """Grab the client directory."""
 
-    output = p4CmdList("client -o", shell=True)
+    output = p4CmdList(["client", "-o"])
     if len(output) != 1:
         die('Output from "client -o" is %d lines, expecting 1' % len(output))
 
@@ -1473,7 +1464,7 @@ def p4UserId(self):
         if self.myP4UserId:
             return self.myP4UserId
 
-        results = p4CmdList("user -o", shell=True)
+        results = p4CmdList(["user", "-o"])
         for r in results:
             if 'User' in r:
                 self.myP4UserId = r['User']
@@ -1498,7 +1489,7 @@ def getUserMapFromPerforceServer(self):
         self.users = {}
         self.emails = {}
 
-        for output in p4CmdList("users", shell=True):
+        for output in p4CmdList(["users"]):
             if "User" not in output:
                 continue
             self.users[output["User"]] = output["FullName"] + " <" + output["Email"] + ">"
@@ -1622,7 +1613,7 @@ def __init__(self):
             die("Large file system not supported for git-p4 submit command. Please remove it from config.")
 
     def check(self):
-        if len(p4CmdList("opened ...", shell=True)) > 0:
+        if len(p4CmdList(["opened", "..."])) > 0:
             die("You have files opened with perforce! Close them before starting the sync.")
 
     def separate_jobs_from_description(self, message):
@@ -1726,7 +1717,7 @@ def lastP4Changelist(self):
         # then gets used to patch up the username in the change. If the same
         # client spec is being used by multiple processes then this might go
         # wrong.
-        results = p4CmdList("client -o", shell=True)    # find the current client
+        results = p4CmdList(["client", "-o"])        # find the current client
         client = None
         for r in results:
             if 'Client' in r:
@@ -1742,7 +1733,7 @@ def lastP4Changelist(self):
 
     def modifyChangelistUser(self, changelist, newUser):
         # fixup the user field of a changelist after it has been submitted.
-        changes = p4CmdList("change -o %s" % changelist, shell=True)
+        changes = p4CmdList(["change", "-o", changelist])
         if len(changes) != 1:
             die("Bad output from p4 change modifying %s to user %s" %
                 (changelist, newUser))
@@ -1753,7 +1744,7 @@ def modifyChangelistUser(self, changelist, newUser):
         # p4 does not understand format version 3 and above
         input = marshal.dumps(c, 2)
 
-        result = p4CmdList("change -f -i", stdin=input, shell=True)
+        result = p4CmdList(["change", "-f", "-i"], stdin=input)
         for r in result:
             if 'code' in r:
                 if r['code'] == 'error':
@@ -1859,7 +1850,7 @@ def edit_template(self, template_file):
         if "P4EDITOR" in os.environ and (os.environ.get("P4EDITOR") != ""):
             editor = os.environ.get("P4EDITOR")
         else:
-            editor = read_pipe("git var GIT_EDITOR", shell=True).strip()
+            editor = read_pipe(["git", "var", "GIT_EDITOR"]).strip()
         system(["sh", "-c", ('%s "$@"' % editor), editor, template_file])
 
         # If the file was not saved, prompt to see if this patch should
@@ -1918,8 +1909,7 @@ def applyCommit(self, id):
         (p4User, gitEmail) = self.p4UserForCommit(id)
 
         diff = read_pipe_lines(
-            "git diff-tree -r %s \"%s^\" \"%s\"" % (self.diffOpts, id, id),
-            shell=True)
+            ["git", "diff-tree", "-r"] + self.diffOpts + ["{}^".format(id), id])
         filesToAdd = set()
         filesToChangeType = set()
         filesToDelete = set()
@@ -2405,17 +2395,17 @@ def run(self, args):
         #
         if self.detectRenames:
             # command-line -M arg
-            self.diffOpts = "-M"
+            self.diffOpts = ["-M"]
         else:
             # If not explicitly set check the config variable
             detectRenames = gitConfig("git-p4.detectRenames")
 
             if detectRenames.lower() == "false" or detectRenames == "":
-                self.diffOpts = ""
+                self.diffOpts = []
             elif detectRenames.lower() == "true":
-                self.diffOpts = "-M"
+                self.diffOpts = ["-M"]
             else:
-                self.diffOpts = "-M%s" % detectRenames
+                self.diffOpts = ["-M{}".format(detectRenames)]
 
         # no command-line arg for -C or --find-copies-harder, just
         # config variables
@@ -2423,12 +2413,12 @@ def run(self, args):
         if detectCopies.lower() == "false" or detectCopies == "":
             pass
         elif detectCopies.lower() == "true":
-            self.diffOpts += " -C"
+            self.diffOpts.append("-C")
         else:
-            self.diffOpts += " -C%s" % detectCopies
+            self.diffOpts.append("-C{}".format(detectCopies))
 
         if gitConfigBool("git-p4.detectCopiesHarder"):
-            self.diffOpts += " --find-copies-harder"
+            self.diffOpts.append("--find-copies-harder")
 
         num_shelves = len(self.update_shelve)
         if num_shelves > 0 and num_shelves != len(commits):
@@ -3376,12 +3366,9 @@ def getBranchMapping(self):
         lostAndFoundBranches = set()
 
         user = gitConfig("git-p4.branchUser")
-        if len(user) > 0:
-            command = "branches -u %s" % user
-        else:
-            command = "branches"
 
-        for info in p4CmdList(command, shell=True):
+        for info in p4CmdList(
+            ["branches"] + (["-u", user] if len(user) > 0 else [])):
             details = p4Cmd(["branch", "-o", info["branch"]])
             viewIdx = 0
             while "View%s" % viewIdx in details:
@@ -3472,9 +3459,8 @@ def gitCommitByP4Change(self, ref, change):
         while True:
             if self.verbose:
                 print("trying: earliest %s latest %s" % (earliestCommit, latestCommit))
-            next = read_pipe(
-                "git rev-list --bisect %s %s" % (latestCommit, earliestCommit),
-                shell=True).strip()
+            next = read_pipe(["git", "rev-list", "--bisect",
+                latestCommit, earliestCommit]).strip()
             if len(next) == 0:
                 if self.verbose:
                     print("argh")
@@ -3630,7 +3616,7 @@ def sync_origin_only(self):
             if self.hasOrigin:
                 if not self.silent:
                     print('Syncing with origin first, using "git fetch origin"')
-                system("git fetch origin", shell=True)
+                system(["git", "fetch", "origin"])
 
     def importHeadRevision(self, revision):
         print("Doing initial import of %s from revision %s into %s" % (' '.join(self.depotPaths), revision, self.branch))
@@ -3797,8 +3783,8 @@ def run(self, args):
         if len(self.branch) == 0:
             self.branch = self.refPrefix + "master"
             if gitBranchExists("refs/heads/p4") and self.importIntoRemotes:
-                system("git update-ref %s refs/heads/p4" % self.branch, shell=True)
-                system("git branch -D p4", shell=True)
+                system(["git", "update-ref", self.branch, "refs/heads/p4"])
+                system(["git", "branch", "-D", "p4"])
 
         # accept either the command-line option, or the configuration variable
         if self.useClientSpec:
@@ -4001,7 +3987,7 @@ def run(self, args):
         # Cleanup temporary branches created during import
         if self.tempBranches != []:
             for branch in self.tempBranches:
-                read_pipe("git update-ref -d %s" % branch, shell=True)
+                read_pipe(["git", "update-ref", "-d", branch])
             os.rmdir(os.path.join(os.environ.get("GIT_DIR", ".git"), self.tempBranchLocation))
 
         # Create a symbolic ref p4/HEAD pointing to p4/<branch> to allow
@@ -4033,7 +4019,7 @@ def run(self, args):
     def rebase(self):
         if os.system("git update-index --refresh") != 0:
             die("Some files in your working directory are modified and different than what is in your index. You can use git update-index <filename> to bring the index up to date or stash away all your changes with git stash.");
-        if len(read_pipe("git diff-index HEAD --", shell=True)) > 0:
+        if len(read_pipe(["git", "diff-index", "HEAD", "--"])) > 0:
             die("You have uncommitted changes. Please commit them before rebasing or stash them away with git stash.");
 
         [upstream, settings] = findUpstreamBranchPoint()
@@ -4044,10 +4030,10 @@ def rebase(self):
         upstream = re.sub("~[0-9]+$", "", upstream)
 
         print("Rebasing the current branch onto %s" % upstream)
-        oldHead = read_pipe("git rev-parse HEAD", shell=True).strip()
-        system("git rebase %s" % upstream, shell=True)
-        system("git diff-tree --stat --summary -M %s HEAD --" % oldHead,
-            shell=True)
+        oldHead = read_pipe(["git", "rev-parse", "HEAD"]).strip()
+        system(["git", "rebase", upstream])
+        system(["git", "diff-tree", "--stat", "--summary", "-M", oldHead,
+            "HEAD", "--"])
         return True
 
 class P4Clone(P4Sync):
@@ -4124,7 +4110,7 @@ def run(self, args):
 
         # auto-set this variable if invoked with --use-client-spec
         if self.useClientSpec_from_options:
-            system("git config --bool git-p4.useclientspec true", shell=True)
+            system(["git", "config", "--bool", "git-p4.useclientspec", "true"])
 
         return True
 
@@ -4255,10 +4241,7 @@ def run(self, args):
         if originP4BranchesExist():
             createOrUpdateBranchesFromOrigin()
 
-        cmdline = "git rev-parse --symbolic "
-        cmdline += " --remotes"
-
-        for line in read_pipe_lines(cmdline, shell=True):
+        for line in read_pipe_lines(["git", "rev-parse", "--symbolic", "--remotes"]):
             line = line.strip()
 
             if not line.startswith('p4/') or line == "p4/HEAD":
@@ -4341,11 +4324,9 @@ def main():
             cmd.gitdir = os.path.abspath(".git")
             if not isValidGitDir(cmd.gitdir):
                 # "rev-parse --git-dir" without arguments will try $PWD/.git
-                cmd.gitdir = read_pipe(
-                    "git rev-parse --git-dir", shell=True).strip()
+                cmd.gitdir = read_pipe(["git", "rev-parse", "--git-dir"]).strip()
                 if os.path.exists(cmd.gitdir):
-                    cdup = read_pipe(
-                        "git rev-parse --show-cdup", shell=True).strip()
+                    cdup = read_pipe(["git", "rev-parse", "--show-cdup"]).strip()
                     if len(cdup) > 0:
                         chdir(cdup);
 
-- 
2.34.1

