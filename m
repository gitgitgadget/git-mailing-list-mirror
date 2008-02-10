From: Jeff King <peff@peff.net>
Subject: Re: Upcoming memcached releases + rambling.
Date: Sun, 10 Feb 2008 06:05:04 -0500
Message-ID: <20080210110504.GA27314@coredump.intra.peff.net>
References: <47AAC7DA.2010604@rydia.net> <4422C0B2-6874-41EA-B4A0-4F3414F385FC@spy.net> <47AB3DBD.60004@rydia.net> <3897B3FD-4DCB-4150-8A07-7F8868A70A93@spy.net> <47AD2D1F.7030807@rydia.net> <5222C3B4-5E2C-45D2-8DF3-A85D69DDA2CF@spy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: dormando <dormando@rydia.net>,
	memcached list <memcached@lists.danga.com>, git@vger.kernel.org
To: Dustin Sallings <dustin@spy.net>
X-From: git-owner@vger.kernel.org Sun Feb 10 12:05:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOA0H-0005HP-9S
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 12:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274AbYBJLFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 06:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbYBJLFL
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 06:05:11 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1638 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751420AbYBJLFI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 06:05:08 -0500
Received: (qmail 26333 invoked by uid 111); 10 Feb 2008 11:05:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 10 Feb 2008 06:05:05 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Feb 2008 06:05:04 -0500
Content-Disposition: inline
In-Reply-To: <5222C3B4-5E2C-45D2-8DF3-A85D69DDA2CF@spy.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73337>

[I'm not on the list, so please cc me in replies]

On Fri, Feb 08, 2008 at 09:21:16PM -0800, Dustin Sallings wrote:

> I've seen lots of people using git for their own work, but not enough
> using it in a distributed fashion.  I've been asking questions about how
> to collaborate with git, but I can't seem to find any git experts who will
> answer questions.

Please, if you have git questions, feel free to ask them on the git list
(which I am cc'ing here).

> serve, bundle, export, import, incoming, and outgoing don't seem
> to have equivalences in git.

I don't know hg well at all, but I will attempt to translate (please
correct me if I'm wrong on any hg behavior).

"hg serve" runs a web repo browser and a pull server. In git, these
duties are split. Depending on what you want, you can:
  - for allowing people to pull from you, you can use git-daemon
  - for repository browsing, run an instance of gitweb. There is a
    git-instaweb script for doing one-off "I just need to set this up
    for a minute" versions.
  - you can also allow people to pull via http; just copy your '.git'
    directory somewhere that is accessible by the web server
  - you can also allow people to pull via ssh; just give them an ssh
    account and point them to host:/path/to/repo

"hg bundle" has an equivalent in git: "git bundle"

"hg export" seems to generate the commit message + patch for a set of
commits. The git equivalent is "git format-patch" which puts each patch
in its own mbox file (you can also use "git format-patch --stdout >mbox"
to put them all in one mbox.

"hg import" presumably applies the results of "hg export". In git, this
is "git am" (where am stands for apply mailbox), which applies the
changes from an entire mbox one by one.

"incoming" and "outgoing" seem to basically be diffs against remote
repositories (i.e., "what do I have that he doesn't" and vice versa). In
git, you would do a "git fetch" to say "contact the remote repository
and get what he has, but don't update any of my branches" followed by
"git log origin..HEAD" (what does I have that he doesn't) or "git log
HEAD..origin" (the opposite). You can also use the symmetric difference
with a graphical browser like gitk: "gitk origin...HEAD" which will show
everything that he has and everything you have, down to the point where
the two histories last diverged.

> 	I've contributed changes to both git and hg projects and haven't had  
> good luck submitting changes upstream.   I'd be interesting in talking to 
> people who collaborate on projects using git both as first and  
> second-level contributors to see if their experiences are any better than 
> mine.  I don't doubt that I may be doing it wrong.

Again, if you have specific questions, please feel free to ask on the
git list. We are more than happy to help out if we can.

> 	Should memcached choose git, it may be as simple as putting up a page  
> that says, ``this is how you clone, this is how you work, this is how you 
> submit your changes back.''

I don't know hg very well, but my impression is that the implementation
is quite similar to git and that writing a document "translating"
commands from one system to the other would be feasible.

-Peff
