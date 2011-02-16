From: Johan Herland <johan@herland.net>
Subject: [PATCH] push.default: Rename 'tracking' to 'upstream'
Date: Wed, 16 Feb 2011 01:54:24 +0100
Message-ID: <201102160154.24744.johan@herland.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102151606.21040.johan@herland.net>
 <7vipwlp3yv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 01:56:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpVh4-000250-VV
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 01:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933499Ab1BPAye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 19:54:34 -0500
Received: from smtp.getmail.no ([84.208.15.66]:40336 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933373Ab1BPAya (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 19:54:30 -0500
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LGO004PHQIQV850@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 16 Feb 2011 01:54:26 +0100 (MET)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 098E01EEF454_D5B2042B	for <git@vger.kernel.org>; Wed,
 16 Feb 2011 00:54:26 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 66EDB1EEF3C1_D5B2041F	for <git@vger.kernel.org>; Wed,
 16 Feb 2011 00:54:25 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LGO00M9LQIPQ400@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 16 Feb 2011 01:54:25 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <7vipwlp3yv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166909>

Users are sometimes confused with two different types of "tracking" behavior
in Git: "remote-tracking" branches (e.g. refs/remotes/*/*) versus the
merge/rebase relationship between a local branch and its @{upstream}
(controlled by branch.foo.remote and branch.foo.merge config settings).

When the push.default is set to 'tracking', it specifies that a branch should
be pushed to its @{upstream} branch. In other words, setting push.default to
'tracking' applies only to the latter of the above two types of "tracking"
behavior.

In order to make this more understandable to the user, we rename the
push.default == 'tracking' option to push.default == 'upstream'.

push.default == 'tracking' is left as a deprecated synonym for 'upstream'.

Signed-off-by: Johan Herland <johan@herland.net>
---

On Tuesday 15 February 2011, Junio C Hamano wrote:
> Perhaps leave "tracking" as a deprecated synonym and add "upstream" as
> the official name of the mode?

This patch does just that.

I took the liberty of renaming the setup_push_tracking() function as
well, and rephrasing its error messages. Although this may be
considered code churn, I think it's worth keeping the function naming
closer to the phrasing in the documentation.


Have fun! :)

...Johan


 Documentation/config.txt |    3 ++-
 builtin/push.c           |   10 +++++-----
 cache.h                  |    2 +-
 config.c                 |    6 ++++--
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c5e1835..c995a1a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1591,7 +1591,8 @@ push.default::
 * `matching` - push all matching branches.
   All branches having the same name in both ends are considered to be
   matching. This is the default.
-* `tracking` - push the current branch to its upstream branch.
+* `upstream` - push the current branch to its upstream branch.
+* `tracking` - deprecated synonym for `upstream`.
 * `current` - push the current branch to a branch of the same name.
 
 rebase.stat::
diff --git a/builtin/push.c b/builtin/push.c
index e655eb7..31da418 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -64,17 +64,17 @@ static void set_refspecs(const char **refs, int nr)
 	}
 }
 
-static void setup_push_tracking(void)
+static void setup_push_upstream(void)
 {
 	struct strbuf refspec = STRBUF_INIT;
 	struct branch *branch = branch_get(NULL);
 	if (!branch)
 		die("You are not currently on a branch.");
 	if (!branch->merge_nr || !branch->merge)
-		die("The current branch %s is not tracking anything.",
+		die("The current branch %s has no upstream branch.",
 		    branch->name);
 	if (branch->merge_nr != 1)
-		die("The current branch %s is tracking multiple branches, "
+		die("The current branch %s has multiple upstream branches, "
 		    "refusing to push.", branch->name);
 	strbuf_addf(&refspec, "%s:%s", branch->name, branch->merge[0]->src);
 	add_refspec(refspec.buf);
@@ -88,8 +88,8 @@ static void setup_default_push_refspecs(void)
 		add_refspec(":");
 		break;
 
-	case PUSH_DEFAULT_TRACKING:
-		setup_push_tracking();
+	case PUSH_DEFAULT_UPSTREAM:
+		setup_push_upstream();
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
diff --git a/cache.h b/cache.h
index d83d68c..7acf120 100644
--- a/cache.h
+++ b/cache.h
@@ -608,7 +608,7 @@ enum rebase_setup_type {
 enum push_default_type {
 	PUSH_DEFAULT_NOTHING = 0,
 	PUSH_DEFAULT_MATCHING,
-	PUSH_DEFAULT_TRACKING,
+	PUSH_DEFAULT_UPSTREAM,
 	PUSH_DEFAULT_CURRENT
 };
 
diff --git a/config.c b/config.c
index 625e051..9184900 100644
--- a/config.c
+++ b/config.c
@@ -737,8 +737,10 @@ static int git_default_push_config(const char *var, const char *value)
 			push_default = PUSH_DEFAULT_NOTHING;
 		else if (!strcmp(value, "matching"))
 			push_default = PUSH_DEFAULT_MATCHING;
-		else if (!strcmp(value, "tracking"))
-			push_default = PUSH_DEFAULT_TRACKING;
+		else if (!strcmp(value, "upstream"))
+			push_default = PUSH_DEFAULT_UPSTREAM;
+		else if (!strcmp(value, "tracking")) /* deprecated */
+			push_default = PUSH_DEFAULT_UPSTREAM;
 		else if (!strcmp(value, "current"))
 			push_default = PUSH_DEFAULT_CURRENT;
 		else {
-- 
1.7.4
