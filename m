From: Thomas Zander <zander@kde.org>
Subject: git apply behaves differently from patch(1)
Date: Wed, 16 Jan 2008 23:58:48 +0100
Message-ID: <200801162358.48723.zander@kde.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="nextPart1368140.ML3QStQytI";
	 protocol="application/pgp-signature";
	 micalg=pgp-sha1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 23:59:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFHE9-0006MI-7a
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 23:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbYAPW6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 17:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753225AbYAPW6w
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 17:58:52 -0500
Received: from hoat.troll.no ([62.70.27.150]:58438 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753205AbYAPW6v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 17:58:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by hoat.troll.no (Postfix) with ESMTP id 94B6458073
	for <git@vger.kernel.org>; Wed, 16 Jan 2008 23:58:50 +0100 (CET)
Received: from hoat.troll.no ([127.0.0.1])
 by localhost (hoat.troll.no [127.0.0.1]) (amavisd-maia, port 10024) with LMTP
 id 05988-06 for <git@vger.kernel.org>; Wed, 16 Jan 2008 23:58:49 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	by hoat.troll.no (Postfix) with ESMTP id 517525800D
	for <git@vger.kernel.org>; Wed, 16 Jan 2008 23:58:49 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id m0GMwnZC002342
	for <git@vger.kernel.org>; Wed, 16 Jan 2008 23:58:49 +0100
Received: from lacuna.local ( [172.20.1.14])
    by sx01.troll.no (Scalix SMTP Relay 11.3.0.11339)
    via ESMTP; Wed, 16 Jan 2008 23:58:49 +0100 (CET)
x-scalix-Hops: 1
User-Agent: KMail/1.9.6
X-Virus-Scanned: Maia Mailguard 1.0.2a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70763>


--nextPart1368140.ML3QStQytI
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

In the following usecase git apply (git version 1.5.4.rc3.15.g785f9)=20
doesn't do what I expect it should do. I expect it to do the same as=20
patch does in the same situation.

To reproduce;
Create a file 'test' with a number on each line.  Numbers 1 though 10.
$ for i in 1 2 3 4 5 6 7 8 9 10; do echo $i >> test; done
$ git add test
$ git commit test

$ rm test
$ for i in 1 3 4 5 6 7 10; do echo $i >> test; done
$ git diff-index -p --unified=3D0 HEAD test | tee mypatch

Now use your editor to edit 'mypatch' and remove the first hunk; the end=20
result (after your editing) should be something like this;
$ cat mypatch
diff --git a/test b/test
index f00c965..319869c 100644
=2D-- a/test
+++ b/test
@@ -8,2 +6,0 @@
=2D8
=2D9

apply revert this patch;
$ git apply -R --unidiff-zero --apply mypatch
$ git diff

What I expect (and what I get if I replace git apply with a 'patch -R -p1=20
< mypatch') is that the diff shows line "2" is still missing.

What I get instead is that "2" is missing but also that "10" moved 2 lines=
=20
up.
I conclude that git somehow doesn't like the patch to be removed, while=20
patch(1) has no problem with that.

I hope you agree its a bug and fix it in an upcoming version, it would be=20
great if I can avoid using patch(1) or worse.
If you have any questions feel free to ask; but please cc me as I am not=20
subscribed.
=2D-=20
Thomas Zander

--nextPart1368140.ML3QStQytI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHjowoCojCW6H2z/QRAthCAJwKl0KV1hbOCdAXzQAFxRcNWbHzugCdGOCl
/yuescd/VqR0Ht7iGH3fjVI=
=ijXs
-----END PGP SIGNATURE-----

--nextPart1368140.ML3QStQytI--
