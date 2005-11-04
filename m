From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Cogito: Support for implicit remote branches in cloned repositories
Date: Fri, 04 Nov 2005 09:43:04 -0800
Message-ID: <7vvez8wbpz.fsf@assigned-by-dhcp.cox.net>
References: <200511041701.48881.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 18:44:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY5as-0004E4-6x
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 18:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVKDRnI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 12:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVKDRnH
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 12:43:07 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:29134 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750762AbVKDRnG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 12:43:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051104174215.LKIX11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Nov 2005 12:42:15 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200511041701.48881.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Fri, 4 Nov 2005 17:01:48 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11147>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> ... One difference of cloning with GIT vs. with
> Cogito is that Git always clones all remote branches. This can
> be limiting if you want to work with multiple repositories,
> but allows you to immediatly work with all the branches.

Three points, and two footnotes.

. After a git clone, you can still fetch from non-origin
  repository; you can also set up .git/remotes/somewhere-else if
  you pull from the non-origin repository regularly, so it is
  not really "limiting".  It is just being slightly less
  convenient, in that setting up for the origin is done for you
  by clone [*1*] while you have to arrange for non-origin
  repository yourself afterwards.

. The namespace under refs/heads is and always will be an issue.
  It is a local matter and how remote branches are named should
  not dictate what local branch names you can use in your
  repository, but that essentially is what happens after
  git-clone to users who do not rename those branches from the
  initial cloning.

  I once considered to give an option to clone to map the origin
  heads to .git/refs/heads/origin/{master,maint,pu,...}.  In
  hindsight that might have been cleaner.  Instead I just followed
  what Cogito already established, and mapped remote "master" to
  "origin".

. The namespace under refs/tags theoretically also has the same
  issue, but I suspect it would not matter too much in practice.
  The tags people fetches from remote tend to be release-point
  tags (e.g. v2.6.14) whose names implicitly follow an obvious
  (to humans) naming convention; when you name your temporary
  anchor points using lightweight tags, you can easily avoid
  name clashes with those "for other people" tags [*2*].

[Footnotes]

*1* Actually, even the setting up for the origin is done only
halfway -- it only arranges 'git fetch/pull' to fetch from the
master branch, and other branches are not tracked unless you
explicitly arrange them to be.  This is somewhat deliberate; the
refs/ namespace management is a local matter and you do not
necessarily want to keep tracking all the branches from origin.

*2* This becomes somewhat problematic when the tool
automatically follows/fetches tags, and that is why git-core
barebone Porcelainish requires an explicit 'git fetch --tags'.
