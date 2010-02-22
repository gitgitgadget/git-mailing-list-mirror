From: Jelmer Vernooij <jelmer@samba.org>
Subject: Re: Storing (hidden) per-commit metadata
Date: Mon, 22 Feb 2010 10:56:47 +0100
Message-ID: <1266832607.31769.37.camel@ganieda>
References: <1266599485.29753.54.camel@ganieda>
	 <1266687636-sup-7641@ben-laptop>
	 <32541b131002201057t31fc8a6aydb0942171fe1b8c8@mail.gmail.com>
	 <20100221063433.GA2840@coredump.intra.peff.net>
	 <1266754646.12035.23.camel@ganieda>
	 <20100222051748.GB10191@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-KQObP4Xr5XBQKtlBVeck"
Cc: Jeff King <peff@peff.net>, Avery Pennarun <apenwarr@gmail.com>,
	Ben Gamari <bgamari@gmail.com>, git <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 12:46:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjV2h-0003b7-4v
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 10:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881Ab0BVJ5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 04:57:24 -0500
Received: from gwenhwyvar.vernstok.nl ([92.243.4.181]:58553 "EHLO
	gwenhwyvar.vernstok.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503Ab0BVJ5K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 04:57:10 -0500
Received: from ganieda (localhost [127.0.0.1])
	by gwenhwyvar.vernstok.nl (Postfix) with ESMTP id 0CFE3265F8;
	Mon, 22 Feb 2010 09:58:16 +0000 (UTC)
Received: by ganieda (Postfix, from userid 1000)
	id 5EE7514BC31; Mon, 22 Feb 2010 10:56:48 +0100 (CET)
In-Reply-To: <20100222051748.GB10191@dpotapov.dyndns.org>
X-Mailer: Evolution 2.28.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140665>


--=-KQObP4Xr5XBQKtlBVeck
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-02-22 at 08:17 +0300, Dmitry Potapov wrote:
> On Sun, Feb 21, 2010 at 01:17:26PM +0100, Jelmer Vernooij wrote:
> > For each file we would need to store:
> >=20
> >  * the Bazaar revision id
> >  * any Bazaar revision properties. This is typically a list of URLs of
> > bugs that were fixed, name of the branch the commit was on, any
> > additional parents, or anything arbitrary set by plugins (e.g. the
> > rebase plugin sets 'rebase-of' to the id of the original revision)
> >  * For each file that was added or moved around in the revision, a path
> > to fileid mapping
> >  * Optionally, a list of ghost parent ids and "unusual" revisions for
> > each file but these should be rare.
> >=20
> > This is at least a couple of lines of data and in some cases a lot more=
.
> > I would rather avoid confronting git users who don't care about Bazaar
> > with it.
> The problem with storying this meta data in the commit object is that
> any newly created commits in Git will not have this information, and you
> probably have to add it later when you export these commits to Bazaar,
> which means that the history in Git should be re-written, and Git users
> will have to rebase their branches from one commit to another that are
> identical except this Bazaar-specific information, which you try to hide
> from them. So much for don't care about Bazaar!

> In other words, no matter what git-log displays, as long as you put this
> meta data wherever it changes commit-id, it is visible to Git users, and
> trying to hide this fact is utterly stupid.
>=20
> There are many ways to store Bazaar data in Git without confronting git
> users who don't care about Bazaar with it. For instance, you can create
> a separate branch that will hold this meta data.
>=20
>    master      bzr/master
>=20
>       /---------o
>      o          |
>      |          |
>      |/---------o
>      o          |
>      |          |
>=20
> Commits on bzr/master are fast-forward merges that have the same tree-id
> as corresponding commits on master, but the commit message contains
> Bazaar specific information. So, if someone does not care about Bazaar,
> this is a throw away branch for him. Also, there is no problem to add
> Bazaar specific information to any git commit later when it is pushed
> to Bazaar. The only problem is if you try to rebase commits that were
> pushed to Bazaar, but AFAIK Bazaar does not support overwriting history,
> so you cannot expect anything good of this attempt anyway. The published
> history should not rebased.

There is no need for that data to be added later for revisions that did
not originate from Bazaar. All of the metadata that has to be stored
will be known at the time the commit is created. Those commits that were
made in Git later will not have any metadata that can not be represented
in Git (they were made with Git, after all). There is no need for
rebasing/overwriting history for existing revisions to enable access by
Bazaar.

Having a bzr/master ref means that the extra metadata will not always be
copied around (unless git is patched), so if I push my work from Bazaar
into Git, somebody works on it in Git and pushes a derived branch and
then somebody else clones that derived Git branch into Bazaar again, I
will not be able to communicate with that person's branch.

Cheers,

Jelmer

--=-KQObP4Xr5XBQKtlBVeck
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABAgAGBQJLglTfAAoJEACAbyvXKaRXSXkP/08Jq2bLVWoZqSgiZu6uu5pZ
hMHOP+TF4bjID8MMn4dQP/+xnqbrIKi6lNT398//3GSbwlK/so0ambI2EcCL6hQd
KASuwvIpt40kxCSEdCjZ8DCvfH3BPURavtJQ5da9uW0XK61pp91tAfiyoxhrXEFJ
CpXLz1C6rpNcdILRNnPoENigkYMj/2f/nB5olSED6Hls2eVf6pfq8rspj1J1eLvT
h1OZX6ER7RIcMvHm3KY3Yzv+Nz7S4E3iCdiCyHKR0cM5A4atAtKo+yNy2NgMde77
5N3A622AGe/B8ZTjSN+2OiIc0upzrYPXlYjFqVOGvCGHgQqjlubQCt6KwFEFkMwp
b8Wnn+ilgqjM5Mvrh8zd7+z5Gk+VUZE+AwfjugFuHxQxo9jQpJUkdG4J1+kAWsnv
217RlmJF64mO5jrwqL2x/64GZYWGsEPMAMurPpykAkyoSFHuaOBg3HXQQToL+HZk
93k6rNvGpB7byheGk+pXfcqq9y9snbAoXApXQKV9qnaBCT7mwhdCsVolOJORtuKz
GWOWdZUu8LOgQ7lIauetQs2WvL8VIFjKnvYYbPbzYdTlc1MFSU9kEXMWQOayxQXJ
S1PcbZt+BfpMbmHZ54smJMZFDpA6ASX4GuU2DUPp4u8QN3OkoNPL49+xuzLdMChv
syTaJpdqng0xt9L2E+5J
=ZHl2
-----END PGP SIGNATURE-----

--=-KQObP4Xr5XBQKtlBVeck--
