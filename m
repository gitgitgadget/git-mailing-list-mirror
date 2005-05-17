From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: git-rev-list  in local commit order
Date: Tue, 17 May 2005 09:52:00 +0000
Organization: linutronix
Message-ID: <1116323520.17296.12.camel@tglx.tec.linutronix.de>
References: <4127.10.10.10.24.1116107046.squirrel@linux1>
	 <1116186533.11872.152.camel@tglx>
	 <4971.10.10.10.24.1116187076.squirrel@linux1>
	 <1116189873.11872.171.camel@tglx>
	 <1102.10.10.10.24.1116189916.squirrel@linux1>
	 <1116191636.11872.195.camel@tglx>
	 <1273.10.10.10.24.1116192097.squirrel@linux1>
	 <1116192629.11872.201.camel@tglx>
	 <1392.10.10.10.24.1116193437.squirrel@linux1>
	 <1116195235.11872.213.camel@tglx>
	 <1629.10.10.10.24.1116278725.squirrel@linux1>
	 <Pine.LNX.4.58.0505161638090.18337@ppc970.osdl.org>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 11:52:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXyjt-0005hj-Dv
	for gcvg-git@gmane.org; Tue, 17 May 2005 11:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVEQJwJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 05:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVEQJwJ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 05:52:09 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:38831
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261347AbVEQJwA
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2005 05:52:00 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 384B065C003;
	Tue, 17 May 2005 11:51:42 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 608BC280C4;
	Tue, 17 May 2005 11:51:59 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505161638090.18337@ppc970.osdl.org>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-05-16 at 16:46 -0700, Linus Torvalds wrote:
> Yes. I'm not ahuge fan of the notion of "repo ID's". One reason is that I
> actually really really like the notion of anonymous repositories, so that
> when I do something stupid, and blow away one of my less successful
> repositories and continue with another one, nobody ever sees it (and yes,
> this happens - in my BK usage I occasionally cloned my repo for some
> testing, and then ended up using the _cloned_ repo for the real work, and
> totally blowing away ymy original one, and renamed my cloned one back to
> where my main one is).

What you blow away is a work space. But at the end you push the result
of whatever work space you kept into a public available repository. Also
BK stores a somewhat hidden repository (not workspace) id.

My idea of repository id was not the notion of workspace seperation. I
dont care in which directory and on which machine you or who ever
commits a line of code. I care where the change appears in a public
repository, which is unique.

> I don't see why people don't just use the "committer" name for this.  
> That's really what you want, and it ends up being a very good
> approximation of "repository ID" for a commit. Sure, people end up having
> multiple reposiories, and thus you'll occasionally see merges that end up
> merging two heads with the same "repo ID", but does anybody really care? I
> doubt it.

I came up with this after I started "git tracker" and David Woodhouse
asked me to make it possible to look at the history of his repository
from the repositiory POV rather than from the cloned global history of
torvalds/linux-2.6.git. 

Sure I have retrieved the information from committer name and committer
mail, but when I tried to do the same with Dave Millers and Gregs
repositories it turned out to be impossible as they use the same
name/mail for each of their repositories.

> For example, if you have a company Q&A policy that says that you want to 
> keep commits to different repos separate, just make sure that those repos 
> are on different machines or are accessed with different users. Or write 
> some simple wrapper scripts that make sure to set GIT_COMMITTER_EMAIL to 
> the proper value (say, the wrapper could be as simple as
> 
> 	#!/bin/sh
> 	export GIT_COMMITTER_EMAIL=$(cat .git/committer_email)
> 	real-git-commit "$@"
> 
> and then you just create a ".git/committer_email" file per repository that 
> contains the "repo ID" you want to fake.

Might be a workable solution. I would prefer if this would be a part of
the core plumbing.
Would you accept a patch for commit-tree which tries to check this file
for existance and use the content in case its there?

tglx


