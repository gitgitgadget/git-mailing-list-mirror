From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Cleaning up die() error messages
Date: Mon, 10 Oct 2005 12:04:17 -0700
Message-ID: <7vzmph42j2.fsf@assigned-by-dhcp.cox.net>
References: <20051010105008.GB30202@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 10 21:06:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP2wh-0006B7-8l
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 21:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVJJTEU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 15:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVJJTEU
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 15:04:20 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:14042 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751114AbVJJTET (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 15:04:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051010190411.OVCE4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Oct 2005 15:04:11 -0400
To: Elfyn McBratney <beu@gentoo.org>
In-Reply-To: <20051010105008.GB30202@gentoo.org> (Elfyn McBratney's message of
	"Mon, 10 Oct 2005 11:50:08 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9912>

Elfyn McBratney <beu@gentoo.org> writes:

> (Of course, the C parts (`prog' and `set_prog_name()') would go into a
> header, and not in every single C source file. ;)
>
> So, any thoughts/comments/flames? :)

I do not have objections to either one, except I tend to prefer
programs that tells its full path when erroring out, which helps
me identify "Oops, my path was screwed up and I am not testing
the right one" case.

One thing to keep in mind is how badly this C part might
interact with the libification effort going on underwater.
Since current code Smurf is working on is based on 0.99.6 and
many small pieces need to be reviewed anyway, I am not so much
worried about forward porting the changes.  But some die()s that
are in the parts that will be moved to the common library code
would also want to use this prog global somehow.

But that would not be too much of a problem.  Worst case, we
force the library clients to do set_prog_name(), or initialize
prog to "(unnamed)", or do both.
