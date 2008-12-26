From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Strange large push operation.
Date: Fri, 26 Dec 2008 14:48:47 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngl9rmf.r7h.sitaramc@sitaramc.homelinux.net>
References: <4954CCD6.5000105@daysofwonder.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 26 15:52:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGE2q-0006mS-JB
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 15:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbYLZOtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 09:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752253AbYLZOs7
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 09:48:59 -0500
Received: from main.gmane.org ([80.91.229.2]:41398 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbYLZOs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 09:48:58 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LGDzk-0002sW-8t
	for git@vger.kernel.org; Fri, 26 Dec 2008 14:48:56 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Dec 2008 14:48:56 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Dec 2008 14:48:56 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103944>

On 2008-12-26, Brice Figureau <brice+git@daysofwonder.com> wrote:

> Then I wanted to push this newbranch as a remote branch with:
> $ git push origin newbranch:refs/heads/newbranch

I'd have just said "git push origin newbranch" :-)

> and obtained the following output:
> Counting objects: 12767, done.
> Compressing objects: 100% (3816/3816), done.
> writing objects:   8% (935/11682), 2.40 MiB | 324 KiB/s
> ^C

> I stopped the push because I don't get why there are so much objects to 
> send while the diff between newbranch and branch is only 5 small commits 
>   (and it obviously wants to push a large part of the history).

Yes but you didn't actually say that the master has "branch"
-- perhaps it isn't as uptodate as you thought it was...?
Or perhaps there was a rebase or something that changed a
*lot* of stuff.

Try "git log -n 1 branch" on both machines to see if they
point to the same hash.

[Additionally, I'm not really sure if that progress is a
worst case estimate or a real estimate...]

> Is there a way to check what objects are sent to origin and why?

My all-time favourite git command is "bundle" [which should
tell you I work a lot with disconnected repos!]

Try "git bundle create /tmp/temp.bdl branch..newbranch" then
see how big that temp file is.  That'll be about what goes
to the other side (assuming the other side has the same hash
for "branch").

You could even take it to the other side and do the
following:
    git ls-remote temp.bdl  # shows refs in bundle
    git fetch temp.bdl one-of-the-refs-in-the-bundle
    git merge FETCH_HEAD # merge it into current branch

> What could be the cause of the issue?

can't say.  Try the following commands also to get a birds
eye view of the various branches on both sides
    git fetch   # update your idea of what's on remote
    git branch -a -v

I also like
    git log --graph --pretty=oneline --abbrev-commit --decorate --all
which I've aliased to "lg"

> (and found 5 unreachables objects in the local one, should I care?). I 

Nope.  Lots of reasons to have unreachable objects...
