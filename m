From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: Fix UTF Encoding issue
Date: Tue, 4 Dec 2007 10:12:50 +0200
Organization: Pardus / KDE
Message-ID: <200712041012.50935.ismail@pardus.org.tr>
References: <4753D419.80503@clearchain.com> <47547930.5070603@clearchain.com> <20071204080407.GC31042@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benjamin Close <Benjamin.Close@clearchain.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org,
	Perl Unicode Mailing List <perl-unicode@perl.org>,
	Dan Kogai <dankogai@dan.co.jp>
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue Dec 04 09:12:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzStJ-0004qB-7k
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 09:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbXLDIMJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Dec 2007 03:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbXLDIMI
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 03:12:08 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:44092 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750709AbXLDIMF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Dec 2007 03:12:05 -0500
Received: from ninjamobile.local (unknown [85.102.220.209])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 36EAB61CD611;
	Tue,  4 Dec 2007 10:11:58 +0200 (EET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <20071204080407.GC31042@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67016>

Tuesday 04 December 2007 10:04:07 Martin Koegler yazm=C4=B1=C5=9Ft=C4=B1=
:
> On Tue, Dec 04, 2007 at 08:16:24AM +1030, Benjamin Close wrote:
> > Jakub Narebski wrote:
> > >On Mon, 3 Dec 2007, Martin Koegler wrote:
> > >>On Mon, Dec 03, 2007 at 04:06:48AM -0800, Jakub Narebski wrote:
> > >>>Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:
> > >>>>Monday 03 December 2007 Tarihinde 12:14:43 yazm??t?:
> > >>>>>Benjamin Close <Benjamin.Close@clearchain.com> writes:
> > >>>>>>-	eval { $res =3D decode_utf8($str, Encode::FB_CROAK); };
> > >>>>>>-	if (defined $res) {
> > >>>>>>-		return $res;
> > >>>>>>-	} else {
> > >>>>>>-		return decode($fallback_encoding, $str,
> > >>>>>>Encode::FB_DEFAULT);
> > >>>>>>-	}
> > >>>>>>+	eval { return ($res =3D decode_utf8($str, Encode::FB_CROAK)=
);
> > >>>>>>};
> > >>>>>>+	return decode($fallback_encoding, $str, Encode::FB_DEFAULT)=
;
> > >>>>>> }
> > >>
> > >>This version is broken on Debian sarge and etch. Feeding a UTF-8 =
and a
> > >>latin1
> > >>encoding of the same character sequence yields to different resul=
ts.
> >
> > For the record, this was on a debian sid machine.
> >
> > #perl --version
> > This is perl, v5.8.8 built for x86_64-linux-gnu-thread-multi
> >
> > and the result of not using the original patch was:
> >
> > <h1>Software error:</h1>
> > <pre>Cannot decode string with wide characters at
> > /usr/lib/perl/5.8/Encode.pm line 166.
> > </pre>
> >
> >
> > I haven't tried the other solutions tested here.
>
> Debian etch also has v5.8.8.
>
> My main question is, why is the error not catched?
>
> I'm not a perl programmer, but in your patch the first line is a
> NOP. The return in eval seems to only returns from the eval block, so
> any text is decoded as latin1 with the second statement.
>
> In the original version, decode($fallback_encoding, $str,
> Encode::FB_DEFAULT) can not emit an error, else it would in your
> version too.
>
> In your version, eval is able to surpress the error of
> decode_utf8($str, Encode::FB_CROAK);, but not in the original version=
=2E

I think just a better method is to use (not tested):

if( is_utf8($str) )=20
{
	return decode_utf8($str);
}
else {
	return decode($str);
}

Regards,
ismail

--=20
Never learn by your mistakes, if you do you may never dare to try again=
=2E
