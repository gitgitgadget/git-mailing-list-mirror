Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72296C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiAMNsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:48:19 -0500
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:26926
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235485AbiAMNsS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:48:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyhTjhxZUKNVVKySLjVoTKCxzzOQHOBDeC5Qk2kUbMGVMBKGQYJMC1JAK+ScVShyyGbGkOdouxLiVq0d5lN+jJnDmluYIjuHMU/YNz6ujnYC040kYEO9Jk51CSRharHesG3JFza+fSVCEq93a7SQrf8G4oXxAwlLdKP7rrofLododb4HwTITHsOisBiU/WFqzaNgz7L+UKxZTEhq+k96Xibfm+MS0ntklndciwJ1mihocFnHTXQPPNCEx2lPjzujrcUcwV4ntXlYeFkYbfVKdeqeK709ubmsQXepl4uU9lBdOAzMXTEXhbXEY58dq4xZYmbPKTlSc1hm8mlUJwn85g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIpJkYms6VPws/AtLE6tw2sRwE/m04Ru39zwMQcRu9Q=;
 b=XPx+bbhh0ziY66h2QvVAw4c1BBUWZ+Q4ZtvHgSAHeEr9TycQkSdna/mt2x0nhE6YFgpZBCCEgOOnU6qDFaajmhHHEPWLqgGl4+6fRsI2HEeAm2uT7QArXo6KGEnfbYQK8eQEaSwZhckL7EnBRltOxmqEuvRKdwS/MoTKrK8YbIWi7TSE/aEpROYtZ09VHD59e4Y+hpQ7uGqEQzs4odpapivO+W5vl2l97iJnWq0M0OmqdGMBZSprp/oeXfWLZVAtdMYqCrLtL/VWKyzSEOHHlUBb6DlnBGn7Wk22/1vYTS0+AOGe32+IA6R6fJ5ptTaO1HDkRLW2zmCjRb6KbnAzhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIpJkYms6VPws/AtLE6tw2sRwE/m04Ru39zwMQcRu9Q=;
 b=d/u5UGqCfXiqDCrzHlFASHo4GQdlh0wvOjSUnw9AMz1RF9y9nzjEcsbIGkdRxFKEycRFQwMAU4OxpaTigXvLJGypL7LRLfr+/837hQ3jUz47/vk7nB7W/6jJ6Ps4ONW/nTXJfminCigrDvt/Fb0PSAkOinp96a5Q1Kv7Y1iDcWQSFutL5cY6VKeOBI+qr5Tv+kL7dvUrb4uwdf2ns6wQcjVBJ/b90Qb67OvyGqQ7hCvPVhZNEDSAahYzhsLxXjxrUblm+W0PLD9aSPD0ywJ2MXGrHvgux3SlZ9vBj97QPlAFoK4yF+mrpC4gxUboSKFyymuAiXndHNhpf0p8GL1Ujg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 13:48:09 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 13:48:09 +0000
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
Subject: [PATCH v2 05/21] git-p4: convert descriptive class and function comments into docstrings
Date:   Thu, 13 Jan 2022 13:47:12 +0000
Message-Id: <20220113134728.23192-6-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113134728.23192-1-jholdsworth@nvidia.com>
References: <20220113134728.23192-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0101.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::42) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df7afcb7-1926-4d60-de72-08d9d69b553f
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB244796C4FE6483E83F534754C8539@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:215;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h1hea3d6LaZ+rPCw5rGccsYpuq0HGrZNyabYiczAPObg3qqP7/c57k98x1yB2NUHt7UJGXJ/0b8jath3e1feJneBqj/Utw/1xUZqR2tieLhS81sZYW8JrVmUkL5rWQCcQ4Xjhx+rH1G557x2BCsJkyUuseYIcLIpw6I4WeyeoE/rioNfJ4/SiVXxQ69f9G4DNWQhg7Fa8ACcsnN7965Bm3llcEASjCjO8LJ8G2LiMF7OHIlR8J3xKKYtpYdf8qEsR1UwbIx1In8/BdmavPOBufipJzIZFV6EILnGjlrlIidpbvTpei7jSC1uUGbJh6mFgt02+lUCnXkDMy3fzU3q7XCq8/HZ6Y3g6oD+NK95wVJJsCVjFBQQ1S++bFd+pVOnY+CGh6D/BBEmfIdBSditKADPMRo26qAAJAWTN3X9pOOiPpa0kRlyUWcHzsXmlYo1K16V0KB38EauffVzuNLORp64jrzZKx2CUpurVSdxteJ2+VLl6xdQNPKtiVwOIizUobxtyX+gkQQ+nsHh3MU61uBZSpqfYIlieKHY0JPe5tj1f3LxIW6WQziKOqK3QIpJUA1xGXHBLQQxZEmsWakhlpHRaVsVz6zMHSreMrM8EOqxZZ0muJu9WKZ4vCiSaf52NBTOEuRTugO3D4BsvCxFTYVpTXYaH6pcIV5cnkPWXXTmsjv4KytgkVwhwj7nnzYFO+qXZLVc1vx3rucVNyG7Bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(1076003)(8676002)(66946007)(8936002)(26005)(83380400001)(19627235002)(55236004)(2616005)(4326008)(107886003)(6512007)(6666004)(36756003)(6486002)(186003)(54906003)(316002)(38350700002)(110136005)(38100700002)(7416002)(30864003)(508600001)(66556008)(5660300002)(6506007)(2906002)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?faY+QmRs1y5PURCMDY2zpB9UheeWZUbULpRklfEHzf8RhjmQeof2qkhU9Hkl?=
 =?us-ascii?Q?IMSX5rd0ckPoY1jZaspaKWOTuchTuBiq2vCUHPESbfBmGBFr5Dbr5ycBg7aA?=
 =?us-ascii?Q?b9PE/f1uiM25Wk2RkkoJHQ7/HrrybonXqF4oZIe/BCaYvR1NFcinF4mhEkRT?=
 =?us-ascii?Q?3BL7qa4X21m1WNzR+COix0Czt66mTMgaJioL85dhKMBjmzojAAdWsvRktjZ1?=
 =?us-ascii?Q?ViZwPgTzIaWDL5hOF1esr064P5jRqliMOzlR2L7LR2mtlFh0lSsYguz/gVI5?=
 =?us-ascii?Q?W9E9FHwECG/URImwIU2F4sx4JbXVLXHDrilshQkjwrGbsXF9/p9+dxcHpiUA?=
 =?us-ascii?Q?0QzBBlxyAkmgJYo+iJR4OmMNIOcogGLJHDsV3VBh8op8WG1O7ow+fP25qNlv?=
 =?us-ascii?Q?PSdi6jsERVWn4yoOF01KRcE6/VKAq8SeHSnYEBThG4U944RZKxibrcG3L3Px?=
 =?us-ascii?Q?mZ/Pnzx3Rn5Kljddr7lmiWFSWRZ/vZjRh86GPl5V0d1yvLoBzewR3hGP+5So?=
 =?us-ascii?Q?kI6SmZP6DSgv6xDoAJStOhGfWOgt1tGIS4vRBb2hI55UJeCZBSTs/pDadV/E?=
 =?us-ascii?Q?jyLoWI9xw8IAfGvnmth6+qLdqdzgjDQLuO2760KAFyJ/8O/whlblpFKX0/JU?=
 =?us-ascii?Q?y3AzY88ke05EoncEhDdoP1RWOO9VY9LyHuWOK01OwTPqHGSuozxGO+ANcTtp?=
 =?us-ascii?Q?o11ydaR/BD+jgN/dcCufskxQKQjimUXLthVQv0G8KdWaW9QEx7znyEQg9/y+?=
 =?us-ascii?Q?/9oCCxRx3ooQJmczVxloc9cZ1AH5BUwNiu7KogD55xElbkfRUsJ4b6uWCWWv?=
 =?us-ascii?Q?JQNTWGXjPvlHJ9aP4erIughT3UL16mFe64EmyVf4QNzJa3xu9Xj5q74QHKGu?=
 =?us-ascii?Q?z3R4y4nNIhdC/XYILV53S9+M8J3DAFvs/0/PeKOInDJI49nilPwxZBCZ4ImD?=
 =?us-ascii?Q?IqsQYidhHvNFjTx2X2MTKHwZ+38DIt9YawbNjXQhsjNCnRKYbJUD0qz3EOsn?=
 =?us-ascii?Q?nq/SP6cpJ31cAOxKZqmIxq4OODCTy872qnz3ZRStfGTglD2htNcyty/XXnS3?=
 =?us-ascii?Q?XiQ5rP2O8U/9R8jAYYxEpoYKW/fGQK9wkDtxMUsbl8TUxixb8x7MczGgrXO7?=
 =?us-ascii?Q?zIk+jA5iPuekY4BkIiHvANVmAbDcITnDjnYF+7+5hJQah02AIs3pMBXlqBbG?=
 =?us-ascii?Q?Wtps8rid7jYgBMNYvXV/4vberEFduEhJ9sPRKIpEEaEqmoc7ISJzBfxMjdx2?=
 =?us-ascii?Q?KctLcAaCl3/R84ABhuafYhqRZ+VAVZVbL3KLm3vi+kFm9/PfItRC78q1q1Yq?=
 =?us-ascii?Q?mp/uNQBxTZib2nYdextLlDZGf6RUZjmj/RkdDqQanSuD2mtrZx+wWlxwiv5F?=
 =?us-ascii?Q?7ecdGv0Ka5iB6hcE5bg3d73EjhlD5SJtuYjkwGexp1pFdLjC8pRlswCcnGjm?=
 =?us-ascii?Q?5pAO+ALU714VhSO+7744G7i3THdBVUlKquO72sbFn9bdJIcpsRrU5NydVulY?=
 =?us-ascii?Q?k4VtYNeWgnDGi4ab/UepXUJQJu2Ne+qe0CRmjABUZMUsm6ImFf0KXEKdBEAZ?=
 =?us-ascii?Q?ZYTN2EmwmzRq7yC4DYWnZ9Jeo7dNqxa3LbcccCvuRijToBV+0U5k2PjhLHUZ?=
 =?us-ascii?Q?Y3o6APcnihp374q74q6snoA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7afcb7-1926-4d60-de72-08d9d69b553f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 13:48:08.9734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUnYhFCOXYdpagwLT/tW6HRcLbr8v3FpFTg++qKPg1Qw1DjL/6F0yQtsb4m1p043GIAovWOoBAdRzCFaZJ6MXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, a small number of functions, methods and classes were
