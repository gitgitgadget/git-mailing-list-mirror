From: Jeff King <peff@peff.net>
Subject: Re: upgrading GIT from version 1.7.0.4 to 1.7.6.1.
Date: Mon, 19 Sep 2011 15:00:23 -0400
Message-ID: <20110919190023.GC26115@sigill.intra.peff.net>
References: <1316435430491-6808156.post@n2.nabble.com>
 <4E773A71.6020905@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Mika=C3=ABl?= <mikael.donini@gmail.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Sep 19 21:00:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5j4x-0002eO-EA
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 21:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459Ab1ISTA0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Sep 2011 15:00:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37520
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756349Ab1ISTAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 15:00:25 -0400
Received: (qmail 7930 invoked by uid 107); 19 Sep 2011 19:05:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Sep 2011 15:05:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Sep 2011 15:00:23 -0400
Content-Disposition: inline
In-Reply-To: <4E773A71.6020905@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181690>

On Mon, Sep 19, 2011 at 02:49:53PM +0200, Andreas Ericsson wrote:

> On 09/19/2011 02:30 PM, Mika=C3=ABl wrote:
> >=20
> > 1- Is it possible to have two GIT installations pointing on the sam=
e=20
> > repositories?
> >=20
>=20
> The core structure and layout of a git repository hasn't changed
> since may 2005, so it should work just fine provided you use any
> git version that actually has a version number.
>=20
> We've upgraded in a hodge-podge fashion at $dayjob. One of our
> servers is still running 1.4.something. We've never even come close
> to anything resembling a problem. It's actually a bit weird, since
> we started using git in late 2005 and it's so far been the most
> reliable and backwards-compatible piece of software we have in the
> company pretty much ever since.

This is not completely true. Any two versions should be able to
interoperate over the network using the git:// protocol. However, the
disk format has changed slightly over time.

Since v1.6.0 (August 2008), git defaults to using delta base offsets in
packfiles and version 2 of the pack index format. These features are no=
t
understood by versions before v1.5.2 (May 2007) or v1.4.4.5 (July 2008)=
=2E
A very old git accessing those repositories directly on disk (or by a
dumb protocol like rsync or non-smart http) would have problems[1].

So it has happened[2], but it's important to note that:

  1. We waited a year to flip the default for the code supporting it to
     become more pervasive.

  2. The switch happened on a major version boundary (1.5 -> 1.6),
     was already supported by versions in the prior major series (1.5),
     and we released a maintenance version for the series before that
     (1.4.4.x).

  3. The change, along with the affected versions, was mentioned
     prominently in the 1.6.0 release notes.

So no, I wouldn't expect any disk format issues moving from v1.7.0.4 to
v1.7.6.1. But it never hurts to read the release notes if you're unsure=
=2E

-Peff

[1] I do very occasionally run into this while bisecting some ancient
    code on a modern repository.

[2] I suspect a similar thing happened with turning on packed refs
    (around the v1.4.4 era?), but I didn't dig around for details.
