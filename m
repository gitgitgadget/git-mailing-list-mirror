From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] send-email: extend sanitize_address_rfc822 to do rfc2047 quoting
Date: Wed, 11 Jul 2007 13:49:09 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070711114909.GA14086@informatik.uni-freiburg.de>
References: <11840869641759-git-send-email-ukleinek@informatik.uni-freiburg.de> <20070711084232.GE1528MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Wed Jul 11 13:49:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8ah3-0000ac-Pe
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 13:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762337AbXGKLtO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 11 Jul 2007 07:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760329AbXGKLtO
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 07:49:14 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:56784 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759876AbXGKLtN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jul 2007 07:49:13 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1I8agx-0006sq-Sq; Wed, 11 Jul 2007 13:49:12 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l6BBn9FG014284;
	Wed, 11 Jul 2007 13:49:09 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l6BBn9hq014283;
	Wed, 11 Jul 2007 13:49:09 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	skimo@liacs.nl, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070711084232.GE1528MdfPADPa@greensroom.kotnet.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52153>

Sven Verdoolaege wrote:
> On Tue, Jul 10, 2007 at 07:02:43PM +0200, Uwe Kleine-K=F6nig wrote:
> >  	my ($recipient) =3D @_;
> > -	my ($recipient_name) =3D ($recipient =3D~ /^(.*?)\s+</);
> > +	my ($recipient_name, $recipient_addr) =3D ($recipient =3D~ /^(.*?=
)(\s+<.*)/);
> > +
> > +	if ($recipient_name && $recipient_name =3D~ /[^-a-zA-Z0-9!*+\/ ]/=
 && $recipient_name !~ /=3D\?utf-8\?q?.*\?=3D/) {
>=20
> Why the extra test for truthness of $recipient_name ?
Try:

	my $recipient =3D 'skimo@kotnet.org';
	my ($recipient_name, $recipient_addr) =3D ($recipient =3D~ /^(.*?)(\s+=
<.*)/);
	print "Hoppla\n" if (!$recipient_name);

i.e. if the pattern doesn't match, recipient_name is undefined.

But the function could be simplyfied anyhow.  e.g.

	if ($recipient_name) {
		... do all the quoting ...
		return "$recipient_name$recipient_addr";
	} else {
		return $recipient;
	}

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3Dsquare+root+of+2
