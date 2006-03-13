From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] Use explicit pointers for execl...() sentinels.
Date: Mon, 13 Mar 2006 00:12:31 -0400
Message-ID: <200603130412.k2D4CW1b011631@laptop11.inf.utfsm.cl>
References: <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 13 16:50:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIpIR-0007je-5z
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 16:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWCMPtS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 10:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWCMPtS
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 10:49:18 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:29841 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751448AbWCMPtR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Mar 2006 10:49:17 -0500
Received: from laptop11.inf.utfsm.cl (laptop11.inf.utfsm.cl [200.1.19.198])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k2DFnDkF025134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 13 Mar 2006 11:49:15 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.5/8.13.5) with ESMTP id k2D4CW1b011631
	for <git@vger.kernel.org>; Mon, 13 Mar 2006 00:12:32 -0400
To: git@vger.kernel.org
In-Reply-To: Message from Jeff King <peff@peff.net> 
   of "Sun, 12 Mar 2006 22:31:21 EST." <20060313033121.GA14601@coredump.intra.peff.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 13 Mar 2006 11:49:15 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17566>

Jeff King <peff@peff.net> wrote:
> On Sun, Mar 12, 2006 at 08:08:12PM +0200, Timo Hirvonen wrote:
> > NULL pointer does not point to any data, it just says it's 'empty'.  So
> > it doesn't need to be same type pointer as specified in the function
> > prototype.  Pointers are just addresses, it doesn't matter from to code
> > generation point of view whether it is (char *)0 or (void *)0.

> Sorry, but I think you're wrong according to the C standard. Pointers of 
> different types do NOT have to share the same representation (e.g.,
> there have been some platforms where char* and int* were different
> sizes). A void pointer must be capable of representing any type of
> pointer (for example, holding the largest possible type). However, if
> sizeof(void *) == 8 and sizeof(char *) == 4,

Very improbable, they'll be the same normally ("void *" is a way of getting
rid of the overloading of the meaning of "char *" for this before ANSI C).
Sure, sizeof(int *) might be 4, but I think that is pretty far off.

>                                              you have a problem with
> variadic functions which are expecting to pull 4 byte off the stack. 

There are special rules for variadic functions, probably pointers would be
cast to/from void * in such a case by the compiler.

> In a non-variadic function, the compiler would do the right implicit
> casting. In a variadic function, it can't. 

It sure can. The rules where defined so that it works.

> The real question is, does git want to care about portability to such
> platforms.

Broken platform, on which the compiler fails miserably in doing its job?
No, it doesn't.

> If you remain unconvinced, I can try to find chapter and verse of the
> standard.

Please do.

> > sizeof(unsigned long) is sizeof(void *) in real world.

> Are you saying that because it encompasses all of the platforms you've
> worked on, or do you have some evidence that it is largely the case? It
> certainly isn't guaranteed by the C standard.

More because a machine with pointers that are much larger than the largest
"normal" integer would be pretty weird (sure, on intel 8086 they where 32
("far" pointer, segment + offset) and 16 bits, but...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
