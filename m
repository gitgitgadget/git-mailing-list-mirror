From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: [PATCH v4 0/4] git-submodule add: Add --local-branch option
Date: Tue, 27 Nov 2012 21:42:05 -0500
Message-ID: <20121128024205.GG15213@odin.tremily.us>
References: <20121127183125.GA4185@book.hvoigt.net>
 <20121123175402.GH2806@odin.tremily.us>
 <20121127190105.GQ10656@odin.tremily.us>
 <20121127232858.GA4742@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=gvF4niNJ+uBMJnEh
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 03:42:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdXbn-00085v-Fd
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 03:42:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404Ab2K1Cm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 21:42:27 -0500
Received: from vms173019pub.verizon.net ([206.46.173.19]:46423 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117Ab2K1Cm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 21:42:26 -0500
Received: from odin.tremily.us ([unknown] [72.76.144.216])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ME6008Z5FI60800@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 27 Nov 2012 20:42:07 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id DC36E6E10C2; Tue,
 27 Nov 2012 21:42:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354070525; bh=HA86yQrHX9eUmhalXhawrmw4WcxjqEvMPIH+EpOyFtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kufVPvYUOEyPXdo1jIzA6KUbgnvbuvGaoIcabIsD7rxXjcYy+18oB/WpcaiA7tXpe
 r3jdYxKvYiFN2Bvu1h+EGyiCMPV70/Hyf8tt8VVpeGPRpAyRR5xiGprtbrrYO6tDiA
 G1ondaIoSXjHGAAXJSLz/S9doT1tY/7Bvqkqv//U=
Content-disposition: inline
In-reply-to: <20121127232858.GA4742@book.hvoigt.net>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210678>


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2012 at 12:28:58AM +0100, Heiko Voigt wrote:
> On Tue, Nov 27, 2012 at 02:01:05PM -0500, W. Trevor King wrote:
> > On Tue, Nov 27, 2012 at 07:31:25PM +0100, Heiko Voigt wrote:
> > The v4 series leaves the remote branch amigious, but it helps you
> > point the local branch at the right hash so that future calls to
> >=20
> >   $ git submodule foreach 'git pull'
> >=20
> > can use the branch's .git/modules/<name>/config settings.
>=20
> But IMO thats the functionality which should be implemented in submodule
> update and not left to the user.

Then you might need submodule.<name>.local-branch,
submodule.<name>.remote-repository, and submodule.<name>.remote-branch
to configure

  $ git checkout submodule.<name>.local-branch
  $ git pull submodule.<name>.remote-repository submodule.<name>.remote-bra=
nch

and this would ignore the $sha1 stored in the gitlink (which all of
the other update commands use).  This ignoring-the-$sha1 bit made me
think that a built-in pull wasn't a good fit for 'submodule update'.
Maybe if it went into a new 'submodule pull'?  Then users have a clear
distinction:

* 'update' to push superproject $sha1 changes into the submodules
* 'pull' to push upstream-branch changes into the submodules

> > > I would think more of some convention like:
> > >=20
> > > 	$ git checkout -t origin/$branch
> > >=20
> > > when first initialising the submodule with e.g.
> > >=20
> > > 	$ git submodule update --init --branch
> > >=20
> > > Then later calls of
> > >=20
> > > 	$ git submodule update --branch
> > >=20
> > > would have a branch configured to pull from. I imagine that results in
> > > a similar behavior gerrit is doing on the server side?
> >=20
> > That sounds like it's doing pretty much the same thing.  Can you think
> > of a test that would distinguish it from my current v4 implementation?
>=20
> Well the main difference is that gerrit is automatically updating the
> superproject AFAIK. I would like it if we could implement the same
> workflow support in the submodule script. It seems to me that this is
> already proven to be useful workflow.

Ah, sorry, I meant the configuring which remote branch you were
pulling from happens at submodule initialization (via .git/modules/=E2=80=
=A6)
for both your workflow and my v4.

You're right that having a builtin pull is different from my v4.

> https://github.com/hvoigt/git/commits/hv/floating_submodules_draft

I looked over this before, but maybe not thoroughly enough ;).

> > > How about reusing the -b|--branch option for add? Since we only change
> > > the behavior when submodule.$name.update is set to branch it seems
> > > reasonable to me. Opinions?
> >=20
> > That was the approach I used in v1, but people were concerned that we
> > would be stomping on previously unclaimed config space.  Since noone
> > has pointed out other uses besides Gerrit's very similar case, I'm not
> > sure if that is still an issue.
>=20
> Could you point me to that mail? I cannot seem to find it in my archive.

