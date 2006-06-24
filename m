From: linux@horizon.com
Subject: Re: x86 asm SHA1 (draft)
Date: 23 Jun 2006 21:22:02 -0400
Message-ID: <20060624012202.4822.qmail@science.horizon.com>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net>
Cc: linux@horizon.com
X-From: git-owner@vger.kernel.org Sat Jun 24 08:47:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu1vq-0000U0-K7
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 08:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932907AbWFXGrr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 02:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932908AbWFXGrr
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 02:47:47 -0400
Received: from science.horizon.com ([192.35.100.1]:33350 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932907AbWFXGrq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 02:47:46 -0400
Received: (qmail 4823 invoked by uid 1000); 23 Jun 2006 21:22:02 -0400
To: git@vger.kernel.org, junkio@cox.net
In-Reply-To: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22486>

> The series to revamp SHA1 is good but judging the merit of each
> is outside my expertise, so I'd appreciate help to evaluate
> these changes.  For example, I cannot choose between competing
> three implementations for ppc without having access to a variety
> of ppc machines, and even if I did, ppc is not what I normally
> use, so incentive to try picking the best one for everybody is
> relatively low on my part.

Well, I'm not sure it's worth this much trouble.  Both of my PPC
implementations are smaller and faster than the current one,
so that's a pretty easy decision.  The difference between them
is 2-3%, which is, I think, not enough to be worth the maintenance
burden of a run-time decision infrastructure.  Just pick either one
and call it a day.

> The only external interface for the set of SHA1 implementation
> alternatives to the outside world is a well established SHA_CTX
> type, and three functions SHA1_Init(), SHA1_Update() and
> SHA1_Final(), and the alternative implementations are supposed
> to be drop-in replaceable.

I'd prefer it it was an *opaque* SHA_CTX type.  Sometimes you can achieve
some useful benefits by rearranging the fields.  For example, keeping the
64-bit length field as a native-order 64-bit number when appropriate.
And sometimes it's useful to have the full 80-word W[] array, while
other implementations don't want it.

> We probably would want to collect the benchmark results from
> popular platforms, have a summary to help people to choose a
> sensible one in the toplevel INSTALL file, and include the raw
> numbers in Documentation/technical/sha1-implementations.txt.

Not that numbers are bad, but I think that until there's a real
need for more than a single good-enough version per instruction set,
this is excessive.  Does hashing even show up on a profile?
