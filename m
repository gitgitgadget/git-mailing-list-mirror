From: Junio C Hamano <junkio@cox.net>
Subject: Re: Merge with git-pasky II.
Date: Thu, 14 Apr 2005 12:59:04 -0700
Message-ID: <7v7jj5qgdz.fsf@assigned-by-dhcp.cox.net>
References: <20050414002902.GU25711@pasky.ji.cz>
	<20050413212546.GA17236@64m.dyndns.org>
	<20050414004504.GW25711@pasky.ji.cz>
	<Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
	<7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
	<7v64ypsqev.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	<20050414121624.GZ25711@pasky.ji.cz>
	<7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 21:57:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMASC-0004Bv-7C
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 21:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVDNT7j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 15:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVDNT7b
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 15:59:31 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:15794 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261489AbVDNT7J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 15:59:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050414195906.HAZJ19936.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 14 Apr 2005 15:59:06 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 14 Apr 2005 11:36:52 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Thu, 14 Apr 2005, Junio C Hamano wrote:

>> Sorry, I have not seen what you have been doing since pasky 0.3,
>> and I have not even started to understand the mental model of
>> the world your tool is building.  That said, my gut feeling is
>> that telling this script about git-pasky's world model might be
>> a mistake.  I'd rather see you consider the script as mere "part
>> of the plumbing". 

LT> I agree. Having separate abstraction layers is good.  I'm actually very 
LT> happy with Pasky's cleaned-up-tree, exactly because unlike the first one, 
LT> Pasky did a great job of maintaining the abstraction between "plumbing" 
LT> and user interfaces.

Agreed, not just with your agreeing with me, but with the
statement that Pasky did a good job (although I am ashamed to
say I have not caught up with the "userland" tools).

LT> The plumbing should take user interface needs into account, but the more
LT> conceptually separate it is ("does it makes sense on its own?") the better
LT> off we'll be. And "merge these two trees" (which works on a _tree_ level)
LT> or "find the common commit" (which works on a _commit_ level) look like 
LT> plumbing to me - the kind of things I should have written, if I weren't 
LT> such a lazy slob.

I am planning drop the ancestor computation from the script, and
make it another command line parameter to the script.  Dan
Barkalow's merge-base program should be used to compute it and
his result should drive the merge.  That sounds more UNIXy to
me.  I even may want to make the script take three trees not
commits, since the merge script does not need commits (it only
needs trees).  As plumbing it would be cleaner interface to it
to do so.  The wrapper SCM scripts can and should make sure it
is fed trees when the user gives it commits (or symbolic
representation of it like .git/tags/blah, or `cat .git/HEAD`).

But one different thing to note here.

You say "merge these two trees" above (I take it that you mean
"merge these two trees, taking account of this tree as their
common ancestor", so actually you are dealing with three trees),
and I am tending to agree with the notion of merging trees not
commits.  However you might get richer context and more sensible
resulting merge if you say "merge these two commits".  Since
commit chaining is part of the fundamental git object model you
may as well use it.

This however opens up another set of can of worms---it would
involve not just three trees but all the trees in the commit
chain in between.  That's when you start wondering if it would
be better to add renames in the git object model, which is the
topic of another thread.  I have not formed an opinion on that
one myself yet.

