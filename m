Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,WEIRD_PORT shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8AB81F428
	for <e@80x24.org>; Wed, 15 Aug 2018 06:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbeHOJSm convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 15 Aug 2018 05:18:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:56845 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbeHOJSm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 05:18:42 -0400
Received: from [217.7.79.146] ([217.7.79.146]) by web-mail.gmx.net
 (3c-app-gmx-bs78.server.lan [172.19.170.226]) (via HTTP); Wed, 15 Aug 2018
 08:27:51 +0200
MIME-Version: 1.0
Message-ID: <trinity-1b5bee3c-e801-483f-b555-7ad0b97f5239-1534314471150@3c-app-gmx-bs78>
From:   =?UTF-8?Q?=22Jochen_K=C3=BChner=22?= <jochen.kuehner@gmx.de>
To:     "Stefan Beller" <sbeller@google.com>
Cc:     git@vger.kernel.org, "Stefan Beller" <sbeller@google.com>
Subject: Aw: [PATCH] git-submodule.sh: accept verbose flag in cmd_update to
 be non-quiet
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 15 Aug 2018 08:27:51 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20180814182202.59442-1-sbeller@google.com>
References: <929572FA-6B1D-4EC7-825B-93B96053A82C@gmx.de>
 <20180814182202.59442-1-sbeller@google.com>
Content-Transfer-Encoding: 8BIT
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:vEsd5abuBvHdI/6NCkZaBy72jRxxsgOfaK/czCca+B2Oz8mxKPCpyvDn7/G8TAD/tqobf
 H1ENTNWtETpN6tVR+FUUII/0Hq+HJsI0GVR/YmET4bkYGnKu/orN/DMsjwDnwAq+RhkCHa36k7yg
 dueXr8JcUYHi9TjUxTUJN4kvANh7GoFPWztgt5+mBC2qY4dh01k4KrtqvllTWOEvQtgqQhmuKgbq
 3kPDeD1tFZxohiu/BVrWbtRs7ETkOBT4zh0FXkt8cMBBXwRnaZTceuru9nc9K4t+UrmFqEEyu3UT
 JM=
X-UI-Out-Filterresults: notjunk:1;V01:K0:/UDM0DLuGDE=:h4BUOAiwLD0UFeA0mmxhQH
 2kf5PI0Rz/VHFm1JLU6Bim/+t5rBy/bi4MmI55b9XHbERF4g0YKeAnOi1+AcNadWMlWiiB+pA
 7FwejgYgZVsEMgUyhfFI1vz9eaThfxl05b4QRSNHEe08KzKFGx1ctU5OFSGN3ciSW8GRa/FR8
 Y02nLRdkB1G/A0JDvA06B7Iuzt1Eua9NLimmRMORAJRFDb3YHZ4oi9yfdjODV/YV4s8K/Ldqw
 vqAjnKvjVvqL1pXIM51XWQ6v6mANun3djnUdmZ7a/qENxObnc+Wjvvq7hjcxrlXb/2qrye7XC
 T44Jiu750XiF60z7NGNeXSoo8C2i4jqc0h9Axw5CSVrMScbi8wA7g5DY9Uk2g7RkPnJ0pKj8D
 jhljiNly382OZ51uABv2rVFfVaqEH0lt0GB3qt2gJmj8bFhfKfQ+JzHUUeoAIE359Yqcz4rmz
 sK6MzO+K/UMKO7LvCnfX+R88RMOneEyPGZbN1gxi6q3bimKv49NV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


 

We use git for windows, there I cannot fin the git-submodule.sh! How can I fix it there?
 

Gesendet: Dienstag, 14. August 2018 um 20:22 Uhr
Von: "Stefan Beller" <sbeller@google.com>
An: jochen.kuehner@gmx.de
Cc: git@vger.kernel.org, "Stefan Beller" <sbeller@google.com>
Betreff: [PATCH] git-submodule.sh: accept verbose flag in cmd_update to be non-quiet
In a56771a668d (builtin/pull: respect verbosity settings in submodules,
2018-01-25), we made sure to pass on both quiet and verbose flag from
builtin/pull.c to the submodule shell script. However git-submodule doesn't
understand a verbose flag, which results in a bug when invoking

git pull --recurse-submodules -v [...]

There are a few different approaches to fix this bug:

1) rewrite 'argv_push_verbosity' or its caller in builtin/pull.c to
cap opt_verbosity at 0. Then 'argv_push_verbosity' would only add
'-q' if any.

2) Have a flag in 'argv_push_verbosity' that specifies if we allow adding
-q or -v (or both).

3) Add -v to git-submodule.sh and make it a no-op

(1) seems like a maintenance burden: What if we add code after
the submodule operations or move submodule operations higher up,
then we have altered the opt_verbosity setting further down the line
in builtin/pull.c.

(2) seems like it could work reasonably well without more regressions

(3) seems easiest to implement as well as actually is a feature with the
last-one-wins rule of passing flags to Git commands.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

On Tue, Aug 14, 2018 at 10:54 AM Jochen Kühner <jochen.kuehner@gmx.de> wrote:
>
> If I set
> git config --global submodule.recurse true
> and run git via:
> git pull --progress -v --no-rebase "origin"
> The command will fail with following output (Errorlevel is 1)
> Fetching submodule submodules/tstemplates
> From http://10.0.102.194:7990/scm/mcc/tstemplates
> = [up to date] feature/robin -> origin/feature/robin
> = [up to date] master -> origin/master
> Already up to date.
> usage: git submodule [--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
> or: git submodule [--quiet] status [--cached] [--recursive] [--] [<path>...]
> or: git submodule [--quiet] init [--] [<path>...]
> or: git submodule [--quiet] deinit [-f|--force] (--all| [--] <path>...)
> or: git submodule [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
> or: git submodule [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
> or: git submodule [--quiet] foreach [--recursive] <command>
> or: git submodule [--quiet] sync [--recursive] [--] [<path>...]
> or: git submodule [--quiet] absorbgitdirs [--] [<path>...]
>
> seams that the “verbose” parameter “-v” is also sent to “git submodules” wich does not support it.
>
> If I remove “-v” it will work.
>
> Problem is, I use TortoiseGit, wich will automatically create this command!

git-submodule.sh | 3 +++
1 file changed, 3 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 8b5ad59bdee..f7fd80345cd 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -438,6 +438,9 @@ cmd_update()
-q|--quiet)
GIT_QUIET=1
;;
+ -v)
+ GIT_QUIET=0
+ ;;
--progress)
progress=1
;;
--
2.18.0.265.g16de1b435c9.dirty
 
