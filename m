From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 2/2] builtin-merge: avoid run_command_v_opt() for
	recursive
Date: Mon, 11 Aug 2008 21:07:05 +0200
Message-ID: <20080811190705.GQ18960@genesis.frugalware.org>
References: <cover.1218374062.git.vmiklos@frugalware.org> <3db5bd9a8fa1fefb9bd188cc148db826b77fec12.1218374062.git.vmiklos@frugalware.org> <ea5b9868df7c17c55cd091b4408f08a310bed641.1218374062.git.vmiklos@frugalware.org> <7vhc9rxuc4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vTUhhhdwRI43FzeR"
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 21:08:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSckH-0003dj-3D
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 21:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbYHKTGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 15:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbYHKTGx
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 15:06:53 -0400
Received: from virgo.iok.hu ([193.202.89.103]:60532 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943AbYHKTGw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 15:06:52 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 4FD721B251A;
	Mon, 11 Aug 2008 21:06:51 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7A9CA4465E;
	Mon, 11 Aug 2008 20:14:57 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 5723C1190002; Mon, 11 Aug 2008 21:07:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vhc9rxuc4.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91977>


--vTUhhhdwRI43FzeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2008 at 11:47:07AM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> Yes, it saves a fork, but is this really worth it in the bigger picture?
>=20
> Doesn't the current code structure have benefit of allowing git-merge
> itself do necessary clean-up action when merge-recursive calls any of the
> die() it has in many places?

As far as I see in most cases merge-recursive does not call die().

Cases when it does are like:

- broken snprintf
- cache_tree_fully_valid() or cache_tree_update() fails
- diff_setup_done() fails
- flush_buffer() fails
- read_sha1_file() fails
- ll_merge() fails

etc.

In short, I think there are two cases when a die() would be problematic
inside merge-recursive when calling it from builtin-merge:

- merge-recursive can't handle a merge, but an other strategy could do.
  This is the case when doing an octopus merge but in that case
  merge_recursive() is not called at all.

- merge-recursive results in conflicts, but an other strategy could
  handle the merge without conflicts. In this case die() isn't used
  either, so this will not be a problem.

So I don't think there is a case when a die() inside merge-recursive
would occur, but an other strategy would handle the merge properly.

Unless I missed something. ;-)

--vTUhhhdwRI43FzeR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkigjdkACgkQe81tAgORUJan+QCgpWEinOjKIzjIim+7sYNk83HB
GC8An1P/+DNQQLEFoL+u871FFlLaUfkQ
=6J8L
-----END PGP SIGNATURE-----

--vTUhhhdwRI43FzeR--
