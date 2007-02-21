From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: removing content from git history
Date: Wed, 21 Feb 2007 10:56:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702211048220.4043@woody.linux-foundation.org>
References: <20070221164527.GA8513@ginosko.local>
 <Pine.LNX.4.64.0702210904350.4043@woody.linux-foundation.org>
 <20070221183028.GA9088@ginosko.local> <Pine.LNX.4.64.0702211041500.4043@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Michael Hendricks <michael@ndrix.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 19:57:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJwea-0002rQ-Tx
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 19:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422811AbXBUS4O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 13:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422809AbXBUS4O
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 13:56:14 -0500
Received: from smtp.osdl.org ([65.172.181.24]:37808 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422812AbXBUS4M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 13:56:12 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1LIuAhB031860
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Feb 2007 10:56:10 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1LIu9q5022832;
	Wed, 21 Feb 2007 10:56:10 -0800
In-Reply-To: <Pine.LNX.4.64.0702211041500.4043@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.461 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40319>



On Wed, 21 Feb 2007, Linus Torvalds wrote:

> 
> 
> On Wed, 21 Feb 2007, Michael Hendricks wrote:
> > 
> > What's a decent way to make a branch into a new repository?  My first
> > inclination is to "cp -a" the existing repository, checkout the branch,
> > delete all other branches and repack.  That seems to have worked in my
> > quick test, but is there a better way?
> 
> That works.

Btw, when I say "works", I do mean that "yeah, 'cp -a' works, but 
generally you're better off cloning".

When you use 'cp -a' you have to re-build the index at the very least. It 
so happens that since you checked out the branch explicitly, that will do 
it for you anyway, but it's still often a good idea to just *not* use the 
regular "copy everything by hand" approach.

If you want to be really efficient, there are actually better ways. For 
example, since you want to avoid having any of the old objects even 
reachable by mistake), you're probably better off with an explicit pull of 
the explicit branch, if only because that also involves a re-pack of only 
the reachable objects, and you know that there won't be any reflogs etc 
that might still make the object you try to remove be accessible to people 
who can access the resulting repository directly.

(Yeah, the "cp -a" is faster than the "git pull", but since you want to do 
the packing that git pull does for you *anyway* to get rid of the old 
objects, "git pull" actually ends up being better).

			Linus
