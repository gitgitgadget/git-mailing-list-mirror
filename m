From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-send-pack segfaulting on DebianPPC (was: Re: cg-clone, tag
 objects and cg-push/git-push don't play nice)
Date: Wed, 19 Oct 2005 14:09:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510191405020.3369@g5.osdl.org>
References: <46a038f90510190202n60101c5cgf27bd714dce00513@mail.gmail.com> 
 <Pine.LNX.4.64.0510190724000.3369@g5.osdl.org>
 <46a038f90510191356w56b78413p6b9fe5b67fc9ee74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Oct 19 23:11:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESLCP-0001ty-FY
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 23:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbVJSVKH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 17:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbVJSVKH
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 17:10:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22459 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751347AbVJSVKG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2005 17:10:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9JL9uFC004940
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 19 Oct 2005 14:09:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9JL9tFv020120;
	Wed, 19 Oct 2005 14:09:55 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90510191356w56b78413p6b9fe5b67fc9ee74@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10310>



On Thu, 20 Oct 2005, Martin Langhoff wrote:
> 
> On this broken-ish repo, git-fetch-pack segfaults as I've reported.
> Running it under strace shows that it dies walking the local repo,
> trying to find a missing commit. Unlikely that this is PPC only ;-)

Ok, that's not horribly surprising, but it's wrong.

Since I'm a lazy bastard, and couldn't necessarily re-create the right 
kind of broken repository even if I weren't, could you just enable 
core-dumps, and run gdb on the thing and report what "where" says is the 
call-chain.

It's almost certainly something that looks up an object and dereferences 
it without checking whether the object lookup succeeded or not. But if you 
can say where the SIGSEGV happens, it will be easier to figure out where.

Of course, what I really _should_ do is improve "sparse" to the point 
where I can mark functions as returning "unsafe" pointers, and then have 
sparse statically find all the dangerous users. I should do that anyway, 
since it would be useful for the kernel too, but it's actually quite 
nontrivial.

		Linus "being lazy is not a state of
			mind - it's a way of life" Torvalds
