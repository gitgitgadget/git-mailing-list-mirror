From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] git-blame --incremental: don't use pager
Date: Sun, 28 Jan 2007 15:25:55 +0100
Message-ID: <45BCB273.7010601@lsrfire.ath.cx>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>	<20070127080126.GC9966@spearce.org>	<Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>	<Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>	<7vzm84gmei.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org> <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jan 28 15:26:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBAz3-0004oL-Df
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 15:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbXA1O0G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 09:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbXA1O0G
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 09:26:06 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:35316
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932653AbXA1O0F (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Jan 2007 09:26:05 -0500
Received: from [10.0.1.20] (p508E762C.dip.t-dialin.net [80.142.118.44])
	by neapel230.server4you.de (Postfix) with ESMTP id 3A9ABA08B;
	Sun, 28 Jan 2007 15:26:02 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
In-Reply-To: <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38033>

Starting a pager defeats the purpose of the incremental output
mode.  This changes git-blame to only paginate if --incremental
was not given.

git -p blame --incremental still starts the pager, though.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

 builtin-blame.c |    3 +++
 git.c           |    2 +-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 7a58ee3..02bda5e 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1780,6 +1780,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			argv[unk++] = arg;
 	}
 
+	if (!incremental)
+		setup_pager();
+
 	if (!blame_move_score)
 		blame_move_score = BLAME_DEFAULT_MOVE_SCORE;
 	if (!blame_copy_score)
diff --git a/git.c b/git.c
index 530e99f..e9febc3 100644
--- a/git.c
+++ b/git.c
@@ -217,7 +217,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "annotate", cmd_annotate, USE_PAGER },
 		{ "apply", cmd_apply },
 		{ "archive", cmd_archive },
-		{ "blame", cmd_blame, RUN_SETUP | USE_PAGER },
+		{ "blame", cmd_blame, RUN_SETUP },
 		{ "branch", cmd_branch, RUN_SETUP },
 		{ "cat-file", cmd_cat_file, RUN_SETUP },
 		{ "checkout-index", cmd_checkout_index, RUN_SETUP },
