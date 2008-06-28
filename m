From: Jeff King <peff@peff.net>
Subject: Re: bug related to branches using / in name
Date: Sat, 28 Jun 2008 00:18:41 -0400
Message-ID: <20080628041841.GA9451@sigill.intra.peff.net>
References: <1214509350.28344.31.camel@odie.local> <20080627030245.GA7144@sigill.intra.peff.net> <20080627035747.GC7144@sigill.intra.peff.net> <7vtzfemp4d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Simon Holm =?utf-8?Q?Th=C3=B8gersen?= <odie@cs.aau.dk>,
	git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 06:19:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCRuY-0007XK-VR
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 06:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbYF1ESq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 00:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbYF1ESp
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 00:18:45 -0400
Received: from peff.net ([208.65.91.99]:3223 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbYF1ESp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 00:18:45 -0400
Received: (qmail 8419 invoked by uid 111); 28 Jun 2008 04:18:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 28 Jun 2008 00:18:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Jun 2008 00:18:41 -0400
Content-Disposition: inline
In-Reply-To: <7vtzfemp4d.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86699>

On Fri, Jun 27, 2008 at 04:31:30PM -0700, Junio C Hamano wrote:

> >> It might be nicer if this were handled automatically, but it would
> >> violate git-fetch's rule about never deleting branches.
> 
> Hmm.  Is there actually such a rule?

I thought so, though I don't necessarily agree with it. But I seem to
recall this being touted as a feature in the past; a remote deleting
some work will not cause it to be deleted locally.

> I was wondering if it might make more sense to do the equivalent of what
> checkout_entry() does (i.e. remove_subtree()) when there is such a

As as long your "equivalent of" means "branch -d"; we need to kill off
both the ref and its reflogs. And therefore...

> conflict.  After all, tracking branches are meant to accept rewinds and
> anything that happens on the remote end, and having to run "git remote
> prune" is not a feature but is a lack of feature in the "git fetch", which
> may make it look like deletion is somewhat special.

The one key difference between rewinds and branch deletion is that the
latter will kill off the reflog, making the history inaccessible. You
can always still access rewound or rebased work via the reflog.

If we don't care about this "safety feature", then I definitely agree
that we should fix the problem rather than hint to the user.

-Peff
