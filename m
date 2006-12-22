From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
Subject: Re: [PATCH 1/2] libgit.a: add some UTF-8 handling functions
Date: Fri, 22 Dec 2006 23:14:48 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20061222221448.GB2407@cepheus>
References: <20061221085907.GA2244@cepheus> <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de> <200612211623.14236.litvinov2004@gmail.com> <7vejqtaz7q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612220351520.19693@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0612221030440.18171@xanadu.home> <7vslf7zrdp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612222201200.19693@wbgn013.biozentrum.uni-wuerzburg.de> <7virg3y624.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612222233150.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 23:15:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxsfP-0007yO-KZ
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 23:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbWLVWOx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 22 Dec 2006 17:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753060AbWLVWOx
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 17:14:53 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:34841 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752910AbWLVWOw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Dec 2006 17:14:52 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1GxsfD-0004qQ-Jj; Fri, 22 Dec 2006 23:14:51 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id kBMMEm4W025174;
	Fri, 22 Dec 2006 23:14:48 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id kBMMElOe025173;
	Fri, 22 Dec 2006 23:14:47 +0100 (MET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <zeisberg@informatik.uni-freiburg.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612222233150.19693@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35232>

Hello Johannes,

Johannes Schindelin wrote:
> On Fri, 22 Dec 2006, Junio C Hamano wrote:
>=20
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >=20
> > > This adds utf8_byte_count(), utf8_strlen() and print_wrapped_text=
().
> > >
> > > The most important is probably utf8_strlen(), which returns the l=
ength
> > > of the text, if it is in UTF-8, otherwise -1.
> > >
> > > Note that we do not go the full nine yards: we could also check t=
hat
> > > the character is encoded with the minimum amount of bytes, as poi=
nted
> > > out by Uwe Kleine-Koenig.
> > >
> > > The function print_wrapped_text() can be used to wrap text to a c=
ertain
> > > line length.
> >=20
> > If you do wrapped_text, I think you do not _want_ strlen (the
> > definition to me of strlen is "number of characters in the
> > string").  What you want is a function that returns the number
> > of columns consumed when displayed on monospace terminal.
>=20
> To me, characters are the symbols occupying one "column" each. Bytes =
are=20
> the 8-bit thingies that you usually use to encode the characters.
Quoting utf-8(7):

	are no longer valid in UTF-8 locales.  Firstly, a single byte
	does not necessarily correspond any more to a single character.
	Secondly, since modern terminal emulators in UTF-8 mode also
	support Chinese, Japanese, and Korean double-width characters as
	well as non-spacing combining characters, outputting a single
	character does not necessarily advance the cursor by one
	position as it did in ASCII.  Library functions such as
	mbsrtowcs(3) and wcswidth(3) should be used today to count
	characters and cursor positions.

I'd prefer using a similar naming scheme.  To acknowledge Junio,
wcslen(3) (the wide-character equivalent of the strlen() function)
counts the number of (wide-)characters in a string.

Best regards,
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3De+%5E+%28i+pi%29
