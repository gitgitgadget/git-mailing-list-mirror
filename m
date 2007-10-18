From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: bug: origin refs updated too soon locally
Date: Thu, 18 Oct 2007 00:53:58 -0400
Message-ID: <20071018045358.GB14735@spearce.org>
References: <8CEF6150-4BE7-4B4D-B58C-12CE4671007E@cs.indiana.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Perry Wagle <wagle@cs.indiana.edu>
X-From: git-owner@vger.kernel.org Thu Oct 18 06:54:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiNOi-0000af-P5
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 06:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbXJREyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 00:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbXJREyF
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 00:54:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50563 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbXJREyD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 00:54:03 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IiNOP-0005Mt-8q; Thu, 18 Oct 2007 00:53:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3E5AB20FBAE; Thu, 18 Oct 2007 00:53:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <8CEF6150-4BE7-4B4D-B58C-12CE4671007E@cs.indiana.edu>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61469>

Perry Wagle <wagle@cs.indiana.edu> wrote:
> If I clone a remote repository, make a few commits, push them to the  
> remote repository, and the update hook on the remote repository  
> rejects them (exit 1), the local origin refs are still updated as if  
> the push had gone through.  The workaround is to do a pull to set the  
> origin refs back.

Heh.  Yes, that's a known bug.  Someone should really fix it.
The problem is we are updating the local tracking ref before we
actually get confirmation from the remote side that the remote side
has accepted (or rejected) that update request.

This is probably easier to do after the db/fetch-pack topic is
merged as the improvements there might make this easier.  But I
could be wrong.  Be nice if someone proved me wrong by writing up
a patch for git-send-pack.

For the time being the best way to recover from this is to use
git-fetch rather than git-pull.  Recall that git-pull is defined as
"fetch then merge".  You really just need to refetch the tracking
branches again, so your tracking branches have the same value as
the remote side.

-- 
Shawn.
