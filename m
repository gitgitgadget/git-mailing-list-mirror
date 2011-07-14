From: Eric Blake <eblake@redhat.com>
Subject: git push vs. slow connection times - local commit resolution is too
 late
Date: Thu, 14 Jul 2011 07:22:50 -0600
Organization: Red Hat
Message-ID: <4E1EEDAA.1000204@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enigBD73FE038DF425C79453E0CE"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 14 15:22:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhLsW-0003ig-JS
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 15:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862Ab1GNNWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 09:22:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59464 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754770Ab1GNNWv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 09:22:51 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p6EDMpHa013865
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Thu, 14 Jul 2011 09:22:51 -0400
Received: from [10.3.113.37] (ovpn-113-37.phx2.redhat.com [10.3.113.37])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p6EDMo4J021334
	for <git@vger.kernel.org>; Thu, 14 Jul 2011 09:22:50 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110621 Fedora/3.1.11-1.fc14 Lightning/1.0b3pre Mnenhy/0.8.3 Thunderbird/3.1.11
X-Enigmail-Version: 1.1.2
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177129>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBD73FE038DF425C79453E0CE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I've been bitten several times by this bug now, so I'll report it in the
hopes that someone knows what to do to patch it.

Scenario - I have a remote repository that takes on the order of 10
seconds to connect to, for any operation like 'git push'.  I know that
there is a lag, so I intentionally have two terminals open, both
visiting the same directory, one for interaction with the remote, and
the other for acting on the local repository, with the hope that I can
do useful work in the second terminal rather than idly waiting on the
lag in the first terminal.

In the middle of rebasing a patch series, where I want to incrementally
push the patches that I have gotten through so far, I used the following
steps:

On the remote-interaction terminal, I push the current state of my tree:
git push remote HEAD:master

On the local-interaction terminal, I move on to the next patch:
git rebase --continue

then, to my horror, I find out that the commit I'm working on locally
has already been pushed!  Why?  Because 'git push remote HEAD:master'
does not determine which commit 'HEAD' refers to until _after_ it has
established a connection to remote, but the stupid 10-second lag was
long enough that my actions in my second terminal have changed HEAD in
the meantime.

I would really love it if 'git push' would resolve all local references
_prior_ to trying to connect to the remote server, rather than waiting
until after the connection.  That way, my remote-interaction terminal
can truly be a type-it-and-forget-it terminal, where the push action I
requested reflects the state of the tree at the time I requested it,
rather than picking up changes made later in another terminal.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enigBD73FE038DF425C79453E0CE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJOHu2qAAoJEKeha0olJ0NqZgoH/2vd9iBWVYLiPHco5I+TjyjF
InNkbKrkRGpCJ6+W7RweO5LwteCNVRzDTf+jdMBhn/m/+isGyXrmVmRpzdXHI/aD
kYVOLju5aL+zBNLG/quTj0yxZZvXWmrlRDCBDlCNwLkyZMkfkydhI+JpMqTSJNPe
caygy1C6O7aXQe4g4aipMLanYCrHUHa21hfsHe8N+KvW44KC7npW/XE25cDlOhXJ
ZxQMd9hTgoUSnWXL8KOeVFKo8Kgav6+rlIiNWEDsRjg/Hl6Z5Wz7r+r6SMNsKUsH
eo8fBEvtCwhfPfEfIuoaUdZw3rAryjeF1uJdFmeBKyS8jYxoMjPmG0oaY58LbuA=
=WnnM
-----END PGP SIGNATURE-----

--------------enigBD73FE038DF425C79453E0CE--
