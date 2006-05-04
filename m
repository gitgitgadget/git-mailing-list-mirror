From: Junio C Hamano <junkio@cox.net>
Subject: Unresolved issues #2
Date: Thu, 04 May 2006 01:15:03 -0700
Message-ID: <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 04 10:15:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbYzX-0007la-RK
	for gcvg-git@gmane.org; Thu, 04 May 2006 10:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWEDIPH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 04:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWEDIPH
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 04:15:07 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:34490 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751015AbWEDIPF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 May 2006 04:15:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060504081504.ZIVM18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 4 May 2006 04:15:04 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19556>

Here is a list of topics in the recent git traffic that I feel
inadequately addressed.  I've commented on some of them to give
people a feel for what my priorities are.  Somebody might want
to rehash the ones low on my priority list to conclusion with a
concrete proposal if they cared about them enough.

The list is *not* ordered in any way, except that the entries
kept from the previous issue of this message have been pushed
down to the bottom.  I will probably start dropping some entries
that did not get any reaction from the list in future issues of
this message, but for now I kept all of them from the first one.

* Message-ID: <4fb292fa0604290630r19edd7ejf88642e33b350d1d@mail.gmail.com>
  Content-type charset for send-email (Bertrand Jacquin)

  The output from format-patch by default is unmarked, which
  means the commit message part is UTF-8 (by strong convention),
  and the contents of the diff is whatever the contents of the
  file is encoded in.

  David Woodhouse did a patch to allow specifying charset on the
  command line (and default to UTF-8) which is a move in the
  right direction, but Bertrand's system seems to have trouble
  with it.

  I think if we were to do this we probably need to teach
  format-patch to optionally do multi-part.  We may not
  necessarily want to mark the payload to be in the same
  encoding as the commit message (not that git-apply cares -- to
  it, the payload is just 8-bit unencoded text, but we would
  want to protect it from getting mangled by e-mail transport).

* Message-ID: <Pine.LNX.4.64.0604291006270.3701@g5.osdl.org>
  Perhaps "note" field in commit objects are useful?

* Message-ID: <Pine.LNX.4.63.0604301524080.2646@wbgn013.biozentrum.uni-wuerzburg.de>

  An optional "git fetch --store newname URL refspecs..." to
  create an equivalent of remotes file so newname can then be
  used as a short-hand.  I still have somewhat negative reaction
  to it, but I am willing to apply it if there are enough people
  who want this.

-- carried over from the first issue of this list.

* Message-ID: <Pine.LNX.4.64.0604050855080.2550@localhost.localdomain>
  Binary diff output? (Nicolas Pitre)

  I do not think this is needed for our primary audience (the
  kernel project), but I am sure it would be helpful for some
  other projects if we allowed them to exchange patches that
  describe binary file changes via e-mail, so I am not
  dismissing this.

* #irc 2006-04-10
  Shallow clones (Carl Worth).

  The experiment last round did not work out very well, but as
  existing repositories get bigger, and more projects being
  migrated from foreign SCM systems, this would become a
  must-have from would-be-nice-to-have.

  I am beginning to think using "graft" to cauterize history
  for this, while it technically would work, would not be so
  helpful to users, so the design needs to be worked out again.

* Message-ID: <E1FMH3o-0001B5-Dw@jdl.com>
  git status does not distinguish contents changes and mode
  changes; it just says "modified" (Jon Loeliger).

  Unconditionally changing the status letter would break
  Porcelains so we would need an extra option to do this.
  An outline patch has been already prepared -- this perhaps has
  to wait until we sort out the "option parsing" one.

* Message-ID: <tnxmzf9sh7k.fsf@arm.com>
  git could use diff3 instead of merge which is a wrapper around
  diff3. (Catalin Marinas)

  If having "diff3" is a lot more common than having "merge", I
  do not have problem with this; "merge" being a wrapper to
  "diff3", people who have been happy with the current code
  would certainly have "diff3" installed so changing to "diff3"
  would not break them.

* Message-ID: <81b0412b0603020649u99a2035i3b8adde8ddce9410@mail.gmail.com>
  Windows problems summary (Alex Riesen)

  A good list to keep in mind.

* Message-ID: <Pine.LNX.4.64.0604030730040.3781@g5.osdl.org>
  Huge packfiles (Linus Torvalds)

  Because I do not think asking users to break up packs to
  manageable and mmap()able size is too much to ask, I would not
  be advocating for updating the pack idx to 64-bit offset and
  mmap()ing parts of a packfile, at least too strongly.

  However, we currently lack tool support or recepe for users
  with such a repository to easily break up packs.

* Message-ID: <1143856098.3555.48.camel@dv>
  Per branch property, esp. where to merge from (Pavel Roskin)

  This involves user-level "world model" design, which is more
  Porcelainish than Plumbing, and as people know I do not do
  Porcelain well; interested parties need to come up with what
  they want and how they want to use it.
