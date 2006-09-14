From: Shawn Pearce <spearce@spearce.org>
Subject: Re: cvs import
Date: Thu, 14 Sep 2006 11:50:03 -0400
Message-ID: <20060914155003.GB9657@spearce.org>
References: <45084400.1090906@bluegap.ch>
	<9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com>
	<46a038f90609131341se42b2dcne73c017cf757d13a@mail.gmail.com>
	<450872AE.5050409@bluegap.ch>
	<9e4733910609131438n686b6d72u4d5799533c7473d7@mail.gmail.com>
	<4508EA78.5030001@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>, monotone-devel@nongnu.org,
	Jon Smirl <jonsmirl@gmail.com>, dev@cvs2svn.tigris.org,
	Git Mailing List <git@vger.kernel.org>
X-From: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org Thu Sep 14 17:50:33 2006
Return-path: <monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org>
Envelope-to: gcvmd-monotone-devel@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNtTj-0005Ew-UD
	for gcvmd-monotone-devel@m.gmane.org; Thu, 14 Sep 2006 17:50:16 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1GNtTj-0004Nj-HS
	for gcvmd-monotone-devel@m.gmane.org; Thu, 14 Sep 2006 11:50:15 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1GNtTf-0004N8-SX
	for monotone-devel@nongnu.org; Thu, 14 Sep 2006 11:50:11 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1GNtTf-0004Ls-25
	for monotone-devel@nongnu.org; Thu, 14 Sep 2006 11:50:11 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1GNtTe-0004LX-T1
	for monotone-devel@nongnu.org; Thu, 14 Sep 2006 11:50:10 -0400
Received: from [64.38.20.226] (helo=corvette.plexpod.net)
	by monty-python.gnu.org with esmtps
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.52) id 1GNtVc-0004n3-UY
	for monotone-devel@nongnu.org; Thu, 14 Sep 2006 11:52:13 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
	helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GNtTT-0005w4-BO; Thu, 14 Sep 2006 11:49:59 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8D37620FB1F; Thu, 14 Sep 2006 11:50:03 -0400 (EDT)
To: Michael Haggerty <mhagger@alum.mit.edu>
Content-Disposition: inline
In-Reply-To: <4508EA78.5030001@alum.mit.edu>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - nongnu.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-BeenThere: monotone-devel@nongnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: developer discussion for monotone <monotone-devel.nongnu.org>
List-Unsubscribe: <http://lists.nongnu.org/mailman/listinfo/monotone-devel>,
	<mailto:monotone-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/monotone-devel>
List-Post: <mailto:monotone-devel@nongnu.org>
List-Help: <mailto:monotone-devel-request@nongnu.org?subject=help>
List-Subscribe: <http://lists.nongnu.org/mailman/listinfo/monotone-devel>,
	<mailto:monotone-devel-request@nongnu.org?subject=subscribe>
Sender: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org
Errors-To: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27004>

Michael Haggerty <mhagger@alum.mit.edu> wrote:
>  The only difference between our SCMs that might be difficult
> to paper over in a universal dumpfile is that SVN wants its changesets
> in chronological order, whereas I gather that others would prefer the
> data in dependency order branch by branch.

This really isn't an issue for Git.

Originally I wanted Jon Smirl to modify the cvs2svn code to emit
only one branch at a time as that would be much faster than jumping
around branches in chronological order.  But it turned out to
be too much work to change cvs2svn.  So git-fast-import (the Git
program that consumes the dump stream from Jon's modified cvs2svn)
maintains an LRU of the branches in memory and reloads inactive
branches as necessary when cvs2svn jumps around.

It turns out it didn't matter if the git-fast-import maintained 5
active branches in the LRU or 60.  Apparently the Mozilla repo didn't
jump around more than 5 branches at a time - most of the time anyway.

Branches in git-fast-import seemed to cost us only 2 MB of memory
per active branch on the Mozilla repository.  Holding 60 of them at
once (120 MB) is peanuts on most machines today.  But really only 5
(10 MB) were needed for an efficient import.


I don't know how the Monotone guys feel about it but I think Git
is happy with the data in any order, just so long as the dependency
chains aren't fed out of order.  Which I think nearly all changeset
based SCMs would have an issue with.  So we should be just fine
with the current chronological order produced by cvs2svn.

-- 
Shawn.
