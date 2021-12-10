Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44D5C433FE
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 15:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242888AbhLJPfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 10:35:15 -0500
Received: from mail-dm6nam12on2057.outbound.protection.outlook.com ([40.107.243.57]:40928
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231651AbhLJPfM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 10:35:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dza12m5U0XNYuF17zhws8KlOhujK76TW6zs8a7waHbifMg1gMWSB7KlGcP70cUPCRzW5TgvrcmVhQ2u5yjBWXVLpXKwETrcpHh7nrJLs0V5y+uxnVZsumxi1Tbm2m4dvPvDbCDTx/FEry3ruixPHBBI37L2Cc5Q6g97YbnpjCCNB4e1WvxTT9vEzn2UoGyr8TRH9bb3jzoSPjFTys3BhuQGpcUKcSNPdDKdtvCZ8n9vlBvJ4w9WSoTRUJhZt0dwS/d32aDBgONSg+7TwYw2MHDUfIJFh5oixLPQE11PW4b92zNnaYCCckeaSVR2nvQTRYfMl4h8emgk09hg3m+ZmtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sRCldmn3fP8K1WVTZcitIOvWqIqTtu5dX/Zgyl2nBY=;
 b=DV2lnBJwQXmLu2qRe0I7gda5hh1geJBTOyllBJpZhKD6UqrqCWCHudxEIEYUTWsQXzRzxHdNoNy7SBznSq+i6AEEhQQjX22NcJa1ZojAj+KRqbvzhDmjnK5ZZFY0r95ioT+cDq/BtpoHhL3x+rGKOHpXG9zaa8ipQLzocuN0D5laZ1UcVa1di6oS8DTZ+jkxbp+fT9qoQSAbfNypcA9OQEtO/oGCvZ4oFV4clmK0k6N9ZIXyRNOK0iH089ob4/2OaEfGNyi+7ITlQNYLVkgBjuossgKUgVf8/cqH5Ivgx2ZUU6DING6y77dpoX0Vqn9C/gKTeRG7+686yuLzmpszRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sRCldmn3fP8K1WVTZcitIOvWqIqTtu5dX/Zgyl2nBY=;
 b=lpuPT+zGJX67KHyAJ6pAbL1LR6ilcxoTMwkEK00uUjidrbotCyCtvqO5niZPsVse63SuHS8LkSefvvsYm1ax0NSnVkSHX+2DNRpgT0VGnmhJd/L5WOFEf9/FCwKiXHXOk9gnyrrMu4atRJ/LTIsZkIxKdK5eSLZpCUqtWxugZsMuqtD2h3iEKfKzSJSr5nJR03HUI2bMe7Rz0FpKZ8q/bbB/Y96hNea5Kr8ft93tGF934xkxB3tLS5N6PQH4CLUWwDG39NftU5L4/j6or6nr9Ol8hmUfmMG/EWGdN+bVY1aabOVM0pZyJ4MMvFu1RbdCjjSukG91YZH7HtBogXRTcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR1201MB0019.namprd12.prod.outlook.com (2603:10b6:405:4d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Fri, 10 Dec
 2021 15:31:34 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4755.025; Fri, 10 Dec 2021
 15:31:34 +0000
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
Subject: [PATCH v2 2/3] git-p4: eliminate decode_stream and encode_stream
Date:   Fri, 10 Dec 2021 15:31:00 +0000
Message-Id: <20211210153101.35433-3-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211210153101.35433-1-jholdsworth@nvidia.com>
References: <20211210153101.35433-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0128.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::7) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
Received: from red.nvidia.com (195.110.77.193) by LO4P123CA0128.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:193::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Fri, 10 Dec 2021 15:31:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0360369-2d31-4ca6-47e9-08d9bbf22624
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0019:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0019762A48297D8DAC1DBE13C8719@BN6PR1201MB0019.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YAlgMRgUso1lD0gTBnlLYj+fJGg4tSLdKNpBlKUrXgPmLB3w+lYFGzi8B6u3ikNf+CCUnnig06Sw7ynNwDMvlkjLrE06lyhpIlyHweEFA+VtLHLO8v96SKB51rVnbHtGph87CpGaYKxeo1LWuiLtBZUEHSZibgG9p9a0HEeQLUVDU06YkjS9JbVbHeA4flmEeb3GfKXfQ1kI8/teFKR7zc6xcQcwSONQbJVVtXja008pTOlGI1eI96263Gtv32R0Y4Bb8973T3Q2mF77iQ4QU+UmXJnrJfC9+YDwLz6mCo3bLph1jg47vGuMmfCEEyLJPcdOI6ITrOrFMaBoO7ymYQF3MOBcwE9bobaKb2HyPSB6xg4YunE1QzpxhjKXQU0mi3T3twmkXVGzIApcXSeNZOaMpK0gTjpB5uLAriW98yW1KDsyaxxJe1AnN1BnKNDblUsj68OUnHVWaNzViz+2aQaeT8XOckBvPTLhtZArztHdZ/pCXvvIhiggp2OtfUdSWRgpttY0VJ0jSxLzkRUmYVe7lTJ1bE7qWOi7DGWLhsXjsL0EkDYcXjLsTk8BWxtYcTLT/KyYQX85Tb3e1UOWhsolWkYzIeSQFJM5MyeIr2qi3855K7k8LywemyRxAqXE9q4PwyJqDieOPqcAc3i9Sf3HWJO0L3eOSZLWB6RzrLZVVE7g9MDjyb490HatpOy6bM4PHHpGqd96CC/eFdqZjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(66556008)(1076003)(956004)(86362001)(54906003)(8676002)(5660300002)(26005)(6666004)(55236004)(508600001)(6486002)(2906002)(52116002)(7696005)(6916009)(316002)(36756003)(4326008)(8936002)(38100700002)(38350700002)(83380400001)(186003)(66946007)(107886003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kSnqwjL9VEBZ4mggB4y4lAnmOY3QorsbYhzLJ2cO0xHxWWB8HYN7sZAHPh7r?=
 =?us-ascii?Q?emvPE+RTxmHUZrEsGU/QhE7MKJLHMdKnN2hqEKp07u1HVMHaVwoSfayNfmYj?=
 =?us-ascii?Q?5C90z2HyiZeUbgspjeUKxTGK21NPNx9QBMS7Ep4xDLjxsKj+OIlYsD7l/KTt?=
 =?us-ascii?Q?QkVGsBmL+IX3d06+WY/38bvK5hpIWX//8DSA5uWfW+XPntuJL4YDB6gm8hRV?=
 =?us-ascii?Q?Ixzj0jdL+kxBeE91x6jIW/FuwLDQBFkWNO98YUPbHCQ58jsWTQYoH2tDxWxT?=
 =?us-ascii?Q?6Sw6Ht4z9w6GgKlX2jmcZwHnRfrzu9WuUFy6Yv1w6lHMW7R/YD2WJCipLZVD?=
 =?us-ascii?Q?q5zZuVjqakQh98bn26okZXrRA5YBx+8EM0iri2s3uomHUissNppFMD/kWzH3?=
 =?us-ascii?Q?c7v6MvvYmHiXd9xL7iTNa+2r/JKOajntNN+GalmtSvD3YBOEebGZGsMCsOwp?=
 =?us-ascii?Q?wqfQqQXdYZ+4OPg+q5djjlXBRdqYajbPeeVcM8DsH32As7QRw4fReelmDcOt?=
 =?us-ascii?Q?W9/4/e7xC1CswCriGLvD2aqMQmVI97DvS2lkqXVio+oyA9D4cAYqVlbBCd9J?=
 =?us-ascii?Q?nXtTkOs+nu/pp1YNi+84fuzDxlLI6h4wcnF+OjAbEMu1FHgU1sVRhiF2opFa?=
 =?us-ascii?Q?xXGEg6RsmupDbreyrdSBiXpsivIRTa8cpqEtWoixRe0Waf1cSDtZP3KD+qSX?=
 =?us-ascii?Q?SJgmhpnuY1fuBSQ/54HUUtoXoXWxN3WGrAGnua87Y7u2WmIRjwx6hk8IsMgv?=
 =?us-ascii?Q?vWv8q3bs4t2gAxV17WB8DL4oNSbTmFWYvgr4DYPJaHqGQHxqMQcoHesO5IkJ?=
 =?us-ascii?Q?Inp1I3a156p2BB3c5G6rYyhMTfz4xgfyJbAOJw9DLp3L/DDO5v08v/HpTyJw?=
 =?us-ascii?Q?dl1dyuFwJlIKFvsaE5E+Q2XGnxUJMtuSKm+RvDqBkznyaASXzsJIrq8wH0TC?=
 =?us-ascii?Q?Wx4uxinTWd4BEUQdvvNF2DEUKs7WYcDORd0o7WhPuB73KLSikynj1sv4XS3A?=
 =?us-ascii?Q?QHtPQ+3HpU0WvQnB23qfsAMd1lXIYgcvp1DKRyiAqzrokuZAoEhrUf5ki5m0?=
 =?us-ascii?Q?6w66KB+jfY1T3hyfEyE3PMjwy70QUvsCtQy7l78/A5YdnZ/SGVtQf2XMRAkl?=
 =?us-ascii?Q?g6lKbq2J1ZzQBo+XUWFIEAu4e7yIvNNQrpSymE1VZgJSFiDKk5YU4yYGjkLU?=
 =?us-ascii?Q?4dvt4yLe4pH3Jx0FY4urQDpy+uEvh+Sag2SFzeDV6eXIR91WixsiwoZQ+eah?=
 =?us-ascii?Q?Bzf4iFwNKS2FGf0KdVz9vaFdXao1l7UmAPnfyizglBzUpTSA6SZXnbsJjANX?=
 =?us-ascii?Q?NC5c1+lquZXNP5h9VidVl7SBzk4E/3SonGuP3S+VUnQtugBuSeuLzv+sVDTD?=
 =?us-ascii?Q?QTCmA0Q+65JZJIxDy8cupFdAD+REjgrwliqMohZ3cw2/pvArsz6MXCTx28UG?=
 =?us-ascii?Q?tb0eheRqbg7l3YWntVOhoslCUNCJhU6rzgHi/MrTgrxEUUTPrSYQLsPpRAF8?=
 =?us-ascii?Q?Ydk2d2y2k2ZAT5RKxgZwoBnsG1K6m69RCt9+Aejiiao861foyYsf3ZTQsqR5?=
 =?us-ascii?Q?751AaPzP7pKLYJ0JxOgUkYSIdDGNnmWvyzkNA7d6q9oPkVfF/wBTb/iXI08U?=
 =?us-ascii?Q?bLMnm6iAJR96H+9yn6cWh5Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0360369-2d31-4ca6-47e9-08d9bbf22624
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:31:34.7136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbXUj694CwTa6DVw90N64XqfI+QDdS9c6o8QKUACyDAPNUo5cQ42XOIBcS/I3xVvd+vw5DvieONIOaSfafiTwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0019
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The decode_stream and encode_stream functions previously abstracted away
the differences in string encode/decode behaviour between Python 2 and
Python 3.

Given that Python 2 is no longer supported, and the code paths for it
have been removed, the abstraction is no longer necessary, and the
script can therefore be simplified by eliminating these functions.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 49 +++++++++++++++++++------------------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index e3fe86e4f2..5568d44c72 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -167,11 +167,6 @@ def prompt(prompt_text):
         if response in choices:
             return response
 
-def decode_text_stream(s):
-    return s.decode() if isinstance(s, bytes) else s
-def encode_text_stream(s):
-    return s.encode() if isinstance(s, str) else s
-
 def decode_path(path):
     """Decode a given string (bytes or otherwise) using configured path encoding options
     """
@@ -276,7 +271,7 @@ def read_pipe_full(c):
     expand = not isinstance(c, list)
     p = subprocess.Popen(c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=expand)
     (out, err) = p.communicate()
-    return (p.returncode, out, decode_text_stream(err))
+    return (p.returncode, out, err.decode())
 
 def read_pipe(c, ignore_error=False, raw=False):
     """ Read output from  command. Returns the output text on
@@ -288,22 +283,17 @@ def read_pipe(c, ignore_error=False, raw=False):
     (retcode, out, err) = read_pipe_full(c)
     if retcode != 0:
         if ignore_error:
-            out = ""
+            out = b""
         else:
             die('Command failed: %s\nError: %s' % (str(c), err))
-    if not raw:
-        out = decode_text_stream(out)
-    return out
+    return out if raw else out.decode()
 
 def read_pipe_text(c):
     """ Read output from a command with trailing whitespace stripped.
         On error, returns None.
     """
     (retcode, out, err) = read_pipe_full(c)
-    if retcode != 0:
-        return None
-    else:
-        return decode_text_stream(out).rstrip()
+    return out.decode().rstrip() if retcode == 0 else None
 
 def p4_read_pipe(c, ignore_error=False, raw=False):
     real_cmd = p4_build_cmd(c)
@@ -316,7 +306,7 @@ def read_pipe_lines(c):
     expand = not isinstance(c, list)
     p = subprocess.Popen(c, stdout=subprocess.PIPE, shell=expand)
     pipe = p.stdout
-    val = [decode_text_stream(line) for line in pipe.readlines()]
+    val = [line.decode() for line in pipe.readlines()]
     if pipe.close() or p.wait():
         die('Command failed: %s' % str(c))
     return val
@@ -346,7 +336,7 @@ def p4_has_move_command():
     cmd = p4_build_cmd(["move", "-k", "@from", "@to"])
     p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
     (out, err) = p.communicate()
-    err = decode_text_stream(err)
+    err = err.decode()
     # return code will be 1 in either case
     if err.find("Invalid option") >= 0:
         return False
@@ -721,7 +711,7 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
             stdin_file.write(stdin)
         else:
             for i in stdin:
-                stdin_file.write(encode_text_stream(i))
+                stdin_file.write(i.encode() if isinstance(i, str) else i)
                 stdin_file.write(b'\n')
         stdin_file.flush()
         stdin_file.seek(0)
@@ -963,8 +953,7 @@ def branch_exists(branch):
 
     cmd = [ "git", "rev-parse", "--symbolic", "--verify", branch ]
     p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
-    out, _ = p.communicate()
-    out = decode_text_stream(out)
+    out = p.communicate()[0].decode()
     if p.returncode:
         return False
     # expect exactly one line of output: the branch name
@@ -1349,7 +1338,7 @@ def generatePointer(self, contentFile):
             ['git', 'lfs', 'pointer', '--file=' + contentFile],
             stdout=subprocess.PIPE
         )
-        pointerFile = decode_text_stream(pointerProcess.stdout.read())
+        pointerFile = pointerProcess.stdout.read().decode()
         if pointerProcess.wait():
             os.remove(contentFile)
             die('git-lfs pointer command failed. Did you install the extension?')
@@ -2148,7 +2137,7 @@ def applyCommit(self, id):
         tmpFile = os.fdopen(handle, "w+b")
         if self.isWindows:
             submitTemplate = submitTemplate.replace("\n", "\r\n")
-        tmpFile.write(encode_text_stream(submitTemplate))
+        tmpFile.write(submitTemplate.encode())
         tmpFile.close()
 
         submitted = False
@@ -2204,8 +2193,8 @@ def applyCommit(self, id):
                         return False
 
                 # read the edited message and submit
-                tmpFile = open(fileName, "rb")
-                message = decode_text_stream(tmpFile.read())
+                with open(fileName, "r") as tmpFile:
+                    message = tmpFile.read()
                 tmpFile.close()
                 if self.isWindows:
                     message = message.replace("\r\n", "\n")
@@ -2905,7 +2894,7 @@ def splitFilesIntoBranches(self, commit):
         return branches
 
     def writeToGitStream(self, gitMode, relPath, contents):
-        self.gitStream.write(encode_text_stream(u'M {} inline {}\n'.format(gitMode, relPath)))
+        self.gitStream.write('M {} inline {}\n'.format(gitMode, relPath))
         self.gitStream.write('data %d\n' % sum(len(d) for d in contents))
         for d in contents:
             self.gitStream.write(d)
@@ -2947,7 +2936,7 @@ def streamOneP4File(self, file, contents):
             git_mode = "120000"
             # p4 print on a symlink sometimes contains "target\n";
             # if it does, remove the newline
-            data = ''.join(decode_text_stream(c) for c in contents)
+            data = ''.join(c.decode() for c in contents)
             if not data:
                 # Some version of p4 allowed creating a symlink that pointed
                 # to nothing.  This causes p4 errors when checking out such
@@ -3001,9 +2990,9 @@ def streamOneP4File(self, file, contents):
         pattern = p4_keywords_regexp_for_type(type_base, type_mods)
         if pattern:
             regexp = re.compile(pattern, re.VERBOSE)
-            text = ''.join(decode_text_stream(c) for c in contents)
+            text = ''.join(c.decode() for c in contents)
             text = regexp.sub(r'$\1$', text)
-            contents = [ encode_text_stream(text) ]
+            contents = [text.encode()]
 
         if self.largeFileSystem:
             (git_mode, contents) = self.largeFileSystem.processContent(git_mode, relPath, contents)
@@ -3015,7 +3004,7 @@ def streamOneP4Deletion(self, file):
         if verbose:
             sys.stdout.write("delete %s\n" % relPath)
             sys.stdout.flush()
-        self.gitStream.write(encode_text_stream(u'D {}\n'.format(relPath)))
+        self.gitStream.write('D {}\n'.format(relPath))
 
         if self.largeFileSystem and self.largeFileSystem.isLargeFile(relPath):
             self.largeFileSystem.removeLargeFile(relPath)
@@ -3115,9 +3104,9 @@ def streamP4FilesCbSelf(entry):
                 if 'shelved_cl' in f:
                     # Handle shelved CLs using the "p4 print file@=N" syntax to print
                     # the contents
-                    fileArg = f['path'] + encode_text_stream('@={}'.format(f['shelved_cl']))
+                    fileArg = f['path'] + '@={}'.format(f['shelved_cl']).encode()
                 else:
-                    fileArg = f['path'] + encode_text_stream('#{}'.format(f['rev']))
+                    fileArg = f['path'] + '#{}'.format(f['rev']).encode()
 
                 fileArgs.append(fileArg)
 
-- 
2.33.0

