From: Jeff King <peff@peff.net>
Subject: Re: moving to a git-backed wiki
Date: Thu, 3 Feb 2011 12:45:18 -0500
Message-ID: <20110203174518.GA14871@sigill.intra.peff.net>
References: <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <7vsjw957fq.fsf_-_@alter.siamese.dyndns.org>
 <7vzkqg4x2h.fsf_-_@alter.siamese.dyndns.org>
 <20110131225529.GC14419@sigill.intra.peff.net>
 <AANLkTimHCp_JKUw1keJoA4zD_q7Sci+rOwPeAs_T=7xH@mail.gmail.com>
 <20110201201144.GA16003@sigill.intra.peff.net>
 <AANLkTikfzzELUaN3B+20rh9D51St8mUYs4p-WYjp8JVV@mail.gmail.com>
 <4D488DCD.3080305@eaglescrag.net>
 <4D4929F4.3020805@snarc.org>
 <4D4A11D7.4040103@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vincent Hanquez <tab@snarc.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Thu Feb 03 18:45:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl3FL-00069M-FL
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 18:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756662Ab1BCRp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 12:45:26 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:43276 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756441Ab1BCRpW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 12:45:22 -0500
Received: (qmail 2401 invoked by uid 111); 3 Feb 2011 17:45:21 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 03 Feb 2011 17:45:21 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Feb 2011 12:45:18 -0500
Content-Disposition: inline
In-Reply-To: <4D4A11D7.4040103@eaglescrag.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165986>

On Wed, Feb 02, 2011 at 06:24:23PM -0800, J.H. wrote:

> On 02/02/2011 01:55 AM, Vincent Hanquez wrote:
> >  On 01/02/11 22:48, J.H. wrote:
> >> The wiki will almost universally have a "central site" no matter what
> >> the backend.  Personally I see little advantage to having a git backed
> >> wiki myself.
> > with git based wiki, you can clone the whole wiki on your local machine,
> > and read/edit/commit on it locally using standard editor tool (i.e.
> > $EDITOR). and the history/revision/diff is completely built-in.
> 
> That would be fine for things like source code or documentation, but you
> end up with a single person who would need to merge / push things to a
> central location, a-la git.wiki.kernel.org.  You are now taking
> something, that is already editable by anyone, and making it only
> editable by a single person.

I don't think it makes sense to use the same workflow for the wiki as
git.git itself uses. The point of having a wiki is to keep the barrier
to editing extremely low; the point of source code control is to keep
the quality of contributions high.

But that doesn't mean they can't be accessed by the same tool.

Forget about a git-backed wiki for a moment, and imagine a regular old
Mediawiki. What are the operations you can perform? You can look at
the current or any past version of a page, you can do diffs between
versions of pages, and you can create a new version of a page. All
through some CGI forms.

So what stops us from replacing the CGI interface with a git one (or
adding it alongside)? Given the ability to retrieve current and past
versions of all pages, I could surely build a git repository of the
whole wiki (and update it incrementally as new edits were made).  And
pushing a set of commits is just a sequential series of page edits, no?

And I think that would be enough for the purposes of this discussion.
Most of us don't really care if git is the ultimate storage mechanism. I
could even build the git interface as a purely client thing on top of
the CGI interface; the problem is that scraping the wiki pages for new
versions over the net would be horribly inefficient.

But the point is that accessing the wiki via git is not about changing
the wiki workflow. It's about providing a richer set of tools for doing
those page views, diffs, and edits.

Getting back to git as the actual backend:

> You also have a scalability problem.  Git is *VERY* memory and i/o
> intensive.  While you basically have a cache of data that is static (the
> basic pages you are viewing) things like the history, edits, etc can be
> quite expensive to generate.

Sure. But is that any worse than running gitweb, which you already do?
Or a site like GitHub, which basically is just running git constantly on
a bunch of repos? Or how much worse is it than running regular wiki
software? I mean, Foswiki is backed by RCS, for god's sake. Surely git
is more efficient than that. ;)

If it sounds like I'm handwaving away scalability problems, I am. I'd be
curious to see some performance numbers for gollum or ikiwiki versus
more traditional wiki formats.

> Think about a site, we'll use git.wiki.kernel.org, where it's not
> running on a single machine, but a cluster of machines (how many web
> infrastructures, including git.wiki.kernel.org run) and now you have a
> problem of an edit happens and commits on node3, a different conflicting
> edit happens on node9 and when those try to merge - you get conflicts.

Don't you have the same problem with a regular wiki? Or with stock git
repos, for that matter? You need database consistency.

-Peff
