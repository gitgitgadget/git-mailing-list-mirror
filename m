From: Steven Cole <elenstev@mesatop.com>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Tue, 19 Apr 2005 17:04:48 -0600
Message-ID: <200504191704.48976.elenstev@mesatop.com>
References: <20050419043938.GA23724@kroah.com> <426583D5.2020308@mesatop.com> <Pine.LNX.4.58.0504191525290.2274@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Greg KH <greg@kroah.com>, Greg KH <gregkh@suse.de>,
	Git Mailing List <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
X-From: git-owner@vger.kernel.org Wed Apr 20 01:05:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1m0-0001Km-AA
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 01:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVDSXI6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 19:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVDSXI6
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 19:08:58 -0400
Received: from nacho.zianet.com ([216.234.192.105]:2319 "HELO nacho.zianet.com")
	by vger.kernel.org with SMTP id S261737AbVDSXIt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 19:08:49 -0400
Received: (qmail 15258 invoked from network); 19 Apr 2005 23:08:47 -0000
Received: from 216-31-65-7.zianet.com (216.31.65.7)
  by 0 with SMTP; 19 Apr 2005 23:08:47 -0000
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.6.1
In-Reply-To: <Pine.LNX.4.58.0504191525290.2274@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tuesday 19 April 2005 04:38 pm, Linus Torvalds wrote:
> 
> On Tue, 19 Apr 2005, Steven Cole wrote:
> >
> > But perhaps a progress bar right about here might be
> > a good thing for the terminally impatient.
> > 
> > real    3m54.909s
> > user    0m14.835s
> > sys     0m10.587s
> > 
> > 4 minutes might be long enough to cause some folks to lose hope.
> 
> Well, the real operations took only 15 seconds. What kind of horribe 
> person are you, that you don't have all of the kernel in your disk cache 
> already? Shame on you.
> 
> Or was the 4 minutes for downloading all the objest too?

Yes, I was using a very recent version of the pasky tools,
I had created the repo this morning with git init YOUR_RSYC_URL_FOR_LINUX-2.6.
I did time git pull origin and watched the fur fly.

Then, the flurry of patching file blah messages, followed by a rather 
pregnant pause after the last patching message.

I wasn't complaining about the 4 minutes, just the lack of feedback
during the majority of that time.  And most of it was after the last
patching file message.

> 
> Anyway, it looks like you are using pasky's scripts, and the old 
> "patch-based" upgrade at that. You certainly will _not_ see the
> 
> 	[many files patched]
> 	patching file mm/mmap.c
> 	..
> 
> if you use a real git merge. That's probable be the real problem here.
> 
> Real merges have no patches taking place _anywhere_. And they take about 
> half a second. Doing an "update" of your tree should _literally_ boil down 
> to
> 
> 	#
> 	# "repo" needs to point to the repo we update from
> 	#
> 	rsync -avz --ignore-existing $repo/objects/. .git/objects/.
> 	rsync -L $repo/HEAD .git/NEW_HEAD || exit 1
> 	read-tree -m $(cat .git/NEW_HEAD) || exit 1
> 	checkout-cache -f -a
> 	update-cache --refresh
> 	mv .git/NEW_HEAD .git/HEAD
> 
> and if it does anything else, it's literally broken. Btw, the above does
> need my "read-tree -m" thing which I committed today.
> 
> (CAREFUL: the above is not a good script, because it _will_ just overwrite 
> all your old contents with the stuff you updated to. You should thus not 
> actually use something like this, but a "git update" should literally end 
> up doing the above operations in the end, and just add proper checking).
> 
> And if that takes 4 minutes, you've got problems.
> 
> Just say no to patches. 
> 
> 		Linus
> 
> PS: If you want a clean tree without any old files or anything else, for
> that matter, you can then do a "show-files -z --others | xargs -0 rm", but
> be careful: that will blow away _anything_ that wasn't revision controlled
> with git. So don't blame me if your pr0n collection is gone afterwards.
> 

OK.  I may try some of this tomorrow from work, where I have a fat pipe.

I'm on dialup from home, and I suspect not very many folks want to hear
the sad tale of how long it takes to get the kernel over 56k dialup.

Steven
