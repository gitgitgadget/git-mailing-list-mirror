From: Jens Axboe <axboe@suse.de>
Subject: Re: git merging
Date: Mon, 20 Jun 2005 14:30:53 +0200
Message-ID: <20050620123053.GI15021@suse.de>
References: <20050617175653.GS6957@suse.de> <Pine.LNX.4.58.0506171101450.2268@ppc970.osdl.org> <20050617181156.GT6957@suse.de> <Pine.LNX.4.58.0506171132390.2268@ppc970.osdl.org> <20050617183914.GX6957@suse.de> <Pine.LNX.4.58.0506171142500.2268@ppc970.osdl.org> <42B357D7.6030302@pobox.com> <Pine.LNX.4.58.0506171629320.2268@ppc970.osdl.org> <42B36207.3020209@pobox.com> <Pine.LNX.4.58.0506171700200.2268@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 14:24:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkLJn-0001vM-2w
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 14:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVFTM3t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Jun 2005 08:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVFTM3t
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 08:29:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63920 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261231AbVFTM3q (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2005 08:29:46 -0400
Received: from [62.242.22.158] (helo=router.home.kernel.dk)
	by virtualhost.dk with esmtp (Exim 3.36 #1)
	id 1DkLPB-0000ld-00; Mon, 20 Jun 2005 14:29:33 +0200
Received: from nelson.home.kernel.dk ([192.168.0.33] helo=kernel.dk)
	by router.home.kernel.dk with esmtp (Exim 4.22)
	id 1DkLP9-0000Jg-8M; Mon, 20 Jun 2005 14:29:31 +0200
Received: by kernel.dk (Postfix, from userid 1000)
	id C75541E132; Mon, 20 Jun 2005 14:30:53 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506171700200.2268@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 17 2005, Linus Torvalds wrote:
> 
> 
> On Fri, 17 Jun 2005, Jeff Garzik wrote:
> > 
> > This is definitely not the case; my .git/HEAD is _always_ a symlink.
> 
> Ok. Are you sure that you gave the same arguments (or rather, lack of
> arguments) to both fsck and "git prune"? The thing is, they are both
> really the same thing, so I'm pretty surprised. If git prune says 
> something is unreachable, then git-fsck-cache shouldn't complain about it 
> being gone, because one just depends on the other..

Seeing something weird here as well, my setup is similar to Jeffs in
that I have branches in refs/heads/* and HEAD a symlink to the active
one.

I committed a bad patch, so wanting to reverse that change I did an

# echo sha_of_previous_commit > .git/HEAD
# git-read-tree -m HEAD && git-checkout-cache -q -f -u -a

which, if I understand correctly, should put me back where I was before.
So continuing commits, checking the tree now gives me:

axboe@nelson:[.]l/git/linux-2.6-block.git $ git prune
error: cannot map sha1 file c39ae07f393806ccf406ef966e9a15afc43cc36a
bad sha1 entry '5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c'
axboe@nelson:[.]l/git/linux-2.6-block.git $ git-fsck-cache 
error: cannot map sha1 file c39ae07f393806ccf406ef966e9a15afc43cc36a
bad object in tag 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c
bad sha1 entry '5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c'

Running git prune again gives me the same output. What is wrong?

-- 
Jens Axboe

