From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] teach sha1_name to look in graveyard reflogs
Date: Fri, 20 Jul 2012 11:53:41 -0400
Message-ID: <20120720155341.GD2862@sigill.intra.peff.net>
References: <20120719213225.GA20311@sigill.intra.peff.net>
 <20120719213326.GB20385@sigill.intra.peff.net>
 <7vtxx3tlyb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Alexey Muranov <alexey.muranov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 17:53:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsFWX-0008TS-FF
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 17:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242Ab2GTPxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 11:53:44 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56573 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753236Ab2GTPxn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 11:53:43 -0400
Received: (qmail 11962 invoked by uid 107); 20 Jul 2012 15:53:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 Jul 2012 11:53:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jul 2012 11:53:41 -0400
Content-Disposition: inline
In-Reply-To: <7vtxx3tlyb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201784>

On Thu, Jul 19, 2012 at 03:39:24PM -0700, Junio C Hamano wrote:

> > Similarly, for_each_reflog_ent learns to fallback to
> > graveyard refs, which allows the reflog walker to work.
> > However, this is slightly less friendly, as the revision
> > parser expects the matching ref to exist before it realizes
> > that we are interested in the reflog. Therefore you must use
> > "git log -g deleted@{1}" insted of "git log -g deleted" to
> > walk a deleted reflog.
> 
> This may or may not be related, but I vaguely recall that "log -g"
> traversal hack had a corner case where the walking stops prematurely
> upon seeing a gap (or creation/deletion that has 0{40})?  Do you
> recall if we have ever dealt with that?

>From my tests, I think it is probably still broken (if you do a delete,
create, delete sequence on a branch and then walk the reflog, it stops
prematurely at the 0{40} sha1).

But what _should_ it show for such an entry? There is no commit to show
in the reflog walker, but it would still be nice to say "BTW, there was
a deletion even here". Obviously just skipping it and showing the next
entry would be better than the current behavior of stopping the
traversal, but I feel like there must be some better behavior.

-Peff
