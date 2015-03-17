From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC] git submodule purge
Date: Tue, 17 Mar 2015 08:56:36 +0100
Message-ID: <20150317075636.GA354@pks-pc>
References: <20150316134407.GA31794@pks-tp.elego.de>
 <20150316200353.GB5186@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 08:57:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXmNI-0005uF-Cy
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 08:57:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbbCQH5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 03:57:12 -0400
Received: from sender1.zohomail.com ([74.201.84.155]:29638 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbbCQH5K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 03:57:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; 
  b=MK83Lxj00IJaYY5050Zc0DAPSV8LDnDjDv75cb5cQ7Ks8HORgLRl7eH9cfTIDc5xOEi3CQEBm9qA
    cdyPLqXB4zjZhfnxwI1/Dvm0pWWn/ij4lT/gcl4OTz73ZbNyzsrJPcaBsGax5E2cwPxuc8tCtxqY
    8m7msLQ/9yGtU0byZuU=  
Received: from localhost (g225000112.adsl.alicedsl.de [92.225.0.112]) by mx.zohomail.com
	with SMTPS id 1426579021759318.4133066607337; Tue, 17 Mar 2015 00:57:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150316200353.GB5186@google.com>
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265620>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2015 at 01:03:53PM -0700, Jonathan Nieder wrote:
> (+cc: Jens and Heiko, submodule experts)
> Hi,
>=20
> Patrick Steinhardt wrote:
>=20
> > This proposal is just for discussion. If there is any interest I
> > will implement the feature and send some patches.
> >
> > Currently it is hard to properly remove submodules. That is when
> > a submodule is deinitialized and removed from a repository the
> > directory '.git/modules/<SM_NAME>' will still be present and
> > there is no way to remove it despite manually calling `rm` on it.
> > I think there should be a command that is able to remove those
> > dangling repositories if the following conditions are met:
> >
> > - the submodule should not be initialized
> >
> > - the submodule should not have an entry in .gitmodules in the
> >   currently checked out revision
> >
> > - the submodule should not contain any commits that are not
> >   upstream
> >
> > - the submodule should not contain other submodules that do not
> >   meet those conditions
> >
> > This would ensure that it is hard to loose any commits that may
> > be of interest. In the case that the user knows what he is doing
> > we may provide a '--force' switch to override those checks.
>=20
> Those conditions look simultaneously too strong and too weak. ;-)
>=20
> In principle, it should be safe to remove .git/modules/<name> as
> long as
>=20
>  (1) it (and its submodules, sub-sub-modules, etc) doesn't have any
>      un-pushed local commits.
>=20
>  (2) it is not being referred to by a .git file in the work tree of
>      the parent repository.
>=20
> Condition (1) can be relaxed if the user knows what they are losing
> and is okay with that.  Condition (2) can be avoided by removing
> (de-initing) the copy of that submodule in the worktree at the same
> time.
>=20
> The functionality sounds like a useful thing to have, whether as an
> option to 'git submodule deinit' or as a new subcommand.  In the long
> term I would like it to be possible to do everything 'git submodule'
> can do using normal git commands instead of that specialized
> interface.  What command do you think this would eventually belong in?
> (An option to "git gc", maybe?)
>=20
> Thanks,
> Jonathan

Thanks for your feedback.

Considering that purging the submodule is tightly coupled with
de-initializing it, it might make sense to provide this
functionality as part of `git submodule deinit`. Maybe something
like `git submodule deinit --purge` would work for the user.
Problem is if the user first removes the submodule and does not
first deinitialize it he is not able to purge the repository
afterwards as deinit will complain about the submodule not being
matched anymore. We could just make `deinit --purge` work with
removed submodules, but that does not feel very natural to me.

`git gc` feels saner in that regard, but I don't think it would
be easy to spot for users as this command is in general not used
very frequently by them. One could argue though that it does not
need to be discoverable.

Regards
Patrick

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVB940AAoJEBF8Z7aeq/EsVcwP/i+xN64DVhmyXgGSWyTCHg5B
186GHrbwJKptdIEHoehetp9QWisicNFjz2GttsqDV7iLzHeUcgYqBwkJZ86mtiOP
SMQo1iq3F2UFchopuRtQm6gEQdA+OJ55PAUHU1hNmM6cbYIKi0OsT1jryonq34pv
jfM0RtA5ONWvT5VybYBLVSe52qloVoaOoGbld1DQUkQ+M03Bl270orSIuNAoprZc
1oa8ikQrnUzjBu50IPJXoMpptm8vNNKiu5u/UBot5NxFeuWJxu4wZb19oCHqWV4f
Rv9nOIzAW30/nVEhqJPrzozN92JvEKXBVAEmNpM50RSh7C7SHKtNbrYr1SbyKTQw
I2lef3RglNgovpQ+nf8lCRZiBDxUYXHhX9/BsCeQDpVY9cgrYR9MYzDECAdgMxDU
V531ays863W/D8IEl+grMEeTRVvbwvgWcQ5ByCxvjsw/bStkzKthma9OidQwY9xq
khZdHzO+xsa+oZPgev8EWl0vzl5Adb8gceWKoaeg83p1LiAo3xtNK3b6GkaDhFL0
doUIDuPh1730uQT38mjZitykg5pAA2I30BTNlipn/zVVB/FIVETgVsmc2p4xPcaG
YqBmND+7aALhj3VQVFChncpHxyXl7Trc/Mf5vp9JLY6pjhgR77vCqC1szPLosW1r
fwpcacxX+HOfyS+O04pn
=KiiG
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
