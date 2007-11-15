From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix Solaris compiler warnings
Date: Thu, 15 Nov 2007 15:16:25 -0800
Message-ID: <7v1war3xrq.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711152317140.7416@bianca.dialin.t-online.de>
	<20071115230002.GA24069@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 00:16:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsnxA-0004d2-6g
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 00:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764415AbXKOXQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 18:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762006AbXKOXQh
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 18:16:37 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:33534 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755142AbXKOXQh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 18:16:37 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 7E81F2F2;
	Thu, 15 Nov 2007 18:16:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 085AC962C8;
	Thu, 15 Nov 2007 18:16:53 -0500 (EST)
In-Reply-To: <20071115230002.GA24069@steel.home> (Alex Riesen's message of
	"Fri, 16 Nov 2007 00:00:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65180>

Alex Riesen <raa.lkml@gmail.com> writes:

> Guido Ostkamp, Thu, Nov 15, 2007 23:19:11 +0100:
>> Hello,
>>
>> the below patch fixes some compiler warnings returned by Solaris Workshop 
>> Compilers.
>>
>>     CC builtin-apply.o
>> "builtin-apply.c", line 686: warning: statement not reached
>>     CC utf8.o
>> "utf8.c", line 287: warning: statement not reached
>>     CC xdiff/xdiffi.o
>> "xdiff/xdiffi.c", line 261: warning: statement not reached
>
> All these are wrong. That's a fantastically broken piece of compiler

Eh?

I've looked at builtin-apply and utf8 cases but these returns
are after an endless loop whose exit paths always return
directly, so these return statements are in fact never reached.

Dumber compilers may not notice and if you remove these returns
they may start complaining, though. 
