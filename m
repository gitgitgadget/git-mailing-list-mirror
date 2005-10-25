From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: git-rev-list: add "--dense" flag
Date: Tue, 25 Oct 2005 20:40:30 +0200
Message-ID: <20051025184030.GB7463@diku.dk>
References: <Pine.LNX.4.64.0510211631400.10477@g5.osdl.org> <20051025180707.GA7463@diku.dk> <Pine.LNX.4.64.0510251110050.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 25 20:43:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUTiu-00030I-G4
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 20:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbVJYSkc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 14:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVJYSkc
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 14:40:32 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:13813 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S932297AbVJYSkc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 14:40:32 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 0FEDE6E00E9; Tue, 25 Oct 2005 20:40:26 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id C82B06E00B6; Tue, 25 Oct 2005 20:40:25 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 270DF61141; Tue, 25 Oct 2005 20:40:31 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510251110050.10477@g5.osdl.org>
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10607>

Linus Torvalds <torvalds@osdl.org> wrote Tue, Oct 25, 2005:
> On Tue, 25 Oct 2005, Jonas Fonseca wrote:
> > 
> > Is the initial commit supposed to be listed when the file has been added
> > later?
> 
> Right now --dense will _always_ show the root commit. I didn't do the 
> logic that does the diff against an empty tree. I was lazy.
> 
> This patch does that, and may or may not work.

Without the workaround below it segfaults.

> Does this match what you expected?

Yes, thanks.

diff --git a/rev-list.c b/rev-list.c
index 5f125fd..82ec656 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -87,6 +87,7 @@ static void rewrite_one(struct commit **
 		struct commit *p = *pp;
 		if (p->object.flags & (TREECHANGE | UNINTERESTING))
 			return;
+		if (!p->parents) return;
 		/* Only single-parent commits don't have TREECHANGE */
 		*pp = p->parents->item;
 	}


-- 
Jonas Fonseca
