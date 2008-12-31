From: Daniel Barkalow <barkalow@iabervon.org>
Subject: RE: for newbs = little exercise / tutorial / warmup for windows and
 other non-sophisticated new Git users :-) [Scanned]
Date: Tue, 30 Dec 2008 22:10:45 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812302143210.19665@iabervon.org>
References: <BB5F02FD3789B54E8964D38D6775E718242D35@ALTMORE-SVR.altmore.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Whiteside <jeff.m.whiteside@gmail.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Conor Rafferty <conor.rafferty@altmore.co.uk>
X-From: git-owner@vger.kernel.org Wed Dec 31 04:13:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHrWJ-0001t7-Uv
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 04:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930AbYLaDKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 22:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754729AbYLaDKr
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 22:10:47 -0500
Received: from iabervon.org ([66.92.72.58]:53555 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754299AbYLaDKq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 22:10:46 -0500
Received: (qmail 26232 invoked by uid 1000); 31 Dec 2008 03:10:45 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Dec 2008 03:10:45 -0000
In-Reply-To: <BB5F02FD3789B54E8964D38D6775E718242D35@ALTMORE-SVR.altmore.local>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104246>

On Wed, 31 Dec 2008, Conor Rafferty wrote:

> -----Original Message-----
> wtf is wrong with
> 
> git checkout <something>
> 
> ??
> 
> ** It doesn't reliably put the files that were in that revision into the
> working directory - a fairly major flaw, for what I'm using SCM for (and
> 80% of the market IMHO)

It certainly does for me; I rely on it pretty much constantly. Can you 
give a sequence of commands (ideally the whole sequence from the "git 
init") that leads to a difference?

The only case I know of where there will be files left over is if you 
switch from a situation where you have an untracked file (e.g., you create 
C.txt but don't add it to anything) to another situation where the file 
still isn't tracked, it won't remove it. But, of course, you wouldn't 
really want git to remove your uncommitted work in general, since it's 
generally irreplaceable. It'll only be lacking files if it fails to switch 
(if, for instance, you had uncommitted changes that conflict with the 
changes that it would do), and it will give an error message in that case.

> if you must have
> 
> git checkout <something> <paths>
> 
> then instead use
> 
> git checkout <something> <paths>
> git clean
> 
> ** hmm, might try this - obviously as per Daniels post there is some
> undefined interaction happenign with the index, to screw up the working
> directory. I presume clean flushes the index?

git clean wouldn't remove those files, because they're supposed to be 
there at that point.

In the sequence:

...
$ git tag versionD
$ git checkout versionA .

This means: "Update the index with the files in versionA, and working 
directory from the index"

So now you're working on a commit based versionD (because you didn't 
switch branches), and your work thus far, which is marked as ready for 
your next commit, is to recover the removed files ABC.txt and AC.txt (from 
versionA).

$ rm *.*

This removes those files again, but only in your working directory. Your 
index still says that your next commit will recover them.

$ git checkout versionB .

This recovers ABC.txt and BC.txt (from versionB). Your index has ABC.txt, 
BC.txt (from versionB), and AC.txt (from versionA), marked as going into 
the next commit. It also puts all of these in your working directory (when 
you might expect it to only put ABC.txt and BC.txt there).

So (a) you're still working on the commit after versionD, rather than 
navagting history at all; and (b) you've recovered files from two 
different commits.

Now:

$ git clean

will remove any files that you happen to have around, other than the one 
you're confused about and trying to get rid of.

	-Daniel
*This .sig left intentionally blank*
