From: Paul Mackerras <paulus@samba.org>
Subject: Re: Gitk feature - show nearby tags
Date: Sun, 4 Jun 2006 11:59:43 +1000
Message-ID: <17538.16015.53244.876090@cargo.ozlabs.ibm.com>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com>
	<7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550606030416s2ef6182crbde1395dd29e5b94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Jonas Fonseca" <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sun Jun 04 04:00:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmhuI-0005jU-N8
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 03:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWFDB7v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 21:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWFDB7v
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 21:59:51 -0400
Received: from ozlabs.org ([203.10.76.45]:59329 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751268AbWFDB7u (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 21:59:50 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 0AA9C67A0E; Sun,  4 Jun 2006 11:59:49 +1000 (EST)
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550606030416s2ef6182crbde1395dd29e5b94@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21240>

Marco Costalba writes:

> If I have understood correctly the patch runs a 'git rev-list --all
> --topo-order --parents'
> and then does a tree walking.

Yes, that's right.  It means that gitk can show the nearest tags even
if they aren't included in the current view.

> I am wandering if there exist any native git way to found the previous tag.

I don't know of any.  Doing the tree walking in Tcl turned out to be
not too much of an overhead, though; it does the whole kernel
repository in 1.5 seconds on my G5.

> As example given a selected revision with id <sha> is it possible to
> do something like this to fond the ancestor?
> 
> 1) get the tag list with git-peek-remote or something similar if tags
> are not already loaded
> 
> 2) given the tagList vector with n elements run
> 
>     git-rev-list  --topo-order <sha> ^tagList[0]  ^tagList[1]   ....
>   ^tagList[n-1]
> 
> 3) take the last sha spit out by git-rev-list, be it <lastSha>.
> 
> 4) Previous nearest tag is the parent of lastSha
> 
> I've missed something?

I'm not sure exactly what that would do, but gitk can show more than
one tag (the term "nearest tag" is only a shorthand approximation for
what it does).  For example, if you have two tagged commits where
neither is an ancestor of the other, and do a merge of the two, gitk
will show both tags when you select the merge.  It doesn't actually
happen in the kernel repository, though, because the tags there form a
linear list (at least the tags in the upstream repository do).

Paul.
