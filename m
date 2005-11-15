From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Tue, 15 Nov 2005 10:13:15 -0800
Message-ID: <7v4q6dn5j8.fsf@assigned-by-dhcp.cox.net>
References: <1132034390.22207.18.camel@dv>
	<7vveyuqto5.fsf@assigned-by-dhcp.cox.net>
	<1132042427.3512.50.camel@dv>
	<7vpsp2qpx4.fsf@assigned-by-dhcp.cox.net>
	<7vd5l2mco1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511151207070.21671@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051115121854.GV30496@pasky.or.cz>
	<7v8xvpn8ne.fsf@assigned-by-dhcp.cox.net>
	<1132075295.25640.59.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 20:12:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec63g-0007mH-3c
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 20:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbVKOTB2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 14:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbVKOTB1
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 14:01:27 -0500
Received: from fed1rmmtai09.cox.net ([68.230.241.50]:24224 "EHLO
	fed1rmmtai09.cox.net") by vger.kernel.org with ESMTP
	id S965001AbVKOTB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 14:01:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051115181213.MVEA17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 13:12:13 -0500
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1132075295.25640.59.camel@dv> (Pavel Roskin's message of "Tue,
	15 Nov 2005 12:21:35 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11935>

Pavel Roskin <proski@gnu.org> writes:

> On Tue, 2005-11-15 at 09:05 -0800, Junio C Hamano wrote:
>> Petr Baudis <pasky@suse.cz> writes:
>> 
>> > Yes, I would very much like to have this. I still want to go
>> > symrefs-only for public repositories created for cg-admin-setuprepo, so
>> > that fetching over HTTP works properly.
>> 
>> Sorry, I must have missed that part.  How does fetch-over-HTTP
>> break with symlinked HEAD?
>
> With symlinks, cogito doesn't know which branch it is fetching if the
> branch is not explicitly specified.

Ah, thanks.

git-clone-pack has the same problem.  It basically "guesses" by:

	- If the master branch exists, and the object name of
          the branch tip matches the object name of HEAD, assume
          HEAD points at master.  Even when there are other
          branches that happen to share the same branch head.

	- Otherwise, if there is a branch whose tip matches the
          object name of HEAD, assume HEAD points at it.  It
          just picks "one-of-them" if more than one branches
          match.

	- If there is no branch that matches HEAD, issue a
          warning and create HEAD that records the object name,
          not pointing anywhere.

To solve this generally we would need to extend what ls-remote
returns, I suppose.
