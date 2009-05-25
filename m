From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] am: do not do any reset on --abort
Date: Mon, 25 May 2009 08:00:19 -0400
Message-ID: <20090525120019.GA1740@coredump.intra.peff.net>
References: <20090525104308.GA26775@coredump.intra.peff.net> <alpine.DEB.1.00.0905251348050.4288@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 25 14:00:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Yr0-0002zl-9Z
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 14:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbZEYMAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 08:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbZEYMAV
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 08:00:21 -0400
Received: from peff.net ([208.65.91.99]:55811 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbZEYMAV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 08:00:21 -0400
Received: (qmail 4260 invoked by uid 107); 25 May 2009 12:00:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 25 May 2009 08:00:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 25 May 2009 08:00:19 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0905251348050.4288@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119928>

On Mon, May 25, 2009 at 01:49:18PM +0200, Johannes Schindelin wrote:

> > We really have no idea what state the tree is in at this
> > point, and whether the user might have done useful work on
> > top of it. So let's err on the side of keeping the user's
> > data intact.
> > 
> > The downside is that if they do have cruft to get rid of, or
> > want to pretend as if earlier parts of the series that were
> > applied did not exist, they must manually "git reset --hard"
> > now.
> 
> Hmm.  I think I would revert that patch after merging git.git right away.

You know, you can just say you don't like it. ;)

> Can you at least check for a dirty tree and reset --hard if it is clean?

No, that would defeat the purpose. The problem is that we have no idea
what has happened since the initial "git am". The user may have made
commits they want to keep, and we don't want to reset those away. They
may even have pulled, which means ORIG_HEAD can no longer be trusted for
a reset.

> In the other case, you could still say "you seem to have modifications, 
> bla bla bla"...

I think you raise a good point here. If we do decide to stop doing the
reset automatically, it is probably better not to simply stop doing it
(as my patch does), but to downgrade it to a warning ("You probably want
to reset, etc...").

-Peff
