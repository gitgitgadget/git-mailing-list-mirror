From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH] git-p4: check for existence of repo dir before trying to create [Was: Asking again... [Re: how to properly import perforce history?]]
Date: Mon, 11 Jun 2007 23:32:43 +0200
Message-ID: <200706112332.46996.simon@lst.de>
References: <20070608202236.GJ25093@menevado.ms.com> <200706112159.34181.simon@lst.de> <20070611205140.GN25093@menevado.ms.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2295649.uMlKQjcokv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kevin Green <Kevin.T.Green@morganstanley.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 23:32:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxrVF-0005lU-2n
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 23:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbXFKVch (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 17:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbXFKVch
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 17:32:37 -0400
Received: from verein.lst.de ([213.95.11.210]:50176 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733AbXFKVch (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 17:32:37 -0400
Received: from luria.local (172.84-48-121.nextgentel.com [84.48.121.172])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l5BLWVo6019694
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Mon, 11 Jun 2007 23:32:33 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <20070611205140.GN25093@menevado.ms.com>
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49887>

--nextPart2295649.uMlKQjcokv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 11 June 2007 22:51:40 Kevin Green wrote:
[...]
> Anyway, grabbed git-p4 and tried it three ways:
>
> 1) git-p4 clone //depot/path/repo@all
>
>   I don't like this because it creates a git repository under "repo"
> subdir. To make a long store short, we have a very strict namespace for
>   development...  The path ends in src and I'd like the .git repository to
> be under src.

=46air enough :)

> So, I tried this one level up:
>
> 2) git-p4 clone //depot/path/repo@all src
>
> 	But that dies with a mkdir error because 'src' already exists.  I want to
> 	submit a patch, but wanted to check with you first to see if that's the
> 	desired behaviour (I don't think it should fail though) because maybe you
> 	want to stop someone from scribbling on an already present git repositor=
y?
>
> 	I would want to just go for a "if it doesn't exist yet, create it,
> 	otherwise, forge ahead" behaviour.  I attach the patch after my .sig...

Thanks for the patch. Applied and pushed out.

> 3) Tried without clone:
>
> $ git init
> $ git-p4 sync //depot/path/repo@all
>
> 	This looks like it's pulling down all the revisions, but it doesn't
> 	actually put any code in there.  I'm left with the same situation as
> 	git-p4import.py.
>
> 	Actually, not even.  I don't even have the commit history...

Actually... the import worked just fine, but I admit that it is not obvious=
=20
_where_ the import went. I've just pushed out a change that makes git-p4 sy=
nc=20
in this case also print out the ref. By default git-p4 sync imports into=20
refs/remotes/p4/master, so after the above command a simple

	git branch -r

should print

	p4/HEAD
	p4/master

so you could for example just create a new master branch based on your p4=20
import using

	git branch master p4
	git checkout master

I hope this helps :)

Simon

--nextPart2295649.uMlKQjcokv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGbb9+WXvMThJCpvIRAppDAKCITVM4wKRyQil0Mq9j0KdiWAcfCgCggKgj
zW4i65iqsKvybUjk+UhljLE=
=fF0a
-----END PGP SIGNATURE-----

--nextPart2295649.uMlKQjcokv--
