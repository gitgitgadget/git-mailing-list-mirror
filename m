Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99854C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 16:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241886AbiAEQP3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 11:15:29 -0500
Received: from mail-dm6nam10on2079.outbound.protection.outlook.com ([40.107.93.79]:56289
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241882AbiAEQP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 11:15:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWHjOWJ88lK2sXF446ULcHGDGZE5q1/mBRTcL/MD3+ifSjR2UWW1K9rjNjF+/7aZbDjSOHrKwe6j1bbfULB0qqtiV2ctH6oQU7fxvTxwuPW/hjbIP0eaDrt1CT0KSS1x/1ZnypHa0RD5eCyDTkfzkrTm+mwY65HLyt5V85tfJ+EVTgGD1VQwHtrgwElDybhwjE/+S6mDddf+UsHeuIAom0HPSp9uvAEfs2yaXXg1MFeQCtQJxZDBD36SurtnE+OjLquVanq8OFnhglQMRh2N51yYsO0D7K/NZRpGltRdfsuoS7ldFW4EGZYeT0p7A7hoNT1HsJT0FCM4hoQk626hJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wB63a1NljUfkkAhqXmg4BJT1EhG0TM+dm7Cnp72Ghk=;
 b=Ya1pxRCGaZmmRyZxTEERKCqeuxETSjAAixP8zyDFvx5S/Ygt5bOS10OuYU1e4aao3CSmkUW9thdNRabuZNhLFNSlXdVVZzM20qb+9m31NQ70zGqL8NomAP7QuIfsdyQecUeDRcCocUOha+ftrxc1wIh/DkEqsc7RkAEYVyRvIEHlrKe6TkNVRsUjEoIkO9NIaPdEq2P8Z1KHQlYmNJ0IE2KBd4Fy2RkrFChzBZxFIP7pM22XRvud1tyWBnQVi6XDn7Gx3eJYBY2yyBHeclqryIB1BZtzlV3JSnNaBSAC4pce/80CUbwUkPiPeJ1/EzCxOhmzYqRULn4oY/NujYau2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wB63a1NljUfkkAhqXmg4BJT1EhG0TM+dm7Cnp72Ghk=;
 b=B9TeOsWV2XFyCkR4MRMf6moWbHa5IxznAe95zkq+h27XBcTKWegWgrd1Cfeh406/7Bu2JSjKDsQp9Opr26ype78MR0moZHD3FrX3inH5wt5CnMCbNEmPlUnxJQLSfBBaGx8dWVfdOAJ2ZTdx3Nf5ddAOYqSMr+TjCvMeYBLkxqxd/PF62bwJ5HGy083eB8JGCoYW4hAscJLLJanuZGGA0owvBlfowaEQ9T9j7JIXh5ORNsXnIvybGDyAVovyQjED6dxE5OjVkejlQSYyOlPLTWjj9711RJrP+TPwjajrzMhWxOv6sByBMSkFkoCGLjWxNA7JOu23p7QLYh61u7YiOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 5 Jan
 2022 16:15:26 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6%5]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 16:15:26 +0000
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
Subject: [PATCH 1/3] git-p4: don't select shell mode using the type of the command argument
Date:   Wed,  5 Jan 2022 16:14:49 +0000
Message-Id: <20220105161451.56378-2-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105161451.56378-1-jholdsworth@nvidia.com>
References: <20220105161451.56378-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P192CA0025.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::38) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b6b42ab-db8b-4eb6-5028-08d9d066959b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4423:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB44230A7CF86A9849E0635F22C84B9@MN2PR12MB4423.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZnBAgFU0cQDI83M/xlNMzLryu7zIs/iL/SA7iIgVCQWuR7Bt7heYqFI9JZdTXXhhWGmR2+4EOxx9x0Nl00xOByXz99st9svFayNmF98Rioh5CHHKnQHFmNY40wAbC8G+fUnOVWB349EE7hwE0ptZfWUS70ZGkribSNQh7+UP3lbSdH5xgmQjvVcRWorkmMx1LggQ8QSATgALd3tERBQQC0058S/b0LDc6ASwK0YOpRteKRVUOhOAUlwenPJwNk9zKT2EqUEKkqxCWBwhqSB119bNAMDny11mHqEyBetaotPPRcN+re/ZzXaUpJ7kKNXEked1dit1wuCQh9U7oD2o8EQjkUXdT+oUFBz9fpQhd8dM7EloK5taTWkXfl5TYEBdpEWRusd/7c5rmPcxB7RV0/aPS0MbIuANzYcenKPaWHB9tLzV/ms1V3eegfJ2AtF1sDBXEe9Sn+jjArYjQhRdI+rvwvt5Ky4S9xoiGayR9gELmjjH5tDzEuAcnhleZnR2qHJ/MsbnfWpj2wqzV2Nhs5aQKIdARKIhxCA9UJIMoULlYszRsRzUywOZKY8TVY1x1a0huPsUhbe9DzeKqYr1tKepFyk1o6rfboIP+xW4j2q7mTscf7j7z5KTUGsP2zMHUewv0k0a6m9Mwczjf14ls+vrasD7HNGiQuMp5wwiFrrhtoCBiwpKF+9ra46AwWgyVVmSxlsxpAS9r4Y6tbGKd3byUuGSJeAu37uRx4y1kJ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(6666004)(30864003)(66556008)(2616005)(1076003)(38100700002)(54906003)(4326008)(316002)(66946007)(110136005)(6486002)(186003)(66476007)(36756003)(38350700002)(7416002)(55236004)(6506007)(86362001)(52116002)(107886003)(8676002)(83380400001)(508600001)(26005)(2906002)(6512007)(8936002)(403724002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LLNbznUf7dhZMOWY+bJS+YaURhTMyMFSXWu9oa5lmXUuNmAfrQonEOq1RgpD?=
 =?us-ascii?Q?UrQr1waEO4CLJ7jEM1HiknBDhM/5ZMykRVhjX9UFGWQBVeBnGl5IX//fBmuA?=
 =?us-ascii?Q?7BNukCANaZwClPzOet9SHke4JIOugqa0qAgRRfEGJM7ukA7hyJZ0SEAUZTgY?=
 =?us-ascii?Q?nNzudD015Um41e/29aCNdPa1D10SJexET2XipJvcnhNM7Kh249skLRCwig8a?=
 =?us-ascii?Q?D4Bgd+m/H+3OvyALDWybT/bVuX6HfMcdTOkOGcAb7+GRF1sYn/2/9raLgKBh?=
 =?us-ascii?Q?Oc91dWrsrFMruCWr7PmHR9WN5ozzdXjJKilk6qv2qD9HIsMhJ/GA0wOUFyv5?=
 =?us-ascii?Q?nZW6ibG1xFpgdPJlSFE2drejk7ZDOJ6OEH3UC+v8ssGWJEO4gFrL57nUuFCy?=
 =?us-ascii?Q?PEvmKGeRie49Iaj4iOm/i3zSWS3RMZPaUUc+3n5+CgG8VarjIE3UuT4hmNcX?=
 =?us-ascii?Q?b/FLVsLwkxV9IgJ1JCA6PJvWhmAftYYYVcPtp1otM3ywXRwpNkvSM9Y+8rTC?=
 =?us-ascii?Q?oLi9NpU+njLe/10vosMdFNuQoe+XrHiC1uGw770MMwmMXQyXD+eb3gwJDes/?=
 =?us-ascii?Q?hYWR2g7KOfmgBz2DeDuoh4FyFOLWWSpktWU657DsKZ6RcQFKZn/3CM1J3gZu?=
 =?us-ascii?Q?4CdgnazQRdiJQbt+DaAvE4BvHjbcLUd0vmdIA3MyZf6H3CVID8SvIElquBfc?=
 =?us-ascii?Q?NMR7rN0E7ZZizWvFU+16hgr/LLrdEf4BVf2qZ9obWkGL3+dSnfxPg9/LK3Gt?=
 =?us-ascii?Q?aXpJ6ApFQtuYaZ6HUz1x7PbyaFGParKkXTGLyj4YFwGGyL21UtQFtXEmcnnf?=
 =?us-ascii?Q?AcMVytAqLD1Keh7ysA09Xd3gQrYBmIYsNGPAqjibYDIjSjF/QMQl99GMR+1C?=
 =?us-ascii?Q?wldxES6IjNPzSgZA9pNcaFI5niHuEiD7sjeukp+DQMeZ7SwdmNCnwFevvgcH?=
 =?us-ascii?Q?M7jjRzfjg5KauGX53D0tjDV5qg76lxScQGlXZ3vqgKwi7e06SCXb7KPQOZFi?=
 =?us-ascii?Q?scG31SBT9HglSWMxP1IDLLGuXVZzCjaZoeTsXx62XR3IlHHuiCAuerXOX43K?=
 =?us-ascii?Q?ka2ZJyXVidddI6XvtHSIRECwN1JySN+ztTNlwa1kgI/A5Da7OPC3jT69yhN1?=
 =?us-ascii?Q?chyrH6raLOtUyB9a0UmNzWgRP19hYa9wP1PZM4R08CWqkv/MNCzzJAFZyvND?=
 =?us-ascii?Q?J1Yjq+Mf5Kyvp8vMyAaDs0H1xE2PYD5/XBIq73tiXmi/vVyf9CqLL98wUhoj?=
 =?us-ascii?Q?vXLqClQ8VZqhlg3l3euc7uslY5wIIRJ0z24/oCkG5RuB2cjK++rykyaXhnVv?=
 =?us-ascii?Q?ag+FCpKUC+UlHBOEXkb//qWiq806K/2E+MPxiBKfrzSbzKQ9xBcwQNWFV4F0?=
 =?us-ascii?Q?y/FSpjoc5pEx63V+z6Vlr+9JDt/DwpHifciMnIyBYOtDKWBgZrsGAh5Fh/aM?=
 =?us-ascii?Q?Ts/ZM2sBIBeRsyeOA1Yu0runN1635EYNAtX9CtToggb3vc2yZyGNW8whCgKA?=
 =?us-ascii?Q?QTo1w+BzbSTaUrXeamiY+aU3+md7HQk77J3ITMotwIsI1Cwn2kqtheASssXq?=
 =?us-ascii?Q?3Yy1DIwwGzabhljMPms4812Gzyd2ePyVANRF2cmdOpJo8RmWtP8pnXtflgli?=
 =?us-ascii?Q?Vr/v04pb2whWUJvMbTQsyNY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6b42ab-db8b-4eb6-5028-08d9d066959b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 16:15:26.6423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCrY85IYBrBAjJ+6OjTUl+QXzr91qxvnsEqwTQEZn4XDTqRaIuAUv3+boB6ZBUYdwkHXpKVW/cxs3ydRp8cUWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, the script would invoke subprocess functions setting the
shell argument True if the command argument was a string, setting it
False otherwise.

This patch replaces this implicit type-driven behaviour with explicit
shell arguments specified by the caller.

The apparent motive for the implict behaviour is that the subprocess
functions do not divide command strings into args. Invoking
subprocess.call("echo hello") will attempt to execute a program by the
name "echo hello". With subprocess.call("echo hello", shell=True), sh
-c "echo hello" will be executed instead, which will cause the command
and args to be divided by spaces.

Eventually, all usage of shell=True, that is not necessary for some
purpose beyond parsing command strings, should be removed. For now,
this patch makes the usage of shells explicit.
---
 git-p4.py | 126 +++++++++++++++++++++++++++---------------------------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index cb37545455..6a6aa4e928 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -288,12 +288,11 @@ def run_hook_command(cmd, param):
     return subprocess.call(cli, shell=use_shell)
 
 
-def write_pipe(c, stdin):
+def write_pipe(c, stdin, *k, **kw):
     if verbose:
         sys.stderr.write('Writing pipe: %s\n' % str(c))
 
-    expand = not isinstance(c, list)
-    p = subprocess.Popen(c, stdin=subprocess.PIPE, shell=expand)
+    p = subprocess.Popen(c, stdin=subprocess.PIPE, *k, **kw)
     pipe = p.stdin
     val = pipe.write(stdin)
     pipe.close()
@@ -302,13 +301,13 @@ def write_pipe(c, stdin):
 
     return val
 
-def p4_write_pipe(c, stdin):
+def p4_write_pipe(c, stdin, *k, **kw):
     real_cmd = p4_build_cmd(c)
     if bytes is not str and isinstance(stdin, str):
         stdin = encode_text_stream(stdin)
-    return write_pipe(real_cmd, stdin)
+    return write_pipe(real_cmd, stdin, *k, **kw)
 
-def read_pipe_full(c):
+def read_pipe_full(c, *k, **kw):
     """ Read output from  command. Returns a tuple
         of the return status, stdout text and stderr
         text.
@@ -316,19 +315,19 @@ def read_pipe_full(c):
     if verbose:
         sys.stderr.write('Reading pipe: %s\n' % str(c))
 
-    expand = not isinstance(c, list)
-    p = subprocess.Popen(c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=expand)
+    p = subprocess.Popen(
+        c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, *k, **kw)
     (out, err) = p.communicate()
     return (p.returncode, out, decode_text_stream(err))
 
-def read_pipe(c, ignore_error=False, raw=False):
+def read_pipe(c, ignore_error=False, raw=False, *k, **kw):
     """ Read output from  command. Returns the output text on
         success. On failure, terminates execution, unless
         ignore_error is True, when it returns an empty string.
 
         If raw is True, do not attempt to decode output text.
     """
-    (retcode, out, err) = read_pipe_full(c)
+    (retcode, out, err) = read_pipe_full(c, *k, **kw)
     if retcode != 0:
         if ignore_error:
             out = ""
@@ -338,26 +337,25 @@ def read_pipe(c, ignore_error=False, raw=False):
         out = decode_text_stream(out)
     return out
 
-def read_pipe_text(c):
+def read_pipe_text(c, *k, **kw):
     """ Read output from a command with trailing whitespace stripped.
         On error, returns None.
     """
-    (retcode, out, err) = read_pipe_full(c)
+    (retcode, out, err) = read_pipe_full(c, *k, **kw)
     if retcode != 0:
         return None
     else:
         return decode_text_stream(out).rstrip()
 
-def p4_read_pipe(c, ignore_error=False, raw=False):
+def p4_read_pipe(c, ignore_error=False, raw=False, *k, **kw):
     real_cmd = p4_build_cmd(c)
-    return read_pipe(real_cmd, ignore_error, raw=raw)
+    return read_pipe(real_cmd, ignore_error, raw=raw, *k, **kw)
 
-def read_pipe_lines(c, raw=False):
+def read_pipe_lines(c, raw=False, *k, **kw):
     if verbose:
         sys.stderr.write('Reading pipe: %s\n' % str(c))
 
-    expand = not isinstance(c, list)
-    p = subprocess.Popen(c, stdout=subprocess.PIPE, shell=expand)
+    p = subprocess.Popen(c, stdout=subprocess.PIPE, *k, **kw)
     pipe = p.stdout
     lines = pipe.readlines()
     if not raw:
@@ -366,10 +364,10 @@ def read_pipe_lines(c, raw=False):
         die('Command failed: %s' % str(c))
     return lines
 
-def p4_read_pipe_lines(c):
+def p4_read_pipe_lines(c, *k, **kw):
     """Specifically invoke p4 on the command supplied. """
     real_cmd = p4_build_cmd(c)
-    return read_pipe_lines(real_cmd)
+    return read_pipe_lines(real_cmd, *k, **kw)
 
 def p4_has_command(cmd):
     """Ask p4 for help on this command.  If it returns an error, the
@@ -400,21 +398,19 @@ def p4_has_move_command():
     # assume it failed because @... was invalid changelist
     return True
 
-def system(cmd, ignore_error=False):
-    expand = not isinstance(cmd, list)
+def system(cmd, ignore_error=False, *k, **kw):
     if verbose:
         sys.stderr.write("executing %s\n" % str(cmd))
-    retcode = subprocess.call(cmd, shell=expand)
+    retcode = subprocess.call(cmd, *k, **kw)
     if retcode and not ignore_error:
         raise CalledProcessError(retcode, cmd)
 
     return retcode
 
-def p4_system(cmd):
+def p4_system(cmd, *k, **kw):
     """Specifically invoke p4 as the system command. """
     real_cmd = p4_build_cmd(cmd)
-    expand = not isinstance(real_cmd, list)
-    retcode = subprocess.call(real_cmd, shell=expand)
+    retcode = subprocess.call(real_cmd, *k, **kw)
     if retcode:
         raise CalledProcessError(retcode, real_cmd)
 
@@ -735,14 +731,12 @@ def isModeExecChanged(src_mode, dst_mode):
     return isModeExec(src_mode) != isModeExec(dst_mode)
 
 def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
-        errors_as_exceptions=False):
+        errors_as_exceptions=False, *k, **kw):
 
     if not isinstance(cmd, list):
         cmd = "-G " + cmd
