Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525FDC433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 13:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353688AbiALNrZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:47:25 -0500
Received: from mail-dm6nam11on2052.outbound.protection.outlook.com ([40.107.223.52]:31597
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353687AbiALNrM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 08:47:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPdzmsEeWYsikWPq0hRg9bqB4sfvhiAZfEGInqAIQAjuvhBPkykCi0m+F+27JS1ezlfjhHr/OJLfrVztodRepNmlXIMJ4/eotFNkok6XhiSYDXTvgfwQ5MsWa5AvpXn9fMHtcRP11ZqrrZB5pb/EWHEoC5Wpk9JPRu6BTF3gfMFoyod4RwldSAUxyxhC0MeYQzqpAI+eYBo4cKqiz/B+PXlzXqhdRh5oJLAwYU7l+yp3tgJYe3lCDkZWTl9+6Fo9Yz2FHR79RtunqQ2uQkp0S/2J7Or01Ay+4TkkjB7lXP+Az7x4VpYi08B6mnFi/rribSf5efw5Pua+Erf2V6Cdaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktgOPrNAjMadJWXLBQaIX49y0/qM+/A/NaD6OcQQ6mM=;
 b=T851cX9fZ3TfFBfooJNmn2BnkjkyeKoY/9oMM9dZE3oU9qu2ijLrQZxNi0kdQ8WnzeMah1j6ocZWFeG+HdldFGGYG7JLRS461a1QiGjUAzsAP8klTgjVkx8+60ocp27k0fihj9GJCYUWsK0WZNhDYIRnmZ+eVrofsWohW3CpiCJjBBOiWlhSl4JZo2EBa5uApJcexf0m7is+9ETlctnTVyPH0XbGyf+HTZ6LLujnX0Gah6T/10I+WhuWTjrZDmdWuGiWaBty+NIxc2qTXl+PD01U7MaECCNTpTamqmyZjW2HTcvG+Jn0mJ0ABqiNdQ1M/zmOnV+JNVhrGOTC0FFIxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktgOPrNAjMadJWXLBQaIX49y0/qM+/A/NaD6OcQQ6mM=;
 b=iaGaObwEi6Ok2l+s9pKWMlug8Wnk1pBaEA9ECqO1WmiXz+/Kr/5l+zh2N7L4HyBQBwGc3PMnihVzsBoMfYki1zQSjnGuoOAUGm28dRtzPhtL90GA+/cFr0ofr9hlX9eQJc1U9apXYoK+f+Dfp+qbxpBxCYLc7oW89rLtW/SLOzHgsXvPkuXPk4kDdnc1vJ7KNY4jxSEJXiNGUL8oHkhiUNCtdQ2rLSl6pKf5RiQiwzrKMm/F/5GBl2fyKA3I8hVbCtUAXPfF/JErXgpGsEEZ1GqDbhu/4uMgSi0oUogpAc2IiE/n20zVeWRdoTo4cPVbsSGU1uI4RuDbEvrmEc1zHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 13:47:10 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 13:47:10 +0000
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
Subject: [PATCH 01/20] git-p4: add blank lines between functions and class definitions
Date:   Wed, 12 Jan 2022 13:46:16 +0000
Message-Id: <20220112134635.177877-2-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112134635.177877-1-jholdsworth@nvidia.com>
References: <20220112134635.177877-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff744fc3-8c35-4fc6-a3c5-08d9d5d207d4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4136:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4136FEE692E6242DE105C90EC8529@CH2PR12MB4136.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:218;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xL3EIeKXQSyjzbcHNb/BaV63yjW3cGRd1MG0SMoxWT5A+y3C+ywFeJvfkZYCFKoYBg3ZLjZ8+VVamQRumjmjcUrRTGiDJG9d7ZZ/5cdvGVFhEb0u/o6uYO23T8F1kA9qu9HYUdkM1MIAJPtNLvBWP5SWF9ZtarD4lApUqywA5U/reYmU7pccDXqH7IHAiWEmw3krc7X2gJb7ZZw+fZk+6QyR2TWxuA+5i40/F1oRHTOq507iNZ0xAfDNHLtwPQruIOGT6ill7ntl+jo09UvXiixqPokeR81gb+Elli2gvUjhBwKiMN0S+VZlQUvSHePISoY/xaqyoRRftRyzNqcGLRx/Hj0Eg4g60d8oTxuP7hEbXudIyRZPm7ncavRVa835qbaQWKxEaMVSJFODOz6ZrtSH8+eektG/X1eQ4GQUOsuYzz1rrfaW/z1dMNESLwsx12lvqBnCH72kwsHcZeY8tNamqAFAOaaFvBBT6O/IA7sYyRXaVimiBbv/8IEEfqY+1OZ4KTbjR3+oXXk3cM3io6ePR5itQ3C1qmZRkV2AxZGBPhzE5uOZl264cdUZAlswg5MX0Qi14uBdIim9NfsqUVxeBAVnB/69Gj6+pfQS+y6lTaj52e2wspap5sTFaUvFmNhSnCS8Tw/dRwrwv1abTQ0qNKRmGVwiHUYuyUm6RItUIPT42wOcnJeVb7sMThJVm1CqdY+M/uGv0g+qxBprEF8jxCwnfW3HLh413U934C02Ewm0/0Mi/3fB9ONdIp/JrxQO6DyccNvPWoXIinwRoCbP47j89S3PQlC+w9pbFIV00u/TUDV/k0One6J2Dud9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(966005)(26005)(110136005)(8676002)(6486002)(2616005)(30864003)(38100700002)(86362001)(7416002)(36756003)(54906003)(5660300002)(8936002)(6512007)(4326008)(52116002)(2906002)(1076003)(66476007)(6506007)(66556008)(186003)(38350700002)(316002)(107886003)(83380400001)(66946007)(55236004)(334744004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AmnytSvU6fvoEKyslKHrtKyEyfHBhbrTmD7r01w5ZkwrOu46LVrdg5PjpPT4?=
 =?us-ascii?Q?2xyc7FzeAuqx3Y7RBStXxgFQ+Scy98rECs/4vK7IC/2/SRTqsnCqXS/3abx6?=
 =?us-ascii?Q?Y2BU+enGguiCNtnOAR1I0fQ07Ny9yjEeFp3qQ7ZeTbCCyMGe9rbdO8UsaIXT?=
 =?us-ascii?Q?8ojdp41Gtq4AdXaNiC2+L4R8IKkfpjjsL8XVicJZPZR89vMCjcQWvp9Oc8dM?=
 =?us-ascii?Q?Bd+SRjY9TMXGzKAyJt0NbhYp/gk2jZAdKfrMw7tVwQKwqPhH3QvE1JnjBvb8?=
 =?us-ascii?Q?TAvu4g0HwC1egfMXnSfMQCcAPo1yQ1jLapkSluwnkVL13WJN9lwQdZCxSWxa?=
 =?us-ascii?Q?iOoyVaTzZYGNmOG7QlQehmDVJMdHP6fOhhYW+evy+GW/VIhjN3ILGqN4SDTK?=
 =?us-ascii?Q?m9bhlR89IWyOYD6GaUuU3gqAn8iAHm4XMeb2HYGQhsBoNciQ6xGgsPtDG07d?=
 =?us-ascii?Q?h8QuclEwyfv66ADotMx3XvHN31ImeAafnrmJv1xCz/NAz928G8AnpkwgSCxy?=
 =?us-ascii?Q?EAD99vt5TeI7N7NojsDwX6Vv2Pm4WQ1RObW3HlO0NAHg+Tm02mphQbVkJHab?=
 =?us-ascii?Q?onjD1p8dQYsQICP7D8mKZCrRN2EB4Ntb7t/Ow+rTkvemUmSzEHCw0rY32NbD?=
 =?us-ascii?Q?S02PgddPKZWxRx3TUl/fZ2KDEKyVhhYfFXOZhGi0yDbp+juVC0ARD4ms+9Ld?=
 =?us-ascii?Q?QSWbEK68DV0xA+9OAG31UIxRALiaq69aJTvwT6s5nIcv52lhbGm9f2EVq7ED?=
 =?us-ascii?Q?FrEc5QPsF9Tjpe25VzI4i63Vd0Azy2ktcLIdC1swnZtvvPyeDH6ISDWsQffh?=
 =?us-ascii?Q?V+bUhZPo+LnM5p5RrTmjrnDgktktASIGBK/MA9fy2qyrRgsY+sFgvBYzi1fN?=
 =?us-ascii?Q?n2fJKdJjfJx9zryj8yrEWyQB1CaYzy/FJsZW076if8351ByMjUL523jlllGb?=
 =?us-ascii?Q?b0E78RCneJQNy4gBY1ZovD97Ze7LBOigQK3Ke5TOd/Ol9XpaDTVhPpEzZCq8?=
 =?us-ascii?Q?Bwe4yGfzgxiPFMY9qF5SuJuILjoo7i2n/x/2JbAhVNdqsPzgTzLpoezxfhEH?=
 =?us-ascii?Q?N5LQdA21OguvggGMWF6Y6e6ehFgKAGV9A/bNSwDH0jjjzQXqvKouh+LooJ/k?=
 =?us-ascii?Q?rxxkAlB19tsPjkEa1J5ed7Xb+RP2Ht1WIePYR8VF0NsS9nGO3YqG8ukTZAmw?=
 =?us-ascii?Q?B571X/IsWFGhW4kiUFTczf/PUF8P1ryKdV+EqmNmaQwJCzCGX2HoIx5uIkev?=
 =?us-ascii?Q?wJo2Bfl9Bo0cAQfY88lqfWptOz6nH1Qa4uucUFzftEvdXZblKwlJITfPYSJG?=
 =?us-ascii?Q?IfwNC25AFzgDUtjfnhwFrIpgr//oT5EkbDihWlIm+DtHwy6OmFBLccZ1Upm2?=
 =?us-ascii?Q?7L85RyuwgPOk3405Vmm/7AC+exaankDIRSJrtnjwCzFjQ/7ZfxpllDetvmlA?=
 =?us-ascii?Q?HdVV+QjkYfdyBWyYLzvZoZNolEn44bQzu3JfIRWv+KnkwcM0fupUVC9QaoGS?=
 =?us-ascii?Q?85Wt2cUqVuwsLmE/vXpRW98b6G/yrVsWiltX2lUL0g14XOcPYgASiRSiKINy?=
 =?us-ascii?Q?Zifjgfc2Jh35E5ZA6ygpcIsLhFjhp+jzUsTxQEsuNUSqOMSiaAOStSxib9a4?=
 =?us-ascii?Q?SaPm9Zw4MwcR2uQxkhOnbOo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff744fc3-8c35-4fc6-a3c5-08d9d5d207d4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:47:10.4140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JUUydqwlVQUtoOSAvYpoycxE6hOxR0x3IqHW/NU/2wLICn0orp+xzg32jlBbrKLb8EDRELVixzG+A+A+I3FgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136
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
 git-p4.py | 109 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index cb37545455..e6cc0f18a7 100755
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
 
@@ -121,6 +123,7 @@ def p4_build_cmd(cmd):
 
     return real_cmd
 
+
 def git_dir(path):
     """ Return TRUE if the given path is a git directory (/path/to/dir/.git).
         This won't automatically add ".git" to a directory.
@@ -131,6 +134,7 @@ def git_dir(path):
     else:
         return d
 
+
 def chdir(path, is_client_path=False):
     """Do chdir to the given path, and set the PWD environment
        variable for use by P4.  It does not look at getcwd() output.
@@ -153,6 +157,7 @@ def chdir(path, is_client_path=False):
         path = os.getcwd()
     os.environ['PWD'] = path
 
+
 def calcDiskFree():
     """Return free space in bytes on the disk of the given dirname."""
     if platform.system() == 'Windows':
@@ -163,6 +168,7 @@ def calcDiskFree():
         st = os.statvfs(os.getcwd())
         return st.f_bavail * st.f_frsize
 
+
 def die(msg):
     """ Terminate execution. Make sure that any running child processes have been wait()ed for before
         calling this.
@@ -173,6 +179,7 @@ def die(msg):
         sys.stderr.write(msg + "\n")
         sys.exit(1)
 
+
 def prompt(prompt_text):
     """ Prompt the user to choose one of the choices
 
@@ -191,21 +198,25 @@ def prompt(prompt_text):
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
@@ -221,6 +232,7 @@ def decode_path(path):
                 print('Path with non-ASCII characters detected. Used {} to decode: {}'.format(encoding, path))
         return path
 
+
 def run_git_hook(cmd, param=[]):
     """Execute a hook if the hook exists."""
     if verbose:
@@ -256,6 +268,7 @@ def run_git_hook(cmd, param=[]):
 
     return run_hook_command(hook_file, param) == 0
 
+
 def run_hook_command(cmd, param):
     """Executes a git hook command
        cmd = the command line file to be executed. This can be
@@ -302,12 +315,14 @@ def write_pipe(c, stdin):
 
     return val
 
+
 def p4_write_pipe(c, stdin):
     real_cmd = p4_build_cmd(c)
     if bytes is not str and isinstance(stdin, str):
         stdin = encode_text_stream(stdin)
     return write_pipe(real_cmd, stdin)
 
+
 def read_pipe_full(c):
     """ Read output from  command. Returns a tuple
         of the return status, stdout text and stderr
@@ -321,6 +336,7 @@ def read_pipe_full(c):
     (out, err) = p.communicate()
     return (p.returncode, out, decode_text_stream(err))
 
+
 def read_pipe(c, ignore_error=False, raw=False):
     """ Read output from  command. Returns the output text on
         success. On failure, terminates execution, unless
@@ -338,6 +354,7 @@ def read_pipe(c, ignore_error=False, raw=False):
         out = decode_text_stream(out)
     return out
 
+
 def read_pipe_text(c):
     """ Read output from a command with trailing whitespace stripped.
         On error, returns None.
@@ -348,10 +365,12 @@ def read_pipe_text(c):
     else:
         return decode_text_stream(out).rstrip()
 
+
 def p4_read_pipe(c, ignore_error=False, raw=False):
     real_cmd = p4_build_cmd(c)
     return read_pipe(real_cmd, ignore_error, raw=raw)
 
+
 def read_pipe_lines(c, raw=False):
     if verbose:
         sys.stderr.write('Reading pipe: %s\n' % str(c))
@@ -366,11 +385,13 @@ def read_pipe_lines(c, raw=False):
         die('Command failed: %s' % str(c))
     return lines
 
+
 def p4_read_pipe_lines(c):
     """Specifically invoke p4 on the command supplied. """
     real_cmd = p4_build_cmd(c)
     return read_pipe_lines(real_cmd)
 
+
 def p4_has_command(cmd):
     """Ask p4 for help on this command.  If it returns an error, the
        command does not exist in this version of p4."""
@@ -380,6 +401,7 @@ def p4_has_command(cmd):
     p.communicate()
     return p.returncode == 0
 
+
 def p4_has_move_command():
     """See if the move command exists, that it supports -k, and that
        it has not been administratively disabled.  The arguments
@@ -400,6 +422,7 @@ def p4_has_move_command():
     # assume it failed because @... was invalid changelist
     return True
 
+
 def system(cmd, ignore_error=False):
     expand = not isinstance(cmd, list)
     if verbose:
@@ -410,6 +433,7 @@ def system(cmd, ignore_error=False):
 
     return retcode
 
+
 def p4_system(cmd):
     """Specifically invoke p4 as the system command. """
     real_cmd = p4_build_cmd(cmd)
@@ -418,9 +442,11 @@ def p4_system(cmd):
     if retcode:
         raise CalledProcessError(retcode, real_cmd)
 
+
 def die_bad_access(s):
     die("failure accessing depot: {0}".format(s.rstrip()))
 
+
 def p4_check_access(min_expiration=1):
     """ Check if we can access Perforce - account still logged in
     """
@@ -466,7 +492,10 @@ def p4_check_access(min_expiration=1):
     else:
         die_bad_access("unknown error code {0}".format(code))
 
+
 _p4_version_string = None
+
+
 def p4_version_string():
     """Read the version string, showing just the last line, which
        hopefully is the interesting version bit.
@@ -482,12 +511,15 @@ def p4_version_string():
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
@@ -495,29 +527,37 @@ def p4_add(f):
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
@@ -546,6 +586,7 @@ def p4_describe(change, shelved=False):
 
     return d
 
+
 #
 # Canonicalize the p4 type and return a tuple of the
 # base type, plus any modifiers.  See "p4 help filetypes"
@@ -581,6 +622,7 @@ def split_p4_type(p4type):
         mods = s[1]
     return (base, mods)
 
+
 #
 # return the raw p4 type of a file (text, text+ko, etc)
 #
@@ -588,6 +630,7 @@ def p4_type(f):
     results = p4CmdList(["fstat", "-T", "headType", wildcard_encode(f)])
     return results[0]['headType']
 
+
 #
 # Given a type base and modifier, return a regexp matching
 # the keywords that can be expanded in the file
@@ -603,6 +646,7 @@ def p4_keywords_regexp_for_type(base, type_mods):
     else:
         return None
 
+
 #
 # Given a file, return a regexp matching the possible
 # RCS keywords that will be expanded, or None for files
@@ -615,6 +659,7 @@ def p4_keywords_regexp_for_file(file):
         (type_base, type_mods) = split_p4_type(p4_type(file))
         return p4_keywords_regexp_for_type(type_base, type_mods)
 
+
 def setP4ExecBit(file, mode):
     # Reopens an already open file and changes the execute bit to match
     # the execute bit setting in the passed in mode.
@@ -630,6 +675,7 @@ def setP4ExecBit(file, mode):
 
     p4_reopen(p4Type, file)
 
+
 def getP4OpenedType(file):
     # Returns the perforce file type for the given file.
 
@@ -640,6 +686,7 @@ def getP4OpenedType(file):
     else:
         die("Could not determine file type for %s (result: '%s')" % (file, result))
 
+
 # Return the set of all p4 labels
 def getP4Labels(depotPaths):
     labels = set()
@@ -652,6 +699,7 @@ def getP4Labels(depotPaths):
 
     return labels
 
+
 # Return the set of all git tags
 def getGitTags():
     gitTags = set()
@@ -660,8 +708,10 @@ def getGitTags():
         gitTags.add(tag)
     return gitTags
 
+
 _diff_tree_pattern = None
 
+
 def parseDiffTreeEntry(entry):
     """Parses a single diff tree entry into its component elements.
 
@@ -699,41 +749,52 @@ def parseDiffTreeEntry(entry):
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
         errors_as_exceptions=False):
 
@@ -819,6 +880,7 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
 
     return result
 
+
 def p4Cmd(cmd):
     list = p4CmdList(cmd)
     result = {}
@@ -826,6 +888,7 @@ def p4Cmd(cmd):
         result.update(entry)
     return result;
 
+
 def p4Where(depotPath):
     if not depotPath.endswith("/"):
         depotPath += "/"
@@ -862,20 +925,25 @@ def p4Where(depotPath):
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
     return read_pipe("git rev-parse %s" % ref).strip()
 
+
 def branchExists(ref):
     rev = read_pipe(["git", "rev-parse", "-q", "--verify", ref],
                      ignore_error=True)
     return len(rev) > 0
 
+
 def extractLogMessageFromGitCommit(commit):
     logMessage = ""
 
@@ -890,6 +958,7 @@ def extractLogMessageFromGitCommit(commit):
        logMessage += log
     return logMessage
 
+
 def extractSettingsGitLog(log):
     values = {}
     for line in log.split("\n"):
@@ -915,19 +984,24 @@ def extractSettingsGitLog(log):
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
@@ -938,6 +1012,7 @@ def gitConfig(key, typeSpecifier=None):
         _gitConfig[key] = s.strip()
     return _gitConfig[key]
 
+
 def gitConfigBool(key):
     """Return a bool, using git config --bool.  It is True only if the
        variable is set to true, and False if set to false or not present
@@ -947,6 +1022,7 @@ def gitConfigBool(key):
         _gitConfig[key] = gitConfig(key, '--bool') == "true"
     return _gitConfig[key]
 
+
 def gitConfigInt(key):
     if key not in _gitConfig:
         cmd = [ "git", "config", "--int", key ]
@@ -958,6 +1034,7 @@ def gitConfigInt(key):
             _gitConfig[key] = None
     return _gitConfig[key]
 
+
 def gitConfigList(key):
     if key not in _gitConfig:
         s = read_pipe(["git", "config", "--get-all", key], ignore_error=True)
@@ -966,6 +1043,7 @@ def gitConfigList(key):
             _gitConfig[key] = []
     return _gitConfig[key]
 
+
 def p4BranchesInGit(branchesAreInRemotes=True):
     """Find all the branches whose names start with "p4/", looking
        in remotes or heads as specified by the argument.  Return
@@ -998,6 +1076,7 @@ def p4BranchesInGit(branchesAreInRemotes=True):
 
     return branches
 
+
 def branch_exists(branch):
     """Make sure that the given ref name really exists."""
 
@@ -1010,6 +1089,7 @@ def branch_exists(branch):
     # expect exactly one line of output: the branch name
     return out.rstrip() == branch
 
+
 def findUpstreamBranchPoint(head = "HEAD"):
     branches = p4BranchesInGit()
     # map from depot-path to branch name
@@ -1037,6 +1117,7 @@ def findUpstreamBranchPoint(head = "HEAD"):
 
     return ["", settings]
 
+
 def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent=True):
     if not silent:
         print("Creating/updating branch(es) in %s based on origin branch(es)"
@@ -1084,6 +1165,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
         if update:
             system("git update-ref %s %s" % (remoteHead, originHead))
 
+
 def originP4BranchesExist():
         return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
 
@@ -1097,12 +1179,14 @@ def p4ParseNumericChangeRange(parts):
 
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
 
@@ -1180,6 +1264,7 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
     changes = sorted(changes)
     return changes
 
+
 def p4PathStartsWith(path, prefix):
     # This method tries to remedy a potential mixed-case issue:
     #
@@ -1192,6 +1277,7 @@ def p4PathStartsWith(path, prefix):
         return path.lower().startswith(prefix.lower())
     return path.startswith(prefix)
 
+
 def getClientSpec():
     """Look at the p4 client spec, create a View() object that contains
        all the mappings, and return it."""
@@ -1222,6 +1308,7 @@ def getClientSpec():
 
     return view
 
+
 def getClientRoot():
     """Grab the client directory."""
 
@@ -1235,6 +1322,7 @@ def getClientRoot():
 
     return entry["Root"]
 
+
 #
 # P4 wildcards are not allowed in filenames.  P4 complains
 # if you simply add them, but you can force it with "-f", in
@@ -1252,6 +1340,7 @@ def wildcard_decode(path):
                .replace("%25", "%")
     return path
 
+
 def wildcard_encode(path):
     # do % first to avoid double-encoding the %s introduced here
     path = path.replace("%", "%25") \
@@ -1260,10 +1349,12 @@ def wildcard_encode(path):
                .replace("@", "%40")
     return path
 
+
 def wildcard_present(path):
     m = re.search("[*#@%]", path)
     return m is not None
 
+
 class LargeFileSystem(object):
     """Base class for large file system support."""
 
@@ -1345,6 +1436,7 @@ def processContent(self, git_mode, relPath, contents):
                     sys.stderr.write("%s moved to large file system (%s)\n" % (relPath, localLargeFile))
         return (git_mode, contents)
 
+
 class MockLFS(LargeFileSystem):
     """Mock large file system for testing."""
 
@@ -1368,6 +1460,7 @@ def pushFile(self, localLargeFile):
             os.makedirs(remotePath)
         shutil.copyfile(localLargeFile, os.path.join(remotePath, os.path.basename(localLargeFile)))
 
+
 class GitLFS(LargeFileSystem):
     """Git LFS as backend for the git-p4 large file system.
        See https://git-lfs.github.com/ for details."""
@@ -1456,6 +1549,7 @@ def processContent(self, git_mode, relPath, contents):
         else:
             return LargeFileSystem.processContent(self, git_mode, relPath, contents)
 
+
 class Command:
     delete_actions = ( "delete", "move/delete", "purge" )
     add_actions = ( "add", "branch", "move/add" )
@@ -1471,6 +1565,7 @@ def ensure_value(self, attr, value):
             setattr(self, attr, value)
         return getattr(self, attr)
 
+
 class P4UserMap:
     def __init__(self):
         self.userMapFromPerforceServer = False
@@ -1541,6 +1636,7 @@ def loadUserMapFromCache(self):
         except IOError:
             self.getUserMapFromPerforceServer()
 
+
 class P4Submit(Command, P4UserMap):
 
     conflict_behavior_choices = ("ask", "skip", "quit")
@@ -2545,6 +2641,7 @@ def run(self, args):
 
         return True
 
+
 class View(object):
     """Represent a p4 view ("p4 help views"), and map files in a
        repo according to the view."""
@@ -2652,11 +2749,13 @@ def map_in_client(self, depot_path):
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
@@ -2885,7 +2984,6 @@ def encodeWithUTF8(self, path):
 
     # output one file from the P4 stream
     # - helper for streamP4Files
-
     def streamOneP4File(self, file, contents):
         file_path = file['depotFile']
         relPath = self.stripRepoPath(decode_path(file_path), self.branchPrefixes)
@@ -3692,7 +3790,6 @@ def importHeadRevision(self, revision):
             print("IO error details: {}".format(err))
             print(self.gitError.read())
 
-
     def importRevisions(self, args, branch_arg_given):
         changes = []
 
@@ -4016,6 +4113,7 @@ def run(self, args):
 
         return True
 
+
 class P4Rebase(Command):
     def __init__(self):
         Command.__init__(self)
@@ -4052,6 +4150,7 @@ def rebase(self):
         system("git diff-tree --stat --summary -M %s HEAD --" % oldHead)
         return True
 
+
 class P4Clone(P4Sync):
     def __init__(self):
         P4Sync.__init__(self)
@@ -4130,6 +4229,7 @@ def run(self, args):
 
         return True
 
+
 class P4Unshelve(Command):
     def __init__(self):
         Command.__init__(self)
@@ -4245,6 +4345,7 @@ def run(self, args):
 
         return True
 
+
 class P4Branches(Command):
     def __init__(self):
         Command.__init__(self)
@@ -4273,6 +4374,7 @@ def run(self, args):
             print("%s <= %s (%s)" % (branch, ",".join(settings["depot-paths"]), settings["change"]))
         return True
 
+
 class HelpFormatter(optparse.IndentedHelpFormatter):
     def __init__(self):
         optparse.IndentedHelpFormatter.__init__(self)
@@ -4283,6 +4385,7 @@ def format_description(self, description):
         else:
             return ""
 
+
 def printUsage(commands):
     print("usage: %s <command> [options]" % sys.argv[0])
     print("")
@@ -4291,6 +4394,7 @@ def printUsage(commands):
     print("Try %s <command> --help for command specific help." % sys.argv[0])
     print("")
 
+
 commands = {
     "submit" : P4Submit,
     "commit" : P4Submit,
@@ -4301,6 +4405,7 @@ def printUsage(commands):
     "unshelve" : P4Unshelve,
 }
 
+
 def main():
     if len(sys.argv[1:]) == 0:
         printUsage(commands.keys())
-- 
2.34.1

