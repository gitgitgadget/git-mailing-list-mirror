From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] git-prompt: do not look for refs/stash in $GIT_DIR
Date: Mon, 25 Aug 2014 08:46:31 -0400
Message-ID: <20140825124631.GC17288@peff.net>
References: <E1XLXkh-0002sL-IJ@iramx2.ira.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>
To: =?utf-8?B?R8OhYm9y?= Szeder <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Aug 25 14:46:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLtfR-0000kT-L5
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 14:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596AbaHYMqd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Aug 2014 08:46:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:58376 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753406AbaHYMqd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 08:46:33 -0400
Received: (qmail 10045 invoked by uid 102); 25 Aug 2014 12:46:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Aug 2014 07:46:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Aug 2014 08:46:31 -0400
Content-Disposition: inline
In-Reply-To: <E1XLXkh-0002sL-IJ@iramx2.ira.uni-karlsruhe.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255822>

On Sun, Aug 24, 2014 at 08:22:41PM +0700, G=C3=A1bor Szeder wrote:

> On Aug 23, 2014 12:26 PM, Jeff King <peff@peff.net> wrote:
> > Since dd0b72c (bash prompt: use bash builtins to check stash=20
> > state, 2011-04-01), git-prompt checks whether we have a=20
> > stash by looking for $GIT_DIR/refs/stash. Generally external=20
> > programs should never do this, because they would miss=20
> > packed-refs.
>=20
> Not sure whether the prompt script is external program or not, but
> doesn't matter, this is the right thing to do.

Yeah, by external I just meant "nothing outside of refs.c should make
this assumption".

> > That commit claims that packed-refs does not pack=20
> > refs/stash, but that is not quite true. It does pack the=20
> > ref, but due to a bug, fails to prune the ref. When we fix=20
> > that bug, we would want to be doing the right thing here.=20
> >
> > Signed-off-by: Jeff King <peff@peff.net>=20
> > ---=20
> > I know we are pretty sensitive to forks in the prompt code (after a=
ll,=20
> > that was the point of dd0b72c). This patch is essentially a reversi=
on of=20
> > this hunk of dd0b72c, and is definitely safe.
>=20
> I'm not sure, but if I remember correctly (don't have the means to
> check it at the moment, sorry) in that commit I also added a 'git
> pack-ref' invocation to the relevant test(s?) to guard us against
> breakages due to changes in 'git pack-refs'.=C2=A0 If that is so, the=
n I
> think those invocations should be removed as well, as they'll become
> useless.

It did add that change (that's actually how I noticed the problem!
Thank you for being thorough in dd0b72c). My inclination is to leave th=
e
pack-refs invocations, as they protect against a certain class of error=
s
(we are not doing the risky behavior now, but the purpose of the test
suite is to detect regressions; the next person to touch that code may
not be so careful as you were).

I don't feel too strongly, though, so if we want them gone, I'm OK with
that.

-Peff