-        expand = True
     else:
         cmd = ["-G"] + cmd
-        expand = False
 
     cmd = p4_build_cmd(cmd)
     if verbose:
@@ -763,10 +757,8 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
         stdin_file.flush()
         stdin_file.seek(0)
 
-    p4 = subprocess.Popen(cmd,
-                          shell=expand,
-                          stdin=stdin_file,
-                          stdout=subprocess.PIPE)
+    p4 = subprocess.Popen(
+        cmd, stdin=stdin_file, stdout=subprocess.PIPE, *k, **kw)
 
     result = []
     try:
@@ -819,8 +811,8 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
 
     return result
 
-def p4Cmd(cmd):
-    list = p4CmdList(cmd)
+def p4Cmd(cmd, *k, **kw):
+    list = p4CmdList(cmd, *k, **kw)
     result = {}
     for entry in list:
         result.update(entry)
@@ -869,7 +861,7 @@ def isValidGitDir(path):
     return git_dir(path) != None
 
 def parseRevision(ref):
-    return read_pipe("git rev-parse %s" % ref).strip()
+    return read_pipe("git rev-parse %s" % ref, shell=True).strip()
 
 def branchExists(ref):
     rev = read_pipe(["git", "rev-parse", "-q", "--verify", ref],
@@ -981,7 +973,7 @@ def p4BranchesInGit(branchesAreInRemotes=True):
     else:
         cmdline += "--branches"
 
-    for line in read_pipe_lines(cmdline):
+    for line in read_pipe_lines(cmdline, shell=True):
         line = line.strip()
 
         # only import to p4/
@@ -1044,7 +1036,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
 
     originPrefix = "origin/p4/"
 
-    for line in read_pipe_lines("git rev-parse --symbolic --remotes"):
+    for line in read_pipe_lines("git rev-parse --symbolic --remotes", shell=True):
         line = line.strip()
         if (not line.startswith(originPrefix)) or line.endswith("HEAD"):
             continue
@@ -1082,7 +1074,8 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
                               remoteHead, ','.join(settings['depot-paths'])))
 
         if update:
