From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: Re: [PATCH 2/3] gitweb: Add a feature for adding more branch refs
Date: Wed, 04 Dec 2013 13:49:58 +0100
Message-ID: <1386161398.2173.9.camel@localhost.localdomain>
References: <1386082603-8404-1-git-send-email-krzesimir@endocode.com>
	 <1386082603-8404-3-git-send-email-krzesimir@endocode.com>
	 <xmqqr49tn11c.fsf@gitster.dls.corp.google.com>
	 <CANQwDwcpkbbfND9MmB9wGcL7mrhV_Mxb1amvGPgWeR344_fcfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 13:50:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoBu6-00069v-OU
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 13:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232Ab3LDMuE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Dec 2013 07:50:04 -0500
Received: from mail-ee0-f48.google.com ([74.125.83.48]:60119 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932208Ab3LDMuB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 07:50:01 -0500
Received: by mail-ee0-f48.google.com with SMTP id e49so2320827eek.35
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 04:50:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=DLTOsFiQNvZx2NfZlKLey9Rnir8Q31pAH6b5uThvemw=;
        b=OchLkY0dwjWxbu+HaUlsb6Nbbdbk6nhcdYE1CkxOmy1KihVII5ESyqjcDbmiEFGjSu
         97WtErWg36tSMRXuHerL79O+0T9EC3jfhM5K4EPcZlR759HMB5D4/TPiUQO3eqwQsctP
         A0f7XOW+65T2kOKeD8XkzBWiQeO/ANxg981ltfIGWR8CrBDwgHb7bcbDSbuLL1h69pvr
         Qh8sbhto77VchIv4UYHhvVDUReFBWVy41JFcoebSRnepV8f/p9IsoFk8mRdKH5FhtFeo
         dPeb/u+T6KSO5toAFrQeWIgh1ZAKlYsT3EJGoIixgMlsdC/iahUuo0EufD3+9Z3ay3X+
         cOEQ==
X-Gm-Message-State: ALoCoQml1kFoPMGvLN6tf1p+33TawzzYsXavT+EU9g0FPMxXnuynlWFlvFq0Hdqf3yjMC8a8Ciwk
X-Received: by 10.15.82.136 with SMTP id a8mr7393719eez.81.1386161400619;
        Wed, 04 Dec 2013 04:50:00 -0800 (PST)
Received: from [192.168.1.100] (95-91-240-208-dynip.superkabel.de. [95.91.240.208])
        by mx.google.com with ESMTPSA id b41sm70602052eef.16.2013.12.04.04.49.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 04 Dec 2013 04:49:59 -0800 (PST)
In-Reply-To: <CANQwDwcpkbbfND9MmB9wGcL7mrhV_Mxb1amvGPgWeR344_fcfw@mail.gmail.com>
X-Mailer: Evolution 3.8.5 (3.8.5-2.fc19) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238773>

On Tue, 2013-12-03 at 21:38 +0100, Jakub Nar=C4=99bski wrote:
> On Tue, Dec 3, 2013 at 9:15 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> > Krzesimir Nowak <krzesimir@endocode.com> writes:
> >
> >> @@ -626,6 +640,17 @@ sub feature_avatar {
> >>       return @val ? @val : @_;
> >>  }
> >>
> >> +sub feature_extra_branch_refs {
> >> +     my (@branch_refs) =3D @_;
> >> +     my $values =3D git_get_project_config('extra_branch_refs');
> >
> > Hmph.  Three points.
> >
> > * Almost all callers of this function use
> >
> >     my ($val) =3D git_get_project_config(...);
> >     my @val =3D git_get_project_config(...);
> >
> >   to expect that the function returns a list of things (and grab th=
e
> >   first one among them, not the length of the list).  Shouldn't thi=
s
> >   part do the same?
>=20
> Right. feature_snapshot() has here
>=20
>     my (@fmts) =3D @_;
>     my ($val) =3D git_get_project_config('snapshot');
>=20
> ...though git_get_project_config returns scalar.

So what's the point of it? 'my @val =3D git_get_project_config ()' just
creates an array with one element.

>=20
> > * Wouldn't this be a good candidate for a multi-valued configuratio=
n
> >   variable, e.g. shouldn't this
> >
> >         [gitweb]
> >                 extraBranchRefs =3D wip
> >                 extraBranchRefs =3D sandbox other
> >
> >   be parsed as a three-item list, qw(wip sandbox other)?
>=20
> This would require changes in git_get_project_config(), which would
> need to be able to deal with multi-valued result (it caches these
> results, so we pay only one cost of `git config` call).

Hm, actually not at all. Now, if I have a setup like Junio wrote the
git_get_project_config just returns an array ref. So modifying the
feature_extra_branch_refs to handle the returned value as either simple
scalar or array reference should be enough.

>=20
> > * I think the $key parameter to git_get_project_config() eventually
> >   is used to look up a key in the Git-style configuration file, and
> >   the 'words_with_underscore' goes against our convention (cf. see
> >   how 'show-sizes' feature is spelled as 'showsizes' there).
>=20
> Errr... actually git_get_project_config() strips '_' from $key, thoug=
h
> not for some strange reason '-'.
>=20
> BTW. though it is 'showsizes' in code, it usually is 'showSizes' in
> config file (camelCase convention, lowercased by git-config).

Oi, that was an omission from my side - at first I had that git config
setting with underscores. I removed them when I noticed that underscore=
s
are not used there. Apparently I missed that one.

>=20
> >> +     if ($values) {
> >> +             @branch_refs =3D split /\s+/, $values;
> >> +     }
> >> +
> >> +     return @branch_refs;
> >> +}
>=20
>=20
>=20

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
