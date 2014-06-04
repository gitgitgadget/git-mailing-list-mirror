From: Michael Wagner <mail@mwagner.org>
Subject: Re: [PATCH] gitweb: Harden UTF-8 handling in generated links
Date: Wed, 4 Jun 2014 22:47:46 +0200
Message-ID: <20140604204746.GA1855@localhost.localdomain>
References: <20140514184145.GA25699@localhost.localdomain>
 <xmqqd2fghvlf.fsf@gitster.dls.corp.google.com>
 <CANQwDwdh1qQkYi9sB=22wbNnb+g5qv5prCzj2aWhHBbTZhVhdg@mail.gmail.com>
 <20140515050820.GA30785@localhost.localdomain>
 <alpine.DEB.2.00.1405150957520.10221@ds9.cixit.se>
 <20140515184808.GA7964@localhost.localdomain>
 <CANQwDwe+GJ+yAYWdVfMaHq97zGXBoepCfUdLiaQD9LFoz3SiOA@mail.gmail.com>
 <53849FB2.7000701@gmail.com>
 <20140604154128.GA28549@localhost.localdomain>
 <538F69DA.9010201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 22:47:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsI6G-0003mN-2I
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 22:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbaFDUrw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2014 16:47:52 -0400
Received: from caelum.uberspace.de ([95.143.172.212]:47884 "EHLO
	caelum.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbaFDUrv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 16:47:51 -0400
Received: (qmail 32070 invoked from network); 4 Jun 2014 20:47:48 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by caelum.uberspace.de with SMTP; 4 Jun 2014 20:47:48 -0000
Content-Disposition: inline
In-Reply-To: <538F69DA.9010201@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250778>

On Wed, Jun 04, 2014 at 08:47:54PM +0200, Jakub Nar=C4=99bski wrote:
> Michael Wagner wrote:
> > On Tue, May 27, 2014 at 04:22:42PM +0200, Jakub Nar=C4=99bski wrote=
:
>=20
> >> Subject: [PATCH] gitweb: Harden UTF-8 handling in generated links
> >>
> >> esc_html() ensures that its input is properly UTF-8 encoded and ma=
rked
> >> as UTF-8 with to_utf8().  Make esc_param() (used for query paramet=
ers
> >> in generated URLs), esc_path_info() (for escaping path_info
> >> components) and esc_url() use it too.
> >>
> >> This hardens gitweb against errors in UTF-8 handling; because
> >> to_utf8() is idempotent it won't change correct output.
> [...]
> >>   sub esc_param {
> >>   	my $str =3D shift;
> >>   	return undef unless defined $str;
> >> +
> >> +	$str =3D to_utf8($str);
> >>   	$str =3D~ s/([^A-Za-z0-9\-_.~()\/:@ ]+)/CGI::escape($1)/eg;
> >>   	$str =3D~ s/ /\+/g;
> >> +
> >>   	return $str;
> >>   }  =20
> =20
> > While trying to view a "blob_plain" of "G=C3=BCtekritierien.txt", a=
 404 error
> > occured. "git_get_hash_by_path" tries to resolve the hash with the =
wrong
> > filename (git ls-tree -z HEAD -- G=C3=83=C2=BCtekriterien.txt) and =
fails.
> >=20
> > The filename needs the correct encoding. Something like this is pro=
bably
> > needed for all filenames and should be done at a prior stage:
>=20
> True.
>=20
> First, I wonder why the tests I did for this situation didn't
> show any errors even before the "harden href()" patch. What
> is different in your config that you see those errors?
>=20

Nothing special. It is reproducible with git 1.9.3 (Fedora 20), git
instaweb (lighttpd) and LANG=3Dde_DE.UTF-8. =20
=20
