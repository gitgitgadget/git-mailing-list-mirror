From: Jeff King <peff@peff.net>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Wed, 19 Dec 2012 08:06:32 -0500
Message-ID: <20121219130632.GA7134@sigill.intra.peff.net>
References: <20121217114058.449cbc3c@chalon.bertin.fr>
 <CAP8UFD2pkotNy=t5wTxDH-pMivQsTz-kw2y8Y7rWY42YKabp7g@mail.gmail.com>
 <m21ueo78f8.fsf@igel.home>
 <7vwqwgjs8f.fsf@alter.siamese.dyndns.org>
 <20121218120058.0c558ba5@chalon.bertin.fr>
 <50D05BAF.4000200@viscovery.net>
 <871uentthz.fsf@pctrast.inf.ethz.ch>
 <20121218144157.00ccd915@chalon.bertin.fr>
 <20121218162402.GA20122@sigill.intra.peff.net>
 <50D16911.10000@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yann Dirson <dirson@bertin.fr>, Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Christian Couder <christian.couder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	git list <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Dec 19 14:07:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlJMX-0001xT-1Y
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 14:07:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302Ab2LSNGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 08:06:45 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58417 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751430Ab2LSNGn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 08:06:43 -0500
Received: (qmail 28492 invoked by uid 107); 19 Dec 2012 13:07:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Dec 2012 08:07:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2012 08:06:32 -0500
Content-Disposition: inline
In-Reply-To: <50D16911.10000@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211817>

On Wed, Dec 19, 2012 at 08:13:21AM +0100, Johannes Sixt wrote:

> Am 12/18/2012 17:24, schrieb Jeff King:
> > I am not really interested in pushing this forward myself, but I worked
> > up this toy that somebody might find interesting (you can "git replace
> > HEAD~20" to get dumped in an editor). It should probably handle trees,
> > and it would probably make sense to do per-object-type sanity checks
> > (e.g., call verify_tag on tags).
> 
> I know it's just a throw-away patch, but I would discourage to go this
> route without also adding all the sanity checks. Otherwise, it will have
> just created a porcelain command that can generate a commit object with
> any content you want!

I think I agree with you that it would not be worth doing without sanity
checks. I am not sure if your "any content you want" statement means
"bad people can easily make bogus objects" or "it is too easy to make
arbitrary mistakes, putting your repo in a bogus state".

I would agree that the latter is compelling, but not the former.  You
can already easily generate a commit with any content you want via
"hash-object -t commit", and I have frequently done this while testing
corner cases of fsck, how git behaves when given buggy data, etc. So to
me it is not about preventing intentional abuse, but about not promoting
a feature that makes it too easy to screw up.

-Peff
