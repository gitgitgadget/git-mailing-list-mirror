From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 18:21:27 -0500
Message-ID: <20071130232127.GA3169@sigill.intra.peff.net>
References: <alpine.LFD.0.9999.0711291821220.8458@woody.linux-foundation.org> <5E2A9E2B-8B9A-46B0-99D0-DB3798F10119@zib.de> <20071130151223.GB22095@coredump.intra.peff.net> <8aa486160711300728x70f591f1hf8884a78f2b15806@mail.gmail.com> <20071130152942.GA22489@coredump.intra.peff.net> <alpine.LFD.0.9999.0711300745330.8458@woody.linux-foundation.org> <20071130162257.GA22882@coredump.intra.peff.net> <Pine.LNX.4.64.0711301828050.27959@racer.site> <20071130183755.GA29382@sigill.intra.peff.net> <Pine.LNX.4.64.0711302305300.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Santi B?jar <sbejar@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 01 00:22:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyFB9-00051Z-HS
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 00:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755062AbXK3XVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 18:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755212AbXK3XVb
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 18:21:31 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4937 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755046AbXK3XVa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 18:21:30 -0500
Received: (qmail 5961 invoked by uid 111); 30 Nov 2007 23:21:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 30 Nov 2007 18:21:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Nov 2007 18:21:27 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711302305300.27959@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66667>

On Fri, Nov 30, 2007 at 11:05:50PM +0000, Johannes Schindelin wrote:

> > > >  	alias_command = (*argv)[0];
> > > >  	git_config(git_alias_config);
> > > > +	if (!alias_string)
> > > > +		alias_string = builtin_alias(alias_command);
> > > >  	if (alias_string) {
> > > >  		if (alias_string[0] == '!') {
> > > >  			if (*argcp > 1) {
> > > 
> > > Didn't you mean to put this _before_ the git_config() call?  As you wrote 
> > > it, the "soft" alias overrides the user-specified one.
> > 
> > No. The "if (!alias_string)" means we only do the lookup if no user
> > alias was found. Try it.
> 
> Ah.  To me, that was rather easy to miss, though...

I don't particularly care if it is re-written as:

  alias_string = builtin_alias(alias_command);
  git_config(git_alias_config);

which should be equivalent.  I wrote it the original way to avoid doing
the O(n) search through builtin aliases when it was unnecessary, but
obviously this isn't a performance critical code path.

-Peff
