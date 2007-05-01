From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: svn:externals using git submodules
Date: Tue, 1 May 2007 15:19:10 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705011512300.3808@woody.linux-foundation.org>
References: <200705011121.17172.andyparkins@gmail.com>
 <200705011936.14345.andyparkins@gmail.com> <20070501191703.GA25287@pe.Belkin>
 <200705012048.04817.andyparkins@gmail.com>
 <20070501202356.GA25531@pe.Belkin>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Chris Shoemaker <c.shoemaker@cox.net>
X-From: git-owner@vger.kernel.org Wed May 02 00:19:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hj0h4-0000pG-9f
	for gcvg-git@gmane.org; Wed, 02 May 2007 00:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078AbXEAWTb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 18:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752999AbXEAWTb
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 18:19:31 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:53425 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752062AbXEAWTa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2007 18:19:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l41MJDcL024161
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 1 May 2007 15:19:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l41MJAUh008014;
	Tue, 1 May 2007 15:19:12 -0700
In-Reply-To: <20070501202356.GA25531@pe.Belkin>
X-Spam-Status: No, hits=-2.981 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45985>



On Tue, 1 May 2007, Chris Shoemaker wrote:
> 
> Making git-svn handle svn:externals with specified revisions would be
> _quite_ useful.  There's a special-case of this that I use personally:
> svn:externals that point to other paths (and other revisions) of the
> parent repo.

Side note: even _without_ a specified revision, I think it's quite sane to 
have the rule that a submodule hash of all zeroes is "unversioned".

Such a submodule is still _useful_: while the tree itself contains no 
information (and it SHOULD NOT do so, since the actual location of the 
external module may not be globally stable or visible!), it would 
basically act like subversion externals together with the ".gitmodules" 
file that contains that information.

So while the git submodule thing was designed to specify specific 
revisions, there's nothing that really technically _requires_ it. The 
exact SHA1 details in the submodule link are going to be up to the 
higher-level user anyway.

(Of course, if you actually have a "all zeroes" gitlink entry, and then 
have a checked-out git tree at that entry, "git status" and "git diff" 
would show it as needing update. I think that's _correct_, but if we want 
to shut it up for the special case of all-zero SHA1, we trivially could).

But while I'm encouraged that the whole gitlink thing seems to be working 
for Andy, and some others are playing with it too, I'm also a bit 
discouraged by the fact that there hasn't been any noise or work on the 
porcelain side. I was obviously optimistic and hoping we'd see support in 
checkout/diff, but I haven't heard anybody talk about actually 
implementing .gitmodules and the porcelain support that uses them..

			Linus
