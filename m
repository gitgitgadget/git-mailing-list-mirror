From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] grep: obey --textconv for the case rev:path
Date: Sat, 20 Apr 2013 23:41:52 -0400
Message-ID: <20130421034152.GB18890@sigill.intra.peff.net>
References: <cover.1366389739.git.git@drmicha.warpmail.net>
 <717ec305e9bd056a44b1da5cc478d314db2920e5.1366389739.git.git@drmicha.warpmail.net>
 <20130420042445.GD24970@sigill.intra.peff.net>
 <5172A969.9000106@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Apr 21 05:42:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTlA8-0004F1-CI
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 05:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665Ab3DUDlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 23:41:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:45265 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573Ab3DUDly (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 23:41:54 -0400
Received: (qmail 6476 invoked by uid 102); 21 Apr 2013 03:42:01 -0000
Received: from 99-108-225-125.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.225.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 20 Apr 2013 22:42:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Apr 2013 23:41:52 -0400
Content-Disposition: inline
In-Reply-To: <5172A969.9000106@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221888>

On Sat, Apr 20, 2013 at 04:42:49PM +0200, Michael J Gruber wrote:

> > And this mass of almost-the-same functions is gross, too, especially
> > given that the object_context contains a mode itself.
> 
> Well, it's just providing different ways to call into the one and only
> function, in order to satisfy different callers' needs. It's not unheard
> of (or rather: unseen) in our code, is it?

No, we have instances of it already. And they're ugly, too. :) I think
when we hit more than 2 or 3 wrappers it is time to start thinking
whether they can be consolidated.  I think it is mostly the overlap in
context and mode that makes me find this one particularly ugly. But it's
probably not solvable without some pretty heavy refactoring.

> I vaguely seem to recall we had some more general framework cooking but
> I may be wrong (I was offline due to sickness for a while). It was about
> attaching some additional info to something. Yes, I said "vaguely" ...

Yeah, I really wanted to keep the context inside the object_array, but
it means either wasting a lot of space (due to over-large buffers) or
having the array elements be variable-sized (with a flex-array for the
pathname). And object_array entries already have a memory-leak problem
from the "name" field, which I think we just punt on elsewhere. So I
think this is probably the lesser of the possible evils.

-Peff