documented using comments. This patch improves consistency by converting
these into docstrings similar to those that already exist in the script.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
Incoorporates changes suggested by Eric Sunshine.

 git-p4.py | 163 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 94 insertions(+), 69 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 62e2763f13..186ac36300 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -522,7 +522,7 @@ def p4_sync(f, *options):
 
 
 def p4_add(f):
-    # forcibly add file names with wildcards
+    """Forcibly add file names with wildcards."""
     if wildcard_present(f):
         p4_system(["add", "-f", f])
     else:
@@ -590,12 +590,10 @@ def p4_describe(change, shelved=False):
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
@@ -626,19 +624,18 @@ def split_p4_type(p4type):
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
@@ -650,12 +647,11 @@ def p4_keywords_regexp_for_type(base, type_mods):
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
@@ -664,8 +660,9 @@ def p4_keywords_regexp_for_file(file):
 
 
 def setP4ExecBit(file, mode):
-    # Reopens an already open file and changes the execute bit to match
-    # the execute bit setting in the passed in mode.
+    """Reopens an already open file and changes the execute bit to match the
+       execute bit setting in the passed in mode.
+       """
 
     p4Type = "+x"
 
@@ -680,7 +677,7 @@ def setP4ExecBit(file, mode):
 
 
 def getP4OpenedType(file):
