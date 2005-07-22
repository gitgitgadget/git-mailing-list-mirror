From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Fri, 22 Jul 2005 22:41:20 +0200
Message-ID: <20050722204120.GD11916@pasky.ji.cz>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca> <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Bryan larsen <bryanlarsen@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 22:42:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw4Km-0002Dz-8R
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 22:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVGVUlY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 16:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVGVUlX
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 16:41:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44038 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261385AbVGVUlX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 16:41:23 -0400
Received: (qmail 22508 invoked by uid 2001); 22 Jul 2005 20:41:20 -0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <tnx1x5ryvn2.fsf@arm.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jul 22, 2005 at 12:37:05PM CEST, I got a letter
where Catalin Marinas <catalin.marinas@gmail.com> told me that...
> > Cogito seems to use $GIT_DIR/commit-template for that purpose.
> > Can't users put that "vim:" hint there, and if StGIT does not
> > use a commit template, patch it to use the same file as Cogito
> > does?
> 
> I would use a neutral commit template, only that it should have a
> neutral prefix as well for the lines to be removed (neither STG nor CG
> but GIT maybe). The $GIT_DIR/commit-template is fine as a file name.

This unfortunately isn't that simple, since this file substitutes only
the

	CG: -----------------------------------------------------------------------
	CG: Lines beginning with the CG: prefix are removed automatically.

snippet of the file. The trouble is, Cogito autogenerates most of the
rest of it. Would the acceptable solution be that I would have
@CG_FILELIST@-style placeholders there, and any tool processing the
file would simply drop lines containing @ directives it does not
understand? (@@ is escaped @)

I have nothing against changing the prefix to GIT:.

Then, Cogito's default commit-template would look like

	GIT: -----------------------------------------------------------------------
	GIT: Lines beginning with the GIT: prefix are removed automatically.
	GIT:
	GIT: Author: @AUTHOR_NAME@
	GIT: Email: @AUTHOR_EMAIL@
	GIT: Date: @AUTHOR_DATE@
	GIT:@CG_SHOWFILES@@CG_NOMERGE@
	GIT:@CG_SHOWFILES@@CG_NOMERGE@ By deleting lines beginning with GIT:F, the associated file
	GIT:@CG_SHOWFILES@@CG_NOMERGE@ will be removed from the commit list.
	GIT:@CG_SHOWFILES@
	GIT:@CG_SHOWFILES@ Modified files:
	GIT:@CG_SHOWFILES@F   @FILELIST@
	GIT: -----------------------------------------------------------------------
	GIT: vim: textwidth=75

(where CG_SHOWFILES is defined only when the list of the files is to be
shown and CG_NOMERGE only when there is no merge going on).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
