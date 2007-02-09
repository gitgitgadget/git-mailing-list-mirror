From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git rescue mission
Date: Thu, 08 Feb 2007 16:53:32 -0800
Message-ID: <7vy7n8up6b.fsf@assigned-by-dhcp.cox.net>
References: <17866.27739.701406.722074@lisa.zopyra.com>
	<7vr6t13251.fsf@assigned-by-dhcp.cox.net>
	<200702081028.31493.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bill Lear <rael@zopyra.com>
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 09 01:53:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFK1I-0001cJ-39
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 01:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423205AbXBIAxe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 19:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423209AbXBIAxe
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 19:53:34 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:36269 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423205AbXBIAxd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 19:53:33 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070209005332.QWTT1306.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Thu, 8 Feb 2007 19:53:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MCtY1W0051kojtg0000000; Thu, 08 Feb 2007 19:53:32 -0500
In-Reply-To: <200702081028.31493.litvinov2004@gmail.com> (Alexander Litvinov's
	message of "Thu, 8 Feb 2007 10:28:31 +0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39145>

Alexander Litvinov <litvinov2004@gmail.com> writes:

> I think this should go to git-pull/git-clone man
> pages. Personaly for me this post dispels dark magic about
> git-pull's merging logic. I always did git-fetch and then
> git-pull . <some-branch> to control what and where should be
> merged.

Fair enough.  But I am known to be very bad at writing, so I
would ask the list to proofread this to see if it makes sense,
and prefereably rewrite it to make it easier to understand.

I think it is technically accurate -- I just do not know if I am
not writing enough, leaving certain necessary things unsaid,
because I assumed (wrongly) too much knowledge on the reader's
side.


diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index a81d68c..94478ed 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -33,6 +33,60 @@ include::urls.txt[]
 
 include::merge-strategies.txt[]
 
+DEFAULT BEHAVIOUR
+-----------------
+
+Often people use `git pull` without giving any parameter.
+Traditionally, this has been equivalent to saying `git pull
+origin`.  However, when configuration `branch.<name>.remote` is
+present while on branch `<name>`, that value is used instead of
+`origin`.
+
+In order to determine what URL to use to fetch from, the value
+of the configuration `remote.<origin>.url` is consulted
+and if there is not any such variable, the value on `URL: ` line
+in `$GIT_DIR/remotes/<origin>` file is used.
+
+In order to determine what remote branches to fetch (and
+optionally store in the tracking branches) when the command is
+run without any refspec parameters on the command line, values
+of the configuration variable `remote.<origin>.fetch` are
+consulted, and if there aren't any, `$GIT_DIR/remotes/<origin>`
+file is consulted and its `Pull: ` lines are used.
+In addition to the refspec formats described in the OPTIONS
+section, you can have a globbing refspec that looks like this:
+
+------------
+refs/heads/*:refs/remotes/origin/*
+------------
+
+A globbing refspec must have a non-empty RHS (i.e. must store
+what were fetched in tracking branches), and its LHS and RHS
+must end with `/*`.  The above specifies that all remote
+branches are tracked using tracking branches in
+`refs/remotes/origin/` hierarchy under the same name.
+
+The rule to determine which remote branch to merge after
+fetching is a bit involved, in order not to break backward
+compatibility.
+
+If explicit refspecs were given on the command
+line of `git pull`, they are all merged.
+
+When no refspec was given on the command line, then `git pull`
+uses the refspec from the configuration or
+`$GIT_DIR/remotes/<origin>`.  In such cases, the following
+rules apply:
+
+. If `branch.<name>.merge` configuration for the current
+  branch `<name>` exists, that is the name of the branch at the
+  remote site that is merged.
+
+. If the refspec is a globbing one, nothing is merged.
+
+. Otherwise the remote branch of the first refspec is merged.
+
+
 EXAMPLES
 --------
 
