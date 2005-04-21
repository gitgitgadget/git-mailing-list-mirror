From: Steven Cole <elenstev@mesatop.com>
Subject: Re: Possible problem with git-pasky-0.6.2 (patch: **** Only garbage was found in the patch input.)I
Date: Thu, 21 Apr 2005 04:23:45 -0600
Message-ID: <200504210423.47369.elenstev@mesatop.com>
References: <200504201706.09656.elenstev@mesatop.com> <200504201820.27497.elenstev@mesatop.com> <20050421071104.GC31910@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 12:24:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOYqj-0005zu-LV
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 12:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVDUK2Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 06:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVDUK2Q
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 06:28:16 -0400
Received: from taco.zianet.com ([216.234.192.159]:32521 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S261265AbVDUK1y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 06:27:54 -0400
Received: (qmail 97549 invoked from network); 21 Apr 2005 10:27:51 -0000
Received: from 216-31-65-221.zianet.com (216.31.65.221)
  by 0 with SMTP; 21 Apr 2005 10:27:51 -0000
To: Petr Baudis <pasky@ucw.cz>
User-Agent: KMail/1.6.1
In-Reply-To: <20050421071104.GC31910@pasky.ji.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thursday 21 April 2005 01:11 am, Petr Baudis wrote:
> Dear diary, on Thu, Apr 21, 2005 at 02:20:27AM CEST, I got a letter
> where Steven Cole <elenstev@mesatop.com> told me that...
> > Actually, I meant "patch -p1 <stuff_from_above".
> 
> So, how did it end up?

The file listed in the diff was already patched, so applying that
output does the expected:
[steven@spc git-pasky-0.6.2-damaged]$ patch -p1 <xyzzy.diff
patching file gitcancel.sh
Reversed (or previously applied) patch detected!  Assume -R? [n] n
Apply anyway? [n] n
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file gitcancel.sh.rej

> 
> Actually, never mind. I forgot that I bring the local changes forward as
> patches instead. So this is Harmless (tm). It means the patch containing
> your local changes has just that kind of git diff output containing
> filename: hash. I will probably just chain grep -v '^[^+-@ ]' in front
> of patch. (Someone starting his filename with a space _deserves_ the
> trouble. ;-)
> 
> > But before doing that, I did a fsck-cache as follows, with these results.
> > This seems damaged.
> > 
> > [steven@spc git-pasky-0.6.2]$ fsck-cache --unreachable $(cat .git/HEAD)
> 
> You can't do just this. In Cogito repository, you may have multiple
> branches, each with different HEAD of course. So you need to
> 
> 	fsck-cache --unreachable $(cat .git/heads/*)
> 

[steven@spc git-pasky-0.6.2]$ fsck-cache  $(cat .git/heads/*)
root 1bf00e46973f7f1c40bc898f1346a1273f0a347f
dangling commit 2c1a8048d56cfbe0ff8a3d04c12d06f3832e7edc
dangling commit a387546d148df5718a9c53bbe0cbea441e793d98
dangling blob d6ff9de73fc920cf1f27afac82571c4c58526b80

[steven@spc git-pasky-0.6.2]$ ./git-prune-script

Ah, yes. Prune juice.

[steven@spc git-pasky-0.6.2]$ fsck-cache --unreachable $(cat .git/heads/*)
root 1bf00e46973f7f1c40bc898f1346a1273f0a347f

Now, all is well.  Sorry for the noise.

Steven


