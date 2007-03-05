From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 5 Mar 2007 14:37:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703051431130.3998@woody.linux-foundation.org>
References: <17895.18265.710811.536526@lisa.zopyra.com>
 <20070302091426.GA2605@diana.vm.bytemark.co.uk> <17896.9631.316001.869157@lisa.zopyra.com>
 <Pine.LNX.4.63.0703021618000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070302162136.GA9593@diana.vm.bytemark.co.uk>
 <Pine.LNX.4.63.0703022018190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070305072323.GA31169@diana.vm.bytemark.co.uk>
 <Pine.LNX.4.63.0703051230390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17900.27067.247950.419438@lisa.zopyra.com>
 <Pine.LNX.4.63.0703052014020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17900.30394.172067.743310@lisa.zopyra.com>
 <Pine.LNX.4.63.0703052143120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17900.36569.805689.922989@lisa.zopyra.com>
 <Pine.LNX.4.64.0703051347490.3998@woody.linux-foundation.org>
 <17900.39124.763603.695942@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 23:37:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOLo7-0007j7-Vz
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 23:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbXCEWhY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 17:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbXCEWhY
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 17:37:24 -0500
Received: from smtp.osdl.org ([65.172.181.24]:39764 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932279AbXCEWhX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 17:37:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l25MbGq8011867
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Mar 2007 14:37:16 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l25MbF3c003136;
	Mon, 5 Mar 2007 14:37:15 -0800
In-Reply-To: <17900.39124.763603.695942@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.46 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41497>



On Mon, 5 Mar 2007, Bill Lear wrote:
>
> Maybe, maybe not.  Each argument I've seen doesn't convince me.  Sure,
> it may be MESSY.  It may be UGLY, and therefore undesirable, but I
> don't think any of the arguments have conclusively shown that it
> is WRONG or INFEASIBLE in any way.

I'm sorry. If you don't see how it's WRONG to seta datestamp back to 
something that will make a simple "make" *miscompile* your source tree, I 
don't know what defintiion of "wrong" you are talking about.

It's WRONG. 

It's STUPID.

And it's totally INFEASIBLE to implement.

> Why should I care whether git knows this?  I never said it should.  As
> I said, if I have make products in separate, per-branch directories (a
> minor extension to my current make system), I don't see how this would
> be confusing in the least.  Git should only care if the content of the
> file in the index changes.  It shouldn't care in the least about my
> make products.

But Bill, the content in the index *does* change. It's that simple. It 
changes every time you check out another branch. And if it doesn't change, 
git already avoids changing mtime (because git already avoids changing the 
file).

> Here's the flow.  Perhaps I'm fundamentally confused, and I'll be
> the first to admit that is true in plenty of ways:
> 
> I edit sourcefile.c, compile it, then commit it with
> N=timestamp(sourcefile.c) on master.  N is <
> timestamp(.master/sourcefile.o).  I then switch to branchX.  N is
> stored by git for master:sourcefile.c.  No stored timestamp are on
> this branch, so the file gets the timestamp it gets on checkout
> M=timestamp(sourcefile.c).  I compile the file again, all is well.  I
> move back to master branch.  Git stores M as branchX:sourcefile.c Git
> checks out the file, and stamps it with N.  I do a make.  No
> recompilation happens.

WHICH IS WRONG! You need to recompile, since the compile you did on the 
other branch DOES NOT MATCH in "sourcefile.c" any more. 

And if sourcefile.c _does_ match in the two branches, then git *already* 
won't have changed it at all, so git already does the obvious 
optimization.

The thing is, "ccache" actually does this right. You could arguably 
integrate ccache with more git integration, and let ccache just use the 
SHA1's that git already caches and knows about. But the real issue is that 
what _you_ suggest is crazy. It doesn't work.

		Linus
