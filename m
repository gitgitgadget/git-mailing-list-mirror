From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix Solaris compiler warnings
Date: Fri, 16 Nov 2007 01:14:19 -0800
Message-ID: <7vve82zh5g.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711152317140.7416@bianca.dialin.t-online.de>
	<20071115230002.GA24069@steel.home>
	<7v1war3xrq.fsf@gitster.siamese.dyndns.org>
	<20071116074850.GA3400@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 10:14:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsxHk-0005Lo-GK
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 10:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbXKPJOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 04:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752780AbXKPJOc
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 04:14:32 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:38306 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbXKPJOa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 04:14:30 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C3A4C2EF;
	Fri, 16 Nov 2007 04:14:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 47D9095449;
	Fri, 16 Nov 2007 04:14:47 -0500 (EST)
In-Reply-To: <20071116074850.GA3400@steel.home> (Alex Riesen's message of
	"Fri, 16 Nov 2007 08:48:50 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65206>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Fri, Nov 16, 2007 00:16:25 +0100:
>> Alex Riesen <raa.lkml@gmail.com> writes:
>> 
>> > Guido Ostkamp, Thu, Nov 15, 2007 23:19:11 +0100:
>> ...
>> >>     CC builtin-apply.o
>> >> "builtin-apply.c", line 686: warning: statement not reached
>> >>     CC utf8.o
>> >> "utf8.c", line 287: warning: statement not reached
>> >>     CC xdiff/xdiffi.o
>> >> "xdiff/xdiffi.c", line 261: warning: statement not reached
>> >
>> > All these are wrong. That's a fantastically broken piece of compiler
>> 
>> I've looked at builtin-apply and utf8 cases but these returns
>> are after an endless loop whose exit paths always return
>> directly, so these return statements are in fact never reached.
>> ...
>
> Hmm... Guido, I owe you an appology. Still, consider this patch
> instead (it does not fix the return in xdiff/xdiffi.c though):

If you are referring to the "xdiff/xdiffi.c:line 261" one (which
I did not say if I looked at it or not), I think there is
nothing to fix there, either.  In front of itt is a big fat loop
controlled with:

	for (ec = 1;; ec++) {
		...
	}

and only exits from there are returns.  Two "break" appear but
they are breaking out of nested inner loops and would not escape
this outermost loop.
