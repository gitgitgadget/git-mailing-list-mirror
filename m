From: Ismael Bouya <ismael.bouya@normalesup.org>
Subject: Problem with git when rebasing
Date: Wed, 29 Oct 2014 14:48:47 +0100
Message-ID: <20141029134847.GF12302@ns208507.ip-188-165-209.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vSsTm1kUtxIHoa7M"
Cc: thaddee.tyl@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 29 14:57:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjTkk-0003yQ-Qo
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 14:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932994AbaJ2N5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2014 09:57:30 -0400
Received: from ns208507.ip-188-165-209.eu ([188.165.209.148]:37584 "EHLO
	immae.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932906AbaJ2N53 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 09:57:29 -0400
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Oct 2014 09:57:28 EDT
Received: by immae.eu (Postfix, from userid 1000)
	id 25FAA1802E1; Wed, 29 Oct 2014 14:48:47 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vSsTm1kUtxIHoa7M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,
git rebase can sometimes "forget" a commit, here is the workflow to reprodu=
ce
this problem:

$ git init .
$ echo "content 1" > file1
$ git add file1 && git commit -m "C1"
$ echo "content 2" > file2
$ git add file2 && git commit -m "C2"
$ echo "content 3" > file3
$ echo "content 2.3" >> file2
$ git add file3 && git commit -a -m "C3"
$ echo "content 4" > file4
$ git add file4 && git commit -a -m "C4"
$ git rebase -i HEAD^^
<change "pick" to "edit" for C2>
$ echo "content 2" > file3
$ git rebase --continue

Here, we get an error
------
error: The following untracked working tree files would be overwritten by m=
erge:
  file3
Please move or remove them before you can merge.
Aborting
Could not apply <hash_C3>... C3
------
This is expected, as we have created an untracked file which will be created
later.

However, if we remove/move away the file3 which conflicts, the "git status"
command is misleading, in the sense that it doesn't tell us to run
git cherry-pick <hash_C3>
Or something approaching. If we don't, then commit <hash_C3> is completely
forgotten by the rebasing once we continue it.

Maybe a more explanatory error message would be useful? It is very unclear =
that
the commit won't apply when we continue the rebase workflow.

Kind regards,
--=20
Ismael

--vSsTm1kUtxIHoa7M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlRQ8D8ACgkQbQyv/dsc/pCAUwCfUpZkIPdaLRTTh90EpkQKWx/3
XugAnAj7PEv2Q8xBTHZC4rmank2DLBhu
=NB1S
-----END PGP SIGNATURE-----

--vSsTm1kUtxIHoa7M--
