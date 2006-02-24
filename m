From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Fri, 24 Feb 2006 16:12:14 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602241544270.31162@localhost.localdomain>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
 <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net>
 <20060224174422.GA13367@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
 <20060224183554.GA31247@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241350190.31162@localhost.localdomain>
 <20060224192354.GC387@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241438521.31162@localhost.localdomain>
 <20060224204022.GA15962@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 22:12:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCkEp-0000sC-Gg
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 22:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWBXVM2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 16:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWBXVM2
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 16:12:28 -0500
Received: from relais.videotron.ca ([24.201.245.36]:42474 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932499AbWBXVM1
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 16:12:27 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IV7008XVMWET390@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 24 Feb 2006 16:12:15 -0500 (EST)
In-reply-to: <20060224204022.GA15962@hpsvcnb.fc.hp.com>
X-X-Sender: nico@localhost.localdomain
To: Carl Baldwin <cnb@fc.hp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16739>

On Fri, 24 Feb 2006, Carl Baldwin wrote:

> On Fri, Feb 24, 2006 at 03:02:07PM -0500, Nicolas Pitre wrote:
> > Well that is probably a bit tight.  Ideally it should be linear with the 
> > size of the data set to process.  If you have 10 files 10MB each it 
> > should take about the same time to pack than 10000 files of 10KB each.  
> > Of course incrementally packing one additional 10MB file might take more 
> > than a second although it is only one file.
> 
> Well, I might not have been fair here.  I tried an experiment where I
> packed each of the twelve large blob objects explicitly one-by-one using
> git-pack-objects.  Incrementally packing each single object was very
> fast.  Well under a second per object on my machine.
> 
> After the twelve large objects were packed into individual packs the
> rest of the packing went very quickly and git v1.2.3's date reuse worked
> very well.  This was sort of my attempt at simulating how things would
> be if git avoided deltification of each of these large files. I'm sorry
> to have been so harsh earlier I just didn't understand that
> incrementally packing one-by-one was going to help this much.

Hmmmmmmm....

I don't think I understand what is going on here.

You say that, if you add those big files and incrementally repack after 
each commit using git repack with no option, then it requires only about 
one second each time.  Right?

But if you use "git-repack -a -f" then it is gone for more than an hour?

I'd expect something like 2 * (sum i for i = 1 to 10) i.e. in the 110 
second range due to the combinatorial effect when repacking everything.  
This is far from one hour and something appears to be really really 
wrong.

How many files besides those 12 big blobs do you have?

> This gives me hope that if somehow git were to not attempt to deltify
> these objects then performance would be much better than acceptible.
> 
> [snip]
> > However, if you could let me play with two samples of your big file I'd 
> > be grateful.  If so I'd like to make git work well with your data set 
> > too which is not that uncommon after all.
> 
> I would be happy to do this.  I will probably need to scrub a bit and
> make sure that the result shows the same characteristics.  How would you
> like me to deliver these files to you?  They are about 25 MB deflated.

If you can add them into a single .tgz with instructions on how 
to reproduce the issue and provide me with an URL where I can fetch it 
that'd be perfect.


Nicolas