-            system("git update-ref %s %s" % (remoteHead, originHead))
+            system("git update-ref %s %s" % (remoteHead, originHead),
+                shell=True)
 
 def originP4BranchesExist():
         return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
@@ -1196,7 +1189,7 @@ def getClientSpec():
     """Look at the p4 client spec, create a View() object that contains
        all the mappings, and return it."""
 
-    specList = p4CmdList("client -o")
+    specList = p4CmdList("client -o", shell=True)
     if len(specList) != 1:
         die('Output from "client -o" is %d lines, expecting 1' %
             len(specList))
@@ -1225,7 +1218,7 @@ def getClientSpec():
 def getClientRoot():
     """Grab the client directory."""
 
-    output = p4CmdList("client -o")
+    output = p4CmdList("client -o", shell=True)
     if len(output) != 1:
         die('Output from "client -o" is %d lines, expecting 1' % len(output))
 
@@ -1480,7 +1473,7 @@ def p4UserId(self):
         if self.myP4UserId:
             return self.myP4UserId
 
-        results = p4CmdList("user -o")
+        results = p4CmdList("user -o", shell=True)
         for r in results:
             if 'User' in r:
                 self.myP4UserId = r['User']
@@ -1505,7 +1498,7 @@ def getUserMapFromPerforceServer(self):
         self.users = {}
         self.emails = {}
 
