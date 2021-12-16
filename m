Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEF9C433FE
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 13:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbhLPNrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 08:47:32 -0500
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com ([40.107.236.89]:46689
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234473AbhLPNr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 08:47:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEIwlGM1gXk8IEsU2fgSH7mncGwlQC4tCD6ezyunwcFT3Dtq+jLJ2libYcmfcmsB6TN18hVIJMnrn+pz2DeLUdOyY6rbsbJethynCK474VzdmSjgWbu0/B29xAP7fPpGJqQRUe5IMlxt4DrXsW7iGTiMXSWK6MqUWq43K3qdD3nYZi+6Td2B5E4Kux97tZfyrZ04Tsyu3ZFQ4+fa/YoNyczetrOP+Owb2Xzm0qXx6/biBTR7XbD2ac3T7EwFwIUn1VQdOHlnxKBC2XXb/q1nyVMxLb7UQQVa36SGt+L2PMrdMzwXxOU3GaSI5xM0D2Vm42+UnA0GfU34ILcsmmXDkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFaeKCgJ+164wJpamcTyx+jAqUbfgWut7lg94cgI/1M=;
 b=Kk7ZLSddgcoZjQ9A3pJmIc+rJ/0SmfM01jiSs21Ts27JPw1RCU7qOUP5mnvzOY+1FDbXCuR+gufLzjdBfHFQ3ZOn976+xng+jhthi7s19op73anF+VVZDRb5MJrn2AWQ6brQTdB1NY70XwDiOSTxKGVaoM1oLhtxqbs+P+hz+XKVLBHzOC0Kb2kiOGsH1DgO+OlBAlrOXwWxmFzFYSVFyn7davL97a28UufQUSMfz+nExyXo6/ZGv3vV/4fDUhnK6z60S0DfJO6rLDydp8/oNXqCqQjv8mWPfzEuJeXTGjQuqR8lgUVG/EJ0e12YetPneexK3y9fCQAtXH4y/DUcYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFaeKCgJ+164wJpamcTyx+jAqUbfgWut7lg94cgI/1M=;
 b=RkGlKcYh4jZngv7hwaBl8E1XNq248sDD2uEgUr9kPPzOt3Se/87t4idophWmm+R9xgVy1xulCWne1jPvCfikE0DIMJp0ALuOHkf2GQsKD6e6LeCEaN2EUjtC2Fq3NuacLCgzAhut6wXJ2GpNKYWia6B7CRfmVWFUVTE+BzIBOCuhsUvQ8x9ej0Lhpl3bb/qy6sOPPcwcrP9094fnoXLIgutoLG4OCVtGlHf2pKqIjRJfnZn2+y+rXTLsMsyTc9pWrEcOBYAT5rcLLIE54d8kH24wPTk1zxRBrAZxf0f58kx3eJsVucRO8dhJYqvgvVy1SGiOpBfEyr+v2h7Le3u0cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Thu, 16 Dec
 2021 13:47:27 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 13:47:27 +0000
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
Subject: [PATCH v2 5/5] git-p4: resolve RCS keywords in bytes not utf-8
Date:   Thu, 16 Dec 2021 13:46:19 +0000
Message-Id: <20211216134619.2048348-6-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216134619.2048348-1-jholdsworth@nvidia.com>
References: <20211216134619.2048348-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0028.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::33) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8989b1d6-3657-4e3d-6229-08d9c09a98d8
X-MS-TrafficTypeDiagnostic: BN8PR12MB2946:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB294602819EBC3BB53C5F38EBC8779@BN8PR12MB2946.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6R279IMyXcPU/8S3Y9/voUn7D47QjCtE2EPOKZdRULWZZGlGP9iaDBzo/v3P8JemSdEC+LQeegElJB/SwjhBYKC/BITuoAr4zxRonRDodHuZhTkXXbJqUNGC2ygdvmNw9fxHdE7gnhh+CFJoIM9wE3no7gHnD4HXPW9Yw1asIll+zy+wfy9HTBHKc94P129nu4DYzrPPzkHT/ajzId7e+arth/4TnlYveLCZA2VjHVLfwHNqTutyI64oFTT1hKqgrZMUSp0yAAHf+iP3kZu+EHsNPWoc87Xt30dllGL6YD2mUETCVLS7pK+bpPj/yrsw2WD+dOrk/XccBHoz3olZTtoE8bTk8Ccty4AflfyHKAi6EGUYYNm6ovMNO8n/RcYjnHe4nNZigrxriHFI929ggZiHjDv1kUFPt66FLRvR+Dl4HlDHT4f8DhZmOa3GW6o0NX2TlJfx30kYj7501sSkvrcWlDn8dl7y6/9hdNtPXaj14nag5HPaOvHlkO6UKWoPaFXaw2NCUYmVM3/nKA04ujxbgq/m1YebrHac5L51NWZU7DEiOLrJokT6eXexEtRw/kvTZJ/t9XpYXREc5IQ/Heyv6gkpDuv/tLFUDFwUzb0zN7hWN1Yk7HYXDO7KaZOCBIRwpItO/VG9g+oopBoCqaWyM8fJ8fR8Oh1oVKFH7nfMADhMpcsqT/V5DawuNT6DJoVIGKZ44VhcMSzizT8mZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(5660300002)(66946007)(508600001)(86362001)(55236004)(54906003)(66556008)(6506007)(6512007)(316002)(1076003)(6666004)(6486002)(66476007)(8936002)(26005)(6916009)(107886003)(4326008)(2906002)(2616005)(36756003)(186003)(83380400001)(52116002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KzPqi3kjfQkYHHdse6Z2N0g35sK47c7kHq3M21qTVluV1yU3CcyxoVZ1Idml?=
 =?us-ascii?Q?GfLhTqwXuPnDiZUSHLRIS663wGOzLN7Me42yspxLksqdAuX2HD4LcIne+C2i?=
 =?us-ascii?Q?YSLRmI/4SQeq/YZTqX8S6YpsAkeJBOxt7RGbvmeHhV+4399Ng1PeNSbiyJyp?=
 =?us-ascii?Q?QNHMh4M5MxJVsEO+ZNqcD49EElqD58k7ffCqKDasayFRGDAZiDDOzZlpudRn?=
 =?us-ascii?Q?TQHhFzHAGM7jemOUSJY4ahEKZUbJZsht6DDaO2g6tR4DC6RymJ8f2hGRrVhY?=
 =?us-ascii?Q?pKFK2P6RpEPh76cvrbtmWWfNUnlyl7U1yiZD4rutd5O1HyLm85Y6zfVmrQ1e?=
 =?us-ascii?Q?hlUV8lhz5ablONCN91nqoB2JIEldGyRjZXNDKWHQIP0ri2pRfo4qK2wjO8OO?=
 =?us-ascii?Q?r7h0B3bAURF47BcTkQikd0WpmAhu+7e00u5I1RXXjwOusvEiUlywgM9WyDnM?=
 =?us-ascii?Q?vxcMuVb1yoiMPzMEOe8CM6h7xlen7OB2Zr0wksrOTHarIbgrQhlWqN4ktNwP?=
 =?us-ascii?Q?06ugZ+SqnzHmreJBU13GNPPsbDVfq8qEXvPEep3osF/s6AvFrByxPxy6VLl+?=
 =?us-ascii?Q?7ZV6CskD6/t11ahRX2Jmp1O3vQaNWUw4OKqAzwmIM9FrHqsbtutgLDfuqAbO?=
 =?us-ascii?Q?QRHBrwXasOUUAL0CKD+wTU4gVYoj4VsxlIn3iY2jvwS7CMW55zyIBRpxI1z1?=
 =?us-ascii?Q?uKiBBB2UJQppgwJH7Hbs9hZBM8Vsw3mYH0vl+l8mGUhIaNr3xs5hMnMw+V9b?=
 =?us-ascii?Q?yVQ6F6ICFjWaMspBTljg7uNciwfH4BIUByUz4gEVXVL0Kng3ZMstmVkqgurG?=
 =?us-ascii?Q?+wEHRtKqQrCViEuxUOvsk8aZdV9hvZF+/kUsFL0fcSshk2DYmYNSAnyx5rWX?=
 =?us-ascii?Q?rMeCums6JgxsrU04I6i9HLB2s2PsKq62VQewQPNJECUyNLmXFYoBwQIHMWhA?=
 =?us-ascii?Q?8FIqW5y80BY8B/lrjIIqQZmGAqsP9djLVJW1sk8Ix05qudOpyNL0OkETqV4O?=
 =?us-ascii?Q?7pjOuGA3edWBfN3pzLvygSLZyLaVvOKLQyRsX0TehF9UoZ0wuIDMxcDVknW2?=
 =?us-ascii?Q?Wrt2vNeVNO1jwWBt3lGmmE2+r7iHeCHgfJaDqN5jegat4HR8bMPt9nqlozsB?=
 =?us-ascii?Q?vIfDjR8EoEJ/d1NIZxqs6K08Ba3t6q07WhKH6Ys0Mvc6GfwNTNnXva3xbrJE?=
 =?us-ascii?Q?WJQ5RCqgySuPCeNXEXDSmWujVIu06+FJEuBPcYRJMZVf+80I7ATJiqQYVmc7?=
 =?us-ascii?Q?rslAU6XlBSkvbXrVvH+Jk1IAY8TSMnBLbLzCkq0teWOPUoCce7zfNh7KZ/mq?=
 =?us-ascii?Q?FGHKASYpUq6EdH/VCurk1AZhk6XHD66Dri7xp6ovi7urtlJ1NozmxOSBb0/R?=
 =?us-ascii?Q?FrPYoM9OcGetOL2yohXw65uQe2UIgzhqIZEUu5R4GAXKLjbQSvrIcw+b/hXZ?=
 =?us-ascii?Q?kv9QQ2KkE9wI0Jme/aH6wA3/wzGAkcSJmSUH6GnV9Wo8TcrtpMTAJNArQ1dL?=
 =?us-ascii?Q?KpjXuSrvh++R0ts9VdxbbEYHyoV0252D3ROw1R4ciTNDDZlGNaMKfHX7S/tm?=
 =?us-ascii?Q?HHosCw4Z82+pomCoT33fVtnm+Lpl2WiAujLfWxTWHqhOJ/idD2dDbr3ktjD4?=
 =?us-ascii?Q?CAmg0J8q+A5U8y4lMN5kG04=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8989b1d6-3657-4e3d-6229-08d9c09a98d8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 13:47:27.3698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jjFN4JshMcvdFkwx01v/dNQh+o0+MRLPm6KyqTpi15GoPzg/DLKuPumHRsPDr7tKF8MkAcUezw2pLsxeaT0yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2946
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RCS keywords are strings that are replaced with information from
Perforce. Examples include $Date$, $Author$, $File$, $Change$ etc.

Perforce resolves these by expanding them with their expanded values
when files are synced, but Git's data model requires these expanded
values to be converted back into their unexpanded form.

Previously, git-p4.py would implement this behaviour through the use of
regular expressions. However, the regular expression substitution was
applied using decoded strings i.e. the content of incoming commit diffs
was first decoded from bytes into UTF-8, processed with regular
expressions, then converted back to bytes.

Not only is this behaviour inefficient, but it is also a cause of a
common issue caused by text files containing invalid UTF-8 data. For
files created in Windows, CP1252 Smart Quote Characters (0x93 and 0x94)
are seen fairly frequently. These codes are invalid in UTF-8, so if the
script encountered any file containing them, on Python 2 the symbols
will be corrupted, and on Python 3 the script will fail with an
exception.

This patch replaces this decoding/encoding with bytes object regular
expressions, so that the substitution is performed directly upon the
source data with no conversions.

A test for smart quote handling has been added to the
t9810-git-p4-rcs.sh test suite.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py             | 15 ++++++++-------
 t/t9810-git-p4-rcs.sh | 15 +++++++++++++++
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 7845210e69..986595bef0 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -56,8 +56,8 @@
 
 p4_access_checked = False
 
-re_ko_keywords = re.compile(r'\$(Id|Header)(:[^$\n]+)?\$')
-re_k_keywords = re.compile(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision)(:[^$\n]+)?\$')
+re_ko_keywords = re.compile(br'\$(Id|Header)(:[^$\n]+)?\$')
+re_k_keywords = re.compile(br'\$(Id|Header|Author|Date|DateTime|Change|File|Revision)(:[^$\n]+)?\$')
 
 def p4_build_cmd(cmd):
     """Build a suitable p4 command line.
@@ -1754,9 +1754,9 @@ def patchRCSKeywords(self, file, regexp):
         # Attempt to zap the RCS keywords in a p4 controlled file matching the given regex
         (handle, outFileName) = tempfile.mkstemp(dir='.')
         try:
-            with os.fdopen(handle, "w") as outFile, open(file, "r") as inFile:
+            with os.fdopen(handle, "wb") as outFile, open(file, "rb") as inFile:
                 for line in inFile.readlines():
-                    outFile.write(regexp.sub(r'$\1$', line))
+                    outFile.write(regexp.sub(br'$\1$', line))
             # Forcibly overwrite the original file
             os.unlink(file)
             shutil.move(outFileName, file)
@@ -2089,7 +2089,9 @@ def applyCommit(self, id):
                     regexp = p4_keywords_regexp_for_file(file)
                     if regexp:
                         # this file is a possibility...look for RCS keywords.
-                        for line in read_pipe_lines(["git", "diff", "%s^..%s" % (id, id), file]):
+                        for line in read_pipe_lines(
+                            ["git", "diff", "%s^..%s" % (id, id), file],
+                            raw=True):
                             if regexp.search(line):
                                 if verbose:
                                     print("got keyword match on %s in %s in %s" % (regex.pattern, line, file))
@@ -3020,8 +3022,7 @@ def streamOneP4File(self, file, contents):
         # even though in theory somebody may want that.
         regexp = p4_keywords_regexp_for_type(type_base, type_mods)
         if regexp:
-            contents = [encode_text_stream(regexp.sub(
-                r'$\1$', ''.join(decode_text_stream(c) for c in contents)))]
+            contents = [regexp.sub(br'$\1$', c) for c in contents]
 
         if self.largeFileSystem:
             (git_mode, contents) = self.largeFileSystem.processContent(git_mode, relPath, contents)
diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
index e3836888ec..5fe83315ec 100755
--- a/t/t9810-git-p4-rcs.sh
+++ b/t/t9810-git-p4-rcs.sh
@@ -4,6 +4,8 @@ test_description='git p4 rcs keywords'
 
 . ./lib-git-p4.sh
 
+CP1252="\223\224"
+
 test_expect_success 'start p4d' '
 	start_p4d
 '
@@ -32,6 +34,9 @@ test_expect_success 'init depot' '
 		p4 submit -d "filek" &&
 		p4 add -t text+ko fileko &&
 		p4 submit -d "fileko" &&
+		printf "$CP1252" >fileko_cp1252 &&
+		p4 add -t text+ko fileko_cp1252 &&
+		p4 submit -d "fileko_cp1252" &&
 		p4 add -t text file_text &&
 		p4 submit -d "file_text"
 	)
@@ -359,4 +364,14 @@ test_expect_failure 'Add keywords in git which do not match the default p4 value
 	)
 '
 
+test_expect_success 'check cp1252 smart quote are preserved through RCS keyword processing' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		printf "$CP1252" >expect &&
+		test_cmp_bin expect fileko_cp1252
+	)
+'
+
 test_done
-- 
2.34.1

