Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D68C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244694AbiBJQrO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:47:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244679AbiBJQrM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:47:12 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB841B1
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:47:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HepFieQE1WHJM9zzLb0KJzkw+2ONLgdIjiY0AXUjpMN14e1mlKQZnF1xvCbq3Gcc9ZkpKFeGMCUbi5zza/d2NOpj9hZG9h8CpvqZJl9S5Mj7ABYKlCWB8NMCluvJC6g0ZphmJAoVARh44PyelVRMeLNLCaCIRLDHyud6pTyc9N2pdbEaSYjyiAGbpbgGDB/dboa2oo06YqVhy+F1mOsZUFJfD/vJzcL2OxvTViCRBKFccD8rWKLZtrJFZsjB+1KfnnWYlNYA5dj86jZByMNyDAqTrzL07odoV9vg3NZpRc0dVGywEuVbNrBDHCqkTrG8auBEk4gJZHJ2IzBWa1SAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HeOH2KFFE91MEmUzn81za96UMiQuoxIbj7Jg4FkwDI=;
 b=LajUmoS/paf+o6ECXTSoUprHFdXKOjQw8aA8ZK+coO/A4+RcyZ32D9wzw+9ZBEll2dXi69CUfa6pRWugize5CTaEHXvXGGTxvpyJ9NBxu1PMqv1+O6XdJ3oE0dkI1JCj6BopsOpqFBYSZURH9mLw7K4zt8ldLSw+O0i7ECTUmzEHg8R1zAoYxbNbuivbfFJuBRoE5ATUaAHGve+FV5t0Qe1fshKx8xVGWBFUz4lAA/vQMY4WSnKb1tWwH0esjE2WO71RQzebRic1d4paLT+jxgv3d0WbPAIrACqWbaqCozVBP14p3ME1N5tbb10AD31BY5dCGDRd1F2FEW4M4ULhqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HeOH2KFFE91MEmUzn81za96UMiQuoxIbj7Jg4FkwDI=;
 b=ZsglOWj/Ydh/t4h0aaeu4JJQWZ9RssPNDZn8FU5aLffXBIf7dWoW5rPFCik4G/wy/NkKxXszQMpyadUIbgZAcESDpARYJ1zXobvx3SGIEetBtTskNYHQyaB9t+BXLfEHmNHFja2FRnTLUe41gY9P878nw8syBuayaq2UjBWLv23ZvK0wTJqF6dythIfHG60Fl8802M/cEAlTZ+MJdrc4IwvbocCoWoWRmzphCzFqoaZn/b2evPs/VSxwMHuoWkIYZcAbYCCDKKkKG8Jo31BDJgcZ56dhHMmWCqr9eCIVb1U6wXUMnoVPB5JFr/OzlJtCq1DjZeNv2iLbcJK1jIdDQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB2421.namprd12.prod.outlook.com (2603:10b6:4:b4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:47:04 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:47:04 +0000
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
Subject: [PATCH v4 05/22] git-p4: convert descriptive class and function comments into docstrings
Date:   Thu, 10 Feb 2022 16:46:10 +0000
Message-Id: <20220210164627.279520-6-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220210164627.279520-1-jholdsworth@nvidia.com>
References: <20220210164627.279520-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0069.eurprd04.prod.outlook.com
 (2603:10a6:208:1::46) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c2f65a9-2594-40aa-829f-08d9ecb4f779
X-MS-TrafficTypeDiagnostic: DM5PR12MB2421:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2421AC20C808ECC9BBDE3279C82F9@DM5PR12MB2421.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:215;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cPGPJlDNO8ocuZ0VJ1cFFr3ULo8T2I0Am+EOTa8exttrEM1HR05MhzihxQ3uuAEslQ+xx/egpAF9/9bymmKERkOCgEdMTirTVKBDNl2+VuFDv+0I0x6AO4aaU5bzZcKN7/6sj6kyMZW328QQ4ooNWbaE+4LkyQhVq2cTtj1AAJjG0+fiFOmV+yXQlTzBiq7txWLpCsgLV1j36jx++hHo8j2Gsw59VPQDJVRw7xXKIGV9uezVx6zfzk/Ri3Okhwr+7iVoOp/sjwqSky9OP5LXnZT2s1YgyNcdw2LWSkfHa6bgwMGRQcwwTbHEL6hX6/KQ3+MslZFtijFtTyuTsOcxZBNh0Irl4AJKSO3PazfNecMAWGE60f80zPvbwH3D4g+lQMqjmDkwmpsytJgj6MLKTPX2KQc3OUOgt/nvxd5Er14MOD8kCzqt07ym0Qa0NX0G4ohOO7XJlFNtFnhqnEz1eRWde6NVj9xRT0byi3yr+N/3T5ZvKQEyIGC3AGLt6ZyF3Jks3IeABiO3M8CL2dcp3S6KXJQgqkL3jFLr0FEgOIiUsTnJ45797UmqmfWIXPn6AnqqrmZ3dxc2XRpQxSirkkZ3eKwfwqUTXJLlKWxPPmg6IIz9B9aoUmSgOtwk2pw/zY+53I4wo1WG1xu2EbVooEX7nCVf3/l4xCdKcSfJOmzv8wBLuOmNaGdBz+CL9vyyc36HxDPp3NnrZR76dG+4pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(2906002)(52116002)(86362001)(6666004)(508600001)(6486002)(6512007)(55236004)(6506007)(186003)(8936002)(8676002)(66556008)(66946007)(7416002)(19627235002)(5660300002)(110136005)(1076003)(316002)(4326008)(36756003)(54906003)(83380400001)(66476007)(30864003)(2616005)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hbPJwYBivuh8bNaYqLzbfET1cXa8Yr0ExIFOvptUp+T76IpP7FQdEqHWOVzB?=
 =?us-ascii?Q?nM/iCrZzepZROTexuaIK7EIcBNykP358+x6uhuxLzoO1Av0g60Ue+wkd/yNI?=
 =?us-ascii?Q?5C3C7M+bVXdEuW/3JI2uwt91MSL87nuBfQu8fVFhkKM/8aKnR/IwZLf8RNu6?=
 =?us-ascii?Q?OnltpKKoIZkLEtaqQ85V039SoZpVwukOV0H9rq70cGz0yCco1wxBp/9YX7Qd?=
 =?us-ascii?Q?8Fh7vGJme7kQ7tJd2c6q3TQtP9sn+tPvht2gWId4bu6D5fMRlkc0bbGsiYpH?=
 =?us-ascii?Q?dmJ+DvoBS6AzU2QXZ81lbQ/tjHWyxpWdCs5SuHHGkj/kRS2y1rVyoiJrZZb6?=
 =?us-ascii?Q?ZeaGY9lBh6N15kX4RO0mYMIPbUQB9M4/jnh5aiJP5fPVP50a+giYAsHeIsvh?=
 =?us-ascii?Q?d24pxvjzPMQWKGOeqp8nkQi4P3hs39P2K8yLH18SxNVlFUn67JD85e1IJWTB?=
 =?us-ascii?Q?EnJnYVFXhqMigA8+RA/7X1nBLULkS1zufN35yGTKQL5I1vs4o+OHDQDmTias?=
 =?us-ascii?Q?zlq+QaocuF5nLD/iijiuZiE6Vd4m6ZztCqf8wC0xOKTizoox0Q8U+TDwyFMk?=
 =?us-ascii?Q?wfPxaSigZmRq2NB9U/0SJqqHZLK6LDQDur5eaig3+0cMwnaDfB0sVhlHdjEt?=
 =?us-ascii?Q?LlOBLwU2z2wD37/JaNKXNiAiYXhvWs8Z3EcCCzB9mCDrrOQtBR+HnjwP570Z?=
 =?us-ascii?Q?I0EVt5hBRSu//NTP0lEeGXTfwWH1SRl38EQh7B2A/Ec+cBJAAII5emsP+oDB?=
 =?us-ascii?Q?Q2wZ1nVGMVSjYoJCGys5bkZp/wpRL7RmAY73FkYFElx0ObhkjuZrqPEKdJPY?=
 =?us-ascii?Q?gHe8gP3OIqMibd9lLWy7JlMuGNNcl4eAjDKju0JbTBHaq6QSpkmBHUlM73wo?=
 =?us-ascii?Q?feve1O1kRsfmnsl/vLffrK/eN0B9KHBZs4PlfpFQFAl15i7oZX3eLDOTu8Gr?=
 =?us-ascii?Q?BEJdgPbuTA9y6cuJd1pto2cYo7VKuPJr7TtHxT694Rkxc6jdYeqnKhahF4/O?=
 =?us-ascii?Q?tlqLqI24L5v9USmT5kXrnfbXntDjE4fQaH0FlhHwAPwdBZW9mJyQCYkKkLFM?=
 =?us-ascii?Q?0g17VEdrKTgd4VcpVKDu21JDehoBgD1xhwg0jvXhK9wRyyBZoYuElhdh8iqF?=
 =?us-ascii?Q?+qrsKUVjDWgwX7inSnsy4BdC2b/nvqF/sxHBtGqpjoVHQP0fXFF4UYNhzzay?=
 =?us-ascii?Q?e68pcgsvwsAqn1CpDvh5AecQgxC7cnNODxMe/fIN0DzW5uSGPq2vyt9ixjCn?=
 =?us-ascii?Q?kNio8ClcOh3dOiR4VsmsE0wzJh7BkgufS6DuvOX1JZFDeJMNrtrmjipFVcEd?=
 =?us-ascii?Q?Tidf0UR3oOBOPyxohEZ5T8M2qqk84p5OdpqDjMYXdBLox+/H7zxiitu3ra4c?=
 =?us-ascii?Q?NtwZCcIPl31bL6NBLXxvvV/ow77eTwDuQweyWXmiLoM7KYAEBlHfzgkbCnI5?=
 =?us-ascii?Q?XrzxH1dTwuUoNVxQxxbS2P7rHWmK4dXGX9mAuU56GfQ9Fxg0XM9PwjAUSRvQ?=
 =?us-ascii?Q?8HGhWrHNGt14Ix0qtIhEt+x9BJKnIacrXmGmc7vffyeih4wKOP6mHbuEugbC?=
 =?us-ascii?Q?hPGGECKs30uE2m5sI6JlzQxdLD+3FBT/LGjaUwpoQzpo5yJ9uCfNi+o7ZKNr?=
 =?us-ascii?Q?KkebaeeaQLtj0BsFXxvSvR4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2f65a9-2594-40aa-829f-08d9ecb4f779
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:47:04.1558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asa+x57F+WK1k7z6yzoJqOJzHox4t+SHa1n+wMsCXOQf+UIEH7lhSODWSZGIYTRxvvYPkDqcPC+i3ie3Cuj1Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2421
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, a small number of functions, methods and classes were
documented using comments. This patch improves consistency by converting
these into docstrings similar to those that already exist in the script.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 164 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 94 insertions(+), 70 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 10b51b17de..892b964eec 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -458,7 +458,7 @@ def p4_sync(f, *options):
 
 
 def p4_add(f):
-    # forcibly add file names with wildcards
+    """Forcibly add file names with wildcards."""
     if wildcard_present(f):
         p4_system(["add", "-f", f])
     else:
@@ -526,12 +526,10 @@ def p4_describe(change, shelved=False):
     return d
 
 
-#
-# Canonicalize the p4 type and return a tuple of the
-# base type, plus any modifiers.  See "p4 help filetypes"
-# for a list and explanation.
-#
 def split_p4_type(p4type):
+    """Canonicalize the p4 type and return a tuple of the base type, plus any
+       modifiers.  See "p4 help filetypes" for a list and explanation.
+       """
 
     p4_filetypes_historical = {
         "ctempobj": "binary+Sw",
@@ -562,19 +560,18 @@ def split_p4_type(p4type):
     return (base, mods)
 
 
-#
-# return the raw p4 type of a file (text, text+ko, etc)
-#
 def p4_type(f):
+    """Return the raw p4 type of a file (text, text+ko, etc)."""
+
     results = p4CmdList(["fstat", "-T", "headType", wildcard_encode(f)])
     return results[0]['headType']
 
 
-#
-# Given a type base and modifier, return a regexp matching
-# the keywords that can be expanded in the file
-#
 def p4_keywords_regexp_for_type(base, type_mods):
+    """Given a type base and modifier, return a regexp matching the keywords
+       that can be expanded in the file.
+       """
+
     if base in ("text", "unicode", "binary"):
         if "ko" in type_mods:
             return re_ko_keywords
@@ -586,12 +583,11 @@ def p4_keywords_regexp_for_type(base, type_mods):
         return None
 
 
-#
-# Given a file, return a regexp matching the possible
-# RCS keywords that will be expanded, or None for files
-# with kw expansion turned off.
-#
 def p4_keywords_regexp_for_file(file):
+    """Given a file, return a regexp matching the possible RCS keywords that
+       will be expanded, or None for files with kw expansion turned off.
+       """
+
     if not os.path.exists(file):
         return None
     else:
@@ -600,8 +596,9 @@ def p4_keywords_regexp_for_file(file):
 
 
 def setP4ExecBit(file, mode):
-    # Reopens an already open file and changes the execute bit to match
-    # the execute bit setting in the passed in mode.
+    """Reopens an already open file and changes the execute bit to match the
+       execute bit setting in the passed in mode.
+       """
 
     p4Type = "+x"
 
@@ -616,7 +613,7 @@ def setP4ExecBit(file, mode):
 
 
 def getP4OpenedType(file):
-    # Returns the perforce file type for the given file.
+    """Returns the perforce file type for the given file."""
 
     result = p4_read_pipe(["opened", wildcard_encode(file)])
     match = re.match(".*\((.+)\)( \*exclusive\*)?\r?$", result)
@@ -626,8 +623,9 @@ def getP4OpenedType(file):
         die("Could not determine file type for %s (result: '%s')" % (file, result))
 
 
-# Return the set of all p4 labels
 def getP4Labels(depotPaths):
+    """Return the set of all p4 labels."""
+
     labels = set()
     if not isinstance(depotPaths, list):
         depotPaths = [depotPaths]
@@ -639,8 +637,9 @@ def getP4Labels(depotPaths):
     return labels
 
 
-# Return the set of all git tags
 def getGitTags():
+    """Return the set of all git tags."""
+
     gitTags = set()
     for line in read_pipe_lines(["git", "tag"]):
         tag = line.strip()
@@ -691,8 +690,9 @@ def parseDiffTreeEntry(entry):
 
 
 def isModeExec(mode):
-    # Returns True if the given git mode represents an executable file,
-    # otherwise False.
+    """Returns True if the given git mode represents an executable file,
+       otherwise False.
+       """
     return mode[-3:] == "755"
 
 
@@ -1201,13 +1201,14 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
 
 
 def p4PathStartsWith(path, prefix):
-    # This method tries to remedy a potential mixed-case issue:
-    #
-    # If UserA adds  //depot/DirA/file1
-    # and UserB adds //depot/dira/file2
-    #
-    # we may or may not have a problem. If you have core.ignorecase=true,
-    # we treat DirA and dira as the same directory
+    """This method tries to remedy a potential mixed-case issue:
+
+       If UserA adds  //depot/DirA/file1
+       and UserB adds //depot/dira/file2
+
+       we may or may not have a problem. If you have core.ignorecase=true,
+       we treat DirA and dira as the same directory.
+       """
     if gitConfigBool("core.ignorecase"):
         return path.lower().startswith(prefix.lower())
     return path.startswith(prefix)
@@ -1259,12 +1260,14 @@ def getClientRoot():
     return entry["Root"]
 
 
-#
-# P4 wildcards are not allowed in filenames.  P4 complains
-# if you simply add them, but you can force it with "-f", in
-# which case it translates them into %xx encoding internally.
-#
 def wildcard_decode(path):
+    """Decode P4 wildcards into %xx encoding
+
+       P4 wildcards are not allowed in filenames.  P4 complains if you simply
+       add them, but you can force it with "-f", in which case it translates
+       them into %xx encoding internally.
+       """
+
     # Search for and fix just these four characters.  Do % last so
     # that fixing it does not inadvertently create new %-escapes.
     # Cannot have * in a filename in windows; untested as to
@@ -1278,6 +1281,8 @@ def wildcard_decode(path):
 
 
 def wildcard_encode(path):
+    """Encode %xx coded wildcards into P4 coding."""
+
     # do % first to avoid double-encoding the %s introduced here
     path = path.replace("%", "%25") \
                .replace("*", "%2A") \
@@ -1524,7 +1529,7 @@ def p4UserId(self):
         die("Could not find your p4 user id")
 
     def p4UserIsMe(self, p4User):
-        # return True if the given p4 user is actually me
+        """Return True if the given p4 user is actually me."""
         me = self.p4UserId()
         if not p4User or p4User != me:
             return False
@@ -1727,7 +1732,9 @@ def prepareLogMessage(self, template, message, jobs):
         return result
 
     def patchRCSKeywords(self, file, regexp):
-        # Attempt to zap the RCS keywords in a p4 controlled file matching the given regex
+        """Attempt to zap the RCS keywords in a p4 controlled file matching the
+           given regex.
+           """
         (handle, outFileName) = tempfile.mkstemp(dir='.')
         try:
             with os.fdopen(handle, "wb") as outFile, open(file, "rb") as inFile:
@@ -1745,7 +1752,9 @@ def patchRCSKeywords(self, file, regexp):
         print("Patched up RCS keywords in %s" % file)
 
     def p4UserForCommit(self,id):
-        # Return the tuple (perforce user,git email) for a given git commit id
+        """Return the tuple (perforce user,git email) for a given git commit
+           id.
+           """
         self.getUserMapFromPerforceServer()
         gitEmail = read_pipe(["git", "log", "--max-count=1",
                               "--format=%ae", id])
@@ -1756,7 +1765,7 @@ def p4UserForCommit(self,id):
             return (self.emails[gitEmail],gitEmail)
 
     def checkValidP4Users(self,commits):
-        # check if any git authors cannot be mapped to p4 users
+        """Check if any git authors cannot be mapped to p4 users."""
         for id in commits:
             (user,email) = self.p4UserForCommit(id)
             if not user:
@@ -1767,10 +1776,12 @@ def checkValidP4Users(self,commits):
                     die("Error: %s\nSet git-p4.allowMissingP4Users to true to allow this." % msg)
 
     def lastP4Changelist(self):
-        # Get back the last changelist number submitted in this client spec. This
-        # then gets used to patch up the username in the change. If the same
-        # client spec is being used by multiple processes then this might go
-        # wrong.
+        """Get back the last changelist number submitted in this client spec.
+
+           This then gets used to patch up the username in the change. If the
+           same client spec is being used by multiple processes then this might
+           go wrong.
+           """
         results = p4CmdList(["client", "-o"])        # find the current client
         client = None
         for r in results:
@@ -1786,7 +1797,7 @@ def lastP4Changelist(self):
         die("Could not get changelist number for last submit - cannot patch up user details")
 
     def modifyChangelistUser(self, changelist, newUser):
-        # fixup the user field of a changelist after it has been submitted.
+        """Fixup the user field of a changelist after it has been submitted."""
         changes = p4CmdList(["change", "-o", changelist])
         if len(changes) != 1:
             die("Bad output from p4 change modifying %s to user %s" %
@@ -1809,8 +1820,9 @@ def modifyChangelistUser(self, changelist, newUser):
         die("Could not modify user field of changelist %s to %s" % (changelist, newUser))
 
     def canChangeChangelists(self):
-        # check to see if we have p4 admin or super-user permissions, either of
-        # which are required to modify changelists.
+        """Check to see if we have p4 admin or super-user permissions, either
+           of which are required to modify changelists.
+           """
         results = p4CmdList(["protects", self.depotPath])
         for r in results:
             if 'perm' in r:
@@ -2262,9 +2274,11 @@ def applyCommit(self, id):
                 os.remove(fileName)
         return submitted
 
-    # Export git tags as p4 labels. Create a p4 label and then tag
-    # with that.
     def exportGitTags(self, gitTags):
+        """Export git tags as p4 labels. Create a p4 label and then tag with
+           that.
+           """
+
         validLabelRegexp = gitConfig("git-p4.labelExportRegexp")
         if len(validLabelRegexp) == 0:
             validLabelRegexp = defaultLabelRegexp
@@ -2787,8 +2801,8 @@ def __init__(self):
         self.tz = "%+03d%02d" % (- time.timezone / 3600, ((- time.timezone % 3600) / 60))
         self.labels = {}
 
-    # Force a checkpoint in fast-import and wait for it to finish
     def checkpoint(self):
+        """Force a checkpoint in fast-import and wait for it to finish."""
         self.gitStream.write("checkpoint\n\n")
         self.gitStream.write("progress checkpoint\n\n")
         self.gitStream.flush()
@@ -2934,10 +2948,12 @@ def encodeWithUTF8(self, path):
                 print('Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, path))
         return path
 
-    # output one file from the P4 stream
-    # - helper for streamP4Files
-
     def streamOneP4File(self, file, contents):
+        """Output one file from the P4 stream.
+
+           This is a helper for streamP4Files().
+           """
+
         file_path = file['depotFile']
         relPath = self.stripRepoPath(decode_path(file_path), self.branchPrefixes)
 
@@ -3029,8 +3045,8 @@ def streamOneP4Deletion(self, file):
         if self.largeFileSystem and self.largeFileSystem.isLargeFile(relPath):
             self.largeFileSystem.removeLargeFile(relPath)
 
-    # handle another chunk of streaming data
     def streamP4FilesCb(self, marshalled):
+        """Handle another chunk of streaming data."""
 
         # catch p4 errors and complain
         err = None
@@ -3094,8 +3110,9 @@ def streamP4FilesCb(self, marshalled):
 
         self.stream_have_file_info = True
 
-    # Stream directly from "p4 files" into "git fast-import"
     def streamP4Files(self, files):
+        """Stream directly from "p4 files" into "git fast-import."""
+
         filesForCommit = []
         filesToRead = []
         filesToDelete = []
@@ -3199,15 +3216,18 @@ def hasBranchPrefix(self, path):
         return hasPrefix
 
     def findShadowedFiles(self, files, change):
-        # Perforce allows you commit files and directories with the same name,
-        # so you could have files //depot/foo and //depot/foo/bar both checked
-        # in.  A p4 sync of a repository in this state fails.  Deleting one of
-        # the files recovers the repository.
-        #
-        # Git will not allow the broken state to exist and only the most recent
-        # of the conflicting names is left in the repository.  When one of the
-        # conflicting files is deleted we need to re-add the other one to make
-        # sure the git repository recovers in the same way as perforce.
+        """Perforce allows you commit files and directories with the same name,
+           so you could have files //depot/foo and //depot/foo/bar both checked
+           in.  A p4 sync of a repository in this state fails.  Deleting one of
+           the files recovers the repository.
+
+           Git will not allow the broken state to exist and only the most
+           recent of the conflicting names is left in the repository.  When one
+           of the conflicting files is deleted we need to re-add the other one
+           to make sure the git repository recovers in the same way as
+           perforce.
+           """
+
         deleted = [f for f in files if f['action'] in self.delete_actions]
         to_check = set()
         for f in deleted:
@@ -3324,8 +3344,11 @@ def commit(self, details, files, branch, parent = "", allow_empty=False):
                     print("Tag %s does not match with change %s: file count is different."
                            % (labelDetails["label"], change))
 
-    # Build a dictionary of changelists and labels, for "detect-labels" option.
     def getLabels(self):
+        """Build a dictionary of changelists and labels, for "detect-labels"
+           option.
+           """
+
         self.labels = {}
 
         l = p4CmdList(["labels"] + ["%s..." % p for p in self.depotPaths])
@@ -3351,11 +3374,12 @@ def getLabels(self):
         if self.verbose:
             print("Label changes: %s" % self.labels.keys())
 
-    # Import p4 labels as git tags. A direct mapping does not
-    # exist, so assume that if all the files are at the same revision
-    # then we can use that, or it's something more complicated we should
-    # just ignore.
     def importP4Labels(self, stream, p4Labels):
+        """Import p4 labels as git tags. A direct mapping does not exist, so
+           assume that if all the files are at the same revision then we can
+           use that, or it's something more complicated we should just ignore.
+           """
+
         if verbose:
             print("import p4 labels: " + ' '.join(p4Labels))
 
-- 
2.35.GIT

