From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] format-patch --signature-file <file>
Date: Wed, 21 May 2014 10:37:05 -0700
Message-ID: <xmqq61kzqbi6.fsf@gitster.dls.corp.google.com>
References: <1400572806-21092-1-git-send-email-jmmahler@gmail.com>
	<1400572806-21092-2-git-send-email-jmmahler@gmail.com>
	<20140520082740.GB27590@sigill.intra.peff.net>
	<xmqq61l01gmw.fsf@gitster.dls.corp.google.com>
	<20140520182443.GA30533@sigill.intra.peff.net>
	<xmqq7g5gz3s4.fsf@gitster.dls.corp.google.com>
	<20140521164255.GA2040@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 21 19:37:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnAST-0002wY-Qw
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 19:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbaEURhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 13:37:15 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56627 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081AbaEURhL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 13:37:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2A88C172F0;
	Wed, 21 May 2014 13:37:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ABDqVGbEmGBR0qn/LTE4huE2ET0=; b=Hbs38H
	XjAEM6tNosT1x8T6L/CaAowOUiHoMFJ5C2zVvjePtkmi8ltabtvvzK5GAmVrbxtz
	50uQX16goMbdIP7vSJC4fT6BmQruo/9l8iFAFaJsJchDoiDbw72CIavSUzUEtlTG
	BaSjWGww8+yHmRo0w9Q5jqhqo4OJ2RLMuDe7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jCnjCnvoQmPbKNnQ+iK++NdjplHKhand
	1c2LAbduwQjihyM4ARnIMvL+Hd2niCN5QnAh5i+YP5CNHvEJNPDbis1p8hYA5e1T
	I6jxUdX/OOWh6jzaqZAMoLnRdoJZzzZqut3G7/v7R98pWHmQ74RDeJlfaHuSocbv
	baYRrWoUdng=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 20008172EF;
	Wed, 21 May 2014 13:37:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5A6DD172E7;
	Wed, 21 May 2014 13:37:07 -0400 (EDT)
In-Reply-To: <20140521164255.GA2040@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 21 May 2014 12:42:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 87B4E31A-E10E-11E3-99ED-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249814>

Jeff King <peff@peff.net> writes:

> On Tue, May 20, 2014 at 11:46:51AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > If it were just "--signature", I'd agree. After all, nobody is even
>> > complaining. But this is also in preparation for --signature-file.
>> > Should the user create a file without a trailing newline?
>> 
>> Ahh, I missed that part.
>> 
>> I am fine with processing it with stripspace().
>
> I wasn't planning on anything as drastic as stripspace. I really just
> wanted to suppress the one newline, which is almost certainly the right
> thing to include for "--signature", but the wrong thing for
> "--signature-file" (i.e., the patch I posted earlier).
> ...
> I dunno. Maybe it is not worth caring too much about.

I suggested stripspace() because I know we do not care too
much, actually.

Cleansing blank lines in one way for many types of user input
(e.g. commit log messages and tag messages) while doing it in a
completely different way just for "--signature-file" is warranted if
there is a good reason for them to be different, but I did not think
of any, and I still don't.  So...

>> By the way, at some point we may want to move that helper function
>> to strbuf.c, but that is a separate issue.
>
> Agreed. I was touching some string functions earlier today and noticed
> that strbuf.c actually contains a lot of non-strbuf functions for
> dealing with C strings. That's fine, I guess, but I also wondered if we
> should have a separate file for C-string functions. I suppose it doesn't
> matter that much either way, as long as it's in a libgit.a file (and
> stripspace currently is _not_, which I assume is what you were
> indicating above).

Yes, I thought you would have used it in your follow-up patch if it
were more prominent.
