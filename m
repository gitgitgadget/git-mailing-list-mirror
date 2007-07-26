From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Teach git-gui to split hunks
Date: Thu, 26 Jul 2007 03:07:44 -0400
Message-ID: <20070726070744.GD18114@spearce.org>
References: <Pine.LNX.4.64.0707260630570.14781@racer.site> <85ir8790lj.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jul 26 09:08:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDxSM-0003iv-Rd
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 09:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761238AbXGZHHw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 03:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762755AbXGZHHv
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 03:07:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42784 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762669AbXGZHHu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 03:07:50 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IDxRp-000096-Rs; Thu, 26 Jul 2007 03:07:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C8A5620FBAE; Thu, 26 Jul 2007 03:07:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <85ir8790lj.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53796>

David Kastrup <dak@gnu.org> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > When you select the context menu item "Split Hunk" in the diff area,
> > git-gui will now split the current hunk so that a new hunk starts at
> > the current position.
> >
> > For this to work, apply has to be called with --unidiff-zero, since
> > the new hunks can start or stop with a "-" or "+" line.
> 
> Unless one splits right at the beginning or end of an existing hunk,
> wouldn't there be context which one could use?  Or does it confuse
> patch when adjacent hunks have overlapping contexts?  At least if the
> first hunk patches what is to be used as context in the second hunk, I
> could imagine this.  And there is really no danger of losing synch in
> this situation, anyhow.  So it would be more of a convenience thing
> than anything else to be able to omit --unidiff-zero.

Yea, there's context there.  Junio and I talked about this patch on
#git a few minutes ago.  I really appreciate that Dscho wrote it,
especially given that he hasn't really been into Tcl hacking for
Git much before.  But I'd really like to save/create context, like
`git add -i` does, so that we don't have to use --unidiff-zero here.

It won't matter if git-apply rejected overlapping context in this
case.  git-gui will only ever feed one hunk at a time to git-apply.
And if things get really f'd in the diff buffer the user can easily
regenerate it (right click, Refresh).

Right now git-gui's apply doesn't correctly update the other hunk
headers when you apply a hunk.  I've seen git-apply fail on some
hunks just for this reason.  Refreshing the diff (so git recomputes
the headers) works around the issue.  So I'm a little worried about
using --unidiff-zero here.

-- 
Shawn.
