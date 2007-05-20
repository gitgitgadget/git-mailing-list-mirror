From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Mon, 21 May 2007 00:52:53 +0200
Message-ID: <20070520225252.GO5412@admingilde.org>
References: <11796842882917-git-send-email-skimo@liacs.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LG0Ll82vYr46+VA1"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon May 21 00:53:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpuGr-0001zG-Tg
	for gcvg-git@gmane.org; Mon, 21 May 2007 00:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757821AbXETWwz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 18:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757835AbXETWwz
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 18:52:55 -0400
Received: from mail.admingilde.org ([213.95.32.147]:59180 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757821AbXETWwy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 18:52:54 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HpuGj-00070d-3i; Mon, 21 May 2007 00:52:53 +0200
Content-Disposition: inline
In-Reply-To: <11796842882917-git-send-email-skimo@liacs.nl>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47942>


--LG0Ll82vYr46+VA1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, May 20, 2007 at 08:04:33PM +0200, skimo@liacs.nl wrote:
> This patch series implements a mechanism for cloning submodules.
> Each submodule is specified by a 'submodule.<submodule>.url'
> configuration option, e.g.,
>=20
> bash-3.00$ ./git-config --remote=3Dhttp://www.liacs.nl/~sverdool/isa.git =
--get-regexp 'submodule\..*\.url'=20
> submodule.cloog.url /home/sverdool/public_html/cloog.git
> submodule.cloog.url http://www.liacs.nl/~sverdool/cloog.git

I really think we should try to find one standard method to
automatically find the right parent repository for a submodule,
based on the supermodules parent repository.

So e.g. that the submodule repository should stay in the same directory
or in some special subdirectory of the supermodule or even in the
same object store.
Then we can add a configuration layor on top, but there should always
be a sane default.


Things we have to think about:
 * we have to cope with moving / disappearing repositories.
 * we should support bare repositories even for superprojects.
   This can be done either by including the submodule objects in
   the bare repository directly or by linking them (e.g. with your
   config implementation)
 * we have to keep old submodules around forever,
   at least when we want to be able to recover old versions.
   Of course this is not required for all working copies as people
   only want to have a subset of needed modules.
   But for central synchronization repositories (probably the bare ones)
   this is really important.
 * If you remove the whole working directory I don't want to loose any
   data which is already committed, including submodules.

That leads to submodules which store their objects within the
supermodule .git directory, which would automatically obsolete the
need to specify explicit submodule URLs.  But I'm not quite sure
on how to really do this, despite having experimented a bit with it
(my module3 branch should still contain some brainstorming and code).


So back to your code: I don't like absolute URLs in the cloneable part
of the repository.  We should try to stay with relative ones which
can stay the same everywhere.

--=20
Martin Waitz

--LG0Ll82vYr46+VA1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGUNFEj/Eaxd/oD7IRAtLHAJ9MsUTG4SSnajJ2XfNqPpBokthBkwCfZvWq
QLofMGn+vSioiNL5Xbf2FJY=
=Fa1I
-----END PGP SIGNATURE-----

--LG0Ll82vYr46+VA1--
