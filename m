From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-count-objects --all support
Date: Sat, 21 Jan 2006 19:03:35 -0800
Message-ID: <7v7j8thsl4.fsf@assigned-by-dhcp.cox.net>
References: <20060122022718.16375.78611.stgit@machine.or.cz>
	<7vslrhht8b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 04:03:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0VW0-0007Gd-Rc
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 04:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWAVDDi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 22:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWAVDDi
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 22:03:38 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:63142 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751260AbWAVDDh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 22:03:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060122030229.XUJT20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 Jan 2006 22:02:29 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <7vslrhht8b.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 21 Jan 2006 18:49:40 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15040>

Junio C Hamano <junkio@cox.net> writes:

> The point of counting objects is to see if it is time to repack,
> so the warning is something I am quite hesitant to accept, even
> with a suppression option.  The other way around is probably OK
> ("please warn me if I have packs"), but feels somewhat pointless.
>
> The --all option might be a welcome addition, though.

I think your patch counts the same object twice if it is packed
in more than one packs and/or it has a loose copy _and_ also in
a pack.  If it is a good thing or not is totally up to the
reason why we are counting.

We might be better off if we did this kind of additions by
building on fsck-objects.  For example, you could give a --stat
option that might say something like this:

	$ git fsck-objects --full --stat
        commit	 2488
        tree    43343
        blob   212234
        total  258065
	packed 184382
	loose   78115
        dups     4432

where "dups" is number of duplicated copies --- an object packed
in more than two packs, or appearing in a pack and also having a
loose copy.  I dunno.
