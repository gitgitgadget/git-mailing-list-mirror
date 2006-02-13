From: Ryan Anderson <ryan@michonline.com>
Subject: Re: git-bisect problem
Date: Mon, 13 Feb 2006 05:14:43 -0500
Message-ID: <20060213101443.GD11053@mythryan2.michonline.com>
References: <20060213002502.5c23122c.akpm@osdl.org> <7virrj1v44.fsf@assigned-by-dhcp.cox.net> <20060213013205.4ba47836.akpm@osdl.org> <20060213093938.GC11053@mythryan2.michonline.com> <20060213015146.26e6c09d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 11:15:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8ak5-0006lP-HW
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 11:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbWBMKPf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 05:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbWBMKPf
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 05:15:35 -0500
Received: from mail.autoweb.net ([198.172.237.26]:53197 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751708AbWBMKPe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 05:15:34 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1F8ajx-0003Qs-RX; Mon, 13 Feb 2006 05:15:31 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1F8ajr-00043x-Rc; Mon, 13 Feb 2006 05:15:29 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1F8ajX-0004zh-7m; Mon, 13 Feb 2006 05:15:03 -0500
To: Andrew Morton <akpm@osdl.org>
Content-Disposition: inline
In-Reply-To: <20060213015146.26e6c09d.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-Spam-Score: -4.4
X-Spam-Report: Spam detection software, running on the system "h4x0r5.com", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Mon, Feb 13, 2006 at 01:51:46AM -0800, Andrew Morton
	wrote: > > Assuming I find the bad commit, how do I extract it as a
	patch? > > I tried > > git-format-patch -o ~/a
	386093ef9a6c88576d8b418bf1c8616d5e410a20 git-netdev-all > > and that
	chewed 10 minutes CPU time and produced no output, so I killed it. [...] 
	Content analysis details:   (-4.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.8 ALL_TRUSTED            Passed through trusted hosts only via SMTP
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16063>

On Mon, Feb 13, 2006 at 01:51:46AM -0800, Andrew Morton wrote:
> 
> Assuming I find the bad commit, how do I extract it as a patch?
> 
> I tried
> 
> git-format-patch -o ~/a 386093ef9a6c88576d8b418bf1c8616d5e410a20 git-netdev-all
> 
> and that chewed 10 minutes CPU time and produced no output, so I killed it.

Well, assuming it's not a merge, you'll want something like this:

git format-patch -o ~/a 386093ef9a6c88576d8b418bf1c8616d5e410a20^1..386093ef9a6c88576d8b418bf1c8616d5e410a20

For essentially the same output, you can do a few other variations:

git whatchanged -p 386093ef9a6c88576d8b418bf1c8616d5e410a20^1..386093ef9a6c88576d8b418bf1c8616d5e410a20
git diff 386093ef9a6c88576d8b418bf1c8616d5e410a20^1..386093ef9a6c88576d8b418bf1c8616d5e410a20

If it's a merge that bisect terminates on, things get a bit trickier, as
you want to figure out what went wrong in the merge to cause it, so
you'll want to use either the syntax for specifying which merge parent
to look at (which I forget at the moment) or, run:
	git rev-list --parents --max-count=1 386093ef9a6c88576d8b418bf1c8616d5e410a20
and look at columns 2+ individually.

In fact, if you want, you can re-do the merge, by creating some branches
based off of each parent, then pulling one into the other, and seeing
what went wrong.

Hope that helps (if not, I apologize - I should've gone to bed a while
ago and it may have snuck through)

-- 

Ryan Anderson
  sometimes Pug Majere
