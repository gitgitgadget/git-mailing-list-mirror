From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Stop git-rev-list at sha1 match
Date: Thu, 12 May 2005 00:17:19 +0200
Message-ID: <20050511221719.GH22686@pasky.ji.cz>
References: <1115839456.22180.79.camel@tglx> <7vy8alr0mz.fsf@assigned-by-dhcp.cox.net> <1115843429.22180.90.camel@tglx> <7vis1pqvi4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 00:11:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVzPa-0006VT-SC
	for gcvg-git@gmane.org; Thu, 12 May 2005 00:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVEKWSG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 18:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbVEKWSF
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 18:18:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:64706 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261730AbVEKWRY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2005 18:17:24 -0400
Received: (qmail 8995 invoked by uid 2001); 11 May 2005 22:17:19 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vis1pqvi4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, May 11, 2005 at 11:54:11PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "TG" == Thomas Gleixner <tglx@linutronix.de> writes:
> 
> TG> You moved the stop behind the printf which is inconsistent to the other
> TG> stop conditions, but thats a pure cosmetic question as long as it stays
> TG> that way for ever. 
> 
> While I work on the core GIT changes, I often find myself doing
> 
>     $ jit-log -l --since linus
>     $ jit-log -l --since git-jc
> 
> to see what changes I have in my local work repository, and
> seeing the branching point (or origin) at the very end of the
> log made me feel assured that I am not losing anything in the
> log.  But come to think of it, that is really an unnecessary
> thing and stopping _before_ the named commit would make more
> sense.
> 
> Here is a fixed version.  I am CC'ing pasky hoping he would pick
> it up.

Yes, looks better and more consistent with the rest of the stuff.

But the very fact that you want this makes me *quite* nervous - I think
this is bad thing to do. The problem is, for something like

     o
     | \
     o  |
     |  o
     |  o
     o /
     o
    ------

it will show the merged revisions properly, but for

     o
     | \
     o  |
    ------
     |  o
     |  o
     o /
     o

it won't show the full merge. Whilst when you do

	*-log --since foo

I think you mean it to show everything going into the tree since foo -
that would include the whole branch you cut off now.

Thomas, what are you going to use it for?

> Add --stop-at to git-rev-list command.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

I liked the previous patch revision commit message much better, I have
to admit. ;-)

> ---
> --- a/checkout-cache.c
> +++ b/checkout-cache.c

I assume this is irrelevant here?

> --- a/rev-list.c
> +++ b/rev-list.c

Looks ok.

Could you please also update the documentation appropriately? (If we
have it, let's keep it up to date.)

> Created: t/t0000.sh (mode:100755)
> --- /dev/null
> +++ b/t/t0000.sh

You want this in too?

Starting to build a testsuite sounds like a good idea, but we should
probably first devise some calling convention etc. I personally suck at
automated testing.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
