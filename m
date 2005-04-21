From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Pasky problem with 'git init URL'
Date: Thu, 21 Apr 2005 18:21:58 +0200
Message-ID: <1114100518.17551.31.camel@nosferatu.lan>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yrV7nktmfqwQAI7gn6AS"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Apr 21 18:18:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOeN1-0003sq-IM
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 18:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVDUQVP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 12:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVDUQTH
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 12:19:07 -0400
Received: from ctb-mesg7.saix.net ([196.25.240.79]:7335 "EHLO
	ctb-mesg7.saix.net") by vger.kernel.org with ESMTP id S261512AbVDUQSF
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 12:18:05 -0400
Received: from gateway.lan (wblv-146-254-56.telkomadsl.co.za [165.146.254.56])
	by ctb-mesg7.saix.net (Postfix) with ESMTP id 08D176683
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 18:17:59 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 47FA23A2430
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 18:24:19 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27565-19 for <git@vger.kernel.org>; Thu, 21 Apr 2005 18:24:15 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 607D33A241A
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 18:24:15 +0200 (SAST)
To: GIT Mailing Lists <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-yrV7nktmfqwQAI7gn6AS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Just pulled linux-2.6.git, and got this:

----
New branch: 3a6fd752a50af92765853879f4a11cc0cfcd0320
Tracked branch, applying changes...
Merging 4d78b6c78ae6d87e4c1c8072f42efa716f04afb9 -> 3a6fd752a50af9276585387=
9f4a11cc0cfcd0320
        to a2755a80f40e5794ddc20e00f781af9d6320fafb...

Enter commit message, terminated by ctrl-D on a separate line:
Merge with 3a6fd752a50af92765853879f4a11cc0cfcd0320
----

Weird thing was that I made no changes.

Digging a bit deeper, I saw that .git/HEAD was a symlink
to .git/heads/master, and the tracked branch was 'origin'.  Due to the
fact that Linus only have a .git/heads/master on his rsync, and this
thus updated to the new sha1, but the 'origin' (and tracked) head is
still pointing to an older sha1 caused this confusion.

I replicated the linux tree via:

----
git init URL
----

So I had a look at gitinit.sh, which first creates the .git/heads/master
and symlinks HEAD to it, then on seeing a URL was supplied, creates
a .git/heads/origin, track it, but do *not* change the .git/HEAD
symlink ... Is this intended?  I see also that gittrack.sh do not update
the HEAD symlink ...  Is this also intended?

I guess a solution is to either just use 'master', and do not do the
'origin' head, or to update the HEAD symlink.  I however do not think
this is very generic, especially if the remote repo do not call their
main head 'master' - so it might be better to check what it have
in .git/heads, and if only one, use that as the main and tracked head,
else do nothing and tell the user to decide what head to track, etc.

The last option however brings a problem or two.  First, how do you do
the multi-head thing?  Maybe add a command 'git lsheads' (and while at
it, also add 'git lstags'?)?  Secondly, if there was more than one head,
the local copy needs to be checked out ... don't know if 'git cancel' is
the logical thing the user will think to do ('git clone' perhaps?) ...

I think it might be a good time to start thinking and putting to text
what commands is really needed, what they should be called, and how
exactly they should behave before it gets much later in the game.

Anyhow, suggestions/comments welcome.


Thanks,

--=20
Martin Schlemmer


--=-yrV7nktmfqwQAI7gn6AS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCZ9MmqburzKaJYLYRAsadAJ4npIVqQ/Fz7BG0LemDf+ejULveAQCfYFt5
uNw8OEG3k2q4qfGyqRpBpS0=
=LJQQ
-----END PGP SIGNATURE-----

--=-yrV7nktmfqwQAI7gn6AS--

