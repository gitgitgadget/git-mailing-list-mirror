From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v3] quickfetch(): Prevent overflow of the rev-list command
 line
Date: Thu, 09 Jul 2009 17:32:49 +0200
Message-ID: <200907091732.49708.johan@herland.net>
References: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se>
 <200907091642.05746.johan@herland.net> <4A560509.8060909@viscovery.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>, Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jul 09 17:33:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOvcK-0003JG-RU
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 17:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760537AbZGIPcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 11:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760061AbZGIPcw
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 11:32:52 -0400
Received: from mx.getmail.no ([84.208.15.66]:51954 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752975AbZGIPcw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 11:32:52 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KMI006DSTUQ3GB0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 09 Jul 2009 17:32:50 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KMI00KRVTUP3Z00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 09 Jul 2009 17:32:50 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.7.9.151820
User-Agent: KMail/1.11.4 (Linux/2.6.30-ARCH; KDE/4.2.4; x86_64; ; )
In-reply-to: <4A560509.8060909@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122982>

On Thursday 09 July 2009, Johannes Sixt wrote:
> Johan Herland schrieb:
> > On Thursday 09 July 2009, Johannes Sixt wrote:
> >> But actually I meant you to make a test that triggers the SIGPIPE that
> >> would kill git-fetch if it were not ignored. This one doesn't trigger
> >> it, either.
> >
> > AFAIU from earlier in this thread (and a mail from Peter linking to
> > http://markmail.org/message/dbgdj4csafen65ye), SIGPIPE _never_ triggers
> > on Windows, thus ignoring SIGPIPE is not needed for the fix per se.
> > However, as a side-effect of the fix, we may now get SIGPIPE on Linux
> > (and other POSIX platforms), so although it never triggers on Windows,
> > it's still needed.
>
> I know that, of course. But try this: Remove the signal(SIGPIPE, SIG_IGN)
> and run the test suite. There is not a single failure.

That's not what I'm seeing. When I don't ignore the signal, the testsuite 
fails intermittently for me (on Linux). I see the following tests fail:

- t3409-rebase-preserve-merges.sh (subtest #2)
- t5503-tagfollow.sh (subtests #4, #6, #7)
- t5505-remote.sh (subtests #10, #12, #14 - #20, #27)
- t5510-fetch.sh (subtest #6 or #25)
- probably more (I seldom get this far...)

I assume the intermittent failures are caused by git rev-list sometimes 
terminate before git fetch is finished writing objects to its standard input 
(because of scheduling differences).

When i enable the signal handling, all selftests pass every time.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
