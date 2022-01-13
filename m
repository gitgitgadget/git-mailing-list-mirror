Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD0CC433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbiAMNsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:48:18 -0500
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:26926
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235486AbiAMNsO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:48:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3+qG8ENmWXvWlDJGAy6OkVqG/DyJJ0pSo2IToPyEi4iPJyKWHHTYMZyTHwIKpxAwGc+lqy6R76g3NEjtNaCuplvScIu8iYzMEA57e3rEQA+f3yzTI54GYt1jPNjr73lpkYNxjPpw4trRv0137RarDK+myAlvry3T8kM5q1GtHCpC7JK9JFhWYTNPkSnuG8l3z78t3SFXDcUiFs+UclfWgdGNwa/hAWefPn1pczGJacfIwFjhSCY/ZJIG2u/JVtQDpyn9u+PMdHLSx7LwviI9TeePAWcYmbtdafRIpXHto7Z5kx2gyaY3XdJYOSIdZEZy/bfG0BU+S0fcDoEmaKaxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsVV31lRevvDPXwVCQYHegoa/56SWckftXvec3jxHNQ=;
 b=CpQSr8WvITOyivaIsBQFf37Kyqtf54MRFG00oPFxZGzjyzqbXHb5fWEuAT3dMia/IaxunxdA/k2WMS1RhKOv2LUJRoTRYa1DXejTdoAM14KaRYblWa35kwcHn2ZPZZdg11ZD4a4YjKbTvalhZELNyYXBad30rZxZo14BLt6OE9HqLVibeByTge3Toym/tmPiE1EhWL5pILElPVKvCql4uLhKqhzeVjBWRJ3fDMcCdSAtpLJJ9OtaoEpfQEpdBHWU3cF10GE80AepK+5sNWVqHTMTzIjKEPh5bMRthUB05CLvkQTHwvgTzkEfhhnQ+hKf1G63Qoh9WeA1aOSPqfgHog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsVV31lRevvDPXwVCQYHegoa/56SWckftXvec3jxHNQ=;
 b=uWvdhgMAiC/Vjn090euiFQjxKWe2MRfYJ37LpVQvr65Y+uPHQAHsRzBe2htdsltJ8h3v35GqRpquRqwnURGk0pJOc0rOjoFddM2IzDo8wBRjbzhdTS3ZeI6mWCCt7YKuZQCThjJfuaDdqAMSlm8KLHTfJdqf9seyXU5A82exLFkyHr7s4zGrrrOVU5kk4zVXwOS6w3pKBSsoRgyNVnxEqSH3QZPj70Y3wJOYRIp2UozZQSsR4aAIQrbHhd+LPIa3vQcDHEg4h1V6RAyUlWyPcEkcy6mvSYG+VsrT6jV+WeIP3EHyOQ5VjWSefVTFjPhffUt43Kwq/Uatb3uSGntXog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 13:48:07 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 13:48:07 +0000
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
Subject: [PATCH v2 04/21] git-p4: improve consistency of docstring formatting
Date:   Thu, 13 Jan 2022 13:47:11 +0000
Message-Id: <20220113134728.23192-5-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113134728.23192-1-jholdsworth@nvidia.com>
References: <20220113134728.23192-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0101.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::42) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 616cd1df-529a-4977-960e-08d9d69b5426
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2447F3345AB34C4877E54741C8539@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4OnxscKjGldaf/OXYV+aS5ftpkTAQ57sc/Z/RU911S9bog+NTz7BEv5cteLuErIzFivK9xfO1kCk2536AH3VD/joxRg/QB3TU7PjZxUklYJl3wtiqJZ2dLC2ICdk/M0WGbbqqCiJcMwr3RKwgeDUr50lDhy2ONBCnTBWIGj4CchURt7eEFZfYeP2P9Z3i0AlY56wRGmlCZWrAn4jhJEUS6O38GKxCcOmckdaRlMBT/Upj+uIL+6OlCjQ5pfZPv6FwbQTGrZmSRJ8fd6ufA+rXj703bgJF4PuZ4yAzFgr87DJgmSW7ChIBr9u5eDEW0Pm1L8PimsolOIZoyOcqWyfol0dlzNa2oY3JFzl3YgLN7ACBgNqATJ+i9rz5sKtPBnhRPyE9KvZ2O3114QEiuWxCMIU8b9l1RtuAJDkxQYN5TR42fyNo2pBBa2JsIeSRXXxQXvaoRtBlDHAm1UFS6vlofyENfmNUaws5hX6SbQSrnmrBEY7fEih66Taj2UGOfvU5DsdP9pu90x52pmYyuNMSOjSTsQO1JolySH+czKKvajkjk/o6vYhVBVT2i/ME9epMvo5U83/cHPYxB8xKbrswZAScnFp3KfrBxPETDEQXwJoEE2pOajt857ps2rTDNKgjlCjwmx7R/EooSDRsNOwEf0GR7VqiA6QH9NqIB0MHrUbUetvfxzoRYtFU8y341mTgFcE2Jfr8EOoOnL5z3+JIAWW1zQJjPSVduEfPyb0RuobQ8oZidTit1nhwu579EK++6vq27zOiAlorc/c9WmguoIndv+nGkc55b4mURAWaArpeS7DCkXf2Mb5pVlhkQd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(1076003)(8676002)(66946007)(8936002)(26005)(83380400001)(55236004)(2616005)(4326008)(107886003)(6512007)(6666004)(36756003)(6486002)(186003)(54906003)(316002)(38350700002)(110136005)(38100700002)(7416002)(30864003)(966005)(508600001)(66556008)(5660300002)(6506007)(2906002)(52116002)(86362001)(460985005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+8IRhUOWS+Kk8hLrsH0Muw/W1W/N9ndov08P5BjNADSkY+euikfznA1w6k19?=
 =?us-ascii?Q?LGgnYzl4+CCRQ7TSTSJpQ6jFRBEOuGUN7zETqaw7XgKPBmfNXIBP1toiEuDE?=
 =?us-ascii?Q?qxWUknSVdvN59Scjbcw4h1JKXywHJ573oR1Np+Z+rL4rQZ42pbj4lh5p6PZj?=
 =?us-ascii?Q?+xLBhH8k/3dsXoWFgeCVYqyiBnbDI59c2Xm4WcJUMXXRPAa6+bYPl8xEl2Ug?=
 =?us-ascii?Q?FBRaFcrUCxYIOEReCts70oMNEVm5zA/X/CKbq3ukWohZvvrgzMPJg0xNtatM?=
 =?us-ascii?Q?gt6vwAE4lPLd6XJkhiC2kxZnYuFMjeeGHOrtdgSP0DseIYzQ72R4cmx3l5dA?=
 =?us-ascii?Q?9lrNDMM4vbi0SDEua8gVCnqcSZbQRx/EJObAQAtAr5I9BQV/geWhqfZ6qVYE?=
 =?us-ascii?Q?JSRwy1m459hbkV5FfH/ol7kfyz/OaMmxbaE6fcJ3xx/cu+1aOU52KtE2EhuA?=
 =?us-ascii?Q?22wb/D3S5Y0l6eIwjtDBrF0dePcR6KOA+arc65orfl64nouBdtCoqTZ5xkid?=
 =?us-ascii?Q?Sv64sJlTb77iKx4af1hFNqceHx6IRLFAJXuDA44M7nPkGh0iOifHCaztBzpQ?=
 =?us-ascii?Q?QeClzrP54x+FmqnjSPWd0W3NIbCR5tkV2xQXi+SpBNYLTR7WXSX54wqtc+8O?=
 =?us-ascii?Q?3QEmdsO73w5SbW4JtbosKXkLQwCGlLSInpawALLX/q/l/niyNmZcxO9WRI6b?=
 =?us-ascii?Q?ehnvMHZt+o4AO+fv2MLPQU363PAa9lzR8ngvZ0cxjetStGa7BgHCFjM2tvw5?=
 =?us-ascii?Q?lqSHUjkCAOXuQlkQLMxl7UR+dBeGPW31KzK8vOS9e2uJEwZ3e17FwlyqQ75Y?=
 =?us-ascii?Q?SxEGmmjNEOlAEX2Yx+SPQ2gtRmU7baZa0j+w3dUJFjKERFqyI2ZHgFsYVnx7?=
 =?us-ascii?Q?1CW40W+y/CPSYG32uuqoBtaztHb2ivZvzFkLxVsu5D4cYV8ziTvnh1u9ve+T?=
 =?us-ascii?Q?AiAsVYM5XunSGYOEBhKgGUashgnSzZOGOo7RLbcHqyIi2EryXr9z9IL/4lqo?=
 =?us-ascii?Q?/+TvMADb3iSgg6b+FeuFlo3+mHGEcDSK+rKnQ2lODSfm/+R4bco3eUzw7m7/?=
 =?us-ascii?Q?Eb8zw/mvVzS7vdxbab81LRfGwWepJ3gM6N3wDAPntEXNHxB9iBlUiwaKglmL?=
 =?us-ascii?Q?bkxB6Gu4iLJGVUlnOfkYvJcdIBSww7zPv7/BWw7g8Sk0MfEQQx0prctDaIoj?=
 =?us-ascii?Q?BXIMg9bAwmQqTUD1XVj+ZYvRu97ZE+/rhgZyG2fFFInHSXMQzhtn11UGH1l/?=
 =?us-ascii?Q?hCnVMlxxKjr1wILWYqKetqEND7SroahOLexw2eA3odEIHHmszN5efd9W5oeE?=
 =?us-ascii?Q?T5q6421IVFGg4njCjxcFZVr4C23CVsHd8lT6qqmE7cYf7Pkai09j2rYAB58d?=
 =?us-ascii?Q?dlC6iyEkZXlIaqXtYpv+cjQ3hAhL0VjJ9s2puPoiOUO3gj0yZN/Dai9RhmxI?=
 =?us-ascii?Q?3AbnE5i6uumdU9Rf5/SA/UWTVDTIqmVPORB4KvaqUnXZ9l43t+IBAm7Rt0A+?=
 =?us-ascii?Q?efrilS75qwwtNn9P6JF7Yxp6sNuJnQF6cQlkfB6e1AAwm4GJXa9bjC9hqRiu?=
 =?us-ascii?Q?Zh3L9Mg/X+KK7/KA2oBpg2qkzCDucPgTl+QMF6fMyIenXtkeV/N/BtKfBHZj?=
 =?us-ascii?Q?JgXJxajY/vHQfcNTR+sFSE8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616cd1df-529a-4977-960e-08d9d69b5426
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 13:48:07.1444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: od6YE7By/QgGo4lzbAY66aUmS/CyAmkOLhtf8CsveG7w4yFv2HfNHd6CiOWHcpS53/gylaph+JItHPzM0w1RXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
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
Incoorporates changes suggested by Eric Sunshine.

 git-p4.py | 311 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 168 insertions(+), 143 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 5fb3e09875..62e2763f13 100755
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
@@ -270,21 +270,21 @@ def run_git_hook(cmd, param=[]):
 
 
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

