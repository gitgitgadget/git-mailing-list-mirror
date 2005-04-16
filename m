From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Merge with git-pasky II.
Date: Sat, 16 Apr 2005 13:41:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504161334540.7211@ppc970.osdl.org>
References: <E1DMtuY-0002fL-3b@approximate.corpus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Woodhouse <dwmw2@infradead.org>,
	Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 22:36:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMu1b-0005ry-NX
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 22:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbVDPUj5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 16:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbVDPUj5
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 16:39:57 -0400
Received: from fire.osdl.org ([65.172.181.4]:24246 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262752AbVDPUjz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 16:39:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3GKdYs4009821
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 16 Apr 2005 13:39:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3GKdX8Y026919;
	Sat, 16 Apr 2005 13:39:34 -0700
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
In-Reply-To: <E1DMtuY-0002fL-3b@approximate.corpus.cam.ac.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 16 Apr 2005, Sanjoy Mahajan wrote:
> 
> I like this elegant approach, but clever pattern matching can help even
> at commit time.  Suppose hello.c is simply:

Here, what you're talking about is not "commit", but "merge".

The git model very much separates the two events. You first generate a 
merged tree, an dyou commit that merge as a separate and largely totally 
independent phase.

And yes, I agree that with merging, you do end up potentially wanting to 
try different things. When I've done my "git" merges, all I've really done 
is to make sure that the trivial parts basically merge in zero time, so 
that you can afford to perhaps spend some effort on handling the _real_ 
merge conflicts.

Many systems seem to be designed around a "clever merge" algorithm, with 
darcs perhaps being the most extreme example. The problem with that design 
is that 99.9% of all the work is not at all about being clever, and if you 
try to base your design around the clever things, your performance will 
definitely suck.

So I think that with git, you can actually really try to be clever,
because when you get a merge conflict, you're now only worrying about one
file out of 17,000, and then you can go wild on that one and try different
merge algorithms (token merge, character-merge, line-based merge, you name
it).

Of course, I might not actually personally want to depend on any clever 
merges, but the git infrastructure really doesn't care. My plumbing 
doesn't merge the conflicts that arise within one single object, or the 
filename differences - you can do anything you want on that.

		Linus
