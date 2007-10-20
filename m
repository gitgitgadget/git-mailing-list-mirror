From: Jan Hudec <bulb@ucw.cz>
Subject: Re: How can I access remote branches in a cloned repository on my
	local machine?
Date: Sat, 20 Oct 2007 16:09:27 +0200
Message-ID: <20071020140927.GC19521@efreet.light.src>
References: <05B1B470-1C86-40E6-9E33-968809414537@atlasocean.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Cc: git@vger.kernel.org
To: Erich Ocean <erich@atlasocean.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 16:09:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjF1R-0004w2-L2
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 16:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304AbXJTOJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 10:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754258AbXJTOJe
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 10:09:34 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:41668 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752702AbXJTOJd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 10:09:33 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 3C37B57372;
	Sat, 20 Oct 2007 16:09:32 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id B12gVZGX50wb; Sat, 20 Oct 2007 16:09:29 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id A80CF57371;
	Sat, 20 Oct 2007 16:09:28 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IjF15-00027c-D6; Sat, 20 Oct 2007 16:09:27 +0200
Content-Disposition: inline
In-Reply-To: <05B1B470-1C86-40E6-9E33-968809414537@atlasocean.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61838>


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 20, 2007 at 06:15:21 -0700, Erich Ocean wrote:
> Our developer group has a shared git repository at=20
> git@git.1kstudios.lan:dev.
>
> Each developer has established their own local repository by running:
>
> 	git clone git@git.1kstudios.lan:dev
> 	git config remote.origin.push master:refs/remotes/<username>/master

The paths on server are refs/remotes/<userame>/master.

It's more common to publish (push to public or shared repository) to
refs/heads. The refs/remotes namespace is normally only used when fetching.
There's nothing in git saying you can't do it your way, but there are things
that make the common way more convenient.

> Each developer then does a `git pull` to update their master branch, merg=
es=20
> their changes from their local topic branches, and then does `git push` t=
o=20
> make the results available at git@git.1kstudios.lan:dev.
>
> As the integrator, I have then been ssh'ing into the git@git.1kstudios.la=
n=20
> machine, cd'ing to "dev" and doing:
>
> 	git merge <username>/master

Yes, because locally refs/remotes is searched when looking for unqualified
ref. But if you checked that out, git would complain it's not a branch and
created a detached head.

> to incorporate their changes after running `git diff` to see what the=20
> changes are.
>
> My own development repository is set up identically to the other=20
> developers.
>
> What I would like to do now is clone the git@git.1kstudios.lan:dev=20
> repository on my local machine a second time, checkout a <username>/maste=
r=20
> branch in that repository, and then use BBEdit's graphical diff to visual=
ly=20
> see the changes between my own repository and what another developer has=
=20
> pushed to the shared repository. I'll then merge them into my own develop=
er=20
> repository and push that to the shared repository for the rest of the=20
> developers to pull from, so no longer will I merge by ssh'ing into the=20
> machine with the shared repository.
>
> The problem is, when I clone git@git.1kstudios.lan:dev, the various=20
> <username>/master's aren't there. I have tried a bunch of different ways,=
=20
> but they all give me errors. For example:

By default clone only compies refs from refs/heads to refs/remotes/origin a=
nd
=66rom refs/tags to refs/tags.

You have two options here:
 - Move the branches on server to refs/heads. Then the various
   <username>/master will be visible locally as origin/<username>/master
   (qualified names refs/remotes/origin/<username>/master -- you can of
   course call the remote differently if you want).
 - Add +refs/remotes/*:refs/remotes/origin/* to remote.origin.fetch config
   key in your local repository (I am not sure it will work properly with
   multiple source patterns with the same destination pattern, though).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHGgwXRel1vVwhjGURAqLYAKDuzVSMQKlIQE0+hSsfZW26oaMhbgCeJSZc
nmpLkElTuK0KJsB42kuFIBI=
=s5P0
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
