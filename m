From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Two gitweb feature requests
Date: Fri, 28 Apr 2006 11:23:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604281116020.3701@g5.osdl.org>
References: <1146144425.11909.450.camel@pmac.infradead.org> <e2tjqm$83n$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 28 20:23:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZXcg-0001Hn-6T
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 20:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbWD1SXR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 14:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbWD1SXR
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 14:23:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18105 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751777AbWD1SXQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Apr 2006 14:23:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3SINDtH014795
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 28 Apr 2006 11:23:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3SINB4Z014643;
	Fri, 28 Apr 2006 11:23:13 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e2tjqm$83n$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19285>



On Fri, 28 Apr 2006, Jakub Narebski wrote:
>
> I'd like to have 'parent directory' link for trees ('..' link) at the top of
> it's contents. I know it is possible to use browser history for that, but
> it would give greater similarity with 'directory listing' mode of WWW
> servers.

Well, a git "tree" doesn't actually _have_ a parent. It potentially has 
multiple.

So to get to "a parent", you literally do need to keep track of how you 
got to the tree. Which is certainly possible (maybe it even ends up being 
in the URI that gitk generates, I didn't check), but basically, if it 
isn't tracked explicitly, it basically is impossible to find.

Not having back-pointers is what allows git to do data sharing and a lot 
of other things efficiently. A tree is a tree is a tree, and has zero data 
about what points to it, so as long as the _contents_ of a tree are the 
same, you have exactly the same object. That means that the same subtree 
can - and will - be pointed to by multiple upper-level trees and commits. 

So you do need that "browser history" one way or another. Either in the 
browser (use the "back button") or by encoding the "how did we get here" 
information in the URI and the dynamically generated page content.

The downside is that you'd have two different web-pages for the same tree 
depending on which commit it came from. Which is not a downside from a 
user perspective, but it's a downside from a caching/server perspective, 
since it means less reuse of pages (maybe gitweb already does that, 
though).

		Linus
