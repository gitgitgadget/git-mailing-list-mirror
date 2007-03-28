From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: specifying "fast-forward" only in git-pull
Date: Wed, 28 Mar 2007 17:30:07 -0400
Message-ID: <20070328213006.GO13247@spearce.org>
References: <e1dab3980703281412m78c2481bj9b9f7ec885dbbe4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Tweed <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 23:56:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWg7o-0002NL-Gy
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 23:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933328AbXC1V4J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 17:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933345AbXC1V4I
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 17:56:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41075 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933328AbXC1V4H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 17:56:07 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HWg7Y-0004KS-Pl; Wed, 28 Mar 2007 17:55:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1DE5F20FBAE; Wed, 28 Mar 2007 17:30:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <e1dab3980703281412m78c2481bj9b9f7ec885dbbe4f@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43392>

David Tweed <david.tweed@gmail.com> wrote:
> Hi, I'm looking through the documentation on git-pull and
> I see that I can specify a particular (sequence of) merge
> strategies, but I can't see a way to say "only do a fast
> forward, stopping if a fast forward doesn't apply".
> (Fast-forward doesn't appear to be a named strategy,
> which is why I can't use it with -s). Is there a way to
> do this?
> 
> Rationale: I have a repository on several machines that
> are synchronised via usb-stick. 99.9% of the time a fast
> forward is all that is needed, and for scripting the
> synchronisation I'd like to restrict it so that only
> fast-forwards can happen automatically and everything
> else I have to do by invoking git myself. (Somehow I managed to get
> a merge that gave a weird result without me actually
> noticing for a couple of days, which combined with
> my chronological version scripts seemed to put new
> trees onto an unnamed branch. I've got the repo sorted
> out now, but I want to avoid the same issue in future.)

If you are running a pull automatically and want to make sure its
strictly a fast-forward, use something like:

	git fetch &&
	b=$(git merge-base FETCH_HEAD HEAD) &&
	test $b = $(git rev-parse HEAD^0) &&
	git merge FETCH_HEAD

The idea here is that if the merge base of the current branch and
the incoming branch is the current branch, then the incoming branch
is a superset of the current branch, and git-merge will perform
a fast-forward.

-- 
Shawn.
