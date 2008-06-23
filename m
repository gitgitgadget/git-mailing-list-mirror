From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 17:25:52 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806231709540.6440@racer>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <20080623082223.GA12130@artemis.madism.org> <alpine.DEB.1.00.0806231312130.6440@racer> <20080623155315.GA18593@artemis.madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 18:29:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAouP-0004rs-Us
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 18:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035AbYFWQ1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 12:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754923AbYFWQ1x
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 12:27:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:46417 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754846AbYFWQ1x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 12:27:53 -0400
Received: (qmail invoked by alias); 23 Jun 2008 16:27:51 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp017) with SMTP; 23 Jun 2008 18:27:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX181gZgE0qs1xfyVej5XV7dGWaEOlD6XzA6FKbU20p
	rngooElQODIHrR
X-X-Sender: gene099@racer
In-Reply-To: <20080623155315.GA18593@artemis.madism.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85883>

Hi,

On Mon, 23 Jun 2008, Pierre Habouzit wrote:

> On Mon, Jun 23, 2008 at 12:26:41PM +0000, Johannes Schindelin wrote:
> 
> > On Mon, 23 Jun 2008, Pierre Habouzit wrote:
> > 
> > > This "PARSE_OPT_IGNORE_UNRECOGNIZED" thing has been discussed many 
> > > times in the past, but it just doesn't fly.
> > > 
> > > Though to help migrations we can probably introduce a new parse 
> > > option construct that would be a callback that is responsible for 
> > > dealing with "things" the upper level parser doesn't know about, 
> > > something where the callback could be:
> > > 
> > > enum {
> > >     FLAG_ERROR = -1,
> > >     FLAG_NOT_FOR_ME,
> > >     FLAG_IS_FOR_ME,
> > >     FLAG_AND_VALUE_ARE_FOR_ME,
> > > }
> > > 
> > > int (*parse_opt_unknown_cb)(int shortopt, const char *longopt,
> > >                             const char *value, void *priv);
> > 
> > I believe that this is what Junio was talking about when he mentioned 
> > callbacks.
> > 
> > However, I think it buys us more trouble than it saves us.
> > 
> > Thinking about the recursive approach again, I came up with this POC:
> 
>   Well I proposed something like that in the past, and we believed it to
> be too cumbersome.

IIRC your solution was a bit involved, while I think that mine is at least 
small enough to be simple.

Note: it is a bit wasteful, allocating space for a new option table 
in every case, even if there are no OPTION_OPTIONS, but I think that is 
okay.

> I can live with it well fwiw, but it doesn't solve the issue of 
> migrating a very complex option parsing chain to parse-options well 
> IMHO. THe big problem with diff and rev opt parsing is that one you want 
> to migrate _any_ of the commands, you have to migrate _all_ of them, 
> which is huge.

I don't think you have to migrate all of them in one go.  To the contrary, 
if we have both "diff_opt_parse()" as well as a "struct options 
*diff__options", it can be done one by one.  During that time, though, 
people would have to add new diff options to both places.
 
Ciao,
Dscho