-    # Returns the perforce file type for the given file.
+    """Returns the perforce file type for the given file."""
 
     result = p4_read_pipe(["opened", wildcard_encode(file)])
     match = re.match(".*\((.+)\)( \*exclusive\*)?\r?$", result)
@@ -690,8 +687,9 @@ def getP4OpenedType(file):
         die("Could not determine file type for %s (result: '%s')" % (file, result))
 
 
-# Return the set of all p4 labels
 def getP4Labels(depotPaths):
+    """Return the set of all p4 labels."""
+
     labels = set()
     if not isinstance(depotPaths, list):
         depotPaths = [depotPaths]
@@ -703,8 +701,9 @@ def getP4Labels(depotPaths):
     return labels
 
 
-# Return the set of all git tags
 def getGitTags():
+    """Return the set of all git tags."""
+
     gitTags = set()
     for line in read_pipe_lines(["git", "tag"]):
         tag = line.strip()
@@ -755,8 +754,9 @@ def parseDiffTreeEntry(entry):
 
 
 def isModeExec(mode):
-    # Returns True if the given git mode represents an executable file,
-    # otherwise False.
+    """Returns True if the given git mode represents an executable file,
+       otherwise False.
+       """
     return mode[-3:] == "755"
 
 
@@ -1274,13 +1274,14 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
 
 
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
@@ -1332,12 +1333,14 @@ def getClientRoot():
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
@@ -1351,6 +1354,8 @@ def wildcard_decode(path):
 
 
 def wildcard_encode(path):
+    """Encode %xx coded wildcards into P4 coding."""
+
     # do % first to avoid double-encoding the %s introduced here
     path = path.replace("%", "%25") \
                .replace("*", "%2A") \
