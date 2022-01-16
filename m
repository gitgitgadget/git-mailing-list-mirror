Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFE0C433EF
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 16:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbiAPQH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:07:29 -0500
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com ([40.107.92.73]:64736
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233561AbiAPQHX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 11:07:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJXhI0rBczPMY9qrQaGXLd6ovjfIIZtl3nxDiS1514ujEJj4UKF250JMvWsSFRHYtPocGkL2lc/EK+OiDJHn3sb2AwkBKOmTF8Zl3CP9yTFxOcEVUIr4IKFhbNtA4+ugSF3ZT7n82ntd6qsS9jvEUWH7S/QuUIcNqaRVpWp8fGpPgXmIiNGzfZoin70fSjTxc/+5DfM756+BglTyeBxYmXvI3j+sLuQA3orouIgXGHxpWwztPbcH6r0HKsTEEaqoz3RKEwIDNZRBluYfbdATD0NfScmr/w4NmxZTJ7INRygbOjN1osQIRjaFEd4bYt4e+2r30KkQsaoK0PCYjhp+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3tRxQH4RTst0LAIk+onII+hrUc3S8XCUH2iG5F9akE=;
 b=VwbCt2QKibzmM7uy8brU15DNp5l4XfQIQa1G74+v6KUF97lve+u0FJlci0sWRnPrfGG3NwsRdjbzDbD+qWUWnqEcbnC/JdhqgsfYTOUB0vx6HXY5sJ8D1sDzH/5kCiyJGkKxGPv/v5FOgm9c4NJvIgGerb7YSX3zWeJGw+CBh8Tc86IiOmD26WDCkg/0bX5AgAxTomPYCIgPgg50dxe28BDRa7vKf4tLB2i+rbjTOmsZnAnN304+CWB1hr5azd97PIdEVMLo5MMuYxOOctVIUd6Bf84HYcgmMEe64Q+QMZwLMUbVIQaXwo3OPKx/uoDPzJMmow542kDT0oKn/u+Zyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3tRxQH4RTst0LAIk+onII+hrUc3S8XCUH2iG5F9akE=;
 b=IvP0JVTmeN9qEIP37CNHJOPSAoFbSQ5BptyKEkf6CitylScnZCIeoHcPGcDYYQXCR6+6QosNNn+Ki18CC9dUnfTcPuSqKl9QPYso3nhd+NV6Togrz4vIqejS4T4t+wljee01Ex0yHqfRs6Hqb+GQhifsNv/2vhCR3LQmS1NAoCESJ92YH/tve/ybaESagu+Vi//61vpcjD9x+O62MPM3Uy3jA2sAtXsOAZqKWoD3j6qZ5EtFbwTm7ZVBXFsCX3W4j3CteFmEE3LeytS0gx3qRpuxFBVEr/uv8xGweYHIdKwowbfWWpXulyDXEDR+k7tvAVumi5wUNpDU1YuCJCzlXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB3088.namprd12.prod.outlook.com (2603:10b6:208:c4::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sun, 16 Jan
 2022 16:07:22 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 16:07:22 +0000
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
Subject: [PATCH v3 04/21] git-p4: improve consistency of docstring formatting
Date:   Sun, 16 Jan 2022 16:05:33 +0000
Message-Id: <20220116160550.514637-5-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: fe8ec071-21db-45d1-05e0-08d9d90a4720
X-MS-TrafficTypeDiagnostic: MN2PR12MB3088:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB30889393DE1D0B2132F22809C8569@MN2PR12MB3088.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v8Nd4TsCWx99HWNj2XNxak9CYaKXv6LpgKVCuZg/G1amWUubiPbfkBO+elsvvsGN8AjqyozDIl+kWB7vEQvaSBkTpgJ6p2P+arGJzqLr0NoE0ftbfsCQJWTRgJQgNqmaAjUSBxg1EDArBOeCD2N8ZASDnYQ0knearVIsK8Sf84sPSuv/xbw81jr2lcFlm2L8OqtwN1HoW1E6+tXYbvKXfpE1U5nMTKuURA18UnvbzM157hlML/gpe8hR1ernEgHXHJu8BMaYIP7ab4ne1Q3oM75WhfGavs5aNbvaMvBZT50zM3Rv6gbVXFQ87cGermNshSPuwt+FIC/WNk4bcCKSzsxGHC/w9CTxuQkZAoFJjdROCeWAtioZY0Yq4XaYkACSG8nLgRsgQgTVpui4pd8ApDFeDxXOrHQCkgEK5TVPZCAlsIDnYq8n9zIc5dqnBeCI6gerFs2N4GZkgUOT58bu/0ltNX93FVZ2rPFOY/Ly7q51k0mAB+8EdTbQn5w9ocu0+zTy78V2wna3w8tEuDj43Fq1JJrmvGl6Jj0I1mapphH5RJ/SMRBMfIONjf4ib1P7vFiDHfuOOXtg9+fdt2MGV1gcJZwHGHJxtcIx1myI59ZgypIFVys6/nIVk9cwPx18k0GAEJsk8xHC9mf7pccYneE1+gE8nJCAuiAmSfdQnoiPswVnQgjtrXmzUegJjiE9WKVQTOXpavxYYITYPp3SjxytsNs1JD3fjBJaOxOoJIdIsIljJ5R2h3+5k7lk4TSGbCjKzFqjKjcUAEX/lfuEAlfGStyB+2PPSXzMIOXPLRz4zY4N/IJ5uQhiXLW484vn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(36756003)(54906003)(107886003)(7416002)(110136005)(83380400001)(2906002)(186003)(52116002)(38100700002)(316002)(6486002)(8936002)(38350700002)(2616005)(4326008)(8676002)(6512007)(5660300002)(66946007)(30864003)(508600001)(86362001)(55236004)(1076003)(26005)(66556008)(66476007)(966005)(6666004)(460985005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lqkBFzM/vEXFQCBdmOvKxQOSgNdjp7VNpE9nbmce+eOHoZL26hFowBx7L0MB?=
 =?us-ascii?Q?kBIejKy5fkaBRBaAgFMQN1KnBXOSmsj5DvV0PtEW+G4OccAsaAWe/8zKmNSB?=
 =?us-ascii?Q?LD5mHC44Wc+pCUHGHs1bscup0qeWe7uSV/k9Qp5z9S8+rf6tSdFEQyw0ww3P?=
 =?us-ascii?Q?30/JWXm38ne42UdCmWuQUHYzSlWzCn1PpkqPWBL4ePY/CW8MkRMBSOxtaC0K?=
 =?us-ascii?Q?X+FoLRPywC1g6naUSeHebxFNe6o6EOmBnrMU5OMeBrYldBC0qHVS6OtWmnh2?=
 =?us-ascii?Q?dJUajgq8a256YxVZwuqgV/wJ6cJk30g0gcLj7zvwGl4QM2L419OvjF0uAeuC?=
 =?us-ascii?Q?FndgCHCQ03U9Bnoxq7MIvQ5wGsTxamE8KQrgvNae0Jd+kvxPKmgTFdawq7Go?=
 =?us-ascii?Q?sxOWnA2xJcZr2Kxd8PF5ZyV51UrMdhNjs59XxpZwwqUoRIHcne89oP5B2pe5?=
 =?us-ascii?Q?AFruDnqrpPvcmq3uOrZ8Xv0fT+dc+Fi1CNv+0OfH9yk2d6iZ5kEi84T16m+X?=
 =?us-ascii?Q?Ld0dJykzi1BR7MeCgxN0inCWEWiGkmPkC0Sq5YFM8Lpb3HEo2HYNo2HbUWFV?=
 =?us-ascii?Q?6rN8UvtFYwylPFTz3lovZNJMGOOramVO8gVL19rMWsjmjRaPXPcxtpC+GK8n?=
 =?us-ascii?Q?IOQRZvMgOooouo1zqBWm7XFCWF1ywLV+iRdWgbMndkn0HFzVezXO9IJNq9Hm?=
 =?us-ascii?Q?h4cqTN8XFk/kl5LqAJffZb6m03NjBsvjDVFNwifmj3GbC1eJJ5KyUDmOo3F6?=
 =?us-ascii?Q?5Z468lN87ArbsOywebXWXFIAd1icxYOchu2Q7kVIjLR8qvR6TN4JO7EbLDWh?=
 =?us-ascii?Q?75a8ZQLjrhFdkW/IXKm0HDPHMMr0RXx8OxjkAYO7By6jyMAd+LMGUxfsE48t?=
 =?us-ascii?Q?2c5NZWdTvBf7yRKhBMmH+oYHwUWu80+wFJUis7loNhzbkP0pFQZkNrIWty9L?=
 =?us-ascii?Q?trBHP3sFkC/BgDZ9p7WY6dywq4iMYn8Id8xPW8YvdMlEIPebpA4I766A7oPT?=
 =?us-ascii?Q?D3fiuFcFiIiajdWVFjiVAraONKgz4DSYF1/GxN0XsJOxYDK1sDxaDAkc+Ngh?=
 =?us-ascii?Q?gyh6n9sVRFv5GYBF508Bp3nas6cdh8MgENfNz/Sr+rnVPsMpC0n0BNmknSCU?=
 =?us-ascii?Q?YYn2loQ2dlPBsyolAR2AwLeRQSPelMs2ds49WM+vLLUbUKFr/nVaqyn/pwva?=
 =?us-ascii?Q?uplvuVdSqrN0GclWI8poRlgbQwVPEMzSv5ZymDkUeUhHYGF5rDazb3jqHEND?=
 =?us-ascii?Q?ybJNxvBPkJOEOdE3PHFN88i78uAZ7JRermT8TEAb3NMXaLd81qc5FH/p8S7x?=
 =?us-ascii?Q?mCPTjhI8KoTxq5xPwclka7mlTBBh7wdLMAJbizX8EosNPERNJ/+41XrxKyc5?=
 =?us-ascii?Q?jzyYa3sy2eB2iw61bvzoX+6H34C1LwAb67+VApsZzQ21Q7tAZMhrKjA+mzR5?=
 =?us-ascii?Q?IbQUv5f5yEQPQqX424pl85cB4UAi/a+aMuUotyMJmLWBrTbB8KemRy+ihn7Y?=
 =?us-ascii?Q?SNwwgi9P1lGhsVOxgHEDktBs6nXQHxQqWPaN5rMwIQ02RTR2ef+KVOyj2hie?=
 =?us-ascii?Q?Kwp04wkhHAWCtf008ue/zgrvY6uAUY8UmlegO9V0AqI7MNR0qzfQ7JuS2WP/?=
 =?us-ascii?Q?btBJw0scrynUxX3YD/yyYQc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8ec071-21db-45d1-05e0-08d9d90a4720
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 16:07:21.9254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bQio12zQRtdp8tvRLRxDkgAmEv3hn1jf//eIV1BvXTJzQm6RaIVFjtJDAqyGsvcKUjg/Za3wt8xh7nyOhvFDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3088
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
 git-p4.py | 311 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 168 insertions(+), 143 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index eceda0fb76..28d04d5cd9 100755
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
@@ -122,9 +122,9 @@ def p4_build_cmd(cmd):
 
 
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
@@ -133,20 +133,18 @@ def git_dir(path):
 
 
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
@@ -167,9 +165,9 @@ def calcDiskFree():
 
 
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
@@ -178,11 +176,11 @@ def die(msg):
 
 
 def prompt(prompt_text):
-    """ Prompt the user to choose one of the choices
+    """Prompt the user to choose one of the choices.
 
-    Choices are identified in the prompt_text by square brackets around
-    a single letter option.
-    """
+       Choices are identified in the prompt_text by square brackets around a
+       single letter option.
+       """
     choices = set(m.group(1) for m in re.finditer(r"\[(.)\]", prompt_text))
     while True:
         sys.stderr.flush()
@@ -215,8 +213,10 @@ def encode_text_stream(s):
 
 
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
@@ -267,21 +267,21 @@ def run_git_hook(cmd, param=[]):
 
 
 def run_hook_command(cmd, param):
-    """Executes a git hook command
-       cmd = the command line file to be executed. This can be
-       a file that is run by OS association.
+    """Executes a git hook command.
+
+       cmd - the command line file to be executed.  This can be a file that
+           is run by OS association.
 
-       param = a list of parameters to pass to the cmd command
+       param - a list of parameters to pass to the cmd command
 
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
@@ -320,10 +320,9 @@ def p4_write_pipe(c, stdin, *k, **kw):
 
 
 def read_pipe_full(c, *k, **kw):
-    """ Read output from  command. Returns a tuple
-        of the return status, stdout text and stderr
-        text.
-    """
+    """Read output from command. Returns a tuple of the return status, stdout
+       text and stderr text.
+       """
     if verbose:
         sys.stderr.write('Reading pipe: {}\n'.format(' '.join(c)))
 
@@ -334,12 +333,12 @@ def read_pipe_full(c, *k, **kw):
 
 
 def read_pipe(c, ignore_error=False, raw=False, *k, **kw):
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
     (retcode, out, err) = read_pipe_full(c, *k, **kw)
     if retcode != 0:
         if ignore_error:
@@ -352,9 +351,9 @@ def read_pipe(c, ignore_error=False, raw=False, *k, **kw):
 
 
 def read_pipe_text(c, *k, **kw):
-    """ Read output from a command with trailing whitespace stripped.
-        On error, returns None.
-    """
+    """Read output from a command with trailing whitespace stripped. On error,
+       returns None.
+       """
     (retcode, out, err) = read_pipe_full(c, *k, **kw)
     if retcode != 0:
         return None
@@ -382,14 +381,15 @@ def read_pipe_lines(c, raw=False, *k, **kw):
 
 
 def p4_read_pipe_lines(c, *k, **kw):
-    """Specifically invoke p4 on the command supplied. """
+    """Specifically invoke p4 on the command supplied."""
     real_cmd = p4_build_cmd(c)
     return read_pipe_lines(real_cmd, *k, **kw)
 
 
 def p4_has_command(cmd):
-    """Ask p4 for help on this command.  If it returns an error, the
-       command does not exist in this version of p4."""
+    """Ask p4 for help on this command.  If it returns an error, the command
+       does not exist in this version of p4.
+       """
     real_cmd = p4_build_cmd(["help", cmd])
     p = subprocess.Popen(real_cmd, stdout=subprocess.PIPE,
                                    stderr=subprocess.PIPE)
@@ -398,10 +398,11 @@ def p4_has_command(cmd):
 
 
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
@@ -430,7 +431,7 @@ def system(cmd, ignore_error=False, *k, **kw):
 
 
 def p4_system(cmd, *k, **kw):
-    """Specifically invoke p4 as the system command. """
+    """Specifically invoke p4 as the system command."""
     real_cmd = p4_build_cmd(cmd)
     retcode = subprocess.call(real_cmd, *k, **kw)
     if retcode:
@@ -442,8 +443,8 @@ def die_bad_access(s):
 
 
 def p4_check_access(min_expiration=1):
-    """ Check if we can access Perforce - account still logged in
-    """
+    """Check if we can access Perforce - account still logged in."""
+
     results = p4CmdList(["login", "-s"])
 
     if len(results) == 0:
@@ -491,14 +492,14 @@ def p4_check_access(min_expiration=1):
 
 
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
@@ -553,9 +554,11 @@ def p4_last_change():
 
 
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
@@ -709,21 +712,22 @@ def getGitTags():
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
@@ -751,14 +755,16 @@ def isModeExec(mode):
 
 
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
@@ -768,7 +774,7 @@ def __init__(self, exit_code, p4_result):
 
 
 class P4RequestSizeException(P4ServerException):
-    """ One of the maxresults or maxscanrows errors """
+    """One of the maxresults or maxscanrows errors."""
 
     def __init__(self, exit_code, p4_result, limit):
         super(P4RequestSizeException, self).__init__(exit_code, p4_result)
@@ -776,7 +782,7 @@ def __init__(self, exit_code, p4_result, limit):
 
 
 class P4CommandException(P4Exception):
-    """ Something went wrong calling p4 which means we have to give up """
+    """Something went wrong calling p4 which means we have to give up."""
 
     def __init__(self, msg):
         self.msg = msg
@@ -1001,7 +1007,8 @@ def gitConfig(key, typeSpecifier=None):
 def gitConfigBool(key):
     """Return a bool, using git config --bool.  It is True only if the
        variable is set to true, and False if set to false or not present
-       in the config."""
+       in the config.
+       """
 
     if key not in _gitConfig:
         _gitConfig[key] = gitConfig(key, '--bool') == "true"
@@ -1034,7 +1041,8 @@ def p4BranchesInGit(branchesAreInRemotes=True):
        in remotes or heads as specified by the argument.  Return
        a dictionary of { branch: revision } for each one found.
        The branch names are the short names, without any
-       "p4/" prefix."""
+       "p4/" prefix.
+       """
 
     branches = {}
 
@@ -1265,7 +1273,8 @@ def p4PathStartsWith(path, prefix):
 
 def getClientSpec():
     """Look at the p4 client spec, create a View() object that contains
-       all the mappings, and return it."""
+       all the mappings, and return it.
+       """
 
     specList = p4CmdList(["client", "-o"])
     if len(specList) != 1:
@@ -1348,13 +1357,15 @@ def __init__(self, writeToGitStream):
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
@@ -1402,7 +1413,8 @@ def isLargeFile(self, relPath):
     def processContent(self, git_mode, relPath, contents):
         """Processes the content of git fast import. This method decides if a
            file is stored in the large file system and handles all necessary
-           steps."""
+           steps.
+           """
         if self.exceedsLargeFileThreshold(relPath, contents) or self.hasLargeFileExtension(relPath):
             contentTempFile = self.generateTempFile(contents)
             (pointer_git_mode, contents, localLargeFile) = self.generatePointer(contentTempFile)
@@ -1427,7 +1439,8 @@ class MockLFS(LargeFileSystem):
 
     def generatePointer(self, contentFile):
         """The pointer content is the original content prefixed with "pointer-".
-           The local filename of the large file storage is derived from the file content.
+           The local filename of the large file storage is derived from the
+           file content.
            """
         with open(contentFile, 'r') as f:
             content = next(f)
@@ -1437,8 +1450,8 @@ def generatePointer(self, contentFile):
             return (gitMode, pointerContents, localLargeFile)
 
     def pushFile(self, localLargeFile):
-        """The remote filename of the large file storage is the same as the local
-           one but in a different directory.
+        """The remote filename of the large file storage is the same as the
+           local one but in a different directory.
            """
         remotePath = os.path.join(os.path.dirname(localLargeFile), '..', 'remote')
         if not os.path.exists(remotePath):
@@ -1448,7 +1461,8 @@ def pushFile(self, localLargeFile):
 
 class GitLFS(LargeFileSystem):
     """Git LFS as backend for the git-p4 large file system.
-       See https://git-lfs.github.com/ for details."""
+       See https://git-lfs.github.com/ for details.
+       """
 
     def __init__(self, *args):
         LargeFileSystem.__init__(self, *args)
@@ -1714,20 +1728,20 @@ def check(self):
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
@@ -1738,9 +1752,10 @@ def separate_jobs_from_description(self, message):
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
@@ -1865,11 +1880,13 @@ def canChangeChangelists(self):
 
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
 
@@ -1932,8 +1949,10 @@ def prepareSubmitTemplate(self, changelist=None):
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
@@ -2629,8 +2648,9 @@ def run(self, args):
 
 
 class View(object):
-    """Represent a p4 view ("p4 help views"), and map files in a
-       repo according to the view."""
+    """Represent a p4 view ("p4 help views"), and map files in a repo according
+       to the view.
+       """
 
     def __init__(self, client_name):
         self.mappings = []
@@ -2639,9 +2659,10 @@ def __init__(self, client_name):
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
@@ -2690,7 +2711,7 @@ def convert_client_path(self, clientFile):
         return clientFile[len(self.client_prefix):]
 
     def update_client_spec_path_cache(self, files):
-        """ Caching file paths by "p4 where" batch query """
+        """Caching file paths by "p4 where" batch query."""
 
         # List depot file paths exclude that already cached
         fileArgs = [f['path'] for f in files if decode_path(f['path']) not in self.client_spec_path_cache]
@@ -2722,9 +2743,11 @@ def update_client_spec_path_cache(self, files):
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
@@ -2875,10 +2898,10 @@ def extractJobsFromCommit(self, commit):
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
@@ -2907,8 +2930,9 @@ def stripRepoPath(self, path, prefixes):
         return path
 
     def splitFilesIntoBranches(self, commit):
-        """Look at each depotFile in the commit to figure out to what
-           branch it belongs."""
+        """Look at each depotFile in the commit to figure out to what branch it
+           belongs.
+           """
 
         if self.clientSpecDirs:
             files = self.extractFilesFromCommit(commit)
@@ -3180,9 +3204,10 @@ def make_email(self, userid):
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
@@ -4233,8 +4258,7 @@ def __init__(self):
         self.destbranch = "refs/remotes/p4-unshelved"
 
     def renameBranch(self, branch_name):
-        """ Rename the existing branch to branch_name.N
-        """
+        """Rename the existing branch to branch_name.N ."""
 
         found = True
         for i in range(0,1000):
@@ -4250,9 +4274,9 @@ def renameBranch(self, branch_name):
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
@@ -4263,8 +4287,9 @@ def findLastP4Revision(self, starting_point):
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

