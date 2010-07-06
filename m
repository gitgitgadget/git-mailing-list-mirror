From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: help moving boost.org to git
Date: Mon, 05 Jul 2010 20:16:11 -0400
Message-ID: <rmimxu5bh2s.fsf@fnord.ir.bbn.com>
References: <4C31E944.30801@boostpro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Eric Niebler <eric@boostpro.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 02:23:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVvws-0004WE-7q
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 02:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740Ab0GFAXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 20:23:36 -0400
Received: from fnord.ir.bbn.com ([192.1.100.210]:62215 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753333Ab0GFAXf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 20:23:35 -0400
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Jul 2010 20:23:35 EDT
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 56DC7578D; Mon,  5 Jul 2010 20:16:11 -0400 (EDT)
X-Hashcash: 1:20:100706:git@vger.kernel.org::aPeXwRqv9ysvGV5Q:0000000000000000000000000000000000000000000tnY
X-Hashcash: 1:20:100706:eric@boostpro.com::EEyiA6X65e6aR/RH:000000000000000000000000000000000000000000000dRa
In-Reply-To: <4C31E944.30801@boostpro.com> (Eric Niebler's message of "Mon, 05
	Jul 2010 10:16:36 -0400")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.2 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150304>

--=-=-=


You have found the core issue with svn/git: svn allows you to have a
large repo with everything (and atomic commits across it) and to have
users check out parts of the repo separately.  git does not, because the
svn separate checkouts model only works with a remote repository that
you don't keep a copy of.  With git, cloning the repo gets you the whole
thing.

One thought is that you may want to separate how you organize boost
sources in git and how you release them.  It's possible to have a single
git repo for all libraries and have atomic commits but then create
distfiles for each library separately.

git becomes a bit slow when repositories get really large (although
other tools are not any better - the problem is in the sheer number of
vnode ops necessary for the semantics).  I have a repo with all of
NetBSD's "src", "xsrc" and "pkgsrc" in it, and "git status" can take
several seconds because it is calling stat on 230K files.  With only 23K
files, things should be ok.

My advice (which is not really about git) is to figure out whether you
want:

  A) a set of interrelated libraries on which you will allow atomic
  commits that change interfaces/usage in multiple libraries

or

  B) a set of independent libaries which have commits to separate
  libraries, and for which you insist that each library have an API and
  ABI compatiblity story, so that even when upgraded other libraries can
  continue to use it.


For A, you probably want one git repo, much as you have one svn repo
now.  For B, multiple git repos are the right answer.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iEYEARECAAYFAkwydcsACgkQ+vesoDJhHiV9TwCcCaqlSVAI1M6NaEAmAfpxMfY3
JH0AoKDti+VgDh8MmItftH98k/aBjDJQ
=HkJO
-----END PGP SIGNATURE-----
--=-=-=--
