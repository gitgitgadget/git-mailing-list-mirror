From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Tue, 12 May 2009 16:34:50 -0700
Message-ID: <20090512233450.GY30527@spearce.org>
References: <200905122329.15379.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 01:37:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M41Wv-00009s-On
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 01:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759874AbZELXev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 19:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759853AbZELXev
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 19:34:51 -0400
Received: from george.spearce.org ([209.20.77.23]:55375 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759847AbZELXeu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 19:34:50 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 03F94381D5; Tue, 12 May 2009 23:34:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200905122329.15379.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118973>

Jakub Narebski <jnareb@gmail.com> wrote:
> We have now proliferation of different (re)implementations of git:
> JGit in Java, Dulwich in Python, Grit in Ruby; and there are other
> planned: git# / managed git in C# (GSoC Mono project), ObjectiveGit
> in Objective-C (for iPhone IIRC).  At some time they would reach
> the point (or reached it already) of implementing git-daemon...
> but currently the documentation of git protocol is lacking.

Well, lets see...

JGit - me and Robin, here on git ML.  JGit is the closest
reimplementation effort to the canonical C implementation.
JGit runs in production servers for many folks, e.g. quite
a few Google engineers use the JGit server every day.  Its
our main git daemon.

Grit - GitHub folks.  They know where to find us.  And their
business is Git.  If Grit isn't right, they'll make it right,
or possibly suffer a loss of customers.  I'm fairly certain
that GitHub runs Grit in production.

ObjectGit - Scott Chacon, again, a GitHub folk.  Though he has
expressed interest in moving to JGit or libgit2 where/when possible.

Dulwich - off in its own world and not even trying to match basic
protocol rules by just watching what happens when you telnet to a
git port.  No clue how that's going to fair.

git# - We'll see.  Mono GSoC Git projects have a really bad
reputation of ignoring the existing git knowledge and hoping
they can invent the wheel on their own.

> This can lead, as you can read from recent post on git mailing, to
> implementing details wrong (like Dulwich not using full SHA-1 where
> it should, leading to ordinary git clients to failing to fetch from it),
> or fail at best practices of implementation (like JGit last issue with
> deadlocking for multi_ack extension).

Dulwich is just busted.

No existing developers knew that the fetch-pack/upload-pack protocol
has this required implicit buffering consideration until JGit
deadlocked over it.  But even then I'm still not 100% sure this
is true, or if it is just an artifact of the JGit upload-pack side
implementation being partially wrong.

> The current documentation of git protocol is very sparse; the docs
> in Documentation/technical/pack-protocol.txt offer only a sketch of
> exchange.  You can find more, including pkt-line format, a way sideband
> is multiplexed, and how capabilities are negotiated between server and
> client in design document for "smart" HTTP server, for example in
>   Subject: Re: More on git over HTTP POST
>   Message-ID: <20080803025602.GB27465@spearce.org>
>   URL: http://thread.gmane.org/gmane.comp.version-control.git/91104/focus=91196

Seriously?  Don't link to that.  Its a horrible version of the smart
HTTP RFC, and worse, it doesn't describe what you say it describes.
 
> It would be really nice, I think, to have RFC for git pack protocol.
> And it would help avoid incompatibilities between different clients
> and servers.  If the document would contain expected behaviour of
> client and server and Best Current Practices it would help avoid
> pitfals when implementing git-daemon in other implementation.

Yea, it would be nice.  But find me someone who knows the protocol
and who has the time to document the #!@* thing.  Maybe I'll try
to work on this myself, but I'm strapped for time, especially over
the next two-to-three months.

And lets not even start to mention Dulwich not completing a thin
pack before storing it on disk.  Those sorts of on disk things
matter to other more popular Git implementations (c git, jgit).
 
-- 
Shawn.
