From: Steven Grimm <koreth@midwinter.com>
Subject: Recovering from an aborted git-rebase?
Date: Tue, 09 Jan 2007 15:20:33 -0800
Message-ID: <45A42341.8040304@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jan 10 00:20:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4QGJ-00086R-O4
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 00:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbXAIXUH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 18:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbXAIXUG
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 18:20:06 -0500
Received: from tater.midwinter.com ([216.32.86.90]:57927 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932514AbXAIXUF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 18:20:05 -0500
Received: (qmail 9606 invoked from network); 9 Jan 2007 23:20:04 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=KzwRXoX+B4GrR5KOx0R4NC7sAOfLqLZxdgGNnUyaXoWtDzFIpSRUeTiIC3M8XytA  ;
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1)
  by localhost with SMTP; 9 Jan 2007 23:20:04 -0000
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36420>

Got this from one of the other people here who's using git. Luckily he 
was able to restore his repo from a filesystem snapshot, so no permanent 
harm done, but what's the pure-git way to recover from this? Are the 
revisions in question really gone?

---
I have 3 branches:
master
fql
fql-new
master is basically just the same as remotes/git-svn, fql is a bunch of
changes on top of that, and then fql-new is a new version of FQL so it makes
changes on top of the changes in fql (with the intention being to make it
easy to jump back if I didn't wind up liking the new version).
unfortunately perhaps I made it too easy, as now fql and fql-new are
identical and I can't get the additional set of changes back for fql-new.

Generally when I want to sync up to SVN I just fetch it in master and then
rebase everything to its parent branch - basically my goal being to get git
show-branch to look the same as it did before the fetch.  This time I did
the fetch command in fql-new instead of master, which I'm pretty sure I've
done before with no real harm done.  Anyway, here's what I did:
(in fql-new branch)
dev005:~/www-git$ git svn fetch
<pulls in the usual updates>
dev005:~/www-git$ git rebase fql
Current branch fql-new is up to date.
dev005:~/www-git$ git checkout master
dev005:~/www-git$ git rebase remotes/git-svn
First, rewinding head to replay your work on top of it...
HEAD is now at a5074e5... Fix IE6 display bug on photo_comments
Fast-forwarded master to remotes/git-svn.
dev005:~/www-git$ git checkout fql
dev005:~/www-git$ git rebase master
<works normally, lots of output spew>
dev005:~/www-git$ git checkout fql-new
dev005:~/www-git$ git rebase master
First, rewinding head to replay your work on top of it...
HEAD is now at a5074e5... Fix IE6 display bug on photo_comments
*********
at this point I think to myself "oops, I meant to rebase to fql, not to
master" and press ctrl+c
*********
dev005:~/www-git$ git rebase fql
First, rewinding head to replay your work on top of it...
HEAD is now at 7b49c62... split up some fql/fields/ files to more closely
match the actual tables we have
Fast-forwarded fql-new to fql.
******
notice that it doesn't apply any changes on top of fql and doesn't output
any spew here
*******
dev005:~/www-git$

and just like that, now all those changes from fql to fql-new are totally
lost.  git log and git show-branch show no trace of them.
