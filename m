From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Wed, 5 Aug 2009 21:27:05 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908052120330.3390@localhost.localdomain>
References: <20090805181755.22765.qmail@science.horizon.com> <alpine.LFD.2.01.0908051352280.3390@localhost.localdomain> <alpine.LFD.2.01.0908051545000.3390@localhost.localdomain> <alpine.LFD.2.01.0908051800030.3390@localhost.localdomain>
 <alpine.LFD.2.00.0908052144430.16073@xanadu.home> <alpine.LFD.2.01.0908051902580.3390@localhost.localdomain> <4A7A4BC5.7010106@gmail.com> <alpine.LFD.2.01.0908052024081.3390@localhost.localdomain> <4A7A5723.6070704@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, George Spelvin <linux@horizon.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 06:28:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYuaO-0000kF-9k
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 06:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbZHFE1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 00:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbZHFE1o
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 00:27:44 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58725 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751205AbZHFE1n (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 00:27:43 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n764R7FL021790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Aug 2009 21:27:08 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n764R5mU002725;
	Wed, 5 Aug 2009 21:27:05 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4A7A5723.6070704@gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.466 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125035>



On Thu, 6 Aug 2009, Artur Skawina wrote:
> > 
> > The way it's written, I can easily make it do one or the other by just 
> > turning the macro inside a loop (and we can have a preprocessor flag to 
> > choose one or the other), but let me work on it a bit more first.
> 
> that's of course how i measured it.. :)

Well, with my "rolling 512-bit array" I can't do that easily any more.

Now it actually depends on the compiler being able to statically do that 
circular list calculation. If I were to turn it back into the chunks of 
loops, my new code would suck, because it would have all those nasty 
dynamic address calculations.

> I've only tested on p4 and there the winner so far is still:

Yeah, well, I refuse to touch that crappy micro-architecture any more. I 
complained to Intel people for years that their best CPU was only 
available as a laptop chip (Pentium-M), and I'm really happy to have 
gotten rid of all my horrid P4's.

(Ok, so it was great when the P4 ran at 2x the frequency of the 
competition, and then it smoked them all. Except on OS loads, where the P4 
exception handling took ten times longer than anything else).

So I'm a big biased against P4. 

I'll try it on my Atom's, though. They're pretty crappy CPU's, but they 
have a fairly good _reason_ to be crappy.

			Linus
