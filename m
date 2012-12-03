From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v6 2/4] submodule update: add --remote for submodule's
 upstream changes
Date: Mon, 03 Dec 2012 13:15:19 -0500
Message-ID: <20121203181519.GC14981@odin.tremily.us>
References: <20121130032719.GE29257@odin.tremily.us>
 <cover.1354417618.git.wking@tremily.us>
 <ec5d0235322619aff6c1c64b0a346efb0e4d0a32.1354417618.git.wking@tremily.us>
 <7v8v9ft761.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=xesSdrSSBC0PokLI
Cc: Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 19:16:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfaYe-0004pi-Rb
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 19:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306Ab2LCSPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 13:15:39 -0500
Received: from vms173009pub.verizon.net ([206.46.173.9]:49819 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab2LCSPj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 13:15:39 -0500
Received: from odin.tremily.us ([unknown] [72.68.101.162])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MEG00L4MW1J0X40@vms173009.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 03 Dec 2012 12:15:21 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 29D9F6E54E6; Mon,
 03 Dec 2012 13:15:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354558519; bh=QrGovvN1nHsB/YE9HbIUHmqCvDT+GZn34Da9DD+uGRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VCmvz3HK2SujMtXLqVA/WS29zYmqcb9/gc2ryw6JBOG/GThlBQFbVW6gd49Sl7ryG
 TevONRCql2dEcYRdYfbYvfyG3xE0MOWDRRZCOVIvyWIcuJs/sjbaosCuMlH7QdwFYw
 f9B5v4axFa1WmfZNKZ5nvSI0bvTmB/lI6Qjmgoqc=
Content-disposition: inline
In-reply-to: <7v8v9ft761.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211048>


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2012 at 08:46:46AM -0800, Junio C Hamano wrote:
> As you hinted in the first paragraph, you could flip between merge,
> rebase, and detach with a command line option when running the
> "update" subcommand, but I would imagine that the expected use
> pattern is that for a particular project, you would choose one mode
> and consistently stick to that mode.  To make it easier, the user
> can set submodule.$name.update once and run "update" without having
> to give any flags.

Sure.

> And this is about adding another mode to the "update" subcommand
> where the HEAD is not detached, nor merged, nor rebased, but is set
> to follow whatever commit a remote branch points at.

This is about adding another suite of modes.  Currently you can
rebase/merge/checkout the superproject-recorded $sha1.  I'm adding the
ability to rebase/merge/checkout a submodule-upstream branch.  I
discuss this explicitly in Documentation/git-submodule.txt when
describing --remote.

> Shouldn't the patch add a way for the user to set a configuration
> variable to signal that this new mode is always used when "update"
> is run without a command line flag?

How about a new submodule.<name>.update-source with (which can be
either superproject-gitlink or submodule-upstream)?  Or to be a bit
simpler and less explicit, a submodule.<name>.update-remote boolean?
For lack of a better name, I'll call this submodule.<name>.<something>
below.

> As the user has to configure submodule.$name.branch in order to use
> this mode anyway, I have a feeling that taking that as a signal, and
> ignoring submodule.$name.update altogether, might be a simpler
> interface from the end user's point of view.  That is,

As I mention earlier, submodule.<name>.update is still important.  I
think it's good to add a new submodule.<name>.<something> config and a
--no-remote option (to override a configured
submodule.<name>.<something>).  This way a user that generally updates
via the superproject's gitlink can still configure a branch to update
=66rom when they use --remote.

>  (1) if you are not interested in the submodule $name, you do not
>      "init" it; you "init" it for all of the following.
>=20
>  (2) if you want to have the tree state as recorded in the
>      superproject, you do "update" without any option to make the
>      HEAD of the submodule detached at the commit the superproject's
>      tree records;
>=20
>  (3) if you want to follow the upstream project of the submodule,
>      you set submodule.$name.branch to the branch you want to
>      follow, and you do "update"---submodule.$name.update is ignored
>      and you will make the HEAD of the submodule detached at the tip
>      of the branch at the remote (using remote-tracking branch);
>=20
>  (4) if you want to --merge or --rebase, you give them from the
>      command line, or use submodule.$name.update.

But what if your whant to merge the upstream project into a currently
checked out submodule branch?  Or rebase a currently detached head
against the upstream branch?

> I may be oversimplifying a bit, but a separate
> submodule.$name.remote feels very wrong;

I use submodule.<name>.remote in patch 4 to specify the name of the
superproject's remote (for when get_default_remote doesn't give the
value you want), but I think you're referring to the potential
submodule.<name>.<something> and the presense of the --remote option.

> How does this compare with the floating submodules Heiko has been
> working on?

Heiko's older hv/floating_submodules also uses submodule.<name>.branch
(with a similar interpretation).  There's also a --branch option to
`update` for command-line overrides (which I don't have, perhaps I
should add them?).  He reverts to the original behavior in the
presense of submodule.<name>.branch with `update --checkout`, or when
submodule.<name>.branch=3DHEAD.

He also fetches all remotes, while I fetch just the explicitly
configured submodule.<name>.remote falling back on
$(get_default_remote.  His submodule.<name>.branch is the full local
ref for the branch (e.g. 'origin/master'), while mine is just the
remote branch (e.g. 'master').  I split the remote (e.g. 'origin')
into submodule.<name>.remote in patch 4 so you can explicitly fetch
just that remote (and not all the remotes you may have configured for
that submodule).

For reasons that I don't understand, he only supports the `checkout`
update logic for remote branches.

Heiko's newer hv/floating_submodules_draft builds on my earlier v4
--local-branch option, but he uses his own processing logic.  He pulls
the existing 'update to $sha1' logic out into a new
handle_on_demand_update() and uses the stored submodule.<name>.branch
as the name of a local submodule branch to check out when tracking.
Then he pulls that local branches default upstream (configured in
=2Egit/modules/<name>/config) with --ff-only.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQvOw0AAoJEEUbTsx0l5OMWFoP/j6uYWbjnBBYYVFsXkxkyj9f
c+1FTh0A8PxhRAISzymIv/aHLMr08swbsfpyIYd5/h0gEYoDneccnCMk1b7MIs4L
KK520QMH+TxMXivNeSG9+/p3RiUGwi/eLKLf0218DVMTtHMe4Xb7ZiZjkEucv55h
gSTXpi+D79RW55GErw5rdDAajhZDFi3Ae8U/uNCo2yIm9I3kKqwmygqNIQK25rr4
GqMGLSNYpNZaeW/34sXYq+ZBjgfp8Z9v/KRGd9pY4esnUlJsITNV+PwgcUrzITrs
vKMJkKaha8yZTqm/dIMiqyi0+TyWjtNAQN0iC/83y5VKZDVQdVdkrsgl/4lS65V+
3XlCz57Ft/byYkvqYnFev7QTku4kemnW6nSlO/cc04/10KVzR1VE99RLoeRVC0kH
fRbW8/fJkK/srDZz+slupXdJBaUSbCDs9WKcnySige5CMFKgu/KJS52cV9TjX0k3
h7f/thxK1Dh66WcOkSg/qObhUOyex4rfuOwMeSvhZhxU/0KQZKgq/2e8LF5rh463
nPNDvzNhvc39UR4QaxJaUaNM+8CBUmCd8oTx8zUFTOZ9sr18lcAkQuT1OVfDxhah
1kpYvNnb9bsql+r+derAKMog5EvKNKMwQsSbH8qqRUzqX1htPYJ1UAwNfCLdR2Fh
ZdLll3V88GfuD+vpiQUE
=YjEQ
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
