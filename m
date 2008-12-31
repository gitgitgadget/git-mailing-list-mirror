From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and
 other non-sophisticated new Git users :-) [Scanned]
Date: Wed, 31 Dec 2008 13:37:49 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnglmtdd.v54.sitaramc@sitaramc.homelinux.net>
References: <BB5F02FD3789B54E8964D38D6775E718242D35@ALTMORE-SVR.altmore.local>
 <alpine.LNX.1.00.0812302143210.19665@iabervon.org>
 <gjfn28$3k2$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 31 14:39:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LI1I9-0005yW-CB
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 14:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938AbYLaNiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 08:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755158AbYLaNiA
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 08:38:00 -0500
Received: from main.gmane.org ([80.91.229.2]:45562 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467AbYLaNh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 08:37:59 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LI1Gm-0001C1-8Q
	for git@vger.kernel.org; Wed, 31 Dec 2008 13:37:56 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 13:37:56 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 13:37:56 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104271>

a quick comment: you don't need to use the sha1 to create a
tag at the current HEAD.  "git tag newtag sha" can be
shortened to "git tag newtag" if the sha is for the latest
commit you did.  Like the "." thing, I'd be curious where
you picked up this habit...

On 2008-12-31, Zorba <cr@altmore.co.uk> wrote:
> Why should
>
> $ git checkout <version> .
>
> screw things up for
>
> $ git checkout <version>

These are quite different operations so yes you could say
they should have used some other name instead of overloading
two different functions on the same command.  But to be
fair, the doc is fairly clear, in the first 2 paras.

And really, if I understand all your angst and what you're
trying to do, you just have to stop using the "." and -- if
you want untracked files gone each time you switch to an
older version -- use git clean.  See below.

I have snipped your log heavily but it should still be
fairly simple to follow which piece I am referring to below:

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

> $ git rm AC.txt
> $ git add BC.txt
> $ git commit -m "version B"
> $ git tag versionB fad9

> $ cat > AC.txt
> $ ls
> ABC.txt  AC.txt  BC.txt  C.txt

> $ git reset --hard versionB
> HEAD is now at fad9c29 version B
> $ ls
> ABC.txt  AC.txt  BC.txt  C.txt

you're wondering why AC.txt is still hanging around when
resetting to a commit where that file was explicitly
deleted?

A commit represents a state, not a set of actions.

"versionB" doesn't represent a "delete of AC.txt", plus an
"add of BC.txt".  It represents a state where ABC.txt and
BC.txt exist, that's it.

So AC.txt is now just an untracked file at the point you do
the reset, as you would have seen if you did a "git status".

A reset will not touch untracked files -- hardly any
operation will touch an untracked file actually.

If you really want that functionality, use git clean after
the reset, this is the only command I know that deletes
untracked files:
        git clean -d -f
        # or first try with "-n" for a "dry-run"

[later]

> $ git checkout versionA
> $ ls
> ABC.txt  AC.txt  comment.txt

> $ git checkout versionB
> $ ls
> ABC.txt  BC.txt  comment.txt

And now you're wondering what happened to "AC.txt"?  Well
this time it's a known and tracked file for the current
state (versionA), so it is a candidate for removal/change as
dictated by the new state you're going to.

I should also mention that you have not yet tried the case
where you have local modifications to some file that is
known to both the current branch and the branch you're
switching to.  "git help checkout" and look for the word
"merge" and read up the two places it is relevant to this
context (one a description and one an example).
