From: Jan Hudec <bulb@ucw.cz>
Subject: Re: git push bug?
Date: Sat, 20 Oct 2007 14:05:43 +0200
Message-ID: <20071020120543.GA19521@efreet.light.src>
References: <Pine.LNX.4.64.0710191920210.16728@wbgn129.biozentrum.uni-wuerzburg.de> <000001c81280$ebc5c5e0$5267a8c0@Jocke>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Cc: 'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
	'Steffen Prohaska' <prohaska@zib.de>,
	'git' <git@vger.kernel.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Sat Oct 20 14:18:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjDD9-00014O-Gk
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 14:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531AbXJTMF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 08:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756080AbXJTMF4
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 08:05:56 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:45990 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbXJTMFy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 08:05:54 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 48802572AD;
	Sat, 20 Oct 2007 14:05:53 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id Yt3rcT8jTaYU; Sat, 20 Oct 2007 14:05:50 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 8CEA0572DB;
	Sat, 20 Oct 2007 14:05:49 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IjD5M-0001jJ-2h; Sat, 20 Oct 2007 14:05:44 +0200
Content-Disposition: inline
In-Reply-To: <000001c81280$ebc5c5e0$5267a8c0@Jocke>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61827>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 19, 2007 at 20:50:29 +0200, Joakim Tjernlund wrote:
> On den 19 oktober 2007 19:25, Johannes Schindelin [mailto:Johannes.Schind=
elin@gmx.de] wrote:
> > It strikes me as really odd that you would _want_ to create a branch=20
> > remotely, that has _never_ existed locally.
> It strikes me as really odd that a core developers like yourself
> hasn't tried to justify/explain why push works as it does.

Dscho it rarely kind to newbies.

> As I am trying to convince our dev. group here to move to git instead of =
subversion, I
> need to learn how git works. Now I have gotten to the push function and I=
 need
> to know what can be done with push and how, pitfalls too. As I go along I=
 find behavior
> that I find odd and report these to the list.
>=20
>  git push <repo> v2.6.23:refs/heads/linus
> will make a tag look like a branch

That's becasue tags come in two flavors -- annotated and unannotated.
Annotated ones don't point to commits directly, but via 'tag' objects, that
contain description and usually signature.

Now git push will simply assign a remote branch whatever value you give it.
You gave it a tag, so it assigned a tag.

>  git push <repo> linus:linus
> won't let me create the remote branch linus but
>  git push <repo> linus
> will

Because in the former you are not saying whether refs/heads/linus,
refs/tags/linus or something else (the fact that heads and tags are treated
specially by git does not mean refs can't have other subdirectories -- it
can).

On the other hand in the later it resolves the ref locally and uses the same
name remotedly.

>  git push <repo> :linus
> OOPS, now I just deleted remote branch linus, no warning

Your commands are quite obvious. No need for warning. (Besides, isn't there
a reflog?)

>  git push <repo> linus:refs/head/linus
> creates a branch that is invisible(wont show in git branch -a)

It does not create a branch. It creates a ref with slightly funny name (it's
refs/heads, not refs/head).
         ^

>  git push <repo> linus:refs/heads/newbranch
> creates remote branch newbranch, but you have to know the magic words
> refs/heads/ to do it.

Because you could have wanted a tag. Or a remote. Or something completely
different, maybe because some add-on uses (eg. stgit uses refs/bases and
refs/patches, IIRC).

> Se what I mean?=20

To me it all looks perfectly consistent. But maybe the documentation should
state more clearly, that push works in terms of arbitrary refs, NOT branche=
s.
Feel free to post a documentation patch (people who just had hard time
finding something out are usually better at explaining it than old-timers w=
ho
consider it obvious).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHGe8XRel1vVwhjGURAl+wAJ9f8dZ8/TOQo2hzScf0Bo/YBayFYwCfQDuh
GhG1uQMPLJmlMTmO9SHu4cM=
=GXU5
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
