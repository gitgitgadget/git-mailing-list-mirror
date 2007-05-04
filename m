From: Michael Niedermayer <michaelni@gmx.at>
Subject: Re: FFmpeg considering GIT
Date: Fri, 4 May 2007 13:46:28 +0000 (UTC)
Message-ID: <loom.20070504T143538-533@post.gmane.org>
References: <loom.20070502T111026-882@post.gmane.org> <20070503180016.GB21333@informatik.uni-freiburg.de> <20070503200013.GG4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 15:55:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjyFn-0002S8-6e
	for gcvg-git@gmane.org; Fri, 04 May 2007 15:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286AbXEDNzQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 09:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755279AbXEDNzQ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 09:55:16 -0400
Received: from main.gmane.org ([80.91.229.2]:60019 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755286AbXEDNzN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 09:55:13 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HjyFS-0005y7-Ce
	for git@vger.kernel.org; Fri, 04 May 2007 15:55:02 +0200
Received: from chello080109116125.4.15.vie.surfer.at ([80.109.116.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 May 2007 15:55:02 +0200
Received: from michaelni by chello080109116125.4.15.vie.surfer.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 May 2007 15:55:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.109.116.125 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.2) Gecko/20070208 Iceweasel/2.0.0.2 (Debian-2.0.0.2+dfsg-3))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46181>

Petr Baudis <pasky <at> suse.cz> writes:
[...]
> > 	let me explain a little bit why this is critically needed
> > 	think of someone misstakely commiting the whole ffmpeg
> > 	reindented or mistakely commiting a old ffmpeg version over the
> > 	new or another total messup, these things do happen, and
> > 	especially if they cannot be corrected and at the time where
> > 	none of the developers is around
> > 
[...]
>   Still, if this kind of bogus change checkins happens at any frequent
> rate in the ffmpeg project, there is a serious problem somewhere. 

well, my example above was exagerated, noone ever reindented the whole
ffmpeg or checked in a old version over HEAD. what did and does occasionally
happen is that people check in several things at once (like a 100k reindenton
mixed with various functional changes)
for these we currently copy the last good version of the affected files
over the current one with svn cp and then apply the changes in nicely
split manner. (possibly without the reindention if its uneeded ...)
Another thing that happens occasionally is that complete nonsense is checked
in like checking in the wrong file or some "private" debuging code

we never use the svn cp method to revert normal buggy code ...



> But I think the git way of alleviating this problem would be to have a
> way to hint the pickaxe and blame tools to ignore changes in given
> commits. So, you don't _cover up_ the messy things that happened during
> the history, but avoid in getting in the way in your view. You can still
> look it up (with git log or something) in case you'd need to (perhaps
> the revert patch was a bit complicated because of conflicting with some
> other changes, and a subtle bug was introduced; this would be thousand
> times harder to track down if you would've rewritten the history).
> 
>   Would crafting up a patch to implement something like this help ffmpeg
> people in their decision?

well if git blame and others could somehow be told to automatically ignore
nonsense changes and matching nonsense reverts that would be great
maybe by searching for some keyword in the revert message?

ignoring all or no reverts though would again be suboptimal as that would
also ignore some reverts due to normal buggy changes

actually i think ive found an almost working solution for replacing svn cp
(though i dont know if its safe on a public repo? or if theres some other
issue with it iam missing)

ascii > testfile
git add testfile ; git commit
Created initial commit c14755cd59af4b0e6c53fb3d4bf8fa7d5aad3f3d
 1 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100644 testfile

vim testfile 
git add testfile ; git commit
Created commit 0fd74c0955ae4281ac17520eabefea639f635354
 1 files changed, 2 insertions(+), 2 deletions(-)

vim testfile 
git add testfile ; git commit
Created commit d1dce0e5a20603faa0e64b722d93e847f5b80845
 1 files changed, 23 insertions(+), 23 deletions(-)

git checkout 0fd74c0955ae4281ac17520eabefea639f635354
Note: moving to "0fd74c0955ae4281ac17520eabefea639f635354" which 
isn't a local branch
If you want to create a new branch from this checkout, you may do so
(now or later) by using -b with the checkout command again. Example:
  git checkout -b <new_branch_name>
HEAD is now at 0fd74c0... good change

cp testfile testbak
git add testbak ; git commit
Created commit 0e55c6f422005e64fd3b73595f0fe409148d725f
 1 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100644 testbak

git checkout d1dce0e5a20603faa0e64b722d93e847f5b80845
HEAD is now at d1dce0e... bad change
$git rm testfile 
rm 'testfile'

git merge 0e55c6f422005e64fd3b73595f0fe409148d725f
 100% (1/1) done
Merge made by recursive.
 testbak |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100644 testbak

git mv testbak testfile 
fatal: destination exists, source=testbak, destination=testfile
git rm testfile 
rm 'testfile'
git mv testbak testfile 

git commit
Created commit ca5bcbcadb9799b0a6eaa792fae322d511ecd55f
 2 files changed, 23 insertions(+), 46 deletions(-)
 delete mode 100644 testbak

git blame -C1 -C1 -M testfile
(this just shows ca5bcbca)

vim testfile (changing a single line)
git add testfile ; git commit
Created commit 7a0a828629935ce139177fc4623a0eb9916b78fd
 1 files changed, 1 insertions(+), 1 deletions(-)

git blame -C1 -C1 -M testfile | cut -d ' ' -f 1
^c14755c
^c14755c
^c14755c
^c14755c
^c14755c
0fd74c09
0fd74c09
^c14755c
^c14755c
^c14755c
^c14755c
^c14755c
^c14755c
^c14755c
^c14755c
^c14755c
7a0a8286
ca5bcbca
ca5bcbca
ca5bcbca
ca5bcbca
ca5bcbca
ca5bcbca

this is correct except the last 6 lines

[...]

Michael
