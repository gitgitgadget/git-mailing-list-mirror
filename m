Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE199C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 21:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244329AbiAFVlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 16:41:04 -0500
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com ([40.107.243.43]:57313
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244184AbiAFVlB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 16:41:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUvDVz7Or8XNA+wa4GcluGOyD/vX/IHiRIDAptdUFa5Zfc+9LKpwJSZwkY2sXOlcSOVVaKqFksLkG4pUlDpiWw315B38GztMIzCj26Fufgyza4AYARdydDs05aVQLwZK9wAKTU8BPNpVN2fMQne9VtFqm/Jd169utSwqy5nfk1aJVeI/VXjdWDV5AS5ylBBOgrkMDOS61e5052cC8iN5dbHsWG7s85gT9ndyIcusAW4XW+jjD3mvRQQ46lfqN7CbbZJylcJW7wbAa0vDO0RtR0kSMtVY4AbS658uOaB18qN+rnFi+fB2sFl5rbkOeKBXR5KFU8bM+gl1twP7H6C+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4X0DIDtFaYJ9pd3LUEpT2iu/aZPnfb3F7zKXUJzzZ4=;
 b=Q5SsOjQCoLwYNvq3EbUypJiBs02JeUxh0e9cFNDYDj469cKsRiJ7m2mt546xYEXXE9ILo1GiqbxbshVB0PY7TSgFlgbIusisTqy6/CJVw5Y5ZVhR2sfhTM+Do+DqLSNwMCR3F5hJSuQaOMEEa4H6pwfgJVFkd/xQw19Ea/TirJaFdQYk5FHS2D4aJXPSIXPcEADaT09yqzTrP0DKjJdRcbIBL8G4F8wbscmUiH4I+PFruvticjJBKBHFAnRE3Mg94wmBUBaf9tzPQTbVPHCW3p4xRtegKZ+S+ooDmcNUfmiEdAXfGMHR7PQU5AkP+oMTMuA+JkoiJvmLt8IWJ0+2eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4X0DIDtFaYJ9pd3LUEpT2iu/aZPnfb3F7zKXUJzzZ4=;
 b=XSfs6vHYuCFs+zrYLYqfgbXtOpU+LTfXvqWCXOb7rwsGBWLi076SFFYqWCFHah9Aoa8plpBTDCXksyqr659Um8guuGs1kNY9N07nD1GikKI1s0G5BBtsp3BRDp99abWIxmc79ty8qfG/Xi93bWGGxvtCW7/Nlxd3Tbmlcpl68ikYgvvBYLup4ZW/bn6Nugj5s0Ah3f1Rq3OeEInL3Al7EbZGVV6O3LeMaHgA8NzHwjoTG0qn75vIJGBkL0uw74teYDDMRmxoCSgaX2xhgLU+xpPBUB+NPn2aIPsFd8vLX8nuyD89cfHTJtIm9NGujupRllVgDS7LvqJRx3nRQAmZ3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB3854.namprd12.prod.outlook.com (2603:10b6:208:16a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Thu, 6 Jan
 2022 21:41:00 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 21:41:00 +0000
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
Subject: [PATCH v2 1/3] git-p4: don't select shell mode using the type of the command argument
Date:   Thu,  6 Jan 2022 21:40:33 +0000
Message-Id: <20220106214035.90725-2-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220106214035.90725-1-jholdsworth@nvidia.com>
References: <20220106214035.90725-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::35) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23f32419-4ba1-4d9a-b554-08d9d15d3ad3
X-MS-TrafficTypeDiagnostic: MN2PR12MB3854:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB38545C81EBB0426171ECA10FC84C9@MN2PR12MB3854.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vxGWyCa+ORpI5uKhULX7fXlOdjKN8BuXQS+9uProBgf8pWVqxQa7NrCxl8JHoOu6LsuM8oISzz96bihX0hlEAdt6mU4XZ8mhsjRCI/WVQkGgA1wGIPxgNUe2SCwWrsGPFHjbZNs6qhre4BbBt5KM7pgMT7vaOSs+F1+aMTR++NNgjuikmjT3TS15ILYf2MPst9PX/o4cWC/akXc/AV+LYiB0FqjA3/3NKX2D8rMuSHOOIGrnQt31KMi1gNmB0ZIErMYF1biwywN1y2CshKfrv1OHxhssFWDygYxxq1bngnwyH1uV+6bdyH8bizZIrd3dvkh3vyA0APONNTB77kmLbCPGd2EEo6hutnMkH/yjbQhp3C5pAjunKWgaRLUgA4XH17HqZMTL9w1a4qwMOLO3mEog2N0EZ45AyQ2SUsLZIJBsvI2BRiop2ZjNWKX0jg8iXHSqWzpOullHLcyVE5rASGdgpp2wlnaFOQuRt+0jYdGsSAzP9hSje1O9/qLiI5OWvHQRkn9H+IRsro6GTpH2uxzwymtPB62OrjUTTPp72NkOk+mM3D1jYBG4+kSBLEnwb466PKhlLFaxF/Yi5k8KAZj1CJTD5gX7+pdcfS9POMc6xw8tqQjjsKu+1NnKQS7Q9KHdzVstlD954JKeuDzNfw/SRY4yZOH55bZOL5P+vSMh8XyrAZe9EkZ0TsZ7IhI29llU15KEPWIONMp0bMAwH+GDwrqGU72SxmiEu6a1htM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(508600001)(26005)(66556008)(66476007)(83380400001)(186003)(4326008)(38350700002)(8936002)(66946007)(8676002)(36756003)(2616005)(7416002)(54906003)(6512007)(6666004)(107886003)(52116002)(2906002)(30864003)(6486002)(316002)(5660300002)(6506007)(110136005)(1076003)(55236004)(86362001)(403724002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JGYiL5aJg02NJIh6t665hGI2t+pgvfwlJTepUUgdKHxZHwQu9MvlMcF+uYo0?=
 =?us-ascii?Q?t5LgVnG5gSm8gDdMLfSXAaFs8/FKiGpxwfSqie4l05tTzVukmJaLFuX+CGHw?=
 =?us-ascii?Q?Eir5VbiSn1GHXfCVXavpUXFWh7sg23ZNMO0LfSuupx6f+4+lTTuEL1/pNFby?=
 =?us-ascii?Q?vzvZKvX7qF8umZAvqf1HbyFvz45ZpJvP/BKv7/dPP1PQb1sH0reZxGztgtsG?=
 =?us-ascii?Q?Rg24+IpgrVYZ5bpqROK/wnLLOgN4Qff7acN5mTvdz/2BDMpvB0WGFFX8q/xo?=
 =?us-ascii?Q?Db2MeipNQOk4+6UEnSRnnmWMkY85n3eCM66oZsMOF73CJjBBofOBVSFGGgZQ?=
 =?us-ascii?Q?PrBuLPk/NbxjAdk07ApAhI3mPsJb9FBcEOsXj/AlOgvGHNfPBRoXFTJiSy/i?=
 =?us-ascii?Q?qFs81szhhhRU1WYjmzNSQcXXqAcfWqga7+Z+gKNfdSc4oU9xkZQ22Ad6V5c2?=
 =?us-ascii?Q?bEGbQzizBH55jrgnZ1GrapNWbzC68tbt5xOoJG8fXsWw19PTjHkBpFN0jMoY?=
 =?us-ascii?Q?uLsYaaAsTjsdc6R+8aQC9jiZlax+20tJReW5oiEF9W9o7067HLklM91nnc9L?=
 =?us-ascii?Q?y/cg8iqBMlo24gBhEroGjwHZG6/OM1Bkc8oR7UsjvsqHKjZi3zgZGPYet8Ja?=
 =?us-ascii?Q?LYTuBqKMotafpaiMv251o12fBRN8Y+gxq8fExR6+6B9w0G75tKsTekJcdCmA?=
 =?us-ascii?Q?YkND1nZ5git2CbETphfsjkipLUfSnmUtvjWO/S0E/Dlqs+rP//+d2kzHgSi0?=
 =?us-ascii?Q?/5m8zFEb7d3eEJovhhWRg3NH06wgZkVeYaoyXDPqXHyi+oDcwfBcVdvcnrQo?=
 =?us-ascii?Q?9PafVzAJSFerhPFKBK2OSd2J/aoSaOO+OpYLR5qk4b06/IrML9Bg8c5XG1iP?=
 =?us-ascii?Q?N9m6KsQPwJfMRKfpkxSYL5BSFJJQxFuOdRPUc1akYsuJxjz1WnXVmEg1kJpc?=
 =?us-ascii?Q?MBQvvK+oH032d5ff5HThm5gOS5hrGKFhzLYnIvNbN1a0NZrROzW/WBbfb/2s?=
 =?us-ascii?Q?Rsabs7V9HQl4ec3rSfqyuYUHK6Kcn6fhRNJ65oN/AaKAso1AixwobMLJjrQg?=
 =?us-ascii?Q?cgw2pZr0lHkFFOdpKnO6yddWSsqnb+vkfvCLVRG2r5nBRK6LDPZQYKdfao+S?=
 =?us-ascii?Q?QsMPckOx3ngFRUNVP8HBsuol9SeOPJzx27VQQWdNs8FGOtVg2TfbliD3bl31?=
 =?us-ascii?Q?UjcJhaK2cp3hD3RN1RDeIKjLEkzoFFpk7XWcpdoTjQLMwUPEEgHjeUo9HU/H?=
 =?us-ascii?Q?coAa939HSBXodVvYJty3n6FIk8gbM5bkW/R/U978UmE/pEAexmrQHG0S3zzO?=
 =?us-ascii?Q?mZYV1RbOgsB808jkRppbmHawX+Z/owjEBkqLDuWVH9avgD2cd6cb61KxhkI4?=
 =?us-ascii?Q?R70sXEbPFUuU6K6dcZQzXQhqDDcQluo6rGZaN2nF5r82xCvGP2vfecQockeu?=
 =?us-ascii?Q?N0nKLrroZZcjF3fRnu/Jq2NvgfYDSCosDzhS6I/RsTarIGiY6oSeD1nvDmeN?=
 =?us-ascii?Q?LDdCB1oG8RLBhGLcKuuL+gJlpK6Rn/BoidJ1vjxJE8mAn8BBvzOY0L0zvmXB?=
 =?us-ascii?Q?xICgyp24iVQZ3BIE/21crFf/kzC1SS69iezYRDxtRlZOvL9Q3ECvNmqlAmP4?=
 =?us-ascii?Q?8J1Q7hVFMUOwlIZ5TRE9lZs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f32419-4ba1-4d9a-b554-08d9d15d3ad3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 21:41:00.1096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJhVXWKoIntRynyFCnL45WmtSlYn3Mqg13g1XTshyoa1ClOkqFghnCcI7m9rvnqHTRvdXqGaCURW0AGZpvMflA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3854
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

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
This version adds a missing signoff.

 git-p4.py | 126 +++++++++++++++++++++++++++---------------------------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 986595bef0..7ec90388b6 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -276,12 +276,11 @@ def run_hook_command(cmd, param):
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
@@ -290,13 +289,13 @@ def write_pipe(c, stdin):
 
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
@@ -304,19 +303,19 @@ def read_pipe_full(c):
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
@@ -326,26 +325,25 @@ def read_pipe(c, ignore_error=False, raw=False):
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
@@ -354,10 +352,10 @@ def read_pipe_lines(c, raw=False):
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
@@ -388,21 +386,19 @@ def p4_has_move_command():
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
 
@@ -723,14 +719,12 @@ def isModeExecChanged(src_mode, dst_mode):
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
@@ -751,10 +745,8 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
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
@@ -807,8 +799,8 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
 
     return result
 
-def p4Cmd(cmd):
-    list = p4CmdList(cmd)
+def p4Cmd(cmd, *k, **kw):
+    list = p4CmdList(cmd, *k, **kw)
     result = {}
     for entry in list:
         result.update(entry)
@@ -857,7 +849,7 @@ def isValidGitDir(path):
     return git_dir(path) != None
 
 def parseRevision(ref):
-    return read_pipe("git rev-parse %s" % ref).strip()
+    return read_pipe("git rev-parse %s" % ref, shell=True).strip()
 
 def branchExists(ref):
     rev = read_pipe(["git", "rev-parse", "-q", "--verify", ref],
@@ -969,7 +961,7 @@ def p4BranchesInGit(branchesAreInRemotes=True):
     else:
         cmdline += "--branches"
 
-    for line in read_pipe_lines(cmdline):
+    for line in read_pipe_lines(cmdline, shell=True):
         line = line.strip()
 
         # only import to p4/
@@ -1032,7 +1024,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
 
     originPrefix = "origin/p4/"
 
-    for line in read_pipe_lines("git rev-parse --symbolic --remotes"):
+    for line in read_pipe_lines("git rev-parse --symbolic --remotes", shell=True):
         line = line.strip()
         if (not line.startswith(originPrefix)) or line.endswith("HEAD"):
             continue
@@ -1070,7 +1062,8 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
                               remoteHead, ','.join(settings['depot-paths'])))
 
         if update:
-            system("git update-ref %s %s" % (remoteHead, originHead))
+            system("git update-ref %s %s" % (remoteHead, originHead),
+                shell=True)
 
 def originP4BranchesExist():
         return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
@@ -1184,7 +1177,7 @@ def getClientSpec():
     """Look at the p4 client spec, create a View() object that contains
        all the mappings, and return it."""
 
-    specList = p4CmdList("client -o")
+    specList = p4CmdList("client -o", shell=True)
     if len(specList) != 1:
         die('Output from "client -o" is %d lines, expecting 1' %
             len(specList))
@@ -1213,7 +1206,7 @@ def getClientSpec():
 def getClientRoot():
     """Grab the client directory."""
 
-    output = p4CmdList("client -o")
+    output = p4CmdList("client -o", shell=True)
     if len(output) != 1:
         die('Output from "client -o" is %d lines, expecting 1' % len(output))
 
@@ -1468,7 +1461,7 @@ def p4UserId(self):
         if self.myP4UserId:
             return self.myP4UserId
 
-        results = p4CmdList("user -o")
+        results = p4CmdList("user -o", shell=True)
         for r in results:
             if 'User' in r:
                 self.myP4UserId = r['User']
@@ -1493,7 +1486,7 @@ def getUserMapFromPerforceServer(self):
         self.users = {}
         self.emails = {}
 
-        for output in p4CmdList("users"):
+        for output in p4CmdList("users", shell=True):
             if "User" not in output:
                 continue
             self.users[output["User"]] = output["FullName"] + " <" + output["Email"] + ">"
@@ -1691,7 +1684,7 @@ def __init__(self):
             die("Large file system not supported for git-p4 submit command. Please remove it from config.")
 
     def check(self):
-        if len(p4CmdList("opened ...")) > 0:
+        if len(p4CmdList("opened ...", shell=True)) > 0:
             die("You have files opened with perforce! Close them before starting the sync.")
 
     def separate_jobs_from_description(self, message):
@@ -1795,7 +1788,7 @@ def lastP4Changelist(self):
         # then gets used to patch up the username in the change. If the same
         # client spec is being used by multiple processes then this might go
         # wrong.
-        results = p4CmdList("client -o")        # find the current client
+        results = p4CmdList("client -o", shell=True)    # find the current client
         client = None
         for r in results:
             if 'Client' in r:
@@ -1811,7 +1804,7 @@ def lastP4Changelist(self):
 
     def modifyChangelistUser(self, changelist, newUser):
         # fixup the user field of a changelist after it has been submitted.
-        changes = p4CmdList("change -o %s" % changelist)
+        changes = p4CmdList("change -o %s" % changelist, shell=True)
         if len(changes) != 1:
             die("Bad output from p4 change modifying %s to user %s" %
                 (changelist, newUser))
@@ -1822,7 +1815,7 @@ def modifyChangelistUser(self, changelist, newUser):
         # p4 does not understand format version 3 and above
         input = marshal.dumps(c, 2)
 
-        result = p4CmdList("change -f -i", stdin=input)
+        result = p4CmdList("change -f -i", stdin=input, shell=True)
         for r in result:
             if 'code' in r:
                 if r['code'] == 'error':
@@ -1928,7 +1921,7 @@ def edit_template(self, template_file):
         if "P4EDITOR" in os.environ and (os.environ.get("P4EDITOR") != ""):
             editor = os.environ.get("P4EDITOR")
         else:
-            editor = read_pipe("git var GIT_EDITOR").strip()
+            editor = read_pipe("git var GIT_EDITOR", shell=True).strip()
         system(["sh", "-c", ('%s "$@"' % editor), editor, template_file])
 
         # If the file was not saved, prompt to see if this patch should
@@ -1986,7 +1979,9 @@ def applyCommit(self, id):
 
         (p4User, gitEmail) = self.p4UserForCommit(id)
 
-        diff = read_pipe_lines("git diff-tree -r %s \"%s^\" \"%s\"" % (self.diffOpts, id, id))
+        diff = read_pipe_lines(
+            "git diff-tree -r %s \"%s^\" \"%s\"" % (self.diffOpts, id, id),
+            shell=True)
         filesToAdd = set()
         filesToChangeType = set()
         filesToDelete = set()
@@ -2122,7 +2117,7 @@ def applyCommit(self, id):
         #
         # Apply the patch for real, and do add/delete/+x handling.
         #
-        system(applyPatchCmd)
+        system(applyPatchCmd, shell=True)
 
         for f in filesToChangeType:
             p4_edit(f, "-t", "auto")
@@ -3446,7 +3441,7 @@ def getBranchMapping(self):
         else:
             command = "branches"
 
-        for info in p4CmdList(command):
+        for info in p4CmdList(command, shell=True):
             details = p4Cmd(["branch", "-o", info["branch"]])
             viewIdx = 0
             while "View%s" % viewIdx in details:
@@ -3537,7 +3532,9 @@ def gitCommitByP4Change(self, ref, change):
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
@@ -3692,7 +3689,7 @@ def sync_origin_only(self):
             if self.hasOrigin:
                 if not self.silent:
                     print('Syncing with origin first, using "git fetch origin"')
-                system("git fetch origin")
+                system("git fetch origin", shell=True)
 
     def importHeadRevision(self, revision):
         print("Doing initial import of %s from revision %s into %s" % (' '.join(self.depotPaths), revision, self.branch))
@@ -3859,8 +3856,8 @@ def run(self, args):
         if len(self.branch) == 0:
             self.branch = self.refPrefix + "master"
             if gitBranchExists("refs/heads/p4") and self.importIntoRemotes:
-                system("git update-ref %s refs/heads/p4" % self.branch)
-                system("git branch -D p4")
+                system("git update-ref %s refs/heads/p4" % self.branch, shell=True)
+                system("git branch -D p4", shell=True)
 
         # accept either the command-line option, or the configuration variable
         if self.useClientSpec:
@@ -4063,7 +4060,7 @@ def run(self, args):
         # Cleanup temporary branches created during import
         if self.tempBranches != []:
             for branch in self.tempBranches:
-                read_pipe("git update-ref -d %s" % branch)
+                read_pipe("git update-ref -d %s" % branch, shell=True)
             os.rmdir(os.path.join(os.environ.get("GIT_DIR", ".git"), self.tempBranchLocation))
 
         # Create a symbolic ref p4/HEAD pointing to p4/<branch> to allow
@@ -4095,7 +4092,7 @@ def run(self, args):
     def rebase(self):
         if os.system("git update-index --refresh") != 0:
             die("Some files in your working directory are modified and different than what is in your index. You can use git update-index <filename> to bring the index up to date or stash away all your changes with git stash.");
-        if len(read_pipe("git diff-index HEAD --")) > 0:
+        if len(read_pipe("git diff-index HEAD --", shell=True)) > 0:
             die("You have uncommitted changes. Please commit them before rebasing or stash them away with git stash.");
 
         [upstream, settings] = findUpstreamBranchPoint()
@@ -4106,9 +4103,10 @@ def rebase(self):
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
@@ -4185,7 +4183,7 @@ def run(self, args):
 
         # auto-set this variable if invoked with --use-client-spec
         if self.useClientSpec_from_options:
-            system("git config --bool git-p4.useclientspec true")
+            system("git config --bool git-p4.useclientspec true", shell=True)
 
         return True
 
@@ -4319,7 +4317,7 @@ def run(self, args):
         cmdline = "git rev-parse --symbolic "
         cmdline += " --remotes"
 
-        for line in read_pipe_lines(cmdline):
+        for line in read_pipe_lines(cmdline, shell=True):
             line = line.strip()
 
             if not line.startswith('p4/') or line == "p4/HEAD":
@@ -4404,9 +4402,11 @@ def main():
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

