From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Fix git-fsck-cache segfault on invalid tag
Date: Fri, 20 May 2005 10:50:47 +0200
Message-ID: <20050520085047.GA27787@pasky.ji.cz>
References: <428D8B19.4070605@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri May 20 10:51:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZ3Co-00080e-C2
	for gcvg-git@gmane.org; Fri, 20 May 2005 10:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVETIu4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 04:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVETIu4
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 04:50:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48556 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261381AbVETIus (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 04:50:48 -0400
Received: (qmail 29740 invoked by uid 2001); 20 May 2005 08:50:47 -0000
To: Frank Sorenson <frank@tuxrocks.com>
Content-Disposition: inline
In-Reply-To: <428D8B19.4070605@tuxrocks.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, May 20, 2005 at 09:00:41AM CEST, I got a letter
where Frank Sorenson <frank@tuxrocks.com> told me that...
> git-fsck-cache will segfault if a tag contains a non-existent sha1.  This
> patch fixes fsck-cache to report the invalid tag and not die.

Oh. I've fixed this too but didn't even get to commit it yet. :-)

> Index: fsck-cache.c
> ===================================================================
> --- ca5fef50fb68a3afbb35e1a48ac622f7a964f021/fsck-cache.c  (mode:100644)
> +++ ac5d65a040c22194ddcd0706dc5f0b8bb52aef65/fsck-cache.c  (mode:100644)
> @@ -315,6 +315,10 @@
>  		return;
>  
>  	obj = lookup_object(sha1);
> +	if (!obj) {
> +		fprintf(stderr, "invalid tag %s - %s\n", path, hexname);
> +		return;
> +	}
>  	obj->used = 1;
>  	mark_reachable(obj, REACHABLE);
>  }

My error message is

	error("%s: invalid sha1 pointer %.40s", path, hexname);

I'd prefer that (at least use the error() call). The .40 is there since
it has a newline on its own.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
