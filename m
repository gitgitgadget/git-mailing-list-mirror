From: Carl Worth <cworth@cworth.org>
Subject: Re: [PATCH] format-patch: Properly escape From_ lines when creating an mbox.
Date: Thu, 10 Jun 2010 08:52:33 -0700
Message-ID: <87mxv2hola.fsf@yoom.home.cworth.org>
References: <1276045305-20743-1-git-send-email-cworth@cworth.org> <7vljaorhjq.fsf@alter.siamese.dyndns.org> <87eiggiy8g.fsf@yoom.home.cworth.org> <7vaar3nds1.fsf@alter.siamese.dyndns.org> <87pqzyhpl2.fsf@yoom.home.cworth.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git <git@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 17:52:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMk3m-0005K3-FJ
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 17:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759431Ab0FJPwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 11:52:45 -0400
Received: from u15218177.onlinehome-server.com ([74.208.220.233]:35760 "EHLO
	olra.theworths.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab0FJPwo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 11:52:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 57FBD4196F2;
	Thu, 10 Jun 2010 08:52:44 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9cwLNx8mIg4L; Thu, 10 Jun 2010 08:52:34 -0700 (PDT)
Received: from yoom.home.cworth.org (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 10261431FC1;
	Thu, 10 Jun 2010 08:52:34 -0700 (PDT)
Received: by yoom.home.cworth.org (Postfix, from userid 1000)
	id B6C71568E9B; Thu, 10 Jun 2010 08:52:33 -0700 (PDT)
In-Reply-To: <87pqzyhpl2.fsf@yoom.home.cworth.org>
User-Agent: Notmuch/0.3.1-61-ge870437 (http://notmuchmail.org) Emacs/23.1.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148884>

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Jun 2010 08:31:05 -0700, Carl Worth <cworth@cworth.org> wrote:
> I suppose we could maintain compatibility with any scripts, etc. by
> still emitting the initial "From " line, but declaring these files as
> messages (not mbox) and avoiding doing any quoting for them.
>=20
> I think that gets us all the upsides with no downsides. I'll send one
> last patch for that.

Thinking about implementing and testing this, I realized that a file
that looks like an mbox but isn't an mbox will confuse "git am"
slightly. It will think that it should unquote any ">From " lines, but
that would end up being the technically wrong thing to do since the
lines aren't quoted.

I'm not sure what to do here that would cause the least undesirable
breakage. Ignore this problem? Emit a line that still contains anything
that scripts might be looking for but that "git am" could key off of as
"not actually an mbox"?

I suppose we could put a magic timestamp there, but that feels pretty
creepy and fragile.

Another option would be to just emit RFC2822 messages unless the user
passes an explicit option to format-patch (such as --mbox, which would
be implied by --stdout). Then git would generate legitimate (unqoted)
messages and legitimate (quoted) mbox files.

I'd leave it to you to decide whether the --mbox option should be on by
default or phased in with a warning or whatever.

What do you think?

=2DCarl

=2D-=20
carl.d.worth@intel.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iD8DBQFMEQpB6JDdNq8qSWgRApkQAJ0TSFufzcWZlnJb88zXvNmfDYAEBgCghos2
WUoDEEpVk4bwepX4toICJ9A=
=2L8w
-----END PGP SIGNATURE-----
--=-=-=--
