From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] documentation: Makefile accounts for SHELL_PATH setting
Date: Sat, 21 Mar 2009 07:38:35 -0400
Message-ID: <1237635198-sup-2111@ntdws12.chass.utoronto.ca>
References: <1237603220-22897-1-git-send-email-bwalton@artsci.utoronto.ca> <20090321032240.GA31547@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1237635520-431584-28712-1057-26-="; micalg="pgp-sha1"
Cc: GIT List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 21 12:40:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkzYj-0007lz-Av
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 12:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbZCULip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 07:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752737AbZCULio
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 07:38:44 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:56324 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbZCULin (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 07:38:43 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253] ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1LkzXF-00046w-7w; Sat, 21 Mar 2009 07:38:41 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1LkzXF-0006tx-5Q; Sat, 21 Mar 2009 07:38:41 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n2LBcejt026529;
	Sat, 21 Mar 2009 07:38:40 -0400
In-Reply-To: <20090321032240.GA31547@coredump.intra.peff.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114035>


--=-1237635520-431584-28712-1057-26-=
Content-Type: text/plain; charset=UTF-8

Excerpts from Jeff King's message of Fri Mar 20 23:22:40 -0400 2009:
> > +#retain original (but broken) behaviour if SHELL_PATH isn't overridden
> > +ifndef SHELL_PATH
> > +    SHELL_PATH = sh
> > +endif
> 
> The Makefile in t/Makefile does:
> 
>   SHELL_PATH ?= $(SHELL)
> 
> which I think makes more sense (and yes, yours actually keeps the
> existing behavior, but it's probably better to inherit from SHELL in
> case it is set to something more useful).

I used the ifndef/endif setup becuase that's how the PERL_PATH was set
and also becuase I think it's slightly more explicit.  I'm ok with ?=
though too.  I had considered using $(SHELL), but discarded it because
it veered from the current behaviour.  I agree that $(SHELL) is likely
better than sh though.

> >  install-html: html
> > -    sh ./install-webdoc.sh $(DESTDIR)$(htmldir)
> > +    $(SHELL_PATH) ./install-webdoc.sh $(DESTDIR)$(htmldir)
> 
> You need a SHELL_PATH_SQ to handle paths with spaces; see t/Makefile for
> an example.

Ok.  I'll look at this and implement the _SQ bits too to make it safer
and more general.

> I wonder if both subdirs should simply be pulling from
> GIT-BUILD-OPTIONS, though, which would allow this to use the specified
> SHELL_PATH:
> 
>   $ make SHELL_PATH=whatever
>   $ cd Documentation && make
> 
> but maybe it is not worth caring about (since it may complicate building
> Documentation if you _haven't_ build the actual code).

In my case, I'm using the configure script and then running make,
which sees the Documentation/Makefile source in the ../config.mak
files, so there may be some variance between pure make and make +
autoconf in this respect.  I hadn't looked at it in that light.
Should this be reconciled too?

I'm away today, but will try to correct this patch when I get home.

Thanks
-Ben
-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302

GPG Key Id: 8E89F6D2; Key Server: pgp.mit.edu
Contact me to arrange for a CAcert assurance meeting.

--=-1237635520-431584-28712-1057-26-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFJxNHA8vuMHY6J9tIRAm48AKCWUGIR1atlcEw+KKb/dcPiNJq7vQCg6SWS
sJJnFApxhqm3+c2eMqHSptA=
=0QH1
-----END PGP SIGNATURE-----

--=-1237635520-431584-28712-1057-26-=--
