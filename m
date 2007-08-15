From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Make git-cvsexportcommit "status" each file in turn
Date: Wed, 15 Aug 2007 21:40:35 +0200
Message-ID: <200708152140.36432.robin.rosenberg.lists@dewire.com>
References: <1187184448.13096.54.camel@murta.transitives.com> <20070815140431.GC4550@xp.machine.xx> <1187195112.13096.71.camel@murta.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 21:39:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILOiR-0005Ja-5d
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 21:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760663AbXHOTjV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 15:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758221AbXHOTjV
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 15:39:21 -0400
Received: from [83.140.172.130] ([83.140.172.130]:17553 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1758734AbXHOTjU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 15:39:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9D48B802850;
	Wed, 15 Aug 2007 21:31:42 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 29181-04; Wed, 15 Aug 2007 21:31:42 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 30F6980019B;
	Wed, 15 Aug 2007 21:31:42 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <1187195112.13096.71.camel@murta.transitives.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55941>

onsdag 15 augusti 2007 skrev Alex Bennee:
> On Wed, 2007-08-15 at 16:04 +0200, Peter Baumann wrote:
> > On Wed, Aug 15, 2007 at 02:27:28PM +0100, Alex Bennee wrote:
> > > Hi,
> > > 
> > > It turns out CVS doesn't always give the status output in the order
> > > requested. According to my local CVS gurus this is a known CVS issue.
> > <snip>
> > I inlined the patch for easier commenting. Please inline further
> > patches.
> 
> Will do. I assumed Evolution would do something sensible. My mistake :-(
> 
> > 
> > > ---
> > >  git-cvsexportcommit.perl |   30 ++++++++++++++++++++----------
> > >  1 files changed, 20 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
> > <snip>
> > This is extremly wastefull, because it will spawn a CVS process for each 
file.
> > A better fix would be to parse the filename from the output of
> > 'cvs status' and use that as input for $cvsstat.
> > 
> > (And/or you could use an hash instead of an array for 'cvsoutput', so
> > you could double check that you only get the status for those files you
> > asked for.)
> 
> I agree it's wasteful and could be done better however I'm no perl
> hacker so I just went for something that was correct and worked. 
> 
> The path that is echoed later in the status output is however the CVS
> file path which may not be directly related to the actual path in your
> source tree. For example I have one status reported as:
> 
> $ cvs status src/proj_version
> ===================================================================
> File: proj_version      Status: Up-to-date
> 
>    Working revision:    1.1.380.1
>    Repository revision: 
1.1.380.1       /export/cvsroot/project/src/Attic/proj_version,v
>    Sticky Tag:          ATAG (branch: 1.1.380)
>    Sticky Date:         (none)
>    Sticky Options:      (none)
> 
> This makes the matching more than a little problematic.
CVS/Root contains the first part of the path. Just use the one found at the 
top of the CVS checkout. Using CVS may be insane, but mixing different repos 
in the same checkout is absolute madness.

Then drop /Attic/ if present and the ,v at the end of the file name. Not 
rocket science I'd say.

> It depends on how much people that use this script care about performance?
We do although I rarely commit big patches so cvsexportcommit usually does 
it's job in seconds for me. I also use the -u option and don't do any work in 
the CVS checkout so performing status if just overhead for me. We might drop 
it completely with a switch.

> For my part it's a fire and forget script once I've finished my hacking
> in a git tree so I don't mind it taking some time. I'm not particularly
> minded to dig further in perl to make it faster unless there is a real
> clamour - or perhaps someone with a bigger itch and more perl foo can
> tackle it. 

> 
> In the meantime it does fix a bug in the script so I would say it's
> applying.
> 

I suggest Junio wait a few days in case a real fix materializes.

-- robin
