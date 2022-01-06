Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00091C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 21:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244333AbiAFVlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 16:41:05 -0500
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com ([40.107.243.43]:57313
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244330AbiAFVlD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 16:41:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jamxOJmvUiXWiCULkoiw/DcwDLl00jSBtG4Agxb9zoJSZWNQHbwYYb+kQ4jivhLLh3F/U0RMuuPjqYP7I3VGRxNWy41pYEqyFP2ifGaSSRrumIljYDfiywrNC5yznYzcicVfyjtbE7475mWQ7WfjSmgb44GsSWfmXyVW50Gp9Re8wMGuq1GX/gOh4HOWa0mpT0SiyRf9dpebAqYvcKOhxapWX78hwPt+7/5obJ+2bgCBefLQSH12Y93LVVeCCf9gd9JsBWPImv4kT5yPbAV0Sc2iWWdIMnBLGq08VnuIh9fmfgPvoYKaCW1iU8ORkoSjWORBpiSEO69Xhvf/j1hKdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9K/MFep3Wo5zdNXsHxqAo0kMmdzYOpR40Saz2fwqmaY=;
 b=T1wKCRx/CMC97ZH7/KauUwvivL3b2d8oZhsmyCp0FtRd2vGmvWW9kv3yCrzCS1487DvHbZFutn1eTyfeTmyLPTHn2OMpnepT65v/v0CzUEQWpVPH+rcoq4ZgXyrHgDqpcYd/aA+A258tvIoNWo3V9QToYBm1rRH9DYWuSYRYZG0FHPlzsholDMZ/ISwH26OJCvdrVj8KhJXB8VSfFlnzrNSEKVKisH9ZwT1oD9rPrfHF6mJB5EPhHJPH1gk8x7c1j5UBPs36oDyjVigXmssk7cGzF2+qOJ4KLNsWxaFgf3UFERl9Dk/pTkCRkd5/G1BQCCGBe4WjJrgdoUk7z1vXOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9K/MFep3Wo5zdNXsHxqAo0kMmdzYOpR40Saz2fwqmaY=;
 b=RA2fa4z3agSFttVlvtX2cVDChFAtGPVmBt2WGRj/nTgI/lfzJabJVaDX+o9EsOg8b/L7D2EJxV3EZHIBsrajBvwlwlvglsYmYab6fhR1Yf8epugVCJWOvCZyYXbH7jG/bF9gNVvHzBUenKMXydK8UmOfnzaQwle6lHuCvfrKZBXc2a9pc1EU1RHI5bwtegs0+Wu1VrSMU0EGsvT/O27QfR/Nd4fWkrXV3Sl+wqZ0593le4cmoTnuKv2B4nAgBDLeb+gqJfN90q9FS8RZV6GLUzihNNfzP/QDcnqGBYbA/7mCLbfzkc7olJBWSRsjUf1ecSOwnqr/mKr3fFfkqiKBYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB3854.namprd12.prod.outlook.com (2603:10b6:208:16a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Thu, 6 Jan
 2022 21:41:02 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 21:41:02 +0000
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
Subject: [PATCH v2 2/3] git-p4: pass command arguments as lists instead of using shell
Date:   Thu,  6 Jan 2022 21:40:34 +0000
Message-Id: <20220106214035.90725-3-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220106214035.90725-1-jholdsworth@nvidia.com>
References: <20220106214035.90725-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::35) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59e98c36-b7da-41c5-8ca3-08d9d15d3c2d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3854:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3854841DA7D8F7171D2B8A70C84C9@MN2PR12MB3854.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:462;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q5xn2Qe0Xb9HJctZ4tjiDLITXu09MHDmtPeOnvu/LdCCdqQkeD3kgA5Zr56ywFU6aYHo4IT2fVXdCxY7eTu5v7MCwcQ5Z4Hzgk+TbrhiHj0hkDZnopicjSrypqqlcSakYci4udZOXjHn4UWWxrYHr1MZXeitw7YhMf/lxBBpTKV4SNnVzXQmcCQG3igDUiQsj1k34rOvskfwiQGZE6OVF42bYxr2AfzwO4+waGDi2McL3Wdrb+ae4m3eN2kzwa60NOSLw2SsVu3WWDotEKfJbssEGdDcwjdPvzroM5W71bQJtB4FnNTwCNHgavZlMTl5PaP02fSnicGWhJpcZZ8em+JPar7nlWz3+G76JUMzJm9vCTJrc99ZyXkq38W6rT1f9A7lyc/KldTaksX79Zc/TTq+FNdN0l/BgShsIlN9haEfoiL0EKqxxpzd2/A/yH+Y9rRU8xOFdC9Ihs8+S6VgjNzNzTlpZcVxiEZrF4cT8Lu/P3/ieKsG8UEuQd8Tg9zMW0GU+Bt9jnfs1aiG0LQt4fTuKDXQKR0/BqQc7bW/fKej9RjY804YsZ6Wqlt8zsUv+PPxH5UyPf2YyptJ40DmbtkoQV4X6oGJp76uqoN7okEJCJDSozMPW82NwGx9ryaZpBrLw9GC8tSAvk7JAyO3fUcfZov8Oc+g7POQpVA6gtGB54BbxQcKKII2PMskUnqtTl8mVDLXV5FN5JbNOjXKfkAdU8QLvDRdmp46ehH7rFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(508600001)(26005)(66556008)(66476007)(83380400001)(186003)(4326008)(38350700002)(8936002)(66946007)(8676002)(36756003)(2616005)(7416002)(54906003)(6512007)(6666004)(107886003)(52116002)(2906002)(30864003)(6486002)(316002)(5660300002)(6506007)(110136005)(1076003)(55236004)(86362001)(403724002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hZm46+hr3VgqBdoEf1ITiRmcnLG2pMJqnMpwa7GEoa/+wcAwkUS0e9YI7Y4G?=
 =?us-ascii?Q?2ImEiUB0eooW2V5rEBuG0sUkCVqRDKO2grCR/Rww6ZtqNMHJVvDqibyaKOeN?=
 =?us-ascii?Q?nZjnN8i+3IC0Xxfen7jdJPZUNQ/omlqVrpVdmQOtGM1awU5O0wPXi9k/YiIX?=
 =?us-ascii?Q?PwsMU6YGS8tCmGqqr9uSZ8uo83SQJS2AqFPAVkgGLE+8MrBzKETAQV4F8ziz?=
 =?us-ascii?Q?0fTzoka+1dPk+cOWckKTt4SZfQw7ptlKthRuZlUnAaUYYRat5PaZSj4Yzr9L?=
 =?us-ascii?Q?a1KC7hK1UqrvxgtkJsyfZY5h9wzDQsX2n8nvs1SS8ZxWAYR7aQWzigwITkA9?=
 =?us-ascii?Q?yU+4wVZxOPvhEIDbsSjgMVkB0Rj54Pt8ELHOACuHiOIKdnc1bewZLVqvmUhN?=
 =?us-ascii?Q?zzRsvy4jfl/wPxkEeRj4twDP5Z4TPJy/fTyXf6C6djExAQgXPBMhSJJPiCaq?=
 =?us-ascii?Q?sgp46RLZlFb4fLR+M6PYQbssfWU5C5WgjkUyfQEQVfUKoZ/141i+BQDkBWhN?=
 =?us-ascii?Q?WZASNMBvmfXQ/Zvd72dE9aPNGD5gEo6OgKPOa5hgNKnq3OtK4iIA8/ohFQUQ?=
 =?us-ascii?Q?9aO4n/hlw5RUzau6qOcRqBtVvBjXlF01dQI5LS2AZzaDE45lW4RxMiUkStBp?=
 =?us-ascii?Q?9HAFcBLQQgE2BuudZo1wP8CyesyuWghLD15TdBgaGLHcvANGf6Duhh2DPuma?=
 =?us-ascii?Q?tLHjLguhdbuUPci+0EFV5++1/bHqhZwTHauxrSW8t69gl2ysEh6fb6FAE6kb?=
 =?us-ascii?Q?o47rE+Ymqjpp2YlG5cAjmqu1HVXiF/I1sYBSw42Wpn9Pay62qV6OT938QPG7?=
 =?us-ascii?Q?m+CXLTbDRXLKYF+ABPqTpVpjWlWkxYDs07tjH4wbe6c2GLGfqmhDMSRkom6g?=
 =?us-ascii?Q?F5bilph+DDaCPDyKtmDNLxlTrgTC2SKhbZ4ChNTKHnNx0gHyakBRyaCv8CuU?=
 =?us-ascii?Q?x7QxP213BNwlbI6xRU1g8T5Ee2Q7GrMw7r4d47gpKweRTfEcAFftdfSB906C?=
 =?us-ascii?Q?oc5rq75tR0CdpnMRKwUCvwf+vkudQRkGhMt6xg4UrYigYFw+MRlQLKftxHZR?=
 =?us-ascii?Q?8UVC3FiEjdvPMHtOnIhyEgqbsnUdP+D7OV5TcU2R/Krb+v62AT0r2fqJ8Pm6?=
 =?us-ascii?Q?OiBpq3KZhALwDfvIyxbPYLNe5Zi05WsIVYDD7IQ36bIOMH813PGEB1XUKh8V?=
 =?us-ascii?Q?SvKr1p51/Q2yZikYg4/y7v/uS89OwhKNWgQTkemYsZPQeKjm2ptMRWdNaw/V?=
 =?us-ascii?Q?9Ufp3QMZ0/VpWtNUeW8NsTlY2fXH6rJQ2xNzLAPJB+WvEPCx5cekNKOc5iME?=
 =?us-ascii?Q?G9TRHVBRxo0CwbhG1wPhzPaONSCwv7SI7+KnOxGd1Ytln8jLgyLsE+qGZoPw?=
 =?us-ascii?Q?ub1I52/PaHux9/wS7+K/NFDnfSl80ZW2flDAyg1l/sVYiYsnKrzQdhrmMI1X?=
 =?us-ascii?Q?S8EdXi5/z0x1kv+PbptqTxpAuK1P3FCHqpdibpZ+44XAg1XLnO1qqTZO8kXZ?=
 =?us-ascii?Q?zQWz1V791PJku73JNC2XpGSGSTISWmhOmjv5FGweJ8NuhjaW5PBrIqLoYvpP?=
 =?us-ascii?Q?ycyEyVPFo4jOn6JMp7XqZvg7Qdn5egZlJXYY3DwzarQbcNXp5x4Xf3JBvDni?=
 =?us-ascii?Q?9lt9zkGIiauzN5sFLyMols4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e98c36-b7da-41c5-8ca3-08d9d15d3c2d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 21:41:02.3448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zN4F2OPBBJdwN4yCGNthYbIDKVUU+2TnrUGycxi2ZIWVoany7vgiDEg7Vv2EbkRFpeQ+Z7UBJIfjKJsvrW9Dlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3854
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
index 7ec90388b6..492eb5aa23 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -96,10 +96,7 @@ def p4_build_cmd(cmd):
         # Provide a way to not pass this option by setting git-p4.retries to 0
         real_cmd += ["-r", str(retries)]
 
-    if not isinstance(cmd, list):
-        real_cmd = ' '.join(real_cmd) + ' ' + cmd
-    else:
-        real_cmd += cmd
+    real_cmd += cmd
 
     # now check that we can actually talk to the server
     global p4_access_checked
@@ -721,12 +718,7 @@ def isModeExecChanged(src_mode, dst_mode):
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
 
@@ -849,7 +841,7 @@ def isValidGitDir(path):
     return git_dir(path) != None
 
 def parseRevision(ref):
-    return read_pipe("git rev-parse %s" % ref, shell=True).strip()
+    return read_pipe(["git", "rev-parse", ref]).strip()
 
 def branchExists(ref):
     rev = read_pipe(["git", "rev-parse", "-q", "--verify", ref],
@@ -955,13 +947,13 @@ def p4BranchesInGit(branchesAreInRemotes=True):
 
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
@@ -1024,7 +1016,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
 
     originPrefix = "origin/p4/"
 
-    for line in read_pipe_lines("git rev-parse --symbolic --remotes", shell=True):
+    for line in read_pipe_lines(["git", "rev-parse", "--symbolic", "--remotes"]):
         line = line.strip()
         if (not line.startswith(originPrefix)) or line.endswith("HEAD"):
             continue
@@ -1062,8 +1054,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
                               remoteHead, ','.join(settings['depot-paths'])))
 
         if update:
-            system("git update-ref %s %s" % (remoteHead, originHead),
-                shell=True)
+            system(["git", "update-ref", remoteHead, originHead])
 
 def originP4BranchesExist():
         return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
@@ -1177,7 +1168,7 @@ def getClientSpec():
     """Look at the p4 client spec, create a View() object that contains
        all the mappings, and return it."""
 
-    specList = p4CmdList("client -o", shell=True)
+    specList = p4CmdList(["client", "-o"])
     if len(specList) != 1:
         die('Output from "client -o" is %d lines, expecting 1' %
             len(specList))
@@ -1206,7 +1197,7 @@ def getClientSpec():
 def getClientRoot():
     """Grab the client directory."""
 
-    output = p4CmdList("client -o", shell=True)
+    output = p4CmdList(["client", "-o"])
     if len(output) != 1:
         die('Output from "client -o" is %d lines, expecting 1' % len(output))
 
@@ -1461,7 +1452,7 @@ def p4UserId(self):
         if self.myP4UserId:
             return self.myP4UserId
 
-        results = p4CmdList("user -o", shell=True)
+        results = p4CmdList(["user", "-o"])
         for r in results:
             if 'User' in r:
                 self.myP4UserId = r['User']
@@ -1486,7 +1477,7 @@ def getUserMapFromPerforceServer(self):
         self.users = {}
         self.emails = {}
 
-        for output in p4CmdList("users", shell=True):
+        for output in p4CmdList(["users"]):
             if "User" not in output:
                 continue
             self.users[output["User"]] = output["FullName"] + " <" + output["Email"] + ">"
@@ -1684,7 +1675,7 @@ def __init__(self):
             die("Large file system not supported for git-p4 submit command. Please remove it from config.")
 
     def check(self):
-        if len(p4CmdList("opened ...", shell=True)) > 0:
+        if len(p4CmdList(["opened", "..."])) > 0:
             die("You have files opened with perforce! Close them before starting the sync.")
 
     def separate_jobs_from_description(self, message):
@@ -1788,7 +1779,7 @@ def lastP4Changelist(self):
         # then gets used to patch up the username in the change. If the same
         # client spec is being used by multiple processes then this might go
         # wrong.
-        results = p4CmdList("client -o", shell=True)    # find the current client
+        results = p4CmdList(["client", "-o"])        # find the current client
         client = None
         for r in results:
             if 'Client' in r:
@@ -1804,7 +1795,7 @@ def lastP4Changelist(self):
 
     def modifyChangelistUser(self, changelist, newUser):
         # fixup the user field of a changelist after it has been submitted.
-        changes = p4CmdList("change -o %s" % changelist, shell=True)
+        changes = p4CmdList(["change", "-o", changelist])
         if len(changes) != 1:
             die("Bad output from p4 change modifying %s to user %s" %
                 (changelist, newUser))
@@ -1815,7 +1806,7 @@ def modifyChangelistUser(self, changelist, newUser):
         # p4 does not understand format version 3 and above
         input = marshal.dumps(c, 2)
 
-        result = p4CmdList("change -f -i", stdin=input, shell=True)
+        result = p4CmdList(["change", "-f", "-i"], stdin=input)
         for r in result:
             if 'code' in r:
                 if r['code'] == 'error':
@@ -1921,7 +1912,7 @@ def edit_template(self, template_file):
         if "P4EDITOR" in os.environ and (os.environ.get("P4EDITOR") != ""):
             editor = os.environ.get("P4EDITOR")
         else:
-            editor = read_pipe("git var GIT_EDITOR", shell=True).strip()
+            editor = read_pipe(["git", "var", "GIT_EDITOR"]).strip()
         system(["sh", "-c", ('%s "$@"' % editor), editor, template_file])
 
         # If the file was not saved, prompt to see if this patch should
@@ -1980,8 +1971,7 @@ def applyCommit(self, id):
         (p4User, gitEmail) = self.p4UserForCommit(id)
 
         diff = read_pipe_lines(
-            "git diff-tree -r %s \"%s^\" \"%s\"" % (self.diffOpts, id, id),
-            shell=True)
+            ["git", "diff-tree", "-r"] + self.diffOpts + ["{}^".format(id), id])
         filesToAdd = set()
         filesToChangeType = set()
         filesToDelete = set()
