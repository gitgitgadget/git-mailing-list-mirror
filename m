From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 08:38:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702270830260.12485@woody.linux-foundation.org>
References: <E1HM1XL-00071C-N5@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 27 17:39:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM5M8-0005GV-Sp
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 17:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbXB0Qis (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 11:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbXB0Qis
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 11:38:48 -0500
Received: from smtp.osdl.org ([65.172.181.24]:39471 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752500AbXB0Qin (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 11:38:43 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1RGcehB009086
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Feb 2007 08:38:40 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1RGcdn0021680;
	Tue, 27 Feb 2007 08:38:40 -0800
In-Reply-To: <E1HM1XL-00071C-N5@candygram.thunk.org>
X-Spam-Status: No, hits=-0.436 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40759>



On Tue, 27 Feb 2007, Theodore Ts'o wrote:
> 
> git-checkout will only write the output to the working tree.
> git-cat-file and git-show only work on a object identifier (they are
> low-level plumbing commands).  

Everybody has already pointed out how easy this actually is, but your 
fundamental mistake was thinking that "only work on a object identifier" 
is a bad thing.

Repeat after me: in git, *everything* is a SHA1 object!

So the problem you had was that "only". Remove the "only", and realize 
that object identifiers will cover _all_ you ever need, and be happy.

That's why

	git show <tree>:<path>

works. All the files are *also* just SHA1 objects, and as a result 
all the normal SHA1 naming rules apply.

This is also why you can literally do

	git diff v1.4.4:Makefile HEAD~5:Makefile

and it will just magically work and do exactly what the command line would 
make you think it does - even if you didn't know anything at all about 
git.

Because "git diff" knows about blob objects too, and "v1.3:Makefile" is 
the object name for the blob that was the Makefile object at version 
1.4.4, and HEAD~5:Makefile is the Makefile in the fifth parent of your 
current HEAD.

Tell me any other SCM that makes things quite _that_ easy?

So in Unix, we have "everything is a file" (and then we have processes). 
In git, we have "everything is a SHA1-named object" (and then we have 
revision walking). There's a really simple underlying logic to it all, and 
the great thing is how _powerful_ it is.

THIS is what good design is all about. Forget nipples. You just need to 
internalize the fact that "everything is a SHA1".

> So if it is a matter of we don't have an easy way to do this (as opposed
> to me being stupid or the git documentation just failing to mention it
> in the right places), what's the best way to add it?

So not only do we have it, it's probably not mentioned in the docs because 
it is *so* fundamental that nobody even thought to mention any of this 
except in the "how does SHA1 lookup work" sections.

			Linus
