From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Mon, 1 Jan 2007 08:17:26 -0500
Message-ID: <20070101131726.GA21933@thunk.org>
References: <7vfyav8ae1.fsf@assigned-by-dhcp.cox.net> <997672.38239.qm@web31814.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Jan 01 14:35:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1NJf-0003yL-As
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 14:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198AbXAANe7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 08:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755199AbXAANe6
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 08:34:58 -0500
Received: from thunk.org ([69.25.196.29]:53005 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755198AbXAANe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 08:34:58 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1H1NNk-0005oU-DT; Mon, 01 Jan 2007 08:39:16 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1H1N2c-0006zr-UE; Mon, 01 Jan 2007 08:17:27 -0500
To: Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <997672.38239.qm@web31814.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35737>

Luben,

Let me see if I can understand what you are asking for without using
the term "branch spec", which I don't think has been adequately
defined yet in this thread.  (Where "the SCM industry has adopted"
isn't a definition.  :-)

Currently, today, if you type:

	git fetch <non-URL>

... it will look up "<non-URL>" in a single global namespace, which
(using only the new config scheme) is looked up in remote.<non-URL>
and remote.<non-URL>.{url,fetch} is used to control the operation of
git-fetch.

What you want to do is to change this to where:

	git fetch <non-URL>

...will now lookup "<non-URL>" in a namespace which is qualified by
the branch that you are in.  So you want to look up the information in
branches.<current-branch>.<non-URL>.{url,fetch} instead.

You haven't stated it explicitly, but I assume that if
branches.<current-branch>.<non-URL> doesn't exist, you're proposing
that the code fall back to looking in the old configuration parameter,
remote.<non-URL>, so that certain names that should be global can
continue to be global, and that people who want a single global
namespace can continue to have it?

Is that your proposal, stripped of the arguments of why you want it,
and of the somewhat confusing "parent" example (which is a bad one
given that your "git pull parent" example was the semantic equivalent
of "git pull")?

If it is, I'm a bit nervous since it's making the git-fetch command
modal, and modal UI's are confusing to users.  On the other hand, it's
a fundamental modality we have already (based on the question "which
branch am I"), and there are hacks that will allow you to put the
current branch into your command-line.  And as long as you are
proposing a lookup in branches.current.branch.<non-URL> first before
checking remotes.<non-URL> it seems mostly harmless to me.  I doubt
I'd ever use it, but maybe it would be helpful to some.

						- Ted
