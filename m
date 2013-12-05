From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: Re: [PATCH 2/5] gitweb: Move check-ref-format code into separate
 function
Date: Thu, 05 Dec 2013 10:18:40 +0100
Message-ID: <1386235120.2186.2.camel@localhost.localdomain>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
	 <1386164583-14109-3-git-send-email-krzesimir@endocode.com>
	 <xmqqsiu8jr2i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jnareb@gmail.com, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 10:19:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoV5R-0001FX-Im
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 10:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178Ab3LEJTG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 04:19:06 -0500
Received: from mail-bk0-f45.google.com ([209.85.214.45]:37433 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746Ab3LEJSo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 04:18:44 -0500
Received: by mail-bk0-f45.google.com with SMTP id mx13so7002523bkb.18
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 01:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=BBB10gK6EZ5pHoaPP3EWtL7JcfzOWMH/KJ1Rjx84JYE=;
        b=BaI8Onf4y70BrQMr0RR/Jhx9AmTfzsTtbprk5K0j+dgzGFZyOclcMANmZPVIB++Sq8
         1zVbiyD6UGA4P7eLZMsnn19C8Kas2dB99ta081x7xAWhlkGBVMMTEDo85bYCg9QlPhSQ
         +AkWnH4rGsiFVCxdFl3I45uh2ngxFzOlfP7gtMWlNKSqWAGe/t0HNszHO57ogKihPZne
         WS0k8XqWfSIrQTM68uMy6IYs6930lzOnQcE7hXkEzTuYD16TidfDOmQpUVivNutDtL9r
         yDprOtfNEnem5mzBmCmYwv5c9df2C2Bqkcz4kEOH7Pm+/VqC6qbIHgo1REyq2mkCjG9c
         1Mmw==
X-Gm-Message-State: ALoCoQn4TZysBbCvmHHwEEWBkjP5y1nsF8teiuyyEx6ZKv5m7KJzMKaOvHGKjxKHJK3E0MDjmyQR
X-Received: by 10.205.12.133 with SMTP id pi5mr658185bkb.54.1386235122935;
        Thu, 05 Dec 2013 01:18:42 -0800 (PST)
Received: from [192.168.178.31] (p57922DC5.dip0.t-ipconnect.de. [87.146.45.197])
        by mx.google.com with ESMTPSA id tb8sm3759142bkb.10.2013.12.05.01.18.41
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 01:18:42 -0800 (PST)
In-Reply-To: <xmqqsiu8jr2i.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.8.5 (3.8.5-2.fc19) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238849>

On Wed, 2013-12-04 at 12:31 -0800, Junio C Hamano wrote:
> Krzesimir Nowak <krzesimir@endocode.com> writes:
>=20
> > This check will be used in more than one place later.
> >
> > Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
> > Reviewed-by: Junio C Hamano <gitster@pobox.com>
>=20
> Again, I do not think I reviewed this exact version. Nor did I say
> that use of the "... or return undef" is a good idea.

Ok, I'll drop them. Too much fuss over those lines.

>=20
> > Reviewed-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
> > ---
> >  gitweb/gitweb.perl | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index ee61f9e..67415b9 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -1452,6 +1452,16 @@ sub validate_pathname {
> >  	return $input;
> >  }
> > =20
> > +sub check_ref_format {
> > +	my $input =3D shift || return undef;
> > +
> > +	# restrictions on ref name according to git-check-ref-format
> > +	if ($input =3D~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
> > +		return undef;
> > +	}
> > +	return $input;
> > +}
> > +
> >  sub validate_refname {
> >  	my $input =3D shift || return undef;
> > =20
> > @@ -1462,10 +1472,9 @@ sub validate_refname {
> >  	# it must be correct pathname
> >  	$input =3D validate_pathname($input)
> >  		or return undef;
> > -	# restrictions on ref name according to git-check-ref-format
> > -	if ($input =3D~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
> > -		return undef;
> > -	}
> > +	# check git-check-ref-format restrictions
> > +	check_ref_format($input)
> > +		or return undef;
> >  	return $input;
> >  }

--=20
Krzesimir Nowak
Software Developer
Endocode AG

krzesimir@endocode.com

------
Endocode AG, Johannisstra=C3=9Fe 20, 10117 Berlin
info@endocode.com | www.endocode.com

Vorstandsvorsitzender: Mirko Boehm
Vorst=C3=A4nde: Dr. Karl Beecher, Chris K=C3=BChl, Sebastian Sucker
Aufsichtsratsvorsitzende: Jennifer Beecher

Registergericht: Amtsgericht Charlottenburg - HRB 150748 B
