From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH 2/7] gitweb: Support comparing blobs with different names
Date: Mon, 30 Apr 2007 07:27:02 +0200
Message-ID: <20070430052702.GA12744@auto.tuwien.ac.at>
References: <437446e84f3aea71f74fea7ea66db4c1c326fb6b.1176659094.git.mkoegler@auto.tuwien.ac.at> <a209e0308fc80ef0623baef8dca49e61b7bafaab.1176659094.git.mkoegler@auto.tuwien.ac.at> <20070416201813.GA2592@auto.tuwien.ac.at> <200704292335.50102.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 07:27:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiOPs-0007yw-8X
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 07:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423020AbXD3F1K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 30 Apr 2007 01:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422999AbXD3F1J
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 01:27:09 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:39348 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423020AbXD3F1G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 01:27:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 1E83168092C1;
	Mon, 30 Apr 2007 07:27:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i75X9Cp298EZ; Mon, 30 Apr 2007 07:27:02 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 30C266800676; Mon, 30 Apr 2007 07:27:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200704292335.50102.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45855>

On Sun, Apr 29, 2007 at 11:35:49PM +0200, Jakub Narebski wrote:
> On Monday, 16 April 2007, Martin Koegler wrote:
>=20
> > Currently, blobdiff can only compare blobs with different file
> > names, if no hb/hpb parameters are present.
> >=20

I've already posted a new version of this patch:
http://www.spinics.net/lists/git/msg28812.html

Can you please look at it.

> > Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> > ---
> > New version, as I found a bug in the expiration handling code.
> >=20
> > I unified all blobdiff variants and added support for comparing blo=
bs
> > with different names.
> >=20
> > If h/hp parameter are missing, I need to generate them with
> > git_get_hash_by_path, as the are needed for the html header, which =
is
> > generated before parsing the git-diff output.
>=20
> git_get_hash_by_path uses git-ls-tree but it does not catch all the i=
nfo;
> perhaps git_get_info_by_path would be called for here.

I now only need the hash of the blob, if not passed as parameter, to
generate a correct header.

> [...] =20
> > +	if (defined $hash_parent_base && defined $file_parent && !defined=
 $hash_parent) {
> > +	    $hash_parent =3D git_get_hash_by_path($hash_parent_base, $fil=
e_parent);
> > +	}
> [...]
> > +	# open patch output
> > +	open $fd, "-|", git_cmd(), "diff", @diff_opts,
> > +	$hash_parent, $hash, "--"
> > +		or die_error(undef, "Open git-diff failed");
>=20
> You would most probably use now "$hash_base:$file_name" instead of $h=
ash
> if $hash_base is defined, i.e.
>=20
>   defined $hash_base ? "$hash_base:$file_name" : $hash
>=20
> and similarly for $hash_parent parameter now that <tree>:<path> form
> respects mode changes information.

Addressed in new patch.

mfg Martin K=F6gler