-        for output in p4CmdList("users"):
+        for output in p4CmdList("users", shell=True):
             if "User" not in output:
                 continue
             self.users[output["User"]] = output["FullName"] + " <" + output["Email"] + ">"
@@ -1629,7 +1622,7 @@ def __init__(self):
             die("Large file system not supported for git-p4 submit command. Please remove it from config.")
 
     def check(self):
-        if len(p4CmdList("opened ...")) > 0:
+        if len(p4CmdList("opened ...", shell=True)) > 0:
             die("You have files opened with perforce! Close them before starting the sync.")
 
     def separate_jobs_from_description(self, message):
@@ -1733,7 +1726,7 @@ def lastP4Changelist(self):
         # then gets used to patch up the username in the change. If the same
         # client spec is being used by multiple processes then this might go
         # wrong.
-        results = p4CmdList("client -o")        # find the current client
+        results = p4CmdList("client -o", shell=True)    # find the current client
         client = None
         for r in results:
             if 'Client' in r:
@@ -1749,7 +1742,7 @@ def lastP4Changelist(self):
 
     def modifyChangelistUser(self, changelist, newUser):
         # fixup the user field of a changelist after it has been submitted.
-        changes = p4CmdList("change -o %s" % changelist)
+        changes = p4CmdList("change -o %s" % changelist, shell=True)
         if len(changes) != 1:
             die("Bad output from p4 change modifying %s to user %s" %
                 (changelist, newUser))
