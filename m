From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] handle concurrent pruning of packed objects
Date: Fri, 2 Jun 2006 12:04:56 -0400
Message-ID: <20060602160456.GA8957@coredump.intra.peff.net>
References: <20060602153223.GA4223@coredump.intra.peff.net> <7vwtbzblkf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 18:05:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmC8y-0000IL-Oc
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 18:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWFBQE6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 12:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWFBQE6
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 12:04:58 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1503 "HELO
	peff.net") by vger.kernel.org with SMTP id S932495AbWFBQE6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jun 2006 12:04:58 -0400
Received: (qmail 31376 invoked from network); 2 Jun 2006 12:04:56 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 2 Jun 2006 12:04:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri,  2 Jun 2006 12:04:56 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vwtbzblkf.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21168>

On Fri, Jun 02, 2006 at 08:53:52AM -0700, Junio C Hamano wrote:

> I am uncertain about not re-examining the packs it originally
> thought it had.  By prepending the new ones (and the same old
> surviving ones) at the beginning you are effectively hiding the
> old packs, which sounds reasonable in the usual case.

That shouldn't make a difference for correctness, even if the old packs
are still there. If you have an object in two packs, then it doesn't
matter which one you pull it from. The main impacts I can think of are:
  1. The old pack may already be mapped, and it would be more efficient
     to use it. However, the new pack will be mapped on first use, so it
     will be used from then on.
  2. The pack list can grow without bound. However, for this to matter,
     you'd have to do many prunes during the course of a single git
     command.

> Also I suspect this might have funny interaction with the case
> where there are hand-added packs (see how verify-pack does it).
> We do not silently "fix" missing object problems we discover
> there.

I will take a look at this.

-Peff
