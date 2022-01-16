Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724E9C433F5
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 16:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbiAPQHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:07:22 -0500
Received: from mail-sn1anam02on2061.outbound.protection.outlook.com ([40.107.96.61]:12897
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229484AbiAPQHS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 11:07:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAmjbOLXxyElZf5mK4LQcv6P4dhCSTl7KANCT5vbWqUXE95V0wUDygKhNCP05ZNrhDWjU0lxSjUw81SRgmRDIzNDChv9HorrDgDg2yRjNssKzXljhbbYVyTZYGSBLQdKvB9gvHKnILYbTfmaLtcVkthCZ+LtkqCepeS2amNEHx3Zsf6YiTkJCDB/PToKeZFI9/fct38XdBHT73tCKhHO6M7DkzOMCuUv9l/PLTr8Q189e2r+ZIo0xPH8fchZid+J8te01GXXEDYueWZkcNeiCIIB1B/8kAYhEjZsk3+d/8jIfm9HzRfsKQjkAnsVJCMqKRp88KAmNBKxqgSGFO4Z9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBNJzHsx3FFZgiZE0oDb6IMTc974zGx0pRjkGGnx5I8=;
 b=BRnHFAkS6GnyioxU2he6aCUwvC+5sivB4MNJEVBjylObSSaaTxYD/RD30wKZz1LG73AkYrzdEZyxKRF6PqCm2uKA2MfInUWdyRIf1nA4PM9rjHC4LVhkXaJCVRCdi+NHpnStPwTSBxhZeA23jI7l+w95f3DVoipNIh0BugHloSBOgyaqXVidYGCeqlaJAWhr3wdQpsOcwYdQrriG+jn5tRjD8/Cl+Fz19w7SrI7wofW2ebYRS/4SXy6GFk0jkbxse2IwDbit4ir1AnEhmgJKDnELvQkYuBf3CNHtf/MPGh2VhI60JqUB+KqBExJFJ+Kz3CD1YlR67xb1L7ah28cggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBNJzHsx3FFZgiZE0oDb6IMTc974zGx0pRjkGGnx5I8=;
 b=rEKe8KEj0HUBJBICWymhlWcgeDKuy27uvIShvrh7dg3x9IU6fKbrFVxz0i5MtC9vaxGmcphrYPrYW8eZNl+shmUmgXyxZhRSV+S86LFH7ZJxXK0V4/a6hIkzlV2SX/KphVCXI+NviVcFmFAwnFndKLga3gE/lb025wGjlwhGUKO2lI8Ez8RONLmu6b+Yd76tJXqcNyhqRnM7gM4esz1k6GwANijnTdafREJeGZHSdl9HlJRSuB4esmuSMnjLADM5YU1whkxheVVNdJczfbB1lcFUcFBoHm8gT+LpG/FinftNp7CPAaw1uUqlJcGoTtbTRh1gD54KWerZIUfYn00Skw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MWHPR12MB1165.namprd12.prod.outlook.com (2603:10b6:300:d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sun, 16 Jan
 2022 16:07:16 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 16:07:16 +0000
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
Subject: [PATCH v3 01/21] git-p4: add blank lines between functions and class definitions
Date:   Sun, 16 Jan 2022 16:05:30 +0000
Message-Id: <20220116160550.514637-2-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 00e8952a-3502-4dd1-10c4-08d9d90a43a9
X-MS-TrafficTypeDiagnostic: MWHPR12MB1165:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB11657C191524B68EA0986A14C8569@MWHPR12MB1165.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:218;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ub2MzFw2RnC3svWs3KKSQR8I1x3T1mNJETO3zf74W/hdOZpIKFZ1oe09OWkWqVmvNk3UymhrTWiTgpWMMwe1I6HrvB1Fsuczpl2B376P1OXX7r5rNNjQDx3b4mZjuQBO6my439tvXI69DQhSOYzrxy05U5/Ta9xim8ggn1YgVpTGbGFAFlqbeTGxrndIZFe/LnSs79rXPXKmpzCZI8XvUTwcxgG7My4sZCBcixRGSXSpCpW2azTBB+nT8hgGkPy4wVorG+/mCf9Klzl2rOgnN43Y5fS2sbZaFgUIRvKVDtdL67aBzVEG0580iEN5An6SvyWf1wznzLkmRavtM3Nb33SAol05/yotfQ0rro5Ou8H6FsqYlW7vuXYzoOGZpd1is559+i5SWeVffL/tIrByHR9+/r7duwpJ9c/4+qbYeKhfMhm54nXaBwqO7lJl9fiu7S4fDKIkKrVz6i50GhbiJNU5wwRl7ODJraQkL+++kdwrciQyfY3b99Kd1a06D/+/OvZIf+paHkt6AW++lqCeOoCXmsjmpP7ww5WN3tSD4zz8hpy9nHiK9esh3UXGeCa7vFfWujP1UIFNIUNc7AkBcbq0NWbhiqS8ua5jOR0x2DuC9p0O82z9udHRDB5JLvfp0mzisnIoTBMjeZsBAmD2M5K2Dg4BnZKEKhiyFKNnbzps3pne2cvXXrXN01AJIshVFOD5A1qqXt9vW5SyT4DxmBcY+KWiXZNorLwYc1QHvVJBBnI0S0M4TCbfSADAd5a9ROG6gpcp8kzDcLpGDaSGjE7zT/r37CNIftBSKUc3rk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66946007)(2906002)(52116002)(8676002)(508600001)(186003)(966005)(83380400001)(26005)(8936002)(66476007)(107886003)(55236004)(6666004)(30864003)(2616005)(1076003)(7416002)(6486002)(110136005)(86362001)(6512007)(316002)(36756003)(38100700002)(38350700002)(4326008)(54906003)(6506007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jK9Ip0XolbvjhAXKi7gnq4UtNFrSfZP/rJ5c9krGrhWlkNP2UpaZqIi8dd5D?=
 =?us-ascii?Q?BdiTdR/hbQBSbj08/xKjOi6ZWf6sroeoe0D74DzuRujiUa7C5HUtqdyPRM85?=
 =?us-ascii?Q?+hR9aJFG6b3JoCct8IN4ozcG1cPiGZUdmuvJ/xai3foh1hoX8jAVUBZ6vS0R?=
 =?us-ascii?Q?MuMvFZ2igC8Yk43Vdc0X3+ykgSqkFhHQHd3mtiN++K+1AiM5Di2kiSmxS1ex?=
 =?us-ascii?Q?fR7uQPwHfLx1do2SgIa0n9pssPVlNsCRwI4WUHgTSXBkeNv2eA8xf9uNZlQ0?=
 =?us-ascii?Q?U6PPKRVBWfuxcnhM980gF6pVE2yHk+dKuASbIN86F4l0UH21LUGlfVcmYXiB?=
 =?us-ascii?Q?lCn2TkrTPG/VNjcZdBMh4NZvjv2TzAZdYeXQ4CDgkyscjrMMrmGMLEqr4VeH?=
 =?us-ascii?Q?CxfZpIc7tMxfvsNRxD1Evow82KWTg+uSJHAS/notKwUNq4kzCE4rQq7Jp2n9?=
 =?us-ascii?Q?a6NRY6aCfi2E5Znf3mW4aRPQOgZgWMgvg/8Xn156MsTJh9ErNnMynYlCZAkQ?=
 =?us-ascii?Q?wwcBYfppjevHLoKM9QekQmsQcJX8IF91vuMHD2wGpFN/NUCqzI1Z1s3z5Ea8?=
 =?us-ascii?Q?17/NCoXcah1oj1d786R6vsGqDcw3h/xs3kTs4GLR0vX8VAqj1Ips/+JgvnJT?=
 =?us-ascii?Q?i0+zHF/pg9gqnjvNuNqsz2g7ool/OP3G8H4CaXz+AWugUOV+CsrhclyWunTk?=
 =?us-ascii?Q?sBmTf5dTjwkHBkBbegppoG1JbydsMWqr1L8oZQcxUFgS1nSvE/TJQTIGmidJ?=
 =?us-ascii?Q?5uU+VA9xpn2YHsngtKwGcnPUTmMAz5RZ81wnzc2cmMgwoGu4p78XyW49Utj2?=
 =?us-ascii?Q?40UmLK7+i44MI/bE5U3Q/vfpOreyFZMnBYiFbdAGLGlhPUaAI2OzfQF/GIvY?=
 =?us-ascii?Q?+fKF1dZMRXr5qjsJO+ZymJrtPk1LCudDQdRjd087lGBk+p2h/FRCcOGNEsU3?=
 =?us-ascii?Q?qtifYgvINrcQCtzRXoyobOG+7DmL8Ld2MUKJqcxmVKSx3u+GIOMbOpVM7ZjM?=
 =?us-ascii?Q?1XJAIeaiZKaC7ineR3wfngmRz9ksB8pWgEm69/x59Qxo69mI6GMCekhg+EEn?=
 =?us-ascii?Q?0Bzl3/MYrI/ffdX2xIAoE6rYECM9/n56dbyC/h5u9UUZCbFvmAIk+KPv6A9T?=
 =?us-ascii?Q?EX9yDiDHF+7CYap65xOttoAG2uk/1cSKwb4dR1H98jbmOO2C9RmBRU61dS7p?=
 =?us-ascii?Q?6wo/0Lt7Vt642SKZ/NlKrXAslh9KD4q5/NoHBGkIgRskIXs/Rti97G7/nR/U?=
 =?us-ascii?Q?Cf1tlhsdv7E9QpkB3zIS1LUrnYLKww28yBuVAtKIUGX+zLABGwiomiNCtVev?=
 =?us-ascii?Q?youF8PEyAyICA4ljtCOULcP9hDdbzf1AWGcJ6ryHRk54wlWvxGDYSIR+Tgkc?=
 =?us-ascii?Q?sAT5eND8PQa/Tym1nPZaHFQ2neXoSkfGHoMaBtGLbKbFbe/Cuq/K83s2UNNU?=
 =?us-ascii?Q?rguRATAtkNhYbVAWtPi6NtQO8HavbO7gdHMiYXB3FlXlZGjE7pBMW53MrT7f?=
 =?us-ascii?Q?5JIBOb5HbdwvpZ3+1qYi9pgm1dlFvbo/7IQWbZyjaUUd6lj9eff1bCPcZBFu?=
 =?us-ascii?Q?pK5sIRSUi0WCh8vAxXhIq2WqbxGl1lfXfC4xDBDp1PnmN9DTPdHMhYlbpNUq?=
 =?us-ascii?Q?Bpr2DKkUrordCybbt/lB0Sk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e8952a-3502-4dd1-10c4-08d9d90a43a9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 16:07:15.9877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WdlslBO7DgAC7bd6U9s0V+HbxCWWQGCNCdqHZy/RPU3IuS9hhki2vzKX5YaYNiBjslXx4gSTvn4yhQKMPEUmVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1165
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the PEP8 style guidelines, top-level functions and class definitions
should be separated by two blank lines. Methods should be surrounded by
a single blank line.

This guideline is described here in the "Blank Lines" section:
https://www.python.org/dev/peps/pep-0008/#blank-lines

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 47ad2d6409..c098fa852f 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -59,6 +59,7 @@
 re_ko_keywords = re.compile(br'\$(Id|Header)(:[^$\n]+)?\$')
 re_k_keywords = re.compile(br'\$(Id|Header|Author|Date|DateTime|Change|File|Revision)(:[^$\n]+)?\$')
 
+
 def format_size_human_readable(num):
     """ Returns a number of units (typically bytes) formatted as a human-readable
         string.
@@ -71,6 +72,7 @@ def format_size_human_readable(num):
             return "{:3.1f} {}B".format(num, unit)
     return "{:.1f} YiB".format(num)
 
+
 def p4_build_cmd(cmd):
     """Build a suitable p4 command line.
 
@@ -118,6 +120,7 @@ def p4_build_cmd(cmd):
 
     return real_cmd
 
+
 def git_dir(path):
     """ Return TRUE if the given path is a git directory (/path/to/dir/.git).
         This won't automatically add ".git" to a directory.
@@ -128,6 +131,7 @@ def git_dir(path):
     else:
         return d
 
+
 def chdir(path, is_client_path=False):
     """Do chdir to the given path, and set the PWD environment
        variable for use by P4.  It does not look at getcwd() output.
@@ -150,6 +154,7 @@ def chdir(path, is_client_path=False):
         path = os.getcwd()
     os.environ['PWD'] = path
 
+
 def calcDiskFree():
     """Return free space in bytes on the disk of the given dirname."""
     if platform.system() == 'Windows':
@@ -160,6 +165,7 @@ def calcDiskFree():
         st = os.statvfs(os.getcwd())
         return st.f_bavail * st.f_frsize
 
+
 def die(msg):
     """ Terminate execution. Make sure that any running child processes have been wait()ed for before
         calling this.
@@ -170,6 +176,7 @@ def die(msg):
         sys.stderr.write(msg + "\n")
         sys.exit(1)
 
+
 def prompt(prompt_text):
     """ Prompt the user to choose one of the choices
 
@@ -188,21 +195,25 @@ def prompt(prompt_text):
         if response in choices:
             return response
 
+
 # We need different encoding/decoding strategies for text data being passed
 # around in pipes depending on python version
 if bytes is not str:
     # For python3, always encode and decode as appropriate
     def decode_text_stream(s):
         return s.decode() if isinstance(s, bytes) else s
+
     def encode_text_stream(s):
         return s.encode() if isinstance(s, str) else s
 else:
     # For python2.7, pass read strings as-is, but also allow writing unicode
     def decode_text_stream(s):
         return s
+
     def encode_text_stream(s):
         return s.encode('utf_8') if isinstance(s, unicode) else s
 
+
 def decode_path(path):
     """Decode a given string (bytes or otherwise) using configured path encoding options
     """
@@ -218,6 +229,7 @@ def decode_path(path):
                 print('Path with non-ASCII characters detected. Used {} to decode: {}'.format(encoding, path))
         return path
 
+
 def run_git_hook(cmd, param=[]):
     """Execute a hook if the hook exists."""
     if verbose:
@@ -253,6 +265,7 @@ def run_git_hook(cmd, param=[]):
 
     return run_hook_command(hook_file, param) == 0
 
+
 def run_hook_command(cmd, param):
     """Executes a git hook command
        cmd = the command line file to be executed. This can be
@@ -298,12 +311,14 @@ def write_pipe(c, stdin, *k, **kw):
 
     return val
 
+
 def p4_write_pipe(c, stdin, *k, **kw):
     real_cmd = p4_build_cmd(c)
     if bytes is not str and isinstance(stdin, str):
         stdin = encode_text_stream(stdin)
     return write_pipe(real_cmd, stdin, *k, **kw)
 
+
 def read_pipe_full(c, *k, **kw):
     """ Read output from  command. Returns a tuple
         of the return status, stdout text and stderr
@@ -317,6 +332,7 @@ def read_pipe_full(c, *k, **kw):
     (out, err) = p.communicate()
     return (p.returncode, out, decode_text_stream(err))
 
+
 def read_pipe(c, ignore_error=False, raw=False, *k, **kw):
     """ Read output from  command. Returns the output text on
         success. On failure, terminates execution, unless
@@ -334,6 +350,7 @@ def read_pipe(c, ignore_error=False, raw=False, *k, **kw):
         out = decode_text_stream(out)
     return out
 
+
 def read_pipe_text(c, *k, **kw):
     """ Read output from a command with trailing whitespace stripped.
         On error, returns None.
@@ -344,10 +361,12 @@ def read_pipe_text(c, *k, **kw):
     else:
         return decode_text_stream(out).rstrip()
 
+
 def p4_read_pipe(c, ignore_error=False, raw=False, *k, **kw):
     real_cmd = p4_build_cmd(c)
     return read_pipe(real_cmd, ignore_error, raw=raw, *k, **kw)
 
+
 def read_pipe_lines(c, raw=False, *k, **kw):
     if verbose:
         sys.stderr.write('Reading pipe: {}\n'.format(' '.join(c)))
@@ -361,11 +380,13 @@ def read_pipe_lines(c, raw=False, *k, **kw):
         die('Command failed: {}'.format(' '.join(c)))
     return lines
 
+
 def p4_read_pipe_lines(c, *k, **kw):
     """Specifically invoke p4 on the command supplied. """
     real_cmd = p4_build_cmd(c)
     return read_pipe_lines(real_cmd, *k, **kw)
 
+
 def p4_has_command(cmd):
     """Ask p4 for help on this command.  If it returns an error, the
        command does not exist in this version of p4."""
@@ -375,6 +396,7 @@ def p4_has_command(cmd):
     p.communicate()
     return p.returncode == 0
 
+
 def p4_has_move_command():
     """See if the move command exists, that it supports -k, and that
        it has not been administratively disabled.  The arguments
@@ -395,6 +417,7 @@ def p4_has_move_command():
     # assume it failed because @... was invalid changelist
     return True
 
+
 def system(cmd, ignore_error=False, *k, **kw):
     if verbose:
         sys.stderr.write("executing {}\n".format(
@@ -405,6 +428,7 @@ def system(cmd, ignore_error=False, *k, **kw):
 
     return retcode
 
+
 def p4_system(cmd, *k, **kw):
     """Specifically invoke p4 as the system command. """
     real_cmd = p4_build_cmd(cmd)
@@ -412,9 +436,11 @@ def p4_system(cmd, *k, **kw):
     if retcode:
         raise subprocess.CalledProcessError(retcode, real_cmd)
 
+
 def die_bad_access(s):
     die("failure accessing depot: {0}".format(s.rstrip()))
 
+
 def p4_check_access(min_expiration=1):
     """ Check if we can access Perforce - account still logged in
     """
@@ -460,7 +486,10 @@ def p4_check_access(min_expiration=1):
     else:
         die_bad_access("unknown error code {0}".format(code))
 
+
 _p4_version_string = None
+
+
 def p4_version_string():
     """Read the version string, showing just the last line, which
        hopefully is the interesting version bit.
@@ -476,12 +505,15 @@ def p4_version_string():
         _p4_version_string = a[-1].rstrip()
     return _p4_version_string
 
+
 def p4_integrate(src, dest):
     p4_system(["integrate", "-Dt", wildcard_encode(src), wildcard_encode(dest)])
 
+
 def p4_sync(f, *options):
     p4_system(["sync"] + list(options) + [wildcard_encode(f)])
 
+
 def p4_add(f):
     # forcibly add file names with wildcards
     if wildcard_present(f):
@@ -489,29 +521,37 @@ def p4_add(f):
     else:
         p4_system(["add", f])
 
+
 def p4_delete(f):
     p4_system(["delete", wildcard_encode(f)])
 
+
 def p4_edit(f, *options):
     p4_system(["edit"] + list(options) + [wildcard_encode(f)])
 
+
 def p4_revert(f):
     p4_system(["revert", wildcard_encode(f)])
 
+
 def p4_reopen(type, f):
     p4_system(["reopen", "-t", type, wildcard_encode(f)])
 
+
 def p4_reopen_in_change(changelist, files):
     cmd = ["reopen", "-c", str(changelist)] + files
     p4_system(cmd)
 
+
 def p4_move(src, dest):
     p4_system(["move", "-k", wildcard_encode(src), wildcard_encode(dest)])
 
+
 def p4_last_change():
     results = p4CmdList(["changes", "-m", "1"], skip_info=True)
     return int(results[0]['change'])
 
+
 def p4_describe(change, shelved=False):
     """Make sure it returns a valid result by checking for
        the presence of field "time".  Return a dict of the
@@ -540,6 +580,7 @@ def p4_describe(change, shelved=False):
 
     return d
 
+
 #
 # Canonicalize the p4 type and return a tuple of the
 # base type, plus any modifiers.  See "p4 help filetypes"
@@ -575,6 +616,7 @@ def split_p4_type(p4type):
         mods = s[1]
     return (base, mods)
 
+
 #
 # return the raw p4 type of a file (text, text+ko, etc)
 #
@@ -582,6 +624,7 @@ def p4_type(f):
     results = p4CmdList(["fstat", "-T", "headType", wildcard_encode(f)])
     return results[0]['headType']
 
+
 #
 # Given a type base and modifier, return a regexp matching
 # the keywords that can be expanded in the file
@@ -597,6 +640,7 @@ def p4_keywords_regexp_for_type(base, type_mods):
     else:
         return None
 
+
 #
 # Given a file, return a regexp matching the possible
 # RCS keywords that will be expanded, or None for files
@@ -609,6 +653,7 @@ def p4_keywords_regexp_for_file(file):
         (type_base, type_mods) = split_p4_type(p4_type(file))
         return p4_keywords_regexp_for_type(type_base, type_mods)
 
+
 def setP4ExecBit(file, mode):
     # Reopens an already open file and changes the execute bit to match
     # the execute bit setting in the passed in mode.
@@ -624,6 +669,7 @@ def setP4ExecBit(file, mode):
 
     p4_reopen(p4Type, file)
 
+
 def getP4OpenedType(file):
     # Returns the perforce file type for the given file.
 
@@ -634,6 +680,7 @@ def getP4OpenedType(file):
     else:
         die("Could not determine file type for %s (result: '%s')" % (file, result))
 
+
 # Return the set of all p4 labels
 def getP4Labels(depotPaths):
     labels = set()
@@ -646,6 +693,7 @@ def getP4Labels(depotPaths):
 
     return labels
 
+
 # Return the set of all git tags
 def getGitTags():
     gitTags = set()
@@ -654,8 +702,10 @@ def getGitTags():
         gitTags.add(tag)
     return gitTags
 
+
 _diff_tree_pattern = None
 
+
 def parseDiffTreeEntry(entry):
     """Parses a single diff tree entry into its component elements.
 
@@ -693,41 +743,52 @@ def parseDiffTreeEntry(entry):
         }
     return None
 
+
 def isModeExec(mode):
     # Returns True if the given git mode represents an executable file,
     # otherwise False.
     return mode[-3:] == "755"
 
+
 class P4Exception(Exception):
     """ Base class for exceptions from the p4 client """
+
     def __init__(self, exit_code):
         self.p4ExitCode = exit_code
 
+
 class P4ServerException(P4Exception):
     """ Base class for exceptions where we get some kind of marshalled up result from the server """
+
     def __init__(self, exit_code, p4_result):
         super(P4ServerException, self).__init__(exit_code)
         self.p4_result = p4_result
         self.code = p4_result[0]['code']
         self.data = p4_result[0]['data']
 
+
 class P4RequestSizeException(P4ServerException):
     """ One of the maxresults or maxscanrows errors """
+
     def __init__(self, exit_code, p4_result, limit):
         super(P4RequestSizeException, self).__init__(exit_code, p4_result)
         self.limit = limit
 
+
 class P4CommandException(P4Exception):
     """ Something went wrong calling p4 which means we have to give up """
+
     def __init__(self, msg):
         self.msg = msg
 
     def __str__(self):
         return self.msg
 
+
 def isModeExecChanged(src_mode, dst_mode):
     return isModeExec(src_mode) != isModeExec(dst_mode)
 
+
 def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
         errors_as_exceptions=False, *k, **kw):
 
