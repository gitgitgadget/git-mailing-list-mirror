From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] submodule update: document the '--checkout' option
Date: Thu, 27 Feb 2014 22:01:40 +0000
Message-ID: <530FB5C4.8080400@web.de>
References: <20140225110316.GU11566@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Matthijs Kooijman <matthijs@stdin.nl>
X-From: git-owner@vger.kernel.org Thu Feb 27 23:01:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ91Y-0000yx-Tp
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 23:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbaB0WBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 17:01:45 -0500
Received: from mout.web.de ([212.227.17.11]:50673 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbaB0WBo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 17:01:44 -0500
Received: from [192.168.1.102] ([90.174.2.86]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0LlneG-1WsCiz2zq4-00ZQ0L for <git@vger.kernel.org>; Thu,
 27 Feb 2014 23:01:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140225110316.GU11566@login.drsnuggles.stderr.nl>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:I0Z2JJcaLXsDiVlAOPcs5oRpVmkSua2B95uS3l+Yd8HGgiHCZgz
 oyAoEMXeSkO1aPzpi2Qwpee7Pv+aEm5/GAwcxq4gDFSdeI3Wu085sdJGtcjiKe13dv8V3VZ
 OvLgJacz0YyRxd2pJy57P6IasoSTV+SbNzEDFyJN37Z6pzoqOLjg3T0EfKNqh+edQIoE8AY
 OSoqQFsf3JZfg2ZvEs7jA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242864>

Commit 322bb6e12f (add update 'none' flag to disable update of submodule
by default) added the '--checkout' option to "git submodule update" but
forgot to explicitly document it in the synopsis and the man page (It is
only mentioned implicitly in the man page).

Document this option in synopsis and man page too. While at it make it
more clear that only one of '--checkout', '--merge' or '--rebase' make
sense by grouping them together.

Reported-by: Matthijs Kooijman <matthijs@stdin.nl>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 25.02.2014 11:03, schrieb Matthijs Kooijman:
> it seems git submodule supports --checkout, which is also mentioned
> indirectly in the manpage. However, the option itself is not mentioned
> in the synopsis or detailed option list.

Good point. What about this?


 Documentation/git-submodule.txt | 13 +++++++++++--
 git-submodule.sh                |  2 +-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index bfef8a0..9054217 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -15,8 +15,8 @@ SYNOPSIS
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
-	      [-f|--force] [--rebase] [--reference <repository>] [--depth <depth>]
-	      [--merge] [--recursive] [--] [<path>...]
+	      [-f|--force] [--checkout|--merge|--rebase] [--reference <repository>]
+	      [--depth <depth>] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
@@ -287,6 +287,15 @@ SHA-1.  If you don't want to fetch, you should use `submodule update
 	This option is only valid for the update command.
 	Don't fetch new objects from the remote site.

+--checkout::
+	This option is only valid for the update command.
+	Checkout the commit recorded in the superproject on a detached HEAD
+	in the submodule. This is the default behavior, the main use of
+	this option is to override `submodule.$name.update` when set to
+	`merge`, `rebase` or `none`.
+	If the key `submodule.$name.update` is either not explicitly set or
+	set to `checkout`, this option is implicit.
+
 --merge::
 	This option is only valid for the update command.
 	Merge the commit recorded in the superproject into the current branch
diff --git a/git-submodule.sh b/git-submodule.sh
index 4a30087..65cf963 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -9,7 +9,7 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--reference <repository>] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
-- 
1.8.3.1
