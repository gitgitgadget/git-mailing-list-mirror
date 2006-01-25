From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Wed, 25 Jan 2006 05:00:47 -0800
Message-ID: <7vy814qx6o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 25 14:01:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1kGc-0004GU-1Y
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 14:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWAYNAt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 08:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWAYNAt
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 08:00:49 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:45799 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750909AbWAYNAs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 08:00:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060125125843.TVZD17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 Jan 2006 07:58:43 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15129>

I've pushed out the following changes to "master" branch:

 * git-clone

   . --naked option is still accepted but is deprecated.  Please
     say --bare.

   . a repository cloned with --bare does not get "origin"
     branch, nor remotes/origin file.

   . Earlier we accepted more than one -o options, without
     complaining.  We now complain.

 * fetch and peek/ls-remote (Michal Ostrowski)

   . --upload-pack option to the underlying git-peek-remote and
     friends can be passed from the barebone Porcelain.

 * local push/pull environment fix (Matt Draisey)

   . We now clean "GIT_DIR" and friends from the environment
     when spawning a program on the other end to drive git
     native protocols on a local machine.  This uses unsetenv(),
     which is not strictly portable, but I was too lazy to fix
     it myself.  I am hoping that Jason Riedy will scream and
     give us a patch to make it work again on his Solaris box
     ;-).

 * sample update-hook rewrite (Andreas Ericsson)

 * asciidoc --unsafe workaround (Pavel Roskin)

In the "pu" branch, there are some interesting changes.  The
most immediately visible usability enhancement is the "combined
diff" option to git-diff-tree command.  Interested people can
try something like this:

	$ git checkout pu
	$ make clean strip all install
	$ git checkout master

Do not forget to come back to your "master" branch once you are
done, or your next pull would be screwed.

        $ git whatchanged --cc --abbrev pu

This would show an improved version of "git whatchanged -m -p".
The difference is that it uses the "dense combined diff"
suggested by Linus yesterday.  Commits near the tip of "pu" tend
to be Octopus, and you would see quite interesting combined
diffs for them.  I am not proud of the implementation itself,
and I am sure there are more bugs to be discovered, but overall
I am reasonably happy with what it shows.  Once it stabilizes,
it would be a good addition to gitweb UI.  In addition to the
"commitdiff" next to each parent, there would be an extra link
in a merge commit to get a combined diff.

The "annotate helper" change by Linus and "bound commit"
subproject support experiments are there as before.

There are other minor fixes and enhancements.  Not all of them
may make it to "master":

 * "diff-tree --abbrev --pretty" was still showing full 40
   characters of commit object names on "Merge:" line.

 * "rev-parse --abbrev[=<n>] $rev" is similar to
   "rev-parse --verify $rev", except that it shows an
   abbreviated object name.

 * The flag argument was handled confusingly by "rev-parse
   [--flags|--no-flags]".  The command now treats anything that
   come after --flags/--no-flags things to be parsed, not an
   option to control what the command does.  This was primarily
   needed to allow parsing out "--abbrev" option and giving it
   to "diff-tree" inside whatchanged.  All existing users have
   been adjusted to this change.  I do not think any of Cogito,
   gitk, nor stgit is affected.
