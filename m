Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369ABC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244678AbiBJQrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:47:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244202AbiBJQq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:46:59 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2047.outbound.protection.outlook.com [40.107.96.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177DC192
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:46:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klvjXgfL7rG/kQEEBfp+r89EFkpZWUXhweRp/ghr6GQadPFyEY7hCmyYZd6dzQUkAdW9//8R7zDLMP9AD1boSDhxaCmghutTCAvpBsm4FOUp779A9zfjOCRQ0izW439HXTgOOjPFmWyPqzV/ejQdXTs2DTSdD3pUNlQZffd0BvmABBFy+wM7MQiM7N8iiy1vflwH1xVbRPMNkq4mtHaCfvoGZv5jBnYf2mnlSb+WbtG6CRvcUAHPoh+NVZNZVXQFIRpfRUVpV4IhPjM7Rj147PP1HFCZS97Xpf8qLNuXJiqenGqgQEMi5+3I1E8oJrdczNqVcsJMeXsKW9SgHgLZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXiYD7F++yb3v9qzmjSYt+d7HqRldWbpj8Tuy6Jc+3U=;
 b=HqIUKeR0+cPpewTSwIw4AZbW/Sb2awgFtrQ/D/EUGjvNbxUZbb6aou9xRZIAZGEYIvRT/Wx5P8iGQgrgjsqe1OTQsp+2GvLC+sDye0jfk6T5qIwm3HEKkPYPvyXLf5cccUug7XKDJkcT0BBClwJt2ZHOYju47K/ij8ojm0pB1zO1iPyYjA6aAEQgRgplknuDDpmF5sTWIwXLRwR7AF+7HbgmGmUfPk/yyUz4/IALk2pehGmBv6Ol53fSCC8ed1UTW2d56o6V5iGlkV/PljI8bYUYVpvWYDPz2016Xp7gMVpowaUETDmLwetUDkvOoE3JU+s3Plr7y6o3ve9F5f1qEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXiYD7F++yb3v9qzmjSYt+d7HqRldWbpj8Tuy6Jc+3U=;
 b=WVGCywOImSby2EWa8+we5w3UkCSRJJHcz9Wt8+NORF59R4l72sYaHuVnt9YJBDycyJUbFtilQqVEfiFkoQSK7A71PBqgb2hfWuAT+lch2KTVmKF6GDtAnHI5snnCoqZ70/AvewfoOHG3/zxo661SMrfKlfaYMPu3x+RNTkeq08tVxJ9qrMgqpg6Bp6sllFF3gdyS2fJxYxh/o5P2DbPHvsdFjG5JmN0JEi2akak3LmZsfWRLr6KXuquTKMWwHmyPmm2qYGMkDRUuwNNnYw8Ra42IK/Ip/wYZ6NgaqqkgOfHSeXujPYdCP9zQ+ZLBYi2zbKQ2ITfSvcr2MiOwi546Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BN6PR12MB1362.namprd12.prod.outlook.com (2603:10b6:404:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:46:56 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:46:56 +0000
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
Subject: [PATCH v4 01/22] git-p4: add blank lines between functions and class definitions
Date:   Thu, 10 Feb 2022 16:46:06 +0000
Message-Id: <20220210164627.279520-2-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 46eceed9-3545-4b99-673b-08d9ecb4f2bd
X-MS-TrafficTypeDiagnostic: BN6PR12MB1362:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1362BFFA1A67073AA60945A7C82F9@BN6PR12MB1362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:218;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ArjWoCOIZ1Qp3yQn7fPrtOo/cwNFg5DMZugtZ4rfT9d8w7H82xNL42nDrDIVt7EtRiuC4lt4dorQKnqEbgWSWYTfyFNxA4oDc8XxoFu12vpo3tKjC1+m6q1/FxIZuAixVXojFbL75OuAJvXYyR8x6Uyhs0ZbczeAcO5DAhcOKLzlcfOQlmBzPdaiPRXLpiwKAb/ZH6zu1Az8zwsUafbXv7J5RAp9/sdFDLn2Z6ACraJRLvKqaiH8GKosdVhFHLVrOdBAlWCwerTTXvbB0iblzmMLHkG0WN7XkGfhh5vGXnopQlx6Ca4vkXduyz6sBhndY89tnsDjwpf6GjN3swhXgsxRjUEw1oyEcQF8hi0+/l/edHPhyPqZCnUAAt/qhcLUneEVqwuX4x/C4xSJFc7rciqj3OtCHW7NGJvpb9AfHyOvQMQkMK353f9Ff/CVY9QHBCKxVrzzCSACWEdsY1dIeT8vTURH2ZsfN8cpO9joShZv864Nm/SDuTZ1OyfPNSDZJ8zZ2ArJavIfpCL7MFrfGMkPN11JbuMJXg9qn3FONzMw50UN1HdG3KIgDadm/+nP0M7ZPZEmZA8tJSKbgMlznPPR6OpyFI6gTIEXrdrXpdRY2nDMgw2iKNaV1FmmLA1OvZ+hnavechZOrtf6n9/nvHOKpaZvjFRCFcBrowYKdnQ+SDv4nrpsSjSzqXgIsewRf+vBbxBbOLWhIj68409IfvcFtVKF0J3hmNO9KmwS1FGPJrOYuYayttkXvDHHLR3CH0IA1an4qdEiEpDl9r6k6v8SvxsSH6ys0IbL2ck9YZc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6486002)(966005)(7416002)(2906002)(8676002)(66946007)(52116002)(6506007)(8936002)(83380400001)(2616005)(30864003)(38100700002)(38350700002)(4326008)(1076003)(107886003)(508600001)(66556008)(66476007)(5660300002)(6512007)(36756003)(55236004)(6666004)(316002)(110136005)(54906003)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9yrfbKWPGv7AB68U/RuWoqX84d1DBTxbOXc6WljLsxyaJ5ZtkyP/TCUFzmjK?=
 =?us-ascii?Q?0xAdk7zRR4PUACsBHQeJ+D/p6mR7OnAxIFibNEFTUpibMuzecNI+CocTWoy2?=
 =?us-ascii?Q?qrWnlmCk/JF928xvHcgiDE8uA22Fu5/XMUVungZah2O0VPpnlztb1C61XKHs?=
 =?us-ascii?Q?jAuqCPtesorp6kOdwteK3lXx1Ks9b3tsoA73vv9xgIPWsoxEXAUYg+1BIv3d?=
 =?us-ascii?Q?fPE3bjHANWmXpG9RYeQZxVf3StebSZUCBTC1u513OxKJtTPsCbPryjJ7BVHL?=
 =?us-ascii?Q?13icU8qXiJbQ3nAiY8SCk5yvbNQ2bAMnCayavZMiagEg5skKZcoGvPDPtaf6?=
 =?us-ascii?Q?dQu8691+oLa57pBKslFB3y8Xey67p8E1mYZbLejtrhUwNQx8eGAq4DEePjQ4?=
 =?us-ascii?Q?EyA1uA3OJlB6V8pHCqfGBOiS4683SloKpGVKolyTn0fRKsO+/tslqpuErMlt?=
 =?us-ascii?Q?2IWmG5uDROiwMjGNjWGJgSufkUYegIh58VqPTcWg4Gy/uoj1Pv66Xg++8qrp?=
 =?us-ascii?Q?ISIsbznS/Mm7E1tNPcrG0a4xqMpwYJ76tU/vZnyGrRlEFPaOkoFp5GVCBtEq?=
 =?us-ascii?Q?W5VVsbIKpyZ4z0Kc/FpSMNxciyKdw96v+N+QuHMUBHFr3ZcIEyH2s4tFwR0U?=
 =?us-ascii?Q?RjZ5y74e7JvKplulTZ/WX5vix0jqUuRSG6OX28NyOZPpWACnxKsp6WGOziN3?=
 =?us-ascii?Q?8jWoa94tI2hFsIs4n0mkVvX/Em1n7guVc8cqLF8j6j0PhCnx9vSGO+QTV1FG?=
 =?us-ascii?Q?u0jdsy2oHi/qI8x0/rh18uIzPDrzCnm0yPGCVkWFd1vJ7LJRyyf5JiQjBieP?=
 =?us-ascii?Q?ufcI9Qn1gML51PjFIBuXoOwi4VTam0HbfqpK/rf+iz+L96nUlpxN1vM6DHi0?=
 =?us-ascii?Q?lKGzbZXcy7qkUhtKzL8GLevySNfr5WYO9Rm5rchb+hDjET4WLcwa4apFOHMQ?=
 =?us-ascii?Q?7x4aVuepBa9M0Ca3hUqFZjPjqIQNDE2O3Rrl3OQ3yZu3G/7/6s+rPZz6lWQQ?=
 =?us-ascii?Q?y5vu9lW9Jn7K8IiNFSel1mF/eBb/Rpaqeq5V5uOz4A+sCBD5dxwGQmCx5/y9?=
 =?us-ascii?Q?955Exjk4uHey2ihvmrDaeENdwM5zfMnbNEAbP0+du2IgeR7n3CrWTwd73ROL?=
 =?us-ascii?Q?iWbmeDiKKfXLd8H/UKcaIFEY4Nx47Y4sxV7yGeaXTcIkqBTQaJMyjY/E8ios?=
 =?us-ascii?Q?6SuZPiFaXPj95AO1Te9NTAhniE58NLmVWf4b4Rw0+UeexZtfiNprOxRx6r7S?=
 =?us-ascii?Q?9pnYEoOsZ3SwBhT91rAEorZ8TTcqQ86cyNtdhRmfLORUDT/AxvThaosFZXoP?=
 =?us-ascii?Q?XhmjXuonNVWf5XNKIBkdD+1kiygsDVNlW+8hy6BSm+U+T7njt+/if1u5LJrh?=
 =?us-ascii?Q?pb020jqJTUbNhZny+3VyI2YP4XwEZs5Ox1mNUjJY15pyDjjESDuw8PfdiW5k?=
 =?us-ascii?Q?pMKMtSACsE94rptFffhCLNqzIvy9RT6LhTyvh2w0hIisfqQ/S4g2/Znk6NCl?=
 =?us-ascii?Q?a/84ECT4CCadbNYznofGsvlYFWcxlL3/qsKttFkSVwp/us4aOw4VWRRcmApw?=
 =?us-ascii?Q?WLr3H6c38w8sJukx7yI79BMiDhaxzN1cTLfYaOojvdM+QzftFOPaZY3y1gtx?=
 =?us-ascii?Q?nLmH8SkXJbuiS+Wd/VR/KK0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46eceed9-3545-4b99-673b-08d9ecb4f2bd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:46:56.2434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aleKoGl6BWOR/BK8O8S0kQ5Y9hidPTs4F6db620tLS3u2uuNNNJ42L1P0gBxzNnfWXakeorIyFhMxhS8aZQmhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1362
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
index a9b1f90441..265182b088 100755
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
     args = ['git', 'hook', 'run', '--ignore-missing', cmd]
@@ -227,6 +239,7 @@ def run_git_hook(cmd, param=[]):
             args.append(p)
     return subprocess.call(args) == 0
 
+
 def write_pipe(c, stdin, *k, **kw):
     if verbose:
         sys.stderr.write('Writing pipe: {}\n'.format(' '.join(c)))
@@ -240,12 +253,14 @@ def write_pipe(c, stdin, *k, **kw):
 
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
@@ -259,6 +274,7 @@ def read_pipe_full(c, *k, **kw):
     (out, err) = p.communicate()
     return (p.returncode, out, decode_text_stream(err))
 
+
 def read_pipe(c, ignore_error=False, raw=False, *k, **kw):
     """ Read output from  command. Returns the output text on
         success. On failure, terminates execution, unless
@@ -276,6 +292,7 @@ def read_pipe(c, ignore_error=False, raw=False, *k, **kw):
         out = decode_text_stream(out)
     return out
 
+
 def read_pipe_text(c, *k, **kw):
     """ Read output from a command with trailing whitespace stripped.
         On error, returns None.
@@ -286,10 +303,12 @@ def read_pipe_text(c, *k, **kw):
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
@@ -303,11 +322,13 @@ def read_pipe_lines(c, raw=False, *k, **kw):
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
@@ -317,6 +338,7 @@ def p4_has_command(cmd):
     p.communicate()
     return p.returncode == 0
 
+
 def p4_has_move_command():
     """See if the move command exists, that it supports -k, and that
        it has not been administratively disabled.  The arguments
@@ -337,6 +359,7 @@ def p4_has_move_command():
     # assume it failed because @... was invalid changelist
     return True
 
+
 def system(cmd, ignore_error=False, *k, **kw):
     if verbose:
         sys.stderr.write("executing {}\n".format(
@@ -347,6 +370,7 @@ def system(cmd, ignore_error=False, *k, **kw):
 
     return retcode
 
+
 def p4_system(cmd, *k, **kw):
     """Specifically invoke p4 as the system command. """
     real_cmd = p4_build_cmd(cmd)
@@ -354,9 +378,11 @@ def p4_system(cmd, *k, **kw):
     if retcode:
         raise subprocess.CalledProcessError(retcode, real_cmd)
 
+
 def die_bad_access(s):
     die("failure accessing depot: {0}".format(s.rstrip()))
 
+
 def p4_check_access(min_expiration=1):
     """ Check if we can access Perforce - account still logged in
     """
@@ -402,7 +428,10 @@ def p4_check_access(min_expiration=1):
     else:
         die_bad_access("unknown error code {0}".format(code))
 
+
 _p4_version_string = None
+
+
 def p4_version_string():
     """Read the version string, showing just the last line, which
        hopefully is the interesting version bit.
@@ -418,12 +447,15 @@ def p4_version_string():
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
@@ -431,29 +463,37 @@ def p4_add(f):
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
@@ -482,6 +522,7 @@ def p4_describe(change, shelved=False):
 
     return d
 
+
 #
 # Canonicalize the p4 type and return a tuple of the
 # base type, plus any modifiers.  See "p4 help filetypes"
@@ -517,6 +558,7 @@ def split_p4_type(p4type):
         mods = s[1]
     return (base, mods)
 
+
 #
 # return the raw p4 type of a file (text, text+ko, etc)
 #
@@ -524,6 +566,7 @@ def p4_type(f):
     results = p4CmdList(["fstat", "-T", "headType", wildcard_encode(f)])
     return results[0]['headType']
 
+
 #
 # Given a type base and modifier, return a regexp matching
 # the keywords that can be expanded in the file
@@ -539,6 +582,7 @@ def p4_keywords_regexp_for_type(base, type_mods):
     else:
         return None
 
+
 #
 # Given a file, return a regexp matching the possible
 # RCS keywords that will be expanded, or None for files
@@ -551,6 +595,7 @@ def p4_keywords_regexp_for_file(file):
         (type_base, type_mods) = split_p4_type(p4_type(file))
         return p4_keywords_regexp_for_type(type_base, type_mods)
 
+
 def setP4ExecBit(file, mode):
     # Reopens an already open file and changes the execute bit to match
     # the execute bit setting in the passed in mode.
@@ -566,6 +611,7 @@ def setP4ExecBit(file, mode):
 
     p4_reopen(p4Type, file)
 
+
 def getP4OpenedType(file):
     # Returns the perforce file type for the given file.
 
@@ -576,6 +622,7 @@ def getP4OpenedType(file):
     else:
         die("Could not determine file type for %s (result: '%s')" % (file, result))
 
+
 # Return the set of all p4 labels
 def getP4Labels(depotPaths):
     labels = set()
@@ -588,6 +635,7 @@ def getP4Labels(depotPaths):
 
     return labels
 
+
 # Return the set of all git tags
 def getGitTags():
     gitTags = set()
@@ -596,8 +644,10 @@ def getGitTags():
         gitTags.add(tag)
     return gitTags
 
+
 _diff_tree_pattern = None
 
+
 def parseDiffTreeEntry(entry):
     """Parses a single diff tree entry into its component elements.
 
@@ -635,41 +685,52 @@ def parseDiffTreeEntry(entry):
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
 
@@ -746,6 +807,7 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
 
     return result
 
+
 def p4Cmd(cmd, *k, **kw):
     list = p4CmdList(cmd, *k, **kw)
     result = {}
@@ -753,6 +815,7 @@ def p4Cmd(cmd, *k, **kw):
         result.update(entry)
     return result;
 
+
 def p4Where(depotPath):
     if not depotPath.endswith("/"):
         depotPath += "/"
@@ -789,20 +852,25 @@ def p4Where(depotPath):
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
 
@@ -817,6 +885,7 @@ def extractLogMessageFromGitCommit(commit):
        logMessage += log
     return logMessage
 
+
 def extractSettingsGitLog(log):
     values = {}
     for line in log.split("\n"):
@@ -842,19 +911,24 @@ def extractSettingsGitLog(log):
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
@@ -865,6 +939,7 @@ def gitConfig(key, typeSpecifier=None):
         _gitConfig[key] = s.strip()
     return _gitConfig[key]
 
+
 def gitConfigBool(key):
     """Return a bool, using git config --bool.  It is True only if the
        variable is set to true, and False if set to false or not present
@@ -874,6 +949,7 @@ def gitConfigBool(key):
         _gitConfig[key] = gitConfig(key, '--bool') == "true"
     return _gitConfig[key]
 
+
 def gitConfigInt(key):
     if key not in _gitConfig:
         cmd = [ "git", "config", "--int", key ]
@@ -885,6 +961,7 @@ def gitConfigInt(key):
             _gitConfig[key] = None
     return _gitConfig[key]
 
+
 def gitConfigList(key):
     if key not in _gitConfig:
         s = read_pipe(["git", "config", "--get-all", key], ignore_error=True)
@@ -893,6 +970,7 @@ def gitConfigList(key):
             _gitConfig[key] = []
     return _gitConfig[key]
 
+
 def p4BranchesInGit(branchesAreInRemotes=True):
     """Find all the branches whose names start with "p4/", looking
        in remotes or heads as specified by the argument.  Return
@@ -925,6 +1003,7 @@ def p4BranchesInGit(branchesAreInRemotes=True):
 
     return branches
 
+
 def branch_exists(branch):
     """Make sure that the given ref name really exists."""
 
@@ -937,6 +1016,7 @@ def branch_exists(branch):
     # expect exactly one line of output: the branch name
     return out.rstrip() == branch
 
+
 def findUpstreamBranchPoint(head = "HEAD"):
     branches = p4BranchesInGit()
     # map from depot-path to branch name
@@ -964,6 +1044,7 @@ def findUpstreamBranchPoint(head = "HEAD"):
 
     return ["", settings]
 
+
 def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent=True):
     if not silent:
         print("Creating/updating branch(es) in %s based on origin branch(es)"
@@ -1011,6 +1092,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
         if update:
             system(["git", "update-ref", remoteHead, originHead])
 
+
 def originP4BranchesExist():
         return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
 
@@ -1024,12 +1106,14 @@ def p4ParseNumericChangeRange(parts):
 
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
 
@@ -1107,6 +1191,7 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
     changes = sorted(changes)
     return changes
 
+
 def p4PathStartsWith(path, prefix):
     # This method tries to remedy a potential mixed-case issue:
     #
@@ -1119,6 +1204,7 @@ def p4PathStartsWith(path, prefix):
         return path.lower().startswith(prefix.lower())
     return path.startswith(prefix)
 
+
 def getClientSpec():
     """Look at the p4 client spec, create a View() object that contains
        all the mappings, and return it."""
@@ -1149,6 +1235,7 @@ def getClientSpec():
 
     return view
 
+
 def getClientRoot():
     """Grab the client directory."""
 
@@ -1162,6 +1249,7 @@ def getClientRoot():
 
     return entry["Root"]
 
+
 #
 # P4 wildcards are not allowed in filenames.  P4 complains
 # if you simply add them, but you can force it with "-f", in
@@ -1179,6 +1267,7 @@ def wildcard_decode(path):
                .replace("%25", "%")
     return path
 
+
 def wildcard_encode(path):
     # do % first to avoid double-encoding the %s introduced here
     path = path.replace("%", "%25") \
@@ -1187,10 +1276,12 @@ def wildcard_encode(path):
                .replace("@", "%40")
     return path
 
+
 def wildcard_present(path):
     m = re.search("[*#@%]", path)
     return m is not None
 
+
 class LargeFileSystem(object):
     """Base class for large file system support."""
 
@@ -1272,6 +1363,7 @@ def processContent(self, git_mode, relPath, contents):
                     sys.stderr.write("%s moved to large file system (%s)\n" % (relPath, localLargeFile))
         return (git_mode, contents)
 
+
 class MockLFS(LargeFileSystem):
     """Mock large file system for testing."""
 
@@ -1295,6 +1387,7 @@ def pushFile(self, localLargeFile):
             os.makedirs(remotePath)
         shutil.copyfile(localLargeFile, os.path.join(remotePath, os.path.basename(localLargeFile)))
 
+
 class GitLFS(LargeFileSystem):
     """Git LFS as backend for the git-p4 large file system.
        See https://git-lfs.github.com/ for details."""
@@ -1383,6 +1476,7 @@ def processContent(self, git_mode, relPath, contents):
         else:
             return LargeFileSystem.processContent(self, git_mode, relPath, contents)
 
+
 class Command:
     delete_actions = ( "delete", "move/delete", "purge" )
     add_actions = ( "add", "branch", "move/add" )
@@ -1398,6 +1492,7 @@ def ensure_value(self, attr, value):
             setattr(self, attr, value)
         return getattr(self, attr)
 
+
 class P4UserMap:
     def __init__(self):
         self.userMapFromPerforceServer = False
@@ -1468,6 +1563,7 @@ def loadUserMapFromCache(self):
         except IOError:
             self.getUserMapFromPerforceServer()
 
+
 class P4Submit(Command, P4UserMap):
 
     conflict_behavior_choices = ("ask", "skip", "quit")
@@ -2473,6 +2569,7 @@ def run(self, args):
 
         return True
 
+
 class View(object):
     """Represent a p4 view ("p4 help views"), and map files in a
        repo according to the view."""
@@ -2580,11 +2677,13 @@ def map_in_client(self, depot_path):
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
@@ -3942,6 +4041,7 @@ def run(self, args):
 
         return True
 
+
 class P4Rebase(Command):
     def __init__(self):
         Command.__init__(self)
@@ -3979,6 +4079,7 @@ def rebase(self):
             "HEAD", "--"])
         return True
 
