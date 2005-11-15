From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: fix git-pack-redundant crashing sometimes
Date: Tue, 15 Nov 2005 09:28:25 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511150921420.3945@g5.osdl.org>
References: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com> 
 <20051115180848.561a6da5.tihirvon@gmail.com>
 <81b0412b0511150811w2a7a2c4ft9a2920ac4f030ee4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org,
	lukass@etek.chalmers.se, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Nov 15 18:32:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec4cj-0007Jx-AJ
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 18:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbVKOR3e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 12:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbVKOR3e
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 12:29:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18069 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751453AbVKOR3e (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 12:29:34 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAFHSRnO021891
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 15 Nov 2005 09:28:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAFHSPEE009954;
	Tue, 15 Nov 2005 09:28:26 -0800
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0511150811w2a7a2c4ft9a2920ac4f030ee4@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11923>



On Tue, 15 Nov 2005, Alex Riesen wrote:

> On 11/15/05, Timo Hirvonen <tihirvon@gmail.com> wrote:
> > > The code could profit from double-linked lists greatly, IMHO.
> >
> > I use list.h from Linux when I need double-linked lists.  It is very
> > easy to use, efficient and fast.
> 
> Yes, I had it in mind, too.

There's a "ptrlist" implementation in sparse, which does a very 
space-efficient implementation of arbitrary lists of pointers. It's also 
very CPU-efficient (in fact, thanks to being very cache-friendly, more so 
than the kernel list.h implementation) for most well-behaved operations 
(ie it's not hugely friendly to removal, but it's great for "add to end" 
and "traverse the list").

The ptrlist implementation is optimized for cases where the lists are 
usually shortish, but not trivial. So they are worthwhile if you expect 
the list length to be on the order of 5-10 entries rather than just 1-2 
(if you have just a couple of entries, the kernel lists are better). But 
perhaps more importantly, they are very space-efficient when the lists 
grow bigger (ie they average to just about 5% over the memory cost of a 
single pointer per list element for long lists).

Sparse in general is under the OSL license, but I'll happily dual-license 
the ptrlist thing, it's trivial and all my code (and I already checked 
with the person who did the list sorting code that we can dual-license 
that too).

			Linus
