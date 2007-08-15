From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: [PATCH] Make git-cvsexportcommit "status" each file in turn
Date: Wed, 15 Aug 2007 17:25:12 +0100
Organization: Insert joke here
Message-ID: <1187195112.13096.71.camel@murta.transitives.com>
References: <1187184448.13096.54.camel@murta.transitives.com>
	 <20070815140431.GC4550@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 15 18:24:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILLfx-00009F-CP
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 18:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763156AbXHOQYb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 12:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762767AbXHOQYa
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 12:24:30 -0400
Received: from mx.transitive.com ([217.207.128.220]:57976 "EHLO
	pennyblack.transitives.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1761811AbXHOQY3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Aug 2007 12:24:29 -0400
Received: from [192.168.2.164] (helo=[192.168.2.164])
	by pennyblack.transitives.com with esmtp (Exim 4.50)
	id 1ILLWQ-00011y-4F; Wed, 15 Aug 2007 16:15:02 +0000
In-Reply-To: <20070815140431.GC4550@xp.machine.xx>
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55919>

On Wed, 2007-08-15 at 16:04 +0200, Peter Baumann wrote:
> On Wed, Aug 15, 2007 at 02:27:28PM +0100, Alex Bennee wrote:
> > Hi,
> > 
> > It turns out CVS doesn't always give the status output in the order
> > requested. According to my local CVS gurus this is a known CVS issue.
> <snip>
> I inlined the patch for easier commenting. Please inline further
> patches.

Will do. I assumed Evolution would do something sensible. My mistake :-(

> 
> > ---
> >  git-cvsexportcommit.perl |   30 ++++++++++++++++++++----------
> >  1 files changed, 20 insertions(+), 10 deletions(-)
> > 
> > diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
> <snip>
> This is extremly wastefull, because it will spawn a CVS process for each file.
> A better fix would be to parse the filename from the output of
> 'cvs status' and use that as input for $cvsstat.
> 
> (And/or you could use an hash instead of an array for 'cvsoutput', so
> you could double check that you only get the status for those files you
> asked for.)

I agree it's wasteful and could be done better however I'm no perl
hacker so I just went for something that was correct and worked. 

The path that is echoed later in the status output is however the CVS
file path which may not be directly related to the actual path in your
source tree. For example I have one status reported as:

$ cvs status src/proj_version
===================================================================
File: proj_version      Status: Up-to-date

   Working revision:    1.1.380.1
   Repository revision: 1.1.380.1       /export/cvsroot/project/src/Attic/proj_version,v
   Sticky Tag:          ATAG (branch: 1.1.380)
   Sticky Date:         (none)
   Sticky Options:      (none)

This makes the matching more than a little problematic.

It depends on how much people that use this script care about performance?

For my part it's a fire and forget script once I've finished my hacking
in a git tree so I don't mind it taking some time. I'm not particularly
minded to dig further in perl to make it faster unless there is a real
clamour - or perhaps someone with a bigger itch and more perl foo can
tackle it. 

In the meantime it does fix a bug in the script so I would say it's
applying.

-- 
Alex, homepage: http://www.bennee.com/~alex/
Blessed is he who has reached the point of no return and knows it, for
he shall enjoy living. -- W. C. Bennett
