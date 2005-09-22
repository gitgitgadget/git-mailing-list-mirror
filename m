From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH 6/8] cogito: Don't ever assume object type in
	cg-object-id
Date: Thu, 22 Sep 2005 12:55:55 -0400
Message-ID: <1127408155.14856.30.camel@dv>
References: <1127183120.31115.34.camel@dv>
	 <20050921100040.GE24902@pasky.or.cz> <1127359625.8074.18.camel@dv>
	 <20050922094643.GC21019@pasky.or.cz> <1127403479.14856.13.camel@dv>
	 <20050922155025.GK21019@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 22 18:59:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIUMh-0006aa-H8
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 18:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbVIVQ4A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 12:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030444AbVIVQ4A
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 12:56:00 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:5525 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1030449AbVIVQz7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2005 12:55:59 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EIUMX-0001Yr-QG
	for git@vger.kernel.org; Thu, 22 Sep 2005 12:55:57 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EIUMV-0008DY-OE; Thu, 22 Sep 2005 12:55:55 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050922155025.GK21019@pasky.or.cz>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9135>

On Thu, 2005-09-22 at 17:50 +0200, Petr Baudis wrote:
> Dear diary, on Thu, Sep 22, 2005 at 05:37:59PM CEST, I got a letter
> where Pavel Roskin <proski@gnu.org> told me that...
> > [proski@dv cogito]$ for i in .git/refs/tags/*; do git-tar-tree `cat $i` >/dev/null || echo $i; done
> > fatal: not a reference to a tag, commit or tree object: 463d05c7c4fe7f24da29749f4c7f25893fc20b8c
> > .git/refs/tags/git-pasky-0.1
> > fatal: not a reference to a tag, commit or tree object: 2c70421be7d88fbee49986d7a5584d1f010a25de
> > .git/refs/tags/git-pasky-0.2
> > fatal: not a reference to a tag, commit or tree object: d14925c87cdb6ca6345bcb3c8e34a2d659c79451
> > .git/refs/tags/git-pasky-0.3
> 
> Huh. Huh?
> 
> xpasky@machine[1:0]~/git-devel$ git-cat-file -t $(cg-object-id git-pasky-0.1)
> commit

The error message is misleading.  In fact, it's the tree referred to by
the commit that was missing.  Anyway, that object exists on the server,
so it was my local problem.

It would be nice to have a script fetch an object by SHA1, possibly with
the dependencies.  git-fetch doesn't do it yet.

I copied the whole objects tree for cogito using rsync, and I see lots
or error messages from git-fsck-objects.  I'll wait for your changes to
propagate.  As it stands now, b3e9704ecdf48869f635f0aa99ddfb513f885aff
(a file you said you have removed) and
11ed64c1b141c9ba397a1ca76aef2cd250976007 are still present and empty.

Are you sure rsync that copies to kernel.org uses the "delete" option?
If not, we should treat kernel.org as "dumb transport" where directory
listings should never be used.

> > How come that cogito-0.12 - cogito-0.15 are not on the origin tree, but
> > older cogito tags are?
> 
> That's because the older tags tag commits directly, not tag objects.
> git-prune removed the tag objects because they were unreferenced by its
> perspective. Anyway, git-prune without any arguments should get it
> right.

Thanks for the explanation.  I'll be more careful with git-prune.

-- 
Regards,
Pavel Roskin