@@ -2467,17 +2457,17 @@ def run(self, args):
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
@@ -2485,12 +2475,12 @@ def run(self, args):
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
@@ -3436,12 +3426,9 @@ def getBranchMapping(self):
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
@@ -3532,9 +3519,8 @@ def gitCommitByP4Change(self, ref, change):
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
@@ -3689,7 +3675,7 @@ def sync_origin_only(self):
             if self.hasOrigin:
                 if not self.silent:
                     print('Syncing with origin first, using "git fetch origin"')
-                system("git fetch origin", shell=True)
+                system(["git", "fetch", "origin"])
 
     def importHeadRevision(self, revision):
         print("Doing initial import of %s from revision %s into %s" % (' '.join(self.depotPaths), revision, self.branch))
@@ -3856,8 +3842,8 @@ def run(self, args):
         if len(self.branch) == 0:
             self.branch = self.refPrefix + "master"
             if gitBranchExists("refs/heads/p4") and self.importIntoRemotes:
-                system("git update-ref %s refs/heads/p4" % self.branch, shell=True)
-                system("git branch -D p4", shell=True)
+                system(["git", "update-ref", self.branch, "refs/heads/p4"])
+                system(["git", "branch", "-D", "p4"])
 
         # accept either the command-line option, or the configuration variable
         if self.useClientSpec:
