From: Ron Garret <ron1@flownet.com>
Subject: My use case
Date: Sat, 30 Jan 2010 00:26:19 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-09825C.00261930012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 09:27:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb8ff-0004tk-Jt
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 09:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412Ab0A3I0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 03:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311Ab0A3I0o
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 03:26:44 -0500
Received: from lo.gmane.org ([80.91.229.12]:52091 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669Ab0A3I0n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 03:26:43 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nb8fC-0004g5-KR
	for git@vger.kernel.org; Sat, 30 Jan 2010 09:26:42 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 09:26:42 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 09:26:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138464>

My recent question about checking out an upstream commit (and ending up 
as a result on a detached head) has generated a lot of discussion and 
useful information.  I thought I'd describe what I'm actually up to 
because someone might have some ideas on how to do it better.

I'm trying to integrate git into a Lisp IDE (Clozure Common Lisp).  
Because it's Lisp, code is often developed incrementally and 
experimentally.  This has two important consequences.  First, the files 
in your working directory can and often do, as part of the normal course 
of events, get into an incoherent state.  Everything in your running 
Lisp image is working just fine, but if you try to recompile your entire 
system something will break, and you can go for a very long time without 
discovering that this has happened.  Second, development can often lead 
to dead-ends where you want to throw everything you've just done away, 
go back to some earlier version of *some but not all* of your code, and 
start over.

In other words, it is not uncommon to want to roll back an individual 
file or set of files to an earlier version and leave the rest of the 
tree alone.  git can do this, but it's not straightforward.  Simply 
rolling back through the history of the current branch doesn't work 
because you might want to roll back file A, but the last dozen revisions 
or so have been changes to file B.  You might also want to roll both A 
and B back to states which never co-existed in the original history.

One approach is to use git rev-list to find those commits where 
particular files changed, but this is sub-optimal for several reasons.  
First, a naive approach calls rev-list for every rollback, and rev-list 
has to traverse the entire history, so it's very inefficient.  Second, 
if you roll back a single file, git doesn't keep track of that file's 
provenance, so you have to manually track which files and have been 
rolled back and which revisions they have been rolled back to.  (There 
was a third problem but I can't think what it was right now.)

I have this intuition that git can be made to really do this right by 
keeping a separate history of every individual file in addition to a 
history of the entire source tree.  Git can't do this directly as far as 
I know.  I'd be writing additional code to generate extra tree and 
commit objects every time a file was saved from the IDE.  But turning 
this intuition into reality is turning out to be quite challenging.  So 
I'm going with the rev-list approach for the first version despite its 
shortcomings.

If anyone has ideas or suggestions, feedback would be much appreciated.  
But this is mostly just FYI.

rg
