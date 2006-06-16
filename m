From: Keith Packard <keithp@keithp.com>
Subject: Re: Why so much time in the kernel?
Date: Fri, 16 Jun 2006 10:29:28 -0700
Message-ID: <1150478968.6983.7.camel@neko.keithp.com>
References: <9e4733910606160749t4d7a541ev72a67383e96d86da@mail.gmail.com>
	 <Pine.LNX.4.64.0606160755170.5498@g5.osdl.org>
	 <9e4733910606160825hb538d6fo4c9f1d7d9768e100@mail.gmail.com>
	 <Pine.LNX.4.64.0606160906250.5498@g5.osdl.org>
	 <9e4733910606161000t53328571u10a350eca894ccdc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hjjXTMgzSDLlqzN+49zo"
Cc: keithp@keithp.com, Linus Torvalds <torvalds@osdl.org>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 16 19:30:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrI9B-00029e-0i
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 19:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbWFPRaI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 13:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWFPRaI
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 13:30:08 -0400
Received: from home.keithp.com ([63.227.221.253]:33553 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1751499AbWFPRaG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 13:30:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 6273D13001F;
	Fri, 16 Jun 2006 10:30:04 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 22941-02; Fri, 16 Jun 2006 10:30:03 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 8DFAA13001E; Fri, 16 Jun 2006 10:30:03 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id F369714002;
	Fri, 16 Jun 2006 10:30:02 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id CA052542B2; Fri, 16 Jun 2006 10:29:29 -0700 (PDT)
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606161000t53328571u10a350eca894ccdc@mail.gmail.com>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21951>


--=-hjjXTMgzSDLlqzN+49zo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-16 at 13:00 -0400, Jon Smirl wrote:
> Is it a crazy idea to read the cvs files, compute an sha1 on each
> expanded delta and then write the delta straight into a pack file? Are
> the cvs and git delta formats the same? What about CVS's forward and
> reverse delta use?

At this point, merging blobs into packs isn't a significant part of the
computational cost. parsecvs is spending all of its time in the
quadratic traversal of the diff chains; fixing that to emit all of the
versions in a single pass should speed up that part of the conversion
process dramatically.

>  While this is going on, track the
> branches/changsets in memory and then finish up by writing these trees
> into the pack file too. This should take no more ram than cvsps needs
> currently.

cvsps drops too much state on the floor making branch point and branch
contents inaccurate. What I'm hoping is that I can figure out a way to
discard most of the per-version information by computing tree objects in
reverse order, saving only the tree sha1 and other per-commit info, then
stitch the commits together using that, without needing the full
per-file data.

--=20
keith.packard@intel.com

--=-hjjXTMgzSDLlqzN+49zo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEkup4Qp8BWwlsTdMRAs3aAKCJ8sbZdfg/xa/CH1Q8GVMjlevuQACeIXc9
M6eTqHXEbHGH6YP0p70AQHQ=
=HOzP
-----END PGP SIGNATURE-----

--=-hjjXTMgzSDLlqzN+49zo--
