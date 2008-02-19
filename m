From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] push: indicate partialness of error message
Date: Tue, 19 Feb 2008 16:54:41 -0500
Message-ID: <20080219215441.GA7778@coredump.intra.peff.net>
References: <20080219162501.GA30451@sigill.intra.peff.net> <7vablwiqa7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jason Garber <jgarber@ionzoft.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 22:55:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRaQr-0005KI-AY
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 22:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758220AbYBSVyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 16:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757236AbYBSVyp
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 16:54:45 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2370 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755983AbYBSVyo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 16:54:44 -0500
Received: (qmail 25624 invoked by uid 111); 19 Feb 2008 21:54:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 19 Feb 2008 16:54:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Feb 2008 16:54:41 -0500
Content-Disposition: inline
In-Reply-To: <7vablwiqa7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74462>

On Tue, Feb 19, 2008 at 01:34:40PM -0800, Junio C Hamano wrote:

> Distinguishing between [rejected] and [stale] would belong in
> 1.5.5 if it is really needed.  Together with the "git checkout
> notices forks" enhancement on Daniel's git-checkout rewritten in
> C, I think it would solve the issue in the "push [rejected]
> question".

I am still a little uncomfortable with the rejected/stale distinction,
because the semantics aren't clear.

Let's say we figure out which is which in send-pack. Do we:

  - simply change the "rejected" text to "stale, and leave as-is? I
    think that is safe, but I also think it isn't a significant
    improvement for workflows that leave lots of stale branches around
    (they clutter the push output).
  - omit stale listings when -v is not given?
    - this is dangerous with the patch I posted, because "git push; #
      oops, I forgot I amended; git push -f" will push stale branches
      that weren't even mentioned in the first case.
    - instead, should we require some extra magic to force stale
      branches to be pushed? Forcing such a push is almost never a good
      idea, whereas forked branches are not too uncommon.
    - instead, should we disallow "-f" without an explicit refspec (or
      --all, or --mirror, etc) I can't think of a workflow where you
      want to force _many_ branches at once, except the special case of
      mirroring.
    - we could also combine the two: don't respect -f on stale pushes,
      but do respect pushing "+stale"

Thoughts?

-Peff
