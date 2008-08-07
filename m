From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git filter-branch --subdirectory-filter, still a mistery
Date: Fri, 8 Aug 2008 01:48:05 +0200
Message-ID: <200808080148.27384.trast@student.ethz.ch>
References: <200808061539.50268.J.Wielemaker@uva.nl> <200808070950.23754.trast@student.ethz.ch> <200808071214.25399.J.Wielemaker@uva.nl>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5057959.M3n1VQpjPy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Wielemaker <J.Wielemaker@uva.nl>
X-From: git-owner@vger.kernel.org Fri Aug 08 01:49:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRFEP-0000qK-9b
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 01:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbYHGXsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 19:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752837AbYHGXsT
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 19:48:19 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:20143 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658AbYHGXsS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 19:48:18 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Aug 2008 01:48:17 +0200
Received: from [192.168.0.3] ([84.75.158.234]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Aug 2008 01:48:17 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <200808071214.25399.J.Wielemaker@uva.nl>
X-OriginalArrivalTime: 07 Aug 2008 23:48:17.0068 (UTC) FILETIME=[105CD6C0:01C8F8E8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91611>

--nextPart5057959.M3n1VQpjPy
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jan Wielemaker wrote:
>   Ref 'refs/tags/V5.6.50' was rewritten
>   error: Ref refs/tags/V5.6.50 is at 8678b32f71178019c06aefa40e2d3fb9a2e8=
ef25=20
> but
> 	expected 2e8aef64e2fed088720a19ac2ffa2481e5bc7806
>   fatal: Cannot lock the ref 'refs/tags/V5.6.50'.
>   Could not rewrite refs/tags/V5.6.50
[...]
> Now, if I look in .git/packed-refs [...] and I changed all these to
> `lightweight' tags

This appears to be a bug.  I've whipped up a patch that will follow
and should fix the bug.  It has nothing to do with packed-refs; the
current filter-branch chokes on annotated tags during
=2D-subdirectory-filter, even though there is support for tag rewriting.

However, to enable tag rewriting, you need to say --tag-name-filter
cat.

> Now it runs to the end.  Unfortunagtely the history is completely
> screwed up :-(:
>=20
> 	* There are a lot of commits that are not related to the dir
> 	* Commits start long before the directory came into existence,
> 	Looks like it just shows the whole project at this place.

=46or some reason the ancestor detection does not work right.  I'm also
following up with an RFH patch that significantly improves the success
rate (in terms of branches and tags successfully mapped to a rewritten
commit) in the case of your repository.  I doubt more staring at the
code would yield any more ideas at this hour, so ideas would be
appreciated.

The rest is just the other commits/tags showing a lot of the history.
I don't know of any built-in way to prune the branches and tags that
aren't part of the new master, but

  git branch -a --no-merged master

can tell you which branches aren't ancestors of master.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch


--nextPart5057959.M3n1VQpjPy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkibicsACgkQqUud07tmzP1AqwCeN/qXfP5h+NatERHlGECx/xSa
VzEAnjLBf/E27jHb3rbwmXd1RSeAo/ov
=SwCS
-----END PGP SIGNATURE-----

--nextPart5057959.M3n1VQpjPy--
