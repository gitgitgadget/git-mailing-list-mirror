From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Have git-revert, git-cherry-pick cleanup ./.msg upon successful completion.
Date: Mon, 7 May 2007 21:35:32 -0400
Message-ID: <20070508013532.GA11311@spearce.org>
References: <20070504143022.8539.qmail@4071cc1c178e73.315fe32.mid.smarden.org> <20070504143210.8690.qmail@a4171e0dbe98e3.315fe32.mid.smarden.org> <20070505034615.GE16538@spearce.org> <7vps5efnv8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 08 03:35:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlEcI-0003DF-W3
	for gcvg-git@gmane.org; Tue, 08 May 2007 03:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934525AbXEHBfl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 21:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934425AbXEHBfl
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 21:35:41 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50969 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934525AbXEHBfk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 21:35:40 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HlEbr-0001Cf-8o; Mon, 07 May 2007 21:35:23 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B241C20FBAE; Mon,  7 May 2007 21:35:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vps5efnv8.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46504>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > What about this change instead?  We make cherry-pick/revert
> > use the same temporary file as merge, which is under .git/
> > (something Alex mentioned he wanted).  I think the use of ".msg"
> > in cherry-pick/revert has always just been a bug, and not a feature,
> > so I'm really not against changing things around like this.
> 
> While I would not say this is not an improvement, this makes
> MERGE_MSG even less about merges and pushes us away from a
> sensible "git whatnow".
 
I think that ship has already sailed.  Look at builtin-revert.c
on:

    333         const char *target = git_path("MERGE_MSG");

We're already using MERGE_MSG to prep the message for a conflicted
cherry-pick or revert that the user needs to resolve by hand.  I
think we do the same thing in git-rebase, don't we?

Gerrit's patch to try and use COMMIT_MSG feels wrong to me, as
git-commit overwrites that file with what it gets from its "input".

I agree my patch steps us further from a "git whatnow", but we're
already in deep with MERGE_MSG.  We might as well keep that existing
convention that it can be used to prep the commit message for the
next git-commit invocation, and record other data somehow for the
"git whatnow" case.

-- 
Shawn.