@@ -804,6 +865,7 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
 
     return result
 
+
 def p4Cmd(cmd, *k, **kw):
     list = p4CmdList(cmd, *k, **kw)
     result = {}
@@ -811,6 +873,7 @@ def p4Cmd(cmd, *k, **kw):
         result.update(entry)
     return result;
 
+
 def p4Where(depotPath):
     if not depotPath.endswith("/"):
         depotPath += "/"
@@ -847,20 +910,25 @@ def p4Where(depotPath):
         clientPath = clientPath[:-3]
     return clientPath
 
+
 def currentGitBranch():
     return read_pipe_text(["git", "symbolic-ref", "--short", "-q", "HEAD"])
 
+
 def isValidGitDir(path):
     return git_dir(path) != None
 
+
 def parseRevision(ref):
     return read_pipe(["git", "rev-parse", ref]).strip()
 
+
 def branchExists(ref):
     rev = read_pipe(["git", "rev-parse", "-q", "--verify", ref],
                      ignore_error=True)
     return len(rev) > 0
 
+
 def extractLogMessageFromGitCommit(commit):
     logMessage = ""
 
@@ -875,6 +943,7 @@ def extractLogMessageFromGitCommit(commit):
        logMessage += log
     return logMessage
 
+
 def extractSettingsGitLog(log):
     values = {}
     for line in log.split("\n"):
