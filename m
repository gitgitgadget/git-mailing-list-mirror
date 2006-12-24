From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/17] Sliding window mmap for packfiles.
Date: Sun, 24 Dec 2006 01:29:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612240126380.3671@woody.osdl.org>
References: <20061223073317.GA9837@spearce.org>
 <38b2ab8a0612240056k152344ael891e9b0b9f8cbc47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 10:30:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyPgb-0001Dm-P7
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 10:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221AbWLXJaG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 04:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754226AbWLXJaG
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 04:30:06 -0500
Received: from smtp.osdl.org ([65.172.181.25]:53044 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754221AbWLXJaF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 04:30:05 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBO9TT2J032363
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 24 Dec 2006 01:29:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBO9TTWx032241;
	Sun, 24 Dec 2006 01:29:29 -0800
To: Francis Moreau <francis.moro@gmail.com>
In-Reply-To: <38b2ab8a0612240056k152344ael891e9b0b9f8cbc47@mail.gmail.com>
X-Spam-Status: No, hits=-1.152 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.165 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35350>



On Sun, 24 Dec 2006, Francis Moreau wrote:
> 
> Just out of curiosity, do you mean that there are some OS running on
> 32 bits machines which allow 4GiB size of virtual memory within a
> single process ? If so, could you give an example of such OS ?

Actually, Linux will do it on certain architectures (some architectures 
have separate "address spaces" for kernel and user). And even on x86, if 
you apply the (insane) 4GB patches, user space will actually have almost 
all of the 4GB, because there's only a _tiny_ trampoline thing that 
switches the whole page table around that is kernel-mapped and takes away 
from the 4GB thing.

In practice, though, most 32-bit architectures will have between 1-3GB of 
user virtual memory. And obviously stack space, binaries, heap etc take up 
space, so you often end up with with just ~0.5 GB of actual dependable 
contiguous virtual memory.

			Linus
