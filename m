From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: rsync update appears broken now
Date: Thu, 20 Oct 2005 10:48:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510201038320.3369@g5.osdl.org>
References: <86vezs9wy9.fsf@blue.stonehenge.com>
 <81b0412b0510200608l61c00ed0yd4dbc00c313665fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 20 19:58:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESedU-00070n-6T
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 19:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbVJTRzZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 13:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbVJTRzZ
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 13:55:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35280 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932510AbVJTRzY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 13:55:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9KHmmFC020565
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 20 Oct 2005 10:48:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9KHmkwm032597;
	Thu, 20 Oct 2005 10:48:47 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <81b0412b0510200608l61c00ed0yd4dbc00c313665fe@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10373>



On Thu, 20 Oct 2005, Alex Riesen wrote:
> 
> Absolutely normal pull into a changed repository. Just fix the
> conflict (in fetch-pack.c, look for >>>), git-update-index the file
> and commit. Doesn't look like a problem at all.

No, that's wrong.

The fact is, Junio has screwed up his repository, and if you merge, you'll 
never have something that matches _his_ repository.

To fix this, _Junio_ needs to fix his repository.

For those of us who have a separate branch to track the original (I call 
mine "parent), this tells the story:

	* refs/heads/parent: does not fast forward to branch 'master' of master.kernel.org:/pub/scm/git/git;
	  not updating.

IOW, it looks like Junio has screwed up his "master" branch on kernel.org 
and it no longer contains what it used to contain (and this is not a 
mirroring problem - I'm using "master.kernel.org" with no mirrors in 
between).

Doing a

	git fetch parent master:new-junio

followed by a

	gitk parent new-junio

shows that Junio seems to have re-based his "master" branch by removing 
his old top-most entry, and restarted the "master" branch, which is wrong, 
wrong, wrong.

Junio, please don't do that. It really screws people up. Now people can't 
fetch your head any more, and can't track you, because your branch isn't 
stable any more. I know you're very used to doing so in your "pu" branch, 
but it's _wrong_. It's wrong in "pu" too, but at least there you have an 
excuse.

Reparenting things is ok in _private_ branches, but it's not ok in public 
ones, since _others_ will have worked or at least downloaded the previous 
state.

The fact is, "distributed" fundamentally means "mistakes cannot be 
undone". Mistakes have to be _fixed_, not removed. Because the mistakes 
have already percolated to others.

			Linus