@@ -4060,7 +4046,7 @@ def run(self, args):
         # Cleanup temporary branches created during import
         if self.tempBranches != []:
             for branch in self.tempBranches:
-                read_pipe("git update-ref -d %s" % branch, shell=True)
+                read_pipe(["git", "update-ref", "-d", branch])
             os.rmdir(os.path.join(os.environ.get("GIT_DIR", ".git"), self.tempBranchLocation))
 
         # Create a symbolic ref p4/HEAD pointing to p4/<branch> to allow
@@ -4092,7 +4078,7 @@ def run(self, args):
     def rebase(self):
         if os.system("git update-index --refresh") != 0:
             die("Some files in your working directory are modified and different than what is in your index. You can use git update-index <filename> to bring the index up to date or stash away all your changes with git stash.");
-        if len(read_pipe("git diff-index HEAD --", shell=True)) > 0:
+        if len(read_pipe(["git", "diff-index", "HEAD", "--"])) > 0:
             die("You have uncommitted changes. Please commit them before rebasing or stash them away with git stash.");
 
         [upstream, settings] = findUpstreamBranchPoint()
@@ -4103,10 +4089,10 @@ def rebase(self):
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
@@ -4183,7 +4169,7 @@ def run(self, args):
 
         # auto-set this variable if invoked with --use-client-spec
         if self.useClientSpec_from_options:
-            system("git config --bool git-p4.useclientspec true", shell=True)
+            system(["git", "config", "--bool", "git-p4.useclientspec", "true"])
 
         return True
 
@@ -4314,10 +4300,7 @@ def run(self, args):
         if originP4BranchesExist():
             createOrUpdateBranchesFromOrigin()
 
-        cmdline = "git rev-parse --symbolic "
-        cmdline += " --remotes"
-
-        for line in read_pipe_lines(cmdline, shell=True):
+        for line in read_pipe_lines(["git", "rev-parse", "--symbolic", "--remotes"]):
             line = line.strip()
 
             if not line.startswith('p4/') or line == "p4/HEAD":
@@ -4402,11 +4385,9 @@ def main():
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

