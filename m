From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] git fetch -p -t prunes all non-tag refs
Date: Tue, 4 Oct 2011 06:36:24 -0400
Message-ID: <20111004103624.GA11863@sigill.intra.peff.net>
References: <20110926184739.GA11745@erythro.kitwarein.com>
 <7vehz30wdy.fsf@alter.siamese.dyndns.org>
 <1317078667.5579.13.camel@centaur.lab.cmartin.tk>
 <7v1uv228t4.fsf@alter.siamese.dyndns.org>
 <1317079692.5579.19.camel@centaur.lab.cmartin.tk>
 <20110927033134.GB8534@sigill.intra.peff.net>
 <1317724404.2577.6.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, mathstuf@gmail.com,
	git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Oct 04 12:36:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB2MS-0005OK-5w
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 12:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756016Ab1JDKg1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Oct 2011 06:36:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52094
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755960Ab1JDKg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 06:36:27 -0400
Received: (qmail 7156 invoked by uid 107); 4 Oct 2011 10:41:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Oct 2011 06:41:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2011 06:36:24 -0400
Content-Disposition: inline
In-Reply-To: <1317724404.2577.6.camel@bee.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182756>

On Tue, Oct 04, 2011 at 12:33:22PM +0200, Carlos Mart=C3=ADn Nieto wrot=
e:

> > The latter. If I say:
> >=20
> >   git fetch --prune origin refs/heads/master:refs/remotes/origin/ma=
ster
> >=20
> > and refs/heads/master doesn't exist on the remote, I would expect
> > refs/remotes/origin/master to be deleted locally. And that naturall=
y
> > extends to:
> >=20
> >   git fetch --prune origin refs/heads/*:refs/remotes/origin/*
>=20
> I have some code locally that solves this second part. If we are give=
n
> refspecs on the command-line, it will try to match against that inste=
ad
> of blindly trusting what get_stale_heads tells us. I'm looking into
> putting the logic into get_stale_heads so that we can trust it.
>=20
> The first part might be more complicated. If the remote head doesn't
> exist, get_fetch_map dies. It does take a missing_ok flag, so it migh=
t
> be as easy as passing 1 there; but I'm not sure what that would do fo=
r a
> non-prune fetch.

Let's not worry about the first one for now, then. It is a natural
extension of the other, but in practice, I don't expect people to reall=
y
care that much about auto-pruning one specific ref. Instead, they want
to prune wildcards. So as long as it works in the wildcard case, that i=
s
a good start.

> >       # backup to a repository where our objects will be shared
> >       # with other related backups. So we must only use our slice o=
f the
> >       # ref namespace.
> >       git push --mirror backup-repo +refs/*:refs/`hostname`/*
>=20
> Is --mirror needed there? I would have thought that
> refs/*:refs/`hostname`/* would do the same by itself.

I wanted it to auto-prune the remote branches. So if I delete
"refs/heads/foo" locally, then it will be deleted from the backup on th=
e
next push. Regular "push" will not do that, but --mirror will.

-Peff
