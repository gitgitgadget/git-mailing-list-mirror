From: huebbe <nathanael.huebbe@informatik.uni-hamburg.de>
Subject: Bug: Incorrect stripping of the [PATCH] prefix in git-am
Date: Wed, 25 Nov 2015 16:29:30 +0100
Message-ID: <5655D3DA.1050403@informatik.uni-hamburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="N7iHCRJkMH0m1snOrgsf4Ua2HqOapr5wR"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 16:38:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1c8y-0007sa-JR
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 16:38:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbbKYPhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 10:37:55 -0500
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:57267 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752565AbbKYPhw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2015 10:37:52 -0500
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2015 10:37:51 EST
Received: from localhost (localhost [127.0.0.1])
	by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id E68D78A1
	for <git@vger.kernel.org>; Wed, 25 Nov 2015 16:29:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
	by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ApizImbRjz3a for <git@vger.kernel.org>;
	Wed, 25 Nov 2015 16:29:36 +0100 (CET)
Received: from [136.172.14.25] (unknown [136.172.14.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: huebbe)
	by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id F2F4A8A0
	for <git@vger.kernel.org>; Wed, 25 Nov 2015 16:29:35 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281715>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N7iHCRJkMH0m1snOrgsf4Ua2HqOapr5wR
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Description:

When applying a patch created via `git format-patch` with `git am`,
any prefix of the commit message that's within square brackets is strippe=
d from the commit message.


Reproduction:

    $ git log --oneline --decorate --graph --all
    * b41514b (HEAD) [baz] baz
    | * 5e31740 (master) [bar] bar
    |/
    * aaf5d34 [foo] foo
    $ git format-patch aaf5d34
    $ git checkout master
    $ git am 0001-baz-baz.patch
    $ git log --oneline --decorate --graph --all
    * d5161b8 (HEAD, master) baz
    * 5e31740 [bar] bar
    * aaf5d34 [foo] foo

I have omitted all output except for the `git log` output for brevity.
As you can see, the commit resulting from `git am` has lost the "[bar]" p=
refix from its commit message.

Looking at the patch,

    $ cat 0001-baz-baz.patch
    From b41514be8a70fd44052bff0d3ce720373ec9cfd8 Mon Sep 17 00:00:00 200=
1
    From: Nathanael Huebbe <nathanael.huebbe@informatik.uni-hamburg.de>
    Date: Wed, 25 Nov 2015 15:28:09 +0100
    Subject: [PATCH] [baz] baz

    ---
     baz | 1 +
     1 file changed, 1 insertion(+)
     create mode 100644 baz

    diff --git a/baz b/baz
    new file mode 100644
    index 0000000..7601807
    --- /dev/null
    +++ b/baz
    @@ -0,0 +1 @@
    +baz
    --
    2.1.4

I see that the commit message contains the "[PATCH]"-prefix that `git am`=
 is supposed to strip,
yet it seems to incorrectly continue to also strip the "[baz]"-prefix.


Affected versions:
I have reproduced the bug with versions 1.9.1, 2.1.4, and 2.6.3


Severity:
While I do not consider this a high priority bug, it becomes quite irksom=
e in some workflows.
In my case, an upstream `svn` repository has the policy of using "[branch=
-name]" prefixes
to the commit messages, which are stripped whenever I transplant a commit=
 using the
`git format-patch`/`git am` combination.



--=20
Please be aware that the enemies of your civil rights and your freedom
are on CC of all unencrypted communication. Protect yourself.



--N7iHCRJkMH0m1snOrgsf4Ua2HqOapr5wR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJWVdPfAAoJEO3tJW5NCfoMqUkP/2aydEhBVxkHUDnAja0gpYJ+
aPn8u/nGs8kdFM838rInfrJnNHY4J/C0aJtQQD79Hf29ZAYrCo8qpb0TYyda2h+V
1a332zjevlXEVUnsIh71VdBa1Mw9X5UzyemNo9RQEslsRtd0ttKGjib+Y51SToby
DZ7OqBnpL+gdSLcODdtH6nPCkZtb3ixS7NAKSKTnMzc5Udq0qAnZM5fj58BdF3RJ
GD7rTk956bk5NQTlvcz/wrATapW6bUKTC173vjbim7zcLywoRbGhVER8XRK7UWq2
ArUokTJ5tqryRSytmodud2dpdXNlOEnRg8MI0phVQOWICcYRDh1xjXVFf7SbNfEO
ZUo5HHtsYxgBFv3FEMcrYOswkCtjTlKDIDjGrNU76YT9LPcIRNJ66HRlsoaepvgv
8UXob28yz0u8wmw30B3dTca4gIvbhfgC4ooQrR3KUsodSpa47Sc2BCsaNbMMQVDP
YknBXBTNkKvX1b0pHss5Bmu4cXyPb72Bqqf4VuN+8HrYRxhBw9cndSpR6pka02Ek
shBdGV1wfLwelawQYBawAfwfBJzvfTvC4o/pgQ7Cs7K8D6oDjqfyF239s6iPH7eM
jmevJR73K2kgCqHcXtNukglTG472cMlUvhOTxpSBcPWufmww/Rijeuc84D/0MvTW
J28tSqd5m9KUBlFQEQHX
=u+Tx
-----END PGP SIGNATURE-----

--N7iHCRJkMH0m1snOrgsf4Ua2HqOapr5wR--
