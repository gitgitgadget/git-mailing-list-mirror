From: David Syzdek <syzdek@gmail.com>
Subject: Re: [PATCH] autoconf: Add support for --infodir
Date: Fri, 27 Feb 2009 16:15:21 -0900
Message-ID: <9a0027270902271715w3f72e01dp4e1e3a716b92527c@mail.gmail.com>
References: <tim.visher@gmail.com>
	 <20090228002550.22597.53878.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 02:16:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdDox-0007Qk-HH
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 02:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbZB1BPZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 20:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753262AbZB1BPY
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 20:15:24 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:18586 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbZB1BPX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 20:15:23 -0500
Received: by an-out-0708.google.com with SMTP id c2so1085623anc.1
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 17:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=a1mUuGVPVUDs9Spr8AqbpHr0RvXcVRIGz9R5E4ccpJw=;
        b=rE87bmTMuHxklqH9eOeFyexEbiUDq8A40jZgAnckEyHVHy9fQqUe4mE++Rg50v4KYC
         dzrTwc5aT30BF/EaD0nNRuk2M9NzGPdRa2+eNqcgPIO9QbtdmFjrLwMEupMp8CnQEn4Y
         bJY3PbHLAEUrfa9UXfb12eA2/IQ2naWxh8hVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eDLSH5O8J5bvEKv27DVHpl7nVFyPTIxe4zW0C5/8NgJtHsQYw4wO3sYALHc09e61G0
         GCl8Ki9x08Vfj/jcL7SURXq1pzz+eAutnq5i7CZDq9EEeozV+qFYb1CI7fh2rMCEairx
         ez+xDvuSCNZ3sHVzFcjQVOm6YP7q8l8Yp8kBk=
Received: by 10.231.20.1 with SMTP id d1mr2571633ibb.19.1235783721038; Fri, 27 
	Feb 2009 17:15:21 -0800 (PST)
In-Reply-To: <20090228002550.22597.53878.stgit@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111733>

On Fri, Feb 27, 2009 at 3:33 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>
> On Thu, 26 Feb 2009, Jeff King wrote:
> > On Thu, Feb 26, 2009 at 09:48:29AM -0500, Tim Visher wrote:
> >
> >> I'm working on getting git 1.6.2-rc2 built. =C2=A0I have a bin, ma=
n, info,
> >> and html directory in my home folder that I'd like to use as the
> >> defaults for git. =C2=A0I attempted to do this through
> >>
> >> =C2=A0 =C2=A0 make configure
> >> =C2=A0 =C2=A0 ./configure --XXdir=3D/full/path/to/dir
> >> =C2=A0 =C2=A0 make all man info html
> >> =C2=A0 =C2=A0 make install install-man install-info install-html
> >>
> >> But other than the binaries (and I'm not even totally convinced th=
ey
> >> got in correctly) and the man pages, everything else seems to be
> >> attempting to go to the typical places in /usr/local.
> >>
> >> What am I doing wrong?
>
> Why don't you use simply --prefix=3DDIR?
>
> >
> > The configure support is notoriously incomplete (AFAIK, very few of=
 the
> > active developers use it regularly). Probably you need something li=
ke
> > this (but I didn't test it):
> >
> > diff --git a/config.mak.in b/config.mak.in
> > index 7cce0c1..505d5c7 100644
> > --- a/config.mak.in
> > +++ b/config.mak.in
> > @@ -18,6 +18,8 @@ datarootdir =3D @datarootdir@
> > =C2=A0template_dir =3D @datadir@/git-core/templates
> >
> > =C2=A0mandir=3D@mandir@
> > +htmldir=3D@htmldir@
> > +infodir=3D@infodir@
> >
> > =C2=A0srcdir =3D @srcdir@
> > =C2=A0VPATH =3D @srcdir@
>
> Well, the infodir part works trivially, because autoconf (and
> therefore ./configure script) has support for --infodir=3DDIR.
> Below there is patch that adds that, with the commit message.
>
> But it is more difficult with respect to --htmldir. I am not autoconf
> hacker, so I don't know how to add support for having --htmldir=3DDIR=
 in
> ./configure (in configure.ac). =C2=A0What can be done is to derive ht=
mldir
> in config.mak.in from other sources, for example:
>

Autoconf add support for --htmldir in version 2.60.  Here is a snippet
from the help message from a configure script generated with 2.60:
   --datarootdir=3DDIR       read-only arch.-independent data root [PRE=
=46IX/share]
   --docdir=3DDIR            documentation root [DATAROOTDIR/doc/PROJEC=
T_TARNAME]
   --htmldir=3DDIR           html documentation [DOCDIR]

The current configure.ac requires autoconf version >=3D 2.59, bumping
the requirement to autoconf >=3D 2.60 would allow the autoconf variable
$(htmldir) to be used.  Bumping the required version of autoconf will
affect users with older linux installations who use git to upgrade
git; and may affect the maintainer's ability to create a "release"
tarball if he has an older version of autoconf.

> =C2=A0htmldir=3D@datadir@/doc/git
>
> or something like that.
>
> -- >8 --
> Now that we actually (can) install some info files, and that $infodir
> is set and used in Makefile(s), let add support for --infodir=3DDIR
> [PREFIX/info] ./configure option in config.mak.in.
>
> Half of patch by Jeff King <peff@peff.net>m adding --XXdir support
> (the easy part: autoconf has --infodir, but not --htmldir).
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> =C2=A0config.mak.in | =C2=A0 =C2=A01 +
> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/config.mak.in b/config.mak.in
> index 7cce0c1..acff9ed 100644
> --- a/config.mak.in
> +++ b/config.mak.in
> @@ -18,6 +18,7 @@ datarootdir =3D @datarootdir@
> =C2=A0template_dir =3D @datadir@/git-core/templates
>
> =C2=A0mandir=3D@mandir@
> +infodir=3D@infodir@
>
> =C2=A0srcdir =3D @srcdir@
> =C2=A0VPATH =3D @srcdir@
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml



--
An earthquake wiped out Etchisketchistan today.
=C2=A0 -- Onion TV
