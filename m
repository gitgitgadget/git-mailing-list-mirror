From: Jeff King <peff@peff.net>
Subject: Re: Lockless Refs?  (Was [PATCH] refs: do not use cached refs in
 repack_without_ref)
Date: Sat, 29 Dec 2012 03:12:00 -0500
Message-ID: <20121229081200.GD15408@sigill.intra.peff.net>
References: <20121221080449.GA21741@sigill.intra.peff.net>
 <50DAB447.8000101@alum.mit.edu>
 <201212271611.52203.mfick@codeaurora.org>
 <201212280750.14695.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <sop@google.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Sat Dec 29 09:12:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TorWq-0002bj-Ts
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 09:12:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481Ab2L2IMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 03:12:06 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38629 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752350Ab2L2IMF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 03:12:05 -0500
Received: (qmail 27733 invoked by uid 107); 29 Dec 2012 08:13:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 29 Dec 2012 03:13:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Dec 2012 03:12:00 -0500
Content-Disposition: inline
In-Reply-To: <201212280750.14695.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212298>

On Fri, Dec 28, 2012 at 07:50:14AM -0700, Martin Fick wrote:

> Hmm, actually I believe that with a small modification to the 
> semantics described here it would be possible to make multi 
> repo/branch commits work.   Simply allow the ref filename to 
> be locked by a transaction by appending the transaction ID to 
> the filename.  So if transaction 123 wants to lock master 
> which points currently to abcde, then it will move 
> master/abcde to master/abcde_123.  If transaction 123 is 
> designed so that any process can commit/complete/abort it 
> without requiring any locks which can go stale, then this ref 
> lock will never go stale either (easy as long as it writes 
> all its proposed updates somewhere upfront and has atomic 
> semantics for starting, committing and aborting).  On commit, 
> the ref lock gets updated to its new value: master/newsha and 
> on abort it gets unlocked: master/abcde.

Hmm. I thought our goal was to avoid locks? Isn't this just locking by
another name?

I guess your point is to have no locks in the "normal" case, and have
locked transactions as an optional add-on?

-Peff
