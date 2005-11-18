From: sf <sf@b-i-t.de>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes through
Date: Fri, 18 Nov 2005 14:57:05 +0100
Message-ID: <437DDDB1.60103@b-i-t.de>
References: <20051117230723.GD26122@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 18 15:04:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed6pE-00078N-Ei
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 15:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVKROC2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 09:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbVKROC2
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 09:02:28 -0500
Received: from main.gmane.org ([80.91.229.2]:44508 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750732AbVKROC2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 09:02:28 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ed6mI-00065b-T5
	for git@vger.kernel.org; Fri, 18 Nov 2005 14:59:47 +0100
Received: from ip-213157000067.dialin.heagmedianet.de ([213.157.0.67])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Nov 2005 14:59:46 +0100
Received: from sf by ip-213157000067.dialin.heagmedianet.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Nov 2005 14:59:46 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip-213157000067.dialin.heagmedianet.de
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
In-Reply-To: <20051117230723.GD26122@nowhere.earth>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12232>

Yann Dirson wrote:
...
> Current commit objects refer to a child tree, but to parent _commits_.
> Whereas it seems necessary to walk through the history line, and
> easily get a changelog, it is semantically quite not right: the
> changes we record with a commit indeed come from modification of
> trees, not of commits.  That is, the resulting tree does not depend on
> the history of the parent trees, but on the parent trees themselves.

I would go even further: The resulting tree does not depend on anything. 
A tree is a tree is a tree.

A commit is really just the statement: "I changed the tree from state A 
to state B". After all, the commit message does not describe the new 
state (neither the old state) but does describe the changes.

> And similarly, tags usually denote a particular state of the tree,
> "somewhat" independantly of its history: linux-2.6.11 is the same
> beast, whereas the repository holds full history since 0.1 or not.

Exactly, the tree "linux-2.6.11" is the tree "linux-2.6.11". How it came 
about is totally irrelevant if you are only interested in this 
particular version (does anyone download all linux-*.tar.bz2 just to get 
  linux-2.6.11.tar.bz2?).

> Indeed that emphasizes that the history lines are on living on a
> higher level of abstraction that commits.  Now what if we used
> trees->tree commits, instead of the current commits->tree ones ?  The
> main problem would be to be able to reconstruct those history lines,
> so that we can still extract the log - what's a better model if we
> loose functionnality ? ;)

You can traverse tree -> commit -> tree -> commit -> tree ... to get the 
history. No functionality lost.

> However, I must admit that at this point, I have not found a
> reasonable solution to this problem.
> 
> Any genius with a solution out there ? :)

In your model you have a mapping from commits to sets of trees (by way 
of commit objects). Now you create the "inverse" mapping from trees to 
sets of commits. Both mappings together enable you to walk the history.

Why is git's model different?

1. You have to watch out for circles in history (Git's model ensures 
that history is always a DAG).

2. Your model is harder to implement in the typical case (But deleting 
from repositiories, partial repositories, augmenting or cutting history 
etc. are hard to implement as it is now, if not outright impossible).

3. It is the way repositories have been organized ever since CVS (Git 
throws out some concepts of the CVS model, but not all).


Regards
	Stephan
