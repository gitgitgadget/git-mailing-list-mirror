From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes
 through
Date: Sat, 19 Nov 2005 16:27:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511191612350.4895@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051117230723.GD26122@nowhere.earth>
 <Pine.LNX.4.63.0511180026080.18775@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051119140404.GD3393@nowhere.earth> <20051119141341.GE3393@nowhere.earth>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Sat Nov 19 16:28:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdUd1-0001fp-HA
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 16:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbVKSP1R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 10:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVKSP1R
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 10:27:17 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:48869 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751105AbVKSP1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 10:27:16 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BEC5413FCD9; Sat, 19 Nov 2005 16:27:15 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9B603B5262; Sat, 19 Nov 2005 16:27:15 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7DE8BB5215; Sat, 19 Nov 2005 16:27:15 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F07041401F3; Sat, 19 Nov 2005 16:27:12 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20051119141341.GE3393@nowhere.earth>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12342>

Hi,

On Sat, 19 Nov 2005, Yann Dirson wrote:

> - 1st level describes states that existed
> - 2nd level describes events that occured, causing the state to change
> - 3rd level describes the succession of events

But using git's approach you have these levels. Only that you do not 
strictly record them as such:

	- 1st level is trees, agreed.

	- 2nd level is inside the commits, i.e. if you look at the tree(s)
	  of the parent commit(s), you can extract that tree->tree change.

	- 3rd level is not just the succession of events: commit->commit
	  is much stronger.

By the last, I mean that in the commit, by referencing the parent(s) 
(which itself references its parent(s)) you have the whole history. And by 
validating the commit object by its SHA1, you have the history immutable, 
too.

Now, the original purpose of this thread was to discuss a way to un-graft 
some commit objects, i.e. to re-record a history which was not recorded as 
such.

This may be nice for completeness purposes, but it contradicts the main 
idea behind git: You want to be certain about things. By signing off on 
some commit (together with the meta information about its parent(s) and 
the tree), you state that you actually placed your work on *that* 
particular history. And if you based your work on a commit I have, I can 
be certain that we agree.

The proposed rewriting of the history is very lax about that:

Say, you introduce a history line, where you start with -- say -- some 
obsolete proprietary code from some telephone company, and then change -- 
say, by a primitive algorithm -- the code to match git-0.99.8, all the 
time committing with some random commit message.

Then you make a graft which says git-0.99.8 was derived from that history 
, too. Now, you ungraft the tree. It looks like other developers and I 
signed off on working on a "derivative" of some obscure, copyrighted code.

Nice?

Hth,
Dscho
