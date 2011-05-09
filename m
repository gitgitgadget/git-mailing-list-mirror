From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] only warn about ambiguous refs if stderr is a tty
Date: Mon, 09 May 2011 09:33:07 -0700
Message-ID: <7vmxivq1fg.fsf@alter.siamese.dyndns.org>
References: <BANLkTinLCirA4XP9AOb9piGo9ucMsmrmkQ@mail.gmail.com>
 <1304927478-3112-1-git-send-email-kusmabite@gmail.com>
 <20110509080315.GA6205@sigill.intra.peff.net>
 <BANLkTimR_S-px-MfRy0pKGrjxOgSC_=e=A@mail.gmail.com>
 <20110509103208.GA9060@sigill.intra.peff.net>
 <BANLkTimn7542tji-Uu5iH72HS9fcnaywvg@mail.gmail.com>
 <20110509124931.GA18197@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	steveire@gmail.com, felipe.contreras@gmail.com, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 09 18:33:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJTOk-0006sK-AY
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 18:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab1EIQdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 12:33:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35215 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050Ab1EIQdX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 12:33:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 525FB438F;
	Mon,  9 May 2011 12:35:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u1PojADytBxQ9HwlYpF3CjJEZnk=; b=q/aPI3
	KYxzd3LwrFVGtPIDi0gwvoPMjQfKQhUZpB74Fovrk5HYgfLtWPRq36Vt28ODCs9H
	IeOmRMsWCNPkNzjaBADNaLDzbQWJbyqxXjJxBzyyt2zrCi7Et3yKcvx0jeAF7Nwf
	xIU9/WzHhyiKBdTstfLFHtD8kZ+E0RKGNc7dg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nb/uwGACBhx8wSrDfBfh0hQOkYlIw++b
	H3U9YDwnf+Qcy0xgOMP67FG+MO280V5TdpHbNWyKuqfJS1azt7WZriOLgIZQKXJm
	t12zcLqt4G+3P8KCfIm6lwJxAY97hGwbJWn2q/z/unkS32lvl9z+7wM+6D3lTJOq
	0/b3l1znSHo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ED54E438E;
	Mon,  9 May 2011 12:35:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 29666438A; Mon,  9 May 2011
 12:35:13 -0400 (EDT)
In-Reply-To: <20110509124931.GA18197@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 9 May 2011 08:49:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5554D8EE-7A5A-11E0-9CFA-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173244>

Jeff King <peff@peff.net> writes:

> Thinking on it more, I think warning is probably the only sane thing to
> do there. Having a branch with that name is just going to be confusing
> in the long run, and the sooner we start making the user aware of the
> situation, the better.
> ...
>> I think having the ambiguity warning in itself isn't the problem, it's
>> gitk not swallowing it that is.
>
> Agreed.

I agree with both of the above.  It seems that the only thing we would
need is to do (3) and nothing else in Erik's original list?

>> So, to recap: The way I see it, these are our options:
>> 
>>  1) Discard this specific warning when stderr isn't a TTY (i.e
>>     what this patch does)
>>  2) Discard all warnings when stderr isn't a TTY
>>  3) Make gitk understand and forward warnings to the user
>>  4) Have gitk explicitly ignore ambiuous refs
>>  5) Come up with a way to disambiguate HEAD, and use that instead
>>     by default
>>  6) Force HEAD to never be ambiguous
>>  7) Leave things as they are
