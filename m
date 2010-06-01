From: Antonio =?iso-8859-1?q?Garc=EDa_Dom=EDnguez?= 
	<antonio.garciadominguez@uca.es>
Subject: Re: http-smart-backend: can clone, cannot push
Date: Tue, 1 Jun 2010 18:59:58 +0200
Organization: Universidad de =?iso-8859-1?q?C=E1diz?=
Message-ID: <201006011900.01926.antonio.garciadominguez@uca.es>
References: <E66CC81A-CCED-4D8E-AE7C-C02FB0AF6F6C@pelagicore.com> <3A4DAEA3-C7F4-4163-9ABA-37443BB025AB@pelagicore.com> <20100601155833.GT16470@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3246123.imYGCYM7ZL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Jeremiah Foster <jeremiah.foster@pelagicore.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 01 19:30:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJVIH-0000yx-Ga
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 19:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441Ab0FARaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 13:30:20 -0400
Received: from merlin.uca.es ([150.214.76.6]:33911 "EHLO merlin.uca.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab0FARaT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 13:30:19 -0400
X-Greylist: delayed 1810 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Jun 2010 13:30:19 EDT
Received: from localhost (localhost [127.0.0.1])
	by merlin.uca.es (Postfix) with ESMTP id E747EB70ED;
	Tue,  1 Jun 2010 19:00:02 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at uca.es
Received: from merlin.uca.es ([127.0.0.1])
	by localhost (merlin.uca.es [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id aPAvaSS3+Y2B; Tue,  1 Jun 2010 19:00:02 +0200 (CEST)
Received: from morsa.localnet (openvpni21001.uca.es [10.182.221.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by merlin.uca.es (Postfix) with ESMTP id C0490B706A;
	Tue,  1 Jun 2010 19:00:02 +0200 (CEST)
User-Agent: KMail/1.13.2 (Linux/2.6.31-21-generic; KDE/4.4.2; i686; ; )
In-Reply-To: <20100601155833.GT16470@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148145>

--nextPart3246123.imYGCYM7ZL
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

> A flaw of the smart HTTP transport is the servers are
> nearly impossible to configure for anonymous clone and
> authenticated push via the same URL.  The servers just
> can't seem to be configured to require authentication
> for the $GIT_DIR/info/refs?service=3Dgit-receive-pack request.

Yeah, the problem seems to be that query string. Apache's <Location> doesn'=
t=20
help with that. However, you could add a custom authentication handler whic=
h=20
checks the query part of the URL, right?

<shameless plug>
In fact, I submitted a patch which adds smart HTTP integration to Redmine's=
=20
Perl auth module at [1] and does just this. I've tested on a server I set u=
p=20
at my uni, and pretty much nowhere else :-/. Lines 250-254 should do just=20
that: check the unparsed URI (possibly including the query string) for git-
receive-pack at the end. That includes .../git-receive-pack and=20
=2E../refs?service=3Dgit-receive-pack.

Perhaps you could take just the parts you need from the patched Redmine.pm=
=20
file.
</shameless plug>

Another option could be using RewriteCond to set an environment variable=20
depending on REQUEST_URI and QUERY_STRING [2] and use "Allow from env=3D...=
"=20
[3]. I think it should be simpler than writing and installing an=20
authentication handler, but I'm not sure, either. I'm mostly limited to Apa=
che=20
here: perhaps it can be easier with other web servers.

[1]: http://www.redmine.org/attachments/3300/0001-Redmine.pm-add-Git-smart-
HTTP-support-v4.patch
[2]: http://www.phwinfo.com/forum/alt-apache-configuration/329880-regular-
expressions-locationmatch.html#post1483835
[3]: http://httpd.apache.org/docs/2.2/mod/mod_authz_host.html#allow

Regards,
Antonio

--nextPart3246123.imYGCYM7ZL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkwFPI4ACgkQef4fXqLCP6I7gQCfW+cGlPmtGj45r+HGZNZFUF9q
eIsAn36wZ7sxyOXi3fWvlSj0p/5sviOj
=S7Rr
-----END PGP SIGNATURE-----

--nextPart3246123.imYGCYM7ZL--
