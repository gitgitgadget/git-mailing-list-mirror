From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes through
Date: Fri, 18 Nov 2005 16:54:20 +0100
Message-ID: <200511181654.21052.Josef.Weidendorfer@gmx.de>
References: <20051117230723.GD26122@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 18 16:57:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed8a8-0004OK-87
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 16:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVKRPy1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 10:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbVKRPy0
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 10:54:26 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:65152 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S932105AbVKRPy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 10:54:26 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id AC90428A0
	for <git@vger.kernel.org>; Fri, 18 Nov 2005 16:54:22 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.9
In-Reply-To: <20051117230723.GD26122@nowhere.earth>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12235>

On Friday 18 November 2005 00:07, Yann Dirson wrote:
> Current commit objects refer to a child tree, but to parent _commits_.
> Whereas it seems necessary to walk through the history line, and
> easily get a changelog, it is semantically quite not right: the
> changes we record with a commit indeed come from modification of
> trees, not of commits.

Yes. The change to a tree (which is equalent to 2 trees - new old and
the new one; or for merges multiple old ones and the new one) does not
depend on any history. Unfortunately, we have no separate object to
specify the "the change to a tree". We include this information into
the commit object, and thus, bind it to the history.

This could be changed in git, i.e. put the tree relationship into a
separate object; even comments could be split up in change related and
history related. The question is: is this useful, is there any
important usage scenario that rectifies such a change?
I do not really think so.

> That is, the resulting tree does not depend on 
> the history of the parent trees, but on the parent trees themselves.

No, the resulting tree is an independent object, it is the tree ;-)
Do not confuse this with the commit pointing to the tree.

> And similarly, tags usually denote a particular state of the tree,
> "somewhat" independantly of its history: linux-2.6.11 is the same
> beast, whereas the repository holds full history since 0.1 or not.

I agree that tags for tree objects are useful, but what is the problem?
You can do this already.

But tags for commit objects are equally useful, especially signed ones:
they include a fixed history which can not be changed. Eg. they include
all the people which attributed code to the project, and this is important
for license questions. This is the reason that "grafting" should stay
a local workaround.

That the concrete tag "linux-2.6.11" points to a commit, and not to the
tree object, probably was done on purpose; i.e. the creator of the tag
wanted to include the history. If not, he could have made the tag for the
tree object directly.

> Indeed that emphasizes that the history lines are on living on a
> higher level of abstraction that commits.

Hmm.. If you only have tree changes, there is no history. The history
specifies an order of the changes. The changes themselve do not include
any such order.

> Now what if we used 
> trees->tree commits, instead of the current commits->tree ones ?

It would be better to not talk about "commits" for tree changes (perhaps
with comments about the change). As said above, tree change objects
could be introduced. The question is why?

> The
> main problem would be to be able to reconstruct those history lines,
> so that we can still extract the log

No problem: You still have the chain of commits, and one commit points
to the parent commit(s) and the corresponding new introduced tree change
objects.

> - what's a better model if we 
> loose functionnality ? ;)

There is nothing lost. If you regard the comments entered at "git commit"
time as purely change related, this comments can be put together with the
tree change object. So if you "apply a graft to a tree", (signed) tags for tree
changes would include the comment, and stay valid after "regrafting".
But why would anyone want to sign a change?

> However, I must admit that at this point, I have not found a
> reasonable solution to this problem.
> 
> Any genius with a solution out there ? :)

What is the difficult problem here?

Josef
