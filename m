From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 00:32:03 +0200
Message-ID: <20080911223203.GA29559@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com> <20080911123148.GA2056@cuci.nl> <alpine.LFD.1.10.0809111047380.23787@xanadu.home> <20080911160040.GE2056@cuci.nl> <alpine.LFD.1.10.0809111222170.23787@xanadu.home> <7vy71ys8a7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 00:33:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kduiy-000426-9K
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 00:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbYIKWcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 18:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbYIKWcH
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 18:32:07 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:46446 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbYIKWcG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 18:32:06 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 953FE5465; Fri, 12 Sep 2008 00:32:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vy71ys8a7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95657>

Junio C Hamano wrote:
>I keep hearing "blame" in this discussion, but I do not understand why
>people think blame should _follow_ this "origin" information (in the usual
>sense of "following").

>Suppose you cherry-pick an existing commit from unrelated context:

>         ...---A---B
>                    . (origin)
>                     .
>        ...---o---X---Y---Z

>i.e. on top of X the difference to bring A to B is applied to produce Y,
>and a new development Z is made on top.  You start digging from Z.

>Let's see how we would want "origin" get involved.  Instead of the above,
>what Y would do would be:

>   (1) if the contents (excluding the part Z changed) is different from X,
>       instead of taking the blame itself, give the _final_ blame to B.

>   (2) the remainder is passed to X as usual.

Sounds reasonable.

>This is different from the normal "following" in that B is not allowed to
>pass the blame to its parents (should it be allowed to pass it to its
>"origin"?), because the _only thing_ cherry-pick did was to transport what
>B did (relative to A) to the unrelated history that led to X.

Well, I'd expect:
a. That B should be able to pass blame onto it's origin.
b. That B should be able to pass blame onto A (and deeper).

Let me show another example:

...-C---D---E---F---G
                 . (origin)
                  .
         ...---A---B
                    . (origin)
                     .
        ...---o---X---Y---Z


Now suppose there is a piece of sourcecode which evolves from C to F,
then when I dig into G using blame I get something like:  CCCFFEGGDDDCC
(Every letter represents a line in the sourcecode)

Digging into Z I'd expect to see the following:  ZZCCCFFEDDYDCCB

All this assumes that there were minimal changes to the patch when
creating B, and also minimal changes to the patch when creating Y.

I.e. large parts of that code where developed during C, D, E and F, so
that is what I expect to see; is that illogical?
-- 
Sincerely,
           Stephen R. van den Berg.
"There are three types of people in the world;
 those who can count, and those who can't."
