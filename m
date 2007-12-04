From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: Fix UTF Encoding issue
Date: Tue, 4 Dec 2007 09:04:07 +0100
Message-ID: <20071204080407.GC31042@auto.tuwien.ac.at>
References: <4753D419.80503@clearchain.com> <m3prxougmx.fsf@roke.D-201> <20071203163856.GA24269@auto.tuwien.ac.at> <200712031802.55514.jnareb@gmail.com> <47547930.5070603@clearchain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>,
	Junio C Hamano <gitster@pobox.com>,
	Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org,
	Perl Unicode Mailing List <perl-unicode@perl.org>,
	Dan Kogai <dankogai@dan.co.jp>
To: Benjamin Close <Benjamin.Close@clearchain.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 09:04:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzSlc-00039q-WA
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 09:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbXLDIEN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Dec 2007 03:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbXLDIEN
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 03:04:13 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:52305 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933AbXLDIEM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 03:04:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id B0A958BE0E70;
	Tue,  4 Dec 2007 09:04:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9GNddLm-+zZK; Tue,  4 Dec 2007 09:04:07 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 32370680BB03; Tue,  4 Dec 2007 09:04:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <47547930.5070603@clearchain.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67015>

On Tue, Dec 04, 2007 at 08:16:24AM +1030, Benjamin Close wrote:
> Jakub Narebski wrote:
> >On Mon, 3 Dec 2007, Martin Koegler wrote:
> >>On Mon, Dec 03, 2007 at 04:06:48AM -0800, Jakub Narebski wrote:
> >>>Ismail D=F6nmez <ismail@pardus.org.tr> writes:
> >>>>Monday 03 December 2007 Tarihinde 12:14:43 yazm??t?:
> >>>>>Benjamin Close <Benjamin.Close@clearchain.com> writes:
> >>>>>>-	eval { $res =3D decode_utf8($str, Encode::FB_CROAK); };
> >>>>>>-	if (defined $res) {
> >>>>>>-		return $res;
> >>>>>>-	} else {
> >>>>>>-		return decode($fallback_encoding, $str,=20
> >>>>>>Encode::FB_DEFAULT);
> >>>>>>-	}
> >>>>>>+	eval { return ($res =3D decode_utf8($str, Encode::FB_CROAK));=
=20
> >>>>>>};
> >>>>>>+	return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
> >>>>>> }
> >>>>>>           =20
> >>This version is broken on Debian sarge and etch. Feeding a UTF-8 an=
d a=20
> >>latin1
> >>encoding of the same character sequence yields to different results=
=2E
>
> For the record, this was on a debian sid machine.
>=20
> #perl --version
> This is perl, v5.8.8 built for x86_64-linux-gnu-thread-multi
>=20
> and the result of not using the original patch was:
>=20
> <h1>Software error:</h1>
> <pre>Cannot decode string with wide characters at=20
> /usr/lib/perl/5.8/Encode.pm line 166.
> </pre>
>=20
>=20
> I haven't tried the other solutions tested here.

Debian etch also has v5.8.8.

My main question is, why is the error not catched?

I'm not a perl programmer, but in your patch the first line is a
NOP. The return in eval seems to only returns from the eval block, so
any text is decoded as latin1 with the second statement.

In the original version, decode($fallback_encoding, $str,
Encode::FB_DEFAULT) can not emit an error, else it would in your
version too.=20

In your version, eval is able to surpress the error of
decode_utf8($str, Encode::FB_CROAK);, but not in the original version.

Strange.

mfg Martin K=F6gler
