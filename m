From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sun, 6 Jan 2013 16:33:58 -0500
Organization: PD Inc
Message-ID: <D527CF72B81E4F70B390334EC04EA0E8@black>
References: <2491041.bQ51Qu8HcA@thunderbird> <1890551.8jTmplCF6O@thunderbird> <BB541ECCD3F04E479F06CA491DDB598D@black> <50E92675.4010907@web.de> <20130106093211.GB10956@elie.Belkin> <50E946EB.1000709@web.de> <20130106095757.GC10956@elie.Belkin> <50E9647F.4090209@gmail.com> <20130106120917.GC22081@elie.Belkin> <7vfw2enl2l.fsf@alter.siamese.dyndns.org> <50E9E822.4020709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 22:34:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrxrO-0006Aj-4i
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 22:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126Ab3AFVeG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 16:34:06 -0500
Received: from projects.pdinc.us ([67.90.184.26]:53524 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753004Ab3AFVeF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jan 2013 16:34:05 -0500
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id r06LXjpK029066
	for <git@vger.kernel.org>; Sun, 6 Jan 2013 16:33:45 -0500
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <50E9E822.4020709@gmail.com>
Thread-Index: Ac3sUi9hOit53UigQq+3UuDQ0doeRwAArZrQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212843>

> -----Original Message-----
> From: git-owner@vger.kernel.org=20
> [mailto:git-owner@vger.kernel.org] On Behalf Of Mark Levedahl
> Sent: Sunday, January 06, 2013 16:10
> To: Junio C Hamano
> Cc: Jonathan Nieder; Torsten B=F6gershausen; Stephen & Linda=20
> Smith; Jason Pyeron; git@vger.kernel.org; Eric Blake
> Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
>=20
> On 01/06/2013 02:54 PM, Junio C Hamano wrote:
> > Jonathan Nieder <jrnieder@gmail.com> writes:
> >
> >> Mark Levedahl wrote:
> >>
> >>>                                                          =20
> However,=20
> >>> the newer win32api is provided only for the current=20
> cygwin release=20
> >>> series, which can be reliably identified by having dll version=20
> >>> 1.7.x, while the older frozen releases (dll versions 1.6.x from=20
> >>> redhat, 1.5.x open source) still have the older api as no=20
> updates are being made for the legacy version(s).
> >> Ah.  That makes sense, thanks.
> >>
> >> (For the future, if we wanted to diagnose an out-of-date=20
> win32api and=20
> >> print a helpful message, I guess cygcheck would be the command to=20
> >> use.)
> > Hmph, so we might see somebody who cares about Cygwin to=20
> come up with=20
> > a solution based on cygcheck (not on uname) to update this part,=20
> > perhaps on top of Peff's "split default settings based on=20
> uname into=20
> > separate file" patch?
> >
> > If I understood what Mark and Torsten wrote correctly, you=20
> will have=20
> > the new win32api if you install 1.7.17 (or newer) from=20
> scratch, but if=20
> > you are on older 1.7.x then you can update the win32api part as a=20
> > package update (as opposed to the whole-system upgrade).  A=20
> test based=20
> > on "uname -r" cannot notice that an older 1.7.x (say 1.7.14)=20
> > installation has a newer win32api because the user updated=20
> it from the=20
> > package (hence the user should not define CYGWIN_V15_WIN32API).
> >
> > Am I on the same page as you guys, or am I still behind?
> >
> > In the meantime, perhaps we would need something like this?
> >
> >
> > diff --git a/Makefile b/Makefile
> > index 8e225ca..b45b06d 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -281,6 +281,9 @@ all::
> >   #
> >   # Define NO_REGEX if you have no or inferior regex=20
> support in your C library.
> >   #
> > +# Define CYGWIN_V15_WIN32API if your Cygwin uses win32api=20
> dll older=20
> > +than # 1.7.x (this typically is true on Cygwin older than 1.7.17) =
#
> >   # Define HAVE_DEV_TTY if your system can open /dev/tty to=20
> interact with the
> >   # user.
> >   #
> >
> Looking at a current setup.ini, the obsolete win32 api is a=20
> single package "w32api" with last version 3.17-2, and is now=20
> replaced by the new win32 api is in two packages,=20
> "w32api-headers" + "w32api-runtime", both at version=20
> 3.0b_svn5496-1. If setup.exe updated an older installation of=20
> w32api, the old package is not deleted, but replaced by a=20
> special "empty" package with (as of today) version 9999-1.=20
> Note that all of this could change at any time. Also, note=20
> that the new w32api packages have version numbers that are=20
> lower than the older obsoleted version.

I would not rely on that information as it is not designed to convey th=
e
information the git build needs.

>=20
> Running "cygcheck -c w32api w32api-headers w32api-runtime" on=20
> one machine gives
>=20
> Cygwin Package Information
> Package              Version            Status
> w32api               9999-1             OK
> w32api-headers       3.0b_svn5496-1     OK
> w32api-runtime       3.0b_svn5496-1     OK
>=20
> So now, what do folks propose checking for?
> a) w32api is installed? Nope - the package is not "removed",=20
> it was updated to a special empty version to delete its=20
> former contents, but a new fresh installation won't have this.
> b) w32api-headers is installed? Nope - what happens on the=20
> next repackaging?
> c) w32api version is 9999-1? Maybe, but that number could change.
> etc.

This is what is typically done in a configure script by test compiling.

>=20
> There is no documented, reliable, future-proof, method of=20
> determining the installed w32api version on Cygwin. There are=20
> many things that can be done that will work frequently,=20
> except when they won't. I really think the only sane thing is=20
> to follow the guidance of the Cygwin
> developers: the only supported configuration is that which=20
> the current setup.exe produces, and in the case of problems,=20
> if the installation is not up to date then updating is the=20
> first required action.
>=20
> So, in the makefile, you might add:
>=20
> +# Define CYGWIN_V15_WIN32API if you are using Cygwin v1.7.x=20
> but are not=20
> +# using the current w32api packages. But, the recommended=20
> approach is=20
> +to # update your installation if compilation errors occur.
> +#


--
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
This message is copyright PD Inc, subject to license 20080407P00.

=20
