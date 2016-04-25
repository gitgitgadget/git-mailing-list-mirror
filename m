From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] Ordering of remotes for fetch --all
Date: Mon, 25 Apr 2016 17:37:20 -0400
Message-ID: <20160425213720.GB11227@sigill.intra.peff.net>
References: <20160425211506.8421-1-mtzguido@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Guido =?utf-8?B?TWFydMOtbmV6?= <mtzguido@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 23:37:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auoCL-0007ho-9H
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 23:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965209AbcDYVhZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 17:37:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:56139 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964994AbcDYVhX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 17:37:23 -0400
Received: (qmail 9536 invoked by uid 102); 25 Apr 2016 21:37:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Apr 2016 17:37:22 -0400
Received: (qmail 6826 invoked by uid 107); 25 Apr 2016 21:37:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Apr 2016 17:37:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Apr 2016 17:37:20 -0400
Content-Disposition: inline
In-Reply-To: <20160425211506.8421-1-mtzguido@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292567>

On Mon, Apr 25, 2016 at 11:15:05PM +0200, Guido Mart=C3=ADnez wrote:

> I run a server with several git mirrors, that are updated every hour.=
 On
> that same server, users clone those projects and work on them. We use
> the local mirrors to reduce network load: the users can fetch from th=
e
> mirror first (to get most of the objects with zero network cost) and
> then fetch the real remote (to make sure they're completely up to dat=
e).
>=20
> I would like this to be configurable in each git working directory,
> so users can just configure the order they want and then just do "git
> remote update".
>=20
> I'm aware one can get this behavior by editing .git/config and
> ordering the remotes as one wishes, but I find that very hacky and no=
t
> scripting-friendly.

You can also define your own ordered groups, like:

  $ git config remotes.foo "one two three"
  $ git fetch foo 2>&1 | grep ^Fetching
  Fetching one
  Fetching two
  Fetching three

That's not _exactly_ the same, because you can't give a partial orderin=
g
of one high-priority remote and then say "all the rest, in whatever
order you want", because there's no way to say "all the rest".

You _can_ say:

  git config remotes.foo "high-priority --all"

but the final "--all" will fetch from high-priority again. An
alternative feature would be to teach remotes.* groups to cull
duplicates, if that's not acceptable.

I don't have a strong opinion against your approach, though. Just
exploring alternatives.

-Peff
