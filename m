From: "Edward Z. Yang" <ezyang@MIT.EDU>
Subject: Re: My use case
Date: Sat, 30 Jan 2010 03:47:43 -0500
Message-ID: <1264840729-sup-5264@ezyang>
References: <ron1-09825C.00261930012010@news.gmane.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 09:48:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb8zo-0004w4-78
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 09:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560Ab0A3Irx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 03:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752501Ab0A3Irw
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 03:47:52 -0500
Received: from DMZ-MAILSEC-SCANNER-3.MIT.EDU ([18.9.25.14]:50048 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752270Ab0A3Irw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jan 2010 03:47:52 -0500
X-AuditID: 1209190e-b7bfcae000000943-68-4b63f2375966
Received: from central-city-carrier-station.mit.edu (CENTRAL-CITY-CARRIER-STATION.MIT.EDU [18.7.7.72])
	by dmz-mailsec-scanner-3.mit.edu (Symantec Brightmail Gateway) with SMTP id 44.44.02371.732F36B4; Sat, 30 Jan 2010 03:47:51 -0500 (EST)
Received: from outgoing-legacy.mit.edu (OUTGOING-LEGACY.MIT.EDU [18.7.22.104])
	by central-city-carrier-station.mit.edu (8.13.6/8.9.2) with ESMTP id o0U8mmmx016839;
	Sat, 30 Jan 2010 03:48:48 -0500 (EST)
Received: from localhost (EZYANG.MIT.EDU [18.243.1.50])
	)
	by outgoing-legacy.mit.edu (8.13.6/8.12.4) with ESMTP id o0U8m2en019043;
	Sat, 30 Jan 2010 03:48:03 -0500 (EST)
In-reply-to: <ron1-09825C.00261930012010@news.gmane.org>
User-Agent: Sup/git
X-Scanned-By: MIMEDefang 2.42
X-Brightmail-Tracker: AAAAAQCq+Kk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138465>

Excerpts from Ron Garret's message of Sat Jan 30 03:26:19 -0500 2010:
> In other words, it is not uncommon to want to roll back an individual 
> file or set of files to an earlier version and leave the rest of the 
> tree alone.  git can do this, but it's not straightforward.  Simply 
> rolling back through the history of the current branch doesn't work 
> because you might want to roll back file A, but the last dozen revisions 
> or so have been changes to file B.  You might also want to roll both A 
> and B back to states which never co-existed in the original history.
> 
> One approach is to use git rev-list to find those commits where 
> particular files changed, but this is sub-optimal for several reasons.  
> First, a naive approach calls rev-list for every rollback, and rev-list 
> has to traverse the entire history, so it's very inefficient.  Second, 
> if you roll back a single file, git doesn't keep track of that file's 
> provenance, so you have to manually track which files and have been 
> rolled back and which revisions they have been rolled back to.  (There 
> was a third problem but I can't think what it was right now.)

My approach, in this case, would be to use git log, possibly git log -p,
in order to view the changes in each file you were interested in rolling
back.  If the rollback falls on a commit boundary, great; you can use
`git checkout rev -- path`.  If not, you can perform that, and then
use git checkout -p to selectively revert hunks in the patch (fundamentally,
you can't really get better than that).

> I have this intuition that git can be made to really do this right by 
> keeping a separate history of every individual file in addition to a 
> history of the entire source tree.  Git can't do this directly as far as 
> I know.  I'd be writing additional code to generate extra tree and 
> commit objects every time a file was saved from the IDE.  But turning 
> this intuition into reality is turning out to be quite challenging.  So 
> I'm going with the rev-list approach for the first version despite its 
> shortcomings.

While Git's ability to look at individual file's history is "slower", it's still
quite excellent, and you are encouraged to use it as necessary.

Slightly relatedly, I'd recommend flushing to disk and committing more
often.  It's great that the LISP REPL allows for more daring changes,
but having a history either way is very helpful!

Cheers,
Edward
