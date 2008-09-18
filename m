From: Steven Grimm <koreth@midwinter.com>
Subject: How to remove a commit object?
Date: Thu, 18 Sep 2008 16:41:30 -0700
Message-ID: <D53D127D-97DD-417C-9109-ABD46BBD4E18@midwinter.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Users List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 19 01:42:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgT8y-000680-Hf
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 01:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756280AbYIRXlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 19:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756206AbYIRXlc
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 19:41:32 -0400
Received: from tater.midwinter.com ([216.32.86.90]:53012 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756132AbYIRXlb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 19:41:31 -0400
Received: (qmail 29876 invoked from network); 18 Sep 2008 23:41:30 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=jb3BYjwO2ETzahduRFCMEac0miVhKL/eg1z030fT4Ohg2QyAWOPMvs8tGAMV5XLb  ;
Received: from localhost (HELO ?IPv6:::1?) (127.0.0.1)
  by localhost with SMTP; 18 Sep 2008 23:41:30 -0000
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96255>

I maintain a shared repository a bunch of my coworkers push to for  
code reviews. It has accumulated a lot of packfiles, so I want to  
shrink it down a bit, but there's a problem:

% git repack -A -d
Counting objects: ...
error: Could not read 125bf191b65189aaec7a6aa24ff26460d141d587
fatal: bad tree object 125bf191b65189aaec7a6aa24ff26460d141d587

"git fsck" confirms that the tree object is missing:

% git fsck
broken link from  commit 1b2f0595bb4a6c2e17ca43a9cc41feec88c72a47
               to    tree 125bf191b65189aaec7a6aa24ff26460d141d587
...
missing tree 125bf191b65189aaec7a6aa24ff26460d141d587

This is a dangling commit, but that's fine; for this particular  
repository we actually *want* lots of dangling commits since they  
represent the history of people's code review requests. (Hence me  
running git-repack with -A instead of -a.)

Given that it's dangling, it seems like it'd be safe to just remove  
entirely (we lose that little bit of code-review history but we've  
lost it already anyway with the tree object missing). But I'm not sure  
how to do it. Is it possible to delete a commit object, and if so, how?

I don't know how the corruption happened in the first place. There was  
a short time at one point where the permissions on the object  
directories were inconsistent, so it's possible someone pushed during  
that period and managed to create the commit object file in .git/ 
objects but didn't have permission to create the tree object. That's  
just speculation on my part, though. This is the only corrupt object  
in the repository according to git-fsck, so at this point I just want  
to know how to get rid of it so I can do the repack.

Thanks!

-Steve
