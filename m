From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Tue, 14 Feb 2012 13:52:33 -0500
Message-ID: <20120214185233.GA12072@sigill.intra.peff.net>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
 <201202131944.50886.jnareb@gmail.com>
 <20120213220917.4cf14eb1@gmail.com>
 <201202141831.59699.jnareb@gmail.com>
 <20120214192340.2d473866@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 19:52:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxNUc-0002fw-95
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 19:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758786Ab2BNSwm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 13:52:42 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35769
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754001Ab2BNSwl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 13:52:41 -0500
Received: (qmail 9128 invoked by uid 107); 14 Feb 2012 18:59:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Feb 2012 13:59:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2012 13:52:33 -0500
Content-Disposition: inline
In-Reply-To: <20120214192340.2d473866@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190733>

On Tue, Feb 14, 2012 at 07:23:40PM +0100, Micha=C5=82 Kiedrowicz wrote:

> > > > BTW GitHub is closed source, but we can check what algorithm do=
es Trac
> > > > use for diff refinement highlighting (highlighting changed port=
ions of
> > > > diff).
> > > >=20
> > > I think it's
> > > http://trac.edgewall.org/browser/trunk/trac/versioncontrol/diff.p=
y
> > > (see markup intraline_changes()).
> [...]
> [...]
> > The markup_intraline_changes() function compares lines from preimag=
e and
> > from postimage pairwise, requiring that number of lines matches, th=
e same
> > like in your algorithm.
>=20
> So using Jeff's diff-highlight we remain quite consistent with Trac
> output. There's nothing we can "steal" from it.

Neat. When I originally wrote diff-highlight, I was inspired by seeing
what Trac and GitHub did, but came up with the algorithm on my own.
Learning that Trac does the multiline thing (as we started doing with
recent patches) makes me feel even better that it's a good strategy.

As an aside, I looked at what GitHub does. It turns on highlighting onl=
y
for the single-line case, and does the same prefix/suffix thing.

It's really not very complex code; most of the hassle in diff-highlight
is ignoring (but preserving) embedded colors, so that we build on top o=
f
existing colorization. A web tool will be doing the line coloring itsel=
f
anyway, so it can be much simpler. Elsewhere, I suggested lib-ifying
diff-highlight for gitweb to use. But once you remove the embedded colo=
r
handling, there really is not that much code, and it's probably simpler
to just rewrite it.

-Peff
