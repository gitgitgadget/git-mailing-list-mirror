From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-fetch per-repository speed issues
Date: Mon, 03 Jul 2006 20:30:29 -0700
Message-ID: <7vsllinj1m.fsf@assigned-by-dhcp.cox.net>
References: <1151949764.4723.51.camel@neko.keithp.com>
	<Pine.LNX.4.64.0607031603290.12404@g5.osdl.org>
	<1151973438.4723.70.camel@neko.keithp.com>
	<Pine.LNX.4.64.0607032008590.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 05:30:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxbcR-0006CD-DD
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 05:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWGDDab (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 23:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWGDDab
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 23:30:31 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:64971 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751309AbWGDDaa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 23:30:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060704033030.OXAU554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Jul 2006 23:30:30 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607032008590.12404@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 3 Jul 2006 20:21:30 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23243>

Linus Torvalds <torvalds@osdl.org> writes:

> Ok, a "git fetch" really shouldn't take any longer than a single 
> connection. However, the fact that you have 32 heads, and it takes pretty 
> close to _exactly_ 32 times 0.410 seconds (32*0.410s = 13.1s) makes me 
> suspect that "git fetch" is just broken and fetches one branch at a time. 
>
> Which would be just stupid.
>
> But look as I might, I see only that one "git-fetch-pack" in git-fetch.sh 
> that should trigger. Once. Not 32 times. But your timings sure sound like 
> it's doing a _lot_ more than it should.
>
> Junio, any ideas?

Isn't that because the repository have 32 subprojects, totally
unrelated content-wise?  If you have real stuff to pull from
there your pack generation needs to do 32 time as much work as
you would for a single head in that case.

If you are discussing "peek-remote runs, find out the 32 heads
are all up to date and no pack is generated" case, then you are
right.  There is one single fetch-pack to grab the specified
heads, and after that, an optional single ls-remote and
fetch-pack runs only once to follow all new tags.
