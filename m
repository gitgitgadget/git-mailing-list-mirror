From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: $ git checkout and symlinks
Date: Thu, 5 Jul 2007 00:23:51 +0200
Message-ID: <20070704222351.GC13286@artemis.corp>
References: <20070704203541.GA13286@artemis.corp> <7vabubhoxb.fsf@assigned-by-dhcp.cox.net> <20070704210559.GB13286@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="yLVHuoLXiP9kZBkt";
	protocol="application/pgp-signature"; micalg=SHA1
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 05 00:24:00 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6DGQ-0004I8-94
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 00:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758357AbXGDWX4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 18:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760661AbXGDWXz
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 18:23:55 -0400
Received: from pan.madism.org ([88.191.52.104]:32797 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757324AbXGDWXx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 18:23:53 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 8C51A13130;
	Thu,  5 Jul 2007 00:23:52 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id C8B0A10F0; Thu,  5 Jul 2007 00:23:51 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070704210559.GB13286@artemis.corp>
X-Face: $(^e$"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51647>


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 04, 2007 at 11:05:59PM +0200, Pierre Habouzit wrote:
> On Wed, Jul 04, 2007 at 01:52:32PM -0700, Junio C Hamano wrote:
> > Pierre Habouzit <madcoder@debian.org> writes:
> >=20
> > >   if in a branch $ you track the file: dir1/file1.c
> > > and in the branch $ you track elsewhere/file1.c and dir1 be
> > > symlink on elsewhere, then it's not possible to checkout the branch
> > > $. You have to manually
> > > remove the symlink `dir1` else git complains that checkouting branch1
> > > would overwrite dir1/file1.c.
> > >
> > >   I'm not sure how to fix this, and it's quite painful actually :)
> >=20
> > Yeah, I think our handling of symlinks in both read-tree and
> > merge-recursive codepath are Ok for symlinks at the leaf level
> > but not for intermediate levels.  I think we have some patches
> > in the recent git (post 1.5.1) to fix (perhaps some of) the
> > issues, though.
>=20
>   that was with the git in debian unstable, 1.5.2.3 actually.  I'll try
> again with HEAD to see if that's fixed.

  HEADS does not fixes it either.
  Here is how to reproduce the problem step by step:

$ git init-db 				# init a repo

$ mkdir dir
$ echo wibble > dir/a
$ git add a
$ git commit -a -m'add a' 		# have dir/a live in master

$ git checkout -b break
$ git mv dir new 			# rename dir into new
$ ln -s new dir 			# symlink dir to new
$ git add dir 				# add the symlink
$ git commit -a -m 'break things' 	# commit

$ git checkout master
fatal: Untracked working tree file 'dir/a' would be overwritten by merge.


  The same is true for current git.git HEAD, or git 1.5.2.x

Cheers,
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGjB33vGr7W6HudhwRApzQAJwPTe6Q07GQLM0N72AW8IiwARYhfgCgm9IC
TlkBjpWMlkL/tvvvxZB6/JY=
=yZNQ
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
