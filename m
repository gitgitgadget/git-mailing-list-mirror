From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Start handling references internally as a sorted in-memory list
Date: Mon, 11 Sep 2006 18:05:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609111800590.27779@g5.osdl.org>
References: <Pine.LNX.4.64.0609111158390.3960@g5.osdl.org>
 <Pine.LNX.4.64.0609111632050.27779@g5.osdl.org> <7vsliyez2m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 12 03:05:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMwif-00065q-8c
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 03:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965228AbWILBFR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 21:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965229AbWILBFR
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 21:05:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9904 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965228AbWILBFP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Sep 2006 21:05:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8C15AnW007721
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Sep 2006 18:05:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8C159IW002981;
	Mon, 11 Sep 2006 18:05:09 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsliyez2m.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.521 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.148 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26874>



On Mon, 11 Sep 2006, Junio C Hamano wrote:
> 
> I thought what triggered the restructuring of this part was N
> actually being large enough to cause pain to some people, so I
> suspect later might need to be reasonably soon ;-).

Well, the current problems is actually related to the _IO_ load of O(n) 
(and to some degree the disk usage), and that is indeed fairly high. The 
new O(n**2) is all for a (very) simple CPU loop, so I suspect "n" has to 
be in the millions before it even approaches the IO load problem ;)

> I've been wondering what happens if you pack "refs/heads/foo",
> delete it, and create "refs/heads/foo/bar" with your proposal.
> I'll find the answer (which is _not_ "42") in the updated
> do_for_each_ref(), I guess.

Right now, the code in question only contains some preliminary support for 
refs at all, and it's technically incorrect. If you ever have a 
"packed-refs" file that contains _anything_ outside of the actual loose 
refs, it won't do the right thing.

But I'd rather have this as a base, than send one huge patch that does 
everything.

For example, right now the code doesn't support negative refs (even the 
simple kind) at all, so you don't need to even have the "file turned into 
a directory" case for it to "not work".

So right now it's basically just scaffolding. It's hopefully _good_ 
scaffolding, so that when I send the next few patches, it actually starts 
working.. ;)

		Linus
