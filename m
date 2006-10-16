From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many changes
Date: Mon, 16 Oct 2006 15:53:17 -0700
Message-ID: <7vy7rfub36.fsf@assigned-by-dhcp.cox.net>
References: <87slhopcws.fsf@rho.meyering.net>
	<Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610160904400.3962@g5.osdl.org>
	<87mz7wp6ek.fsf@rho.meyering.net>
	<Pine.LNX.4.64.0610160941270.7697@alien.or.mcafeemobile.com>
	<87ejt8p5l9.fsf@rho.meyering.net>
	<Pine.LNX.4.64.0610161038200.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610161109430.7697@alien.or.mcafeemobile.com>
	<Pine.LNX.4.64.0610161130090.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Davide Libenzi <davidel@xmailserver.org>,
	Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Tue Oct 17 00:53:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZbKk-0003yn-TK
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 00:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161147AbWJPWxU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 18:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161150AbWJPWxU
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 18:53:20 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:18873 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1161147AbWJPWxT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 18:53:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061016225318.GAU18180.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Mon, 16 Oct 2006 18:53:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bAtM1V00D1kojtg0000000
	Mon, 16 Oct 2006 18:53:22 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610161130090.3962@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 16 Oct 2006 11:51:17 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28992>

Linus Torvalds <torvalds@osdl.org> writes:

> Junio, I think this is worthy to go in before a 1.4.3 release. Possibly 
> even back-ported to earlier trees.

Thanks for resolving this quickly; I was (am still somewhat)
down sick today and missed all the excitement.

> Quite frankly, I prefer my previous patch more, it just avoids that whole 
> problem, and two shifts and adds (even with a conditional) are often 
> faster than a full 64-bit multiply.

I agree (although I am not sure about the "do it twice for
small" bit), and I think Davide agrees with you in his reply:

Davide Libenzi <davidel@xmailserver.org> writes:
> On Mon, 16 Oct 2006, Linus Torvalds wrote:
> ...
> I ended up using this one:
>
> #define XDL_HASHLONG(v, b) ((((unsigned long) (v) >> ((CHAR_BIT * sizeof(unsigned long)) - (b))) + \
>                              (unsigned long) (v)) & ((1UL << (b)) - 1))

so I am inclined to apply Davide's version, but I am going to
bed again now...
