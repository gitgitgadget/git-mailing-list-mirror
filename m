From: Szekeres Istvan <szekeres@iii.hu>
Subject: Bug: git-rebase goofs up \n in commit messages
Date: Fri, 25 May 2007 23:11:26 +0200
Message-ID: <465750FE.9000406@iii.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE86A62EFA022380F6AF99AD3"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 23:18:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrhAq-00022j-2k
	for gcvg-git@gmane.org; Fri, 25 May 2007 23:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbXEYVRj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 17:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765507AbXEYVRj
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 17:17:39 -0400
Received: from pulsussoft.hu ([193.202.83.99]:55616 "EHLO pulsussoft.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752683AbXEYVRh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 17:17:37 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 May 2007 17:17:36 EDT
Received: by pulsussoft.hu (Postfix, from userid 65534)
	id EED743546; Sat, 26 May 2007 00:17:52 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	pulsus.pulsussoft.hu
X-Spam-Level: 
X-Spam-Status: No, score=-100.0 required=5.0 tests=USER_IN_WHITELIST 
	autolearn=failed version=3.1.7-deb
Received: from [10.0.0.1] (pool-2040.adsl.interware.hu [213.178.107.248])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pulsussoft.hu (Postfix) with ESMTP id B3F35227B
	for <git@vger.kernel.org>; Sat, 26 May 2007 00:17:49 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48419>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE86A62EFA022380F6AF99AD3
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

Hello,

while playing with git I found the following bug: if a commit message
contains "\n" (as a string, not as a character), git-rebase changes this
string into a literal newline character.

This is how to reproduce it:

mkdir tmp
cd tmp
git init-db
echo xx > xx.txt
git add xx.txt
git commit -m foo
echo xx >> xx.txt
git add xx.txt
git commit -m foo
git branch other 'HEAD^'
git checkout other
echo yy > yy.txt
git add yy.txt
git commit -m 'foo \\n bar'
git log 'HEAD^..'              [1]
git rebase master
git log 'HEAD^..'              [2]

The output of [1] is the following (correctly):

commit 694daa542b83dc1bbd6c070630f73c9a111f6e40
Author: Istvan Szekeres <szekeres@iii.hu>
Date:   Fri May 25 23:09:32 2007 +0200

    foo \n bar


The output of [2] is the following (wrong!):
commit 68ba80d2927d4e21c7a1d1d758f9023dbe063bde
Author: Istvan Szekeres <szekeres@iii.hu>
Date:   Fri May 25 22:58:28 2007 +0200

    foo
     bar
=2E...

I think this is a bug.

Best regards,
Istvan






--------------enigE86A62EFA022380F6AF99AD3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGV1D+uOndbEYMS5YRApBlAJ0V26uAL+vzLbhZ+WrSQH3XdVGu0wCghdBH
x86pZe9gPsuvczcyWa8VdAY=
=Iw1C
-----END PGP SIGNATURE-----

--------------enigE86A62EFA022380F6AF99AD3--
