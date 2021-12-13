Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0937C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 22:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbhLMWzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 17:55:50 -0500
Received: from mail-bn7nam10on2085.outbound.protection.outlook.com ([40.107.92.85]:28160
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244070AbhLMWz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 17:55:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FH7lJdwstJ0gXc0qU99HhiPFipnMwD+X3mCOpwr4f0P+z8rJgweTXr0GgD9xaZnWdSv009pgMYZ7KMnqXmbQcyHEMVgsRfg+xwMqAg7edUEwH+YRwFE7rIHOgmKkL0dJJ1KedZlk5kQau8yr6F3uKwY+DN5Bwq/GA4AGZ+YaVLlkFFS/xK6Vv7Jul4LKQOluDhl5vyO7bnv3Oyzz2ztUHwZM6e88yeUXE2mLUZfyJ+cHm+ljYxT10vK9bq40fbeh6dbEw512Ol/5Zwv8irxmFl/ACp0Glj3Nv5f20YpWGe4e4YOSQnoQ/UC/TvSv2WyavNOxOMEieUQ4Is8j7fHNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKEfSDfUPs2D6VLClHxJvQLmVNyEUkTV5YaUp1aUSRQ=;
 b=SWeMq4Pl1zfUpduljxX98ffau0X9sulXUErpDRTotMCu5RD4ZH9O51oNjeWcGNaHYMqWqWNDeFaLjxEZYlUBdUA2DTPLUMdQXgIc22CFqSmjMj4QTPBp2OfXgsEwjBLWpQwSXt/w23m+Vno6q5cXgJYgRp5ksvdc+DbENGLT9OiPkCeAOkyt2RTdAHcavb5p3RjdSUqr2dLANAJAZxmBeL37jdHLo5JmJTAHm/C1WViq6a0XvljANwQO0Jvh3AfddWj183zbsFI2DpEm9XBzdPNuiklgx7GuZRGzjdzbIh+qHYfWfz5xUgC6BAIfHtnhQSFdYZwzDzZOvtgOBkx4dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKEfSDfUPs2D6VLClHxJvQLmVNyEUkTV5YaUp1aUSRQ=;
 b=T1WBiTnOZzZ0sBIWP8eWIX4UhlZRrenJMdHfu8sdNX1jSVWgI/z/RSl3r1AZ9wT/l/sXvLhR+2auMvhwtNUDTn2RwUEw8GSqY4vye9wcd5JOJejNRwGbHO62H/tzk2dMH70yH+amugon7rRNVh8O3TF6c24srlr9pwNXyq4hT57S0Y539PW8xxj8yz5pKwcgk4vJZUmxKlXLgVC9UD9zZF3/MMk7I/GXMU8OwynrHZQeTaTuBPMRTFvXkP9RF980vrJHY5shWemUGbd601bY4wvhYMRw43DwbtbxczIL+OR8UntN/Oe2TqtVQMTEbk+koZ6Efzsi3vt++EPhwB3ZQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR12MB1377.namprd12.prod.outlook.com (2603:10b6:404:1c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Mon, 13 Dec
 2021 22:55:10 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 22:55:10 +0000
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
Subject: [PATCH 4/4] git-p4: resolve RCS keywords in binary
Date:   Mon, 13 Dec 2021 22:54:41 +0000
Message-Id: <20211213225441.1865782-5-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6c210c99-9c46-45a0-e3cc-08d9be8b9da7
X-MS-TrafficTypeDiagnostic: BN6PR12MB1377:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB13773CA0EF6BF4CFFF581AEAC8749@BN6PR12MB1377.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ndPhegtxolLR/VU2KTOcGcon3wDeARmKYZP5ggdkPSrpJud+0W9swAomjKQrfbWYbopc83qqeXvBbbAtop/OaT/LwES9ZouInKM85mjoW1nv1DdsfE0j9RXS06o2/A4V8lu/pP81/LsNGi43/C8vnumobLc/ddC2vSZT0rOvSv6g5peY+tlxY+U/85XI9kWmpATsnLogi7lSp9Dctw53k/r+dP4VCT6e/2p52Vg/uWkXbP/Tkl9YlAItguvUFp4LQt+3f8fn3vUhDw+OgES96BcWIEvmn9L2Fe6qg5gAWqAh/egNAkGWLE+JNjrlFoncx6lrrEfAn2kCw0mgod1Dl0vn+EUSlyDam2z/5R9+NOHJTEHWGrfBUgnJGHWoRSHB6lrzIJMmM4dUCjGdz5mRJ1R248sifgQVqSTuglCs3APGBGQu+2nauNlWGBzt7TVz9gfkmxz0w5gQlsRrv9531IV9pDyq1bh/QwACkLX2IQ3k7CeTIm20VLz/DqoYnWiSYJgLTBYVtwoOWehf1+IuyBWNrfA2LVD8vxtWWUXnUwtiJ8gEoUdNImKmY9CI5NRIEcDi2SB4wxBcNGp5i4YOX9at8mmlKVyvERMOS9Xtshe6RLQ6SqQnPNiXYPQ8QOT8PcLYXHNEAsuYG2EYMFhpJlqyWV4WZrfCeIYik3RIPuLyd0nDdDiefkaBdecr7Xa8TMkji7PiAyIR+/AoovnU+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(508600001)(6486002)(2906002)(54906003)(8676002)(8936002)(6666004)(66476007)(1076003)(6512007)(316002)(66556008)(38350700002)(66946007)(107886003)(36756003)(4326008)(38100700002)(86362001)(6916009)(52116002)(83380400001)(55236004)(6506007)(186003)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IGwmzYvJLiWKvm44xdwRpfGxV+vfbZloU73KQ6pLM+sG9PaDth9sg6EXprYt?=
 =?us-ascii?Q?1DPwWbJ1qWUqY5VYNEzLvuYEJE8svkCC9tIZGI4RJGZRII1H7IKED9iSWarN?=
 =?us-ascii?Q?JADsm2tE0iCYKBq7qWuDFJM/qUPW8yb34KHsmMZc6jbTa5Lgvlfoe+nmu28L?=
 =?us-ascii?Q?LdLQS4v7nC0U+oSs1/zA7t4DRHMEzqmGtPzgoxVtRUXZ56H0iuwUTrIXyA2z?=
 =?us-ascii?Q?1brDnROR/3JjrI/Eu82XsbzzEBH1R0sfKzS07d4udwM9IhbmOz90F369g82A?=
 =?us-ascii?Q?euA5Kq3yCiBsd/CnCo/ArvHPQBJv+q/behkJ93akiEmgRZqrZm80MHY0+Gq5?=
 =?us-ascii?Q?1ylRB4qRr1A148vPLoP38tHkQ+oiENbQWAND/tqaVi/u5jrgcUpmJz1UCSXh?=
 =?us-ascii?Q?AQtjjTz0ZnhA2jUBdeanqQ2i9gjnB1zSSEu9ib6eHhY0TWJuMFJ48dbXaC8/?=
 =?us-ascii?Q?6CUyzZNiIFRwPZKlJ+pW39/vpj+UfT5Ii0xCi58DwJJhjrhRzZSIfnRNaa06?=
 =?us-ascii?Q?NuHD4tQZAVh3cYC/dR8qWlTxT8jWo+039FoGIbrC1Yy/Vm7M/MDn0Kax1FXt?=
 =?us-ascii?Q?MP7Lkk3MeL0ojfdCl0nGzx6q/IKONfW4gDL0CFiAb9zDshVPXMSI/WIOKlwj?=
 =?us-ascii?Q?HIMQ0Apo+cPjGa/0xqfy6syq0N/X+TPMzdGH2cnHCk55rBBOSrFlAhseaqjE?=
 =?us-ascii?Q?EILptg2SWL+uW2yhXWNXjGXkJzQVGytCX8chPR/3WrQP2tiZK9QEghA/bib9?=
 =?us-ascii?Q?O1UM1AuX3x0i4WJ4BsT45WYY5SvC1mpWfS9jLF51Cy5EzdMGckHx2rFDgBBT?=
 =?us-ascii?Q?2YMs243cv3b5vH8+D5Y3aGNTr3T4TYZ+xezVKZcUqT2OHqfithbfKiKuYZ+8?=
 =?us-ascii?Q?x+3I77AB1Dc4oCF/pI0wR/Ph2yeNAniXWaLz/RRj9ua4JrQCFC5EGW1DvdTE?=
 =?us-ascii?Q?7Vg+s56U8CoWg21+nkZJfjNM/2wn0pKfGqQjhOZwu7VYRPIKjCohJj+ra/+k?=
 =?us-ascii?Q?AAuN8QMBSKT5XeF+rm4MXbcsTbV/Bv8SjisDuXBQMKIYBBQTZxCS01X7SprX?=
 =?us-ascii?Q?nMG4Vox4CISlaubhvS4AUvXf7VbVzMs3ubtgY1lP5Z8P2kNb3uB4qtI2zMdG?=
 =?us-ascii?Q?2hQtfL+4tw/bsIiNffABUhbXJuHO5yeTQ2nlusXV0Lxn8qWUNVWHIJf1S8OO?=
 =?us-ascii?Q?IXOBydcGa8UXtaBRHx3k93MjX1puSo1FpFPA1EnFJuhZyx/q9SFcv4um6Ptj?=
 =?us-ascii?Q?ynzPhw0aLQHw7dEvqQCZDdLyQ/qjiuGvI+w55AZcfI1jVIF9JusigmEEhcRE?=
 =?us-ascii?Q?jNvWIhqadKfqTzJ89ekWLmLLYUmk5qsFkLnVt80+t6z/eNwP6Yg7w81MqAM3?=
 =?us-ascii?Q?+usj4B5MnLj5GUDfMoN/M9y2QP+hjUrP7JXwB3CUC6Qf77+nM2uE3hhs/HO8?=
 =?us-ascii?Q?MUbBPhRplsUHTZP4Igsj8YFeJzOQbiLwbjxYwx7uA3gUu0yioQxPiIOfHHNN?=
 =?us-ascii?Q?G10lRz8GTGwkCTJRj7H6sfBTpXjwjJ7Ymjcn6I4eIcERuUBmleVlXs0oQEc1?=
 =?us-ascii?Q?st7mRcMQJ5c59fyw65MhdjAWNWNMJl0n4zQOJYZ87zPvrpx5mw5tH5/DIsU1?=
 =?us-ascii?Q?LAEZgA+GYOEIBwMQG7zmOpI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c210c99-9c46-45a0-e3cc-08d9be8b9da7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 22:55:10.6591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpvqkIHJPnNzCopEosOheEhvr3/3PGlsWaKoMHQ7e48QgjyEGx9PCTpVbGvUzj8f7ubpL8UZW9oXSCSS/xZQRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1377
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RCS keywords are strings that will are replaced with information from
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
source data with not conversions.

A test for smart quote handling has been added to the
t9810-git-p4-rcs.sh test suite.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py             | 15 ++++++++-------
 t/t9810-git-p4-rcs.sh | 15 +++++++++++++++
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 509feac2d8..986595bef0 100755
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
-            with os.fdopen(handle, "w+") as outFile, open(file, "r") as inFile:
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
2.33.0

