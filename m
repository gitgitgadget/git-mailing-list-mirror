From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] Add commit log message spell checking feature.
Date: Wed, 3 Mar 2010 09:45:18 -0500
Message-ID: <20100303144517.GA21385@coredump.intra.peff.net>
References: <alpine.LNX.2.00.1003032018330.21953@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Steven Drake <sdrake@xnet.co.nz>
X-From: git-owner@vger.kernel.org Wed Mar 03 15:45:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmppK-0007hg-Fg
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 15:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713Ab0CCOpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 09:45:24 -0500
Received: from peff.net ([208.65.91.99]:36108 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754467Ab0CCOpX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 09:45:23 -0500
Received: (qmail 10141 invoked by uid 107); 3 Mar 2010 14:45:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 03 Mar 2010 09:45:40 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Mar 2010 09:45:18 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1003032018330.21953@vqena.qenxr.bet.am>
 <alpine.LNX.2.00.1003031947180.19842@vqena.qenxr.bet.am>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141455>

On Wed, Mar 03, 2010 at 07:50:34PM +1300, Steven Drake wrote:

> On Sun, 28 Feb 2010, Jeff King wrote:
> > On Sun, Feb 28, 2010 at 01:03:00PM +1300, Steven Drake wrote:
> > 
> > > Add 'git commit --spell' to run a spell checker on commit log message.
> > > The `commit.spell` configuration variable can be used to enable the spell
> > > checker by default and can be turned off by '--no-spell'.
> > 
> > Isn't this exactly the sort of thing the commit-msg hook is for?
> 
> Accept then there would be no way of having '--spell'/'--no-spell' (Yet!).

You would have to spell it:

  NO_SPELL=1 git commit

which admittedly isn't as nice. But I'm not sure why you would want
--no-spell. I guess for rebases and such where you aren't writing the
message directly? But in that case, shouldn't it be passing --no-verify
already (and if we go with your patch, should --no-verify perhaps imply
--no-spell)?

> Plus as I have just found out all hooks are run with stdin as '/dev/null' so
> there is no way of running an interactive command like 'ispell' from a hook!

Yes, you have to do "ispell </dev/tty". Though both that and your
original suffer from somebody running "git gui" or similar in a terminal
that the user is no longer looking at. I see you check for isatty(), but
I don't know if that is enough for git gui (or any of the other
graphical commit helpers).

> > Though personally I would probably just invoke interactive spell-checking
> > from the editor.
> 
> I would probably forget to.

Sure, but that is a problem with --spell, too. And you have already
solved it here, with commit.spell configuration. So why does that
technique not apply to configuring your editor?

I'm not 100% against your patch. I'm just concerned that it is adding
code and complexity for a feature that nobody will use, because
everybody else is already doing the same thing through their editor,
which is cleaner (e.g., we don't have to worry about handling --no-spell
for scripts).

-Peff
