Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DD1C433FE
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 12:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbiADMto (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 07:49:44 -0500
Received: from mail-dm6nam12on2051.outbound.protection.outlook.com ([40.107.243.51]:21462
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233176AbiADMtm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 07:49:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5Q4hplNZR5cCoBs9vU+Dyl1bOBg92UYVaXrAJOvQ2Wp6r7ytobY25mAehcI9IQcfy0W2u1o2ViFbz1gz8K/ie9oIGgFrQThO1MwJeNW+/utyge9L5nu2nj4Y/XVcZq99lN5zvI/jcHfDdayTmFkIyu5Gq8/4ehiCMSsVOTHxyKZS73PCQAb7DNAiV4FCJaJWRgMAI23KnBFAsylW7n4yWJ0zP2GTYcoNFtdc9I38aZ3ZtqUIrGzJ14yj/YB/Tr2LwkgfqJlAdL4uuU1W0imuJcOHXIoefLK1Bd/xzQTiTq31QTc/z2ADu3p9ndFO1eD48B3suQlZkglPe+slRC9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFaeKCgJ+164wJpamcTyx+jAqUbfgWut7lg94cgI/1M=;
 b=oZDvm4tMn0RAHJONdtO47UAvtKu3xPXF3EC3w/a7AUUZ1RsTK5nL2jMudzdi9l6JbWLmPPDvy15qg2AUlo4oIp+obgboh11mcSly7bd6sggBxGoOdqJry/pYaB2+mUMtBZa+GObMH+wYCXSblgSPR8rPfooeXD854t+ERFrxkXRX1nOxNT/ZuuaaQxkvLwcCDxCKHKZt5gOWpK2YCs1OLYu7xIncdbQxRAN4d+Ld57HZNA25NI4+PETNZhGEqk31tP/heGlIYMPUA2r2eGO6CmbS5F5TlR8LFa82wqzat3dfy4KxMgTHnsvsjAgXgLTGG3lfRv5DO/o4lRv4cyym7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFaeKCgJ+164wJpamcTyx+jAqUbfgWut7lg94cgI/1M=;
 b=VZUr0zZxyV+e0yUl8RyNyydx+2JVYUsJ7f5SUByeeKaWL+RWP7/H0V0cWhvykQ1JZ3LWm6QGGuo7Zp8pGTQloCt9qCWrcjIFHekaBENJa3YoGXHqxeh+/Ql5DmqVhch1EnnHpMNEFrj01VhuqKCcoxq86Ibz57urvEZvLwaguyoDQG/2/ntT6rxAgSSDLNiGLIOaviadUwX1De1QRSQx9KMwUN9C8Ond3bWd2LMCWmHUBOJiQ2y0teferPwu8oUKpj2MiSx2DvE5l1r0oo0tgk/gdeIdrbQicHlPa6sKq+RFawyvl6Mbo8/1LEVBbDSselcJitj7MnOdYk5lW1hFiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BL0PR12MB2500.namprd12.prod.outlook.com (2603:10b6:207:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 12:49:40 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6%5]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 12:49:40 +0000
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
Subject: [PATCH v2 RESEND 5/5] git-p4: resolve RCS keywords in bytes not utf-8
Date:   Tue,  4 Jan 2022 12:49:13 +0000
Message-Id: <20220104124913.2894-6-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: fa6201e9-00c3-4572-27cc-08d9cf80ac53
X-MS-TrafficTypeDiagnostic: BL0PR12MB2500:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2500BB0AFFF44379E29E6138C84A9@BL0PR12MB2500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gz0io49wIW/cqz7PywkUHIsMpYQXGIIMHCbcYlvLHxv5KQVuGmdTe4QlxjYJPwiFePtp2YwrUAQYdVqmx98+/KkcPym4KREkZPuU6khruHZPNZoIYZMjeCgroUWKs3T3MwQmVCgqdK69qEud24AFwg3VYPbQiQotx7msecVEGNtjGTo4PltTNFo0yt2obvQfpzWC0xOBvEJ1U0QVpJN7tlTjQHjKQB4SwTecFW+L6j2o2qjfrLbkyGophu4ykmHmg1UVdPfT9xjj5Duc44Gfiwz9PMYVabuvRBtKhfz3Nv5mg8QQvE/6jaHcCi2unYH2v5TNlwjjbEeveZ6l5GB73zgEGT8RYzbPbtfsH0Hi0zxIJlkfUziZ0hLrktM7uBFEX9tO6cR6WRw72oBJV71XUuqJ8BlYdB85p7cepxm5wjAg9JZVjyJq9AL5tLn5p5myW0DHAt7DCd+dw6LKU2bqRi6MBy4hvm+JBSpmhYmtjwfYYMcvtOLgU5pFavEHtRO5om+mKT1yDt96abI2JdQOj5fnUmxIKjQhE+r/6Pwf2MFinntKZRTUCaPna+Z7mc+5CDqZNxb7HPw4XJfHdNmP5m/dpwKj5Y3a7TmOZc52GMecmnQZlV1QDh8A35cCuUQjeIZd91ibwAz3cegJz+Gy2Xl54SeAujjIb7awQcuoGt05FCQMhjcUytlVWK3OLWb9wvTp/nnyCBb1MM882L5+8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6506007)(6666004)(508600001)(55236004)(7416002)(316002)(107886003)(52116002)(38350700002)(26005)(66556008)(2906002)(83380400001)(4326008)(54906003)(66476007)(2616005)(66946007)(38100700002)(6486002)(110136005)(36756003)(186003)(5660300002)(8676002)(6512007)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1OL17WT+XXkAJafszoY8imV6djzOChP1o3LWkINSO4p3uGtCPgwHSF1k7WXB?=
 =?us-ascii?Q?jSUzCQ3IMCKKOQl53SHn9A0ch2qQTC8FmchyBbfa1OkmXcCx1sYyOinPaVWj?=
 =?us-ascii?Q?af+Mzq/qr/ypRpDyRxW1+4Z4BfKB4lzrUcvhfVOu47M8xzbHtZ0iuulH8k89?=
 =?us-ascii?Q?iSt/Ch3NO7IngwEST9EW1fSZYofXqZyvdfo9O19aQ1i+iIrzO4oy0M8EZfPS?=
 =?us-ascii?Q?yAllJccbONzE9S5FRVSDl9IJbqXtlzgj4QhhwRPuVIpx2ajSluT4CCgSdrCg?=
 =?us-ascii?Q?FtOSDOxbi77t1L1eMdRcCmnkLf+4sK92x2yg8QUQSeUJtW5fBEnuHs/muiWu?=
 =?us-ascii?Q?z6Zvmmy2owhi/4Z80hIVPlm85Vm06ztbmMuPoyISB271G6iVcJsBgzHFCfgR?=
 =?us-ascii?Q?Qg7KJIJAJAtiF79Kk1v4S8cVG/EVDq4xuwL63s4kVQ10R/Kqh9Y7AOjLduTP?=
 =?us-ascii?Q?fhwGuE6/A3jiwOWns2OJnzWs3kk7/W8n/5c1qQml0uLVTjtqs45LbS5D3i60?=
 =?us-ascii?Q?X78zQCULItzhGJRLLo1FcAOv0YxxxE3lVZlThXXBQrGHOKIHv4mMeyksXeIb?=
 =?us-ascii?Q?g8G9IW/ddxk2DQKspxJnta+u/zvXL7zfAvwlXPPCCuTfABDY6qTA+2Uf8zqM?=
 =?us-ascii?Q?gCCW+DELBYyO0vGJatXdGPorCZmEYE/6wQP+D1VrsxtA3Voy4ZMNpJp9IC9w?=
 =?us-ascii?Q?vv2veqK+AYuccZu+/yqLHpE8GY/ufmyCclaU5hvCDv3DOnjxP0XpTIqBGG97?=
 =?us-ascii?Q?tlWCvVbTNWmwf67CK5IVFfePkS2uexCr4mJbGeNuzG+KC2rGi18Ofn/4eOKa?=
 =?us-ascii?Q?waLYO9JnyKvrkCwZMQhgKi11/XhI8lGQG2Lb+FgIBTzeiD9cg302f5Z8Zv6U?=
 =?us-ascii?Q?gm1BN6UCMtQri0RInihwj4USYPZY0FloFidTfg0hN1JL1F7MO/MSzKmC1Wam?=
 =?us-ascii?Q?Mu0inBRl4qO+OaxNTj45jM8srVEzL0CXPsarWD9fsqsyZgoO8lvHKggARM2g?=
 =?us-ascii?Q?NHcFL5cfDAj6cod2Zqn7AbhxiAzj+dXYc1O5TlHNsu8t4MFrQoF98jLyE2Qe?=
 =?us-ascii?Q?mww4xuC85S6szXZAJ7M5rH9tm2IsM3tfVRTEzjDB0s7c9fScpXLvgmkq4Ssn?=
 =?us-ascii?Q?7NHactiy4PrwA0bjGcxlh6JKCehyusO2pynLQKwRPiEvhuEBbmu1i4PRxhzr?=
 =?us-ascii?Q?ASxot/WvI0eVxOs0OsamLQMDy7IXbBzC99nHy76pINuA43aBSkmyGHIvPNP+?=
 =?us-ascii?Q?OE4yl6SGpg/k0xWeV9oCWeHgEpLnkFxPWhhzWp0dfe4HwU0ZR50CkKQDH439?=
 =?us-ascii?Q?jr+LVJyE/1Sm0BATCGrMh5R1IwQ8CGiXd0Vwnba0IKH6wZbfG7bpJLLiYZmm?=
 =?us-ascii?Q?EfJLano8JtNwAXkA5vewKphA3EKme8cv1GXPOq7MQP8N7thP5Kxe63WASEmQ?=
 =?us-ascii?Q?ShCuwxBoRPO5oyqBDUngyd2Hns0QxZ7apPVCAHqVGYc6h9OHxFSbe1QyKyJN?=
 =?us-ascii?Q?ApHqC+ZPzcawHlmzXFbqVSxrni9gx5zSRB2VCoDtMtKKrxTH2M1bCZ+C/7sN?=
 =?us-ascii?Q?CV91ytayogliyz1HrI9RAl85+nqDP5wV2+Pj+TNGv8bLMA1ZCngOm0o6lwGB?=
 =?us-ascii?Q?nzxdPcMMLsgdsKneEH7LNqI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6201e9-00c3-4572-27cc-08d9cf80ac53
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 12:49:40.5726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfjjKWGgTsEDtY+w35CHSPChvhmiL5iiHa+UYjhRuycsUEvG//7I5lcT2tSufZcY/Dkc3kWA3U3yN2xTEZfcRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2500
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

