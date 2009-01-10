From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Main branch being maintained with 'git am', how do mere mortals
 interact without too much conflicts?
Date: Sat, 10 Jan 2009 16:18:52 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngmhijb.3u7.sitaramc@sitaramc.homelinux.net>
References: <87vdsntnyd.dancerj%dancer@netfort.gr.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 10 17:20:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLgZU-0001l4-PF
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 17:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbZAJQTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 11:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbZAJQTE
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 11:19:04 -0500
Received: from main.gmane.org ([80.91.229.2]:39910 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853AbZAJQTD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 11:19:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LLgY8-0006GA-2k
	for git@vger.kernel.org; Sat, 10 Jan 2009 16:19:00 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 16:19:00 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 16:19:00 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105126>

On 2009-01-10, Junichi Uekawa <dancer@netfort.gr.jp> wrote:

> I've been maintaining my Git repository (monthlyreport.git) where most
> people do not have push access, and I'm taking patches through e-mail
> with 'git am'.

In general, if inputs are bunched up and arrive all
together, there's bound to be conflicts.

> It often happens that I'm receiving patches which won't apply without
> a merge ('git am -3') and happen to be conflict-resolving often,
> because people work off a branch a few days before, and try to send

That's the key phrase, the delay between when they pulled
and when they committed.  I'm not sure of the nature of the
data, and how close it is to "source code" but normally this
is a case for a rebase.

If you don't want them to use branches, you can sort of get
away with these changes to your current flow:

> User does 
>   git pull xxxx
    use "git pull --rebase xxxx" instead of plain pull;
    resolve conflicts if needed
>   edit ...
    (I'm assuming there's a long gap between the pull above
    and the add below)
>   git add 
>   git commit 
    git fetch       # update from origin
    git rebase origin/master
    (they may have to resolve conflicts, but it's easiest
    when done at this point)
>   git format-patch -o ... HEAD^

> I do bunch of 
>     git am -3 (which usually has a conflict of some way or other)
>     git add XXXX
>     git am -3 --resolve
>     git push

The less the time gap between their "git format-patch" and
your "git am", the less conflicts you will have.  If you're
working almost in "real time", the next user gets the latest
tree when he does his "git rebase origin/master" -- and in
fact that becomes pretty much the only point at which any
conflicts even happen.

...and you don't usually have to resolve a single conflict
;-)