@@ -1760,7 +1753,7 @@ def modifyChangelistUser(self, changelist, newUser):
         # p4 does not understand format version 3 and above
         input = marshal.dumps(c, 2)
 
-        result = p4CmdList("change -f -i", stdin=input)
+        result = p4CmdList("change -f -i", stdin=input, shell=True)
         for r in result:
             if 'code' in r:
                 if r['code'] == 'error':
@@ -1866,7 +1859,7 @@ def edit_template(self, template_file):
         if "P4EDITOR" in os.environ and (os.environ.get("P4EDITOR") != ""):
             editor = os.environ.get("P4EDITOR")
         else:
-            editor = read_pipe("git var GIT_EDITOR").strip()
+            editor = read_pipe("git var GIT_EDITOR", shell=True).strip()
         system(["sh", "-c", ('%s "$@"' % editor), editor, template_file])
 
         # If the file was not saved, prompt to see if this patch should
@@ -1924,7 +1917,9 @@ def applyCommit(self, id):
 
         (p4User, gitEmail) = self.p4UserForCommit(id)
 
-        diff = read_pipe_lines("git diff-tree -r %s \"%s^\" \"%s\"" % (self.diffOpts, id, id))
+        diff = read_pipe_lines(
+            "git diff-tree -r %s \"%s^\" \"%s\"" % (self.diffOpts, id, id),
+            shell=True)
         filesToAdd = set()
         filesToChangeType = set()
         filesToDelete = set()
