From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Handling renames.
Date: Thu, 14 Apr 2005 20:58:41 +0200
Message-ID: <20050414185841.GA16865@elte.hu>
References: <1113501260.27227.26.camel@hades.cambridge.redhat.com> <20050414181224.GA16126@elte.hu> <Pine.LNX.4.58.0504141124220.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@SteelEye.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 20:56:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM9V0-0003Fk-5Z
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 20:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVDNS64 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 14:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVDNS64
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 14:58:56 -0400
Received: from mx1.elte.hu ([157.181.1.137]:20928 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261445AbVDNS6y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 14:58:54 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id 091D931FD06;
	Thu, 14 Apr 2005 20:58:09 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 1D4741FC2; Thu, 14 Apr 2005 20:58:45 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504141124220.7211@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> [...] Ie if you notice a rename, you first commit the rename (and you 
> can _see_ it's a rename, since the object didn't change, and the sha1 
> stayed the same, which in git-speak means that it is the same object, 
> ie that _is_ a rename as far as git is concerned), and then you create 
> the "this is the data that changed" as a _second_ commit.

ok, i accept your point of not putting this into such a low level as the 
object abstraction. Was a bad idea.

but i dont think the above would be enough: there can be renames of 
objects that have the same sha1 hash as other objects in the same tree, 
and developers want to track individual objects, regardless of whether 
other files share the same content. So some formal operation would be 
needed to signal renames - e.g. to embedd it in the commit object, per 
David's suggestion.

The thing i tried to avoid was to list long filenames in the commit 
(because of the tree hierarchy we'd need to do tree-absolute pathnames 
or something like that, and escape things, and do lookups - duplicating 
a VFS which is quite bad) - it would be better to identify the rename 
source and target via its tree object hash and its offset within that 
tree. Such information could be embedded in the commit object just fine.  
Something like:

me bb95843a5a0f397270819462812735ee29796fb4
tree 1756b578489f93999ded68ae347bef7d6063101c
parent 9f02d4d233223462d3f6217b5837b786e6286ba4
author
committer
rename 39021759c903a943a33a28cfbd5070d36d851581 15234 9f02d4d233223462d3f6217b5837b786e6286ba4 16163

?

	Ingo
