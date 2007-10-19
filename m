From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git push bug?
Date: Thu, 18 Oct 2007 20:49:26 -0400
Message-ID: <20071019004926.GR14735@spearce.org>
References: <1192719040.9433.5.camel@gentoo-jocke.transmode.se> <0DAC53EF-021D-441C-9520-9795AAB6DE54@zib.de> <1192723269.9433.21.camel@gentoo-jocke.transmode.se> <1192723847.9433.25.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steffen Prohaska <prohaska@zib.de>, git <git@vger.kernel.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Fri Oct 19 02:49:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iig3Z-0003Bc-JD
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 02:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756665AbXJSAta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 20:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753916AbXJSAta
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 20:49:30 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40140 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185AbXJSAta (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 20:49:30 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iig38-0001l2-4X; Thu, 18 Oct 2007 20:49:14 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0476F20FBAE; Thu, 18 Oct 2007 20:49:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1192723847.9433.25.camel@gentoo-jocke.transmode.se>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61586>

Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> BTW this does not work either:
> 
> git reset --hard HEAD^
> git push -f  ssh://devsrv/var/git/os2kernel.git +master:master
> updating 'refs/heads/master'
>   from 9c344d18d01221c8f25080cb58910e6b09efbf55
>   to   5761a9e5924b34615c748fba2dcb977ed04c1243
> Generating pack...
> Done counting 0 objects.
> Writing 0 objects...
> Total 0 (delta 0), reused 0 (delta 0)
> error: denying non-fast forward refs/heads/master (you should pull first)
> ng refs/heads/master non-fast forward
> error: failed to push to 'ssh://devsrv/var/git/os2kernel.git'
> 
> I thought the + in +master:master and the -f option should let me
> do that.

Yes, but its only on the client side.

See when we do a push the local client side determines if the push is
going to be a fast-forward or not.  If it isn't then the git-push
client aborts before it even uploads data to the remote side.
The --force or + can be used to make the client side skip this
check and just plow forward anyway.

But the remote side can also veto a non-fast-forward update.  By
default it refuses to allow such updates as they can orphan commits
(and thus potentially lose important work).  See the config option
receive.denyNonFastForwards; you may want to set this to true in
the remote side's config file.

-- 
Shawn.
