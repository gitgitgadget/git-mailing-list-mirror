From: Sam Vilain <sam@vilain.net>
Subject: Re: Decompression speed: zip vs lzo
Date: Sat, 12 Jan 2008 16:06:45 +1300
Message-ID: <47882EC5.2080406@vilain.net>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com> <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net> <alpine.LSU.1.00.0801092328580.31053@racer.site> <47856E8D.4010006@vilain.net> <4785A6DB.3080007@vilain.net> <20080110091607.GA17944@artemis.madism.org> <alpine.LFD.1.00.0801101332150.3054@xanadu.home> <alpine.LFD.1.00.0801101252030.3148@woody.linux-foundation.org> <478691EB.1080704@vilain.net> <alpine.LFD.1.00.0801101400550.3148@woody.linux-foundation.org> <47869C24.3000400@vilain.net> <alpine.LFD.1.00.0801101454440.3148@woody.linux-foundation.org> <4786BFCD.1000303@vilain.net> <alpine.LFD.1.00.0801101805540.3148@woody.linux-foundation.org> <47870CDF.4010606@vilain.net> <alpine.LFD.1.00.0801110759160.3148@woody.linux-foundation.org> <47881D44.
 9060105@vilain.net> <alpine.LFD.1.00.0801112125470.3054@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Jan 12 04:06:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDWhQ-0002mA-G2
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 04:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757280AbYALDFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 22:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757407AbYALDFx
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 22:05:53 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:56987 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756984AbYALDFw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 22:05:52 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 7EBB9FD436; Sat, 12 Jan 2008 16:05:50 +1300 (NZDT)
Received: from [192.168.69.104] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 7FB02FCCF6;
	Sat, 12 Jan 2008 16:05:45 +1300 (NZDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <alpine.LFD.1.00.0801112125470.3054@xanadu.home>
X-Enigmail-Version: 0.95.0
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70257>

Nicolas Pitre wrote:
> Sorry to rain on your parade, but to me 6-10% time saving is not a clear 
> win at all, given the equal increase in repository size.  This is simply 
> not worth it.

Agree.

> And a 50% time saving on an operation, such a git log, which takes less 
> than 2 seconds in absolute time, is not worth the repo size increase 
> either.

Disagree.  Going as much as twice as fast for many history operations
for 10% added space sounds like a clear win to me.  We can easily agree
to disagree though - making it a disabled by default config option
allows the user to unroll their packs if they want.

> Going from 2 seconds down to one second doesn't make enough of 
> a user experience difference.

What do you mean?  1 second waiting is far better than 2 seconds
waiting.  And the mmap optimizations have not even begun yet - that
could result in boosts from zero-copy, such as a lighter VM footprint.

> If git blame was to go from 10 seconds down to 4 then I'd say this is a 
> clear win.  But this is not the case.

This is an awesome boost!  Everything feels snappier already :)

maia:~/src/perl.clean$ time git-log | LANG=C wc
 288927  894027 8860916

real    0m0.839s
user    0m0.824s
sys     0m0.144s
maia:~/src/perl.clean$ cd ../perl.clean.loose/
maia:~/src/perl.clean.loose$ time git-log | LANG=C wc
 288927  894027 8860916

real    0m0.515s
user    0m0.504s
sys     0m0.136s

maia:~/src/perl.clean.loose$ du -sk .git/objects/pack/
113484  .git/objects/pack/
maia:~/src/perl.clean.loose$ cd -
/home/samv/src/perl.clean
maia:~/src/perl.clean$ du -sk .git/objects/pack/
107040  .git/objects/pack/
maia:~/src/perl.clean$

Want me to try this on kde.git?

Sam.
