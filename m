From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: Re: [PATCH 2/5] gitweb: Move check-ref-format code into separate
 function
Date: Thu, 05 Dec 2013 10:19:53 +0100
Message-ID: <1386235193.2186.3.camel@localhost.localdomain>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
	 <1386164583-14109-3-git-send-email-krzesimir@endocode.com>
	 <CANQwDwfWPuH_OOU46yOrRN23qbppHBQbXEUnDcR37dF=93A-iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 10:20:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoV6I-0001pQ-N8
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 10:20:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875Ab3LEJT7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 04:19:59 -0500
Received: from mail-bk0-f44.google.com ([209.85.214.44]:57656 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746Ab3LEJT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 04:19:57 -0500
Received: by mail-bk0-f44.google.com with SMTP id d7so7003400bkh.17
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 01:19:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=dnIMf9ROayY9nIibx693i4LjgCwx4RKwH+4DdVgTOtA=;
        b=Yw9xAAqziJRiIzP0EoqM9S7IGomr7DQ80lQ63CL3c/enuyBXrctg1We9pwlGRN5Eml
         Uq8a0IjRfQ88CgVsbnMvlHBumIWV2nIeJljEHr+RmqXP6EUY59nfHIfVDjbY2pI1DRUH
         rpakgNiN7kO0YoPHLT0Ri5CFxVwwwV7MXO3EROzcndTWF5/7K8NISeIOyVUhHS7WoJ97
         2gqH0PkQyLOfDKH/LfiezZPmCCLh2UpMPdwfuQsSuwDiGb71wNMPl34D693yssL+taZ8
         kQ25vCRQXtn/aAYcuwCQWAfFkiscfrpgjpiS/MQDcmb8XTcTc3Wt1KaCFLFlYpsQllzC
         xGTw==
X-Gm-Message-State: ALoCoQk49iPzBNJVd4vG/5g4h3h2UY55uotBRdAWqk9moWJVH9/RzAg26lX9U/Xuytwas8Lq/2wr
X-Received: by 10.205.46.201 with SMTP id up9mr646888bkb.64.1386235195964;
        Thu, 05 Dec 2013 01:19:55 -0800 (PST)
Received: from [192.168.178.31] (p57922DC5.dip0.t-ipconnect.de. [87.146.45.197])
        by mx.google.com with ESMTPSA id bf8sm36171164bkb.14.2013.12.05.01.19.54
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 01:19:55 -0800 (PST)
In-Reply-To: <CANQwDwfWPuH_OOU46yOrRN23qbppHBQbXEUnDcR37dF=93A-iA@mail.gmail.com>
X-Mailer: Evolution 3.8.5 (3.8.5-2.fc19) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238850>

On Wed, 2013-12-04 at 16:56 +0100, Jakub Nar=C4=99bski wrote:
> On Wed, Dec 4, 2013 at 2:43 PM, Krzesimir Nowak <krzesimir@endocode.c=
om> wrote:
>=20
> > This check will be used in more than one place later.
> >
> > Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
> > Reviewed-by: Junio C Hamano <gitster@pobox.com>
> > Reviewed-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
>=20
> All right, that is nice refactoring.
>=20
> > ---
> >  gitweb/gitweb.perl | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index ee61f9e..67415b9 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -1452,6 +1452,16 @@ sub validate_pathname {
> >         return $input;
> >  }
> >
> > +sub check_ref_format {
> > +       my $input =3D shift || return undef;
> > +
> > +       # restrictions on ref name according to git-check-ref-forma=
t
> > +       if ($input =3D~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
> > +               return undef;
> > +       }
> > +       return $input;
> > +}
> > +
> >  sub validate_refname {
> >         my $input =3D shift || return undef;
> >
> > @@ -1462,10 +1472,9 @@ sub validate_refname {
> >         # it must be correct pathname
> >         $input =3D validate_pathname($input)
> >                 or return undef;
> > -       # restrictions on ref name according to git-check-ref-forma=
t
> > -       if ($input =3D~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
> > -               return undef;
> > -       }
> > +       # check git-check-ref-format restrictions
> > +       check_ref_format($input)
> > +               or return undef;
> >         return $input;
> >  }
>=20
> Right, check_ref_format() has name after git-check-ref-format...
> though... check_ref_format() or die  doesn't read completely
> naturally...
>=20

Ok, I'll rename it to is_valid_ref_format.

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
