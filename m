From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 16:50:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610171642480.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <Pine.LNX.4.64.0610171448150.3962@g5.osdl.org> <45355EEE.3060105@utoronto.ca>
 <200610180124.28048.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 02:14:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZz4X-00033K-ME
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 02:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWJQXuq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 19:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWJQXuq
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 19:50:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30944 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751182AbWJQXup (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 19:50:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9HNoPaX009717
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Oct 2006 16:50:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9HNoNmJ011360;
	Tue, 17 Oct 2006 16:50:24 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610180124.28048.jnareb@gmail.com>
X-Spam-Status: No, hits=-0.473 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29142>



On Wed, 18 Oct 2006, Jakub Narebski wrote:
> 
> Merge commit in fast-forward case is only marking "here we did a pull"
> (here we downloaded from other repository). It is just a marker which
> place is in reflog, not in history. It is only cluttering history.

For non-git people (and maybe even git people who didn't follow some of 
the "reflog" work):

 - git does actually have "local view" support, but it is very much 
   _defined_ to be local. It does not pollute any history as seen by 
   anybody else. It's called "reflog" (where "ref" is just the git name 
   for any reference into a tree, and the "log" part is hopefully obvious)

So each git repository can have (if you enable it) a full log of all the 
changes to each branch. But it's not in the core git datastructures that 
get replicated - because the local view of how the branches have changed 
really _is_ just a local view. It's just a local log to each repository 
(actually, one per branch).

It's what allows a git person to say

	git diff "master@{5.hours.ago}"

because while "5 hours ago" is _not_ well-defined in a distributed 
environment (five hours ago for _whom_?) it's perfectly well-defined in a 
purely _local_ sense of one particular branch.

So there's no need for a fakey "merge" that isn't a real merge and that 
doesn't make sense for anybody else because it doesn't actually add any 
real knowledge about the _history_ of the tree (only about a single 
repository). If you want to see how the history of a particular repository 
has evolved, you can just look at the reflog (although admittedly, common 
tools like "gitk" don't even show it - the data is there if they would 
want to, but the most common usage is the above kind of "show me what 
happened in the last five hours in my current branch".

			Linus