+
 class P4Clone(P4Sync):
     def __init__(self):
         P4Sync.__init__(self)
@@ -4057,6 +4158,7 @@ def run(self, args):
 
         return True
 
+
 class P4Unshelve(Command):
     def __init__(self):
         Command.__init__(self)
@@ -4172,6 +4274,7 @@ def run(self, args):
 
         return True
 
+
 class P4Branches(Command):
     def __init__(self):
         Command.__init__(self)
@@ -4197,6 +4300,7 @@ def run(self, args):
             print("%s <= %s (%s)" % (branch, ",".join(settings["depot-paths"]), settings["change"]))
         return True
 
+
 class HelpFormatter(optparse.IndentedHelpFormatter):
     def __init__(self):
         optparse.IndentedHelpFormatter.__init__(self)
@@ -4207,6 +4311,7 @@ def format_description(self, description):
         else:
             return ""
 
+
 def printUsage(commands):
     print("usage: %s <command> [options]" % sys.argv[0])
     print("")
@@ -4215,6 +4320,7 @@ def printUsage(commands):
     print("Try %s <command> --help for command specific help." % sys.argv[0])
     print("")
 
+
 commands = {
     "submit" : P4Submit,
     "commit" : P4Submit,
@@ -4225,6 +4331,7 @@ def printUsage(commands):
     "unshelve" : P4Unshelve,
 }
 
+
 def main():
     if len(sys.argv[1:]) == 0:
         printUsage(commands.keys())
-- 
2.35.GIT

