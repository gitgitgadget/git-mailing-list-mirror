Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D2DC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 22:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244012AbhLMWzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 17:55:23 -0500
Received: from mail-bn7nam10on2085.outbound.protection.outlook.com ([40.107.92.85]:28160
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244044AbhLMWzO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 17:55:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnYpHaSRaXVMHUbfikBjgbMCZVHkZmxDJl4MXi4Q0T9OhR+7XbTtqDWN9lnZoOuX+5IMUfXFt2gg0LaP9U5VE1+rSFTR0+k1KPti3hCI2Nd4NkBNrRKqG7Xv9yMWvS6RfQQ8NwZ+/CKvP28BNnvspIv2TrujHFFviEjliW/m3KCS8Yt9PWviQ5NXQwpEsxIV9vDjYLTETeu+bZ0ioc60+agJvabRn/7IFNk4rkGdIELbsAwXy1Ffcq5lkBi6/OK9RH4sGALUfcB46IJiFJuTeHZ3Ch/WqxpXnHd8GZALJGU4rNVJZvNcUTNxY3IP5BP2/3RbmjUI4BelpaRyQzb6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBuWx8XTLcF7AIBJQtkfyHUjCNrH03f1Iouh3/jPxiY=;
 b=lsFvPbQlP11JUW8oK+IrAWS9lE2HrmEiaKCaM5EJUsCCE6noVNj4TGTlhtoWw8FwZZw0wCZwU5L2cndsRy/nvBFbY0ulnIWkJqzmeOkKqG1QJiibSu7yiM+8TihQBzp5OshCshvSK5lt9pUKKDfvdlubdq3Nu6KVoMtO/YodrtvfuvvcUtWxElDeReSPhEE3tWfrGdOCsNAPlLu+T8v1g5gA4h2eSQbWk9wBhsjFG9Z0A9C+Jxvfp/iepZho8bmqcRffrzbgvupPEoVQUv6NBz2srZOrdla65ZnvqE49ffkc8GLaTDIUgvbSM/3XZ/q82n5glVIWa3ehJazfUmczYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBuWx8XTLcF7AIBJQtkfyHUjCNrH03f1Iouh3/jPxiY=;
 b=NDQviA0rWIw2s85dsaa/Mw9II9DWVTaKMES2J3s2I5pW1ohQA/7zujs/APjIYuAH2omHmU6NOhdoolHTmBdE5GAQqiVdXEhdXzEac6LRiLXO5wLk8ce6evI02Ro+ca3oDOyYz915tmLoqt0HqfeLlV4V6573lj72RWG2q/dMYfnB9cFLAR8l9zX2M1KJroXogam9YN8fLjNxnDoRPTl+ARIMXgA3chRbUiG1BYXf44koimejlu5YI8fMPuoSloQWHnqiyG+nGb9mqhJLx1wQu9j5wQSClsTHlq/qocoEWeu/HrMI+2UFJbODQxzo2MswMGxSxcXAG0A3afU+ZFN6KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR12MB1377.namprd12.prod.outlook.com (2603:10b6:404:1c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Mon, 13 Dec
 2021 22:55:06 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 22:55:06 +0000
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
Subject: [PATCH 2/4] git-p4: pre-compile RCS keyword regexes
Date:   Mon, 13 Dec 2021 22:54:39 +0000
Message-Id: <20211213225441.1865782-3-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211213225441.1865782-1-jholdsworth@nvidia.com>
References: <20211213225441.1865782-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0263.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::36) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1eb0389-70a0-426e-42f1-08d9be8b9aef
X-MS-TrafficTypeDiagnostic: BN6PR12MB1377:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1377102FF6146634C2B29325C8749@BN6PR12MB1377.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UWQHrOe4J2CgArkjLOvtbYdyqGGMQMEgSKINWDL7hfH23ju3H939drBm9td8oEcYVO5NwuT2SFX3gQbIfHilwNoimuc1Y3m6BAhq2ih27NTbPCe3997ifmPN1Vyn9nxGeUH7V+QGji7wIBLgo1tf8Tq6UThn35Bxq+yw6aiTA5LEMV7GAd52NkE7ODDzgU2gkEuENKy8+lmstwdx9SkHs5Ps+uatiOdyFz74t/5Yy1pvmTidna55XdsJ+S6zvYTAVrYje/sx2JoGIViyvqOvRlqE1/2O9T6hZ3WUe5yqS1gMCvqAdpez0FvGYUi4AQZ7knsbwXrc0Qik91/YKBe/+x2sxORaxCscIIynF1G/ycXMBbh95Z3+2WVPonq1tyGt7e0eZyVebQ17s8yQccdZ/9vzrvm9+Qn6hW5GL13V8Fqo4h+JjClZ6vjARqMDauG/8xly5xCWhnSXuXQrDPkOj9cxUH7QWZeqA/wdxeX+a85TTigMQIr/k6j5gTmOOcx2YLCOxYim7SMATOYdTQZ3AOO/ujLPk1ihofBnwrFPY5JUNb7YkfVxRCWYkgsYGy+q9mspfk+Aksj9/C/W2eKADtsJ4gwuNScWr0pJ2/dPzQ7ExOP2Yeh7tVG9CZspI7jHql3c0VY4KdmnEk21vNj+gdT+reluD3744i8BufiVuJUXZcKx7g2hHPOiCe4h/gL3IGsNZSsdsMPu5+pG45VYqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(508600001)(6486002)(2906002)(54906003)(8676002)(8936002)(6666004)(66476007)(1076003)(6512007)(316002)(66556008)(38350700002)(66946007)(107886003)(36756003)(4326008)(38100700002)(86362001)(6916009)(52116002)(83380400001)(55236004)(6506007)(186003)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nYMvLJAn7zo8+LNh5YiYLsa2NN6SLE2ALwsUTHmqy34V/DQ4xoZ3CDU7vuGg?=
 =?us-ascii?Q?cEyXo1n6ap/Kp52Q8FXCdN5BxeyBrBLp8XXTkCGmrIchvacyL4j6rWbeZ1d0?=
 =?us-ascii?Q?hec+v3q9NktA3vECD8EJ+pe/2Wcfxurabo28aEbKWIL63CALwt3U6LxD7x/v?=
 =?us-ascii?Q?n/Jwe4CfQXqbZgBn9lI4fV+IEiKLDIICl9wLWqHbVcSGI2lVxBT5wK5N9dFt?=
 =?us-ascii?Q?mT1AI918FcpapO6/eoKwqjJFUKlHvfQ1humFxN1JrSn05EUGLALiuvUl60gU?=
 =?us-ascii?Q?Shr8BxMzBUuB1I3qKjV1IO+RIGFE7rJlZFnMBYRg3f0HPqhvmvpUq4gJsTcC?=
 =?us-ascii?Q?Um3EW9A0ipbFMQbynTflAtHiApBk7RvYYmQXy5gIMcLTT6nUX7RvfjwEKQzN?=
 =?us-ascii?Q?NRxSFZSbhxhEbT8vsY3BK4Cw063jitH/yNABbiE+xgFi6oEINTjf/ozByLuU?=
 =?us-ascii?Q?xJRs6X6X7ewqxzJGfu3IlzPLzMivY/Df7/hH1n0TopyydADpMucs5567irVT?=
 =?us-ascii?Q?ZEUlOYLfGCovQXhRINYFVoXvTXeoaFHrEJbfEuw+kK+oOfBYa/62YeeNcZEi?=
 =?us-ascii?Q?HGVW86p1NcTZgLBfc7oj/xhKotWk2llIFZ6C3nMSe4yb/E+aH0Vu/03uUEx6?=
 =?us-ascii?Q?hMTeNuj0Dk5hl7B0/xWTg+JGilZMYnUNwi3surUSwqkKkPC7+/auN9U0lps4?=
 =?us-ascii?Q?9iM6RgxCoDiVADSIH7BJgK1pSRF+vfwpZ2xVSsJ/Et9UjwGK/i842QvNwoJR?=
 =?us-ascii?Q?ZORmdEhb0TQEUrKSqLJpOF8GJEPixwE3zKpGfJfAeyIyShKyZIjKnyb4Lh7E?=
 =?us-ascii?Q?vdDUTcTBqNsQxTQoonieTNw5MImDCXDlC76rJiRhbgpT7DPMfuDfzz2vxLKe?=
 =?us-ascii?Q?u6d8uwVAW9Ae8FMVsUtIWkEjiWiiRiQs9CWtzCsobl8z7c4Ws6qxTiUuv/Tm?=
 =?us-ascii?Q?JXIa29PhNyuqoZpMDu7vK2sKeIHpEE3H+IsUs7mAbLhyG0NJBNOd9ThcqV8O?=
 =?us-ascii?Q?ALErLeMG/JSfYu+SvSQ3GT1zg/jxnIAlTIQ74dS93HGw1wLXWU1EOeLNFG66?=
 =?us-ascii?Q?JUub/YBDrcnzouURF6A4UfGYp2tAG8fnHfmkQS4RZGFxYAzF+XxaZEHyx7z4?=
 =?us-ascii?Q?kscGwSXbFC378rO4mQTBr3h/KSdALg/CO4uoCJZhhNug16P8sFHEfXxqKqcu?=
 =?us-ascii?Q?5nx3F+Y68w4uEIJWfmUkduhUBxE5k4Hpud4jf3tOGKxlAVb1AHZA7C/GHyHS?=
 =?us-ascii?Q?HLlYXa5l+14fPJyV+wE7U3zl0a0Rbd2/W2RxJJNAvzfOhWjjvKVALvG0zr2D?=
 =?us-ascii?Q?nsRyGYAN4OS7H+GzEXOSRlbwzncQAhPN7uBcmGOrTfameGe8zqLI1OKKvKyi?=
 =?us-ascii?Q?JhAn6SB0BbVl+rLQ1Rt+/EH/rJI3QdpX9c9hUi7rIkItSBtan54UpY87f2uN?=
 =?us-ascii?Q?meMOzGYyyGsZCRY0R1jxdA9hhQh3cujaYx3Vk56bcw8vLt6SMMDrca3wxh41?=
 =?us-ascii?Q?CEoDjFvjNmdxzo21tHDg9m/V7SAeJV5ORH+Zn+FTt5P1SU4EUnwSzVUa7k8X?=
 =?us-ascii?Q?zi9hX4Vla4afUtH56Jte/aNCYpkQJMe5L62gJEnntB9T1rtW+P+Iy7obCJ8V?=
 =?us-ascii?Q?OT4gm4XjZRFlvEr0qkJBj0Q=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1eb0389-70a0-426e-42f1-08d9be8b9aef
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 22:55:06.0937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbqirBuP7rgJdvkz1rQv0K4uvulDFnvSt4TsQ+GR7NWStjpcgpuDw+bySmGdLrjtYdQjJEuRO1ko/sNrTP3xNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1377
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously git-p4.py would compile one of two regular expressions for
ever RCS keyword-enabled file. This patch improves simplifies the code
by pre-compiling the two regular expressions when the script first
loads.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 48 ++++++++++++++++++------------------------------
 1 file changed, 18 insertions(+), 30 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 226cdef424..0af83b9c72 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -56,6 +56,9 @@
 
 p4_access_checked = False
 
+re_ko_keywords = re.compile(r'\$(Id|Header)(:[^$\n]+)?\$')
+re_k_keywords = re.compile(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision)(:[^$\n]+)?\$')
+
 def p4_build_cmd(cmd):
     """Build a suitable p4 command line.
 
@@ -577,20 +580,12 @@ def p4_type(f):
 #
 def p4_keywords_regexp_for_type(base, type_mods):
     if base in ("text", "unicode", "binary"):
-        kwords = None
         if "ko" in type_mods:
-            kwords = 'Id|Header'
+            return re_ko_keywords
         elif "k" in type_mods:
-            kwords = 'Id|Header|Author|Date|DateTime|Change|File|Revision'
+            return re_k_keywords
         else:
             return None
-        pattern = r"""
-            \$              # Starts with a dollar, followed by...
-            (%s)            # one of the keywords, followed by...
-            (:[^$\n]+)?     # possibly an old expansion, followed by...
-            \$              # another dollar
-            """ % kwords
-        return pattern
     else:
         return None
 
@@ -1753,15 +1748,13 @@ def prepareLogMessage(self, template, message, jobs):
 
         return result
 
-    def patchRCSKeywords(self, file, pattern):
-        # Attempt to zap the RCS keywords in a p4 controlled file matching the given pattern
+    def patchRCSKeywords(self, file, regexp):
+        # Attempt to zap the RCS keywords in a p4 controlled file matching the given regex
         (handle, outFileName) = tempfile.mkstemp(dir='.')
         try:
             with os.fdopen(handle, "w+") as outFile, open(file, "r") as inFile:
-                regexp = re.compile(pattern, re.VERBOSE)
                 for line in inFile.readlines():
-                    line = regexp.sub(r'$\1$', line)
-                    outFile.write(line)
+                    outFile.write(regexp.sub(r'$\1$', line))
             # Forcibly overwrite the original file
             os.unlink(file)
             shutil.move(outFileName, file)
@@ -2088,25 +2081,22 @@ def applyCommit(self, id):
             # the patch to see if that's possible.
             if gitConfigBool("git-p4.attemptRCSCleanup"):
                 file = None
-                pattern = None
                 kwfiles = {}
                 for file in editedFiles | filesToDelete:
                     # did this file's delta contain RCS keywords?
-                    pattern = p4_keywords_regexp_for_file(file)
-
-                    if pattern:
+                    regexp = p4_keywords_regexp_for_file(file)
+                    if regexp:
                         # this file is a possibility...look for RCS keywords.
-                        regexp = re.compile(pattern, re.VERBOSE)
                         for line in read_pipe_lines(["git", "diff", "%s^..%s" % (id, id), file]):
                             if regexp.search(line):
                                 if verbose:
-                                    print("got keyword match on %s in %s in %s" % (pattern, line, file))
-                                kwfiles[file] = pattern
+                                    print("got keyword match on %s in %s in %s" % (regex.pattern, line, file))
+                                kwfiles[file] = regexp
                                 break
 
-                for file in kwfiles:
+                for file, regexp in kwfiles.items():
                     if verbose:
-                        print("zapping %s with %s" % (line,pattern))
+                        print("zapping %s with %s" % (line, regexp.pattern))
                     # File is being deleted, so not open in p4.  Must
                     # disable the read-only bit on windows.
                     if self.isWindows and file not in editedFiles:
@@ -3026,12 +3016,10 @@ def streamOneP4File(self, file, contents):
 
         # Note that we do not try to de-mangle keywords on utf16 files,
         # even though in theory somebody may want that.
-        pattern = p4_keywords_regexp_for_type(type_base, type_mods)
-        if pattern:
-            regexp = re.compile(pattern, re.VERBOSE)
-            text = ''.join(decode_text_stream(c) for c in contents)
-            text = regexp.sub(r'$\1$', text)
-            contents = [ encode_text_stream(text) ]
+        regexp = p4_keywords_regexp_for_type(type_base, type_mods)
+        if regexp:
+            contents = [encode_text_stream(regexp.sub(
+                r'$\1$', ''.join(decode_text_stream(c) for c in contents)))]
 
         if self.largeFileSystem:
             (git_mode, contents) = self.largeFileSystem.processContent(git_mode, relPath, contents)
-- 
2.33.0

