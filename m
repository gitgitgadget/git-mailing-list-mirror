From: Jeff King <peff@peff.net>
Subject: Re: git-revert is a memory hog
Date: Tue, 29 Jan 2008 17:30:10 -0500
Message-ID: <20080129223010.GA4314@coredump.intra.peff.net>
References: <20080127172748.GD2558@does.not.exist> <20080128055933.GA13521@coredump.intra.peff.net> <alpine.LFD.1.00.0801300844170.28476@www.l.google.com> <20080129222007.GA3985@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adrian Bunk <bunk@kernel.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 29 23:30:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJyye-0005bA-D7
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 23:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbYA2WaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 17:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753072AbYA2WaP
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 17:30:15 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2819 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751264AbYA2WaO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 17:30:14 -0500
Received: (qmail 11424 invoked by uid 111); 29 Jan 2008 22:30:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 29 Jan 2008 17:30:12 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2008 17:30:10 -0500
Content-Disposition: inline
In-Reply-To: <20080129222007.GA3985@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72006>

On Tue, Jan 29, 2008 at 05:20:07PM -0500, Jeff King wrote:

> The culprit seems to be diffcore-rename.c:476:
> 
>   mx = xmalloc(sizeof(*mx) * num_create * num_src);
> 
> Where that ends up allocating about 450M. I think this is exactly the
> sort of case that renamelimit was introduced to address.

BTW, a much easier way to see the problem is with:

  git diff -M -l0 d19fbe8a76

It's just a _really_ old commit, and the rename detection has to work on
a large number of files.

-Peff
