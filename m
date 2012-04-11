From: Nick Douma <n.douma@nekoconeko.nl>
Subject: Re: Migrating SVN to Git, and preserve merge information
Date: Wed, 11 Apr 2012 09:24:35 +0200
Message-ID: <4F8531B3.9030501@nekoconeko.nl>
References: <4F844F33.5000004@nekoconeko.nl> <4F84BAE2.5090803@pileofstuff.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig59600FFC2FEDD7778001BFF8"
Cc: git@vger.kernel.org
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 09:24:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHrvD-0002lW-MA
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 09:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117Ab2DKHYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 03:24:46 -0400
Received: from genome.nekoconeko.nl ([93.94.224.72]:35236 "EHLO
	genome.nekoconeko.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab2DKHYo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 03:24:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by genome.nekoconeko.nl (Postfix) with ESMTP id A78F02217A;
	Wed, 11 Apr 2012 09:26:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at genome.nekoconeko.nl
Received: from genome.nekoconeko.nl ([127.0.0.1])
	by localhost (genome.nekoconeko.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xwsIZbyE7qpQ; Wed, 11 Apr 2012 09:26:50 +0200 (CEST)
Received: from [IPv6:2001:838:300:41e::2] (cl-1055.ams-01.nl.sixxs.net [IPv6:2001:838:300:41e::2])
	by genome.nekoconeko.nl (Postfix) with ESMTPSA id 62EDD22138;
	Wed, 11 Apr 2012 09:26:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nekoconeko.nl;
	s=genome; t=1334129210;
	bh=ctggNDctJsIQxsHI1Zi5JaOjqKwLsvHAA1zkB3bO8GI=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type;
	b=VwFGjQceYkEGzom+whg/kBjqV9DsjXOkbZybFmf2637WBeV+fFBsU2Yh3BcyiF1Ba
	 e9jsS0fCKfhDp+yJRb1dDpYOzHCYsEv8qL3ZHOkky0kvcjGVb+RMlUnlr7d/Vm1PrE
	 aSie/hWCKI1Ep+IuqHef3gz0aHuBke6Xdqbp+GRg=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <4F84BAE2.5090803@pileofstuff.org>
X-Enigmail-Version: 1.4
OpenPGP: id=AB001628;
	url=http://nekoconeko.nl/pub_0xAB001628.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195154>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig59600FFC2FEDD7778001BFF8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 11-04-12 00:57, Andrew Sayers wrote:
> Would I be right in thinking that a commit like "Merged r100,r101,r102
> from trunk" will create three grafts?  If so, that might be the problem=
=2E

One SVN 'merge' commit will generate one graft. The graft itself will
contain all revisions mentioned in the merge commit, and whatever the
original git parent was before the graft.

> Git differentiates between "merges" (which include every commit up to
> and including the specified one) and "cherry-picks" (which just include=

> the specified commit), whereas SVN calls both of these "merges".  Graft=
s
> are a way of creating "merges" rather than "cherry-picks" (which git
> doesn't have any metadata for), and it's not at all easy to get "merge"=

> data out of SVN in the general case.  Having said that, it's often a
> good enough heuristic to pick the highest revision number mentioned in
> the commit message and pretend it's a merge.

The way we 'merged' in SVN was indeed more like cherry-picking, but I'm
looking to display this information as a merge in Git. I also would like
to include all revisions if possible.

The real problem I seem to be having is not completely understanding how
Git grafts work, because I think I'm hitting some kind of limitation or
bug, or just not using it right.

> Incidentally, I'm planning to work on this area of SVN->git conversion
> in the coming months.  I don't have anything you could use yet, but I
> don't suppose the scripts you used are available somewhere?  Getting
> revision information out of log files is particularly tricky, and
> everyone stumbles over a different set of issues.  I'd be really
> interested to pick any nuggets of wisdom out of the approach you took.

I don't really have any useful script for you at the moment, but the
main approach is this:

* I first tag all SVN Git commits with the original SVN revision, like:
"svn/1234"
* Then I retrieve all commits with "merge" in the message, but not "unmer=
ge"
* Now I filter all revisions from the commit message using a regex or two=
=2E
* Using all relevant revisions, I retrieve the corresponding SHA hashes
using the tag names I created in step 1.
* Finally, I write a graft file in format:
<merge commit> <original git parent> <merge rev 1> ... <merge rev n>

Kind regards,

Nick Douma


--------------enig59600FFC2FEDD7778001BFF8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+FMbgACgkQkPq5zKsAFijvzACdEw4QcccjE/gMOPNTd7jvWBlV
JCAAn34I3UihD0/MBYzde9ESi7wFLQ1J
=FuFV
-----END PGP SIGNATURE-----

--------------enig59600FFC2FEDD7778001BFF8--
