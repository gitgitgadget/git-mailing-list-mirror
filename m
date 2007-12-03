From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: Fix UTF Encoding issue
Date: Mon, 3 Dec 2007 13:32:36 +0200
Organization: Pardus / KDE
Message-ID: <200712031332.36187.ismail@pardus.org.tr>
References: <4753D419.80503@clearchain.com> <7v7ijwjd9o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benjamin Close <Benjamin.Close@clearchain.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 12:32:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz9X6-0007Xs-BE
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 12:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921AbXLCLb4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Dec 2007 06:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbXLCLb4
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 06:31:56 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:36804 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752701AbXLCLbz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Dec 2007 06:31:55 -0500
Received: from ninjamobile.local (unknown [85.102.220.209])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 6E2BD61CE61E;
	Mon,  3 Dec 2007 13:31:46 +0200 (EET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <7v7ijwjd9o.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66912>

Monday 03 December 2007 Tarihinde 12:14:43 yazm=C4=B1=C5=9Ft=C4=B1:
> Benjamin Close <Benjamin.Close@clearchain.com> writes:
> >>From 83042abf3967b455953cddeab43e33c1d59c6f03 Mon Sep 17 00:00:00 2=
001
> >
> > From: Benjamin Close <Benjamin.Close@clearchain.com>
> > Date: Sun, 2 Dec 2007 15:09:00 -0800
> > Subject: [PATCH] Gitweb: Fix encoding to always translate rather th=
an
> > sometimes fail
> >
> > When performing the utf translation don't test if $res is defined.
> > It appears that it is defined even when the conversion fails. This =
causes
> > failures on the writing of the output stream which is expecting UTF=
=2E
> > @@ -696,12 +696,8 @@ sub validate_refname {
> >  sub to_utf8 {
> >  	my $str =3D shift;
> >  	my $res;
> > -	eval { $res =3D decode_utf8($str, Encode::FB_CROAK); };
> > -	if (defined $res) {
> > -		return $res;
> > -	} else {
> > -		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
> > -	}
> > +	eval { return ($res =3D decode_utf8($str, Encode::FB_CROAK)); };
> > +	return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
> >  }
>
> This is funny.
>
> I thought the standard catch ... throw idiom in Perl was to do the ab=
ove
> like this:
>
> 	my $res;
>         eval { $res =3D decode_utf8($str, Encode::FB_CROAK); };
>         if ($@) {
>         	return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
> 	}
> 	return $res;

I think this is correct, but the current code in gitweb doesn't look co=
rrect=20
since it checks for $res and not $@.

Regards,
ismail


--=20
Never learn by your mistakes, if you do you may never dare to try again=
=2E
