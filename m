Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621F5C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 13:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhLPNrZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 08:47:25 -0500
Received: from mail-bn8nam11on2057.outbound.protection.outlook.com ([40.107.236.57]:47297
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234025AbhLPNrX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 08:47:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhiXRysZkKDofYfKB0DpFPdEjPmttLPNpYsptU3ug4oac7VCb5fgiummu0VpICYn68n0R9x6RD24eDJYMXsqHQ8Z9a9cEOSk5rD5qE4ZAUY4y6dCTHSFpOuxvxt+Q7FZ7OFeAJ/Olrh++HacrcGrFsuSyTysuYOJxw58rwdazMZzDuu2a1+tgxjlPNtxj6sIj5CZmEPJOBMnar/AfOpU9lQ83L9EUCL9jFOPnvUIalCvpchAeZWAd8Axo64iwPuiDmlZ68bXAjZiUFzwOMff5gs7NClmBQz7OSHgC4XXE6yQM4sYvJ5DKIRGVBja8wKvnkgwMF++Q30HtNFx6SIJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UtJwWaLxcuO0LcZQE6toP0jWfy05EyFdf93XDYv62s=;
 b=Vbz8cD6i2MuvyECqeLJ3PiKXsPgsNknpS1H4TakBXQ2PIrI+IYIEE+pZES/hEsC+v4R7Ca3bECxtDJ7t7k8aztXorTxkKs70dMMEdNqZrh4Atn+n/rzYqknmQFAoh49oRtq7t8HHXiL76JJnoN/XY7VE1/S1CFb2kszNCMZDWlkgB51APjz2HRxtI4y1IfUqAbNV57Y+sYhgQx1s1zUgRlCjuW1LBj8tK831mmemGwb2QmAdOIJrPgyd0ro9isiS7Z1ByawKyKrmfI+WQJjHkywWmRCNqVH8Cb3v5l44eFBYbWhO7A1fTaLV+Id0sNW/L7wvPeCY6MvKZcEPHdJWag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UtJwWaLxcuO0LcZQE6toP0jWfy05EyFdf93XDYv62s=;
 b=dOucWAs89tBZVE678o1pgAOajsUg3X8SohK5gVqsQXtAKPvVC5SZpY1O/ARDIOjeisxC5++5xU87+EmkGoijdD44ycfT/s1xrnshHezLx+kYcfKbaSmi45fDXgwLdHWUmoS/YCBQNcl9UG4qpThwkD2xAjjersXEuXOpy2kWKZGJbMS2xGuPZdQV8NuEgwoB8win2UVZdJXypaKnAF2kyIeSIQoOkInvV2dzkxTrZSmONha1a0JxfPhbNNoFjGLiplhGT0vPmFw9T301NhMT/zzpOSXV2jYur+PfwxcXw9M4AR43X/KjaRJ98QMpUtuEFZBeb/DxHjvj/X3x2O0Ptg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Thu, 16 Dec
 2021 13:47:22 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 13:47:22 +0000
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
Subject: [PATCH v2 2/5] git-p4: pre-compile RCS keyword regexes
Date:   Thu, 16 Dec 2021 13:46:16 +0000
Message-Id: <20211216134619.2048348-3-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9fb2f639-af07-49cc-bf91-08d9c09a95b7
X-MS-TrafficTypeDiagnostic: BN8PR12MB2946:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2946EFD252AF118546390D78C8779@BN8PR12MB2946.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9LCNJXRX11fIrWyEUFhcnmhIrMckJn07XNufZ0zGhyochPC+xGIh+KFP9+9/sk3DfCuUd2cm9d7NZnRr9xOUB2Eyyw0rTfnwlbgwN6oSePrk7OS474QKZ+q7CK37Z260WhD/uXlMYNePT5hnrQ4Jy7U50oAfn4S7AdR/z2zLozgv3u2V7JVlRxmlqOwHAQQETTvkR1XoMQyCacTOg4/4sEIQcI7e/441ASPJez2aW2Lh0nfG3daThUh9AjsNXxMCegucRYHKMkbGjGKHCXSQYB5deXQtemlaYZegRgSj1r36hntL3yT9aHevoeCa/vTnNvZNZr03u20UEOZZw28u94lq8oib7Em8s/IgdxXk47MhhZl10dfInUaMnV6fDvJyCsw72TxK4eGM2C7q+XQInxk3GYHpTOzdv/6xa/X+YZU+KekC3WeajAxKxQvcrE5POUe000g4/yDbWFm4RXvyuwdmScBkNA36wPfqbGeE6aqEm9ysFN3B8Bx9MluYRKs1FYsgG5S/uUXLiddJej/0p5TvxaTLiCgTTr6Pv3kjTBbDqRZcGBYwy7nKCPW2kI5dfq2o2m6HDv7GzyClf7Z/0m0eAmeEXKx4nKQHdv5BpVrx9ZbB2NT+AahI/JqKZtU0MCtxOWpgADyLmnBHyeOehF4I+++nRYwv5reUjkNsHY22EYibarP/y1m22b5A8kRpJp/ZMTilxoqid9jzYe1yqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(5660300002)(66946007)(508600001)(86362001)(55236004)(54906003)(66556008)(6506007)(6512007)(316002)(1076003)(6666004)(6486002)(66476007)(8936002)(26005)(6916009)(107886003)(4326008)(2906002)(2616005)(36756003)(186003)(83380400001)(52116002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5u4sQcPqVHOM7CZP339uWuhPphsPVCDabjd7TJAYykRzdKS6MnejDEk8vt9W?=
 =?us-ascii?Q?KC+Ei9x8e2VBW4UUNbIYKCrQWvRWz3SjzRiZaKbKhOUS99sym/U8JIBb9xWk?=
 =?us-ascii?Q?N6Dfccy2tCuaE1Lllta/mUcq/ZGpYHDjriGmUnvR6BHcOZbvAgkbwnKCdR2f?=
 =?us-ascii?Q?FvvuABub0p/Vvp5feah3ooJVAN5RbwVrNRI2T2/mdupHVZv7pt09gCFwaAxX?=
 =?us-ascii?Q?fhxd1Rc/B84T7IAHatH8tqBmxmEVrpjX4kG60CSSq5TZ3rLCr9ySaD6Sp9iL?=
 =?us-ascii?Q?aM4bGB9vtxDgRBqJ2DP0rwH41X+HmFkeFBsqmcY75/lSGeKEaHZeNGZXe/Bf?=
 =?us-ascii?Q?PFg7F++oOGIxG7HANeDar4oc7qOlsifbAnQpJrWk7FD6PjvbogUoKWaYj+Ir?=
 =?us-ascii?Q?grwKREEkAFH4+a3fg4x/QHv6D/ipHxIe+qUSKjNBo3YhozztE/XUp+OLaCQI?=
 =?us-ascii?Q?sk8QLWG0UNf+LO4nVgkt4BmtJeEm5uXWhhQJ2bso/maylNXyfzzhFaezmnDk?=
 =?us-ascii?Q?hUozI+peyfo6AXFR2e6mq2Zs1mxnwYSusJQa1itICwKYymUqnIgxOv6KGE/G?=
 =?us-ascii?Q?UnNFiXN5S48xdIzmq9EE/JmOdS0Rp2XZ1P7hrUQS7oz2RB/hj+T9cNhKN+hU?=
 =?us-ascii?Q?W6Ugr72gUjJmNZBWVxaepYwTmjlp07ZjDHo+dZh5NqChCu3aGzQvZhced9Pf?=
 =?us-ascii?Q?wSxfZecUFeBMnGh3zZThlOCRyAVokuQb0TxMox3AtgIgOK8wBxn7/qzR7yNZ?=
 =?us-ascii?Q?Eu6lbZZMVLwbmSfBN0mQIkl+OBXtfBY9nDDsjAC7MvV3W6XbE93xjSZi2EZN?=
 =?us-ascii?Q?1hYnbO3Xlp7URWDPxf2wkPramoqQ5DKBC9e1xK1HxVXOV53xeacnnh492h0b?=
 =?us-ascii?Q?aALgpCbS37t8Efd6uXogvJOdlNFmi2kxSze5W3IjgrV42z7uBV713rCQ4lPY?=
 =?us-ascii?Q?FuZhbhMegzQd4d14OOey2HE0DgNk830/TrLTCJfNRBxKSV2mt29V0D7jN3LZ?=
 =?us-ascii?Q?H3CDQawIm0ZBVoD2EOs8fQ5uSOkitCmnOrMeSuc8FtgaHeKs0w+IoBsw9KsF?=
 =?us-ascii?Q?Qu3os9brnfP81Ie2qgjprnQ9vqZvupu2n1LJO+GbVFBfhs5Nyo8+uBCHy0Is?=
 =?us-ascii?Q?sxwRNRHAEgE0yKlPqWbUbF5wevPXo+48lUEIb7bXgVXc01nDxn08mfYHzKZp?=
 =?us-ascii?Q?G1ZwHr2DVNwTb+ybcMj7/OuxsP3F074AsQxVXMd8h5HSh3KpXeCd9S/20D9o?=
 =?us-ascii?Q?fDNCyGFT0WmVYfA2Ey3Lpipv7YDLjMxxDy5pBd3oelHU0DYToHSGUqipjW8J?=
 =?us-ascii?Q?4sImbGfh2GGtr7+eAMR9KjWH8tpIkl/zTOo9U280WR2t7QTTTRYCDUGtaYWV?=
 =?us-ascii?Q?6/DumWifXwNu0LLKuE01w99hALO7F7IE0r1itBNRiAFEQa3q1m+A/sF5Qsra?=
 =?us-ascii?Q?IGL+euiRfLXXYzuHJIzF+35eUJbfAmZBZ6gDmYoaq4UNcFknAb0z5Go8czzz?=
 =?us-ascii?Q?zgiY2z+7U8JYyZkQ+Qo8FqW8SnqD5erh2THKEErx5In8Ir6q85KouTetYjhX?=
 =?us-ascii?Q?vf3rUm7iBXgu7ugGlavWS5oi0NuMtG8cnP1scbH0GwmdlkfnSGrjDKts/sdT?=
 =?us-ascii?Q?w29S7RVh8SRgve+8BOiZqy8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb2f639-af07-49cc-bf91-08d9c09a95b7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 13:47:21.9979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7ZybHKO/k8EXd9lbHUlP7U74raWA+pVdVW8pW3q8lzvRQTDpd/9xgNZ86CckK3iTMSw7SvkTvNxtC1ZYf1rsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2946
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

