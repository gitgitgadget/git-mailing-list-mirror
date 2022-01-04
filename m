Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEFBC433FE
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 12:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiADMti (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 07:49:38 -0500
Received: from mail-bn8nam12on2067.outbound.protection.outlook.com ([40.107.237.67]:42113
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231934AbiADMtg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 07:49:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Js1yS+mxucWYQRX7sGuInvRkq7WJ6h1fNH/AJ8QMTDBPMdwSTORvDSGeX3OYXRjHmm7U5bw7wCA5Z45xyusf3HkcVBQclE4S6h3iilrppcAGuloSloEOvohofCnVJ1VO8j8gT5SdWfDEwCM+RuUCZfc9d2hBc37wiFAjqM32fQZr+jkMLeNtzX7Vcsr5FyLLbPGEQGPSyknYDKZydFL5b8OPESy4bV56OUwLGW3s1XXsg7JQlyWXfkt2xwOKSuI0Wmz3ANYO2mPxtkXWGBSDo04Ag4supSc+O8RqTXJaNBvipeDGr89ho0otR3jwrWAJANLcxmxwFTbRCRnxy88C5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UtJwWaLxcuO0LcZQE6toP0jWfy05EyFdf93XDYv62s=;
 b=VAHleuWaI8Ecg6VZ/mRBFMcZ6HezNVKegwUkJYU1h7KGMDTMdKvfpfa23DBdG1q7y3rrYXicSfuY7ElGAsByDY5c2RMIls21D4gYXWto06H+e4CynlIxgJ9D1SpuoPM6mh/zUScxfiP3E/PT94ZXzX9oLSxYWpE+kVmcVWw1055yxRrOwLhfQz3LL9Hkwxusg9UlRQP2YPtcEYGvoFBQaptkUgl5SJuJrVf4pLOJiLlmvc351MKp+V7DMQ57JYv1wnslv8yb+XstVevv2fXJUYC0eZFHTU4ZjsmBw9J80YSJW+uCaO94cvfeWP9u2SXCtqmO9AQvqiRRG2Tvlrahhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UtJwWaLxcuO0LcZQE6toP0jWfy05EyFdf93XDYv62s=;
 b=lX0Wu99kYVurvWhV5PIOM2jdAVQv5E9oSw0IlCucQTHUq2u8umQB1sf7ow02tiYgCdYP3bD9ELy78Tv4Y9HQlB551E7LQr0qGrQkuedqDFYKejnXsSljPQWMqYGQxEQd8qhkRDVAKZnX6RNuUCWuaOOrtZNI3sobWPaSSAJVxPQcja6wk6FZQQUnKxk/ecysi00HYWmPrUaIicQ7kLxYBbRenFW9I38REI+MK1Ad3rihCU8VYO5FasdWdOwYiLR/tbQdlTAcjCfZqLJ2lXGvCpz4S9S4PgW8WsBxxVt/5rWoavZlKMIqoQRhEESxPZT8vK4+Sk8Mhn0FZn08sp/Mbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BL0PR12MB2500.namprd12.prod.outlook.com (2603:10b6:207:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 12:49:34 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6%5]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 12:49:34 +0000
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
Subject: [PATCH v2 RESEND 2/5] git-p4: pre-compile RCS keyword regexes
Date:   Tue,  4 Jan 2022 12:49:10 +0000
Message-Id: <20220104124913.2894-3-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220104124913.2894-1-jholdsworth@nvidia.com>
References: <20220104124913.2894-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0014.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::19) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47c32111-bf09-45a8-f4fe-08d9cf80a8db
X-MS-TrafficTypeDiagnostic: BL0PR12MB2500:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB25000D98ECD870173D6CFF6AC84A9@BL0PR12MB2500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TqTAvMKAOB3GyXf8KFFNgwtdtD6weDCZKMzGdAlYBhspbtFmTuYD7gAvsUW0d137pGh5xTSzvyc63AU+fCABTTxjx+QpFmSGZb8LWBlPv81p9wKoIrp3AdZd35ebaeI7cGXNvpTggTKJKLLswj++vp7mf8R9cMcq2LvO1jGv27ELy2QcYpdwLoXQo/+B7RfuD6N01q1d7vfOlQ7aoCOKCUAIJHxHfBXIkH8MBZQuKvw9KVwvpID9lQeyy/joOgQRkdi8+F/7akhJcMzE11lOT3TLNXei3MHLlxu/EOUc76wq4lzbOVDSmz/e54duZ5MoZ6ETOwfFtTzHpOO2ejHDlc3WOCpxUUu4rGb1vNVbD5qd6dM9HclLK917kvEARRgpnVLcjdXuNI/DQirio7wNTo792OVtfO7KVN2QxMmuZXZwAgFblbAwd25B9WAuDD2FhRRuyqn52vK5wOEkQxqfAsWIjypNxQEJhsTo7WvR7hm3g1JrAbX+JR+jcLIExI4BraWuTPSlrNWIAqY4ePkzNOU1SmWvy4REVc5Da2PQE2GF7orhJLSB4SvcwOAJEmk22XJVFkos+n1f1ErNWFKPaIs0+YGH/vovBFzn5TG5oc/hPtrsqTt2lHr6AareU8fWt+0Y6NHz2XkhAvhbFpHY4+7NXnEl3FgVH9BoM5lWJrCTP6Qc7w70uPKP6FPLa3FY47YxotkIbc3pXRUesxILHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(66946007)(38100700002)(6486002)(110136005)(2906002)(26005)(66556008)(54906003)(66476007)(83380400001)(4326008)(86362001)(1076003)(36756003)(8676002)(6512007)(186003)(5660300002)(508600001)(6666004)(6506007)(8936002)(107886003)(38350700002)(52116002)(316002)(55236004)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uubtk4gluhqtYsVDj8ly4C+0nUaKwRyjSXAGwDcvH7Owlta5QDaKZb0pD/iz?=
 =?us-ascii?Q?Aca885kBVYOmJz8M15VjpVXSYUa+rZJ2Z3HtaMkzD+EavxV0DN4r0mcjAFQm?=
 =?us-ascii?Q?9KrPW6+RPP7VFFL4Ls9mgQwwaQ+2/wpv4eTfX87aj2q6WVyoCJ0pSmYgR8ll?=
 =?us-ascii?Q?4+bQrTWGxvmhXyfe5XfcUUmaG6cX3HwGKkQOwnxyy05qiUthfpvC2zbPicqq?=
 =?us-ascii?Q?27/q440OGbNiZ5bPlbwcCFnGOQ5N4tRvmsLT6zqXeW6ngIhdbN8mErc9UhjA?=
 =?us-ascii?Q?AuRGTkSbNd3IoIA2l2enbTH3PC2wwfArfZucuENmNZjwEphxni84KPr15EUH?=
 =?us-ascii?Q?eoYhRFTA/x1rxZlw75at+bXxyF8NtvmoXCvQHyk355NuRCmhzm2BA3Zw89z6?=
 =?us-ascii?Q?8/wFpr6wr7TM7rNICbL7cBnL0f31UvdKMybHP8IQ8x6bu1cG/GN4M6GoHfto?=
 =?us-ascii?Q?cSyufesPc/i7xtVM/xHDIiZNLL+BOuwDuxnhN6y5GLhACP8npNokZMbvRlqk?=
 =?us-ascii?Q?FvFFFjgz/qOBGQgQtM37g+Jl79xepJqk328iEOyIGBGpCaJrGKD62iltvCs6?=
 =?us-ascii?Q?7DGcDoxIMcktmVPf3NOwCVfTA/cpIvukJBZ8bTICyHjk79I86GYQeS9bntbn?=
 =?us-ascii?Q?jzgzNeBSoksVTX5ahDFmcqJH30cnhXlNyJcrWtRJergddLDUKQL4mnbIiDfr?=
 =?us-ascii?Q?xGzicJtousavKhs4S88jMpl/2Lr+8kzO0TwBZ4kVusU5Js/Qh5npHXUI1OWV?=
 =?us-ascii?Q?F66s3xInM0uJYeD72aP9v8S2aNhlc1P0bW0LeDYWlpKO+k8xGASbuntxN26V?=
 =?us-ascii?Q?TvHU53g9YSUZiAUH09M9Nucx5HEqc7Jad2wxguNJUwYKjg4VU+GMfBpwtNFw?=
 =?us-ascii?Q?o6+ff43SAhDjcMJ/p+nEWDqYEy5DtZx5ZcDYH2oyziPAC3ZbCDuWEgxUjh+x?=
 =?us-ascii?Q?RZPnYIWk7ispTj9njpSFQJxixH5OQtUrqr+O/fhsZEsyJYAha42j/pPQGnql?=
 =?us-ascii?Q?jwhjZR8hHyyDI4BdxIkVssyflqF6ZPAkX2bE0BezVBN2hVY9hBHSMYSaNOX0?=
 =?us-ascii?Q?L0f4wu3sssNiAdPoUbQ6eez1mdcZQdXIsoLGzfGOFblJbvWT9qsBBDAcs2aP?=
 =?us-ascii?Q?6/C4jwBtHJWIQWQfUWN3Qm8LSdPMAKIWu/3EqCgeqEYoo1rLssbafUZz9irk?=
 =?us-ascii?Q?hQpXnS2j2/V9mpEqV1e+zrYwMHmTP1t/vsgc5vOsSA75pNBAfzaCHRhOsVKU?=
 =?us-ascii?Q?oiywfeqDJWJU6mtSAgH52add58bsYAwKrnF8PTEg+TXK3NWeSqRgDnDLCxHK?=
 =?us-ascii?Q?oHmwcV4VMes6iLJcNOS4sydd6equuwh4S6nB7XhEWto6exFXhqtlkBXnOxYE?=
 =?us-ascii?Q?ac5MZBHa8x9pBvAzNPa+NuWBXiDn66FVcgBfqX5UbmiveRIycDWKJJKKHFfQ?=
 =?us-ascii?Q?36zroXb8p/NfG+jmpv4ORKPYrI54SUJe1biD7jcu6+MepL3DxZlNf8NH4+yK?=
 =?us-ascii?Q?e4EsM+23PiyBFtaq1q7NZ2G0PyqRsE38JmEe8IcKtupUM/6rDImY1PMQpklL?=
 =?us-ascii?Q?Y3YYSa//+num4NaZ1dh6NUjLJ0lI15GuopamEEIhFWPaiVvy+REfj94gP6+Y?=
 =?us-ascii?Q?yGNO+mqppv2vllZneePw3YE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c32111-bf09-45a8-f4fe-08d9cf80a8db
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 12:49:34.7886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/3FK8ZSfCZRDWVHQoXjhC7ZSBsQWG5eoyXS4zOMnEJegdAimuvDrVO1TcGR+lWo6tXrRsrXFkvMC/EppuWWXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2500
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
2.34.1

