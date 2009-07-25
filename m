From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] Add support for external programs for handling native
 fetches
Date: Sat, 25 Jul 2009 11:25:33 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907251107500.3960@localhost.localdomain>
References: <alpine.LNX.2.00.0907251330240.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:25:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUlwN-0001TD-Ne
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbZGYSZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbZGYSZo
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:25:44 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44160 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750893AbZGYSZn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jul 2009 14:25:43 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6PIPYGA007035
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 25 Jul 2009 11:25:35 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6PIPXXn016308;
	Sat, 25 Jul 2009 11:25:33 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LNX.2.00.0907251330240.2147@iabervon.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.959 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124033>



On Sat, 25 Jul 2009, Daniel Barkalow wrote:
>
> This is similar to, but different from, my git-vcs-* stuff; this one 
> expects the helper to be able to look up sha1s for refs efficiently, and 
> to be able to fetch objects directly into the local object database 
> without fast-import. On the otherhand, it should be sufficiently general 
> to allow arbitrary methods for moving the data around.

Wonderful. 

I tested the series, and now there is (not surprisingly, but I made sure 
to test anyway) no difference what-so-ever between NO_CURL and default, 
and 'ldd' looks nice.

Plus it looks like that whole "shim" thing is a good idea in general, in 
that it allows a much more flexible model for fetching/pushing.

So a very big Acked-by: from me for the series. I didn't test that http: 
works with it, but I don't personally even care, so I'd ack it even 
without that ;)

Btw, some real timing numbers for 'time make -j64 test':

 - before:
	real	1m16.070s
	user	2m47.046s
	sys	2m34.698s

 - after:
	real	0m58.851s
	user	1m57.087s
	sys	1m44.671s

so that's actually a real-world example of the whole 'scripting 
performance'. Not an insignificant speedup on my machine (with an 
obligatory "nyaah, nyaah, I can do the git test-suite under a minute" just 
to rub peoples noses in the fact that my desktop computer is disgustingly 
fast).

That's an almost 30% performance improvement, despite the fact that parts 
of the test suite didn't actually change (shell costs are the same, the 
svn tests are quite perl-intensive etc).

			Linus
