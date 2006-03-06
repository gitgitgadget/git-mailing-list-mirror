From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git clone downloads objects that are in GIT_OBJECT_DIRECTORY
Date: Sun, 5 Mar 2006 20:42:53 -0500
Message-ID: <20060306014253.GD25790@spearce.org>
References: <20060306010825.GF20768@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Mar 06 02:43:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG4kX-00007Z-QZ
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 02:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbWCFBm6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 20:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWCFBm6
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 20:42:58 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:7605 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751199AbWCFBm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 20:42:57 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FG4kH-0007wF-NZ
	for git@vger.kernel.org; Sun, 05 Mar 2006 20:42:45 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0EE7F20FBBF; Sun,  5 Mar 2006 20:42:54 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060306010825.GF20768@kvack.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17261>

Benjamin LaHaise <bcrl@kvack.org> wrote:
> Hi folks,
> 
> Doing a fresh git clone git://some.git.url/ foo seems to download the 
> entire remote repository even if all the objects are already stored in 
> GIT_OBJECT_DIRECTORY=/home/bcrl/.git/object .  Is this a known bug?  
> At 100MB for a kernel, this takes a *long* time.

I believe it is a known missing feature.  :-) git-clone doesn't
prep HEAD to have some sort of starting point so the pull it uses
to download everything literally downloads everything as nothing
is in common.

One could work around it by running git-init-db to create the new
clone locally, git-update-ref HEAD to some commit which you have in
common with the remote, create a origin file, then perform a git-pull.
This would only download the objects between the commit you put into
HEAD and the current master of the remote...  But that is actually
some work.

I think Cogito's clone is capable of restarting a failed clone; I
wonder if that logic would benefit you here?

Is using a common GIT_OBJECT_DIRECTORY across many clones actually
pretty common?  Maybe its time that git-clone gets some more smarts
with regards to what it yanks from the origin.

-- 
Shawn.
