From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [RFC PATCH] Allow cloning branches selectively
Date: Sun, 25 Dec 2011 20:37:40 +0000
Message-ID: <20111225203740.GD6361@beez.lab.cmartin.tk>
References: <1324671199-7074-1-git-send-email-cmn@elego.de>
 <7vmxajaswj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 25 21:37:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ReupQ-0003Dn-JC
	for gcvg-git-2@lo.gmane.org; Sun, 25 Dec 2011 21:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271Ab1LYUhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Dec 2011 15:37:52 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:35770 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129Ab1LYUhu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Dec 2011 15:37:50 -0500
Received: from beez.lab.cmartin.tk (145.Red-81-38-112.dynamicIP.rima-tde.net [81.38.112.145])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 3A973461B9;
	Sun, 25 Dec 2011 21:37:38 +0100 (CET)
Received: (nullmailer pid 22986 invoked by uid 1000);
	Sun, 25 Dec 2011 20:37:40 -0000
Mail-Followup-To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vmxajaswj.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187689>


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2011 at 01:18:36PM -0800, Junio C Hamano wrote:
> Carlos Mart=EDn Nieto <cmn@elego.de> writes:
>=20
> > Sometimes it's useful to clone only a subset of branches from a remote
> > we're cloning. Teach clone the --fetch option to select which branches
> > should get fetched.
>=20
> This is just a knee-jerk reaction without reading the patch text (which I
> won't be doing over the holiday weekend anyway), but is the workflow of
> the primarly intended audience to clone "a subset of branches" or "a
> single branch"?
>=20
> I have a slight suspicion that this started out as "I often want to create
> a clone to _track_ a single branch, but because I am mucking with the code
> related to cloning anyway, I might as well allow more than one to be
> fetched, even though I do not have any need for that, somebody might find
> it useful". And that is why it is important to answer the first question.

The main usefulness is indeed to track single branches. Limiting it to
one looked to me to be an arbitrary limitation and I don't like
those. Tracking between two and all branches is probably quite a niche
however, so I'll go with allowing one -t/--track option and if enough
people want to extend it, we'll see what we do then.

>=20
> If the primary motivation is for a single branch, I suspect supporting
> only a single branch and advertising the feature as "tracking only one
> branch" might make it much easier to understand to the end users.
>=20
> Upon "git clone --track cn/single-clone $there x.git", you would do
> something like:
>=20
>   it=3Dcn/single-clone &&
>   git init x.git &&
>   cd x.git &&
>=20
>   # configure "git fetch origin" to only get branch $it
>   git config remote.origin.url "$there" &&
>   git config remote.origin.fetch refs/heads/$it:refs/remotes/origin/$it=
=20
>=20
>   # declare that the primary branch at origin is $it as far as we are con=
cerned
>   git symbolic-ref -m clone refs/remotes/origin/HEAD refs/remotes/origin/=
$it &&

As Jakub pointed out, remote already has this option, so you can
replace these calls with

    git remote add origin $there -t $it -m $it

>=20
>   # Git aware prompt reminds us that this repository is to track branch $=
it
>   git symbolic-ref -m clone HEAD refs/heads/$it &&
>=20
>   # And Go!
>   git fetch origin &&
>   git reset --hard remotes/origin/$it &&
>   git config branch.$it.remote origin &&
>   git config branch.$it.merge $it

A lazier man (or one who doesn't work with internals every day) might do

    git checkout -t origin/$it

which the documentation claims would do the same thing. So it boils
down to doing three commands and it feels like it'd be much easier to
just write a small script than to modify the clone code. Putting it in
C will hopefully make the code a bit cleaner, if I use the code that
already exists in remote.

>=20
> Of course you _could_ support more than one pretty easily, but the point
> is that it is unclear how you explain to the end user what the feature
> does and what it is for in easily understoodd terms, once you start doing
> so. It will no longer be "this new clone is to track that branch", but
> something else, and I do not know what that something else is.

Looking at the explanation for the -t (--track) option in git-remote,
it's certainly not very friendly unless you already know exactly what
a -t option would do if you were to implement it.

   cmn

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJO94mUAAoJEHKRP1jG7ZzTZWIH/0FlGddokujP/rtIxyF0ZKhT
pcQW/uQYyl+c9apVN4sEvCoPnLucLI6n+rHEjfS5qgKAENMa4nh+acdEHfK+zIt1
I9wJ8/NkcNQa5NwUa9AK47INbZkmeTrnis2vyq3rGVJbDBZvwtdjcT3wl8GyozK0
P/ihs7LacHIQd+3XJ8QoO6bqK0t3hlQUoo3viVt5jxRTnZg8LIWoVF9LIVYsVRZg
IYTVb/lZLWdGlv1qfXDKIRwrFRTrzibk1N5cq5oUilV6IykH8ya9/EmvpfZlHG1F
bopBnrux5PZsJMemJinIKncsVSOCiK9IvcIngaTja646qIf5/6Dz/eXJFdDHlGI=
=Z998
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
