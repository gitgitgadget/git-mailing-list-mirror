From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list  in local commit order
Date: Mon, 16 May 2005 16:46:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505161638090.18337@ppc970.osdl.org>
References: <4127.10.10.10.24.1116107046.squirrel@linux1>                  
        <1116186533.11872.152.camel@tglx>                         
 <4971.10.10.10.24.1116187076.squirrel@linux1>                         
 <1116189873.11872.171.camel@tglx>                         
 <1102.10.10.10.24.1116189916.squirrel@linux1>                         
 <1116191636.11872.195.camel@tglx>                         
 <1273.10.10.10.24.1116192097.squirrel@linux1>                         
 <1116192629.11872.201.camel@tglx>                         
 <1392.10.10.10.24.1116193437.squirrel@linux1>                        
 <1116195235.11872.213.camel@tglx> <1629.10.10.10.24.1116278725.squirrel@linux1>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: tglx@linutronix.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 01:47:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXpI3-0006SG-TX
	for gcvg-git@gmane.org; Tue, 17 May 2005 01:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVEPXqw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 19:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVEPXqw
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 19:46:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:39404 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261985AbVEPXqt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2005 19:46:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4GNikU3030779
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 May 2005 16:44:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4GNij47003528;
	Mon, 16 May 2005 16:44:46 -0700
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <1629.10.10.10.24.1116278725.squirrel@linux1>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.39__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 16 May 2005, Sean wrote:
> 
> And you also haven't addressed what to do when someone else uses say,
> Linus' repoid, as their own.  It seems like a risk to have the operation
> of each repository depend on a value anyone else can duplicate.  Linus
> can't control what repoid everyone else uses, he can control the time on
> his own machine.  Unique repoid's are an illusion.

Yes. I'm not ahuge fan of the notion of "repo ID's". One reason is that I
actually really really like the notion of anonymous repositories, so that
when I do something stupid, and blow away one of my less successful
repositories and continue with another one, nobody ever sees it (and yes,
this happens - in my BK usage I occasionally cloned my repo for some
testing, and then ended up using the _cloned_ repo for the real work, and
totally blowing away ymy original one, and renamed my cloned one back to
where my main one is).

That said, while I actually think that time/date matters, I don't think it 
should matter a lot.

I don't see why people don't just use the "committer" name for this.  
That's really what you want, and it ends up being a very good
approximation of "repository ID" for a commit. Sure, people end up having
multiple reposiories, and thus you'll occasionally see merges that end up
merging two heads with the same "repo ID", but does anybody really care? I
doubt it.

For example, if you have a company Q&A policy that says that you want to 
keep commits to different repos separate, just make sure that those repos 
are on different machines or are accessed with different users. Or write 
some simple wrapper scripts that make sure to set GIT_COMMITTER_EMAIL to 
the proper value (say, the wrapper could be as simple as

	#!/bin/sh
	export GIT_COMMITTER_EMAIL=$(cat .git/committer_email)
	real-git-commit "$@"

and then you just create a ".git/committer_email" file per repository that 
contains the "repo ID" you want to fake.

		Linus
