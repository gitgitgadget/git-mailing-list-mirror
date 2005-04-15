From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: fix various issues in gitapply.sh (basically did not handle
	add/del/cm at all)
Date: Fri, 15 Apr 2005 22:30:11 +0200
Message-ID: <1113597012.8582.10.camel@nosferatu.lan>
References: <1113557318.23299.165.camel@nosferatu.lan>
	 <20050415181526.GA7417@pasky.ji.cz>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WLTh14GnaRXePsZj2lIU"
Content-Transfer-Encoding: 8bit
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 15 22:26:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMXNL-0002hd-EN
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 22:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVDOU2g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 16:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVDOU1U
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 16:27:20 -0400
Received: from ctb-mesg2.saix.net ([196.25.240.74]:36306 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S261963AbVDOU03
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 16:26:29 -0400
Received: from gateway.lan (wblv-146-239-208.telkomadsl.co.za [165.146.239.208])
	by ctb-mesg2.saix.net (Postfix) with ESMTP id E893A3F00;
	Fri, 15 Apr 2005 22:26:21 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 1BA733A26DB;
	Fri, 15 Apr 2005 22:32:29 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 09996-12; Fri, 15 Apr 2005 22:32:24 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 1BD1C3A26DA;
	Fri, 15 Apr 2005 22:32:24 +0200 (SAST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050415181526.GA7417@pasky.ji.cz>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-WLTh14GnaRXePsZj2lIU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-15 at 20:15 +0200, Petr Baudis wrote:
> Dear diary, on Fri, Apr 15, 2005 at 11:28:38AM CEST, I got a letter
> where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > Hi,
> >=20
> > The egrep regex should not escape the '{' and '}', and also add a check
> > for ' \t' so that we do not pickup stuff like '+----', etc.  Fix typo i=
n
> > assignment.  Check if file exists in new tree before adding/removing
> > (might add support for this lowlevel to increase speed?).  Fix typo in
> > line removing temp files.
> >=20
> > Signed-off-by: Martin Schlemmer <azarah@gentoo.org>
>=20
> Thanks for the merge and typo fixes. I can't imagine how, but it really
> appeared to work for me that time!
>=20
> I'm confused however what does the exits_in_cache() (what exits? exists?)
> gives us, apart of horribly-looking code. What bug does it fix?
>=20

My typo it seems - should be exists.  Basically (especially for
gittrack.sh) it will add all files changed between the trees to either
the add or remove queue if this is not done.  This is because it will
just add (say git track linus; git track pasky) the git*.sh files that
is missing in the linus tree (or gitrm.sh if in reverse) although they
are already present there.  So we need to check if the file exists in
the destination tree before we git{add,rm}.sh it - if it do exists, then
its ok to gitrm.sh it, if it does not, it is ok to gitadd.sh it.

The other problem is also that if you keep switching, it will add each
file multiple times to the add/rm queue.  This is a bug with
git{add,rm}.sh which do not check the queue if the file is already
there, and it also add a file even if it is already in the cache - so it
probably need the same type of fix.  I will send a patch when we get how
we check if a file is already in the cache resolved.

Like I said in the patch, it might be better to add support low-level
side (don't know if we can have ls-tree return true/false on file basis,
else add a new tool?).


Thanks,

--=20
Martin Schlemmer


--=-WLTh14GnaRXePsZj2lIU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCYCRTqburzKaJYLYRAoVfAJ0a6fYdhIh/BkPfObZBXeJBtIZeIACfaNTl
5rx+6ozVZwft7tiyXugRoZ4=
=jQ7N
-----END PGP SIGNATURE-----

--=-WLTh14GnaRXePsZj2lIU--

