From: Junio C Hamano <junkio@cox.net>
Subject: [RFC] So... are people happy with commit/status -v?
Date: Wed, 15 Feb 2006 01:41:11 -0800
Message-ID: <7vvevhj6x4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Feb 15 10:41:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9J9v-0005ej-QO
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 10:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423043AbWBOJlN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 04:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWBOJlN
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 04:41:13 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:16612 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932449AbWBOJlM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 04:41:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060215093948.JYGT20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 15 Feb 2006 04:39:48 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16228>

I usually never do commits from a subdirectory, also I rarely do
partial commits, so this is not a big issue to me, but are
people happy with the current commit/status?

Regardless of where you started, status is a preview of the next
commit with the same set of flags and arguments, so inherently
that is a whole-tree operation.

One thing that _might_ be better, however, is to shorten certain
parts of the status output when deliberately doing a partial
commit.  No matter where you are, "Updated but not checked in --
will commit" section should stay whole-tree, because it is _the_
preview of the next commit.  However, "Changed but not updated"
and "Untracked" section are different story.

When committing from a subdirectory with "git commit paths...",
It is likely a user forgets about paths that are changed in the
directory and forgets to list them on the command line, so the
same directory and below should be listed, but it might not be
needed to show files outside the current directory.  "Untracked"
files outside the current directory are even less interesting.

Even when committing from a subdirectory with "git commit",
which is "commit the current index contents", the story is the
same.  The user could have forgot to add files in the same
directory or below, but it is less likely that things outside
current directory need to draw attention to prevent mistakes.
"Untracked" outside are less interesting in this case as well.

In either partial or whole commit case, however, "Changed but
not updated" part can be argued important and should be kept
whole-tree (myself, I am slightly in favor of keeping this part
whole-tree).  After all, the user has changed files in the
directory she happens to be in and outside, and reminding she
has something outstanding while previewing the next commit would
help prevent mistakes, whether that modified files are in the
current directory or outside.

So, I'm wondering.  I have a feeling that we might be better of
limiting "Untracked" part to the current directory and below,
while keeping "Updated -- will commit" and "Changed but not
updated" part whole-tree.  OTOH, I do not have strong need
_myself_ to change the current setup.

Comments?  Opinions?
