From: Junio C Hamano <junkio@cox.net>
Subject: Re: Any objectsions to enhancing git-log to show tags/branch heads?
Date: Mon, 16 Apr 2007 10:46:33 -0700
Message-ID: <7vy7kstdom.fsf@assigned-by-dhcp.cox.net>
References: <E1HdQah-0008Q2-7E@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 16 19:47:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdVIS-0005VS-EI
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 19:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbXDPRqf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 13:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754131AbXDPRqf
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 13:46:35 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:37226 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164AbXDPRqe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 13:46:34 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070416174633.ZFCZ1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 16 Apr 2007 13:46:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ntmZ1W00K1kojtg0000000; Mon, 16 Apr 2007 13:46:33 -0400
In-Reply-To: <E1HdQah-0008Q2-7E@candygram.thunk.org> (Theodore Ts'o's message
	of "Mon, 16 Apr 2007 08:45:55 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44680>

"Theodore Ts'o" <tytso@mit.edu> writes:

> I've recently noticed that I'm often firing up gitk for no other purpose
> than to see which changesets have which tags and branch heads.  Often
> I'll fire up gitk, quickly look at the tags/branches, and then kill it
> before it's done parsing the repository, resulting in python errors as
> it dies.
>
> So I'm wondering why we haven't arranged to have git-log show this
> information, and whether there would be any objections if "git-log"
> showed something like this:
> ...
> The only reason why I could imagine not doing this by default would be a
> potential performance problem if there were thousands of heads or branch
> heads.

I cannot comment on performance impact without knowing exactly
what semantics is being proposed.

 (1) If a commit is not directly pointed by any ref, would it
     get HEAD: or TAG: line, perhaps ala 'git-describe'?

 (2) If a commit is at the tip of two branches, what happens?
     Would it get two HEAD: lines?

 (3) Same question as (2) when a commit is tagged with two tags,
     or at the tip of a branch and pointed by a tag.

As to the impact on people's existing scripts that read git-log,
I think changing --pretty=anything would cause breakage for
somebody.  A new --pretty=format: tag would be the least
destabilizing, but I dunno.

But the fact that you kill gitk before it stops drawing suggests
that you are interested in recent commits only?  What is exactly
the use case?  What I am wondering is:

 (a) you have a handful specific commit IDs and wondering what
     they are, relative to known anchoring points.

     If this is the case, git-describe and git-name-rev may be
     your friend.

 (b) whenever you are browsing random part of history, you often
     wonder which ones are tagged or at the tip.  Browsing "git
     log" output does not give the visual cue of anchoring
     points like "gitk" output does, which annoys you.

     A code-free way to help with this is:

       $ git log | git -p name-rev --stdin
