From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Fri, 15 May 2009 13:29:06 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905151324280.3343@localhost.localdomain>
References: <200905122329.15379.jnareb@gmail.com> <20090512233450.GY30527@spearce.org> <200905141024.17525.jnareb@gmail.com> <20090514145724.GE30527@spearce.org> <4A0C3282.4000101@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri May 15 22:29:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M541x-0004Aj-2g
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 22:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbZEOU3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 16:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbZEOU3M
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 16:29:12 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40677 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750958AbZEOU3L (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2009 16:29:11 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4FKT7Q6011088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 15 May 2009 13:29:08 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4FKT67c031712;
	Fri, 15 May 2009 13:29:07 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4A0C3282.4000101@op5.se>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119292>



On Thu, 14 May 2009, Andreas Ericsson wrote:

> Shawn O. Pearce wrote:
> > 
> > In loopback mode for local file URIs, it may become an issue.  C Git
> > is just getting lucky by the pipe size I think.  Though I thought I
> > read somewhere yesterday pipe FIFOs in Linux were being allocated
> > at 512 bytes, not one system page.  Of course other systems could
> > allocate whatever size they want too, and may allocate something
> > below the 2952 minimum, and we'd most likely see a deadlock on them.
> > 
> 
> Linux allocates one page 4096 bytes for a FIFO. 512 is the maximum
> size guaranteed by POSIX to result in an atomic write.

Actually, modern Linux will allocate up to 16 pages (PIPE_BUFFERS), but 
they may not all be filled - we coalesce small writes only if the end 
result fits entirely into a page. So the maximum buffer is 16*PAGE_SIZE, 
and the minimum buffer space (assuming regular "write()" system calls) is 
something like 16*(PAGE_SIZE/2+1).

But yeah, POSIX allows for much smaller buffers.

			Linus
