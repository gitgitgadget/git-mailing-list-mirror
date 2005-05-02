From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: question on merges
Date: Mon, 2 May 2005 08:56:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505020850500.3824@ppc970.osdl.org>
References: <20050502151200.GA4592@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 17:48:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSd9s-0001rf-Ji
	for gcvg-git@gmane.org; Mon, 02 May 2005 17:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVEBPyT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 11:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVEBPyT
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 11:54:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:54490 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261343AbVEBPyL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 11:54:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j42Fs9s4012533
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 2 May 2005 08:54:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j42Fs68l001712;
	Mon, 2 May 2005 08:54:08 -0700
To: Lennert Buytenhek <buytenh@wantstofly.org>
In-Reply-To: <20050502151200.GA4592@xi.wantstofly.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 2 May 2005, Lennert Buytenhek wrote:
> 
> If a git user has X as his most recent local commit, and merges in a
> commit Y from someone else to create commit Z, shouldn't commit Z have
> both commit X and Y as parents?  Or is is the other way round and is it
> perfectly well possible that a 'merge commit' only has one parent?

There are two classes of git merges:
 - the "totally trivial one", where one side is fully contained within the 
   other (ie one side has not done any development at all)

   In this case, the "merge" ends up being a no-op, and just ends up being 
   a trivial "update" to the bigger set of objects. There are no two 
   parents, because the merge never even creates a new commit - it just
   takes the top commit from the other side.

 - a real merge, where both repositories have had concurrent development, 
   and then you see a new merge commit that has two parents (and they'll 
   be the two HEAD commits of the repositories).

So I assume you're just seeing the trivial case, but if what you're seeing 
doesn't seem to match that pattern, then holler.

NOTE! There's a real reason why the trivial merge _has_ to be just a plain 
"fast-forward the history to the new state", namely the fact that if you 
create a new merge-node for that, then you can never ever "stabilize": 
people merging back and forth will always get new nodes, and you end up 
with this run-away situation where you can never get the same tree on both 
sides.

		Linus
