From: Jeff King <peff@peff.net>
Subject: Re: bug? in checkout with ambiguous refnames
Date: Fri, 7 Jan 2011 14:49:09 -0500
Message-ID: <20110107194909.GB6175@sigill.intra.peff.net>
References: <20110107104650.GA5399@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Fri Jan 07 20:49:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbIJK-0007JX-0C
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 20:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755290Ab1AGTtM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jan 2011 14:49:12 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:57877 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753094Ab1AGTtM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 14:49:12 -0500
Received: (qmail 17652 invoked by uid 111); 7 Jan 2011 19:49:11 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 07 Jan 2011 19:49:11 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jan 2011 14:49:09 -0500
Content-Disposition: inline
In-Reply-To: <20110107104650.GA5399@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164749>

On Fri, Jan 07, 2011 at 11:46:50AM +0100, Uwe Kleine-K=C3=B6nig wrote:

> 	ukl@octopus:~/gsrc/linux-2.6$ git diff; git diff --cached
>=20
> 	ukl@octopus:~/gsrc/linux-2.6$ git checkout sgu/mxs-amba-uart
> 	warning: refname 'sgu/mxs-amba-uart' is ambiguous.
> 	Previous HEAD position was c13fb17... Merge commit '65e29a85a419f9a1=
61ab0f09f9d69924e36d940e' into HEAD
> 	Switched to branch 'sgu/mxs-amba-uart'
>=20
> OK, it might be a bad idea to have this ambiguity, still ...
> [...]
> So working copy and cache are at refs/tags/sgu/mxs-amba-uart, HEAD
> points to refs/heads/sgu/mxs-amba-uart

Yeah, we generally resolve ambiguities in favor of the tag (and that
warning comes from deep within get_sha1_basic). So the real bug here is
that it still said "Switched to branch", which is totally wrong.

That being said, it probably would make more sense for "git checkout" t=
o
prefer branches to tags. That's probably going to take a lot more
surgery, and we're in -rc right now. So I think the best thing to do is
to fix the broken message and add some tests, and then if somebody want=
s
to revisit it with a larger patch, they can do so on top.

I'll work on the first part and post a patch in a few minutes.

-Peff
