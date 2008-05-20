From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: using rev-list to tell if a branch is behind or ahead
Date: Tue, 20 May 2008 16:24:38 -0400
Message-ID: <20080520202438.GG29038@spearce.org>
References: <3703BF54-3619-432F-8B65-09AF17299CAD@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tim Harper <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 22:25:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyYOr-0003F9-1M
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 22:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758455AbYETUYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 16:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758391AbYETUYm
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 16:24:42 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42066 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755263AbYETUYm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 16:24:42 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JyYNs-0001Ql-0S; Tue, 20 May 2008 16:24:32 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 02E0720FBAE; Tue, 20 May 2008 16:24:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <3703BF54-3619-432F-8B65-09AF17299CAD@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82499>

Tim Harper <timcharper@gmail.com> wrote:
> I'm implementing a ruby interface to git and am wanting to be able to  
> ask if a branch is ahead or behind.
> 
> I looked in the builtin-checkout.c file and see this code:
> 
> 	/* Run "rev-list --left-right ours...theirs" internally... */
...
> It looks like it's calling rev-parse.  But, when I call it with the  
> same arguments (using branches or commit sha1's), it only will list  
> commits that are in right and not in left.  I need it to show both  
> ways: commits that are in the right and not in left, and commits that  
> are in the left but not in right.
> 
> Do I need to call rev-parse twice to achieve this?

No.  You need to use the triple dot operator ("...") not the
double dot operator ("..").

> Here's a sample of what I'm trying currently:
> ~ $ mkdir test
> ~ $ cd test/
> ~/test $ git init
> Initialized empty Git repository in .git/
> ~/test $ git
> ~/test $ echo content > file.txt
> ~/test $ git add file.txt && git commit -m "Initial commit"
> Created initial commit f5e4160: Initial commit
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 file.txt
> ~/test master$ git co -b task
> Switched to a new branch "task"
> ~/test task$ echo changes >> file.txt
> ~/test task$ git add file.txt && git commit -m "Some changes"
> Created commit 96492ee: Some changes
>  1 files changed, 1 insertions(+), 0 deletions(-)
> ~/test task$ git rev-list --left-right task..master --

You need an extra "." between task and master, this should be:

  git rev-list --left-right task...master --

> ~/test task$ git rev-list --left-right master..task --
> >96492ee80143f43417b00699ff29330d0027df7f

-- 
Shawn.
