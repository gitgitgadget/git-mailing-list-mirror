From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Tue, 9 Jan 2007 18:44:21 -0500
Message-ID: <20070109234421.GD30023@spearce.org>
References: <87ps9xgkjo.wl%cworth@cworth.org> <7virfprquo.fsf@assigned-by-dhcp.cox.net> <87odphgfzz.wl%cworth@cworth.org> <7vbql9ydd7.fsf@assigned-by-dhcp.cox.net> <20070108131735.GA2647@coredump.intra.peff.net> <7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net> <20070109142130.GA10633@coredump.intra.peff.net> <7virffkick.fsf@assigned-by-dhcp.cox.net> <20070109213117.GB25012@fieldses.org> <87zm8ryiyz.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Junio C Hamano <junkio@cox.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 00:45:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4QeO-00061o-T0
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 00:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbXAIXob (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 18:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbXAIXob
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 18:44:31 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34820 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932549AbXAIXoa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 18:44:30 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4QdZ-0006KA-MV; Tue, 09 Jan 2007 18:44:13 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B046420FBAE; Tue,  9 Jan 2007 18:44:21 -0500 (EST)
To: Carl Worth <cworth@cworth.org>
Content-Disposition: inline
In-Reply-To: <87zm8ryiyz.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36427>

Carl Worth <cworth@cworth.org> wrote:
> But, whatever, if allowing fragile commits is seen as important by
> those doing the work, who am I to complain about that? I'd just ask
> that the following not be made slow:
> 
> 	git checkout commit-from-beginning-of-time
> 	git checkout master
> 
> Thanks to the index, and the simplicity of what "git checkout" means,
> checkout has always been blisteringly fast. All the talk of doing
> reachability analysis scares me from a performance point of view,
> (particularly when the _interesting_ cases (to me) of checkouts to
> non-branches never need this anyway---since no commits will be made).

The safety valve I was proposing would be only the additional time of
running `git merge-base commit-from-begging-of-time master` to verify
the former is completely contained in the latter.  That's going to
be true, and is a relatively fast operation (roughly linear in time
with the length of the history).

However in this case:

  git checkout v1.5.0
  git checkout v1.2.0

would take slightly longer as we'd have to verify that the HEAD
from the first checkout is contained in an existing tag/ref.
Which it is.  Since its probably exactly equal to one of those
dereferenced tags this may just wind up being the cost of scanning
the .git/packed-refs file.  You do pack your refs, don't you?

In my mind that is a small price to pay for making sure the
commit currently in a detached HEAD doesn't get orphaned off
into never-never land.

-- 
Shawn.
