From: Kevin D <me@ikke.info>
Subject: Re: Checkout --force without complete overwrite?
Date: Fri, 6 Mar 2015 12:36:36 +0100
Message-ID: <20150306113636.GA11836@vps892.directvps.nl>
References: <D289021BF8782144A9BEB8ED592B380D2B106BA9@xmb-aln-x02.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Phil Hord (hordp)" <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 12:36:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTqYe-0003gt-VL
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 12:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754333AbbCFLgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 06:36:40 -0500
Received: from ikke.info ([178.21.113.177]:34485 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752374AbbCFLgh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 06:36:37 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 4120A1DCF6D; Fri,  6 Mar 2015 12:36:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <D289021BF8782144A9BEB8ED592B380D2B106BA9@xmb-aln-x02.cisco.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264914>

On Fri, Mar 06, 2015 at 02:39:58AM +0000, Phil Hord (hordp) wrote:
> I have a repo whose workdir tends to get pretty dirty as I jump around from branch to branch tending weeds and whatnot.   Sometimes when I try to switch branches git refuses because of local file changes.
> 
>   git checkout otherbranch
>   error: Your local changes to the following files would be overwritten by checkout:
> 	foo.txt
> 	bar.c
>   Please, commit your changes or stash them before you can switch branches.
>   Aborting
> 
> I resolve this by examining my local changes and deciding if I want to keep them or not.  I keep the changes in the conflicting files that I want, and then I discard the rest.
> 
> One way to "discard the rest" is to say 
>    git checkout HEAD -- foo.txt bar.c && git checkout otherbranch
> 
> But sometimes the list of local-change conflicts I want to discard is too long and this recipe seems like a good alternative to me:
>    git checkout -f otherbranch
> 
> But this is disastrous, because I have been focused on examining the conflicting local changes in foo.txt and bar.c, but I forgot about my non-conflicting changes to baz.c, lost as it is in a sea of untracked files making up the majority of my workdir local changes.  So all my untracked files make the leap unscathed, but my precious forgotten changes in baz.c get wiped out by the checkout --force, even though the baz.c in index and in otherbranch are the same.
> 
> I've read the documentation for 'git checkout --force' several times and I have a hard time deciding what it means to do.  But I'm sure it's doing what it's designed to do and what the man page says it will.  (English is my first language, btw.)

Git normally refuses to overwrite uncomitted changes when checking out
complete commits (so not when you check out individual files). --force
overrides that behaviour.

> 
> What I am seeking is some way to checkout the other branch and replace my conflicted local changes while ignoring my non-conflicting local changes in tracked files.  Something like --force-gently, maybe.  Does such an option exist?
> 
> I could script something, but it comes up only often enough to bite me, so I'm sure I'd forget I had scripted it.
> 
> Thanks,
> Phil

What about git checkout -m <otherbranch>. This will try to merge the
commit you checkout in the working tree, creating conflicts when they
happen. This way, you can decide per conflict what you want to do, while
non-conflicting changes are just kept.
