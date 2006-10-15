From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb.cgi feature request: project list "last change" column	to display last change of all heads.
Date: Sun, 15 Oct 2006 14:17:37 +0200
Organization: At home
Message-ID: <egt8sk$99u$1@sea.gmane.org>
References: <4531FC77.6010004@adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Oct 15 14:17:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZ4vz-0006sa-PE
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 14:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWJOMRg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 08:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWJOMRg
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 08:17:36 -0400
Received: from main.gmane.org ([80.91.229.2]:64986 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964808AbWJOMRg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Oct 2006 08:17:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GZ4vv-0006sM-3r
	for git@vger.kernel.org; Sun, 15 Oct 2006 14:17:35 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Oct 2006 14:17:35 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Oct 2006 14:17:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28914>

Pierre Marc Dumuid wrote:

>  I am working with the Cinelerra-CV group (cvs.cinelerra.org) and we are 
>  starting to use git to develop new patches.  Someone has offered to 
>  mirror our git branches to share amongst ourselves at 
>  http://www.pipapo.org/gitweb.
>  
>  The annoying thing is that in our mirrored personal repositories, we 
>  switch from head to head and push new features in different head, and 
>  then wait for the other developers to review.  At the moment, the 
>  getweb.cgi script only shows the "Last Change" for the current branch, 
>  and not all branches, (i.e. it's currently showing "13 days ago" for 
>  cinelerra-pmdumuid, whilst if you click the summary, you'll see I 
>  actually extended one of the branches only "24 hours ago".

This feature is planned (even if I forgot to mention it in the latest
"[RFC] gitweb wishlist and TODO list"[*1*] thread), but for performance
reasons it waits for git-for-each-ref to be in released version of git, as
it should be used for projects list to not be generated too slow.

But we could add it (although git is now in freezer before 1.4.3 release).
I was thinking about using 
  $feature{'lastchange'}{'default'} = HEAD | <branchname> | undef
where undef means search all branches for latest commit.

>  2nd feature request it the ability to browse to the next / previous 
>  commit when looking at a commitdiff...
 
First, merges can have more than one parent, so "previous" (or rather
"parent") can be ambiguous. Well, we could use first parent... But even
now it is fairly easy to go to the parent commitdiff: click on "commit"
link in the top navigation bar, or on the subject of commit; then click
on the "parent" link in the commit view; then click on "commitdiff" link
in the top navigation bar, or on the subject of commit.

Git philosophy and design precludes any kind of "next" link. Commit object
has only links to parents, never to children. If one really, really need
"next" link, one would need to save branch and where on branch we are
(in the git-name-rev way, e.g. b=HEAD~10) and pray somebody didn't update
the branch.

It should be quite easy to add commit+commitdiff view, though.

[*1*] http://marc.theaimsgroup.com/?t=115082282700003&r=1&w=2
      Msg-Id: <egdge3$t12$1@sea.gmane.org>
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
