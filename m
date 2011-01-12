From: Jeff King <peff@peff.net>
Subject: Re: bug? in checkout with ambiguous refnames
Date: Wed, 12 Jan 2011 12:46:00 -0500
Message-ID: <20110112174600.GB31747@sigill.intra.peff.net>
References: <20110107104650.GA5399@pengutronix.de>
 <20110107194909.GB6175@sigill.intra.peff.net>
 <20110112091130.GC24920@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Jan 12 18:46:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pd4lv-0000Ao-74
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 18:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205Ab1ALRqG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jan 2011 12:46:06 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:44474 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753723Ab1ALRqF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 12:46:05 -0500
Received: (qmail 22536 invoked by uid 111); 12 Jan 2011 17:46:01 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 12 Jan 2011 17:46:01 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jan 2011 12:46:00 -0500
Content-Disposition: inline
In-Reply-To: <20110112091130.GC24920@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165021>

On Wed, Jan 12, 2011 at 10:11:30AM +0100, Uwe Kleine-K=C3=B6nig wrote:

> > > So working copy and cache are at refs/tags/sgu/mxs-amba-uart, HEA=
D
> > > points to refs/heads/sgu/mxs-amba-uart
> >=20
> > Yeah, we generally resolve ambiguities in favor of the tag (and tha=
t
> > warning comes from deep within get_sha1_basic). So the real bug her=
e is
> > that it still said "Switched to branch", which is totally wrong.
> I wonder how I can resolve the ambiguity when calling checkout.  (Wel=
l
> apart from changing either branch name or tag name)
>=20
> git checkout refs/heads/sgu/mxs-amba-uart results in a detached HEAD.

You can't disambiguate to the branch without going to a detached HEAD i=
n
the current code; it's just broken[1].

With the patch here:

  http://article.gmane.org/gmane.comp.version-control.git/164986

it will disambiguate to the branch by default, and if you want the tag,
you can do:

  git checkout tags/sgu/mxs-amba-uart

-Peff

[1]: You can't do it with checkout, that is. You can still hack around
     it with:

        branch=3Drefs/heads/sgu/mxs-amba-uart
        git read-tree -m -u $branch &&
        git symbolic-ref HEAD $branch

     which is a simplified version of what checkout is doing.
