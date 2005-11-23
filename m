From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] Add git-graft-ripple, a tool for permanently grafting history into a tree.
Date: Wed, 23 Nov 2005 08:51:50 -0500
Message-ID: <20051123135150.GA16995@mythryan2.michonline.com>
References: <11326926501602-git-send-email-ryan@michonline.com> <Pine.LNX.4.64.0511221652530.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 14:53:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eev2o-00063x-OI
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 14:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVKWNwD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 08:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbVKWNwD
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 08:52:03 -0500
Received: from mail.autoweb.net ([198.172.237.26]:22253 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1750775AbVKWNv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 08:51:57 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1Eev2N-0007JG-L3; Wed, 23 Nov 2005 08:51:53 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Eev2M-00023A-00; Wed, 23 Nov 2005 08:51:50 -0500
Received: from ryan by mythical with local (Exim 4.54)
	id 1Eev2M-0001Ph-Ke; Wed, 23 Nov 2005 08:51:50 -0500
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511221652530.13959@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12620>

On Tue, Nov 22, 2005 at 04:55:04PM -0800, Linus Torvalds wrote:
> On Tue, 22 Nov 2005, Ryan Anderson wrote:
> >
> > Enhancements over the original example:
> > 
> > 	o Each newly created commit A' references A, and (A^1)' (The first try
> > 	referenced A^1 and (A^1)' but not A)
> > 
> > 	o Support for incrementally rewriting history is present.
> 
> How about the case of having commits that have pointers to other commits 
> in the comments? 
> 
> For example, on the kernel do
> 
> 	gitk 19842d67340e4a8f616552d344e97fc7452aa37a
> 
> and see how gitk highlights the SHA1's in the commit message and makes 
> hyperlinks to the commits they point to..

For some reason, my gut says that this goes too far.  I'm having a hard
time pinning down a way to explain that.

I guess something (untested) like this could do it, right before I call
git_commit_tree():

	my $found;
	do {
		$found = 0;
		if ($csets{$old}{comments} =~ /\s([a-f0-9]{40})\s/ &&
			exists $newcsets{$1}) {

			my $tcommit = $1;

			$found = 1;
			$csets{$old}{comments} =~ s/$tcommit/$newcsets{$tcommit}/g;
		}
	} while ($found);

I'm not entirely convinced this is a good idea, but there it is.

I'll write up a patch later for this (probably switching to GetOpt in
the process.)

-- 

Ryan Anderson
  sometimes Pug Majere
