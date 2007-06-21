From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] diffcore-rename: favour identical basenames
Date: Thu, 21 Jun 2007 09:20:51 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706210910390.3593@woody.linux-foundation.org>
References: <20070621030622.GD8477@spearce.org>
 <alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org>
 <Pine.LNX.4.64.0706211248420.4059@racer.site>
 <20070621131915.GD4487@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	govindsalinas <govindsalinas@yahoo.com>, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 21 18:21:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1PPG-0004kp-N8
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 18:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbXFUQVN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 12:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752958AbXFUQVN
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 12:21:13 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35312 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752213AbXFUQVM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jun 2007 12:21:12 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5LGKvuW012396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jun 2007 09:20:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5LGKpIg032171;
	Thu, 21 Jun 2007 09:20:51 -0700
In-Reply-To: <20070621131915.GD4487@coredump.intra.peff.net>
X-Spam-Status: No, hits=-4.527 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50640>



On Thu, 21 Jun 2007, Jeff King wrote:

> On Thu, Jun 21, 2007 at 12:52:11PM +0100, Johannes Schindelin wrote:
> 
> > When there are several candidates for a rename source, and one of them
> > has an identical basename to the rename target, take that one.
> 
> That's a reasonable heuristic, but it unfortunately won't match simple
> things like:
> 
>   i386_widget.c -> arch/i386/widget.c

We'e also had things like

	arch/i386/kernel/pci-pc.c -> arch/i386/kernel/pci/common.c

so it's not always the ending of a file that is unchanged, but you still 
often have some "similarity" of the name (ie the "pci" substring is still 
common there).

So I agree that we can be even better about the heuristics. I don't know 
how much it *matters* in practice.

I do agree with the people who argue that you simply shouldn't depend on 
these kinds of things, and if you have identical files, and move them 
around, you really are getting behaviour that doesn't matter.

The files are *identical* for christ sake! Following their history, it 
doesn't matter *which* base you follow, since regardless, they've come to 
the same point!

So in that sense, the current git behaviour is actually perfectly fine.

At the same time, I'll argue from a totally theoretical point that the 
"filename" is obviously part of the data in the tree, and as such, a 
similarity comparison that takes only the data into account is a bit 
limited. So while I don't think a user should really care, I also think 
that keeping the filename as part of the similarity analysis is actually 
a perfectly logical and valid thing to do withing the git policy of 
"content is king".

The filename *is* part of the content, and it's doubly so when you think 
about a rename or copy operation, where the whole point of the exercise is 
as much about the filename as about the data inside the file.

			Linus
