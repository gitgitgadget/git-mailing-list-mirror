From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: SEGV in git-merge recursive:
Date: Thu, 29 Mar 2007 22:44:58 +0200
Message-ID: <20070329204458.GD2809@steel.home>
References: <20070329075010.GA3493@hermes> <81b0412b0703290429k63642a34u6bea1e08803ffba7@mail.gmail.com> <20070329125803.GA16739@hermes> <81b0412b0703290634j6e62ba89tce3c8c963be3fb92@mail.gmail.com> <20070329141230.GB16739@hermes> <81b0412b0703290744h34b6ef01s4e6f90b1d7ed231b@mail.gmail.com> <81b0412b0703290804n13af6f40we79f7251562c540@mail.gmail.com> <20070329183237.GB2809@steel.home> <Pine.LNX.4.64.0703291232190.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0703291237240.6730@woody.linux-foundation.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Tom Prince <tom.prince@ualberta.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 29 22:45:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX1Uh-0004Mj-Jk
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 22:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030690AbXC2UpE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 16:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030693AbXC2UpE
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 16:45:04 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:33781 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030690AbXC2UpB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 16:45:01 -0400
Received: from tigra.home (Fcb18.f.strato-dslnet.de [195.4.203.24])
	by post.webmailer.de (fruni mo1) (RZmta 5.5)
	with ESMTP id L038a5j2TEo9UB ; Thu, 29 Mar 2007 22:44:59 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 49444277B6;
	Thu, 29 Mar 2007 22:44:59 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id B680DD150; Thu, 29 Mar 2007 22:44:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703291237240.6730@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg7nw==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43469>

Linus Torvalds, Thu, Mar 29, 2007 21:40:53 +0200:
> 
> 
> On Thu, 29 Mar 2007, Linus Torvalds wrote:
> > 
> > It's not the initial commit. It's a criss-cross merge, and it's a virtual 
> > commit created by a previous level of merging.
> > 
> > Apply this patch to see it blow up much earlier, when that bogus commit 
> > with a NULL tree is created.
> > 
> > (I didn't debug *why* that happens, but maybe this gets somebody further)
> 
> Well, it happens because "git_write_tree()" returns NULL. Which in turn is 
> because "unmerged_index()" returns true. 

which in turn is because the inner merge has a rename/rename conflict.
See the repo in the tarball from <20070329185501.GC2809@steel.home>

> merge_trees() tries to clean up the unmerged index, but apparently doesn't 
> do good enough of a job, so git_write_tree() is called with entries still 
> unmerged..

I see no "job" at all: no index cleanup there (merge_trees).
