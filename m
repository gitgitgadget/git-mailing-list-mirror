From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 21:54:52 +0200
Message-ID: <20050415195451.GF7417@pasky.ji.cz>
References: <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org> <7v64ypsqev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org> <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <20050414193507.GA22699@pasky.ji.cz> <7vmzs1osv1.fsf@assigned-by-dhcp.cox.net> <20050414233159.GX22699@pasky.ji.cz> <7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 21:52:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMWql-0007JU-VW
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 21:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVDOTzD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 15:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbVDOTzD
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 15:55:03 -0400
Received: from w241.dkm.cz ([62.24.88.241]:7648 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261945AbVDOTyx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 15:54:53 -0400
Received: (qmail 19257 invoked by uid 2001); 15 Apr 2005 19:54:52 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 15, 2005 at 02:58:25AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
> >> I think the above would result in what SCM person would call
> >> "merge upstream/sidestream changes into my working directory".
> 
> PB> And that's exactly what I'm doing now with git merge. ;-) In fact,
> PB> ideally the whole change in my scripts when your script is finished
> PB> would be replacing
> 
> PB> 	checkout-cache `diff-tree` # symbolic
> PB> 	git diff $base $merged | git apply
> 
> PB> with
> 
> PB> 	merge-tree.pl -b $base $(tree-id) $merged | parse-your-output
> 
> In the above I presume by $merged you mean the tree ID (or
> commit ID) the user's working directory is based upon?  Well,
> merge-trees (Linus has a single directory merge-tree already)
> looks at tree IDs (or commit IDs); it would never involve
> working files in random state that is not recorded as part of a
> tree (committed or not).  Given that constraints I am not sure
> how well that would pan out.  I have to think about this a bit.

No, $(tree-id) is the "destination branhc", what the user directory is
based upon; $merged is the branch you are merging now, relative to
$base. When I throw away the useless "-b" argument, in practice it would
look like

	merge-trees abcd 1234 5678

for doing

      /------ 1234 -+-
abcd <             /
      \------ 5678

(not that the order of 1234 and 5678 would actually really matter)

I fear I don't understand the rest of your paragraph. :-(

> I do like, however, the idea of separating the step of doing any
> checkout/merge etc. and actually doing them.  So the command set
> of parse-your-output needs to be defined.  Based on what I have
> done so far, it would consist of the following:
> 
>  - Result is this object $SHA1 with mode $mode at $path (takes
>    one of the trees); you can do update-cache --cacheinfo (if
>    you want to muck with dircache) or cat-file blob (if you want
>    to get the file) or both.
> 
>  - Result is to delete $path.
> 
>  - Result is a merge between object $SHA1-1 and $SHA1-2 with
>    mode $mode-1 or $mode-2 at $path.
> 
> Would this be a good enough command set?

What about the conflicts? Like one tree deleting, other tree modifying?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
