From: Stephen Bash <bash@genarts.com>
Subject: Re: Git is not scalable with too many refs/*
Date: Thu, 9 Jun 2011 11:42:30 -0400 (EDT)
Message-ID: <5313676.596.1307634150272.JavaMail.root@mail.hq.genarts.com>
References: <m38vtbdzjq.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, NAKAMURA Takumi <geek4civic@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 17:42:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUhNc-0001M9-5B
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 17:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597Ab1FIPmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 11:42:38 -0400
Received: from hq.genarts.com ([173.9.65.1]:36580 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751052Ab1FIPmi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 11:42:38 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 1CBEFEA22FE;
	Thu,  9 Jun 2011 11:42:37 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HznArLCIaPVN; Thu,  9 Jun 2011 11:42:30 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 5B019EA22EC;
	Thu,  9 Jun 2011 11:42:30 -0400 (EDT)
In-Reply-To: <m38vtbdzjq.fsf@localhost.localdomain>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175531>

----- Original Message -----
> From: "Jakub Narebski" <jnareb@gmail.com>
> To: "NAKAMURA Takumi" <geek4civic@gmail.com>
> Cc: "git" <git@vger.kernel.org>
> Sent: Thursday, June 9, 2011 7:18:09 AM
> Subject: Re: Git is not scalable with too many refs/*
> NAKAMURA Takumi <geek4civic@gmail.com> writes:
> 
> > Hello, Git. It is my 1st post here.
> >
> > I have tried tagging each commit as "refs/tags/rXXXXXX" on git-svn
> > repo locally. (over 100k refs/tags.)
> [...]
> 
> That's insane. You would do much better to mark each commit with
> note. Notes are designed to be scalable. See e.g. this thread
> 
> [RFD] Proposal for git-svn: storing SVN metadata (git-svn-id) in notes
> http://article.gmane.org/gmane.comp.version-control.git/174657

As a reformed SVN user (i.e. not using it anymore ;]) I agree that 100k tags seems crazy, but I was contemplating doing the exact same thing as Takumi.  Skimming that thread, I didn't see the key point (IMO): notes can map from commits to a "name" (or other information), tags map from a "name" to commits.

I've seen two different workflows develop:
  1) Hacking on some code in Git the programmer finds something wrong.  Using Git tools he can pickaxe/bisect/etc. and find that the problem traces back to a commit imported from Subversion.
  2) The programmer finds something wrong, asks coworker, coworker says "see bug XYZ", bug XYZ says "Fixed in r20356".

I agree notes is the right answer for (1), but for (2) you really want a cross reference table from Subversion rev number to Git commit.

In our office we created the cross reference table once by walking the Git tree and storing it as a file (we had some degenerate cases where one SVN rev mapped to multiple Git commits, but I don't remember the details), but it's not really usable from Git.  Lightweight tags would be an awesome solution (if they worked).  Perhaps a custom subcommand is a reasonable middle ground.

Thanks,
Stephen
