From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v4 3/6] Color skipped tests blue
Date: Sun, 11 Nov 2012 02:04:14 +0000
Message-ID: <20121111020355.GA11565@gmail.com>
References: <20120919201326.GA23016@sigill.intra.peff.net>
 <1348086263-27555-1-git-send-email-git@adamspiers.org>
 <20120921061325.GA15867@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 11 03:15:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXN5T-0005kF-8B
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 03:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090Ab2KKCN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 21:13:56 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:54788 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001Ab2KKCNz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 21:13:55 -0500
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Nov 2012 21:13:55 EST
Received: from localhost (9.c.4.7.c.a.1.d.d.3.0.3.d.d.1.1.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:11dd:303d:d1ac:74c9])
	by coral.adamspiers.org (Postfix) with ESMTPSA id B4DAE2E5D5;
	Sun, 11 Nov 2012 02:04:14 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20120921061325.GA15867@sigill.intra.peff.net>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209321>

On Fri, Sep 21, 2012 at 02:13:25AM -0400, Jeff King wrote:
> On Wed, Sep 19, 2012 at 09:24:23PM +0100, Adam Spiers wrote:
> 
> >  t/test-lib.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 5293830..78c88c2 100755
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -182,13 +182,13 @@ then
> >  		error)
> >  			tput bold; tput setaf 1;; # bold red
> >  		skip)
> > -			tput bold; tput setaf 2;; # bold green
> > +			tput setaf 4;;            # blue
> >  		warn)
> >  			tput bold; tput setaf 3;; # bold yellow
> >  		pass)
> >  			tput setaf 2;;            # green
> >  		info)
> > -			tput setaf 3;;            # brown
> > +			tput setaf 3;;            # yellow/brown
> 
> I happened to be running a test script with "-v" earlier today, and I
> noticed that the "expecting success..." dump of the test contents is
> also yellow. By your new rules, shouldn't it be blue?
> 
> I think it is matching the "info" type, which from the discussion should
> be blue, no?

It uses the "default" colour:

    say >&3 "expecting success: $2"

where say is defined:

    say () {
            say_color info "$*"
    }

Many other messages are output in this default colour too, and I never
proposed to change it.  The only time in the discussion where blue was
associated with "info" was in this sentence I wrote in the
commit message for the patch altering the colour of "skip" messages:

   "However, it's more informational than cautionary, so instead we
    use blue which is a universal color for information signs."

Whilst it could also be applied to "info", I don't think it would be a
good idea to have the "skip" and "info" colours *both* as bold blue.
It seems to me more important that the "skip" messages should visually
stand out more than "info", since they are rarer and a more notable
level of information than the latter (especially if --verbose is
used).  Additionally, yellow is already somewhat overloaded (yellow
for "info" and bold yellow for "warn").  Therefore I would suggest
changing "info" to perhaps bold white or bold cyan.  Or "skip" could
be magenta and "info" blue.  But now we are heading down a slippery
slope; it'll be near impossible to please everyone.  Any final
thoughts?

> Maybe it is just my terminal. I see it is labeled as "brown" here, but
> it looks very yellow (and I am using the stock xterm colors. According
> to:
> 
>   https://en.wikipedia.org/wiki/ANSI_colors
> 
> It looks it really is brown on some platforms.

Yes, it can be.

> I'm not sure if it is
> worth worrying about.  I don't really want to get into configurable
> colors just for the test-suite output.

Agreed.  There is no indisputably correct combination.  However, I
think that, modulo a tweak for the above, we are definitely in the
right ball park.  The main thing is that the traffic light colour
scheme is adhered to, and that different types of message are clearly
visually separated, with more important ones standing out more than
less important ones.
