Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09C5C433F5
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 16:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbiAPQHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:07:30 -0500
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com ([40.107.92.73]:64736
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235578AbiAPQH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 11:07:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUaWxrYh+V1Tf4Far5b8KuRZEv5LzR9DhFt1X+B8jzSnk7myTxFosUrKdBgO1nk/gH+fgM/70ksvEzR9Dc6Q/J+Dn5CVMD/fI0VH+Fvhxmn8+iug8vC6b+6Qxh9VxWV1sHiv9v6BTLqBXATJ9WYWjSxegE/KHQjQVge1fXj0UPuMgDinuaYZMuJGT0BOWLN4CSIpyr10yPLRjNT1bNNpV+WbXI+mXInDrFnNMAEQLMsUjnflGm3cpCYZ0eilOhAGx2ny1AlMJZ4k30COpLDZ5updn+wkAEi/xgRHrqfaXYVn1VvZ1WwcpJxwIbeD3GOc7tP9DQapcpqFGOEnRyzqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrQWXRvET9GkvEwifao5UBFF9NAM11Y089qaaKS+Zts=;
 b=j2xD2JmuNW9kopFjN90c6dHoGzqVW1EleHcVEeNZXqFSCoy49IU6P93f5qtAeBzGkpwG7DoExr1q3EhgKznB+S6UaJR66kcWuMB5uMl7SAz/KW7ssQTX00bPVaVk4gbgjfzk3Cf+iOTBCkgm3uR1NQfgxatLi7C3ClYWsAjMe7g3FWx8+8nrxjlV0ScagrleC1eg/kpYcFo2uk0eeCKk0TDjkCWjf3+bcsOQn/v5L2NTd4hKYiZKTfBLfzv+Mc/gTu6KXNaK410RIdxf1LNPE+DxqLNU2vncUn1jxZEUq5WMbMoLeTxl/6KDzWz4Q+EI68uPv3AZeg86c+XLctwseQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrQWXRvET9GkvEwifao5UBFF9NAM11Y089qaaKS+Zts=;
 b=FkVD+oufqq1kgnl/YKEWRCAdNBk4MX1/R02MJATOl8ScfalMjJd9BRRHkNrX2lG14olLTk3WCO5pm9ltOpQqtRQxV9/P6YdpUH8uSrEEli8BAU5EK1iuh5PdAnsEZpXr7/jNtuIdUZ1o2IWvZDlhsdGlT5Q26dL39BibVXKMBaqLP00SJq99880yTjzyXNu3pIAB3LLr3XyL0rA8mFDIUqwJmsDwMXkUaebrpvGidFapEsz1oSWU0YCWAZcFRgwliD8+qooqxpcGYeDxov6qwt9/mF2Du92R6wiUF/oB341bIc2ihvuCec+cRmHtkeJbONTUXud2+o0lz7tIglYGkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB3088.namprd12.prod.outlook.com (2603:10b6:208:c4::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sun, 16 Jan
 2022 16:07:24 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 16:07:24 +0000
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
Subject: [PATCH v3 05/21] git-p4: convert descriptive class and function comments into docstrings
Date:   Sun, 16 Jan 2022 16:05:34 +0000
Message-Id: <20220116160550.514637-6-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220116160550.514637-1-jholdsworth@nvidia.com>
References: <20220116160550.514637-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR08CA0019.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::31) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1158c89-d0d1-4bf7-a55a-08d9d90a485f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3088:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3088E0065A38083DE8B024F4C8569@MN2PR12MB3088.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:215;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3rt/xDlyEe0zGKlkylrskXB1FQT1NioYhwGv/NF9tVcWdjReOIj5xEFh9AkWNgPkCFJHalhEeFihYyqXp9OTaw9rAk1UGgAU3cfWf3Z4zUu729tWGcR0KPaJ78SXEdC0IWIvZaosq0m3QL5CJaaPw95ldEn0nzpLlix7MkNTubzrEGOKfwkrX+8G7a3+hMlbmSTsGZ6XK1jop5kBg79n1v6UFFUPaNrm9JCNx5lNzeQqEEsrZfqqxncHeZNm/ByF5WD4KXgSppzZ8Myj7yQ7iqFKGjoHBW3rUes1UTN+my9MQ1s2Sx2LNZLzu/7YbEqiaAvj/zhg45zvlL6RebSKljDaNNAIxfBWMVMYc0m1tTy41uitcrd8JPK8mO1AW9PF0CSaiKSWPbQ2K7XXjjlofmMe3zJgfLysvP/kOwRhWgbF2YbSaBRlRHEsqDayL+9E1ZBmM24Bcj9/m2YDy2k1w+hwrjuhqMJTbBslj04jtRq9ZtGn5ZYz5pA4j7Zt/8TTJklgArhSCBai7q0jhpR5DhCdGVcnWDOK67DvhnufjGChG6q3EU8AMnQll7XBQ8lSNx7XPY5hPO1EkfBO/Y0dgxC5EhZq2ELN2AfL5/8TIRNzb5jQUaa+TSnrAjUAq8n8CeKORc5jqdRMsMozAXVUetnJixUoekSNri/iIiZr9gXTRUkfhc7CH1k7DWC/Ln86oJhDR7eg8yzBpJ7XAIJHKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(36756003)(54906003)(107886003)(7416002)(110136005)(83380400001)(2906002)(186003)(52116002)(38100700002)(316002)(6486002)(8936002)(38350700002)(2616005)(4326008)(8676002)(6512007)(5660300002)(66946007)(30864003)(508600001)(86362001)(19627235002)(55236004)(1076003)(26005)(66556008)(66476007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pcRs2SwbDkDphlwNIFnoy5Y2CLa0mYgn1+pKgc1S0EcLR8cejItPXl0OiZzp?=
 =?us-ascii?Q?JCFATzxU61Dls8jfvHsqb/wX+vVhSi9hLEdm1/GwEVCr4Fo23sQ248suIJXf?=
 =?us-ascii?Q?NLuZla3VM2wJhwO2mr5ujMjckoK6YusB2iN7CeJGbHNoQO9DGRmjQPhxeuir?=
 =?us-ascii?Q?5RtTPW6ve9Pf/pJuaK/1uUj6OXB0sqpVLVFMUxuQXBly1/953rOVcXJH1DSE?=
 =?us-ascii?Q?EVqs3C0M3GGBqWrlxlodrjMAcPIA7yxqBYwTYnCqZtISe1KRuOclygORapr0?=
 =?us-ascii?Q?wGZrTOJF/szm9vjLPfYhF6EPJsAtMcRbPtW+p+uf04F1QJIicLUPW8t4Fkki?=
 =?us-ascii?Q?NiADA+c7kH6rLJZTd7FkeM9xnTIAwmKqc4AugfN0H0Mx+LxpDRZeZ5jyyIbe?=
 =?us-ascii?Q?QxTUaMJ3Eaa2F3GooizbpyNnUC1Srd/JnEkU942OTNTqg0xG1LJll95FC42P?=
 =?us-ascii?Q?+PgMgA64kch6Lxl6EvgB7s89KTss5jP6BHmMj0OestbpDOw3Fc9z0GigpuZp?=
 =?us-ascii?Q?CNnlyAKybTDnZyEHnOarrgY36Z2+HkTHAnGIvboyaYsPM1WLh01YhOBRUPAu?=
 =?us-ascii?Q?lJcv3WXV//eIQLPR0S0UcCGFO/8H3/HqsD461NxUeu0jQCBBN/ppgQHjd/XL?=
 =?us-ascii?Q?SFJ6biqMH17fHJmn+3pYhiLjoSVxQX1fHWF3zLWS/Dvew1Z22OEQUfqFOUqk?=
 =?us-ascii?Q?G6Gkf5l+hOn7SwL9tG4xts49A3GiZqR+NIVQUPUWuLYCD5jSEjx4mVzNgSS1?=
 =?us-ascii?Q?bESJ2z4PFa+v61UuyB+vWFR2M0L3xwaZFZnYoq1boriElwDY8fUbB9ULLki4?=
 =?us-ascii?Q?zJA12M0kHRpSlMChBVSgAhBVAujAV57nT8NfVUAuHPuxpBIMKmT9gvQ5Lw4U?=
 =?us-ascii?Q?2NFNbEQdKaGzLkH9jp+mSJe8vd3CihUDolpCYrBfh7SWaTWr+1XGvVNDzu77?=
 =?us-ascii?Q?kqivuIHM7xUZXh3FhPKzXZ9kec1+f4jQTbnEw/wu6weB3MFvnk56JUw/ZZmU?=
 =?us-ascii?Q?gZtJSd0vJpjYfHwR1ccPGYSv5nBfzztowwnd+IcRKyDveLouWpe5kgM6CPxl?=
 =?us-ascii?Q?0SQC7glCcTcJ3l5Vy3HL48ipcRYnd1DxevDUdokCE0lB6ppim6XHwykO+qKv?=
 =?us-ascii?Q?dysybc5+f9i6AFGGmR4ZK361855vcieIQIBx7ay5q2IIAQGbgltcJpebaNk6?=
 =?us-ascii?Q?eAG4L8qDnYFVT7pqOtKYuIthriN3+Lf5nWm/zDcKYKjKdFC0I62foUvp2EDi?=
 =?us-ascii?Q?wOYrw589G/vKmNU9M0y2hdOrcn6tfTwpqvE4TdarN/+2yoefwaMkirim87HE?=
 =?us-ascii?Q?mjiUu9bJN9cAeqYLt3UuVWTN4U/o0p71l5qoeNl84fzXOCaDZbE/jACua6c4?=
 =?us-ascii?Q?fYVA0CqoTM04ay0OuFdFt8scjCaYZlFUDxfM7dAer0qeCmKdBR+b5lrjvOBD?=
 =?us-ascii?Q?SkPRFTVBYxPD06BtFBmK9lpYc030qitOCIByCLCaDDv4ioTelO39wdsJIe6k?=
 =?us-ascii?Q?NBOhcIEHEQL/yC5h8kYyfyOQjGpfoh27Vv6zEPWVDH2tZDn9KQ9yn7Ck59WW?=
 =?us-ascii?Q?1d/pT0OaBA729lHQ1HdD2tP5zsFbgtQSxFLIGWKgSZVXD1Hzm6KU/4kLEOSD?=
 =?us-ascii?Q?Jb2Jst1sJAiXb9xzNGWEZ98=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1158c89-d0d1-4bf7-a55a-08d9d90a485f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 16:07:23.9118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2byIr+5aqS3zD/pxKsupcReRSqGmUaWNgnACRFs32VZtIbF+TeG+uxLK8GrRXfH4+4Lb15IYMZMNh4iEXqQ5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3088
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
index 28d04d5cd9..01e4e58561 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -516,7 +516,7 @@ def p4_sync(f, *options):
 
 
 def p4_add(f):
-    # forcibly add file names with wildcards
+    """Forcibly add file names with wildcards."""
     if wildcard_present(f):
         p4_system(["add", "-f", f])
     else:
@@ -584,12 +584,10 @@ def p4_describe(change, shelved=False):
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
@@ -620,19 +618,18 @@ def split_p4_type(p4type):
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
@@ -644,12 +641,11 @@ def p4_keywords_regexp_for_type(base, type_mods):
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
@@ -658,8 +654,9 @@ def p4_keywords_regexp_for_file(file):
 
 
 def setP4ExecBit(file, mode):
-    # Reopens an already open file and changes the execute bit to match
-    # the execute bit setting in the passed in mode.
+    """Reopens an already open file and changes the execute bit to match the
+       execute bit setting in the passed in mode.
+       """
 
     p4Type = "+x"
 
@@ -674,7 +671,7 @@ def setP4ExecBit(file, mode):
 
 
 def getP4OpenedType(file):
-    # Returns the perforce file type for the given file.
+    """Returns the perforce file type for the given file."""
 
     result = p4_read_pipe(["opened", wildcard_encode(file)])
     match = re.match(".*\((.+)\)( \*exclusive\*)?\r?$", result)
@@ -684,8 +681,9 @@ def getP4OpenedType(file):
         die("Could not determine file type for %s (result: '%s')" % (file, result))
 
 
-# Return the set of all p4 labels
 def getP4Labels(depotPaths):
+    """Return the set of all p4 labels."""
+
     labels = set()
     if not isinstance(depotPaths, list):
         depotPaths = [depotPaths]
@@ -697,8 +695,9 @@ def getP4Labels(depotPaths):
     return labels
 
 
-# Return the set of all git tags
 def getGitTags():
+    """Return the set of all git tags."""
+
     gitTags = set()
     for line in read_pipe_lines(["git", "tag"]):
         tag = line.strip()
@@ -749,8 +748,9 @@ def parseDiffTreeEntry(entry):
 
 
 def isModeExec(mode):
-    # Returns True if the given git mode represents an executable file,
-    # otherwise False.
+    """Returns True if the given git mode represents an executable file,
+       otherwise False.
+       """
     return mode[-3:] == "755"
 
 
@@ -1259,13 +1259,14 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
 
 
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
@@ -1317,12 +1318,14 @@ def getClientRoot():
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
@@ -1336,6 +1339,8 @@ def wildcard_decode(path):
 
 
 def wildcard_encode(path):
+    """Encode %xx coded wildcards into P4 coding."""
+
     # do % first to avoid double-encoding the %s introduced here
     path = path.replace("%", "%25") \
                .replace("*", "%2A") \
@@ -1582,7 +1587,7 @@ def p4UserId(self):
         die("Could not find your p4 user id")
 
     def p4UserIsMe(self, p4User):
-        # return True if the given p4 user is actually me
+        """Return True if the given p4 user is actually me."""
         me = self.p4UserId()
         if not p4User or p4User != me:
             return False
@@ -1785,7 +1790,9 @@ def prepareLogMessage(self, template, message, jobs):
         return result
 
     def patchRCSKeywords(self, file, regexp):
-        # Attempt to zap the RCS keywords in a p4 controlled file matching the given regex
+        """Attempt to zap the RCS keywords in a p4 controlled file matching the
+           given regex.
+           """
         (handle, outFileName) = tempfile.mkstemp(dir='.')
         try:
             with os.fdopen(handle, "wb") as outFile, open(file, "rb") as inFile:
@@ -1803,7 +1810,9 @@ def patchRCSKeywords(self, file, regexp):
         print("Patched up RCS keywords in %s" % file)
 
     def p4UserForCommit(self,id):
-        # Return the tuple (perforce user,git email) for a given git commit id
+        """Return the tuple (perforce user,git email) for a given git commit
+           id.
+           """
         self.getUserMapFromPerforceServer()
         gitEmail = read_pipe(["git", "log", "--max-count=1",
                               "--format=%ae", id])
@@ -1814,7 +1823,7 @@ def p4UserForCommit(self,id):
             return (self.emails[gitEmail],gitEmail)
 
     def checkValidP4Users(self,commits):
-        # check if any git authors cannot be mapped to p4 users
+        """Check if any git authors cannot be mapped to p4 users."""
         for id in commits:
             (user,email) = self.p4UserForCommit(id)
             if not user:
@@ -1825,10 +1834,12 @@ def checkValidP4Users(self,commits):
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
@@ -1844,7 +1855,7 @@ def lastP4Changelist(self):
         die("Could not get changelist number for last submit - cannot patch up user details")
 
     def modifyChangelistUser(self, changelist, newUser):
-        # fixup the user field of a changelist after it has been submitted.
+        """Fixup the user field of a changelist after it has been submitted."""
         changes = p4CmdList(["change", "-o", changelist])
         if len(changes) != 1:
             die("Bad output from p4 change modifying %s to user %s" %
@@ -1867,8 +1878,9 @@ def modifyChangelistUser(self, changelist, newUser):
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
@@ -2320,9 +2332,11 @@ def applyCommit(self, id):
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
@@ -2845,8 +2859,8 @@ def __init__(self):
         self.tz = "%+03d%02d" % (- time.timezone / 3600, ((- time.timezone % 3600) / 60))
         self.labels = {}
 
-    # Force a checkpoint in fast-import and wait for it to finish
     def checkpoint(self):
+        """Force a checkpoint in fast-import and wait for it to finish."""
         self.gitStream.write("checkpoint\n\n")
         self.gitStream.write("progress checkpoint\n\n")
         self.gitStream.flush()
@@ -2992,10 +3006,12 @@ def encodeWithUTF8(self, path):
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
 
@@ -3087,8 +3103,8 @@ def streamOneP4Deletion(self, file):
         if self.largeFileSystem and self.largeFileSystem.isLargeFile(relPath):
             self.largeFileSystem.removeLargeFile(relPath)
 
-    # handle another chunk of streaming data
     def streamP4FilesCb(self, marshalled):
+        """Handle another chunk of streaming data."""
 
         # catch p4 errors and complain
         err = None
@@ -3152,8 +3168,9 @@ def streamP4FilesCb(self, marshalled):
 
         self.stream_have_file_info = True
 
-    # Stream directly from "p4 files" into "git fast-import"
     def streamP4Files(self, files):
+        """Stream directly from "p4 files" into "git fast-import."""
+
         filesForCommit = []
         filesToRead = []
         filesToDelete = []
@@ -3257,15 +3274,18 @@ def hasBranchPrefix(self, path):
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
@@ -3382,8 +3402,11 @@ def commit(self, details, files, branch, parent = "", allow_empty=False):
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
@@ -3409,11 +3432,12 @@ def getLabels(self):
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

