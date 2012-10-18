From: Jeff King <peff@peff.net>
Subject: Re: What can cause empty GIT_AUTHOR_NAME for 'git filter-branch
 --tree-filter' on Solaris?
Date: Thu, 18 Oct 2012 01:36:56 -0400
Message-ID: <20121018053656.GA6308@sigill.intra.peff.net>
References: <1109432467.20121017104729@gmail.com>
 <507E5CE0.10002@viscovery.net>
 <1013956402.20121017125847@gmail.com>
 <20121017220912.GA21742@sigill.intra.peff.net>
 <507F9437.2070501@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ilya Basin <basinilya@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 07:37:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOin8-0003DV-Cj
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 07:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078Ab2JRFg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 01:36:59 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58614 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753951Ab2JRFg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 01:36:58 -0400
Received: (qmail 1751 invoked by uid 107); 18 Oct 2012 05:37:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Oct 2012 01:37:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2012 01:36:56 -0400
Content-Disposition: inline
In-Reply-To: <507F9437.2070501@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207960>

On Thu, Oct 18, 2012 at 07:31:35AM +0200, Johannes Sixt wrote:

> Right. But we should really be doing something like this instead to save a
> few subprocesses.
> [...]
> -	eval "$(set_ident AUTHOR <../commit)" ||
> +	eval "$(set_ident AUTHOR author <../commit)" ||

I cringe a little at losing DRY-ness to avoid processes. But the
repetition is pretty straightforward and obvious, and I know that some
platforms are really hurt by extra processes (and this is being called
for every commit).

Speaking of repetition, this seems like almost the exact same parsing
that happens in git-sh-setup's get_author_ident_from_commit. Maybe it's
worth merging them. I suspect you could also avoid another process
by parsing out both author and committer information in the same sed
invocation.

-Peff
