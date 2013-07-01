From: Miklos Vajna <vmiklos@suse.cz>
Subject: Re: [PATCH] merge: allow using --no-ff and --ff-only at the same time
Date: Mon, 1 Jul 2013 17:27:30 +0200
Message-ID: <20130701152730.GH17269@suse.cz>
References: <20130701070143.GB17269@suse.cz>
 <51D197AD.1070502@alum.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VkqCAaSJIySsbD6j"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 01 17:27:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utg10-0001jm-9s
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 17:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651Ab3GAP1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 11:27:38 -0400
Received: from cantor2.suse.de ([195.135.220.15]:35083 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752812Ab3GAP1h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 11:27:37 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 76D12A5211;
	Mon,  1 Jul 2013 17:27:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51D197AD.1070502@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229301>


--VkqCAaSJIySsbD6j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Mon, Jul 01, 2013 at 04:52:29PM +0200, Michael Haggerty <mhagger@alum.mi=
t.edu> wrote:
> On 07/01/2013 09:01 AM, Miklos Vajna wrote:
> > 1347483 (Teach 'git merge' and 'git pull' the option --ff-only,
> > 2009-10-29) says this is not allowed, as they contradict each other.
> >=20
> > However, --ff-only is about asserting the input of the merge, and
> > --no-ff is about instructing merge to always create a merge commit, i.e.
> > it makes sense to use these options together in some workflow, e.g. when
> > branches are integrated by rebasing then merging, and the maintainer
> > wants to be sure the branch is rebased.
>=20
> That is one interpretation of what these options should mean, and I
> agree that it is one way of reading the manpage (which says
>=20
> --ff-only::
> 	Refuse to merge and exit with a non-zero status unless the
> 	current `HEAD` is already up-to-date or the merge can be
> 	resolved as a fast-forward.
>=20
> ).  However, I don't think that the manpage unambiguously demands this
> interpretation, and that (more importantly) most users would be very
> surprised if --ff-only and --no-ff were not opposites.

Yes, I agree that that's an unfortunate naming. --ff and --no-ff is the
opposite of each other, however --ff-only is independent, and I would
even rename it to something like --ff-input-only -- but I don't think
it's worth to do so, seeing the cost of it (probably these options are
used by scripts as well).

> How does it hurt?  If I have configuration value merge.ff set to "only"
> and run "git merge --no-ff" and then I merge a branch that *cannot* be
> fast forwarded, the logic of your patch would require the merge to be
> rejected, no?  But I think it is more plausible to expect that the
> command line option takes precedence.

Hmm, I did not remember that actually merge.ff even uses the same
configuration slot for these switches. :-( Yes, that would make sense to
fix, once the switches can be combined. Maybe merge.ff and
merge.ff-only?

> In my opinion, your use case shouldn't be supported by the command
> because (1) it is confusing,

I don't see why it would be confusing. I think using these two options
together is one way to try to get the benefits of both rebase (cleaner
history) and merge (keeping the history of which commits came from a
given merge).

> (2) it is not very common,

Hard to argue that argument. :-) No idea what counts as common, my
motivation is that some projects (e.g. syslog-ng) integrate *every*
feature branch this way, and doing this "manually" (as in indeed
manually or by using a helper script) seems suboptimal, when the support
for this is already mostly in merge.c, just disabled.

> easy to work around:
>=20
>     if git merge-base --is-ancestor HEAD $branch
>     then
>         git merge --no-ff $branch
>     else
>         echo "fatal: Not possible to fast-forward, aborting."
>         exit 1
>     fi

Right, that's indeed a viable workaround for the problem.

Miklos

--VkqCAaSJIySsbD6j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlHRn+IACgkQe81tAgORUJag5gCglXAyCkQk45MSsaR7iviKhYxJ
HIEAn3YmqdkNehXBZhAkzKW5WU8npmEp
=8haY
-----END PGP SIGNATURE-----

--VkqCAaSJIySsbD6j--
