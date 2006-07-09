From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFH: refactor read-tree
Date: Sun, 9 Jul 2006 08:30:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607090827430.5623@g5.osdl.org>
References: <Pine.LNX.4.63.0607090015250.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0607082011060.5623@g5.osdl.org> <20060709124324.GE5919@steel.home>
 <Pine.LNX.4.63.0607091630110.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 17:30:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzbEy-0000dM-1p
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 17:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbWGIPac (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 11:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161033AbWGIPac
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 11:30:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63146 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161026AbWGIPab (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 11:30:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k69FURnW010141
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 9 Jul 2006 08:30:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k69FUQUH027484;
	Sun, 9 Jul 2006 08:30:26 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607091630110.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.84__
X-MIMEDefang-Filter: osdl$Revision: 1.138 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23557>



On Sun, 9 Jul 2006, Johannes Schindelin wrote:
> 
> On Sun, 9 Jul 2006, Alex Riesen wrote:
> 
> > Linus Torvalds, Sun, Jul 09, 2006 05:15:41 +0200:
> > > The basic idea is that "branch1" should be your current branch, and it 
> > > obviously is also expected to match (more or less) the current index. So 
> > > you can do a merge by
> > > 
> > >  - reading in "branch1" into the index:
> > > 
> > > 	GIT_INDEX_FILE=.git/tmp-index git-read-tree -m branch1
> > 
> > what is "-m" here for?
> 
> It means that git-read-tree tries to merge the current index with branch1.

Well, the current index always "merges" by just taking the timestamps from 
it. The actual _content_ doesn't matter for the single-tree case.

For the two- and three-tree case, "git-read-tree -m" will verify that the 
parts that got changed still _match_ in the index, but for a single-tree 
"git-read-tree", there's nothing to match against, just the target, so 
the only thing it does is that for matching index/target-tree entries it 
will re-use the index timestamps (and other stat info).

			Linus
