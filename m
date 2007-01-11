From: Martin Langhoff <martin@catalyst.net.nz>
Subject: Re: [PATCH] cvsimport: skip commits that are too recent
Date: Fri, 12 Jan 2007 09:18:09 +1300
Message-ID: <45A69B81.40306@catalyst.net.nz>
References: <11682386193246-git-send-email-martin@catalyst.net.nz> <200701110922.07997.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Jan 11 21:18:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H56NS-00056p-Bv
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 21:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbXAKUST (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 15:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbXAKUST
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 15:18:19 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:56780 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbXAKUSS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 15:18:18 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.69])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1H56NJ-0004qt-I7; Fri, 12 Jan 2007 09:18:13 +1300
User-Agent: Thunderbird 1.5.0.9 (X11/20070103)
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
In-Reply-To: <200701110922.07997.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36606>

Robin Rosenberg wrote:
> The idea is nice,  but the downside of this patch is that I (and presumably 
> others) have to rewrite the scripts to invoke cvsps explicitly now. 

This patch did _not_ change how we invoke cvsps at all. It did change
that we now ignore the very recent commits (and pick them up in the next
run), unless you pass -a.

> The fix
> should really be in cvsps, not git-cvsimport (which is the reason I haven't 
> fixed this). Running a full cvsps takes two hours and consumes more than a 
> gigabyte of memory for me, which makes it impossible to run on all but one 
> machine, wheras the incremental import runs in less than five minutes on any 
> machine.

Many things would need fixing in cvsps. This aspect [that commits we do
not know if recent activty belongs to a finished commit or a commit that
is still happening], is not cvsps' fault. It is due to the lack of
atomicity in CVS, combined with its rather bad network protocol.

> Add to that the risk that the buggy nature of cvsps probably increases the 
> risk of errors, so please make the old behaviour the default (import all, 
> retain cvsps cache) and make the changed behaviour the result of an explicit 
> switch.

What seems to concern you is the "retain cvsps cache" -- which we do.

I did comment later in the thread that we should consider rebuilding the
cvsps cache. The reason for that is that I am seeing LESS breakage than
maintaining the cache. Significantly less.

As you say, however, it is a major change, so I'm still evaluating options.

cheers



martin
