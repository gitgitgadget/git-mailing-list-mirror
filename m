From: "martin f. krafft" <madduck@madduck.net>
Subject: Re: [PATCH] Export GIT_DIR after setting it
Date: Tue, 20 May 2008 17:17:00 +0100
Message-ID: <20080520161700.GA16629@lapse.madduck.net>
References: <1210807401-11201-1-git-send-email-madduck@madduck.net> <7vod78i9r7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 18:18:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyUXy-0008SZ-HD
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 18:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757086AbYETQRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 12:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755973AbYETQRs
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 12:17:48 -0400
Received: from seamus.madduck.net ([213.203.238.82]:54856 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860AbYETQRr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 12:17:47 -0400
Received: from lapse.madduck.net (ruou.ifi.unizh.ch [130.60.75.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTP id 24A4240A2FA;
	Tue, 20 May 2008 18:17:30 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 55B073FB12; Tue, 20 May 2008 17:17:00 +0100 (IST)
Content-Disposition: inline
In-Reply-To: <7vod78i9r7.fsf@gitster.siamese.dyndns.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.24-1+scoflowctrl.1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.92.1/7181/Tue May 20 17:08:32 2008 on seamus.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82482>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Junio C Hamano <gitster@pobox.com> [2008.05.15.0325 +0100]:
> In any case, this patch is a bit worrying.

Your gut feeling is a good one!

See the following typescript. You'll notice that the new files
created in wc2 pushed and pulled get merged into the first wc at the
wrong location, and index and working dir get out of sync. This only
happens when I export GIT_DIR in git-sh-setup. Ouch.

Arguably, this is a bug in git-merge though!

% GIT_DIR=3Drepo.git git --bare init
Initialized empty Git repository in repo.git/
% mkdir wc && cd wc && git init
Initialized empty Git repository in .git/
% git remote add origin `pwd`/../repo.git
% git config branch.master.remote origin
% git config branch.master.merge refs/heads/master
% touch a; git add a; git commit -m.
Created initial commit c80aa71: .
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 a
% git push origin master
Counting objects: 3, done.
Writing objects: 100% (3/3), 196 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
To /home/madduck/.tmp/cdt.SLg15374/wc/../repo.git
 * [new branch]      master -> master
% mkdir foo && touch foo/a && git add foo/a && git commit -m.
Created commit 8ccd80a: .
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 foo/a
% git push
Counting objects: 3, done.
Compressing objects: 100% (2/2), done.
Unpacking objects: 100% (2/2), done.
Writing objects: 100% (2/2), 247 bytes, done.
Total 2 (delta 0), reused 0 (delta 0)
To /home/madduck/.tmp/cdt.SLg15374/wc/../repo.git
   c80aa71..8ccd80a  master -> master
% cd ../
% git clone repo.git wc2
Initialized empty Git repository in /home/madduck/.tmp/cdt.SLg15374/wc2/.gi=
t/
% cd wc2
% cd foo && mkdir bar && touch bar/a && git add bar/a && git commit -m.
Created commit cba76e8: .
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 foo/bar/a
% git push
Counting objects: 5, done.
Compressing objects: 100% (3/3), done.
Unpacking objects: 100% (3/3), done.
Writing objects: 100% (3/3), 315 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
To /home/madduck/.tmp/cdt.SLg15374/repo.git
   8ccd80a..cba76e8  master -> master
% cd ../../wc/foo=20
% ls
a
% git pull
remote: Counting objects: 5, done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
=46rom /home/madduck/.tmp/cdt.SLg15374/wc/../repo
   8ccd80a..cba76e8  master     -> origin/master
Updating 8ccd80a..cba76e8
foo/a: needs update
Fast forward
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 foo/bar/a
% ls
a  foo
% git status
# On branch master
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#
#       deleted:    bar/a
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       foo/
no changes added to commit (use "git add" and/or "git commit -a")
% git diff
diff --git a/foo/bar/a b/foo/bar/a
deleted file mode 100644
index e69de29..0000000

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
micro$oft windoze: proof that p. t. barnum was correct.
=20
spamtraps: madduck.bogus@madduck.net

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIMvl8IgvIgzMMSnURAqDvAKDtXDMomLdBPYXsPEaY15dKpu2PPwCfQVKJ
KuNRBwEx7Tlp4jETe+NFiMI=
=tQJE
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
