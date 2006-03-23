From: Keith Packard <keithp@keithp.com>
Subject: Re: [RFC] Make dot-counting ignore ".1" at the end
Date: Wed, 22 Mar 2006 22:26:22 -0800
Message-ID: <1143095182.6850.23.camel@neko.keithp.com>
References: <Pine.LNX.4.64.0603221723230.9196@g5.osdl.org>
	 <Pine.LNX.4.64.0603221746300.26286@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-I56GQ1kncSJvd9p9dUbt"
Cc: keithp@keithp.com
X-From: git-owner@vger.kernel.org Thu Mar 23 07:26:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMJHZ-0002qn-RT
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 07:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWCWG0t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 01:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWCWG0t
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 01:26:49 -0500
Received: from home.keithp.com ([63.227.221.253]:20243 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1751232AbWCWG0s (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Mar 2006 01:26:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id BF6A8130020;
	Wed, 22 Mar 2006 22:26:46 -0800 (PST)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 02046-01; Wed, 22 Mar 2006 22:26:46 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1033)
	id B833113001F; Wed, 22 Mar 2006 22:26:45 -0800 (PST)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id A71B214001;
	Wed, 22 Mar 2006 22:26:45 -0800 (PST)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id A36E86AC1BF; Wed, 22 Mar 2006 22:26:25 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0603221746300.26286@g5.osdl.org>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17855>


--=-I56GQ1kncSJvd9p9dUbt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-03-22 at 17:50 -0800, Linus Torvalds wrote:
> I'm not 100% sure this is appropriate, but in general, I think "<rev>" an=
d=20
> "<rev>.1" should be considered the same thing, no? Which implies that=20
> "1.1" and "1.1.1.1" are all the same thing, and collapse to just "1", ie =
a=20
> zero dot-count. They are all the same version, after all, no?

No. 1.1.1.1 is the first import on the first vendor branch; 1.1 is the
head of the tree.

vendor branches are total CVS magic and need very special treatment. The
initial import sets the 'branch' value in the ,v file to point at the
vendor branch. Subsequent imports leave the branch value alone, a commit
to the trunk will reset the branch to point at the trunk. This means
that use of the default version of the file just after an import gives
you the head of the import tree. It's insane, but that's how it works.

What I've been doing is to treat imports to a vendor branch which occur
sequentially as if they were on the trunk. Imports after an intervening
commit to the trunk are placed on a separate branch.

The best part is that you get the vendor branch named 1.1.1 *even if
you've made a million commits to the trunk*. Which means that you must
ignore the numeric relationship between the vendor branch and the trunk
and merge them together in date order.

> This gets rid of the insane (?) special case of "1.1.1.1" that exists=20
> there now, since it's now no longer a special case.

Oh, it's a seriously special case, one which takes seriously special
handling, and a careful disregard for normal version number ordering.

> I also wonder if trailing ".1" revisions should be ignored when comparing=
=20
> two revisions.

As 'real' CVS version numbers always have four digits, this doesn't much
matter.

btw -- I've got my parsecvs code doing a pretty good job of discovering
the structure of an arbitrary set of ,v files. The last remaining bit of
code to write is to correctly construct the tree of branches from the
partial trees in each ,v file. With simple trees, things are looking
good, with the xserver CVS tree, I get a couple of mis-hung branches as
the branch tree is wrong. Fixed tomorrow, I think, at which point it
should be able to produce more accurate commits than cvsps does.

--=20
keith.packard@intel.com

--=-I56GQ1kncSJvd9p9dUbt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEIj+OQp8BWwlsTdMRAswwAJ9v/M5B4fGeCRAsLYN0bykRGOsByQCfYnAL
WOnShObWnoZn4a1jGj9x3I8=
=1fI/
-----END PGP SIGNATURE-----

--=-I56GQ1kncSJvd9p9dUbt--
