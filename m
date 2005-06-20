From: Jens Axboe <axboe@suse.de>
Subject: Re: git merging
Date: Mon, 20 Jun 2005 22:38:22 +0200
Message-ID: <20050620203821.GC7712@suse.de>
References: <20050617181156.GT6957@suse.de> <Pine.LNX.4.58.0506171132390.2268@ppc970.osdl.org> <20050617183914.GX6957@suse.de> <Pine.LNX.4.58.0506171142500.2268@ppc970.osdl.org> <42B357D7.6030302@pobox.com> <Pine.LNX.4.58.0506171629320.2268@ppc970.osdl.org> <42B36207.3020209@pobox.com> <Pine.LNX.4.58.0506171700200.2268@ppc970.osdl.org> <20050620123053.GI15021@suse.de> <Pine.LNX.4.58.0506200844420.2268@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 22:46:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkTA6-0005p5-Lu
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 22:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVFTUvE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Jun 2005 16:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVFTUrv
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 16:47:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:65469 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261715AbVFTUhP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2005 16:37:15 -0400
Received: from [62.242.22.158] (helo=router.home.kernel.dk)
	by virtualhost.dk with esmtp (Exim 3.36 #1)
	id 1DkT0w-0005Re-00; Mon, 20 Jun 2005 22:37:02 +0200
Received: from nelson.home.kernel.dk ([192.168.0.33] helo=kernel.dk)
	by router.home.kernel.dk with esmtp (Exim 4.22)
	id 1DkT0t-0006ro-5K; Mon, 20 Jun 2005 22:36:59 +0200
Received: by kernel.dk (Postfix, from userid 1000)
	id 5F58A70971; Mon, 20 Jun 2005 22:38:22 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506200844420.2268@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 20 2005, Linus Torvalds wrote:
> 
> [ Daniel put on the To: list to see if he can confirm or deny my theory ]
> 
> On Mon, 20 Jun 2005, Jens Axboe wrote:
> > 
> > axboe@nelson:[.]l/git/linux-2.6-block.git $ git prune
> > error: cannot map sha1 file c39ae07f393806ccf406ef966e9a15afc43cc36a
> 
> That's the 2.6.11 "tree" object.
> 
> > bad sha1 entry '5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c'
> > axboe@nelson:[.]l/git/linux-2.6-block.git $ git-fsck-cache 
> > error: cannot map sha1 file c39ae07f393806ccf406ef966e9a15afc43cc36a
> > bad object in tag 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c
> > bad sha1 entry '5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c'
> > 
> > Running git prune again gives me the same output. What is wrong?
> 
> Very interesting. You have my "v2.6.11-tree" tag file pointing the 2.6.11
> tree object, but you seem to not have that 2.6.11 tree itself.
> 
> Actually, judging from the fact that you got this error _during_ the
> prune, maybe you never had it in that repository in the first place?

I can't tell exactly, but I'm fairly sure this is a new error. I have
two git trees locally - one which is just an rsync of your kernel.org
tree, the other which is based off that (with a clone of the fs dir) and
has multiple branches for developments. The main tree did not have this
problem, while the development tree does/did.

> In particular, if you don't use "rsync", but instead use one of the
> "optimized pull" things to create a repository (ie git-http-pull or
> git-ssh-pull), I think your newly pulled tree will always miss anything
> that isn't a head. And the 2.6.11 tree is a special case: it's a pure
> "tree" object without any commit at all pointing to it, just a single tag
> that points directly to the tree.
> 
> Anyway, the fact that you're missing the original 2.6.11 tree doesn't
> really matter, so it's not a huge deal per se. You can re-populate it with
> an "rsync -avz --ignore-existing", but clearly something seems to be
> wrong.

I pulled with rsync manually from kernel.org, and that did fix things up
for me. The main tree is rsync'ed, but the development tree gets the
changes with /opt/kernel/git/linux-2.6/.git/ as the url given to
git-pull-script.

-- 
Jens Axboe

