From: Stephen Bash <bash@genarts.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Fri, 15 Oct 2010 10:50:46 -0400 (EDT)
Message-ID: <2196050.492435.1287154246295.JavaMail.root@mail.hq.genarts.com>
References: <AANLkTi=PwLmKSb_gF=k+xVSZfM1CDCFZFZdR7pLgh6t6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>,
	Tomas Carnecky <tom@dbservice.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 16:51:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6lca-0004rJ-8Y
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 16:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755356Ab0JOOuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 10:50:54 -0400
Received: from hq.genarts.com ([173.9.65.1]:60882 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754659Ab0JOOux (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 10:50:53 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 8C1D71E2693D;
	Fri, 15 Oct 2010 10:50:52 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f51Uooly2JS6; Fri, 15 Oct 2010 10:50:46 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 6C4491E2693A;
	Fri, 15 Oct 2010 10:50:46 -0400 (EDT)
In-Reply-To: <AANLkTi=PwLmKSb_gF=k+xVSZfM1CDCFZFZdR7pLgh6t6@mail.gmail.com>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159120>


> Thanks for the very interesting read. It seems like a (very) long
> pipeline though, I wonder how we can make this not only easier, but
> also more streamlined for git-remote-svn.

The process can certainly be streamlined.  As is often the case, this process was created via the "just make it work" mentality (and a barely passable knowledge of git).  Now that I'm a little more comfortable with git and it's basic objects, I think I could probably create a new process that does a single pass through the svn-fe created repository and creates a new repository with the correct history (and some other nice features that come with any 2.0).

But I'm also looking at this from a one-time conversion view.  I had a couple of conversations with Ram that showed me my point of view is very narrow compared to the larger git-remote-svn effort...

> Do you have any suggestions
> on how you would prefer this to be done in git-remote-svn? (Main
> advantage for git-remote-svn might be that we can use git notes to
> store commit conversion information, instead of having to mine commit
> messages.)

I think using notes is a better way to associate conversion information with commits, but I would probably still end up mining the notes to create some sort of svn to git mapping...  Correct me if I'm wrong, but I don't see how notes would help me get from an svn rev to a git sha (a common practice for tickets and wiki links in our organization).  The latter is more a job for tags, and while that would be possible, that more than doubles the number of objects in the repository (I have a good percentage of SVN revs that turned into multiple git commit objects).

But otherwise, my suggestions are (unfortunately) rather naive.  "Make it work like git-svn, but faster" :)  I can offer the warning to watch out for cross-branch (subdirectory/file) copies; we had a lot of those in our SVN repository, and I still don't know if there's anyway in Git to represent that operation...  And obviously even if I did have/use the svn merge information, svn merges don't map directly to git merges... but I'm guessing I'm not saying anything you haven't already thought about.

I guess after that I should add that I'm happy to help, I'm just not sure where my experience maps to the on going effort.

Thanks,
Stephen
