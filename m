From: Christopher Li <git@chrisli.org>
Subject: Re: CAREFUL! No more delta object support!
Date: Tue, 28 Jun 2005 07:06:25 -0400
Message-ID: <20050628110625.GC21533@64m.dyndns.org>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org> <20050627235857.GA21533@64m.dyndns.org> <Pine.LNX.4.58.0506272016420.19755@ppc970.osdl.org> <7vekamvmxj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 16:23:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnGyh-0008Dm-Fr
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 16:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVF1OWy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 10:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVF1OUx
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 10:20:53 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:44162 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261675AbVF1OTN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2005 10:19:13 -0400
Received: from localhost.localdomain (c-24-6-236-77.hsd1.ca.comcast.net[24.6.236.77])
          by comcast.net (sccrmhc13) with ESMTP
          id <2005062814191001600i3pt7e>; Tue, 28 Jun 2005 14:19:10 +0000
Received: by localhost.localdomain (Postfix, from userid 1027)
	id 79FB33F17F; Tue, 28 Jun 2005 07:06:25 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vekamvmxj.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 28, 2005 at 02:40:56AM -0700, Junio C Hamano wrote:
> >>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
> Still a good space reduction.  Good job!
> 
> I am now dreaming if we someday would enhance the mechanism with
> append-only updates to the *.pack files with complete rewrite of
> the *.idx files, and get rid of files under .git/objects totally.

No offense my friend, this has been done. It's name is mercurial.

> This would make things reasonably friendly to rsync.  The kernel
> pack has around 60M pack with 1.1M index, so everyday use would
> involve incremental updates to the pack [*1*] and full download
> of the index file.

It still have other open issue. Now it would be harder to not sync
all the heads. If I just want the clean Linus-2.6 tree, I have to
dig it out from the pack file which mixing with other heads. 

You could host different projects with it's own pack file. That
will lost the space saving on co-hosting projects.

So I am not convince rsync is the way to go in long run. You need
to have your own network syncing method.

> 
> [Footnote]
> 
> *1* Presumably many objects are deltified against older objects
> which is suboptimal.  Most likely the newer objects are accessed
> far more often and they are what we would want to keep in full
> not as delta.  So even with this scheme we would want to have
> weekly repacking.  Interestingly enough, pack-objects gets the
> objects via usual read_sha1_file() interface so it can produce a
> new pack from an existing pack.

It sounds like you are suggesting backward delta. Keeping the
latest node in full and using delta to access the old one. It should
work but it will lose the append only property.

Chris
