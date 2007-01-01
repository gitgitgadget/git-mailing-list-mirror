From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Sun, 31 Dec 2006 19:29:22 -0800 (PST)
Message-ID: <59142.7095.qm@web31801.mail.mud.yahoo.com>
References: <7vwt47bjwa.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 01 04:29:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1Drf-0003Gv-S0
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 04:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933241AbXAAD3X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 22:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933242AbXAAD3X
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 22:29:23 -0500
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:33764 "HELO
	web31801.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933241AbXAAD3X (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Dec 2006 22:29:23 -0500
Received: (qmail 7309 invoked by uid 60001); 1 Jan 2007 03:29:22 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=EWmpR8UyiDZxAhrbXujwjhfdhpLY9w4CEZu4nbXYwe7cNnwGyaK72JXyOOhAl02TH7YOu4THAM3C+RNxGp0rHHv/1K71FSDK3b3LlYevtyiIZjIDgKxWiOkrBUmiyx/r96ItNcllQfEGYLgCTb2t9mXDGGp8loVcp+1H6YR3094=;
X-YMail-OSG: io59.gwVM1lwvHCK.8tOy8hCYb15kCeWYRx052SYhXFp3ksPRdFc6QVIjpWy9EzdghoyWbw24QRLA5McJ_itc7kAWWE61xvxRXPHMchuqnlRrv1_Ng2KZ1qbwqhg3Bz8.imaqyUtMunNDTUJsrK6gCTjVcYBVnPLOEQYNks5vURn4ggAW1Mhe1rx
Received: from [71.84.31.238] by web31801.mail.mud.yahoo.com via HTTP; Sun, 31 Dec 2006 19:29:22 PST
To: Junio C Hamano <junkio@cox.net>, bfields@fieldses.org
In-Reply-To: <7vwt47bjwa.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35721>

--- Junio C Hamano <junkio@cox.net> wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > What we wanted to do ideally was to forbid "git pull" that does
> > not have explicit refspec from the command line, without
> > configuring branch.*.merge.  However this broke established
> > workflow of people who has remote.$origin.fetch configured to
> > list the remote branch to fetch explicitly; the merged branch
> > selection has always been "the first set of branches listed in
> > the configuration" and these peoples had their configuration
> > right without needing to have branch.*.merge at all.
> >
> > Unfortunately git is too flexible around this area.  
> >
> > We probably could somehow arrante the remote branches that came
> > from wildcarding not subject to the merge branch selection
> > logic, but honestly I am tired of looking at that code for now.
> 
> I am still tired of looking at the code, but I would rather 
> look at it now than having to still look at it next year.
> 
> How about doing this?  The difference this time around is that
> if you have non-wildcard refspec listed first, which usually
> is the case for people with established git workflow with
> existing repositories, we use the old-and-proven rule to
> merge the first set of refs.  An earlier round botched this
> completely by basing the logic on lack of branch.*.merge,
> which broke for many people.

Can we please instead revisit the "branch.<name>.remote"
and "branch.<name>.merge" options?

What I'd really like to see and what really would be useful
to me every day is if I could individually _address_ a
"branch.<name>.remote" and "branch.<name>.merge" pair of
options.

I.e. I'd like to say "git-pull parent" or "git-pull parents"
in such and such branch, and this would pull the designated
parent(s) for the current branch.  But if I'm in a different
branch (of the same repo) then the meaning of "parent" changes
accordingly.

Currently, the parent<-->child branch relationship only
exists in paper: for example: git master is the parent for
all my (local) branches, "git-upstream" is child of "next",
"git-lt-work" is child of "git-upstream" and "git-home" is
child of "git-lt-work", each one introducing its own
customizations and changes.  I currently do the pull/merge
by hand, remembering the child/parent relationship and enforcing
it manually by the strict pull/merge sequence I do.

Of course we shouldn't break existing usages like
for example "git-pull . tag ...".

I can achieve the same thing using the "branch.*" options
today, but I do "git-pull" and I'm not entrirely satisfied
with that since in my head I know I'm doing a "parent->child"
merge and would like to express that on the command line.

So this is something of a cross between the remotes/ and
"branch.*" option.

For example "branch.<name>.<symbolic_ref>.fetch" and
"branch.<name>.<symbolic_ref>.merge" would do the trick.

Then at prompt, I say "git-pull <symbolic_ref>" which will
match local branch and symbolic name to whatever matches.

Of course, "branch..<symbolic_name>.*" would seem to be
identical to remotes.  We should disallow that by stipulating
that a non-empty symbolic name imples non-empty branch name.
"branch.<name>..*" would be identical to its current usage.

The point is that the symbolic name changes its designation depending
on which is the current branch, and with a name like "parent" that
makes sense.

    Luben
