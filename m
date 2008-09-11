From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 00:40:27 +0200
Message-ID: <20080911224027.GB29559@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com> <20080911123148.GA2056@cuci.nl> <alpine.LFD.1.10.0809111047380.23787@xanadu.home> <20080911160040.GE2056@cuci.nl> <alpine.LFD.1.10.0809111222170.23787@xanadu.home> <7vy71ys8a7.fsf@gitster.siamese.dyndns.org> <20080911223203.GA29559@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 00:41:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdur2-0005s5-JR
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 00:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184AbYIKWk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 18:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753439AbYIKWk2
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 18:40:28 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:51480 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158AbYIKWk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 18:40:28 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 0FE495465; Fri, 12 Sep 2008 00:40:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080911223203.GA29559@cuci.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95658>

Stephen R. van den Berg wrote:
>Junio C Hamano wrote:
>>This is different from the normal "following" in that B is not allowed to
>>pass the blame to its parents (should it be allowed to pass it to its
>>"origin"?), because the _only thing_ cherry-pick did was to transport what
>>B did (relative to A) to the unrelated history that led to X.

>Well, I'd expect:
>a. That B should be able to pass blame onto it's origin.
>b. That B should be able to pass blame onto A (and deeper).

>Let me show another example:

>....-C---D---E---F---G
>                 . (origin)
>                  .
>         ...---A---B
>                    . (origin)
>                     .
>        ...---o---X---Y---Z

>Now suppose there is a piece of sourcecode which evolves from C to F,
>then when I dig into G using blame I get something like:  CCCFFEGGDDDCC
>(Every letter represents a line in the sourcecode)

>Digging into Z I'd expect to see the following:  ZZCCCFFEDDYDCCB

>All this assumes that there were minimal changes to the patch when
>creating B, and also minimal changes to the patch when creating Y.

>I.e. large parts of that code where developed during C, D, E and F, so
>that is what I expect to see; is that illogical?

I'm sorry, you're right, I'm confusing things here.  The case I'm describing
here can only happen when you do this:

....-C---D---E---F---G
      \...\...\..\ (origin)
                  .
         ...---A---B
                    . (origin)
                     .
        ...---o---X---Y---Z

I.e. the first cherry-pick needs to cherry-pick C, D, E *and* F into B,
that will result in four origin fields there.
And yes, that means that:
- blame follows origin links (repeatedly).
- blame does *not* travel to parents of commits found through an origin
  link.

Does that mean that blame uses origin fields?  Yes, it does, and it has
to check for origin links at every commit it traverses.
-- 
Sincerely,
           Stephen R. van den Berg.
"There are three types of people in the world;
 those who can count, and those who can't."
