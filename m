From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with
	non-ascii characters
Date: Sat, 29 Mar 2008 17:18:49 -0400
Message-ID: <20080329211849.GA30851@coredump.intra.peff.net>
References: <20080328212700.GA9529@coredump.intra.peff.net> <200803291038.48847.robin.rosenberg.lists@dewire.com> <20080329095238.GB21814@coredump.intra.peff.net> <200803291354.10368.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Mar 29 22:19:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfiSc-0001QK-GE
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 22:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738AbYC2VSw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Mar 2008 17:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754649AbYC2VSw
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 17:18:52 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2361 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754598AbYC2VSw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 17:18:52 -0400
Received: (qmail 5861 invoked by uid 111); 29 Mar 2008 21:18:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 29 Mar 2008 17:18:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Mar 2008 17:18:49 -0400
Content-Disposition: inline
In-Reply-To: <200803291354.10368.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78483>

On Sat, Mar 29, 2008 at 01:54:10PM +0100, Robin Rosenberg wrote:

> I think you really should try the UTF-8 guess, since a file may well =
be UTF-8=20
> even if the user locale is something else. Especially for XML files, =
UTF-8
> is common, but there are many more cases. Look into git-gui/po for mo=
re=20
> examples. The probability of a UTF-8 test being wrong is just so unim=
aginable=20
> low.

Thinking about this more, I think it is only half the solution. If
something is not valid utf-8, then we know it must be something else.
But if something is valid utf-8, is it necessarily utf-8? I think we ar=
e
going to have a much higher probability of guessing wrong there.

=46or example, consider the bytes { 0xc3, 0xb6 }. In utf-8, they are '=C3=
=B6'.
But in iso8859-1, they also have meaning (paragraph symbol followed by
=C3=83). Now that is an unlikely combination to come up. And maybe for
Latin-1, having two non-ascii characters next to each other is unlikely=
=2E
But over all commonly used encodings, what is the probability in an
average text of that encoding that it contains valid UTF-8?
=46or example, I have no idea what patterns can be found in EUCJP.

> > PS Your 'require' is more simply written as 'use I18N::Langinfo
> > qw(langinfo CODESET)', or perhaps even simpler:
>=20
> See the man page, from which I stole it. It suggests you wrap it all =
inside=20
> eval {}, just in case your perl does not have langinfo.

Yes, that does make sense for a script (I just couldn't see it because
the entire toy example would be inside the eval).

> As for the is_utf8() i'm not sure what it does, but I can't make it w=
ork.

There is some magic with how Perl marks strings as "binary" versus
"utf-8" that I don't quite understand. And I think is_utf8 is really
about asking "is the utf-8 flag set".

I think this discussion would benefit greatly from somebody who has mor=
e
of a clue how perl i18n stuff works. Why don't you work up a patch that
makes sense for you, and then hopefully that will get some attention?

-Peff
