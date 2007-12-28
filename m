From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Anomalous conflicts during git rebase
Date: Fri, 28 Dec 2007 12:58:40 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0712281246330.13593@iabervon.org>
References: <m3ir2ju5ce.fsf@euroclydon.lan> <alpine.LNX.1.00.0712271840030.13593@iabervon.org> <m3k5my7r1u.fsf@euroclydon.lan>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-2071333509-1198864720=:13593"
Cc: git@vger.kernel.org
To: adr3nald0s@gmail.com
X-From: git-owner@vger.kernel.org Fri Dec 28 18:59:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8JUE-0004R4-Ao
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 18:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbXL1R6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 12:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbXL1R6m
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 12:58:42 -0500
Received: from iabervon.org ([66.92.72.58]:44942 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbXL1R6l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 12:58:41 -0500
Received: (qmail 7880 invoked by uid 1000); 28 Dec 2007 17:58:40 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Dec 2007 17:58:40 -0000
In-Reply-To: <m3k5my7r1u.fsf@euroclydon.lan>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69292>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-2071333509-1198864720=:13593
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 28 Dec 2007, adr3nald0s@gmail.com wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > This will rebase temp0 (= v2.6.16) onto topic/test. This process 
> > linearizes the history being rebased, and conflicts in that history (that 
> > were resolved in the merges) show up when the second change to those lines 
> > gets introduced.
> 
> Thank you for the explaination of why this is happening.  This is
> something I had not considered WRT git-rebase.
> 
> When you say it linearizes history how is this done.  Mentally I still
> have a model of where the "mainline" is at all times and I assumed
> that git-rebase was following this mainline.  However, upon
> reflection, I realize this is naïve.
> 
> When there is a branch and a subsequent merge, does rebase follow both
> branches?  If so, why does it not use the original merged result for
> the newly rebased file if there are no conflicts between the original
> merge result and the file that is being rebased onto as compared to
> their mutual ancestor?

Rebase takes a list of commits that are in the current branch and 
aren't in the origin branch as what it's going to work on; these are 
ordered in some arbitrary way such that children always follow parents. It 
then resets to the origin branch's commit, and, in sequence, cherry-picks 
each of the commits in the working list. This has two implications:

 - the result is always linear, even if there are forks and merges in the 
   old history, because the new history is formed out of a single sequence 
   of cherry-picks, ignoring the shape of the original.

 - merge results from the old history aren't available, because they're in 
   a commit later in the list than the commit where the cherry-picking 
   finds a conflict.

In theory, of course, it could try to resolve conflicts by looking through 
the rest of the list for merges which would have those conflicts and using 
what that merge did. But that's not at all easy, due to the structure of 
the process, and it's rare that people actually want to rebase history 
with forks in it, anyway, so it hasn't been done.

	-Daniel
*This .sig left intentionally blank*
--1547844168-2071333509-1198864720=:13593--