@@ -900,19 +969,24 @@ def extractSettingsGitLog(log):
         values['depot-paths'] = paths.split(',')
     return values
 
+
 def gitBranchExists(branch):
     proc = subprocess.Popen(["git", "rev-parse", branch],
                             stderr=subprocess.PIPE, stdout=subprocess.PIPE);
     return proc.wait() == 0;
 
+
 def gitUpdateRef(ref, newvalue):
     subprocess.check_call(["git", "update-ref", ref, newvalue])
 
+
 def gitDeleteRef(ref):
     subprocess.check_call(["git", "update-ref", "-d", ref])
 
+
 _gitConfig = {}
 
+
 def gitConfig(key, typeSpecifier=None):
     if key not in _gitConfig:
         cmd = [ "git", "config" ]
@@ -923,6 +997,7 @@ def gitConfig(key, typeSpecifier=None):
         _gitConfig[key] = s.strip()
     return _gitConfig[key]
 
+
 def gitConfigBool(key):
     """Return a bool, using git config --bool.  It is True only if the
        variable is set to true, and False if set to false or not present
@@ -932,6 +1007,7 @@ def gitConfigBool(key):
         _gitConfig[key] = gitConfig(key, '--bool') == "true"
     return _gitConfig[key]
 
+
 def gitConfigInt(key):
     if key not in _gitConfig:
         cmd = [ "git", "config", "--int", key ]
@@ -943,6 +1019,7 @@ def gitConfigInt(key):
             _gitConfig[key] = None
     return _gitConfig[key]
 
+
 def gitConfigList(key):
     if key not in _gitConfig:
         s = read_pipe(["git", "config", "--get-all", key], ignore_error=True)
@@ -951,6 +1028,7 @@ def gitConfigList(key):
             _gitConfig[key] = []
     return _gitConfig[key]
 
+
 def p4BranchesInGit(branchesAreInRemotes=True):
     """Find all the branches whose names start with "p4/", looking
        in remotes or heads as specified by the argument.  Return
