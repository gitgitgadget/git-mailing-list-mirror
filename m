From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: baffled again
Date: Wed, 24 Aug 2005 11:47:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508241140290.3317@g5.osdl.org>
References: <200508232256.j7NMuR1q027892@agluck-lia64.sc.intel.com>
 <7vek8jhk7y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: tony.luck@intel.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 20:49:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E80Hj-0008Fm-5X
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 20:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbVHXSrd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 14:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbVHXSrd
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 14:47:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43188 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751399AbVHXSrc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2005 14:47:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7OIlQjA024073
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 24 Aug 2005 11:47:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7OIlPM1030987;
	Wed, 24 Aug 2005 11:47:25 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek8jhk7y.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7719>



On Wed, 24 Aug 2005, Junio C Hamano wrote:
> 
> This does not have much to do with which common ancestor
> merge-base chooses.  Sorry, I am not sure what is the right way
> to resolve this offhand.

I think git did the "right thing", it just happened to be the thing that
Tony didn't want. Which makes it the "wrong thing", of course, but from a
purely technical standpoint, I don't think there's anything really wrong
with the merge. 

Basically, he had two branches, A and B, and both contained the same patch
(but _not_ the same commit). One undid it, the other did not.  There's no
real way to say which one is "correct", and both cases clearly merge
perfectly, so both outcomes "patch applied" and "patch reverted" are
really equally valid.

Now, if the shared patch hadn't been a patch, but a shared _commit_, then 
the thing would have been unambiguous - the shared commit would have been 
the merge point, and the revert would have clearly undone that shared 
commit.

What does this all mean? It just means that merging doesn't necessarily
even _have_ "one right answer". Automatic merges can be dangerous. The git
"global three-way" merge (global because it bases it's original state on
_global_ history, rather than local one) is about as safe as it gets (*), 
but even it can have these ambigious cases that it resolves automatically, 
and not the way you wanted it to.

		Linus

(*) "safe as it gets" of course also means "potentially really annoying",
since it tends to require manual fixups for any even possibly half-way
ambiguous case.
