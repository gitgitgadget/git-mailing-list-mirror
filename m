From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-email.perl: check for lines longer than 998
	characters
Date: Sun, 20 Jan 2008 17:53:13 -0500
Message-ID: <20080120225313.GA14762@coredump.intra.peff.net>
References: <20080117153252.GD2816@coredump.intra.peff.net> <1200642458-3280-1-git-send-email-ediap@users.sourceforge.net> <47905F70.5090003@viscovery.net> <4790746D.1000502@users.sourceforge.net> <47907914.6000105@viscovery.net> <7v1w8fh2ef.fsf@gitster.siamese.dyndns.org> <20080118141638.GA14928@coredump.intra.peff.net> <7v8x2mdf7e.fsf@gitster.siamese.dyndns.org> <4793CCA2.4060407@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Adam Piatyszek <ediap@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Jan 20 23:53:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGj34-0005Yd-Q8
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 23:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907AbYATWxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 17:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755978AbYATWxR
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 17:53:17 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1650 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755785AbYATWxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 17:53:16 -0500
Received: (qmail 20329 invoked by uid 111); 20 Jan 2008 22:53:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 20 Jan 2008 17:53:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Jan 2008 17:53:13 -0500
Content-Disposition: inline
In-Reply-To: <4793CCA2.4060407@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71200>

On Sun, Jan 20, 2008 at 11:35:14PM +0100, Adam Piatyszek wrote:

> I support this idea. "git-format-patch --attach" is a good place to  
> implement such an additional encoding. Of course, git-mailinfo needs to  
> be extended with a decoding method as well.

I think mailinfo already does support qp, but I haven't tested it (see
builtin-mailinfo.c:decode_q_segment).

>> *1* It's actually second-to-root-cause it, because the real root
>> cause is for the source tree to have such an insanely long line.
> I can not fully agree with this statement. You should have in mind that  
> git is by the definition a "stupid content tracker" and should not assume 
> any particular kind of data being processed.
> For instance, the reported problem with git-send-email was discovered  
> when I tried to send a patch with some reference data of an unformatted  
> standard output of a test program.

I agree with you. One of the things that makes git so useful is that you
can feed it any content and everything "just works".

That being said, there is often a distinction in git between 'text' that
is reasonable for patches, mailing, etc, and 'binary', which is not.
Both cases are handled by git, but in different ways appropriate to
each. 1000-character lines are awfully long; should they perhaps be
handled as binary files?  The upside is that this fits them into a
well-established niche within git. The downside is that the diffs aren't
readable (though who is reading diffs with such long lines?) and I don't
believe the conflict resolution is as simple.

-Peff
