Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF50C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 13:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353721AbiALNrj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:47:39 -0500
Received: from mail-dm6nam12on2054.outbound.protection.outlook.com ([40.107.243.54]:16488
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353691AbiALNrS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 08:47:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlLXPeE3o/gl5x8I1sT0VJ16akE59bVEDUTj5boUujJXY1jJOZ27yZImNM91u2rVFSyK6C1VEZhniUy0fBYhAxi8psaIRKBf/wA9UgSoyXqCYxIPs3pC0DA7hl/dEPw8sXFoZACmQVnSTF621nqMeTb2ruDcg3k1uupV99nTzYWy/OmcOp+KJQcHfEE4ComZPb/MkNzgelB7tkS70bvdogpnhrlEfhiGzL8qAHSk6NzejcfkQh6hIWWGHUwvSNfBHHDfp1eKw83kdxZoBy6LssbkzSsoMCtBFzL+ZzoIrCfpVd0uJ5Y4mlNKZsahvsljdUtN5O1sKflvPPuEFeVl4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mMYjSyquxfF8XWiPNx7fnSquZ/zjOy0cQGD7voEykU=;
 b=CTQZY59OzGa/NNVND5AbjWi9YOkJ4quv8mDXQnJdnpM0BUH+lurC5e6J+R0LKCzkuU7kp2MUiqgnPj2p96JYKaTRAn0gooi9vyAkt3wAZYCPqws/nfI+XYJLIdT++XL63nUAnQRG5HG2GN0A9vwgFHObsYO8lX+9twQdlzyCIioWFL5+uYXA4rw1WFpYd2rJGX/XIAftE3lBks/zuDbE9+ddKBUlGRSDG2dlo/qRXqdt3M2W92Axdivcz/jX1MFKcmuW01+2d9HfNk5CrlBZ2iBTdU5a0Bh+Fvj2WHJ86VJAXXQERlrnnlEBdZ4AJfqEvvh66NaWPwadvnxhwMUBJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mMYjSyquxfF8XWiPNx7fnSquZ/zjOy0cQGD7voEykU=;
 b=dmppT0FJ6zzvhie0FISmz+FUVwSHpMFuMEcHpSzqu3vRr91Ww7wA5GKg8horZkSH0Cmmouvrcz+68jNRnPP7l5gRJuBKcmWbaajsaAKWPO3KKqhZq6CowM021qHluOml+SRDT+mNK/I4g8ngmgNYm3Ro+MMWRGavDZjSRDIJxWb1ZAJaKqKOCitaA39t8OrBz31A4gJccFQkAltByHlWqdR3sozOjgRjnNXblPeFf0QFK3AvnKLSMOBZ7WFXaKqm2I7E40wLGyePgH82sCmLre5JjMA9dS5RVdrYf+Bt3gfAGoEAqF684Mvn5iM+/hxXy5GJmo9YG28bZiTRnhI6hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 12 Jan
 2022 13:47:16 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 13:47:16 +0000
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
Subject: [PATCH 04/20] git-p4: improve consistency of docstring formatting
Date:   Wed, 12 Jan 2022 13:46:19 +0000
Message-Id: <20220112134635.177877-5-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112134635.177877-1-jholdsworth@nvidia.com>
References: <20220112134635.177877-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31e4ae10-4257-4c5e-6c77-08d9d5d20b87
X-MS-TrafficTypeDiagnostic: CH2PR12MB4279:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB42793B4342807B98AD4E0AD0C8529@CH2PR12MB4279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JcKyqfzhymAHzStDRvtLT/s6HDcie8zFnQ4cMPxu/GFUviWnX42xu6JDLyful/X1QSuTdb7MK3coJscJg/C62qacVHlRasmoldmW2hEyZ20tUbxSeazQYo2rZCQ3iSCmv4caMzdqYDiVkWhNWyXMdXKmoFeTGM3IfE3sLq4XxS9HZ4m7K7bJ7ym6sZp2htqD1uZcKlhS6+FP562yiVF4csqWcJK77MNQAGWw2BpnHRpRB/bzv184vHd5E53RqAcEXiEyav8r6Ez+dcdJ0RHEiWa+5StF2pxfagyGn/zPlRUJ5TiY6m6gPNJMsLrRWOBAXKv0aTeoBIOxcqT7uRmhGad/EpzH6k1B3EHJggDl9H3rMHnyumn07sVlpCreRmQgfJIi74dXsPps1v3d5ATqHgJ2+HzggtP62BkVazB6OQ/tXARtx60eWTrH0a/AB01mdxz8de829wZ1K1fhgiO8rjOxpptd8a93D44ILLupp+0kkZTWE9362zvEj7i9AaFl8GMouarxYVHQWp8/ZoXVG+41lu3ZjQX8f9DPLaRJYftNZxBmGBDP8KJP1gen2Li7fPhUdd2I9201Z6I92jgM34O0X4+9HJMKkHOzPZBJcI8DzG52mkvVE8pBMnlfds6pjrbqvi9Ld8sTkM6QgjdJJtYI7u+1W+MXLmeVlTpcSvAsmoYYmcpkO2nN7c/VFJSTbQdSKhq2sXU9ZhKMuGUBtlbMjEQ4Ut24XWRONPe3uRe8tyFQa27o6j2hs/ja78Hp+NYKHt7JZ2rfZvHMJSK5YWXk+TUWdXq/tFJ46EplWoVhOLOPCn9rm24taYkmOMVa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(30864003)(1076003)(55236004)(7416002)(4326008)(38100700002)(38350700002)(508600001)(6506007)(86362001)(54906003)(6486002)(26005)(110136005)(6512007)(186003)(8676002)(2616005)(5660300002)(66476007)(83380400001)(8936002)(2906002)(66946007)(36756003)(66556008)(966005)(107886003)(316002)(52116002)(460985005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9IXBec02ezBIBbNrHn4mixCdxxy4rAgfJS3DL6WB3LZEUh7x3rAo22eU9sAi?=
 =?us-ascii?Q?/6hKbQ2wYiXcr1gIKO3T1nHDGOpSe/RkGdglt9YDoRu6HlWn5ZCaunsS3CCX?=
 =?us-ascii?Q?Ocb3lj/7/clqQRVegKF1NXvai5lBfjMnXhGDr6Tm4GWp2DZeNFhC3EKcRKe0?=
 =?us-ascii?Q?SrYlqm3rN2VRvfdBfDlNByrRKqJ2+fD9h3HRJi6iC0T6xynp1PqjNzAYsepl?=
 =?us-ascii?Q?7QsNyvjgY3UM1f0+ObAQ1nIR6eHJosdyOKQHWwIdMz+Je/iF4Ca3bThByiUt?=
 =?us-ascii?Q?V+U2tK0ALPxHADFU9UvWWLwVd6T+fm5X3ibfq23w4jYR7aHWsXnK/+Yz5AR0?=
 =?us-ascii?Q?+KrORyLYonk8oA+QluRvfdTf8a2v84Xj9UcRmtBo1HazTFbwCemAGktiGFgw?=
 =?us-ascii?Q?dJEK5IhnQtBxiO3erqtCpePeLIIJBxJOEQipJSpDF0021MlDZk5rB4wxef51?=
 =?us-ascii?Q?N7LdvGITkK5+V28teQsB1BqVkUf+r7g5OO3OmfYm0+338ln8QuP8dFRtUW9x?=
 =?us-ascii?Q?fnghx2dMsTt2d9ojA994DlcxtqZ8rRoJzljcRLAWkYnmyTJHMU6hyJQ2f6x9?=
 =?us-ascii?Q?Y3ybsW/QwZPjQNjOnzWPorreaJwRsk2A7N0N40FuGQgGyNpmpSWkSl+RkXm0?=
 =?us-ascii?Q?q52YiH5CW+4irF88+gttKITwQvgyAgPhlAv861YP4DztG0VIsmHOyF6Tu8nc?=
 =?us-ascii?Q?o4MPwhHjA2tGh9Ba2QkAZt16o69BZ/Bmw4K7QxEW5IyzJC1NPa32QF3tOHyb?=
 =?us-ascii?Q?vS/ebh2tWvEhJMVpqBuJ7Zu7WYYjSK/ClSMgxtUdE7EISqGCnahdXCZ/vBzo?=
 =?us-ascii?Q?AMcg2AnDHWn9Z/QDkk78bVePyjwl/JbVK1SubZwPJb7YHqmWU24eZ7OBrRQV?=
 =?us-ascii?Q?SzK/gzwHMrUvI7+GQJgbXy2hxQ18iNIY9bA4+edBbQokklpcezAtZF6A3RSf?=
 =?us-ascii?Q?6L17r3KNiL2Ms5CsiAlBp/8bYrc4BrGF1KZcaRgcfEp0fC1YzaTKEQO8bNDQ?=
 =?us-ascii?Q?BVopna4p1brID7TNcshOSqmF6dCm2Tcb0I4ucmW/azawDjKH8gGvBOS9Lq99?=
 =?us-ascii?Q?iasWfHk2ntVVuxIqd6yClRGIWiWDGlb1/zlOAO9U74ko4YUwcAv3EqU+QqZy?=
 =?us-ascii?Q?96GRBKmcejAfozFzrFkU1Ztb3XuKGdrSHbcgEKKlPgla3fKOPG082GqOWM+c?=
 =?us-ascii?Q?8ZPd6nObWCYujH+/lQQSzTmSYQLCU6Jbn+qivJEHMSIdBFecPRwGbgQRNWfN?=
 =?us-ascii?Q?ig3GPC5eyhcDmKjnIJ3hKu+L+QEuNvKHiIOyLyHaH1XAaEc/oFjDPggPyaIM?=
 =?us-ascii?Q?4hdy52npFlKp8U076+BP/7DqYQIFzbg92ewcJlO+La+ix7d4T6IrPx5oJG/6?=
 =?us-ascii?Q?cVfx+CcoZU7p2DT4FOw8n0Ot9nrO4w19anUtc15as7+AWQblDvzvnr8nwKch?=
 =?us-ascii?Q?v5GnHG2CKNPhEqZkqpazLbKF1k27Cai96vsxNG4T83pdiTdbzU+DV42raFYO?=
 =?us-ascii?Q?usXdnyLntwk7ut983p9Uq2sRKXoXK5GCq5sc0IWCuG5xHfep4Zh+n9gxiIZG?=
 =?us-ascii?Q?YXjG1BkXuiiSHcW7XbmkpM8busH07KVmJaKKQiq8/4F6RdrizrLP+0OQT1oc?=
 =?us-ascii?Q?Hu70fNT+EoNj/RByJS8grE0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e4ae10-4257-4c5e-6c77-08d9d5d20b87
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:47:16.4627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnzoQZS9imZxTD5Fw2PTdEA4iYfFOR/ioxoQtAnF2eT1N02qrd2zHZHgo9tcRTOpAGrlexnVCDaOwFFTrlQaoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch attempts to improve the consistency of the docstrings by
making the following changes:

  - Rewraps all docstrings to a 79-character column limit.
  - Adds a full stop at the end of every docstring.
  - Removes any spaces after the opening triple-quotes of all
    docstrings.
  - Sets the hanging indent of multi-line docstrings to 3-spaces.
  - Ensures that the closing triple-quotes of multi-line docstrings are
    always on a new line indented by a 3-space indent.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 309 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 167 insertions(+), 142 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 5fb3e09875..93f4ec843f 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -61,9 +61,9 @@
 
 
 def format_size_human_readable(num):
-    """ Returns a number of units (typically bytes) formatted as a human-readable
-        string.
-    """
+    """Returns a number of units (typically bytes) formatted as a
+       human-readable string.
+       """
     if num < 1024:
         return '{:d} B'.format(num)
     for unit in ["Ki", "Mi", "Gi", "Ti", "Pi", "Ei", "Zi"]:
@@ -76,10 +76,10 @@ def format_size_human_readable(num):
 def p4_build_cmd(cmd):
     """Build a suitable p4 command line.
 
-    This consolidates building and returning a p4 command line into one
-    location. It means that hooking into the environment, or other configuration
-    can be done more easily.
-    """
+       This consolidates building and returning a p4 command line into one
+       location. It means that hooking into the environment, or other
+       configuration can be done more easily.
+       """
     real_cmd = ["p4"]
 
     user = gitConfig("git-p4.user")
@@ -125,9 +125,9 @@ def p4_build_cmd(cmd):
 
 
 def git_dir(path):
-    """ Return TRUE if the given path is a git directory (/path/to/dir/.git).
-        This won't automatically add ".git" to a directory.
-    """
+    """Return TRUE if the given path is a git directory (/path/to/dir/.git).
+       This won't automatically add ".git" to a directory.
+       """
     d = read_pipe(["git", "--git-dir", path, "rev-parse", "--git-dir"], True).strip()
     if not d or len(d) == 0:
         return None
@@ -136,20 +136,18 @@ def git_dir(path):
 
 
 def chdir(path, is_client_path=False):
-    """Do chdir to the given path, and set the PWD environment
-       variable for use by P4.  It does not look at getcwd() output.
-       Since we're not using the shell, it is necessary to set the
-       PWD environment variable explicitly.
-
-       Normally, expand the path to force it to be absolute.  This
-       addresses the use of relative path names inside P4 settings,
-       e.g. P4CONFIG=.p4config.  P4 does not simply open the filename
-       as given; it looks for .p4config using PWD.
-
-       If is_client_path, the path was handed to us directly by p4,
-       and may be a symbolic link.  Do not call os.getcwd() in this
-       case, because it will cause p4 to think that PWD is not inside
-       the client path.
+    """Do chdir to the given path, and set the PWD environment variable for use
+       by P4.  It does not look at getcwd() output.  Since we're not using the
+       shell, it is necessary to set the PWD environment variable explicitly.
+
+       Normally, expand the path to force it to be absolute.  This addresses
+       the use of relative path names inside P4 settings, e.g.
+       P4CONFIG=.p4config.  P4 does not simply open the filename as given; it
+       looks for .p4config using PWD.
+
+       If is_client_path, the path was handed to us directly by p4, and may be
+       a symbolic link.  Do not call os.getcwd() in this case, because it will
+       cause p4 to think that PWD is not inside the client path.
        """
 
     os.chdir(path)
@@ -170,9 +168,9 @@ def calcDiskFree():
 
 
 def die(msg):
-    """ Terminate execution. Make sure that any running child processes have been wait()ed for before
-        calling this.
-    """
+    """Terminate execution. Make sure that any running child processes have
+       been wait()ed for before calling this.
+       """
     if verbose:
         raise Exception(msg)
     else:
@@ -181,11 +179,11 @@ def die(msg):
 
 
 def prompt(prompt_text):
-    """ Prompt the user to choose one of the choices
+    """Prompt the user to choose one of the choices
 
-    Choices are identified in the prompt_text by square brackets around
-    a single letter option.
-    """
+       Choices are identified in the prompt_text by square brackets around a
+       single letter option.
+       """
     choices = set(m.group(1) for m in re.finditer(r"\[(.)\]", prompt_text))
     while True:
         sys.stderr.flush()
@@ -218,8 +216,10 @@ def encode_text_stream(s):
 
 
 def decode_path(path):
-    """Decode a given string (bytes or otherwise) using configured path encoding options
-    """
+    """Decode a given string (bytes or otherwise) using configured path
+       encoding options.
+       """
+
     encoding = gitConfig('git-p4.pathEncoding') or 'utf_8'
     if bytes is not str:
         return path.decode(encoding, errors='replace') if isinstance(path, bytes) else path
@@ -271,20 +271,20 @@ def run_git_hook(cmd, param=[]):
 
 def run_hook_command(cmd, param):
     """Executes a git hook command
-       cmd = the command line file to be executed. This can be
-       a file that is run by OS association.
 
-       param = a list of parameters to pass to the cmd command
+       cmd -- the command line file to be executed.  This can be a file that
+           is run by OS association.
+
+       param -- a list of parameters to pass to the cmd command
 
-       On windows, the extension is checked to see if it should
-       be run with the Git for Windows Bash shell.  If there
-       is no file extension, the file is deemed a bash shell
-       and will be handed off to sh.exe. Otherwise, Windows
-       will be called with the shell to handle the file assocation.
+       On Windows, the extension is checked to see if it should be run with
+       the Git for Windows Bash shell.  If there is no file extension, the file
+       is deemed a bash shell and will be handed off to sh.exe.  Otherwise,
+       Windows will be called with the shell to handle the file assocation.
 
        For non Windows operating systems, the file is called
        as an executable.
-    """
+       """
     cli = [cmd] + param
     use_shell = False
     if platform.system() == 'Windows':
@@ -324,10 +324,9 @@ def p4_write_pipe(c, stdin):
 
 
 def read_pipe_full(c):
-    """ Read output from  command. Returns a tuple
-        of the return status, stdout text and stderr
-        text.
-    """
+    """Read output from command. Returns a tuple of the return status, stdout
+       text and stderr text.
+       """
     if verbose:
         sys.stderr.write('Reading pipe: %s\n' % str(c))
 
@@ -338,12 +337,12 @@ def read_pipe_full(c):
 
 
 def read_pipe(c, ignore_error=False, raw=False):
-    """ Read output from  command. Returns the output text on
-        success. On failure, terminates execution, unless
-        ignore_error is True, when it returns an empty string.
+    """Read output from  command. Returns the output text on success. On
+       failure, terminates execution, unless ignore_error is True, when it
+       returns an empty string.
 
-        If raw is True, do not attempt to decode output text.
-    """
+       If raw is True, do not attempt to decode output text.
+       """
     (retcode, out, err) = read_pipe_full(c)
     if retcode != 0:
         if ignore_error:
@@ -356,9 +355,9 @@ def read_pipe(c, ignore_error=False, raw=False):
 
 
 def read_pipe_text(c):
-    """ Read output from a command with trailing whitespace stripped.
-        On error, returns None.
-    """
+    """Read output from a command with trailing whitespace stripped. On error,
+       returns None.
+       """
     (retcode, out, err) = read_pipe_full(c)
     if retcode != 0:
         return None
@@ -387,14 +386,15 @@ def read_pipe_lines(c, raw=False):
 
 
 def p4_read_pipe_lines(c):
-    """Specifically invoke p4 on the command supplied. """
+    """Specifically invoke p4 on the command supplied."""
     real_cmd = p4_build_cmd(c)
     return read_pipe_lines(real_cmd)
 
 
 def p4_has_command(cmd):
-    """Ask p4 for help on this command.  If it returns an error, the
-       command does not exist in this version of p4."""
+    """Ask p4 for help on this command.  If it returns an error, the command
+       does not exist in this version of p4.
+       """
     real_cmd = p4_build_cmd(["help", cmd])
     p = subprocess.Popen(real_cmd, stdout=subprocess.PIPE,
                                    stderr=subprocess.PIPE)
@@ -403,10 +403,11 @@ def p4_has_command(cmd):
 
 
 def p4_has_move_command():
-    """See if the move command exists, that it supports -k, and that
-       it has not been administratively disabled.  The arguments
-       must be correct, but the filenames do not have to exist.  Use
-       ones with wildcards so even if they exist, it will fail."""
+    """See if the move command exists, that it supports -k, and that it has not
+       been administratively disabled.  The arguments must be correct, but the
+       filenames do not have to exist.  Use ones with wildcards so even if they
+       exist, it will fail.
+       """
 
     if not p4_has_command("move"):
         return False
@@ -435,7 +436,7 @@ def system(cmd, ignore_error=False):
 
 
 def p4_system(cmd):
-    """Specifically invoke p4 as the system command. """
+    """Specifically invoke p4 as the system command."""
     real_cmd = p4_build_cmd(cmd)
     expand = not isinstance(real_cmd, list)
     retcode = subprocess.call(real_cmd, shell=expand)
@@ -448,8 +449,8 @@ def die_bad_access(s):
 
 
 def p4_check_access(min_expiration=1):
-    """ Check if we can access Perforce - account still logged in
-    """
+    """Check if we can access Perforce - account still logged in."""
+
     results = p4CmdList(["login", "-s"])
 
     if len(results) == 0:
@@ -497,14 +498,14 @@ def p4_check_access(min_expiration=1):
 
 
 def p4_version_string():
-    """Read the version string, showing just the last line, which
-       hopefully is the interesting version bit.
+    """Read the version string, showing just the last line, which hopefully is
+       the interesting version bit.
 
        $ p4 -V
        Perforce - The Fast Software Configuration Management System.
        Copyright 1995-2011 Perforce Software.  All rights reserved.
        Rev. P4/NTX86/2011.1/393975 (2011/12/16).
-    """
+       """
     global _p4_version_string
     if not _p4_version_string:
         a = p4_read_pipe_lines(["-V"])
@@ -559,9 +560,11 @@ def p4_last_change():
 
 
 def p4_describe(change, shelved=False):
-    """Make sure it returns a valid result by checking for
-       the presence of field "time".  Return a dict of the
-       results."""
+    """Make sure it returns a valid result by checking for the presence of
+       field "time".
+
+       Return a dict of the results.
+       """
 
     cmd = ["describe", "-s"]
     if shelved:
@@ -715,21 +718,22 @@ def getGitTags():
 def parseDiffTreeEntry(entry):
     """Parses a single diff tree entry into its component elements.
 
-    See git-diff-tree(1) manpage for details about the format of the diff
-    output. This method returns a dictionary with the following elements:
-
-    src_mode - The mode of the source file
-    dst_mode - The mode of the destination file
-    src_sha1 - The sha1 for the source file
-    dst_sha1 - The sha1 fr the destination file
-    status - The one letter status of the diff (i.e. 'A', 'M', 'D', etc)
-    status_score - The score for the status (applicable for 'C' and 'R'
-                   statuses). This is None if there is no score.
-    src - The path for the source file.
-    dst - The path for the destination file. This is only present for
-          copy or renames. If it is not present, this is None.
-
-    If the pattern is not matched, None is returned."""
+       See git-diff-tree(1) manpage for details about the format of the diff
+       output. This method returns a dictionary with the following elements:
+
+       src_mode - The mode of the source file
+       dst_mode - The mode of the destination file
+       src_sha1 - The sha1 for the source file
+       dst_sha1 - The sha1 fr the destination file
+       status - The one letter status of the diff (i.e. 'A', 'M', 'D', etc)
+       status_score - The score for the status (applicable for 'C' and 'R'
+                      statuses). This is None if there is no score.
+       src - The path for the source file.
+       dst - The path for the destination file. This is only present for
+             copy or renames. If it is not present, this is None.
+
+       If the pattern is not matched, None is returned.
+       """
 
     global _diff_tree_pattern
     if not _diff_tree_pattern:
@@ -757,14 +761,16 @@ def isModeExec(mode):
 
 
 class P4Exception(Exception):
-    """ Base class for exceptions from the p4 client """
+    """Base class for exceptions from the p4 client."""
 
     def __init__(self, exit_code):
         self.p4ExitCode = exit_code
 
 
 class P4ServerException(P4Exception):
-    """ Base class for exceptions where we get some kind of marshalled up result from the server """
+    """Base class for exceptions where we get some kind of marshalled up result
+       from the server.
+       """
 
     def __init__(self, exit_code, p4_result):
         super(P4ServerException, self).__init__(exit_code)
@@ -774,7 +780,7 @@ def __init__(self, exit_code, p4_result):
 
 
 class P4RequestSizeException(P4ServerException):
-    """ One of the maxresults or maxscanrows errors """
+    """One of the maxresults or maxscanrows errors."""
 
     def __init__(self, exit_code, p4_result, limit):
         super(P4RequestSizeException, self).__init__(exit_code, p4_result)
@@ -782,7 +788,7 @@ def __init__(self, exit_code, p4_result, limit):
 
 
 class P4CommandException(P4Exception):
-    """ Something went wrong calling p4 which means we have to give up """
+    """Something went wrong calling p4 which means we have to give up."""
 
     def __init__(self, msg):
         self.msg = msg
@@ -1016,7 +1022,8 @@ def gitConfig(key, typeSpecifier=None):
 def gitConfigBool(key):
     """Return a bool, using git config --bool.  It is True only if the
        variable is set to true, and False if set to false or not present
-       in the config."""
+       in the config.
+       """
 
     if key not in _gitConfig:
         _gitConfig[key] = gitConfig(key, '--bool') == "true"
@@ -1049,7 +1056,8 @@ def p4BranchesInGit(branchesAreInRemotes=True):
        in remotes or heads as specified by the argument.  Return
        a dictionary of { branch: revision } for each one found.
        The branch names are the short names, without any
-       "p4/" prefix."""
+       "p4/" prefix.
+       """
 
     branches = {}
 
@@ -1280,7 +1288,8 @@ def p4PathStartsWith(path, prefix):
 
 def getClientSpec():
     """Look at the p4 client spec, create a View() object that contains
-       all the mappings, and return it."""
+       all the mappings, and return it.
+       """
 
     specList = p4CmdList("client -o")
     if len(specList) != 1:
@@ -1363,13 +1372,15 @@ def __init__(self, writeToGitStream):
         self.writeToGitStream = writeToGitStream
 
     def generatePointer(self, cloneDestination, contentFile):
-        """Return the content of a pointer file that is stored in Git instead of
-           the actual content."""
+        """Return the content of a pointer file that is stored in Git instead
+           of the actual content.
+           """
         assert False, "Method 'generatePointer' required in " + self.__class__.__name__
 
     def pushFile(self, localLargeFile):
         """Push the actual content which is not stored in the Git repository to
-           a server."""
+           a server.
+           """
         assert False, "Method 'pushFile' required in " + self.__class__.__name__
 
     def hasLargeFileExtension(self, relPath):
@@ -1417,7 +1428,8 @@ def isLargeFile(self, relPath):
     def processContent(self, git_mode, relPath, contents):
         """Processes the content of git fast import. This method decides if a
            file is stored in the large file system and handles all necessary
-           steps."""
+           steps.
+           """
         if self.exceedsLargeFileThreshold(relPath, contents) or self.hasLargeFileExtension(relPath):
             contentTempFile = self.generateTempFile(contents)
             (pointer_git_mode, contents, localLargeFile) = self.generatePointer(contentTempFile)
@@ -1442,7 +1454,8 @@ class MockLFS(LargeFileSystem):
 
     def generatePointer(self, contentFile):
         """The pointer content is the original content prefixed with "pointer-".
-           The local filename of the large file storage is derived from the file content.
+           The local filename of the large file storage is derived from the
+           file content.
            """
         with open(contentFile, 'r') as f:
             content = next(f)
@@ -1452,8 +1465,8 @@ def generatePointer(self, contentFile):
             return (gitMode, pointerContents, localLargeFile)
 
     def pushFile(self, localLargeFile):
-        """The remote filename of the large file storage is the same as the local
-           one but in a different directory.
+        """The remote filename of the large file storage is the same as the
+           local one but in a different directory.
            """
         remotePath = os.path.join(os.path.dirname(localLargeFile), '..', 'remote')
         if not os.path.exists(remotePath):
@@ -1463,7 +1476,8 @@ def pushFile(self, localLargeFile):
 
 class GitLFS(LargeFileSystem):
     """Git LFS as backend for the git-p4 large file system.
-       See https://git-lfs.github.com/ for details."""
+       See https://git-lfs.github.com/ for details.
+       """
 
     def __init__(self, *args):
         LargeFileSystem.__init__(self, *args)
@@ -1729,20 +1743,20 @@ def check(self):
             die("You have files opened with perforce! Close them before starting the sync.")
 
     def separate_jobs_from_description(self, message):
-        """Extract and return a possible Jobs field in the commit
-           message.  It goes into a separate section in the p4 change
-           specification.
+        """Extract and return a possible Jobs field in the commit message.  It
+           goes into a separate section in the p4 change specification.
 
-           A jobs line starts with "Jobs:" and looks like a new field
-           in a form.  Values are white-space separated on the same
-           line or on following lines that start with a tab.
+           A jobs line starts with "Jobs:" and looks like a new field in a
+           form.  Values are white-space separated on the same line or on
+           following lines that start with a tab.
 
-           This does not parse and extract the full git commit message
-           like a p4 form.  It just sees the Jobs: line as a marker
-           to pass everything from then on directly into the p4 form,
-           but outside the description section.
+           This does not parse and extract the full git commit message like a
+           p4 form.  It just sees the Jobs: line as a marker to pass everything
+           from then on directly into the p4 form, but outside the description
+           section.
 
-           Return a tuple (stripped log message, jobs string)."""
+           Return a tuple (stripped log message, jobs string).
+           """
 
         m = re.search(r'^Jobs:', message, re.MULTILINE)
         if m is None:
@@ -1753,9 +1767,10 @@ def separate_jobs_from_description(self, message):
         return (stripped_message, jobtext)
 
     def prepareLogMessage(self, template, message, jobs):
-        """Edits the template returned from "p4 change -o" to insert
-           the message in the Description field, and the jobs text in
-           the Jobs field."""
+        """Edits the template returned from "p4 change -o" to insert the
+           message in the Description field, and the jobs text in the Jobs
+           field.
+           """
         result = ""
 
         inDescriptionSection = False
@@ -1880,11 +1895,13 @@ def canChangeChangelists(self):
 
     def prepareSubmitTemplate(self, changelist=None):
         """Run "p4 change -o" to grab a change specification template.
+
            This does not use "p4 -G", as it is nice to keep the submission
            template in original order, since a human might edit it.
 
            Remove lines in the Files section that show changes to files
-           outside the depot path we're committing into."""
+           outside the depot path we're committing into.
+           """
 
         [upstream, settings] = findUpstreamBranchPoint()
 
@@ -1947,8 +1964,10 @@ def prepareSubmitTemplate(self, changelist=None):
         return template
 
     def edit_template(self, template_file):
-        """Invoke the editor to let the user change the submission
-           message.  Return true if okay to continue with the submit."""
+        """Invoke the editor to let the user change the submission message.
+
+           Return true if okay to continue with the submit.
+           """
 
         # if configured to skip the editing part, just submit
         if gitConfigBool("git-p4.skipSubmitEdit"):
@@ -2643,8 +2662,9 @@ def run(self, args):
 
 
 class View(object):
-    """Represent a p4 view ("p4 help views"), and map files in a
-       repo according to the view."""
+    """Represent a p4 view ("p4 help views"), and map files in a repo according
+       to the view.
+       """
 
     def __init__(self, client_name):
         self.mappings = []
@@ -2653,9 +2673,10 @@ def __init__(self, client_name):
         self.client_spec_path_cache = {}
 
     def append(self, view_line):
-        """Parse a view line, splitting it into depot and client
-           sides.  Append to self.mappings, preserving order.  This
-           is only needed for tag creation."""
+        """Parse a view line, splitting it into depot and client sides.  Append
+           to self.mappings, preserving order.  This is only needed for tag
+           creation.
+           """
 
         # Split the view line into exactly two words.  P4 enforces
         # structure on these lines that simplifies this quite a bit.
@@ -2704,7 +2725,7 @@ def convert_client_path(self, clientFile):
         return clientFile[len(self.client_prefix):]
 
     def update_client_spec_path_cache(self, files):
-        """ Caching file paths by "p4 where" batch query """
+        """Caching file paths by "p4 where" batch query."""
 
         # List depot file paths exclude that already cached
         fileArgs = [f['path'] for f in files if decode_path(f['path']) not in self.client_spec_path_cache]
@@ -2736,9 +2757,11 @@ def update_client_spec_path_cache(self, files):
                 self.client_spec_path_cache[depotFile] = b''
 
     def map_in_client(self, depot_path):
-        """Return the relative location in the client where this
-           depot file should live.  Returns "" if the file should
-           not be mapped in the client."""
+        """Return the relative location in the client where this depot file
+           should live.
+
+           Returns "" if the file should not be mapped in the client.
+           """
 
         if gitConfigBool("core.ignorecase"):
             depot_path = depot_path.lower()
@@ -2889,10 +2912,10 @@ def extractJobsFromCommit(self, commit):
         return jobs
 
     def stripRepoPath(self, path, prefixes):
-        """When streaming files, this is called to map a p4 depot path
-           to where it should go in git.  The prefixes are either
-           self.depotPaths, or self.branchPrefixes in the case of
-           branch detection."""
+        """When streaming files, this is called to map a p4 depot path to where
+           it should go in git.  The prefixes are either self.depotPaths, or
+           self.branchPrefixes in the case of branch detection.
+           """
 
         if self.useClientSpec:
             # branch detection moves files up a level (the branch name)
@@ -2921,8 +2944,9 @@ def stripRepoPath(self, path, prefixes):
         return path
 
     def splitFilesIntoBranches(self, commit):
-        """Look at each depotFile in the commit to figure out to what
-           branch it belongs."""
+        """Look at each depotFile in the commit to figure out to what branch it
+           belongs.
+           """
 
         if self.clientSpecDirs:
             files = self.extractFilesFromCommit(commit)
@@ -3193,9 +3217,10 @@ def make_email(self, userid):
             return "%s <a@b>" % userid
 
     def streamTag(self, gitStream, labelName, labelDetails, commit, epoch):
-        """ Stream a p4 tag.
-        commit is either a git commit, or a fast-import mark, ":<p4commit>"
-        """
+        """Stream a p4 tag.
+
+           Commit is either a git commit, or a fast-import mark, ":<p4commit>".
+           """
 
         if verbose:
             print("writing tag %s for commit %s" % (labelName, commit))
@@ -4246,8 +4271,7 @@ def __init__(self):
         self.destbranch = "refs/remotes/p4-unshelved"
 
     def renameBranch(self, branch_name):
-        """ Rename the existing branch to branch_name.N
-        """
+        """Rename the existing branch to branch_name.N ."""
 
         found = True
         for i in range(0,1000):
@@ -4263,9 +4287,9 @@ def renameBranch(self, branch_name):
             sys.exit("gave up trying to rename existing branch {0}".format(sync.branch))
 
     def findLastP4Revision(self, starting_point):
-        """ Look back from starting_point for the first commit created by git-p4
-            to find the P4 commit we are based on, and the depot-paths.
-        """
+        """Look back from starting_point for the first commit created by git-p4
+           to find the P4 commit we are based on, and the depot-paths.
+           """
 
         for parent in (range(65535)):
             log = extractLogMessageFromGitCommit("{0}~{1}".format(starting_point, parent))
@@ -4276,8 +4300,9 @@ def findLastP4Revision(self, starting_point):
         sys.exit("could not find git-p4 commits in {0}".format(self.origin))
 
     def createShelveParent(self, change, branch_name, sync, origin):
-        """ Create a commit matching the parent of the shelved changelist 'change'
-        """
+        """Create a commit matching the parent of the shelved changelist
+           'change'.
+           """
         parent_description = p4_describe(change, shelved=True)
         parent_description['desc'] = 'parent for shelved changelist {}\n'.format(change)
         files = sync.extractFilesFromCommit(parent_description, shelved=False, shelved_cl=change)
-- 
2.34.1