@@ -2060,7 +2055,7 @@ def applyCommit(self, id):
         #
         # Apply the patch for real, and do add/delete/+x handling.
         #
-        system(applyPatchCmd)
+        system(applyPatchCmd, shell=True)
 
         for f in filesToChangeType:
             p4_edit(f, "-t", "auto")
@@ -3386,7 +3381,7 @@ def getBranchMapping(self):
         else:
             command = "branches"
 
-        for info in p4CmdList(command):
+        for info in p4CmdList(command, shell=True):
             details = p4Cmd(["branch", "-o", info["branch"]])
             viewIdx = 0
             while "View%s" % viewIdx in details:
@@ -3477,7 +3472,9 @@ def gitCommitByP4Change(self, ref, change):
         while True:
             if self.verbose:
                 print("trying: earliest %s latest %s" % (earliestCommit, latestCommit))
-            next = read_pipe("git rev-list --bisect %s %s" % (latestCommit, earliestCommit)).strip()
+            next = read_pipe(
+                "git rev-list --bisect %s %s" % (latestCommit, earliestCommit),
+                shell=True).strip()
             if len(next) == 0:
                 if self.verbose:
                     print("argh")
@@ -3633,7 +3630,7 @@ def sync_origin_only(self):
             if self.hasOrigin:
                 if not self.silent:
                     print('Syncing with origin first, using "git fetch origin"')
