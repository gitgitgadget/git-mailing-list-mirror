From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: checking out by date
Date: Mon, 12 Jan 2009 13:58:17 -0600
Message-ID: <200901121358.21342.bss@iguanasuicide.net>
References: <20090112193039.GO25823@eratosthenes.cryptobackpack.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6344622.fPPu3HzSWU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Bryson <david@statichacks.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 20:59:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMSwE-00083c-Kq
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 20:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289AbZALT5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 14:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754851AbZALT5l
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 14:57:41 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:37245 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbZALT5k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 14:57:40 -0500
Received: from [63.167.79.33]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LMSup-0001hD-PE; Mon, 12 Jan 2009 19:57:39 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <20090112193039.GO25823@eratosthenes.cryptobackpack.org>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--nextPart6344622.fPPu3HzSWU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 2009 January 12 13:30:39 David Bryson wrote:
>I have a very large repository that imported into git from CVS with
>about 5 years worth of history.
>
>Today I decided to checkout some code from the past:
>
>$ git checkout master@{"Mon Dec 31  2007"}
>warning: Log for 'master' only goes back to Tue, 2 Dec 2008 16:57:15
>-0800.
>
>Then proceeds to checkout a code snapshot from 2 Dec.  To work around
>this I checked out a specific commit id, by looking at the log:
>
>commit 3771ec1d6ccf329da378b7633fdef60474eac4b7
>Author: XXXXXXXXXXXXXXX
>Date:   Mon Dec 31 23:25:17 2007 +0000
>
>$ git checkout 3771ec1d6ccf329da378b7633fdef60474eac4b7
>...
>HEAD is now at 3771ec1... BugId: none correct wrong commit
>
>So what has caused git to be unable to process the date information,
>even though the information is clearly in the history ?  Did I miss
>something ?

The ref@{date} format uses the reflogs which are expired regularly, IIRC. =
=20
Also, I don't think reflogs are built by cvsimport, so they would only go=20
back to the import date.

While there is date information in the output of 'git log', some of those=20
commits may never have been pointed to by the named ref, so they wouldn't=20
satisfy the semantics of "$ref as it was on $date".  With a linear history,=
=20
this "only" puts you in the middle of a fast-forward, which isn't *that* ba=
d.

However, with a non-linear history, taking the ancestor with the latest com=
mit=20
date before the given date might end up checking out a topic branch that=20
hadn't yet been merged on that date, which could be incredibly confusing.

It should be possible to introduce a commit "spelling" to enable=20
checkout-by-date, but I don't know of one currently.  Something=20
like "commitish~{date}" meaning "commitish~n where n is the largest value=20
s.t. commit_date(commitish~n) <=3D date", intentionally taking the first pa=
rent=20
on any merge to discard the merge event.

If this is a feature we feel is valuable, I don't think it would be that ha=
rd=20
to code.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart6344622.fPPu3HzSWU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklroN0ACgkQdNbfk+86fC2a4gCfTHbFSKRZ1Hhzt2KjaI5QTpVw
MqEAnjBmiZ8N+Fh/+5G89PCaUYgG0a1r
=NmoZ
-----END PGP SIGNATURE-----

--nextPart6344622.fPPu3HzSWU--
