X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] config option core.showroot to enable showing the diff of the root commit
Date: Thu, 23 Nov 2006 17:30:37 -0800
Message-ID: <7vzmahfx6q.fsf@assigned-by-dhcp.cox.net>
References: <200611211341.48862.andyparkins@gmail.com>
	<8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com>
	<slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx>
	<Pine.LNX.4.64.0611210820100.3338@woody.osdl.org>
	<20061121180643.GC7201@pasky.or.cz> <ejvfng$cj6$1@sea.gmane.org>
	<20061121182135.GD7201@pasky.or.cz>
	<7v64d8y4tu.fsf@assigned-by-dhcp.cox.net>
	<slrnemaqt1.esn.Peter.B.Baumann@xp.machine.xx>
	<7virh5khrc.fsf@assigned-by-dhcp.cox.net>
	<slrnemcc0b.ncc.Peter.B.Baumann@xp.machine.xx>
	<7vejrthf2y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 01:41:00 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vejrthf2y.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 23 Nov 2006 16:18:45 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32184>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnPtx-0005aw-2Y for gcvg-git@gmane.org; Fri, 24 Nov
 2006 02:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757548AbWKXBaj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 20:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757549AbWKXBaj
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 20:30:39 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:12190 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1757548AbWKXBai
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 20:30:38 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061124013037.BKYS20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Thu, 23
 Nov 2006 20:30:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qRWl1V00X1kojtg0000000; Thu, 23 Nov 2006
 20:30:45 -0500
To: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
> writes:
>
>> Sorry, but I don't understand. The color handling doesn't look any different
>> to me than the handling of the other config entrys. Did I miss something?
>
> "git-diff-tree --color HEAD" (with explicit command line
> instruction to color it) still colours its output, but "[diff]
> color = auto" in ~/.gitconfig would not affect the coloring.
> Hence, "git-diff-tree HEAD" with the configuration entry gives
> monochrome.
>
> "git diff HEAD" on the other hand looks at '[diff] color = auto"
> and will color its output without being told on the command
> line.

Since this is about "log" family that deals with revision
structure, how about....

-- >8 --
[PATCH] config option log.showroot to show the diff of root commits

From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>

This allows one to see a root commit as a diff in commands like git-log,
git-show and git-whatchanged.

Signed-off-by: Peter Baumann <Peter.B.Baumannn@stud.informatik.uni-erlangen.de>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/config.txt |    6 ++++++
 builtin-log.c            |   20 ++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9d3c71c..9090762 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -219,6 +219,12 @@ i18n.commitEncoding::
 	browser (and possibly at other places in the future or in other
 	porcelains). See e.g. gitlink:git-mailinfo[1]. Defaults to 'utf-8'.
 
+log.showroot::
+	If true, the initial commit will be shown as a big creation event.
+	This is equivalent to a diff against an empty tree.
+	Tools like gitlink:git-log[1] or gitlink:git-whatchanged[1], which
+	normally hide the root commit will now show it. True by default.
+
 merge.summary::
 	Whether to include summaries of merged commits in newly created
 	merge commit messages. False by default.
diff --git a/builtin-log.c b/builtin-log.c
index fedb013..7acf5d3 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -13,6 +13,8 @@
 #include <time.h>
 #include <sys/time.h>
 
+static int default_show_root = 1;
+
 /* this is in builtin-diff.c */
 void add_head(struct rev_info *revs);
 
@@ -22,6 +24,7 @@ static void cmd_log_init(int argc, const
 	rev->abbrev = DEFAULT_ABBREV;
 	rev->commit_format = CMIT_FMT_DEFAULT;
 	rev->verbose_header = 1;
+	rev->show_root_diff = default_show_root;
 	argc = setup_revisions(argc, argv, rev, "HEAD");
 	if (rev->diffopt.pickaxe || rev->diffopt.filter)
 		rev->always_show_header = 0;
@@ -44,11 +47,20 @@ static int cmd_log_walk(struct rev_info
 	return 0;
 }
 
+static int git_log_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "log.showroot")) {
+		default_show_root = git_config_bool(var, value);
+		return 0;
+	}
+	return git_diff_ui_config(var, value);
+}
+
 int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
 
-	git_config(git_diff_ui_config);
+	git_config(git_log_config);
 	init_revisions(&rev, prefix);
 	rev.diff = 1;
 	rev.diffopt.recursive = 1;
@@ -63,7 +75,7 @@ int cmd_show(int argc, const char **argv
 {
 	struct rev_info rev;
 
-	git_config(git_diff_ui_config);
+	git_config(git_log_config);
 	init_revisions(&rev, prefix);
 	rev.diff = 1;
 	rev.diffopt.recursive = 1;
@@ -80,7 +92,7 @@ int cmd_log(int argc, const char **argv,
 {
 	struct rev_info rev;
 
-	git_config(git_diff_ui_config);
+	git_config(git_log_config);
 	init_revisions(&rev, prefix);
 	rev.always_show_header = 1;
 	cmd_log_init(argc, argv, prefix, &rev);
@@ -109,7 +121,7 @@ static int git_format_config(const char
 	if (!strcmp(var, "diff.color")) {
 		return 0;
 	}
-	return git_diff_ui_config(var, value);
+	return git_log_config(var, value);
 }
 
 
-- 
1.4.4.1.g77614