@@ -983,6 +1061,7 @@ def p4BranchesInGit(branchesAreInRemotes=True):
 
     return branches
 
+
 def branch_exists(branch):
     """Make sure that the given ref name really exists."""
 
@@ -995,6 +1074,7 @@ def branch_exists(branch):
     # expect exactly one line of output: the branch name
     return out.rstrip() == branch
 
+
 def findUpstreamBranchPoint(head = "HEAD"):
     branches = p4BranchesInGit()
     # map from depot-path to branch name
@@ -1022,6 +1102,7 @@ def findUpstreamBranchPoint(head = "HEAD"):
 
     return ["", settings]
 
+
 def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent=True):
     if not silent:
         print("Creating/updating branch(es) in %s based on origin branch(es)"
@@ -1069,6 +1150,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
         if update:
             system(["git", "update-ref", remoteHead, originHead])
 
+
 def originP4BranchesExist():
         return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
 
@@ -1082,12 +1164,14 @@ def p4ParseNumericChangeRange(parts):
 
     return (changeStart, changeEnd)
 
+
 def chooseBlockSize(blockSize):
     if blockSize:
         return blockSize
     else:
         return defaultBlockSize
 
+
 def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
     assert depotPaths
 
@@ -1165,6 +1249,7 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
     changes = sorted(changes)
     return changes
 
+
 def p4PathStartsWith(path, prefix):
     # This method tries to remedy a potential mixed-case issue:
     #
@@ -1177,6 +1262,7 @@ def p4PathStartsWith(path, prefix):
         return path.lower().startswith(prefix.lower())
     return path.startswith(prefix)
 
+
 def getClientSpec():
     """Look at the p4 client spec, create a View() object that contains
        all the mappings, and return it."""
@@ -1207,6 +1293,7 @@ def getClientSpec():
 
     return view
 
+
 def getClientRoot():
     """Grab the client directory."""
 
@@ -1220,6 +1307,7 @@ def getClientRoot():
 
     return entry["Root"]
 
+
 #
 # P4 wildcards are not allowed in filenames.  P4 complains
 # if you simply add them, but you can force it with "-f", in
@@ -1237,6 +1325,7 @@ def wildcard_decode(path):
                .replace("%25", "%")
     return path
 
+
 def wildcard_encode(path):
     # do % first to avoid double-encoding the %s introduced here
     path = path.replace("%", "%25") \
@@ -1245,10 +1334,12 @@ def wildcard_encode(path):
                .replace("@", "%40")
     return path
 
+
 def wildcard_present(path):
     m = re.search("[*#@%]", path)
     return m is not None
 
+
 class LargeFileSystem(object):
     """Base class for large file system support."""
 
@@ -1330,6 +1421,7 @@ def processContent(self, git_mode, relPath, contents):
                     sys.stderr.write("%s moved to large file system (%s)\n" % (relPath, localLargeFile))
         return (git_mode, contents)
 
+
 class MockLFS(LargeFileSystem):
     """Mock large file system for testing."""
 
@@ -1353,6 +1445,7 @@ def pushFile(self, localLargeFile):
             os.makedirs(remotePath)
         shutil.copyfile(localLargeFile, os.path.join(remotePath, os.path.basename(localLargeFile)))
 
+
 class GitLFS(LargeFileSystem):
     """Git LFS as backend for the git-p4 large file system.
        See https://git-lfs.github.com/ for details."""
@@ -1441,6 +1534,7 @@ def processContent(self, git_mode, relPath, contents):
         else:
             return LargeFileSystem.processContent(self, git_mode, relPath, contents)
 
+
 class Command:
     delete_actions = ( "delete", "move/delete", "purge" )
     add_actions = ( "add", "branch", "move/add" )
@@ -1456,6 +1550,7 @@ def ensure_value(self, attr, value):
             setattr(self, attr, value)
         return getattr(self, attr)
 
+
 class P4UserMap:
     def __init__(self):
         self.userMapFromPerforceServer = False
@@ -1526,6 +1621,7 @@ def loadUserMapFromCache(self):
         except IOError:
             self.getUserMapFromPerforceServer()
 
+
 class P4Submit(Command, P4UserMap):
 
     conflict_behavior_choices = ("ask", "skip", "quit")
@@ -2531,6 +2627,7 @@ def run(self, args):
 
         return True
 
+
 class View(object):
     """Represent a p4 view ("p4 help views"), and map files in a
        repo according to the view."""
@@ -2638,11 +2735,13 @@ def map_in_client(self, depot_path):
         die( "Error: %s is not found in client spec path" % depot_path )
         return ""
 
+
 def cloneExcludeCallback(option, opt_str, value, parser):
     # prepend "/" because the first "/" was consumed as part of the option itself.
     # ("-//depot/A/..." becomes "/depot/A/..." after option parsing)
     parser.values.cloneExclude += ["/" + re.sub(r"\.\.\.$", "", value)]
 
+
 class P4Sync(Command, P4UserMap):
 
     def __init__(self):
@@ -4000,6 +4099,7 @@ def run(self, args):
 
         return True
 
+
 class P4Rebase(Command):
     def __init__(self):
         Command.__init__(self)
@@ -4037,6 +4137,7 @@ def rebase(self):
             "HEAD", "--"])
         return True
 
