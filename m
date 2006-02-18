From: linux@horizon.com
Subject: Re: Why can't git-rebase back up?
Date: 18 Feb 2006 03:56:08 -0500
Message-ID: <20060218085608.30325.qmail@science.horizon.com>
References: <7vmzgpru8m.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 09:56:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FANt7-00088A-Eh
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 09:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWBRI4Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 03:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbWBRI4Q
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 03:56:16 -0500
Received: from science.horizon.com ([192.35.100.1]:63043 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751022AbWBRI4P
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 03:56:15 -0500
Received: (qmail 30326 invoked by uid 1000); 18 Feb 2006 03:56:08 -0500
To: junkio@cox.net, linux@horizon.com
In-Reply-To: <7vmzgpru8m.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16402>

> The one in "next" has a topic branch change which lets you say:
> 
>	$ git rebase --onto v2.6.16-rc2 v2.6.16-rc3 build
>
> which is a shorthand for
>
>	$ git checkout build
>	$ git rebase --onto v2.6.16-rc2 v2.6.16-rc3
>
> That is, tear out my changes that forked from the development
> trail that led to v2.6.16-rc3, and graft them on top of
> v2.6.16-rc2.

Ah, exactly what I was looking for!
However, why did you decide to make the *destination* the option?

Just giving a naive user's perspective, the argument to git-rebase
is the *destination*, and it "magically" figures out the source.

It would seem more natural to me to have an option to explicltly
specify the "from" and leave the positional argument as the "to".

That also lets you do something about the rebasing-a-merged-branch
problem.  If you have:
      g-->h-->i-->j topic
     /       /
a-->b-->c-->d-->e-->f master

Then I'd expect "git-rebase master topic" to fail with
an error message like:

	Error: "topic" and "master" do not have a unique common
		ancestor.  Possible common ancestors:
		b (master~4)
		d (master~2)
	Rebasing a branch with merges is generally not recommended,
	but if you want to do it, you need to specify where to cut
	off the branch to move.  You probably want one of the above.

And you have to use "git-rebase --from b master" or --from d.
H'm... is that unique?  What if you have a bizarre merge pattern
line


     k--->l---->m
    /            \
    | g-->h-->i-->j topic
    |/        
a-->b-->c-->d-->e-->f master

or 

      g-->h-->i-->j topic
     /       /
a-->b---------->c-->d master

is "--from b" well-defined?  I'll have to play with the existing
code to see what it does.
