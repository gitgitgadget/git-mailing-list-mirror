From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Fri, 24 Feb 2006 13:40:22 -0700
Organization: Hewlett Packard
Message-ID: <20060224204022.GA15962@hpsvcnb.fc.hp.com>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain> <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net> <20060224174422.GA13367@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain> <20060224183554.GA31247@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0602241350190.31162@localhost.localdomain> <20060224192354.GC387@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0602241438521.31162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 21:40:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCjjo-0001be-1H
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 21:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWBXUkY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 15:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWBXUkY
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 15:40:24 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:2735 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751089AbWBXUkX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 15:40:23 -0500
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.15.136.127])
	by atlrel8.hp.com (Postfix) with ESMTP id 01F2E34769;
	Fri, 24 Feb 2006 15:40:22 -0500 (EST)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP id CA27C6EA8;
	Fri, 24 Feb 2006 20:40:22 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id B355DBFA3; Fri, 24 Feb 2006 13:40:22 -0700 (MST)
To: Nicolas Pitre <nico@cam.org>
Mail-Followup-To: Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602241438521.31162@localhost.localdomain>
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16736>

On Fri, Feb 24, 2006 at 03:02:07PM -0500, Nicolas Pitre wrote:
> Well that is probably a bit tight.  Ideally it should be linear with the 
> size of the data set to process.  If you have 10 files 10MB each it 
> should take about the same time to pack than 10000 files of 10KB each.  
> Of course incrementally packing one additional 10MB file might take more 
> than a second although it is only one file.

Well, I might not have been fair here.  I tried an experiment where I
packed each of the twelve large blob objects explicitly one-by-one using
git-pack-objects.  Incrementally packing each single object was very
fast.  Well under a second per object on my machine.

After the twelve large objects were packed into individual packs the
rest of the packing went very quickly and git v1.2.3's date reuse worked
very well.  This was sort of my attempt at simulating how things would
be if git avoided deltification of each of these large files. I'm sorry
to have been so harsh earlier I just didn't understand that
incrementally packing one-by-one was going to help this much.

This gives me hope that if somehow git were to not attempt to deltify
these objects then performance would be much better than acceptible.

[snip]
> However, if you could let me play with two samples of your big file I'd 
> be grateful.  If so I'd like to make git work well with your data set 
> too which is not that uncommon after all.

I would be happy to do this.  I will probably need to scrub a bit and
make sure that the result shows the same characteristics.  How would you
like me to deliver these files to you?  They are about 25 MB deflated.

Carl

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        RADCAD (R&D CAD)
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
