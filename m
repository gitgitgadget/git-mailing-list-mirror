From: Jeff King <peff@peff.net>
Subject: Re: git-revert is a memory hog
Date: Tue, 29 Jan 2008 17:54:28 -0500
Message-ID: <20080129225428.GC4586@coredump.intra.peff.net>
References: <20080127172748.GD2558@does.not.exist> <20080128055933.GA13521@coredump.intra.peff.net> <alpine.LFD.1.00.0801300844170.28476@www.l.google.com> <20080129222007.GA3985@coredump.intra.peff.net> <7vfxwgmf87.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801300945310.3378@www.l.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Adrian Bunk <bunk@kernel.org>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 29 23:55:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJzM9-0005vE-GV
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 23:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbYA2Wyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 17:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752818AbYA2Wyc
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 17:54:32 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1283 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752148AbYA2Wyb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 17:54:31 -0500
Received: (qmail 11695 invoked by uid 111); 29 Jan 2008 22:54:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 29 Jan 2008 17:54:29 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2008 17:54:28 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801300945310.3378@www.l.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72013>

On Wed, Jan 30, 2008 at 09:49:44AM +1100, Linus Torvalds wrote:

> But  the
> 
>         if (rename_limit <= 0 || rename_limit > 32767)
>                 rename_limit = 32767;
> 
> which is there purely to avoid overflow in 32-bit multiplication should 

Ah, right, that first conditional handles the overflow. Then what is the
second one doing? If they are both larger than the rename limit, then
won't there square by definition be larger than the square of the rename
limit? I.e., can't we just get rid of the second conditional?

> Or, better yet (which was what I was hoping for originally), we'd just 
> make the inexact rename detection be linear-size/time rather than O(m*n). 
> But those patches never really came together, so we do need to limit it 
> more aggressively.

I had trouble getting the memory usage to a reasonable level. The hash
tables were just getting enormous.

-Peff
