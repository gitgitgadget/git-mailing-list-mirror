From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Significant performance waste in git-svn and friends
Date: Fri, 7 Sep 2007 00:55:57 -0400
Message-ID: <20070907045557.GY18160@spearce.org>
References: <20070905184710.GA3632@glandium.org> <20070906070407.GA19624@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Sep 07 06:56:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITVt4-0003Ky-Hy
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 06:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbXIGE4F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 00:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbXIGE4E
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 00:56:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58218 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbXIGE4D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 00:56:03 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1ITVst-0001dw-P6; Fri, 07 Sep 2007 00:55:59 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3178020FBAE; Fri,  7 Sep 2007 00:55:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070906070407.GA19624@soma>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57976>

Eric Wong <normalperson@yhbt.net> wrote:
> Making git-svn use fast-import would be very nice.  I've got a bunch
> of other git-svn things that I need to work on, but having git-svn
> converted to use fast-import would be nice.  Or allowing Git.pm
> to access more of the git internals...
> 
> However, how well/poorly would fast-import work for incremental
> fetches throughout the day?

It would work just fine.  git-p4 uses fast-import and runs it in
incremental mode all of the time.

What will happen is you will get a packfile per git-svn fetch, so
if you fetch 5 times that day you will get 5 packfiles that day.
But you could also get 5 packfiles from git-fetch if each of those
fetches brought in 100 or more new objects.  So it really is not
that big of a deal.

At some point the number of packfiles gets out of control, but so
does the number of loose objects.  Repacking is the obvious fix in
both cases.

-- 
Shawn.