+
 class P4Clone(P4Sync):
     def __init__(self):
         P4Sync.__init__(self)
@@ -4115,6 +4216,7 @@ def run(self, args):
 
         return True
 
+
 class P4Unshelve(Command):
     def __init__(self):
         Command.__init__(self)
@@ -4230,6 +4332,7 @@ def run(self, args):
 
         return True
 
+
 class P4Branches(Command):
     def __init__(self):
         Command.__init__(self)
@@ -4255,6 +4358,7 @@ def run(self, args):
             print("%s <= %s (%s)" % (branch, ",".join(settings["depot-paths"]), settings["change"]))
         return True
 
+
 class HelpFormatter(optparse.IndentedHelpFormatter):
     def __init__(self):
         optparse.IndentedHelpFormatter.__init__(self)
@@ -4265,6 +4369,7 @@ def format_description(self, description):
         else:
             return ""
 
+
 def printUsage(commands):
     print("usage: %s <command> [options]" % sys.argv[0])
     print("")
@@ -4273,6 +4378,7 @@ def printUsage(commands):
     print("Try %s <command> --help for command specific help." % sys.argv[0])
     print("")
 
+
 commands = {
     "submit" : P4Submit,
     "commit" : P4Submit,
@@ -4283,6 +4389,7 @@ def printUsage(commands):
     "unshelve" : P4Unshelve,
 }
 
+
 def main():
     if len(sys.argv[1:]) == 0:
         printUsage(commands.keys())
-- 
2.34.1

