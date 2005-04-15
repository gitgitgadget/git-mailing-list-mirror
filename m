From: Junio C Hamano <junkio@cox.net>
Subject: Re: Merge with git-pasky II.
Date: Thu, 14 Apr 2005 17:58:25 -0700
Message-ID: <7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
	<7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
	<7v64ypsqev.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	<20050414121624.GZ25711@pasky.ji.cz>
	<7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	<20050414193507.GA22699@pasky.ji.cz>
	<7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
	<20050414233159.GX22699@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 02:57:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMF9W-0007Es-8Y
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 02:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVDOBAz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 21:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVDOA74
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 20:59:56 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:52926 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261689AbVDOA61 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 20:58:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050415005826.HZJU1282.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 14 Apr 2005 20:58:26 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050414233159.GX22699@pasky.ji.cz> (Petr Baudis's message of
 "Fri, 15 Apr 2005 01:31:59 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
>> I think the above would result in what SCM person would call
>> "merge upstream/sidestream changes into my working directory".

PB> And that's exactly what I'm doing now with git merge. ;-) In fact,
PB> ideally the whole change in my scripts when your script is finished
PB> would be replacing

PB> 	checkout-cache `diff-tree` # symbolic
PB> 	git diff $base $merged | git apply

PB> with

PB> 	merge-tree.pl -b $base $(tree-id) $merged | parse-your-output

In the above I presume by $merged you mean the tree ID (or
commit ID) the user's working directory is based upon?  Well,
merge-trees (Linus has a single directory merge-tree already)
looks at tree IDs (or commit IDs); it would never involve
working files in random state that is not recorded as part of a
tree (committed or not).  Given that constraints I am not sure
how well that would pan out.  I have to think about this a bit.

I do like, however, the idea of separating the step of doing any
checkout/merge etc. and actually doing them.  So the command set
of parse-your-output needs to be defined.  Based on what I have
done so far, it would consist of the following:

 - Result is this object $SHA1 with mode $mode at $path (takes
   one of the trees); you can do update-cache --cacheinfo (if
   you want to muck with dircache) or cat-file blob (if you want
   to get the file) or both.

 - Result is to delete $path.

 - Result is a merge between object $SHA1-1 and $SHA1-2 with
   mode $mode-1 or $mode-2 at $path.

Would this be a good enough command set?

PB> Doesn't Emacs have something equivalent to ./.vimrc? I've also seen
PB> those funny -*- strings.

The former is global per user (that is me including other Perl
files I work outside of git context), which is exactly what I
said is unacceptable to me.  The latter is per file (applying to
everybody else who touch the file), so if it is short and sweet
I should use one.

