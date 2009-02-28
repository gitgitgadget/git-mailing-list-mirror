From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn woes
Date: Fri, 27 Feb 2009 19:31:08 -0800
Message-ID: <20090228033108.GB28606@dcvr.yhbt.net>
References: <alpine.LFD.2.00.0902271442270.5511@xanadu.home> <86d4c5e00902271253y50eaef01x8ca837d3a0ed7ef6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Deskin Miller <deskinm@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 04:38:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdG2U-0004Qc-P2
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 04:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbZB1DbM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 22:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753151AbZB1DbL
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 22:31:11 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:40214 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752912AbZB1DbK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 22:31:10 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id C55C51F799;
	Sat, 28 Feb 2009 03:31:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <86d4c5e00902271253y50eaef01x8ca837d3a0ed7ef6@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111744>

Deskin Miller <deskinm@gmail.com> wrote:
> On Fri, Feb 27, 2009 at 15:37, Nicolas Pitre <nico@cam.org> wrote:
> >
> > OK... I cannot pretend to be a newbie with git. =A0However it's the=
 first
> > time I try git-svn and it looks like a couple basic things aren't r=
ight.
> >
> > I initially cloned svn://svn.berlios.de/openocd using "git svn clon=
e -s".
> > So far so good. =A0Now I'm attempting to update using "git svn fetc=
h" but
> > the operation always fails with the following error:
> >
> > |branch_from: /openocd/branches =3D> /openocd/branches/xscale
> > |Found possible branch point:
> > |svn://svn.berlios.de/openocd/openocd/branches/xscale =3D>
> > |svn://svn.berlios.de/openocd/branches/xscale, 1231
> > |Initializing parent: xscale@1231
> > |Found branch parent: (xscale) 657522f3f2d1ab8b679fd5b45ce4e9ca1974=
af18
> > |Following parent with do_switch
> > |Scanning for empty symlinks, this may take a while if you have man=
y empty files
> > |You may disable this with `git config svn.brokenSymlinkWorkaround =
false'.
> > |This may be done in a different terminal without restarting git sv=
n
> > |Malformed network data: Malformed network data at /home/nico/libex=
ec/git-core/git-svn line 3333
>=20
> I experience the same error as you do with 1.6.2-rc2.  This error is
> occurring in the new broken-symlink-workaround code.  I'm not sure
> what is going on and don't have time to examine it closely, but the
> function where the error occurs doesn't run if the config
> svn.brokenSymlinkWorkaround option is set false; doing so makes the
> fetch continue for me.
>=20
> Any ideas, Eric?

I've been poking around at this for a bit, I am pretty confused
by this, too.  It's been a rough week, so I could be missing
something obvious...

Junio: since 1.6.2 might be out the door before we have time to resolve
this, I'm leaning towards disabling the broken-symlink-workaround by
default for the release. It seems far more people are negatively
affected by the attempted fix around this rare problem than helped.

> > Thing is... the repository never gets updated and by far. =A0Accord=
ing to
> > "git svn info", the fetched revision is 1232, while a separate
> > repository using native svn claims to be at revision 1383.
> >
> > Furthermore, the "git svn info" command produces yet more errors, s=
uch
> > as:
> >
> > |Use of uninitialized value $lc_author in concatenation (.) or stri=
ng at /home/nico/libexec/git-core/git-svn line 964.
> > |Use of uninitialized value $lc_rev in concatenation (.) or string =
at /home/nico/libexec/git-core/git-svn line 965.
> > |Use of uninitialized value $t in gmtime at /home/nico/libexec/git-=
core/git-svn line 4743.
> > |Use of uninitialized value $t in numeric comparison (<=3D>) at /ho=
me/nico/libexec/git-core/git-svn line 4744.
> > |Use of uninitialized value $t in subtraction (-) at /home/nico/lib=
exec/git-core/git-svn line 4745.
> > |Use of uninitialized value $t in localtime at /home/nico/libexec/g=
it-core/git-svn line 4746.
> >
> > This is with git from current "next". I cannot spend time to try fi=
xing
> > the issue myself (especially as I'm not familiar at all with the in=
ner
> > workings of svn), so my only option at the moment is to give up on
> > git-svn altogether. =A0:-(
>=20
> Oh, don't give up quite yet :)
>=20
> Deskin Miler

--=20
Eric Wong
