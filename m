From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Tue, 15 Nov 2005 11:50:36 -0500
Message-ID: <1132073436.25640.32.camel@dv>
References: <1132034390.22207.18.camel@dv>
	 <7vveyuqto5.fsf@assigned-by-dhcp.cox.net> <1132042427.3512.50.camel@dv>
	 <7vpsp2qpx4.fsf@assigned-by-dhcp.cox.net>
	 <7vd5l2mco1.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0511151207070.21671@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20051115121854.GV30496@pasky.or.cz>
	 <Pine.LNX.4.63.0511151518210.23020@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 17:56:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec43s-0001E0-EK
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 17:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbVKOQwZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 Nov 2005 11:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbVKOQwZ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 11:52:25 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:42133 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964926AbVKOQwY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 11:52:24 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Ec422-0001Y3-P1
	for git@vger.kernel.org; Tue, 15 Nov 2005 11:52:18 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1Ec40y-00070g-Dn; Tue, 15 Nov 2005 11:50:36 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511151518210.23020@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11917>

On Tue, 2005-11-15 at 15:24 +0100, Johannes Schindelin wrote:
> <yousortofaskedforit>
> Well, I can see no good reason for symrefs, except for backwards=20
> compatibility! Modern systems do support symlinks, you know?

You misunderstood me here.  I meant backward compatibility with git
wrappers, not with old operating systems.

I meant, the only reason we don't want symrefs to be used by default is
because there are wrappers around git that only work with symlinks.  So=
,
if we change the default behavior in git now, those wrappers will break
on new repositories.

> Let=B4s face it. The main target for git is not Windows users. If we =
really=20
> want to support all idiocies of all possible ones, how about this one=
:
>=20
> If I clone a repository to a USB stick on cygwin, and try to access i=
t=20
> from my iBook, it does not work, because for *backward compatibility*=
=20
> reasons, files fitting the 8.3 format are stored in UPPER CASE.
>=20
> So, I would like to have support for UPPER CASE files in .git, please=
? And=20
> since I cannot do my own testing, please could you force everybody=B4=
s git=20
> to write OBJECTS and MASTER in UPPER CASE?

That was pretty funny :-)

Actually, what's different about symlinks is that they go beyond the
paradigm of one data stream per file.  There are two data streams
accessible through the symlink, one being the data in the file it point=
s
to, and the other being the path to that file.

This doesn't map well to many data transfer protocols.  We don't want
git to work only over protocols that have explicit support for symlinks=
=2E

One example is http, sometimes the only protocol allowed to transcend
corporate firewalls.

Another, more controversial example is CVS.  Sourceforge doesn't suppor=
t
git, but I could store my git database in Sourceforge CVS, and thus
share it with other contributors.  Not being able to put .git/HEAD ther=
e
would be an annoyance.

I believe Cygwin developers were actually more concerned about symlinks
damaged by SMB than about any issues with storing them locally.  After
all, Cygwin is quite good at emulating POSIX, including symlinks.

Returning to your example, 8.3 format is a problem with storage.  Those
are behind us.  It's problems with transfer that are going to limit us.

--=20
Regards,
Pavel Roskin
