From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Two ideas for improving git's user interface
Date: Wed, 1 Feb 2006 17:23:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602011656130.21884@g5.osdl.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
 <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
 <20060130185822.GA24487@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0601311750270.25300@iabervon.org> <7vek2oot7z.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0601311623240.7301@g5.osdl.org> <7v4q3jlgw2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602011125370.5397@localhost.localdomain>
 <7vhd7ibza2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602011307250.21884@g5.osdl.org>
 <7v8xsu91vf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602011433290.21884@g5.osdl.org>
 <87lkwupsbr.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 02:23:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4TCQ-0006RH-Jg
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 02:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161065AbWBBBXs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 20:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbWBBBXs
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 20:23:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39079 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161065AbWBBBXr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 20:23:47 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k121NdDZ005650
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Feb 2006 17:23:40 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k121Nc2x027280;
	Wed, 1 Feb 2006 17:23:39 -0800
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87lkwupsbr.wl%cworth@cworth.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15476>



On Wed, 1 Feb 2006, Carl Worth wrote:
> 
> Here's a fundamental question I have, (and thanks to Keith Packard for
> helping me to phrase it):
> 
> 	Is it ever useful (reasonable, desirable) to commit file
> 	contents that differ from the contents of the working
> 	directory?

Yes. I do it all the time.

I tend to have a certain fairly constant set of changes in my working 
tree, namely every time a release is getting closer, I always tend to have 
the "Makefile" already updated for the new version (but not checked in: I 
do that just before I actually tag it, so that the tag will match the 
commit that actually changes the version).

I do that largely for historical reasons, namely that I've forgotten too 
many times to actually change the version number, and then I usually get a 
bug report within minutes of cutting the release with a snickering "hah, 
you forgot to change the version again".

So I do lots of commits with that Makefile being dirty, without ever 
actually committing the Makefile changes themselves. "git commit -a" as a 
default would be absolutely _horrible_ for me.

I occasionally have other things dirty too in my tree - just random 
hacking. But the Makefile is dirty about 50% of the time for me, so it's 
the common case.

And most of those commits are automated, either through pulls that are 
successful, or just my email patch-application scripts, and both of those 
cases actually check that the files that are _changed_ are never dirty in 
the working directory.

However, if the question was an even stricter "do you ever commit 
_changes_ to a particular file where the last HEAD, the index _and_ the 
working tree are all different", then the answer is actually "Yes" to that 
too.

What has happened is that I have had merges that have content conflicts 
that I fix up by hand, but exactly _because_ I fix them up by hand, I 
actually want to re-compile the kernel and test my fixups.

And in that case, I will actually re-apply my manual Makefile change, even 
if that file was part of the merge changes (in which case I had had to 
first un-apply the change in order to do the merge).

So what happens is that I recompile with my trivial changes in place 
_after_ I have fixed up any merge conflicts, reboot the thing to test, and 
then commit the result if everything looks ok.

And notice how I commit the _merge_ without actually committing my dirty 
state in the tree - and whether the files involved in my standard dirty 
changes ("Makefile") are part of the state that the merge changed or not 
is _totally_ irrelevant.

So I commit file contents that differ from my current working tree all the 
time.

ALMOST all of the time, the actual _changes_ that I commit do not actually 
touch the files that I have dirty, but as explained above, even that is 
not at all impossible.

The thing is, once you get used to the git "index" as a staging place, 
it's really really powerful. 

> Idea #2 (make it easy to preview diffs of what will be committed)
> -------
> Independent of the above, I'd like to propose another change to help
> prevent confusion and to help users learn git. There should be an
> obvious "diff" operation that presents exactly the result of what any
> "commit" operation will perform.

Actually, we do exactly that. Right now we expressly limit the "preview" 
to just the filenames, but we literally do run

	git-diff-index -M --cached --name-status --diff-filter=MDTCRA HEAD

as part of "git status", and the eventual end result is what we will 
populate the commit message file with for your editing pleasure.

And you can actually see that. 

So I would suggest that new git users never be told about the "-m" flag to 
"git commit", so that they always have to edit the commit message by hand, 
because that commit message will contain exactly this information.

Not the patch itself, though. Maybe we could make it show part of it, 
though, if somebody really wants to see it ;)

		Linus
