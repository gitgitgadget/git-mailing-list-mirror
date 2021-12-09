Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7064FC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 20:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhLIUO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 15:14:27 -0500
Received: from mail-mw2nam10on2076.outbound.protection.outlook.com ([40.107.94.76]:37985
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229478AbhLIUO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 15:14:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPWYA8CWLf3Z+w7vvtNuEEcmM+6g2BPLk32oonCSUR/JF8PpDJuxegoooKJ/KCJJHd5P2QLODZTVJAOD1T+rmaqpBew4Ajs2l36bsXSS31fwY0OzRpNZQcGa39U7/k6IJUJyifvLje/Qf1aTZj7+nd4nKf/JDTOY7UiCmK7JVbXTIb3wbfMC8ynbJh7QwhvbWR4EPAX37zZmltHvDqLPoKJzPdXTxgP9O4fMstrOfCjNtkBePZPD9foqOObHIhjhLfbBclcLm9+mEMbhYSe/hoFAcLKpRNCgAu5p+fdG+1VyMyDvhO68B8HlJUzSgwIuBV14hBeDWhT8dn3V9NzDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5Q/jvD9s8TZ8GYI76ogtmuGWp2pplvIna+VYS0VmRg=;
 b=Cq3inGK0wDkyhRcA5eaCb2MgluAGbV/4OL2zHdWUJv9ObhTXd62f7JgDppPsDfgFafQb2/Q1BPvmOIG1c0uZ534y3j/DENDU9eQ/r/UaGJ92Z6a1YEcY7g/gP6aVZ3E5CSoWX65Bhtyc+hDgDZc93kn9GuRfXX1nVy/99gVnRB5XbkDVUWHUFpFZAOw3i2+5QKnWuKSNxWg9qa0udyQ2g/jslI+7NUrMqSR+riqBO5EsL6XC3Hdy17/PdAY8jdlPNrVbSzgnf9ZMnrYo7U1/iOwBjTAvTjUjfENVaViHnG10f6gRrCc2E5XXIWWKPtDV6Z1xmMJPd3Tp4yii5mnSLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5Q/jvD9s8TZ8GYI76ogtmuGWp2pplvIna+VYS0VmRg=;
 b=o4/H7K7/yJcitjUmEj2asWPWXC2WDro9SDTo10IDJe/6CylnbgnvIo67TnCjlEX8lHm0dhkoFWttkya43ouaN0TxGycN5dPPV18KWS9Jz0pV1PePZOGbRJsy4YvSDbXzkwg71MzzjoE/nhMbyjw9SRjxo+6+thfGvnSFT/cIk6FOxa3AbBNV03/MZV3DP+aoaZqll3WIF9txN8xD/Ii6N1E/Uw1qCA4K82O4la7Jm6Sa9VfvepJ1od+TbaFsTwMIMbLR0HbllNDbA44OXN9pn03fx28gRKchUjA4y+SGR15lyxc9OU6SADgFSo/ws+ZETE+mXRQhmxIsje50Mgq1yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN8PR12MB3282.namprd12.prod.outlook.com (2603:10b6:408:9e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 20:10:51 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4755.025; Thu, 9 Dec 2021
 20:10:51 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org
Cc:     Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH 1/6] git-p4: Always pass cmd arguments to subprocess as a python lists
Date:   Thu,  9 Dec 2021 20:10:24 +0000
Message-Id: <20211209201029.136886-2-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209201029.136886-1-jholdsworth@nvidia.com>
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0012.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::17) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
Received: from red.nvidia.com (195.110.77.193) by AM9P195CA0012.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Thu, 9 Dec 2021 20:10:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1965a3d0-8692-4865-e33e-08d9bb4fff2a
X-MS-TrafficTypeDiagnostic: BN8PR12MB3282:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB32821C59121A07174E2BC998C8709@BN8PR12MB3282.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:462;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oGLmLDqBbh5PIvQ6XbEc05jx5u8C/6VOZvp+TTdkkjgKKl4a6ohIdPGQYaolPFKIbYqAmyK0RkIgVs5fOQFDUdnix/iDPHPnKsr7C83rrLxhmTjMfvxjHLxoY/bGNuIcCfqftwVHTd726ylxBQ/foYeoGAAGEtkijyT0pV1N4BddXAKKUIqO158mwkDYUZ+VVwpaXobLuG31C18Bq9B/IJ1+MGYCtuwsUeXpHrDD/nP9VeIKSgRYqnf7u8ug++lJOtkXF28Z5tX6uIhPi/blb9fOddCFR8n6VBIMsTGDsar/g9vKB6Gg8W2gS4nUL7sUWW9pkiHhjA5HGZWJvbm7bFZ0UQwq7xxafCTvOqsvkvB6vMItSznHKHOfruRkGvotDk1Yi31rJf4hDumsuQ/TWVbBBJ3eUGTnDWkyctRhYBPsQRILTybQvx1e7xVpKra2a/9gN8mftPla6zE7mdN2mqFzjphv6bayP+1LE3niKGLsweaIs1/qt5Nk+hlM+U72NmAhvHN5w5Z/queskWJp4BNf/FT+qRND5Q38sNSjnmXd16HaF4NlIaae8RDOz6wkL7Gp7J79c3Yp0VkW8P+lNDULAhRLyemvzUSgv4Grz/QSfbO4LMEAfOfizn182PihTMzJZXpxGJiE7TPlbFuKt9QduUyy+MF4YOQTOBWWAjCQ/qgHtkYLBCWOsF4RXlapgsXSCtgrLTU4OJMWKOvq8cXKuHtZQLD+QuoOWjupA/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(2906002)(83380400001)(26005)(316002)(6666004)(38350700002)(956004)(508600001)(5660300002)(38100700002)(6486002)(4326008)(52116002)(2616005)(8936002)(36756003)(66476007)(7696005)(55236004)(1076003)(66946007)(86362001)(107886003)(6916009)(66556008)(8676002)(30864003)(403724002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CuFDsgL5vKy6lUVIBQfrdjG4ZUYp/f0yNLae5ZrdsMrWMSA3YecByrt2NQ7G?=
 =?us-ascii?Q?aB8Ifrly0S5+Nf7C8Re+tQtvkC1NbfzbLGf7Kk6KRIxWKvTBvweljtEjZuB0?=
 =?us-ascii?Q?ZiLxyOJ+gwj/+fvix8SaXU1hKF30jp4d5z74DnGOgwKOnqQhtM/MYx8oVKvk?=
 =?us-ascii?Q?ARa6kjUtb47LPluNs+vkwrH23vSfbGA3spLR3PEDYTjOjnZvS6ftdUZRr0XQ?=
 =?us-ascii?Q?JGzk2tGcB44yIbrxBkuKPak1Cq9S8l5eLGQZ3q1POoUqRPSQwasA2LBWYUi/?=
 =?us-ascii?Q?Jsic82F9bR7OCCD62v8P8DzFNpU/tUwDKRyYPMwSeDS/zgNBdm0cEo5hc8yL?=
 =?us-ascii?Q?y/6IssIDqUZystjHQRJNWTrK5thCPqw59HQDDOc1W9VKMOZ7Z+WKzCKww36O?=
 =?us-ascii?Q?A0fw3i4El5Cael/5ymawmtW1ohXcd0go3C4zKIEmAOOat4RudFKNDws2Entz?=
 =?us-ascii?Q?FyiKetDQwQaMAu+4Z9ag1YSRiVERi62GsffNUaescl7iAVdqCsn47D/bCVBo?=
 =?us-ascii?Q?qoj519QUmekylUv0megM12+wobUTk3E1ABjtqAFYEdjDGNJeFcFN9lzUhKiD?=
 =?us-ascii?Q?xPdoX14yRCD9zq1OFJmpTtQphzbUiIVmbuDVJ9jDlOrD/fN9OeHJwl9+sKOx?=
 =?us-ascii?Q?MuddULtQVqwRi6pEADevkvJcQEZULNc1QiYRmMd24IS1Fmw76nQVLcWCYClo?=
 =?us-ascii?Q?wCmqSg8oq2+PEJpBxvb9GsZoJwgnMMB0RBtZJKTJzhT6aIVjIWqj+3yXb6aV?=
 =?us-ascii?Q?wKGk/rvKbWd0BUlVV+mYztsAKpDSnQHH05BsE/L37rtl+pd8+OU3b4VQwzAs?=
 =?us-ascii?Q?LflTN1XHUu9JwqBRqnXZKoHTjf+Z4ak8uGTtFIG126/vzb4GaYWrYYu9AeMd?=
 =?us-ascii?Q?7++YZv3YAIYz4Fqh6ngC+nt19Kv7++UcSqr++aCgoOl1M9Y2cTF0BaRweB8m?=
 =?us-ascii?Q?mjGljLXe1zQPrGEqI9qjwrmuxWrcNjoGmP+yTy7gPv3vkuGIliR8TmoNR9XY?=
 =?us-ascii?Q?WrPC8Tg55ngeuAuODLNMstPId2KVp9LWGEEmDmk0WYIGL59mKtqQgtseIcJQ?=
 =?us-ascii?Q?nmxsGoRvd/RY2SXMV6u5/T478bnk+9aMEla8sLGk5MUkcp0melR++08/4QS4?=
 =?us-ascii?Q?1ScD7341N+iemDJ8EZ4BkTLyzCFO1FBeFYSxm9JFbgNBVIhd7HgCdfUxG0bb?=
 =?us-ascii?Q?k3loMri05ez8tRYlLWwOC9yvFhOspsKdz4M19Z2f213SLyiIkZz2Yl6tK944?=
 =?us-ascii?Q?mX0E8nxXQ56KZlyTlEycLSQCEc9IK9Ov4cacL6iOGtyMWeGZ/4GBoO8iP05l?=
 =?us-ascii?Q?imH0O+bGy+SHOBFaVutrEGZW34F6rwSD/Q4v172n44QN3tKu6CuYLqh3fk2+?=
 =?us-ascii?Q?y5HqoGisbkC4htBXwaqvcXsTPOgGa/inWSn1/q8hU+xmfzu1zFt5r7GDNod8?=
 =?us-ascii?Q?S23grXJx7mizULPeUSDmbsROUy5GymrFRgVuW02pz7L6/tVZqAguWy7sQXaf?=
 =?us-ascii?Q?JnCIPQ+B5m9D+BVik7p8T9tA5jwNwrA3UfPpWbGEw2/cq0cykcUzM075VRkb?=
 =?us-ascii?Q?or8+p0Ynmq4X3KeflFyvB/UFojPic/TyhYXpIZ7Y7MNiJkwy3PKTeT/RKU/v?=
 =?us-ascii?Q?kipXVNfBCPFhwxM785cTFYI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1965a3d0-8692-4865-e33e-08d9bb4fff2a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 20:10:50.9435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JC7XXnFKYc6H36oPUotUCVDLMHNc8CIO2iVpJQFTHmKpqEGZDVpVFtTZWRGlmAvxe2mRn97YN6ggbDR3A1bFAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3282
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 138 +++++++++++++++++++++++-------------------------------
 1 file changed, 58 insertions(+), 80 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 2b4500226a..1a4b7331d2 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -93,10 +93,7 @@ def p4_build_cmd(cmd):
         # Provide a way to not pass this option by setting git-p4.retries to 0
         real_cmd += ["-r", str(retries)]
 
-    if not isinstance(cmd, list):
-        real_cmd = ' '.join(real_cmd) + ' ' + cmd
-    else:
-        real_cmd += cmd
+    real_cmd += cmd
 
     # now check that we can actually talk to the server
     global p4_access_checked
@@ -273,12 +270,11 @@ def run_hook_command(cmd, param):
     return subprocess.call(cli, shell=use_shell)
 
 
-def write_pipe(c, stdin):
+def write_pipe(c, stdin, *k, **kw):
     if verbose:
         sys.stderr.write('Writing pipe: %s\n' % str(c))
 
-    expand = not isinstance(c, list)
-    p = subprocess.Popen(c, stdin=subprocess.PIPE, shell=expand)
+    p = subprocess.Popen(c, stdin=subprocess.PIPE, *k, **kw)
     pipe = p.stdin
     val = pipe.write(stdin)
     pipe.close()
@@ -293,7 +289,7 @@ def p4_write_pipe(c, stdin):
         stdin = encode_text_stream(stdin)
     return write_pipe(real_cmd, stdin)
 
-def read_pipe_full(c):
+def read_pipe_full(c, *k, **kw):
     """ Read output from  command. Returns a tuple
         of the return status, stdout text and stderr
         text.
@@ -301,8 +297,8 @@ def read_pipe_full(c):
     if verbose:
         sys.stderr.write('Reading pipe: %s\n' % str(c))
 
-    expand = not isinstance(c, list)
-    p = subprocess.Popen(c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=expand)
+    p = subprocess.Popen(
+        c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, *k, **kw)
     (out, err) = p.communicate()
     return (p.returncode, out, decode_text_stream(err))
 
@@ -337,12 +333,11 @@ def p4_read_pipe(c, ignore_error=False, raw=False):
     real_cmd = p4_build_cmd(c)
     return read_pipe(real_cmd, ignore_error, raw=raw)
 
-def read_pipe_lines(c):
+def read_pipe_lines(c, *k, **kw):
     if verbose:
         sys.stderr.write('Reading pipe: %s\n' % str(c))
 
-    expand = not isinstance(c, list)
-    p = subprocess.Popen(c, stdout=subprocess.PIPE, shell=expand)
+    p = subprocess.Popen(c, stdout=subprocess.PIPE, *k, **kw)
     pipe = p.stdout
     val = [decode_text_stream(line) for line in pipe.readlines()]
     if pipe.close() or p.wait():
@@ -383,11 +378,10 @@ def p4_has_move_command():
     # assume it failed because @... was invalid changelist
     return True
 
-def system(cmd, ignore_error=False):
-    expand = not isinstance(cmd, list)
+def system(cmd, ignore_error=False, *k, **kw):
     if verbose:
         sys.stderr.write("executing %s\n" % str(cmd))
-    retcode = subprocess.call(cmd, shell=expand)
+    retcode = subprocess.call(cmd, *k, **kw)
     if retcode and not ignore_error:
         raise CalledProcessError(retcode, cmd)
 
@@ -396,8 +390,7 @@ def system(cmd, ignore_error=False):
 def p4_system(cmd):
     """Specifically invoke p4 as the system command. """
     real_cmd = p4_build_cmd(cmd)
-    expand = not isinstance(real_cmd, list)
-    retcode = subprocess.call(real_cmd, shell=expand)
+    retcode = subprocess.call(real_cmd)
     if retcode:
         raise CalledProcessError(retcode, real_cmd)
 
@@ -728,14 +721,7 @@ def isModeExecChanged(src_mode, dst_mode):
 def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
         errors_as_exceptions=False):
 
-    if not isinstance(cmd, list):
-        cmd = "-G " + cmd
-        expand = True
-    else:
-        cmd = ["-G"] + cmd
-        expand = False
-
-    cmd = p4_build_cmd(cmd)
+    cmd = p4_build_cmd(["-G"] + cmd)
     if verbose:
         sys.stderr.write("Opening pipe: %s\n" % str(cmd))
 
@@ -745,17 +731,13 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
     stdin_file = None
     if stdin is not None:
         stdin_file = tempfile.TemporaryFile(prefix='p4-stdin', mode=stdin_mode)
-        if not isinstance(stdin, list):
-            stdin_file.write(stdin)
-        else:
-            for i in stdin:
-                stdin_file.write(encode_text_stream(i))
-                stdin_file.write(b'\n')
+        for i in stdin:
+            stdin_file.write(encode_text_stream(i))
+            stdin_file.write(b'\n')
         stdin_file.flush()
         stdin_file.seek(0)
 
     p4 = subprocess.Popen(cmd,
-                          shell=expand,
                           stdin=stdin_file,
                           stdout=subprocess.PIPE)
 
@@ -860,7 +842,7 @@ def isValidGitDir(path):
     return git_dir(path) != None
 
 def parseRevision(ref):
-    return read_pipe("git rev-parse %s" % ref).strip()
+    return read_pipe(["git", "rev-parse", ref]).strip()
 
 def branchExists(ref):
     rev = read_pipe(["git", "rev-parse", "-q", "--verify", ref],
@@ -966,11 +948,11 @@ def p4BranchesInGit(branchesAreInRemotes=True):
 
     branches = {}
 
-    cmdline = "git rev-parse --symbolic "
+    cmdline = ["git", "rev-parse", "--symbolic"]
     if branchesAreInRemotes:
-        cmdline += "--remotes"
+        cmdline.append("--remotes")
     else:
-        cmdline += "--branches"
+        cmdline.append("--branches")
 
     for line in read_pipe_lines(cmdline):
         line = line.strip()
@@ -1035,7 +1017,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
 
     originPrefix = "origin/p4/"
 
-    for line in read_pipe_lines("git rev-parse --symbolic --remotes"):
+    for line in read_pipe_lines(["git", "rev-parse", "--symbolic", "--remotes"]):
         line = line.strip()
         if (not line.startswith(originPrefix)) or line.endswith("HEAD"):
             continue
@@ -1073,7 +1055,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
                               remoteHead, ','.join(settings['depot-paths'])))
 
         if update:
-            system("git update-ref %s %s" % (remoteHead, originHead))
+            system(["git", "update-ref", remoteHead, originHead])
 
 def originP4BranchesExist():
         return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
@@ -1187,7 +1169,7 @@ def getClientSpec():
     """Look at the p4 client spec, create a View() object that contains
        all the mappings, and return it."""
 
-    specList = p4CmdList("client -o")
+    specList = p4CmdList(["client", "-o"])
     if len(specList) != 1:
         die('Output from "client -o" is %d lines, expecting 1' %
             len(specList))
@@ -1216,7 +1198,7 @@ def getClientSpec():
 def getClientRoot():
     """Grab the client directory."""
 
-    output = p4CmdList("client -o")
+    output = p4CmdList(["client", "-o"])
     if len(output) != 1:
         die('Output from "client -o" is %d lines, expecting 1' % len(output))
 
@@ -1471,7 +1453,7 @@ def p4UserId(self):
         if self.myP4UserId:
             return self.myP4UserId
 
-        results = p4CmdList("user -o")
+        results = p4CmdList(["user", "-o"])
         for r in results:
             if 'User' in r:
                 self.myP4UserId = r['User']
@@ -1496,7 +1478,7 @@ def getUserMapFromPerforceServer(self):
         self.users = {}
         self.emails = {}
 
-        for output in p4CmdList("users"):
+        for output in p4CmdList(["users"]):
             if "User" not in output:
                 continue
             self.users[output["User"]] = output["FullName"] + " <" + output["Email"] + ">"
@@ -1566,10 +1548,10 @@ def run(self, args):
 
         if self.rollbackLocalBranches:
             refPrefix = "refs/heads/"
-            lines = read_pipe_lines("git rev-parse --symbolic --branches")
+            lines = read_pipe_lines(["git", "rev-parse", "--symbolic", "--branches"])
         else:
             refPrefix = "refs/remotes/"
-            lines = read_pipe_lines("git rev-parse --symbolic --remotes")
+            lines = read_pipe_lines(["git", "rev-parse", "--symbolic", "--remotes"])
 
         for line in lines:
             if self.rollbackLocalBranches or (line.startswith("p4/") and line != "p4/HEAD\n"):
@@ -1586,14 +1568,14 @@ def run(self, args):
                 if len(p4Cmd("changes -m 1 "  + ' '.join (['%s...@%s' % (p, maxChange)
                                                            for p in depotPaths]))) == 0:
                     print("Branch %s did not exist at change %s, deleting." % (ref, maxChange))
-                    system("git update-ref -d %s `git rev-parse %s`" % (ref, ref))
+                    system("git update-ref -d {ref} `git rev-parse {ref}`".format(ref=ref), shell=True)
                     continue
 
                 while change and int(change) > maxChange:
                     changed = True
                     if self.verbose:
                         print("%s is at %s ; rewinding towards %s" % (ref, change, maxChange))
-                    system("git update-ref %s \"%s^\"" % (ref, ref))
+                    system(["git", "update-ref", ref, "{}^".format(ref)])
                     log = extractLogMessageFromGitCommit(ref)
                     settings =  extractSettingsGitLog(log)
 
@@ -1694,7 +1676,7 @@ def __init__(self):
             die("Large file system not supported for git-p4 submit command. Please remove it from config.")
 
     def check(self):
-        if len(p4CmdList("opened ...")) > 0:
+        if len(p4CmdList(["opened", "..."])) > 0:
             die("You have files opened with perforce! Close them before starting the sync.")
 
     def separate_jobs_from_description(self, message):
@@ -1803,7 +1785,7 @@ def lastP4Changelist(self):
         # then gets used to patch up the username in the change. If the same
         # client spec is being used by multiple processes then this might go
         # wrong.
-        results = p4CmdList("client -o")        # find the current client
+        results = p4CmdList(["client", "-o"])        # find the current client
         client = None
         for r in results:
             if 'Client' in r:
@@ -1819,7 +1801,7 @@ def lastP4Changelist(self):
 
     def modifyChangelistUser(self, changelist, newUser):
         # fixup the user field of a changelist after it has been submitted.
-        changes = p4CmdList("change -o %s" % changelist)
+        changes = p4CmdList(["change", "-o", changelist])
         if len(changes) != 1:
             die("Bad output from p4 change modifying %s to user %s" %
                 (changelist, newUser))
@@ -1830,7 +1812,7 @@ def modifyChangelistUser(self, changelist, newUser):
         # p4 does not understand format version 3 and above
         input = marshal.dumps(c, 2)
 
-        result = p4CmdList("change -f -i", stdin=input)
+        result = p4CmdList(["change", "-f", "-i"], stdin=input)
         for r in result:
             if 'code' in r:
                 if r['code'] == 'error':
@@ -1936,7 +1918,7 @@ def edit_template(self, template_file):
         if "P4EDITOR" in os.environ and (os.environ.get("P4EDITOR") != ""):
             editor = os.environ.get("P4EDITOR")
         else:
-            editor = read_pipe("git var GIT_EDITOR").strip()
+            editor = read_pipe(["git", "var", "GIT_EDITOR"]).strip()
         system(["sh", "-c", ('%s "$@"' % editor), editor, template_file])
 
         # If the file was not saved, prompt to see if this patch should
@@ -1994,7 +1976,7 @@ def applyCommit(self, id):
 
         (p4User, gitEmail) = self.p4UserForCommit(id)
 
-        diff = read_pipe_lines("git diff-tree -r %s \"%s^\" \"%s\"" % (self.diffOpts, id, id))
+        diff = read_pipe_lines(["git", "diff-tree", "-r"] + self.diffOpts + ["{}^".format(id), id])
         filesToAdd = set()
         filesToChangeType = set()
         filesToDelete = set()
@@ -2131,7 +2113,7 @@ def applyCommit(self, id):
         #
         # Apply the patch for real, and do add/delete/+x handling.
         #
-        system(applyPatchCmd)
+        system(applyPatchCmd, shell=True)
 
         for f in filesToChangeType:
             p4_edit(f, "-t", "auto")
@@ -2481,17 +2463,17 @@ def run(self, args):
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
@@ -2499,12 +2481,12 @@ def run(self, args):
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
@@ -3453,10 +3435,9 @@ def getBranchMapping(self):
         lostAndFoundBranches = set()
 
         user = gitConfig("git-p4.branchUser")
+        command = ["branches"]
         if len(user) > 0:
-            command = "branches -u %s" % user
-        else:
-            command = "branches"
+            command += ["-u", user]
 
         for info in p4CmdList(command):
             details = p4Cmd(["branch", "-o", info["branch"]])
@@ -3549,7 +3530,7 @@ def gitCommitByP4Change(self, ref, change):
         while True:
             if self.verbose:
                 print("trying: earliest %s latest %s" % (earliestCommit, latestCommit))
-            next = read_pipe("git rev-list --bisect %s %s" % (latestCommit, earliestCommit)).strip()
+            next = read_pipe(["git", "rev-list", "--bisect", latestCommit, earliestCommit]).strip()
             if len(next) == 0:
                 if self.verbose:
                     print("argh")
@@ -3704,7 +3685,7 @@ def sync_origin_only(self):
             if self.hasOrigin:
                 if not self.silent:
                     print('Syncing with origin first, using "git fetch origin"')
-                system("git fetch origin")
+                system(["git", "fetch", "origin"])
 
     def importHeadRevision(self, revision):
         print("Doing initial import of %s from revision %s into %s" % (' '.join(self.depotPaths), revision, self.branch))
@@ -3871,8 +3852,8 @@ def run(self, args):
         if len(self.branch) == 0:
             self.branch = self.refPrefix + "master"
             if gitBranchExists("refs/heads/p4") and self.importIntoRemotes:
-                system("git update-ref %s refs/heads/p4" % self.branch)
-                system("git branch -D p4")
+                system(["git", "update-ref", self.branch, "refs/heads/p4"])
+                system(["git", "branch", "-D", "p4"])
 
         # accept either the command-line option, or the configuration variable
         if self.useClientSpec:
@@ -4075,7 +4056,7 @@ def run(self, args):
         # Cleanup temporary branches created during import
         if self.tempBranches != []:
             for branch in self.tempBranches:
-                read_pipe("git update-ref -d %s" % branch)
+                read_pipe(["git", "update-ref", "-d", branch])
             os.rmdir(os.path.join(os.environ.get("GIT_DIR", ".git"), self.tempBranchLocation))
 
         # Create a symbolic ref p4/HEAD pointing to p4/<branch> to allow
@@ -4107,7 +4088,7 @@ def run(self, args):
     def rebase(self):
         if os.system("git update-index --refresh") != 0:
             die("Some files in your working directory are modified and different than what is in your index. You can use git update-index <filename> to bring the index up to date or stash away all your changes with git stash.");
-        if len(read_pipe("git diff-index HEAD --")) > 0:
+        if len(read_pipe(["git", "diff-index", "HEAD", "--"])) > 0:
             die("You have uncommitted changes. Please commit them before rebasing or stash them away with git stash.");
 
         [upstream, settings] = findUpstreamBranchPoint()
@@ -4118,9 +4099,9 @@ def rebase(self):
         upstream = re.sub("~[0-9]+$", "", upstream)
 
         print("Rebasing the current branch onto %s" % upstream)
-        oldHead = read_pipe("git rev-parse HEAD").strip()
-        system("git rebase %s" % upstream)
-        system("git diff-tree --stat --summary -M %s HEAD --" % oldHead)
+        oldHead = read_pipe(["git", "rev-parse", "HEAD"]).strip()
+        system(["git", "rebase", upstream])
+        system(["git", "diff-tree", "--stat", "--summary", "-M", oldHead, "HEAD", "--"])
         return True
 
 class P4Clone(P4Sync):
@@ -4197,7 +4178,7 @@ def run(self, args):
 
         # auto-set this variable if invoked with --use-client-spec
         if self.useClientSpec_from_options:
-            system("git config --bool git-p4.useclientspec true")
+            system(["git", "config", "--bool", "git-p4.useclientspec", "true"])
 
         return True
 
@@ -4328,10 +4309,7 @@ def run(self, args):
         if originP4BranchesExist():
             createOrUpdateBranchesFromOrigin()
 
-        cmdline = "git rev-parse --symbolic "
-        cmdline += " --remotes"
-
-        for line in read_pipe_lines(cmdline):
+        for line in read_pipe_lines(["git", "rev-parse", "--symbolic", "--remotes"]):
             line = line.strip()
 
             if not line.startswith('p4/') or line == "p4/HEAD":
@@ -4416,9 +4394,9 @@ def main():
             cmd.gitdir = os.path.abspath(".git")
             if not isValidGitDir(cmd.gitdir):
                 # "rev-parse --git-dir" without arguments will try $PWD/.git
-                cmd.gitdir = read_pipe("git rev-parse --git-dir").strip()
+                cmd.gitdir = read_pipe(["git", "rev-parse", "--git-dir"]).strip()
                 if os.path.exists(cmd.gitdir):
-                    cdup = read_pipe("git rev-parse --show-cdup").strip()
+                    cdup = read_pipe(["git", "rev-parse", "--show-cdup"]).strip()
                     if len(cdup) > 0:
                         chdir(cdup);
 
-- 
2.33.0