@@ -1597,7 +1602,7 @@ def p4UserId(self):
         die("Could not find your p4 user id")
 
     def p4UserIsMe(self, p4User):
-        # return True if the given p4 user is actually me
+        """Return True if the given p4 user is actually me."""
         me = self.p4UserId()
         if not p4User or p4User != me:
             return False
@@ -1800,7 +1805,9 @@ def prepareLogMessage(self, template, message, jobs):
         return result
 
     def patchRCSKeywords(self, file, regexp):
-        # Attempt to zap the RCS keywords in a p4 controlled file matching the given regex
+        """Attempt to zap the RCS keywords in a p4 controlled file matching the
+           given regex.
+           """
         (handle, outFileName) = tempfile.mkstemp(dir='.')
         try:
             with os.fdopen(handle, "wb") as outFile, open(file, "rb") as inFile:
@@ -1818,7 +1825,9 @@ def patchRCSKeywords(self, file, regexp):
         print("Patched up RCS keywords in %s" % file)
 
     def p4UserForCommit(self,id):
-        # Return the tuple (perforce user,git email) for a given git commit id
+        """Return the tuple (perforce user,git email) for a given git commit
+           id.
+           """
         self.getUserMapFromPerforceServer()
         gitEmail = read_pipe(["git", "log", "--max-count=1",
                               "--format=%ae", id])
@@ -1829,7 +1838,7 @@ def p4UserForCommit(self,id):
             return (self.emails[gitEmail],gitEmail)
 
     def checkValidP4Users(self,commits):
-        # check if any git authors cannot be mapped to p4 users
+        """Check if any git authors cannot be mapped to p4 users."""
         for id in commits:
             (user,email) = self.p4UserForCommit(id)
             if not user:
@@ -1840,10 +1849,12 @@ def checkValidP4Users(self,commits):
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
         results = p4CmdList("client -o")        # find the current client
         client = None
         for r in results:
@@ -1859,7 +1870,7 @@ def lastP4Changelist(self):
         die("Could not get changelist number for last submit - cannot patch up user details")
 
     def modifyChangelistUser(self, changelist, newUser):
-        # fixup the user field of a changelist after it has been submitted.
+        """Fixup the user field of a changelist after it has been submitted."""
         changes = p4CmdList("change -o %s" % changelist)
         if len(changes) != 1:
             die("Bad output from p4 change modifying %s to user %s" %
@@ -1882,8 +1893,9 @@ def modifyChangelistUser(self, changelist, newUser):
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
@@ -2334,9 +2346,11 @@ def applyCommit(self, id):
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
@@ -2859,8 +2873,8 @@ def __init__(self):
         self.tz = "%+03d%02d" % (- time.timezone / 3600, ((- time.timezone % 3600) / 60))
         self.labels = {}
 
-    # Force a checkpoint in fast-import and wait for it to finish
     def checkpoint(self):
+        """Force a checkpoint in fast-import and wait for it to finish."""
         self.gitStream.write("checkpoint\n\n")
         self.gitStream.write("progress checkpoint\n\n")
         self.gitStream.flush()
@@ -3006,9 +3020,12 @@ def encodeWithUTF8(self, path):
                 print('Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, path))
         return path
 
-    # output one file from the P4 stream
-    # - helper for streamP4Files
     def streamOneP4File(self, file, contents):
+        """Output one file from the P4 stream.
+
+           This is a helper for streamP4Files().
+           """
+
         file_path = file['depotFile']
         relPath = self.stripRepoPath(decode_path(file_path), self.branchPrefixes)
 
@@ -3100,8 +3117,8 @@ def streamOneP4Deletion(self, file):
         if self.largeFileSystem and self.largeFileSystem.isLargeFile(relPath):
             self.largeFileSystem.removeLargeFile(relPath)
 
-    # handle another chunk of streaming data
     def streamP4FilesCb(self, marshalled):
+        """Handle another chunk of streaming data."""
 
         # catch p4 errors and complain
         err = None
@@ -3165,8 +3182,9 @@ def streamP4FilesCb(self, marshalled):
 
         self.stream_have_file_info = True
 
-    # Stream directly from "p4 files" into "git fast-import"
     def streamP4Files(self, files):
+        """Stream directly from "p4 files" into "git fast-import."""
+
         filesForCommit = []
         filesToRead = []
         filesToDelete = []
@@ -3270,15 +3288,18 @@ def hasBranchPrefix(self, path):
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
@@ -3395,8 +3416,11 @@ def commit(self, details, files, branch, parent = "", allow_empty=False):
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
@@ -3422,11 +3446,12 @@ def getLabels(self):
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
2.34.1

