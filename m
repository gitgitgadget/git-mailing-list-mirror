From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] teamGIT bonjour support
Date: Fri, 20 Nov 2009 10:05:30 +0100
Message-ID: <20091120090529.GM17748@machine.or.cz>
References: <2fcfa6df0908280002y221a22e6md27db56865472144@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, teamgit@googlegroups.com
To: Abhijit Bhopatkar <bain@devslashzero.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 10:06:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBPRZ-00061J-4O
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 10:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbZKTJFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 04:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbZKTJFb
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 04:05:31 -0500
Received: from w241.dkm.cz ([62.24.88.241]:33372 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893AbZKTJFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 04:05:25 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 44ECC862095; Fri, 20 Nov 2009 10:05:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <2fcfa6df0908280002y221a22e6md27db56865472144@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133317>

  Hi!

On Fri, Aug 28, 2009 at 12:32:39PM +0530, Abhijit Bhopatkar wrote:
> I plan to do this on LAN using bonjour service discovery

I wonder why so much emphasis for this? It seems like a nifty
convenience bit, but I don't think making this idea too central is any
good. What if you get a second office at the other end of the world?
What if part of your team is working on a deployment at customer site?
What if part of your team works from home over a VPN?  What if your
team is collaborating over the internet on an open project?  What if...?

That said, it sounds like a great idea to have let's say a post-commit
hook that will start an upload job:

	extbranch="$(whoami)/$(git symbolic-ref HEAD | sed 's#refs/heads/##')"
	pushurl="$(melting_pot)"
	git push --force "$pushurl" "HEAD:$extbranch" >/dev/null &

(untested, +corner cases). On the server side, cronjob or post-update
hook can do the integration testing. The complete setup should be
a matter of few-minutes hack.

Now, it seems totally irrelevant if melting_pot is

	melting_pot() { git config teamgit.meltingpot }

or extra code that tries/caches some local discovery first.


P.S.: It's not clear if you want the information sharing with commit
granularity or less - in that case, things might get rather tricky e.g.
if you add new files and don't git add them until right before you
commit, and the work tree state might be total mess anyway.

P.P.S.: It's not clear if you strive after complete de-centralization of
the service, with no central melting pot. That would seem fancy, but
I think rather useless and hard in practice to arrange your reports
that you want, etc. It's not clear again then if the integration testing
should happen on single machine they all vote on (samba-like), or if
all machines should do integration-testing, and whether of all branches
or only some of them, and how to recognize the interesting branches, and
things are getting very hairy already... Your requirements are too
ambiguous.

-- 
				Petr "Pasky" Baudis
A lot of people have my books on their bookshelves.
That's the problem, they need to read them. -- Don Knuth
