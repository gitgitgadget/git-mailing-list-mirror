From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH] am: replace uses of --resolved with --continue
Date: Wed, 26 Jun 2013 23:06:41 +0300
Message-ID: <1372277201-29324-1-git-send-email-kevin@bracey.fi>
Cc: Jeff King <peff@peff.net>, Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 27 02:54:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Us0UA-0002T7-7h
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 02:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089Ab3F0Ayu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 20:54:50 -0400
Received: from mo4.mail-out.ovh.net ([178.32.228.4]:47117 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557Ab3F0Ayt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 20:54:49 -0400
X-Greylist: delayed 8400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Jun 2013 20:54:49 EDT
Received: from mail92.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 2FD0A104F1AD
	for <git@vger.kernel.org>; Wed, 26 Jun 2013 22:06:49 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 26 Jun 2013 22:06:48 +0200
Received: from 62-183-157-30.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@62.183.157.30)
  by ns0.ovh.net with SMTP; 26 Jun 2013 22:06:47 +0200
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.3.rc0.28.g4b02ef5
X-Ovh-Tracer-Id: 5320721485883216094
X-Ovh-Remote: 62.183.157.30 (62-183-157-30.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiiedrkeekucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiiedrkeekucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229076>

git am was previously modified to provide --continue for consistency
with rebase, merge etc, and the documentation changed to showing
--continue as the primary form.

Complete the work by replacing remaining uses of --resolved by
--continue, most notably in suggested command reminders.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 Documentation/git-am.txt      | 4 ++--
 Documentation/user-manual.txt | 2 +-
 git-am.sh                     | 8 ++++----
 t/t7512-status-help.sh        | 4 ++--
 wt-status.c                   | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 5bbe7b6..54d8461 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -132,7 +132,7 @@ default.   You can use `--no-utf8` to override this.
 --resolvemsg=<msg>::
 	When a patch failure occurs, <msg> will be printed
 	to the screen before exiting.  This overrides the
-	standard message informing you to use `--resolved`
+	standard message informing you to use `--continue`
 	or `--skip` to handle the failure.  This is solely
 	for internal use between 'git rebase' and 'git am'.
 
@@ -176,7 +176,7 @@ aborts in the middle.  You can recover from this in one of two ways:
 
 . hand resolve the conflict in the working directory, and update
   the index file to bring it into a state that the patch should
-  have produced.  Then run the command with the '--resolved' option.
+  have produced.  Then run the command with the '--continue' option.
 
 The command refuses to process new mailboxes until the current
 operation is finished, so if you decide to start over from scratch,
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index e831cc2..8218cf9 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1835,7 +1835,7 @@ Once the index is updated with the results of the conflict
 resolution, instead of creating a new commit, just run
 
 -------------------------------------------------
-$ git am --resolved
+$ git am --continue
 -------------------------------------------------
 
 and Git will create the commit for you and continue applying the
diff --git a/git-am.sh b/git-am.sh
index 9f44509..7ea40fe 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -6,7 +6,7 @@ SUBDIRECTORY_OK=Yes
 OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
 git am [options] [(<mbox>|<Maildir>)...]
-git am [options] (--resolved | --skip | --abort)
+git am [options] (--continue | --skip | --abort)
 --
 i,interactive   run interactively
 b,binary*       (historical option -- no-op)
@@ -102,7 +102,7 @@ stop_here_user_resolve () {
 	    printf '%s\n' "$resolvemsg"
 	    stop_here $1
     fi
-    eval_gettextln "When you have resolved this problem, run \"\$cmdline --resolved\".
+    eval_gettextln "When you have resolved this problem, run \"\$cmdline --continue\".
 If you prefer to skip this patch, run \"\$cmdline --skip\" instead.
 To restore the original branch and stop patching, run \"\$cmdline --abort\"."
 
@@ -523,7 +523,7 @@ Use \"git am --abort\" to remove it.")"
 		esac
 	fi
 
-	# Make sure we are not given --skip, --resolved, nor --abort
+	# Make sure we are not given --skip, --continue, nor --abort
 	test "$skip$resolved$abort" = "" ||
 		die "$(gettext "Resolve operation not in progress, we are not resuming.")"
 
@@ -670,7 +670,7 @@ do
 	#  - patch is the patch body.
 	#
 	# When we are resuming, these files are either already prepared
-	# by the user, or the user can tell us to do so by --resolved flag.
+	# by the user, or the user can tell us to do so by --continue flag.
 	case "$resume" in
 	'')
 		if test -f "$dotest/rebasing"
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 4f09bec..bd8aab0 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -510,7 +510,7 @@ test_expect_success 'status in an am session: file already exists' '
 	cat >expected <<-\EOF &&
 	# On branch am_already_exists
 	# You are in the middle of an am session.
-	#   (fix conflicts and then run "git am --resolved")
+	#   (fix conflicts and then run "git am --continue")
 	#   (use "git am --skip" to skip this patch)
 	#   (use "git am --abort" to restore the original branch)
 	#
@@ -532,7 +532,7 @@ test_expect_success 'status in an am session: file does not exist' '
 	cat >expected <<-\EOF &&
 	# On branch am_not_exists
 	# You are in the middle of an am session.
-	#   (fix conflicts and then run "git am --resolved")
+	#   (fix conflicts and then run "git am --continue")
 	#   (use "git am --skip" to skip this patch)
 	#   (use "git am --abort" to restore the original branch)
 	#
diff --git a/wt-status.c b/wt-status.c
index 438a40d..b191c65 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -826,7 +826,7 @@ static void show_am_in_progress(struct wt_status *s,
 	if (advice_status_hints) {
 		if (!state->am_empty_patch)
 			status_printf_ln(s, color,
-				_("  (fix conflicts and then run \"git am --resolved\")"));
+				_("  (fix conflicts and then run \"git am --continue\")"));
 		status_printf_ln(s, color,
 			_("  (use \"git am --skip\" to skip this patch)"));
 		status_printf_ln(s, color,
-- 
1.8.3.rc0.28.g4b02ef5
