From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] short syntaxes for 'git stash'
Date: Tue, 18 Aug 2009 19:31:53 -0400
Message-ID: <20090818233153.GA6304@sigill.intra.peff.net>
References: <7vbpmcc1sc.fsf@alter.siamese.dyndns.org>
 <1250631523-10524-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 19 01:32:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdY9s-000541-4q
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 01:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbZHRXbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 19:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbZHRXbz
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 19:31:55 -0400
Received: from peff.net ([208.65.91.99]:52512 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152AbZHRXby (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 19:31:54 -0400
Received: (qmail 16271 invoked by uid 107); 18 Aug 2009 23:31:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 18 Aug 2009 19:31:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Aug 2009 19:31:53 -0400
Content-Disposition: inline
In-Reply-To: <1250631523-10524-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126481>

On Tue, Aug 18, 2009 at 11:38:40PM +0200, Matthieu Moy wrote:

> This small patch serie is based on the following commit in pu:
> 
> dda1f2a Implement 'git stash save --patch'
> 
> It is meant to replace two commits already there:
> 
> ea41cfc Make 'git stash -k' a short form for 'git stash save --keep-index'
> f300fab DWIM 'git stash save -p' for 'git stash -p'

Actually, these are already in 'next', so they can't be simply replaced.
So you would need to re-roll patches 1 and 2 at the very least.

However, thinking more on it, I think we can address Dscho's concern
with your proposal to accept only a limited set of options. And looking
at what's in f300fab, it actually does make an attempt to allow multiple
options, but it doesn't cover all cases (e.g., I can use "-p
--no-keep-index" but not "--no-keep-index -p". Nor can I do "-p -k";
even though "-k" is implied by "-p", you will get a very strange usage
mention instead of it being a silent no-op).

So there are two issues:

  - refactoring to allow arbitrary combinations of -k/-p and variants.

  - allowing other options; I believe "-q" is the only one. That seems
    to be specific to Dscho's objection, as it is ambiguous with other
    subcommands. Though "-p" may also become ambiguous, if we get "stash
    apply -p" soon.

I think the first one should be fairly uncontroversial. I'm not sure
about the second.

-Peff
