From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] add object-cache infrastructure
Date: Mon, 11 Jul 2011 20:03:04 -0400
Message-ID: <20110712000304.GA32276@sigill.intra.peff.net>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161754.GB10418@sigill.intra.peff.net>
 <7vliw4d1hu.fsf@alter.siamese.dyndns.org>
 <20110711220107.GC30155@sigill.intra.peff.net>
 <7vk4bo9ze5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 02:03:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgQRV-0005vn-QU
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 02:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462Ab1GLADI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 20:03:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35930
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753651Ab1GLADH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 20:03:07 -0400
Received: (qmail 6656 invoked by uid 107); 12 Jul 2011 00:03:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jul 2011 20:03:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jul 2011 20:03:04 -0400
Content-Disposition: inline
In-Reply-To: <7vk4bo9ze5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176910>

On Mon, Jul 11, 2011 at 04:21:54PM -0700, Junio C Hamano wrote:

> Actually I do not think identifying the ones that can safely skipped is
> such a big issue. The case I am most concerned about is when you see that
> "two reverted back to one" (which you obviously want to avoid, to keep the
> effect of the commit the upstream has to have "two" on that line), but at
> the same time when you do not agree with the change that the upstream took
> for the _current commit_ you are replaying (i.e. you want the final result
> to have "one", not "modified one" which the upstream has applied).

I'm not sure there's a general solution to that. You can't keep the
commit you want intact, because you are rebasing and therefore building
on top of the other broken commit. So in a history like:

    B'--C'
   /
  A--B--C

You really want to perform the transformation of B to B', but on top of
C (i.e., "git checkout C; git diff B' B | git apply"). But if B and C
are textually related, it's going to conflict horribly. And I don't
think there is a general solution short of a darcs-style patch algebra.

-Peff
