From: Jeff King <peff@peff.net>
Subject: Re: Feature: git stash pop --always-drop
Date: Mon, 10 Aug 2015 09:49:58 -0400
Message-ID: <20150810134957.GC6763@sigill.intra.peff.net>
References: <loom.20150810T124037-407@post.gmane.org>
 <20150810124125.GC32371@sigill.intra.peff.net>
 <loom.20150810T144849-152@post.gmane.org>
 <20150810133220.GA3559@sigill.intra.peff.net>
 <loom.20150810T153939-856@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 15:50:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOnSr-0000wV-Bh
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 15:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579AbbHJNuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 09:50:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:43007 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752379AbbHJNuD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 09:50:03 -0400
Received: (qmail 12698 invoked by uid 102); 10 Aug 2015 13:50:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 08:50:02 -0500
Received: (qmail 5540 invoked by uid 107); 10 Aug 2015 13:50:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 09:50:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 09:49:58 -0400
Content-Disposition: inline
In-Reply-To: <loom.20150810T153939-856@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275621>

On Mon, Aug 10, 2015 at 01:43:07PM +0000, Ed Avis wrote:

> Jeff King <peff <at> peff.net> writes:
> 
> >>An alternative would be for git stash to always print the name of the stash
> >>it is applying.
> 
> >  Applying refs/stash@{0} (31cb86c3d700d241e315d989f460e3e83f84fa19)
> 
> Yes, that's the one.
> 
> >Or maybe it would be useful to actually show the stash subject,
> 
> That could be nice to see, but is not a substitute for the SHA.

I think you'd be _technically_ OK without the sha1 in the "applying
message", because you can refer to it as stash@{0} until it is dropped,
and the drop message does mention the sha1. But that seems needlessly
complicated for the user. I agree that including the sha1 is reasonable
(though we might want to use an abbreviated one if there is other stuff
to go on the line).

> If the stash pop failed because of conflicts then it could even print
> 
>     To drop this stash manually, run 'git stash drop abcde...'

Yup, that makes sense. You might want to make it optional an advice.*
config key, though. I also wondered if the "dropped" message is
sufficiently clear to new users. The point of it, I think, is to allow a
final "oops, I didn't mean to do that" moment. But there are no
instructions for how one would re-create the same stash.

It might be that showing instructions on even successful drops would
quickly get annoying, though. I dunno. I tend to turn off most of our
advice config myself.

> Another feature I would like to see is a kind of atomic stash apply, where
> either the whole change can be applied to the working tree without conflicts,
> or nothing happens.

I think that may be a bit harder, as the merge machinery would have to
know how to be atomic. Still, I agree it's a good goal if you'd like to
work on it.

-Peff
