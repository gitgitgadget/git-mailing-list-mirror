From: Pierre Habouzit <madcoder@debian.org>
Subject: git shell scripts flaw wrt dirty env
Date: Fri, 3 Aug 2007 22:14:05 +0200
Message-ID: <20070803201405.GB12430@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="yNb1oOkm5a9FJOVX";
	protocol="application/pgp-signature"; micalg=SHA1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 03 22:14:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH3XJ-0006Jj-1b
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 22:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760909AbXHCUOJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 16:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753812AbXHCUOI
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 16:14:08 -0400
Received: from pan.madism.org ([88.191.52.104]:52151 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759481AbXHCUOH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 16:14:07 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 4AE13C7FC
	for <git@vger.kernel.org>; Fri,  3 Aug 2007 22:14:06 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id C50942BDBB7; Fri,  3 Aug 2007 22:14:05 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54750>


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


  I recently had an issue with git-rebase, and actually git-am, kind of
hard to track down. After some hassle to understand what was going on,
it happened that for an idiotic reason (me trying a fancy new login
manager for X that didn't cleansed environment before staring X) made
all my env dirty. In particular it had $resume (in small letters) set to
/dev/sda5, and git-am happens to use the very same variable, without
cleansing the environment.

  I'm maybe completely out of luck, and that's the sole unsafe use of
variables in git shell scripts, but I don't think so, and maybe some
kind of failsafe could be used. A crude way is to call:

  unset `env | cut -d=3D -f1 | grep -v [A-Z]`

  at the beginning of every script, so that every lowercase-only
variables are unset, hence can be safely used. But it's completely
tasteless. Though, as it can really lead to _very_ odd bugs, well, I
just wanted to share the issue. For the curious, you can read on [0]
what the issue looked like for me...


  [0] http://bugs.debian.org/cgi-bin/bugreport.cgi?msg=3D38;bug=3D435807#38

Cheers,
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGs4yNvGr7W6HudhwRAmJuAJ0YZgVSj4BxEYpNVIuU5lKvx8zNvgCfWtVn
3dl/NDOD5Au7mSgQnIj4BZ4=
=7MBC
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
