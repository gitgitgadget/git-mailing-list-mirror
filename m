From: martin f krafft <madduck@madduck.net>
Subject: publishing a forked^W cloned directory with ancestry
Date: Thu, 30 Aug 2007 21:25:33 +0200
Message-ID: <20070830192533.GA18751@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Cc: mdadm development team <pkg-mdadm-devel@lists.alioth.debian.org>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 30 21:26:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQpeG-0003zs-TN
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 21:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbXH3TZo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 15:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759672AbXH3TZo
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 15:25:44 -0400
Received: from clegg.madduck.net ([82.197.162.59]:43035 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759319AbXH3TZn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 15:25:43 -0400
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 1C228BE84;
	Thu, 30 Aug 2007 21:25:35 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 5BE909F161;
	Thu, 30 Aug 2007 21:25:34 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id EEA1C43F4; Thu, 30 Aug 2007 21:25:33 +0200 (CEST)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4109/Thu Aug 30 19:18:52 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57058>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear list,

I am the mdadm (software RAID management) maintainer for Debian and
a recent git convert. While preparing a new mdadm package tonight,
I found myself screaming too often at SVN [0] and decided to convert
Debian mdadm package maintenance to git. Upstream also uses git, so
I said to myself "jolly good", clapped hands, and=E2=80=A6 froze as the
pieces weren't fitting together nicely, at least from my
understanding of how git works.

There are multiple ways to maintain a Debian package and I shall
today only concentrate on tracking an upstream VCS repo and
packaging it for Debian "when I please" (others call that
snapshotting). Thus, I don't wait for upstream to publish tarballs,
I make the package from a given HEAD. There are pros and cons to
this, but let's just assume that it's "the way".

So I clone upstream and find that git-branch -r includes
upstream/master (s/origin/upstream/ for clarity). I then branch
'debian' off upstream/master and make some required changes. With
utter enjoyment of git, I wrap it up and package a new mdadm.deb.
Yay.

And then I wonder: how do I now publish this result of my work? I'd
like to push my repository to git.debian.org so that others can
clone it and help or submit patches against the debianised upstream.

But the remote branch upstream/master only really exists in
$GIT_DIR, which is local and can't be pushed. Or well, even if
I tried, the people cloning from the push location wouldn't see it
[1].

I saw two solutions to this: using two separate upstreams/origins,
and submodules:

1. I could tell my $GIT_DIR/config that upstream/* comes from mdadm
upstream and debian/* comes from git.debian.org and then merge
happily across branches locally and be done with it. However, John
Doe, who on a rainy Saturday afternoon has two hours to spend and
wants to fix some mdadm bugs would have to jump through hoops to
replicate the setup: all the ties between upstream and the
git.debian.org repo are local to my machine and can't be pushed
anywhere (except to verbose documentation).

2. Let's assume for a moment that all Debian changes go to ./debian,
then submodules seem to want to save the day. Except that Debian
changes are not confined to ./debian, and from the perspective of
the Debian mdadm maintainer and with the semantics of git-submodules
in the back of my head [2], I'd rather want it the other way around:
upstream be a submodule of my Debian-specific repo; but upstream
needs to live in . and TTBOMK, submodules can't live in .

So neither of these work and thus I am turning to you. I want to
publish my Debian "fork" of mdadm in such a way that people can
easily clone it, without pulling all the components together. How
would you do it?

I guess the cleanest solution I can come up with is to branch off
upstream/master into branch "upstream" whenever *I* decide it's time
to snapshot. Then, people using my repo would basically be confined
to the state of the tree as it was the last time I rebased
"upstream", but could work freely on the Debian-specific stuff.
I think this is actually quite okay, but I am still interested in
any comments you may have.

Cheers,
m


Footnotes:

[0] fine "too often" tonight meant "once" but it's once too many.
    Thanks Linus and Junio, since I touched git I can't work most
    other VCS anymore (this is sarcastic... not).
[1] I tried cloning B from A, then cloning C from B. Within C, there
    is no reference to A's master branch, so unless B pulled changes
    from A and C pulled changes from B, C could not be updated.
[2] The submodule's commit ID is stored in the supermodules index
    and a commit to the submodule also requires a commit to the
    supermodule to restore consistency.

--=20
"if builders built buildings the way
 programmers wrote programs,
 then the first woodpecker that came along
 would destroy civilization."
                                                  -- gerald weinberg
=20
spamtraps: madduck.bogus@madduck.net

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG1xmtIgvIgzMMSnURAp4qAKDsxOa+Pkx6zfVSrZd3FidHCrIwRQCeNNp5
VmjoSuyBmfjFyOzf8m1o8KE=
=A/ng
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
