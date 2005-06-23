From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Wed, 22 Jun 2005 22:04:31 -0400
Message-ID: <42BA18AF.2070406@pobox.com>
References: <42B9E536.60704@pobox.com> <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 04:02:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlH2R-0005Wz-DN
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 04:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVFWCHt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 22:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVFWCGR
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 22:06:17 -0400
Received: from mail.dvmed.net ([216.237.124.58]:36273 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262014AbVFWCEj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 22:04:39 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DlH50-0002uo-Ed; Thu, 23 Jun 2005 02:04:35 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> A few notes on these things:
> 
> 	git-apply --index /tmp/my.patch
> 
> will not only apply the patch (unified patches only!), but will do the
> index updates for you while it's at it, so if the patch contains new files
> (or it deletes files), you don't need to worry about it.

The output isn't terribly helpful:

[jgarzik@pretzel netdev-2.6]$ git apply --index \
	~/tmp/linux-2.6.12-rc4-cxgb2.1.1.patch
Fragment applied at offset 11

That is worse than no message at all...  fragment?  offset 11?  did it 
work?  Did it apply only a "fragment" of my patch, not the whole thing? 
  I'm worried! </mental monologue>

Outputting the following (stolen from 'git commit') would be far more 
useful:

       modified: Documentation/networking/cxgb.txt
       modified: drivers/net/chelsio/Makefile
       deleted:  drivers/net/chelsio/ch_ethtool.h
       modified: drivers/net/chelsio/common.h
       modified: drivers/net/chelsio/cphy.h
       modified: drivers/net/chelsio/cpl5_cmd.h
       modified: drivers/net/chelsio/cxgb2.c
       deleted:  drivers/net/chelsio/cxgb2.h
       modified: drivers/net/chelsio/elmer0.h
       modified: drivers/net/chelsio/espi.c
       modified: drivers/net/chelsio/espi.h
       modified: drivers/net/chelsio/gmac.h
       modified: drivers/net/chelsio/mv88x201x.c
       deleted:  drivers/net/chelsio/osdep.h
       modified: drivers/net/chelsio/pm3393.c
       modified: drivers/net/chelsio/regs.h
       modified: drivers/net/chelsio/sge.c
       modified: drivers/net/chelsio/sge.h
       modified: drivers/net/chelsio/subr.c
       modified: drivers/net/chelsio/suni1x10gexp_regs.h
       deleted:  drivers/net/chelsio/tp.c
       deleted:  drivers/net/chelsio/tp.h
       modified: include/linux/pci_ids.h


> Also, you can do
> 
> 	git commit <list-of-files-to-commit>
> 
> as a shorthand for
> 
> 	git-update-cache <list-of-files-to-commit>
> 	git commit
> 
> which some people will probably find more natural.

It would be natural if it functioned like 'bk citool' ;-)

	git commit --figure-out-for-me-what-files-changed

'git diff' can do this, so it's certainly feasible.

Obviously added/removed files would still require git-update-cache or 
git-commit<list of files>.


> "git-whatchanged" is useful if you actually want to see what the commits 
> _changed_, and then you often want to use the "-p" flag to see it as 
> patches. Also, it's worth pointing out the fact that you can limit it to 
> certain subdirectories (or individual files) etc, ie:
> 
> 	git-whatchanged -p drivers/net
> 
> since that is often what people want.
> 
> But if you just want the log, "git log" is faster and simpler and more 
> correct.

I usually want just two things:

1) browse the log

2) list changes in local tree that are not in $remote_tree, a la
	bk changes -L ../linux-2.6

I agree that seeing the merge csets is useful, that is why [being 
ignorant of 'git log'] I used git-changes-script.

	Jeff


