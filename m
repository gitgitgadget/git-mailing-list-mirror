From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] diffcore-rename: favour identical basenames
Date: Thu, 21 Jun 2007 11:24:50 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706211118420.3593@woody.linux-foundation.org>
References: <20070621030622.GD8477@spearce.org>
 <alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org>
 <Pine.LNX.4.64.0706211248420.4059@racer.site> <20070621131915.GD4487@coredump.intra.peff.net>
 <alpine.LFD.0.98.0706210910390.3593@woody.linux-foundation.org>
 <7vfy4lw5yk.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	govindsalinas <govindsalinas@yahoo.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 20:25:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1RLd-0007dz-V7
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 20:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbXFUSZg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 14:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbXFUSZg
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 14:25:36 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38400 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750723AbXFUSZf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jun 2007 14:25:35 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5LIOuxH017345
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jun 2007 11:24:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5LIOocc002126;
	Thu, 21 Jun 2007 11:24:50 -0700
In-Reply-To: <7vfy4lw5yk.fsf@assigned-by-dhcp.pobox.com>
X-Spam-Status: No, hits=-4.533 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50650>



On Thu, 21 Jun 2007, Junio C Hamano wrote:
> 
> This is not an example to draw very useful conclusions, is it?
> 
> The heuristics to say '-pc => common' is a more likely rename
> than '-obscure-arch => common' heavily depends on human
> intelligence in the context

Oh, absolutely.

I'm just saying that *if* you see two equally weighed content moves, if 
you then prefer the one that has more in common with the name, that's 
likely the right choice. 

In the actual example I gave, there was no ambiguity: the file contents 
were very obvious. But let's sat that you happened to have an example of 
two files with 100% identical content that moved, and you had the files

	-arch/i386/kernel/pci-pc.c
	-arch/alpha/kernel/pci-pc.c
	+arch/i386/kernel/pci/common.c
	+arch/alpha/kernel/pci/common.c

to match up, how would you do it? Again: they're all identical files: we 
can obviously agree that two files got renamed, but what is the pairing.

I'd suggest that if you do it by matching up the similarity of the 
filenames (not necessarily "exact same basename"), you'd actually catch 
it. In this case, they all have "pci" in them, but the "alpha" similarity 
would make you select the right one.

Similarly, in some other cases, the "pci" might be the thing they have in 
common, and might be the thing that decides that "oh, those two filenames 
look like they might be more of a better pair".

And yes, all of this would trigger only if the file data content match is 
non-conclusive. The file data is *more* important, but that doesn't mean 
that the file name similarity is *totally* unimportant either.

			Linus
