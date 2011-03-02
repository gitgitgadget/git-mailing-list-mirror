From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Feb 2011, #06; Sun, 27)
Date: Wed, 2 Mar 2011 16:27:24 -0500
Message-ID: <20110302212724.GE20400@sigill.intra.peff.net>
References: <7vy650k62n.fsf@alter.siamese.dyndns.org>
 <AANLkTikW1GVzFoq=zUxvi7MTcUYBLO6fbjJPVZziLUk8@mail.gmail.com>
 <7v7hckje4n.fsf@alter.siamese.dyndns.org>
 <20110301205424.GA18793@sigill.intra.peff.net>
 <7vlj0yff6m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 22:27:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Puta3-0004u3-NH
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 22:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755535Ab1CBV1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 16:27:30 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:34443 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754281Ab1CBV13 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 16:27:29 -0500
Received: (qmail 20601 invoked by uid 111); 2 Mar 2011 21:27:26 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 02 Mar 2011 21:27:26 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Mar 2011 16:27:24 -0500
Content-Disposition: inline
In-Reply-To: <7vlj0yff6m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168346>

On Tue, Mar 01, 2011 at 06:07:29PM -0800, Junio C Hamano wrote:

> > On Mon, Feb 28, 2011 at 08:52:08AM -0800, Junio C Hamano wrote:
> >
> >> I am not convinced that this patch nailed that balance at exactly the
> >> right place, even though I think we are getting closer than before.  In
> >> this sequence:
> >> 
> >>     $ git checkout somewhere^0
> >>     $ git commit
> >>     $ git reset --hard somewhere_else
> >>     $ git commit
> >>     $ git checkout master
> >> ...
> > I really wouldn't expect it to help here. The problem isn't that you're
> > on a detached HEAD. It's that you're using "git reset" at all.
> 
> As you would realize later in your message, the "reset --hard" can instead
> be "checkout v1.7.3".  And the bothersome thing is that there is no safety
> against that.  We don't bother users while they are jumping around on
> detached HEAD, and it is not new; we don't say where the previous detached
> HEAD was.

No, "checkout v1.7.3" should engage the safety valve. And in your patch,
it does. So replacing your reset --hard with checkout _is_ safe. And I
think that behavior is reasonable. Reset's purpose is about shifting
HEAD to drop history, whether you are on a detached HEAD or not. Having
it warn would be annoying and pointless.

Checkout, on the other hand, is about moving your working tree to a
different place in history, and we _should_ warn about dropping history.
So it is really just a matter of educating users to use the appropriate
tool for sight-seeing (and I don't think there is much education to be
done; checkout seems like the obvious choice given it is how you got to
the first commit).

-Peff
