From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] parse_options: Add flag to prevent errors for further
 processing
Date: Sun, 22 Jun 2008 20:07:18 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806221953470.6439@racer>
References: <1213758236-979-1-git-send-email-shawn.bohrer@gmail.com> <1213758236-979-2-git-send-email-shawn.bohrer@gmail.com> <7v1w2v2zsh.fsf@gitster.siamese.dyndns.org> <20080618033010.GA19657@sigill.intra.peff.net> <7vwskn1g2p.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806181709300.6439@racer> <7v8wx2zibp.fsf@gitster.siamese.dyndns.org> <20080619142527.GA8429@mediacenter>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, madcoder@debian.org
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 21:10:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAUxJ-0006x5-2I
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 21:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757858AbYFVTJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 15:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757850AbYFVTJA
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 15:09:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:36984 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757837AbYFVTI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 15:08:59 -0400
Received: (qmail invoked by alias); 22 Jun 2008 19:08:56 -0000
Received: from 87.114.18.83.plusnet.thn-ag3.dyn.plus.net (EHLO racer.local) [87.114.18.83]
  by mail.gmx.net (mp055) with SMTP; 22 Jun 2008 21:08:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/+27F7x3n+C8V9naOmI5FMHOJgp3VqGphZNq5R0Z
	IUZhajxxIdHvwS
X-X-Sender: gene099@racer
In-Reply-To: <20080619142527.GA8429@mediacenter>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85795>

Hi,

On Thu, 19 Jun 2008, Shawn Bohrer wrote:

> On Wed, Jun 18, 2008 at 11:52:42AM -0700, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > On Tue, 17 Jun 2008, Junio C Hamano wrote:
> > >
> > >> Jeff King <peff@peff.net> writes:
> > >> 
> > >> > I think the only right way to accomplish this is to convert the 
> > >> > revision and diff parameters into a parseopt-understandable 
> > >> > format.
> > >> 
> > >> Not necessarily.  You could structure individual option parsers 
> > >> like how diff option parsers are done.  You iterate over argv[], 
> > >> feed diff option parser the current index into argv[] and ask if it 
> > >> is an option diff understands, have diff eat the option (and 
> > >> possibly its parameter) to advance the index, or allow diff option 
> > >> to say "I do not understand this", and then handle it yourself or 
> > >> hand it to other parsers.
> > >
> > > AFAIR Pierre tried a few ways, and settled with a macro to introduce 
> > > the diff options into a caller's options.
> > >
> > > IOW it would look something like this:
> > >
> > > static struct option builtin_what_options[] = {
> > > 	[... options specific to this command ...]
> > > 	DIFF__OPT(&diff_options)
> > > };
> > 
> > I think that is the more painful approach Jeff mentioned, and my 
> > comment was to show that it is not the only way.
> > 
> 
> It seems to me that you could implement Jeff's 
> PARSE_OPT_STOP_AT_UNKNOWN, and then if multiple option parsers are 
> needed you would simply loop over parse_options for each of the 
> commands, waiting for argc to stop changing.  Of course Jeff's flag 
> would also need to stop parse_options from eating the first argument. Is 
> this sort of what you are suggesting Junio?

I believe not.  I think that Junio prefers some callback that can handle a 
whole bunch of options (as opposed to the callback we can have now, to 
handle arguments for a specific option).

However, I am not sure what that would buy us over the approach Pierre 
settled.  Junio, maybe you thought that the option parsing macro would 
live in parse-options.h?  It was supposed to live in diff.h and 
revision.h, respectively.

Ciao,
Dscho
