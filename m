From: Pierre Habouzit <madcoder@debian.org>
Subject: [bug] generic issue with git_config handlers
Date: Thu, 31 Jan 2008 10:16:27 +0100
Message-ID: <20080131091627.GB24403@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="WhfpMioaduB5tiZL";
	protocol="application/pgp-signature"; micalg=SHA1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 10:17:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKVXd-0005wK-Hg
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 10:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbYAaJQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 04:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbYAaJQc
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 04:16:32 -0500
Received: from pan.madism.org ([88.191.52.104]:40154 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156AbYAaJQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 04:16:29 -0500
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 3DBED31696
	for <git@vger.kernel.org>; Thu, 31 Jan 2008 10:16:28 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 62A804D6497; Thu, 31 Jan 2008 10:16:27 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72107>


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


  One of my co-workers stumbled upon a misfeature of the git config
parser. The following syntax is allowed:

    [section]
	 foo


  I saw that this is a feature, though as a consequence, the "value"
passed to git_config handlers may be NULL, and a _lot_ of git config
handlers don't know this could happen. This becomes an issue when you do
something like:

[user]
    name

--> every git command segfaults basically

[alias]
    foo

--> `git foo` segfaults


  I wanted to fix that, and generate nicer errors than a crash, changing
git_config to also take a boolean argument telling if the caller expects
"value" to be NULL, or would like to reject it, though the code has so
many callbacks to fix, and I have too little time right now, that I just
drop the thing on the list, hoping that some nice soul will take care of
the issue.

Cheers,
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHoZHrvGr7W6HudhwRApulAJwKYmdXk5beLD/O+XZ9lWt+6cN1VACfd7Li
kQECjkuvyVB42njYPz1Z9rs=
=SBvs
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
