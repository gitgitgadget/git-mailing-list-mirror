From: Mirko Stocker <mirko.stocker@hsr.ch>
Subject: Working with Git and CVS in a team.
Date: Fri, 13 Jun 2008 16:33:34 +0200
Organization: HSR
Message-ID: <200806131633.34980.mirko.stocker@hsr.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 13 16:42:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7ATa-0005Ji-P7
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 16:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885AbYFMOlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 10:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753315AbYFMOlH
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 10:41:07 -0400
Received: from luc80-74-131-252.ch-meta.net ([80.74.131.252]:35886 "EHLO
	lucius.metanet.ch" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752623AbYFMOlG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2008 10:41:06 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Jun 2008 10:41:05 EDT
Received: (qmail 22621 invoked from network); 13 Jun 2008 16:33:39 +0200
Received: from unknown (HELO pin6108034.hsr.ch) (152.96.200.175)
  by luc80-74-131-153.ch-meta.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 13 Jun 2008 16:33:39 +0200
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84883>

Hello,

Our team works on an existing project that's in CVS, but we don't have
the permissions to commit directly to it. We still need to make
changes and want to stay as up to date as possible, so we are trying
to use git to track the CVS repository and to collaborate inside the
team.

Now, I'm quite new to git, so I'm not sure if the solution I created
is "correct", not way too complicated, or if there are problems waiting
for us.

git-cvsimport seems to be the solution, so I've established the 
following structure:

+-----------------+
| dev.eclipse.org |
+-----------------+
        ^
        | (1)
        |         (2)                      (3)
+---------------+      +---------------+        +------------+
| ifs:/from-cvs | ---> | ifs:/git-proj | <----- | Merge-Dude |
+---------------+      +---------------+        +------------+
                          /           \
                         /             \
                        /               \
                    +------+         +------+
                    | User |   (4)   | User |
                    +------+         +------+

1) I use git-cvsimport to update the repository every night. /git-proj
   is a "clone --bare" of the /from-cvs repository.

2) After the import, I push the changes from CVS to /git-proj using
   'git push /git-proj origin'.

This first two steps can be done with a cronjob, there shouldn't be
any conflicts.

3) Then we have the role of a "Merge-Dude" who pulls the changes from
   /git-proj and uses 'git merge origin/origin' to update his master.
   If there are any conflicts, he resolves them and pushes everything
   back to the master at /git-proj.

4) The users can just push and pull from /git-proj.

>From time to time, we can use 'git diff origin/origin' to get a patch
with all the changes we made and have to send upstream.

What do you guys think, is this approach feasible?

What I don't like is how we have to make the upstream patch(es). Is
there an easy way we can get multiple patches, lets say for each
commit we made? Or is it easier to make a lots of branches and to
then create a patch from the diff between the branch and origin/origin?

Wow, this got longer than I expected. Thanks in advance!

Mirko Stocker
