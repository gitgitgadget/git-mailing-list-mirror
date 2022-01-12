Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8DFC433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 13:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353687AbiALNrq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:47:46 -0500
Received: from mail-dm6nam08on2079.outbound.protection.outlook.com ([40.107.102.79]:20384
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353694AbiALNrU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 08:47:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ax7+QwajWx79wSRAxePXIM7uX28ymZrNJqM5cUcrG9UYENAZTIsgwPdSykaLnHZ2c+vNN+mmBWZLSuurhMl3JquxAv9URKyBTUx0bx7asDUxf0jioWn28Ns/Q/SBys5zeqW2M6VSFRjKteGuVWG4UTR3IPc/siUZcaDUxV/aGEfm7DMzt56ZBfQVb+jVVy+bSoDPVnrdTNG0ELP8Klq26V+43IG9qfJuSG1p44UlHmoK/GBIN91+bCEZjLz4jSfgD0pjsuYBmpZI2qGJTEwvGZ4lxwETjxuswFLj0tU56petpSuq7JSZi6azDCvazGOGuJBDflLC09wQyzvUfq7LsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWjSEpl1imDfOQXWNnXjPs52X+2BjS3OVSoU84HI9eA=;
 b=KpTRR4Tp5rjuQrvY3uqghO7g81vSRbSeobh102zog91d9mHcrz9Ld7p3qJXv/aTT0p5ZCaOfhs/wKHzh53rZibd2zcfIVVsakJ69jXdW7wLxyViuc83AG/sB/ppDOXwuOeEaJcl2SrjeDIjg4vxKhfTHiZtGqep6oO0nQiV983pHtmQaNee+FSRTRTyd+Q5SSbQGt3Qyc/+mdwywJDpFnx/BX4E+2v+22q7qprA6bpJYuQk3um7aAkDreQwzOUXmSW0SOxn0rFMIpagHS1y7xq1miCoWkIeDYqO/KPcbFgUvDUSNjUTssc/FDzccPiO37soMys2T0qjmnu1K0uUKEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWjSEpl1imDfOQXWNnXjPs52X+2BjS3OVSoU84HI9eA=;
 b=GJnA7nrNuFytiiXwV4cB6TLcGyOWVORrZ8APryCGs4olXTlX5bEsy55LSj0HMiXu8LZ+ivYdYy+prClHu7Hn+TS8Z4bHnNj9VLvExp8QTMVwN8moCVnikYRU2ai6q7NjfixmxfVViqN4PMAFfZDF83Ie3v1mTeVNFrhKUv6qUMNjAe2zFO4h3OcUt9cxb9zKo5SYrRvkV8elLbQpt49R3zpRpFsP/mfe9nrKieMecubsTnz9hp5vgfF3XdRj6Jg8HawpbwfakqWBHncN/tWPCZNvsNex0z5JE1FhVIGJ6zdF7ZFolxDClT0qC9fjsEauAnp5y5mFuKccT4ZN3DFDaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 12 Jan
 2022 13:47:18 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 13:47:18 +0000
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
Subject: [PATCH 05/20] git-p4: convert descriptive class and function comments into docstrings
Date:   Wed, 12 Jan 2022 13:46:20 +0000
Message-Id: <20220112134635.177877-6-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112134635.177877-1-jholdsworth@nvidia.com>
References: <20220112134635.177877-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00a66a9e-cfb7-4ce8-9bae-08d9d5d20cd0
X-MS-TrafficTypeDiagnostic: CH2PR12MB4279:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB42794907F170D9800C89261BC8529@CH2PR12MB4279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gqsJdfwQeGdEBJT3kMqJrG4ij8/j5ulgiKOCAhd8m6TAf8RJzT5EFmXi8vaBKhP5b7CO6HWICv1jJyqEkQ7XKGiqNcclD9d+Ox3boy0W5OYVaa7BTQNBBVZ7SunaQpSzhWBWZ14BTBhifA5il2oOzw5ntzI8xcuULyDGteeVyEUfIsWgEL5Nksu6Aw4FmPtPNQ5j8/ctpkNBnZVs3I4ySSVoxwSl2YpIRRL2CBaIBWX0V8Utl88yGXWueKuE2pFXcAA2so+1EKn23Qx5dKW3JSx8h7qG7Pdrab442IvaOpEu+PFpm/wEUKZHUTyi2dW+XbvcJtu4R75o+eutOY55B/OycR0YWOcPOrhVPN1w5PDYwdRWjx8vmbCbctpk0cMwGU1+ZCWvHx53kOk+27N+COwQUE2IvGuTHjWP+e9NGxqijSAR9CVUTlHUEX7uIF3QZDjal890GgOq1ar+bd4SiEHmwX0xUHwlm68BSgS8HUXK1/Beo9w+QWTGk4L92SrGUA7YHtEGggvEYDhLocM8GwtSW0DzMc5EXtF5AXgcJidhvvQL2DJB5mODLTPwOJ3bMqrAfVC8GxbpxD3IlBA5lFDedaejrj26oSl5pI6/6jHZFnEtFRQho95u0PzzVb8hCCvErfwOmzMuomA8+Ib8YROVpoBHy4PiXVYpGB2fd8krQZQpGDyILT9FbWjRqnFZrrfLYPDz7tk2yJrZLnn5Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(30864003)(1076003)(19627235002)(55236004)(7416002)(4326008)(38100700002)(38350700002)(508600001)(6506007)(86362001)(54906003)(6486002)(26005)(110136005)(6512007)(186003)(8676002)(2616005)(5660300002)(66476007)(83380400001)(8936002)(2906002)(66946007)(36756003)(6666004)(66556008)(107886003)(316002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bfp1sW2wGhvUHlVsmr0vUv3cWk25c06n0SX+wlPy8HKDD/XSMdZsfcOsKQTu?=
 =?us-ascii?Q?gheQTub5K8Kgu87zY3Rwrk1H9oycYrd3tlnEYfopJ7H31ERIomXij2h62oRb?=
 =?us-ascii?Q?o7QuoszHrhndXqxIsCW5qbyjcXRshsWWiXbHIW6eDqEUFaHC+amVNvdrDsuX?=
 =?us-ascii?Q?BtPxVcjtlioSYsXfy5CulZpWyzRxxsf0RVvx5vdIFAftdkKJyoAmKP5bsYeT?=
 =?us-ascii?Q?Cb7nMdmy5W5V/XyCRiPqUkHOss8cO36bD5mlffxxY8vHnrOBLkQkihSCLnak?=
 =?us-ascii?Q?/rLeX3zgsLg2Ks5W2Jlklj0e0JzqYukNck0DXTPh7cAmRPO0oQIqQBU5aCXX?=
 =?us-ascii?Q?aphJP/tY/ShSYxFZPaVYiplZH4vwN9PO8fw+st3+3dV1CuT5LegdOr5gK/vk?=
 =?us-ascii?Q?qE9GYLkIYSZrHbbG+sVVa1RL9zqsx5w5tawaGQ8tIm9QRmkdRKkxI/olMg7a?=
 =?us-ascii?Q?vyS4CmpKG/HdgOguETxB2/9qCBI0gJ5IJQ3qNeaBa8ImiAyadfWkrpiOcYqG?=
 =?us-ascii?Q?YDelZgNrirV5l7joaoUFB/EfHuUmTQNwpAyJUmJMsiUKVIQS8QfBKADLuUg5?=
 =?us-ascii?Q?U/xDYbQz7rhT9h3yEFI9UA5I0Wuer4e4NgWVYMJPZaijIXZPDWn7aH6nGyJQ?=
 =?us-ascii?Q?N2gUB07pmiL0CySi7HLv7eeapMqX0Ep0iDofFEehnMzR1QQ4WelKBMsutxyT?=
 =?us-ascii?Q?ttdZFp6OwwChatI3S9OIPtcM4fcdKD1sUgRC5N8sBiBdZbHrO8VtaLsUykYl?=
 =?us-ascii?Q?9qlud/FOB8ruFtPwlkmIPWfNkjHxJqU7pri2CJUnHO1KsLQYodMqQMwMnIY/?=
 =?us-ascii?Q?VBT/bYfkdmgOTj2kTARcOC0lLv0IM7jeuAtYPgphVe2/f0aLkz8SH4rPChkv?=
 =?us-ascii?Q?WASEX8/pHK0X2yOWq/OSsuJqQQZNm5zJuqZZyg9VVGhCK+JUImDROYGQa8ID?=
 =?us-ascii?Q?8nNG1lF7TsXE1zBlEI1pEZ4kWTniV0i1nvnkKHxhVQIz/wbE2+UaUo5M+0xc?=
 =?us-ascii?Q?xXbgLFjVbidVZK9UBW45AntEB8ImhVQlly8eD+BJcRLQdFMvQ3xUjt7vn4Kp?=
 =?us-ascii?Q?g3ZzEWBJgayatkmkWJThDSBUjqXrfJnlFE5lsoXMcnJXeDDJn6NwvCTSF9zR?=
 =?us-ascii?Q?YrYNRdR9xeH4Xsj9PcHZtxdK3gb02gIuiA+PTKLKGO7pwawwEmQx65rE+ANY?=
 =?us-ascii?Q?gqReqxRHbZfhctq6chqUnG5cCQktE1iInUZXDndrXro6Vp5zrGON5EQVPd2Z?=
 =?us-ascii?Q?5veO97WevusNGPSZMkqiQpdd0tqcoGYSysdFGuyPy3k2uLSgPEwumrgTAQUh?=
 =?us-ascii?Q?5Y2mQ1BRA/bt9eUW/P3Nm56Q2HTW8C/PG24/V3rByCEAblmW+EjQn027S2Wu?=
 =?us-ascii?Q?GA5TsIYz93DY8bKcBzNzoxX2xN0nXkSAT3cNw9bojb0cn0P+YvO6bi+/LXxY?=
 =?us-ascii?Q?OYacfsGfkl78nHgDs2vEkn9AiUXlbTh1dw6xpjxF4pkfaV4b/mnIzaJx0IbS?=
 =?us-ascii?Q?K8IXCJo2kmNooEE33mioGORTb20j3VI1fwcruKjBosu582jTXnNwmOcjbVuq?=
 =?us-ascii?Q?uGEcyotjrcCPoJOQj9I/RzR5XTYwBvV7xf6ZAirT23Gdr878Mv6aupp6+WdV?=
 =?us-ascii?Q?ley6x+VIkmQO8Piy4vlb96w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a66a9e-cfb7-4ce8-9bae-08d9d5d20cd0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:47:18.5419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RquUoBwElnz8Sq0CCPR9IXT176NgvfNjEVxiN+EZz4OWvX8V8KfabAZTCP1q/ul0G9tiCv4QmwPdvpMBrWQ1Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, a small number of functions, methods and classes were
documented using comments. This patch improves consistency by converting
these into docstrings similar to those that already exist in the script.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 162 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 92 insertions(+), 70 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 93f4ec843f..0bd1ba00ba 100755
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
@@ -1332,13 +1333,15 @@ def getClientRoot():
     return entry["Root"]
 
 
-#
-# P4 wildcards are not allowed in filenames.  P4 complains
-# if you simply add them, but you can force it with "-f", in
-# which case it translates them into %xx encoding internally.
-#
 def wildcard_decode(path):
-    # Search for and fix just these four characters.  Do % last so
+    """Decode P4 wildcards into %xx encoding
+
+       P4 wildcards are not allowed in filenames.  P4 complains if you simply
+       add them, but you can force it with "-f", in which case it translates
+       them into %xx encoding internally.
+       """
+
+    # Search for and fix just these four characters. Do % last so
     # that fixing it does not inadvertently create new %-escapes.
     # Cannot have * in a filename in windows; untested as to
     # what p4 would do in such a case.
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
@@ -3006,9 +3020,9 @@ def encodeWithUTF8(self, path):
                 print('Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, path))
         return path
 
-    # output one file from the P4 stream
-    # - helper for streamP4Files
     def streamOneP4File(self, file, contents):
+        """Output one file from the P4 stream - helper for streamP4Files."""
+
         file_path = file['depotFile']
         relPath = self.stripRepoPath(decode_path(file_path), self.branchPrefixes)
 
@@ -3100,8 +3114,8 @@ def streamOneP4Deletion(self, file):
         if self.largeFileSystem and self.largeFileSystem.isLargeFile(relPath):
             self.largeFileSystem.removeLargeFile(relPath)
 
-    # handle another chunk of streaming data
     def streamP4FilesCb(self, marshalled):
+        """Handle another chunk of streaming data."""
 
         # catch p4 errors and complain
         err = None
@@ -3165,8 +3179,9 @@ def streamP4FilesCb(self, marshalled):
 
         self.stream_have_file_info = True
 
-    # Stream directly from "p4 files" into "git fast-import"
     def streamP4Files(self, files):
+        """Stream directly from "p4 files" into "git fast-import."""
+
         filesForCommit = []
         filesToRead = []
         filesToDelete = []
@@ -3270,15 +3285,18 @@ def hasBranchPrefix(self, path):
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
@@ -3395,8 +3413,11 @@ def commit(self, details, files, branch, parent = "", allow_empty=False):
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
@@ -3422,11 +3443,12 @@ def getLabels(self):
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

