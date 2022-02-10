Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370B2C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244683AbiBJQrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:47:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244687AbiBJQrE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:47:04 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2054.outbound.protection.outlook.com [40.107.96.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE93189
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:47:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2X1ZAvQnwzuyu5ed+az5piOHbB2JD2uSNFsALaqWh8MJLKDuCbbJ1a525HspGWc4jlzAFHwigeX2E7uqj6zTBSJGYDZILg16KnItS7y3onDtg1KffHP9hmBBKfINEGUo7Fesw49eHGS/uppl7MK+qOp+hMd4dOE2PB0aKGn9AZ0Xco9cO1i7JaG7uURvvOhvye9GRtddAo3StaMrOGGm//CfVcTkkqjm0X3CixoD+Fvzd/ivLl4OEfb6GRalGfijYqqkx5HwkhrHhFwiuf8PHVTV1LDmI0D+4JwWC02j8utADk2PpzA2y0YRKHL4hlG/V9sBtXPxN4wuWt0R1QXmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwWQkYwL4sxjRoxazK30x8t5z6ab4g2qeYlt7XbJhrQ=;
 b=j8WHFooxlBadG41eALUGMo9YhL5CzAj/Vb0HIJtWvVZb9BNPyBnVPYhgDEp2o/FBXahfQOfHMAg3fqtfiIMnTsIGMqQ9N8fKxHjNnYUkgB8gGdJEAzrT+KPHIwbAn67XoO5RIq2w7ThHoDsfuUs6xvOnRTa498eeGCRSSEVeoV3MwOqvoA2/lkX1OA3uZTVz5JL1BXDcRRkrTrfXP+BcthyHWftVr822MxPFpd6DOG6f6z8BRy41DltUNubZGKPM1/im+ZEN8dmqf+GPF+W23gD4UFWlsTYSVy+x4+Ur6hbxQZdBYLujrF9Q6k5wKrHrT2S+C5miy2Zl1lDVqgiynQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwWQkYwL4sxjRoxazK30x8t5z6ab4g2qeYlt7XbJhrQ=;
 b=AmTGqhb7UPjckc17CX0pPzw7SUwT0P8HvbpZhKcjbCUIeRieeoc2/vbkYxCqi0+4g0/dZC/+w3NJbhAYIzwo6rlSpNuNOxhTIYfBdM93qCHBeooiycyr5tcCWyQ/juD2Pon+cmIj3YK951ZE7iEe3kqGF0v3o/XuyqGOiXHy1vNlMmRK9thMFAkhSFzNYu8+mXwvng/FRCU1SLBYuPhwLWENkl8jhxgVHiZ6GOJMeGWJNEz6kpaqNztaxrNXIL2lUzCxajCTJMhRGqw0KJEYi+1WEW5f/xOuVAhcw/J0T7mSoTBFMIagUroaghFmGmLG8kcnPzt4G6JjjDxIkLAGDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BN6PR12MB1362.namprd12.prod.outlook.com (2603:10b6:404:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:47:02 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:47:02 +0000
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
Subject: [PATCH v4 04/22] git-p4: improve consistency of docstring formatting
Date:   Thu, 10 Feb 2022 16:46:09 +0000
Message-Id: <20220210164627.279520-5-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 788db561-4b3a-48c5-da4d-08d9ecb4f658
X-MS-TrafficTypeDiagnostic: BN6PR12MB1362:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1362D4C57E42A2598AC25BD2C82F9@BN6PR12MB1362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0fc63tryLXkh8yIxW8rpxUX0v23bozk53Q65TUO6rOIXvv6RFY1HA5/K1lTBUtSarLPzpeMLt6k/BLhAiDEuiaRLkrFVPRRiZDh+IAkgY17glocxl6URHJZHMdluZsAN2vx/m7VSxqGSSL+WnNdh+t7Ye2/ccg5ThJRpv19I2YP3NcBSHbtDKbo7gnhPOKM4VMKyx/OYVmKtw442N0CljTMszKQtxyopHOs0VMYckdRmfKuxBwiu4+xRFAzgMAz9U2loNIigLWs17apG/KHfx2N4NQfb+NCUuoiVphiSqwVThnGV6kJvPZdhKHq8/iQAzIlGJ9PVKo6sd7brp44vwD8XtKK49/d9JpGahvr7HZmhvb41vDDZPgnrwh6e+bPQd/OESTQl+IktmxZr07QscAdyU7tmgmEvXDvJualg68XDa1LkfejslMHDuNo2xQ0Qb0nxkSbjHUwoIt6GwWJRjF28EZcavrxuCKFz3BqaW9yc8jgbXMlYM0J50a8yqxiOxBN17mWVFEQSxwPiaXByZ/PwJ0iUBFimbHtd6nJWzYDlmnTAM7aHVoty422Q5slBR8+1Kk3tc8iBWTIlgu1KFVDWnRR/EmyP49V531VK04ke7ZvWCgu+mpkHfl88PptyhFde/2wc+7akcrWxOb7VwGvFyW9r0AX9kqJTVuWcujbNycvl6dNQ5BKtCPbQ5ca5DEd3wo7qVs5hHt9CeflITqh+73fZLPFzjzFG4sP6cY7deDpq09dhDLr+Nutgn3EFT5i72C2v+GuuRbc+Uv2dDVX+c5lg9DCGRDigzB/TJVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6486002)(966005)(7416002)(2906002)(8676002)(66946007)(52116002)(6506007)(8936002)(83380400001)(2616005)(30864003)(38100700002)(38350700002)(4326008)(1076003)(107886003)(508600001)(66556008)(66476007)(5660300002)(6512007)(36756003)(55236004)(316002)(110136005)(54906003)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ucylgckAhAPI9ooyGCPcur6RmM5aZgqjn/frtrB+PTTsFs+CZCoUjQyazIOs?=
 =?us-ascii?Q?LQD95sl+JFfL4t+bDiPZPwtaSUmxgk242oaSlH+rfhWvQuXrSEZlt3Bei+lK?=
 =?us-ascii?Q?Ec3mEn2uwx/ZgsHiI5oLWEiX/qzNsfA0flJTWo6I27gLSj60OjrvmWWh4GuA?=
 =?us-ascii?Q?P9aBxmtJXUualKuiRhUmJ7/bX9o8DUJsjyr6+AcoRCybsNrMv1BPp1MkWIz+?=
 =?us-ascii?Q?geFDP6jAbZeRTYiLsMGsqaf3XUoVP/Is0PDZ246ogKAl1Xh2httbzZVziu39?=
 =?us-ascii?Q?A/sJcocK176ECRIRQ6ddGAZ+mo2UiE1eoZ4CLP/11RkgO+CaBrV3aaGcXi1q?=
 =?us-ascii?Q?o4X9tHqmpm01Z4PlPpbKpasgWIzwNeICP9TieMqJDlRU75Q9h2aqztj3227r?=
 =?us-ascii?Q?YMuYWK79itichGXhwMHOsIZEi08Ga+Z4tePqefTxuTfj6ASTXJ8j4WmgGn/4?=
 =?us-ascii?Q?y7WSDXq81n1UxfIy6R3ZWtAXt0g8wmawJw7l72xTD1fiHNmEDPv8I/hx6Sxc?=
 =?us-ascii?Q?F0jD1BDYwpUcy71dP/b6B1ayylMVsOpw9KOo1BDeWuUNN7n7nI6YsWGHobaZ?=
 =?us-ascii?Q?InD0gfMZPZ7zsYHf5UfFDYtPP98dCQi6PiXXXFakXiE37un6jmSsQsPt5w0H?=
 =?us-ascii?Q?lGZYIqmtAj7NyQ6UxJvcJKOTCw9t8xIqeGYrWn1pssZtqrYEEsbb9rTK0df4?=
 =?us-ascii?Q?QRUgyPVtkTP2u2W+W0f97X2yRq+6zAYsHFkRLrsGHw0qDOIllh3ZKYRlD/dM?=
 =?us-ascii?Q?OtvEX/5lwm19eDm8RaZOdo0QLz85inXSNTinfeCt8p8U08I3rDA+JdWnPCXU?=
 =?us-ascii?Q?ryim6iPhUMJqWsgncZzP2Q+yddQsr8k0WT+mWWBOUaJ3uDp/KzRH+KD0zllU?=
 =?us-ascii?Q?mpVacU1vf/cVdKGQO5aE3N1s9YYKakZ8xGQ0+xJx0X/fFs1WpJoMcezLwT/H?=
 =?us-ascii?Q?bvhG8RVVzcethLxjKWCu/7IDfucsVwu/rMpvsYUbDw/F3qW0y8GOsIAjxmeH?=
 =?us-ascii?Q?828qsdg6tcPINyl2ax0nlUkeTEGZ1O9umht9ULyFM0zPU69tb8QvTDp5YolC?=
 =?us-ascii?Q?bZ4Z1nRZ0QhV8e9pHAnzZSD0BsX5mkdSjiYYRp9nwMn37tAxYdoNZZbBrJY1?=
 =?us-ascii?Q?T+viTdW2o0SZCJ/bgSIa36NErkkLtZkLYj8PkJVh2ai3Y37XFPooUJfYwudq?=
 =?us-ascii?Q?PtX4mS4Iqwn/MDHz3hnQw8GQkS6MW3EMTu/caAgdBJ4yR+KL2HYv/201jkDW?=
 =?us-ascii?Q?wGJL6YwVPlAC4i3BeO1OIPBwctb3KTB/BLWEaxXBnQ0Qf63KWOOIptZLKHUl?=
 =?us-ascii?Q?2tPsHwXeQENruSunCLB79fI9NKYqDMoE6wTlD7yOEw2n51xgBXXLxH8rm5Mo?=
 =?us-ascii?Q?cFky1/DlfxCccAj0mWo9sLSnn1KZlggwux7UczYsk+2x0AU8m1CSLaxO0EKA?=
 =?us-ascii?Q?tBWhnzq5khtBOS7YbR2rcFjLEVISHN6FsJp48Qs8BFTvdxeWDOsx7T13+ncH?=
 =?us-ascii?Q?QUpFoOFFyfqiOVpws0aaaSlL42fkWHmDAUeMdf0DvOGpreTlWSPQxrrjuWWM?=
 =?us-ascii?Q?zF7VwIx+s1DGgK5YwOhYNaPXGPagZilAkI3Kux2NMPXrMu+GuynPs908UdBB?=
 =?us-ascii?Q?JM010qx/oJHNj1XsNkyBj2U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788db561-4b3a-48c5-da4d-08d9ecb4f658
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:47:02.3265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSW3sbk1rnpOrq3xYkqdOGJuox6FKHrLkpJmh/dMgruQichCybHTCGKP44k7dqo291/KrXPaNcIdvlGokrqGTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1362
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
 git-p4.py | 291 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 158 insertions(+), 133 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index a9be9ab13c..10b51b17de 100755
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
@@ -262,10 +262,9 @@ def p4_write_pipe(c, stdin, *k, **kw):
 
 
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
 
@@ -276,12 +275,12 @@ def read_pipe_full(c, *k, **kw):
 
 
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
@@ -294,9 +293,9 @@ def read_pipe(c, ignore_error=False, raw=False, *k, **kw):
 
 
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
@@ -324,14 +323,15 @@ def read_pipe_lines(c, raw=False, *k, **kw):
 
 
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
@@ -340,10 +340,11 @@ def p4_has_command(cmd):
 
 
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
@@ -372,7 +373,7 @@ def system(cmd, ignore_error=False, *k, **kw):
 
 
 def p4_system(cmd, *k, **kw):
-    """Specifically invoke p4 as the system command. """
+    """Specifically invoke p4 as the system command."""
     real_cmd = p4_build_cmd(cmd)
     retcode = subprocess.call(real_cmd, *k, **kw)
     if retcode:
@@ -384,8 +385,8 @@ def die_bad_access(s):
 
 
 def p4_check_access(min_expiration=1):
-    """ Check if we can access Perforce - account still logged in
-    """
+    """Check if we can access Perforce - account still logged in."""
+
     results = p4CmdList(["login", "-s"])
 
     if len(results) == 0:
@@ -433,14 +434,14 @@ def p4_check_access(min_expiration=1):
 
 
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
@@ -495,9 +496,11 @@ def p4_last_change():
 
 
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
@@ -651,21 +654,22 @@ def getGitTags():
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
@@ -693,14 +697,16 @@ def isModeExec(mode):
 
 
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
@@ -710,7 +716,7 @@ def __init__(self, exit_code, p4_result):
 
 
 class P4RequestSizeException(P4ServerException):
-    """ One of the maxresults or maxscanrows errors """
+    """One of the maxresults or maxscanrows errors."""
 
     def __init__(self, exit_code, p4_result, limit):
         super(P4RequestSizeException, self).__init__(exit_code, p4_result)
@@ -718,7 +724,7 @@ def __init__(self, exit_code, p4_result, limit):
 
 
 class P4CommandException(P4Exception):
-    """ Something went wrong calling p4 which means we have to give up """
+    """Something went wrong calling p4 which means we have to give up."""
 
     def __init__(self, msg):
         self.msg = msg
@@ -943,7 +949,8 @@ def gitConfig(key, typeSpecifier=None):
 def gitConfigBool(key):
     """Return a bool, using git config --bool.  It is True only if the
        variable is set to true, and False if set to false or not present
-       in the config."""
+       in the config.
+       """
 
     if key not in _gitConfig:
         _gitConfig[key] = gitConfig(key, '--bool') == "true"
@@ -976,7 +983,8 @@ def p4BranchesInGit(branchesAreInRemotes=True):
        in remotes or heads as specified by the argument.  Return
        a dictionary of { branch: revision } for each one found.
        The branch names are the short names, without any
-       "p4/" prefix."""
+       "p4/" prefix.
+       """
 
     branches = {}
 
@@ -1207,7 +1215,8 @@ def p4PathStartsWith(path, prefix):
 
 def getClientSpec():
     """Look at the p4 client spec, create a View() object that contains
-       all the mappings, and return it."""
+       all the mappings, and return it.
+       """
 
     specList = p4CmdList(["client", "-o"])
     if len(specList) != 1:
@@ -1290,13 +1299,15 @@ def __init__(self, writeToGitStream):
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
@@ -1344,7 +1355,8 @@ def isLargeFile(self, relPath):
     def processContent(self, git_mode, relPath, contents):
         """Processes the content of git fast import. This method decides if a
            file is stored in the large file system and handles all necessary
-           steps."""
+           steps.
+           """
         if self.exceedsLargeFileThreshold(relPath, contents) or self.hasLargeFileExtension(relPath):
             contentTempFile = self.generateTempFile(contents)
             (pointer_git_mode, contents, localLargeFile) = self.generatePointer(contentTempFile)
@@ -1369,7 +1381,8 @@ class MockLFS(LargeFileSystem):
 
     def generatePointer(self, contentFile):
         """The pointer content is the original content prefixed with "pointer-".
-           The local filename of the large file storage is derived from the file content.
+           The local filename of the large file storage is derived from the
+           file content.
            """
         with open(contentFile, 'r') as f:
             content = next(f)
@@ -1379,8 +1392,8 @@ def generatePointer(self, contentFile):
             return (gitMode, pointerContents, localLargeFile)
 
     def pushFile(self, localLargeFile):
-        """The remote filename of the large file storage is the same as the local
-           one but in a different directory.
+        """The remote filename of the large file storage is the same as the
+           local one but in a different directory.
            """
         remotePath = os.path.join(os.path.dirname(localLargeFile), '..', 'remote')
         if not os.path.exists(remotePath):
@@ -1390,7 +1403,8 @@ def pushFile(self, localLargeFile):
 
 class GitLFS(LargeFileSystem):
     """Git LFS as backend for the git-p4 large file system.
-       See https://git-lfs.github.com/ for details."""
+       See https://git-lfs.github.com/ for details.
+       """
 
     def __init__(self, *args):
         LargeFileSystem.__init__(self, *args)
@@ -1656,20 +1670,20 @@ def check(self):
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
@@ -1680,9 +1694,10 @@ def separate_jobs_from_description(self, message):
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
@@ -1807,11 +1822,13 @@ def canChangeChangelists(self):
 
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
 
@@ -1874,8 +1891,10 @@ def prepareSubmitTemplate(self, changelist=None):
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
@@ -2571,8 +2590,9 @@ def run(self, args):
 
 
 class View(object):
-    """Represent a p4 view ("p4 help views"), and map files in a
-       repo according to the view."""
+    """Represent a p4 view ("p4 help views"), and map files in a repo according
+       to the view.
+       """
 
     def __init__(self, client_name):
         self.mappings = []
@@ -2581,9 +2601,10 @@ def __init__(self, client_name):
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
@@ -2632,7 +2653,7 @@ def convert_client_path(self, clientFile):
         return clientFile[len(self.client_prefix):]
 
     def update_client_spec_path_cache(self, files):
-        """ Caching file paths by "p4 where" batch query """
+        """Caching file paths by "p4 where" batch query."""
 
         # List depot file paths exclude that already cached
         fileArgs = [f['path'] for f in files if decode_path(f['path']) not in self.client_spec_path_cache]
@@ -2664,9 +2685,11 @@ def update_client_spec_path_cache(self, files):
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
@@ -2817,10 +2840,10 @@ def extractJobsFromCommit(self, commit):
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
@@ -2849,8 +2872,9 @@ def stripRepoPath(self, path, prefixes):
         return path
 
     def splitFilesIntoBranches(self, commit):
-        """Look at each depotFile in the commit to figure out to what
-           branch it belongs."""
+        """Look at each depotFile in the commit to figure out to what branch it
+           belongs.
+           """
 
         if self.clientSpecDirs:
             files = self.extractFilesFromCommit(commit)
@@ -3122,9 +3146,10 @@ def make_email(self, userid):
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
@@ -4175,8 +4200,7 @@ def __init__(self):
         self.destbranch = "refs/remotes/p4-unshelved"
 
     def renameBranch(self, branch_name):
-        """ Rename the existing branch to branch_name.N
-        """
+        """Rename the existing branch to branch_name.N ."""
 
         found = True
         for i in range(0,1000):
@@ -4192,9 +4216,9 @@ def renameBranch(self, branch_name):
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
@@ -4205,8 +4229,9 @@ def findLastP4Revision(self, starting_point):
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
2.35.GIT

