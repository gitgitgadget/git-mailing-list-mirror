From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't fflush(stdout) when it's not helpful
Date: Sat, 30 Jun 2007 11:42:09 -0700
Message-ID: <7vbqexcmim.fsf@assigned-by-dhcp.cox.net>
References: <20070626171127.GA28810@thunk.org>
	<alpine.LFD.0.98.0706261024210.8675@woody.linux-foundation.org>
	<20070628190406.GC29279@thunk.org>
	<20070628213451.GB22455@coredump.intra.peff.net>
	<20070628235319.GD29279@thunk.org>
	<20070629010507.GL12721@planck.djpig.de>
	<20070629034838.GF29279@thunk.org>
	<20070629063819.GA23138@coredump.intra.peff.net>
	<7vmyyjgrxk.fsf@assigned-by-dhcp.pobox.com>
	<alpine.LFD.0.98.0706290851480.8675@woody.linux-foundation.org>
	<20070629174046.GC16268@thunk.org>
	<alpine.LFD.0.98.0706291641590.8675@woody.linux-foundation.org>
	<7vlke2dw6w.fsf@assigned-by-dhcp.pobox.com>
	<alpine.LFD.0.98.0706292114350.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Jeff King <peff@peff.net>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jun 30 20:42:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4htd-0001Dk-I9
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 20:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901AbXF3SmM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 14:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754003AbXF3SmM
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 14:42:12 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:48588 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714AbXF3SmK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 14:42:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070630184210.JBPG1594.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Jun 2007 14:42:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Hui91X0021kojtg0000000; Sat, 30 Jun 2007 14:42:09 -0400
In-Reply-To: <alpine.LFD.0.98.0706292114350.8675@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 29 Jun 2007 21:24:41 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51241>

Linus Torvalds <torvalds@linux-foundation.org> writes:

>> I was planning to push this out to 'master' this weekend.
>
> I think that code is fine, but switching the order around could probably 
> make it less likely that stdio loses the errno for us. 
>
> So doing the last part in a different order, and making it say
>
> 	/* Check for ENOSPC and EIO errors.. */
> 	if (fflush(stdout))
> 		die("write failure on standard output: %s", strerror(errno));
> 	if (ferror(stdout))
> 		die("unknown write failure on standard output");
> 	if (fclose(stdout))
> 		die("close failed on standard output: %s", strerror(errno));
> 	return 0;
>
> may recover at least non-transient errors.

That makes sense, to a certain degree, given that we do not
check every printf().  I'll forge your signature as usual ;-)

Thanks.