Hmm.  It seems like Phil's initial response was (accidentally?) off
list.  The relevant portion was:

On Mon, Oct 22, 2012 at 06:03:53PM -0400, Phil Hord wrote:
> Some projects now use the 'branch' config value to record the tracking
> branch for the submodule.  Some ascribe different meaning to the
> configuration if the value is given vs. undefined.  For example, see
> the Gerrit submodule-subscription mechanism.  This change will cause
> those workflows to behave differently than they do now.
>
> I do like the idea, but I wish it had a different name for the
> recording.  Maybe --record-branch=3D${BRANCH} as an extra switch so the
> action is explicitly requested.

As I said, I'm happy to go back to --branch if opinions have changed.

On Wed, Nov 28, 2012 at 12:28:58AM +0100, Heiko Voigt wrote:
> On Tue, Nov 27, 2012 at 02:01:05PM -0500, W. Trevor King wrote:
> > On Tue, Nov 27, 2012 at 07:31:25PM +0100, Heiko Voigt wrote:
> > > > Because you need to recurse through submodules for `update --branch`
> > > > even if "$subsha1" =3D=3D "$sha1", I had to amend the conditional
> > > > controlling that block.  This broke one of the existing tests, whic=
h I
> > > > "fixed" in patch 4.  I think a proper fix would involve rewriting
> > > >=20
> > > >   (clear_local_git_env; cd "$sm_path" &&
> > > >    ( (rev=3D$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
> > > >     test -z "$rev") || git-fetch)) ||
> > > >   die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path=
'")"
> > > >=20
> > > > but I'm not familiar enough with rev-list to want to dig into that
> > > > yet.  If feedback for the earlier three patches is positive, I'll w=
ork
> > > > up a clean fix and resubmit.
> > >=20
> > > You probably need to separate your handling here. The comparison of t=
he
> > > currently checked out sha1 and the recorded sha1 is an optimization
> > > which skips unnecessary fetching in case the submodules commits are
> > > already correct. This code snippet checks whether the to be checked o=
ut
> > > sha1 is already local and also skips the fetch if it is. We should not
> > > break that.
> >=20
> > Agreed.  However, determining if the target $sha1 is local should have
> > nothing to do with the current checked out $subsha1.
>=20
> See my draft or the diff below for an illustration of the splitup.
>=20
> [snip diff]

This looks fine, but my current --branch implementation (which doesn't
pull) is only a thin branch-checkout layer on top of the standard
`update` functionality.  I'm still unsure if built-in pulls are worth
the configuration trouble.  I'll sleep on it.  Maybe I'll feel better
about them tomorrow ;).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQtXn7AAoJEEUbTsx0l5OMLEsP/jxQGnsZAUKZRRgugEFJVUzM
fK/8AH52hSgupHJ+Ua2h6tu703LU6Tkt2YdlC+yo9NgP088j8DKzCx3mc1lZZefR
M+HVnWM1wBLnAzQU18VdkqOMmnFzTlbU9qxXMQiFABh3Y69IvP6T7me17odFxD+n
Wr6wtLh6ePqplIBsOsxWCcoqPHdsvHlRsevHhKJrwc0hblRUxeiKJiJSWUaR4wM3
9s4Rah4/qgvlIlu2spmrdISevJDPPex8DhiILAkfzwYilDKptXh/LO9H/QVaJd1x
MChUVw5oSTxwWmcYuBE+yrPNZJw46TWZ5gEzXiEDrh6V+enE+3cE08T5beOEKfTT
Zag0lT1F0WM7Ek3TRhIKxfloZL8JjfesJ2msjMa3dqlbLSEX9CefoEj4Po3olgwb
9UZEVH2EDq65/bJs8lKbUkKb4OoIq+H24BBTBL7gZhiPIRGBhzxLr6jtgwc6mjBV
artoRTPcoCZsGxsO1Pd9X/gRtFHX0UzQ5xQ9GWbgeqkxF/+Jar+EsfYvVrMEgKw3
Rf2D6JDiE9Z/FmG6ysPPeKOAHeevhmI6Q4+ufdW/Bics+F9w4vzrefJjEqsO/AAL
Z5FclKUuIjtzUWvqqnozc+gZIoQgm8l8YE6/R4juqQnZcVNtMrPRdzXBN5aTeLrQ
bQ2j3ad4IHWVyMNcNpo3
=/K90
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--
