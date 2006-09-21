From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git user survey and `git pull`
Date: Thu, 21 Sep 2006 10:38:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609211027440.4388@g5.osdl.org>
References: <20060921162401.GD3934@spearce.org> <20060921164048.GY8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 19:41:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQSV6-0008Jd-DY
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 19:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWIURiM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 13:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWIURiM
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 13:38:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53721 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751365AbWIURiM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 13:38:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8LHc5nW006298
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 21 Sep 2006 10:38:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8LHc408016409;
	Thu, 21 Sep 2006 10:38:05 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060921164048.GY8259@pasky.or.cz>
X-Spam-Status: No, hits=-0.491 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.151 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27498>



On Thu, 21 Sep 2006, Petr Baudis wrote:
> 
> This is artifact of the BitKeeper terminology. This is the meaning in
> most other VCSes but in BitKeeper, pull meant "get changes and merge
> them", not just "get changes". So the BitKeeper legacy lives on. :-)

Indeed. "pull/push" are the operations bk has. 

BK doesn't have branches, and cannot do a "fetch", so there's no confusion 
in BK - the pulls and the pushes are not mirror-images, but since there 
are no other operations you'd normally use, you can pretty much ignore it.

(That's not entirely true. In BK, you can do "bk receive" and "bk resolve" 
to "fetch" and "merge" another branch, but quite frankly, I personally 
found them so confusing that I never used them at all).

I agree that the clarifications from Shawn are probably improvements, but 
I'd actually like to solve the problem a bit differently. Namely, I was 
hoping that the per-branch configuration would solve the confusion.

Right now, a plain "git pull" means "fetch all branches and merge the 
first one", and the thing is, that's generally the right thing _only_ if 
you pull into "master".

It's usually exactly the _wrong_ thing to do for any other branch. In 
particular, if you work with a project that has lots of branches, and 
you're working in another branch (that is directly tracking a remote, for 
example), doing a "git pull" definitely should _not_ merge the first head. 
It should fetch everything, and possibly merge the _matching_ head.

Which it doesn't do right now.

So I think the problem with "git pull" is not that it's a "fetch and 
merge", it's that it merges the wrong head. It always merges the first 
remote one (aka the remote "HEAD"), regardless of which head we happen to 
be at right now.

So I was kind of hoping that the per-branch configuration stuff (that 
petered out after the .git/config file format was worked out) would solve 
the problem.

That said, maybe Shawn's suggestion is better. And maybe the fact that 
we'd change the semantics mid-stream would make things even WORSE. I 
dunno.

		Linus
