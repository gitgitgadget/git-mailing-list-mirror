From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: Re: [PATCH 3/5] gitweb: Return plain booleans in validation methods
Date: Thu, 05 Dec 2013 10:23:42 +0100
Message-ID: <1386235422.2186.7.camel@localhost.localdomain>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
	 <1386164583-14109-4-git-send-email-krzesimir@endocode.com>
	 <CANQwDweGgQpnqDqaekBWt-rczjHkJEmFyXW9qDh2En2r=ZXbMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 10:23:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoVA2-0004KM-5N
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 10:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948Ab3LEJXt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 04:23:49 -0500
Received: from mail-bk0-f47.google.com ([209.85.214.47]:64621 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496Ab3LEJXq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 04:23:46 -0500
Received: by mail-bk0-f47.google.com with SMTP id mx12so6930735bkb.6
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 01:23:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=xzVmGzMzdeIranlcCRT0vXM4YAtr2xsFqaYtYh6HufQ=;
        b=jOdrVVy8SKPtKOTLR7glNBxe0mK6qp/Dmi6iwPmR3PxvPlqaAym7KGQSYoOU/Yv/v2
         TA2VDfVDznaY74mKi6lm8ycMElrdFEKTQtIDPJx0/nDBUGoA5ukK+cOGfhjSUAA4dkKM
         uUYePyOya01cuJ4ZoO/Tl3rx9crZ1X/onMU64cYwglFNaUD/d3lHYvEMhg57FKqSaGMK
         3vGqydOVNqOYnSOSAwzA3+XWHHk9+SL/227oW0lhxOUCAmR+jyAETEEEa5MvNIvUtl7s
         CR2RnIPlkmt9Nulz+mAm+fb9zHnjsADja9biW195qoOxH0UlYPbVvL6CdYWXwSm+62ky
         6ICQ==
X-Gm-Message-State: ALoCoQlFyZ/kVxSoXoQBR5z5ewh8y0dApY9wrTrI8xVjaR+TM4wh7peQ5BdTe50V/urkSdVbC62F
X-Received: by 10.205.36.193 with SMTP id tb1mr53822187bkb.28.1386235425156;
        Thu, 05 Dec 2013 01:23:45 -0800 (PST)
Received: from [192.168.178.31] (p57922DC5.dip0.t-ipconnect.de. [87.146.45.197])
        by mx.google.com with ESMTPSA id t2sm84258156bkh.3.2013.12.05.01.23.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 01:23:44 -0800 (PST)
In-Reply-To: <CANQwDweGgQpnqDqaekBWt-rczjHkJEmFyXW9qDh2En2r=ZXbMw@mail.gmail.com>
X-Mailer: Evolution 3.8.5 (3.8.5-2.fc19) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238851>

On Wed, 2013-12-04 at 17:07 +0100, Jakub Nar=C4=99bski wrote:
> On Wed, Dec 4, 2013 at 2:43 PM, Krzesimir Nowak <krzesimir@endocode.c=
om> wrote:
>=20
> > Users of validate_* passing "0" might get failures on correct name
> > because of coercion of "0" to false in code like:
> > die_error(500, "invalid ref") unless (check_ref_format ("0"));
>=20
> I would say that the problem was that validate_sth() subroutines retu=
rned
> value of parameter if it was valid, which could be a problem if said =
value is
> false-ish (e.g. validate_refname("0"), or validate_pathname("0")).

That's what I meant.

>=20
> Returning undef on invalid data newer was a problem, using 'return $i=
nput;'
> on valid input was, especially that validate_sth() functions were eve=
r used
> in a conditional:
>=20
>   if (!validate_sth($param)) {
>       die_error(...)
>   }
>=20
> While at it validate_sth() is not a best name for boolean predicate:
> is_valid_sth() would be better, I think.

Ok, I'll rename those.

>=20
> > Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
> > ---
> >  gitweb/gitweb.perl | 45 +++++++++++++++++++++++++-----------------=
---
> >  1 file changed, 25 insertions(+), 20 deletions(-)
> >
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 67415b9..3434602 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -1419,63 +1419,68 @@ sub href {
> >  ## validation, quoting/unquoting and escaping
> >
> >  sub validate_action {
> > -       my $input =3D shift || return undef;
> > -       return undef unless exists $actions{$input};
> > -       return $input;
> > +       my $input =3D shift;
> > +
> > +       return 0 unless defined $input;
> > +       return 0 unless exists $actions{$input};
> > +       return 1;
> >  }
>=20
> The only change that needs to be doe is replacing
>=20
>            return $input;
>=20
> with
>=20
>            return 1;
>=20

I prefer to use zeros instead of undefs - one might wonder if that unde=
f
is somewhat special that we can't use 0.

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
