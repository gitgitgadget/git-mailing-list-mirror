From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] bisect: add "git bisect help" subcommand to get a long
 usage string
Date: Fri, 11 Apr 2008 05:55:21 +0200
Message-ID: <20080411055521.b2fe90b3.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Fri Apr 11 05:50:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkAHq-0006ls-IG
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 05:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755589AbYDKDuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 23:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756704AbYDKDuB
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 23:50:01 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:54659 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752295AbYDKDuA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 23:50:00 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 17FEC1AB2B6;
	Fri, 11 Apr 2008 05:49:59 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id AC0201AB2B3;
	Fri, 11 Apr 2008 05:49:58 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79262>

Users are not often aware of the fact that "git bisect -h" can give
them a long usage description, as "git bisect" seems to accept only
dashless subcommands like "start", "good", ...

That's why this patch adds a "git bisect help" subcommand that just
calls "git bisect -h". This new subcommand is also fully documented
in the short usage string (that "git bisect" gives), in the long
usage string and in the man page (that "git help bisect" gives).

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect.txt |    7 +++++++
 git-bisect.sh                |   12 +++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

	Ingo,

	Here is a first step to help users help themselves when using
	git bisect.

	Thanks.

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 96585ae..698ffde 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -15,6 +15,7 @@ DESCRIPTION
 The command takes various subcommands, and different options depending
 on the subcommand:
 
+ git bisect help
  git bisect start [<bad> [<good>...]] [--] [<paths>...]
  git bisect bad [<rev>]
  git bisect good [<rev>...]
@@ -29,6 +30,12 @@ This command uses 'git-rev-list --bisect' option to help drive the
 binary search process to find which change introduced a bug, given an
 old "good" commit object name and a later "bad" commit object name.
 
+Getting help
+~~~~~~~~~~~~
+
+Use "git bisect" to get a short usage description, and "git bisect
+help" or "git bisect -h" to get a long usage description.
+
 Basic bisect commands: start, bad, good
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/git-bisect.sh b/git-bisect.sh
index 48fb92d..a1343f6 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,7 +1,9 @@
 #!/bin/sh
 
-USAGE='[start|bad|good|skip|next|reset|visualize|replay|log|run]'
-LONG_USAGE='git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
+USAGE='[help|start|bad|good|skip|next|reset|visualize|replay|log|run]'
+LONG_USAGE='git bisect help
+        print this long help message.
+git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
         reset bisect state and start bisection.
 git bisect bad [<rev>]
         mark <rev> a known-bad revision.
@@ -20,7 +22,9 @@ git bisect replay <logfile>
 git bisect log
         show bisect log.
 git bisect run <cmd>...
-        use <cmd>... to automatically bisect.'
+        use <cmd>... to automatically bisect.
+
+Please use "git help bisect" to get the full man page.'
 
 OPTIONS_SPEC=
 . git-sh-setup
@@ -465,6 +469,8 @@ case "$#" in
     cmd="$1"
     shift
     case "$cmd" in
+    help)
+        git bisect -h ;;
     start)
         bisect_start "$@" ;;
     bad|good|skip)
-- 
1.5.5.44.g62b31.dirty