-                system("git fetch origin")
+                system("git fetch origin", shell=True)
 
     def importHeadRevision(self, revision):
         print("Doing initial import of %s from revision %s into %s" % (' '.join(self.depotPaths), revision, self.branch))
@@ -3800,8 +3797,8 @@ def run(self, args):
         if len(self.branch) == 0:
             self.branch = self.refPrefix + "master"
             if gitBranchExists("refs/heads/p4") and self.importIntoRemotes:
-                system("git update-ref %s refs/heads/p4" % self.branch)
-                system("git branch -D p4")
+                system("git update-ref %s refs/heads/p4" % self.branch, shell=True)
+                system("git branch -D p4", shell=True)
 
         # accept either the command-line option, or the configuration variable
         if self.useClientSpec:
@@ -4004,7 +4001,7 @@ def run(self, args):
         # Cleanup temporary branches created during import
         if self.tempBranches != []:
             for branch in self.tempBranches:
-                read_pipe("git update-ref -d %s" % branch)
+                read_pipe("git update-ref -d %s" % branch, shell=True)
             os.rmdir(os.path.join(os.environ.get("GIT_DIR", ".git"), self.tempBranchLocation))
 
         # Create a symbolic ref p4/HEAD pointing to p4/<branch> to allow
@@ -4036,7 +4033,7 @@ def run(self, args):
     def rebase(self):
         if os.system("git update-index --refresh") != 0:
             die("Some files in your working directory are modified and different than what is in your index. You can use git update-index <filename> to bring the index up to date or stash away all your changes with git stash.");
-        if len(read_pipe("git diff-index HEAD --")) > 0:
+        if len(read_pipe("git diff-index HEAD --", shell=True)) > 0:
             die("You have uncommitted changes. Please commit them before rebasing or stash them away with git stash.");
 
         [upstream, settings] = findUpstreamBranchPoint()
@@ -4047,9 +4044,10 @@ def rebase(self):
         upstream = re.sub("~[0-9]+$", "", upstream)
 
         print("Rebasing the current branch onto %s" % upstream)
-        oldHead = read_pipe("git rev-parse HEAD").strip()
-        system("git rebase %s" % upstream)
-        system("git diff-tree --stat --summary -M %s HEAD --" % oldHead)
+        oldHead = read_pipe("git rev-parse HEAD", shell=True).strip()
+        system("git rebase %s" % upstream, shell=True)
+        system("git diff-tree --stat --summary -M %s HEAD --" % oldHead,
+            shell=True)
         return True
 
 class P4Clone(P4Sync):
@@ -4126,7 +4124,7 @@ def run(self, args):
 
         # auto-set this variable if invoked with --use-client-spec
         if self.useClientSpec_from_options:
-            system("git config --bool git-p4.useclientspec true")
+            system("git config --bool git-p4.useclientspec true", shell=True)
 
         return True
 
@@ -4260,7 +4258,7 @@ def run(self, args):
         cmdline = "git rev-parse --symbolic "
         cmdline += " --remotes"
 
-        for line in read_pipe_lines(cmdline):
+        for line in read_pipe_lines(cmdline, shell=True):
             line = line.strip()
 
             if not line.startswith('p4/') or line == "p4/HEAD":
@@ -4343,9 +4341,11 @@ def main():
             cmd.gitdir = os.path.abspath(".git")
             if not isValidGitDir(cmd.gitdir):
                 # "rev-parse --git-dir" without arguments will try $PWD/.git
-                cmd.gitdir = read_pipe("git rev-parse --git-dir").strip()
+                cmd.gitdir = read_pipe(
+                    "git rev-parse --git-dir", shell=True).strip()
                 if os.path.exists(cmd.gitdir):
-                    cdup = read_pipe("git rev-parse --show-cdup").strip()
+                    cdup = read_pipe(
+                        "git rev-parse --show-cdup", shell=True).strip()
                     if len(cdup) > 0:
                         chdir(cdup);
 
-- 
2.34.1

