From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 1/2] Added basic color support to git add --interactive
Date: Tue, 23 Oct 2007 08:28:28 +0200
Message-ID: <D1795135-AD5E-491C-99E6-30486E189B13@wincent.com>
References: <471045DA.5050902@gmail.com> <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com> <20071013172745.GA2624@coredump.intra.peff.net> <20071013175127.GA3183@coredump.intra.peff.net> <47112491.8070309@gmail.com> <20071015034338.GA4844@coredump.intra.peff.net> <20071016194709.3c1cb3a8@danzwell.com> <20071017015152.GN13801@spearce.org> <20071022163244.4af72973@danzwell.com> <20071023040315.GA28312@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dan Zwell <dzwell@zwell.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 23 08:29:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkDH3-0000AX-6k
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 08:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbXJWG3o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Oct 2007 02:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbXJWG3o
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 02:29:44 -0400
Received: from wincent.com ([72.3.236.74]:39052 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752869AbXJWG3n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Oct 2007 02:29:43 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9N6TGv0003215;
	Tue, 23 Oct 2007 01:29:16 -0500
In-Reply-To: <20071023040315.GA28312@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62112>

El 23/10/2007, a las 6:03, Jeff King escribi=F3:

> This does nothing for embedded newlines in the strings, which means =20
> that
> you can end up with ${COLOR}text\n${RESET}, which fouls up changed
> backgrounds. See commit 50f575fc. Since the strings you are =20
> printing are
> small, I don't see any problem with making a copy, using a regex to
> insert the color coding, and printing that (I think I even posted
> example code in a previous thread on this subject).

I did too, where you add a third, optional "trailer" parameter to the =20
function where you pass the newline if there is one (following the =20
style of the functions in color.c). Pasting it below.

Having said that, I think this kind of function belongs in Git.pm, =20
and the dependency on Term::ANSIColor should be replaced with =20
dependency-free code that generates the colors itself; this should be =20
easy because the number of possible colors is small, Git thus far =20
only uses a subset of the possible ANSI colors, and the C code for =20
doing it is already there in color.c and just needs to be translated =20
into Perl.

sub print_ansi_color {
	my $color =3D shift;
	my $string =3D shift;
	my $trailer =3D shift;
	if ($use_color) {
		print Term::ANSIColor::color($color), $string,
		    Term::ANSIColor::color('clear');
	} else {
		print $string;
	}
	if ($trailer) {
		print $trailer;
	}
}

Cheers,
Wincent
