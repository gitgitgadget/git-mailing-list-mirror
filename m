From: martin f krafft <madduck@madduck.net>
Subject: confused about a conflict during octopus merging
Date: Tue, 9 Oct 2007 01:31:56 +0100
Message-ID: <20071009003156.GA30498@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 02:32:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If31E-0006ZS-DV
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 02:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbXJIAcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 20:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbXJIAcG
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 20:32:06 -0400
Received: from clegg.madduck.net ([82.197.162.59]:40746 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbXJIAcE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 20:32:04 -0400
Received: from lapse.madduck.net (absinthe.ifi.unizh.ch [130.60.75.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 92A9EBE7D
	for <git@vger.kernel.org>; Tue,  9 Oct 2007 02:31:58 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 6C48553CAB; Tue,  9 Oct 2007 01:31:56 +0100 (BST)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4509/Tue Oct  9 01:33:53 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60346>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear list,

I am a little confused why the following yields a conflict:

$ git init
$ touch a; git add a; git commit -ma
Created initial commit 0ba90cc: a
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 a

  # create merger branch for later
$ git branch merger

  # create a file
$ date > d; git add d; git commit -md1
Created commit 89d22eb: d
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 d

  # branch off a second branch and populate it
$ git checkout -b second
Switched to a new branch "second"
$ touch b; git add b; git commit -mb
Created commit 7370737: b
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 b

  # modify file changed in previous commit
$ git checkout master
Switched to branch "master"
$ date >> d; git add d; git commit -md2
Created commit bb5f1b4: d2
 1 files changed, 1 insertions(+), 1 deletions(-)



Now the tree structure is

  x -- master: d2
  | x -- second: b
  |/
  x d1
  |
  x -- merger: a

  # now octopus-merge master+second into merger
$ git checkout merger
Switched to branch "merger"

$ git merge master second
Trying simple merge with bb5f1b4f3a8cbfcbc9dbc97cc823f3ca05db2db1
Trying simple merge with 7370737ff3aa6540a425db015e194766d2cbda2e
Simple merge did not work, trying automatic merge.
Added d in both, but differently.
error: Could not read .merge_file_mCwa4W
ERROR: Merge conflict in d
fatal: merge program failed
Automatic merge failed; fix conflicts and then commit the result.


I don't understand why these conflict. I mean, sure, it makes sense:
after merging master, file d is at d2. Now when merging second, it
tries to replace d by its ancestor, d1.

What I don't understand is why Git does not understand that commit
d is part of the path of arriving at d2, so when 'second' is merged,
Git *should* really see that the change to file d in 'second' (d1)
is an ancestor of the already present d2 commit, and *not* conflict.

What am I misunderstanding here?

Thanks,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"distrust all those who love you extremely
 upon a very slight acquaintance and without any visible reason."
                                                  -- lord chesterfield
=20
spamtraps: madduck.bogus@madduck.net

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHCsv7IgvIgzMMSnURApEMAKDMQ0xgI8BXcwnVyQLDbVBVZsBA2wCfeDwj
6cCloifNkBrvS0gh0APXdYI=
=73qK
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
