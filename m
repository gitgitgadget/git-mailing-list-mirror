From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: add completer for status
Date: Fri, 28 Jun 2013 16:04:34 +0200
Message-ID: <20130628140434.GA12404@goldbirke>
References: <1372094575-20799-1-git-send-email-artagnon@gmail.com>
 <20130628102936.GA16562@goldbirke>
 <20130628105601.GB16562@goldbirke>
 <20130628112631.GC16562@goldbirke>
 <CALkWK0=pyzcx-rB9gjRecoD1MFkHrSdYwLurD8y805O3FwT4Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 16:04:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsZI8-0003fJ-AJ
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 16:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747Ab3F1OEo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jun 2013 10:04:44 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:62762 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754654Ab3F1OEo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 10:04:44 -0400
Received: from localhost6.localdomain6 ([141.21.12.113])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0Lio4j-1UFf2N1e85-00cvrZ; Fri, 28 Jun 2013 16:04:34 +0200
Content-Disposition: inline
In-Reply-To: <CALkWK0=pyzcx-rB9gjRecoD1MFkHrSdYwLurD8y805O3FwT4Cg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:rE5HAICeMK6LnQMkv0sFqPLKDkX2HCN3z93qYsU/Fx+
 d+tUA2Fc3irBlADRYWESdBQVXNCwo7U/qu/qM/lIqyYi3/1UG4
 cMTHqJR25gSNkrXQcW93hEPTYyNwg2beChu+t/6RGF91FrRkS7
 0q9Sfu4EHYVKHnQ09GBe+JBBTg5ch9N+2Jb+wDl9+d3Yp/wFnj
 +ZG76K+fIIF8XOnkAp6qV2GfxbdfYXTEM27odgLlAFpjJpKBQZ
 LEPxxQe3S9udQhQHzbH11Jvbko+GqHw2hvfUkGzwTFrxPnwuK1
 oCzZJQz5RpYcBvE6kFSDdm9fBi3QeUKPrluS1jlr7SdWztfLxl
 BR9tfRqyj0axLo+1UaCUO7pBdGkmUo/clfuj0Ct60
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229200>

On Fri, Jun 28, 2013 at 06:50:02PM +0530, Ramkumar Ramachandra wrote:
> SZEDER G=E1bor wrote:
> > diff --git a/contrib/completion/git-completion.bash b/contrib/compl=
etion/git-completion.bash
> > index 912fb988..b68024c6 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -1697,6 +1697,8 @@ _git_stage ()
> >
> >  _git_status ()
> >  {
> > +       __git_has_doubledash && return
> > +
>=20
> This line makes absolutely no sense to me.

That was my quick attempt to provide a way to complete untracked
files, but M-/ or '--others' will do as well.

> When the case statement
> fails to match anything (which it will, when a double-dash is
> present), we'll use the __git_complete_index_file which is superior t=
o

And slower, too.

> returning and falling back to the dumb zsh file listing, no?  As a
> result, without that line,
>=20
>   $ git status -- foo<TAB>
>=20
> will complete fine when foo* isn't necessarily a file in the
> filesystem, but something that our ls-files returns, no?

If you want fancy completion replies, then you won't type the
doubledash.

> >         case "$cur" in
> >         --untracked-files=3D*)
> >                 __gitcomp "no normal all" "" "${cur##--untracked-fi=
les=3D}"
> > @@ -1718,7 +1720,7 @@ _git_status ()
> >                 return
> >                 ;;
> >         esac
> > -       __git_complete_index_file
> > +       __git_complete_index_file "--with-tree=3DHEAD --cached --de=
leted"
>=20
> Might as well go all the way with  "--cached --deleted --unmerged
> --others" no?

'--unmerged' is definitely not good, it implies '--stage', which
changes the output format.

> What is the point of --with-tree=3DHEAD?

To list files that are deleted from the index:

$ rm version.h
$ git rm version.c
rm 'version.c'
$ git ls-files --deleted
version.h
$ git ls-files --deleted --with-tree=3DHEAD
version.c
version.h


G=E1bor
