From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git submodules
Date: Tue, 29 Jul 2008 10:37:55 +0200
Message-ID: <20080729083755.GC32312@artemis.madism.org>
References: <20080728162003.GA4584@artemis.madism.org> <320075ff0807281323l51bb6478j30e3e4c490974a70@mail.gmail.com> <20080728205545.GB10409@artemis.madism.org> <20080728205923.GC10409@artemis.madism.org> <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com> <b3889dff0807282251t7096a8c9wf477cf4495749d34@mail.gmail.com> <20080729082135.GB32312@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="DIOMP1UsTsWJauNi";
	protocol="application/pgp-signature"; micalg=SHA1
To: Benjamin Collins <aggieben@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nigel Magnay <nigel.magnay@gmail.com>,
	Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 10:39:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNkjR-0007yP-Oq
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 10:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388AbYG2Ih6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 04:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753363AbYG2Ih6
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 04:37:58 -0400
Received: from pan.madism.org ([88.191.52.104]:59452 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753308AbYG2Ih5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 04:37:57 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 777873BD4E;
	Tue, 29 Jul 2008 10:37:56 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 82FCF5AD310; Tue, 29 Jul 2008 10:37:55 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Benjamin Collins <aggieben@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nigel Magnay <nigel.magnay@gmail.com>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080729082135.GB32312@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90602>


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On mar, jui 29, 2008 at 08:21:35 +0000, Pierre Habouzit wrote:
>   * a way to remember where you want to push changes you do in the
>     submodule to. That's a bit like branch tracking, but not quite. This
>     is required so that we can (and I strongly believe we want that in
>     the end) make many porcelain commands act on the full
>     (super+sub)modules in a unified way, somehow hiding the submodules
>     boundaries.
<snip>
>=20
>=20
>   * What you "track" must be a per supermodule branch thing, so that if
>     you do things like that:
<snip>

  In fact, nowhere I used the name of the current submodule branch in my
examples, so maybe we don't really need it. What we need though, is a
way to tell where the submodules are pushed to, IO what they (try to)
track remotely, IOW of which remote reference they should always be a
parent.

  Such an information is probably to be put in .gitmodules, this way,
you have the per-supermodule-branch setting I would like to see. And
then one would not care about the submodules be in a detached HEAD
because I believe those scenarii work well:

  * If you do no changes in the submodules, all just works like it does
    now.

  * If your only work in the submodule is to refresh its state to the
    tip of what it currently track, then well, we probably want a git
    submodule command for that, and no further ado is done.

  * If you just want a simple fix to go in the submodule, work from your
    supermodule, as if there was no submodule. git-commit your changes
    (which with a submodule aware git-commit would be transparent), then
    you can push your work. And in the worst case scenario where you
    cannot push because it's not a fast forward, you would fetch, merge
    and push again.

    You don't really need a name for the submodule, even if you want to
    reset to the state before the merge because you screwed it, as
    basically, git-reset would _also_ be submodule aware and DWYM
    without an explicit reference for the submodule.

  * If you have heavy works in the submodule, then you probably will
    setup many submodule topic branches, work inside of it like you
    already do, and the extra step of reattaching the HEAD somewhere is
    not as bad as it is with (3) as it's a tiny overhead compared to all
    you're going to do with your topic branches.


So okay, let's scratch this "automatic reference" thing, I see its
limits now, so what about having a .gitmodule entry look like:

    [submodule "$path"]
	path =3D "$path"
	url =3D git://somewhere/
	tracks =3D master


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiO1uMACgkQvGr7W6HudhyKUACePcUKP39qELsdjSsCTTu9mWy4
W3oAnjssOTT/Ri3+EqUwEUTOiBNIe65O
=qmYs
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
