From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Has anyone looked at Gettext support for Git itself?
Date: Sun, 16 May 2010 18:08:00 +0200
Message-ID: <20100516160800.GB22447@efreet.light.src>
References: <AANLkTinlDF-aKDjwvgZEqtUgzW7MCIuElQ_RfJn_RkZp@mail.gmail.com>
 <m3pr0wd880.fsf@localhost.localdomain>
 <AANLkTikgs3d1YagU5lRCkEM9uwWe9dmifbHvIjhsk_wF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 16 18:25:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODgf1-0004Jq-NK
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 18:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803Ab0EPQZk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 May 2010 12:25:40 -0400
Received: from cuda1.bluetone.cz ([212.158.128.5]:60096 "EHLO
	cuda1.bluetone.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268Ab0EPQZj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 May 2010 12:25:39 -0400
X-Greylist: delayed 1054 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 May 2010 12:25:38 EDT
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by cuda1.bluetone.cz (Spam & Virus Firewall) with ESMTP
	id 2C53915E8EB4; Sun, 16 May 2010 18:08:01 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145]) by cuda1.bluetone.cz with ESMTP id DN2SLFsRutmB6yUE; Sun, 16 May 2010 18:08:01 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.71)
	(envelope-from <bulb@ucw.cz>)
	id 1ODgNk-0007Us-IC; Sun, 16 May 2010 18:08:00 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTikgs3d1YagU5lRCkEM9uwWe9dmifbHvIjhsk_wF@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147193>

On Sun, May 16, 2010 at 01:12:20 +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
> On Sun, May 16, 2010 at 00:03, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> >
> >> I couldn't find anything about this in the list archives. Have the=
re
> >> been any discussions of adding internationalization support to Git
> >> itself? I.e. the interface messages that the core Git utilities em=
it.
> >>
> >> I tried to get started with integrating GNU Gettext, but gnuish
> >> assumptions it makes about building make it a bit hard.
> >>
> >> Is there perhaps another gettext implementation that would be more
> >> suitable for Git?

Gettext iself does not make any assumptions about building. It's only i=
t's
manual that gives more space to setting up gettext use with autotools t=
han
manually. But doing it manually is really not too hard.

Basically one just needs to set up scripts or makefile targets to:
 - Re-generate the translation template (.pot)
   All this takes is invoking xgettext with correct parameters on the r=
ight
   list of files. It might be necessary to invoke it with different arg=
uments
   for sources in different languages if git needed to use non-default
   options, but I think the defaults would be ok.
 - Update the translations with new strings from the template.
   All this takes is invoking msgmerge for each .po file with the appro=
priate
   template.

Than makefile targets are needed to generate and install the .mc files,=
 but
that's just trivial.

I don't think the automake support saves any work there. It saves you f=
rom
learning the tool invocations, but you have to learn automake instead.
The hardest part is makring all the translatable strings in the code an=
d
the gnuish infrastructure just isn't much help there anyway.

> >> I'd be interested in submitting patches to make the existing strin=
gs
> >> translatable if someone could get the tool + build skeleton going.
> >
> > First, git uses multiple programming languages: you would need a
> > solution that would work for programs in C (gettext), for Perl
> > (Locale::Maketext or less known Data::Localize), probably for Pytho=
n,
> > and what would probably give most problems for shell scripts.
>=20
> All of these languages can read gettext, but you'd need some glue for
> each so that they could get to the files.
>=20
> It would probably make the most sense to have distinct message files
> for each program, e.g.:
>=20
>     /usr/share/locale/*/LC_MESSAGES/git-bisect.mo
>=20
> That way they could be translated incrementally, and the programs
> would load only the small subset of messages they need.

I think it would make things more complicated and not really help anyth=
ing,
since many messages may in fact be shared or come from common parts so =
it
would need to be loaded by many commands anyway. On the other hand the =
=2Emc
file is an external hash, so the access even to a large .mc will be qui=
te
fast.

> > Second, you would need to take care that changing locale wouldn't
> > break git. =C2=A0It can be done either via setting LC_ALL=3DC in
> > git-sh-setup, or by translation only porcelain, and leaving plumbin=
g
> > unchanged.
>=20
> I think it would be fine to break it if that means that Git would
> suddenly start speaking your language, you can always just set LC_ALL
> if you have some scripts that break as a result of parsing the curren=
t
> output in English.

It would definitely not be fine to break *git*. You need to make sure n=
o
part of git itself or anything distributed with it (gitk, git gui, gitw=
eb,
things in contrib) is looking for any string that might be broken by
translating.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
