From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Another merge test case from the kernel tree.
Date: Wed, 14 Sep 2005 12:11:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509141147230.23242@iabervon.org>
References: <20050907164734.GA20198@c165.ib.student.liu.se>
 <20050907165012.GA20392@c165.ib.student.liu.se> <7vzmqk2u1w.fsf_-_@assigned-by-dhcp.cox.net>
 <7vpsrcqjj6.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 18:09:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFZms-0004wg-CJ
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 18:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbVINQGy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 12:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbVINQGy
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 12:06:54 -0400
Received: from iabervon.org ([66.92.72.58]:27410 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1030218AbVINQGx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 12:06:53 -0400
Received: (qmail 6500 invoked by uid 1000); 14 Sep 2005 12:11:00 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Sep 2005 12:11:00 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsrcqjj6.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8534>

On Tue, 13 Sep 2005, Junio C Hamano wrote:

> One more merge test case you would be interested.  What's most
> interesting about this commit is that it has three merge bases,
> not two.
> 
> commit c820884e4f35a40f88b787c3891a23d629ef6bfd
> Merge: aa2dca4563b0629ecd9d9994dfdf39f29ff1b43f 357d596bd552ad157a906289ab13ea6ba7e66e3d
> Author: Tony Luck <tony.luck@intel.com>
> Date:   Sun Sep 11 18:35:10 2005 -0700
> 
>     Auto-update from upstream
> 
> Attempt to reproduce this commit is somewhat troubling.  The
> 'stupid' strategy and git-resolve resolves cleanly and Tony's
> commit matches what 'git-resolve' does (obviously that is the
> algorithm everybody uses).
> 
> But the 'resolve' strategy says this is case #16 (and resolves
> this case differently but I think it is just by luck). This
> indicates that Tony _might_ have committed what he did not
> wanted to.  The path involved is arch/mips/kernel/offset.c.

It shouldn't resolve it at all if it's case #16; I'll have to check on 
that.

>     [Tony, I think you've seen this one once in different
>     commit.  The terminology "case #16" means your merge has
>     more than one merge base candidates:
> 
>         Ancestor#1 -- -- Your tree
>                      X
>         Ancestor#2 -- -- Other tree
> 
>     and when a path in your tree matches Ancestor #i and the
>     same path in the other tree matches Ancestor #j (i!=j).
> 
>     The default git merge algorithm picks a single ancestor that
>     gives the least number of conflicting paths during the
>     merge, and compares your tree and other tree against it and
>     pick the one that changed since that ancestor if only one
>     side changed that path.  But in case #16, depending on which
>     ancestor we pick, the result may come from your tree or
>     other tree, and obviously we do a wrong thing with 50%
>     probability.
> 
>     Thie _could_ indicate that you _might_ be losing a reverted
>     you made in your line of development being overwritten by
>     what the other tree did.]

More precisely, case #16 only comes up when, in coming from the ancestors, 
one side decided to match one ancestor, and the other side decided to 
match the other; it is rarely the case that this could occur due to the 
two merges making opposite decisions to entirely ignore the other 
ancestor, and the only remaining case is that the merges each chose the 
same ancestor, and one side reverted to the other. So it's pretty certain 
that you've got a 50-50 chance of losing the correction.

	-Daniel
*This .sig left intentionally blank*
