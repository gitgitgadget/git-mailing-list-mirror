From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 6/17] Document the [<head>...] and -- arguments to git-prune.
Date: Thu, 08 Dec 2005 16:28:20 -0800
Message-ID: <7voe3r9krf.fsf@assigned-by-dhcp.cox.net>
References: <1134084485547-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
	<1134084485869-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
	<7v4q5jb149.fsf@assigned-by-dhcp.cox.net>
	<7vzmnb9m7w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 09 01:29:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkW7d-0002yE-Im
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 01:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932767AbVLIA2W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 19:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbVLIA2W
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 19:28:22 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:64475 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932767AbVLIA2W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 19:28:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051209002639.WSGR17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 8 Dec 2005 19:26:39 -0500
To: git@vger.kernel.org
In-Reply-To: <7vzmnb9m7w.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 08 Dec 2005 15:56:51 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13405>

Junio C Hamano <junkio@cox.net> writes:

> Come to think of it, why would anybody want to pass heads
> explicitly?  It seems to me that it would allow you to _lose_
> objects referenced only from omitted branches...

Not replacing but always including our own refs may be more
desirable (and unarguably much safer), but at the same time I
have a suspicion that that might be forbidding a useful usage I
haven't thought of, so...

---
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 3367c9b..05c8d49 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -8,7 +8,7 @@ git-prune - Prunes all unreachable objec
 
 SYNOPSIS
 --------
-'git-prune' [-n]
+'git-prune' [-n] [--] [<head>...]
 
 DESCRIPTION
 -----------
@@ -27,6 +27,34 @@ OPTIONS
 	Do not remove anything; just report what it would
 	remove.
 
+--::
+	Do not interpret any more arguments as options.
+
+<head>...::
+	Instead of keeping objects
+	reachable from any of our references, keep objects
+	reachable from only listed <head>s.
++
+Note that the explicitly named <head>s are *not* appended to the
+default set of references, but they replace them.  In general you
+would want to say `git prune $(git-rev-parse --all) extra1
+extra2` to keep chains of commits leading to extra1, extra2,
+... in addition to what are reachable from your own refs.
+Saying `git prune extra1 extra2` would *lose* objects reachable
+only from the usual refs, which is usually not what you want.
+
+
+EXAMPLE
+-------
+
+To prune objects not used by your repository and another that
+borrows from your repository via its
+`.git/objects/info/alternates`:
+
+------------
+$ git prune $(git-rev-parse --all) \
+  $(cd ../another && $(git-rev-parse --all))
+------------
 
 Author
 ------
