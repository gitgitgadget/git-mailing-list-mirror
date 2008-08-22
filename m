From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: nicer frontend to get rebased tree?
Date: Fri, 22 Aug 2008 13:29:39 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808221301300.3487@nehalem.linux-foundation.org>
References: <20080822174655.GP23334@one.firstfloor.org> <alpine.LFD.1.10.0808221053080.3487@nehalem.linux-foundation.org> <20080822182718.GQ23334@one.firstfloor.org> <alpine.LFD.1.10.0808221233100.3487@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 22:31:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWdI0-000101-3W
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 22:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbYHVUaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 16:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbYHVUaO
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 16:30:14 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52476 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753751AbYHVUaM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Aug 2008 16:30:12 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7MKTdDF031741
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Aug 2008 13:29:40 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7MKTd3t015018;
	Fri, 22 Aug 2008 13:29:39 -0700
In-Reply-To: <alpine.LFD.1.10.0808221233100.3487@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.429 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93357>



On Fri, 22 Aug 2008, Linus Torvalds wrote:
> 
> So what you can do is to "git fetch" it (to download it), and then "git 
> checkout" to create a temporary checkout. That's pretty much all you can 
> do with linux-next.

.. oh, and you can also do a throw-away branch and test what a merge would 
look like when merged into linux-next. 

Basically there's a few sane sequences you can do with linux-next:

 - They all basically start with "fetch and test":

	# This obviously assumes you have set up 'linux-next' as a branch
	# earlier by either editing .git/config or using 'git remote add'
	# or something

	git fetch linux-next

	git checkout linux-next/master
	.. this will create a _temporary_ branch ("detatched head") ..
	.. you can now compile, install, boot this state ..

   repeat as necessary, but never actually do anything else with that 
   detached branch (do a "git checkout master" to get back to a sane 
   state)

and after that you can do some things:

 - You can do throw-away work on that temporary branch: you can fix up 
   crap when it doesn't compile etc, but you should always remember that 
   it's purely throw-away, beacuse all of linux-next is throw-away, and 
   gets re-created from scratch each time.

   In particular, one useful "throw-away" thing to do is to test what 
   would happen if all the crud on linux-next is merged with whatever you 
   have done youself. So assuming you're still on that throw-away branch 
   (aka "detached head": "git branch" will say "* (no branch)" is your 
   current branch), you can do things like

	git merge master

   to merge in your own work on top of linux-next, but as a total 
   throw-away (which is what you want: you can never use the state for 
   anything else anyway, and you do _not_ want to pollute your real work 
   in "master" by merging in the throw-away linux-next into that!)

but what you should _never_ do is to forget that you're on the throw-away 
branch, and do any real development.

			Linus
