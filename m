From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Re: git-http-pull broken in latest git
Date: Thu, 11 Aug 2005 22:20:31 -0700
Message-ID: <7vll37afz4.fsf@assigned-by-dhcp.cox.net>
References: <42F8D472.3080404@de.bosch.com>
	<20050811223349.GI25280@pasky.ji.cz>
	<7v4q9wf4ad.fsf@assigned-by-dhcp.cox.net>
	<20050812024552.GO25280@pasky.ji.cz>
	<Pine.LNX.4.63.0508112256430.12816@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 07:21:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3RyG-0006k7-AW
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 07:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbVHLFUe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 01:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbVHLFUe
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 01:20:34 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:16847 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751016AbVHLFUd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 01:20:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050812052032.MPFK8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 12 Aug 2005 01:20:32 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow <barkalow@iabervon.org> writes:

> Petr Baudis <pasky@suse.cz> writes:
>> Yes, but cg-clone doesn't - it naively depended on the core git tools
>> actually, er.. working. ;-)

Sorry about that.  I used to have a wrapper to deal with packs
around http-pull before Daniel's pack enhancement, and yanking
it before really checking that enhanced http-pull actually
worked was my fault as well.

>> This became a nightmare to me by now - on two machines I tried to pull
>> to over HTTP, that failed miserably, and I got stuck until I applied
>> Daniel's patch there (and cleaned up after previous git-http-pulls).

I'll push one out with two patches from Daniel today in short
order.  Currently running the final "make test" round.

> At some point, I have to revisit getting git-ssh-* to generate exactly the 
> required pack and transfer that, but that's an efficiency issue, not a 
> correctness one, and shouldn't be relevant to the problem you're having.

Wouldn't enhancing ssh-push to generate packs on the fly involve
reinventing send-pack and/or upload-pack?

If send-pack/receive-pack pair for the push side, and/or
fetch&clone-pack/upload-pack pair for the pull side does not
work as well as you would want, then ssh-push/pull pair may
still be a useful tool, at the same time that means send-pack
and upload-pack should be fixed to address the problem you have
with them.  But if that is not the case, then it might be better
to declare that ssh-pull/push pair has outlived its usefulness.

The same thing can be said about local-pull to a lesser degree.
Lesser because people, including Pasky who said so on the list
recently, would like its hard-linking behaviour, and its not
exploding the existing packs, which send-pack and upload-pack
would not give.  So I would rate local-pull higher than
ssh-push/pull on the priority scale if I were doing them.
