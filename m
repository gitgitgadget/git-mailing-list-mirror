From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email.perl - Fix 550 EHLO argument does not
 match calling host
Date: Sun, 14 Mar 2010 05:09:34 -0700
Message-ID: <7veijnp0jl.fsf@alter.siamese.dyndns.org>
References: <4B97C157.4020806@gmail.com>
 <20100311081213.GA13575@sigill.intra.peff.net>
 <20100311083148.GA13786@sigill.intra.peff.net>
 <7vaaueziv8.fsf@alter.siamese.dyndns.org> <4B9A74CA.4080507@gmail.com>
 <7vy6hxnnfx.fsf@alter.siamese.dyndns.org> <87bpesi0om.fsf_-_@jondo.cante.net>
 <7vfx433l9x.fsf@alter.siamese.dyndns.org> <87eijng4hy.fsf@jondo.cante.net>
 <7vtysjs9hi.fsf@alter.siamese.dyndns.org> <87d3z7dx2y.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sun Mar 14 13:10:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nqmdz-0005RZ-8S
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 13:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756005Ab0CNMJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 08:09:45 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab0CNMJn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 08:09:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D0FBEA2A84;
	Sun, 14 Mar 2010 08:09:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DcO6gKMy/Ey1NCX+u7KodF9FpLU=; b=HeSA+c
	m5ZBodwTxM/RONaKVpTsb7CP7AJxf14h9zXXQe80l3R/3AbVhY/dpMIJ6IOtoemU
	pcle9JXa1lSoQbjbAGlBA9oCE0Q3J+XEYZalGGGIpb1hvOOmc4/2zWvrcnaoGF7y
	dTu5t/q0E2ZJExUbcapxaWAZAXj4hyGjRVScI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=upE3yRKLPQrJVloWZyyQjoDc7RKSTPFG
	pUWdZXJqja50TAB2RL8l5cA6GsVle0feU203g2uL8qo3B2QtbJns27xge5N/YDBU
	Yg8VmwmjmoQ0aIcTSnM/RdaHU2ctnZjnV+NuusdUU2gw/SLL6xNagrbXFIKGFGkg
	0OTRmkusqb4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AF028A2A81;
	Sun, 14 Mar 2010 08:09:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11425A2A80; Sun, 14 Mar
 2010 08:09:35 -0400 (EDT)
In-Reply-To: <87d3z7dx2y.fsf@jondo.cante.net> (Jari Aalto's message of "Sun\,
 14 Mar 2010 12\:19\:49 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 76906F58-2F62-11DF-A153-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142134>

Jari Aalto <jari.aalto@cante.net> writes:

> The code is based on Perl library Test::Reporter

Thanks for the pointer.  Mention that somewhere in the code or commit,
perhaps?

> Why FQDN is passed to MTA?

That wasn't what I was asking---you know I was aware of the need when you
read the message from me you are responding to.

>> Side note.  Apparently this seems to be a common issue. ...

> It might be good to convert all global variables to de facto UPPERCASE.
> What do you think? (a separate patch?).

Look at the surrounding code in git-send-email.perl; no all-caps variable
except for the language defined globals like %ENV is used there.  In Perl
all-caps tend to give things magic meaning (think BEGIN, $ENV{}, @ARGV,...)
and I don't think it is a good idea to name your own stuff in all-caps
unless there is a good reason for it.  The variable being in global scope
is not a good enough reason.

> It's needed in the error message (see variable's scope):

A global is visible there, isn't it (see the other review message)?

>>> @@ -962,9 +1014,10 @@ X-Mailer: git-send-email $gitversion
>>>  		}
>>>  
>>>  		if (!$smtp) {
>>> -			die "Unable to initialize SMTP properly. Check config. ",
>>> +			die "Unable to initialize SMTP properly. Check config and use --smtp-debug. ",
>>
>> This part is a good addition, but it needs to be in the earlier patch, no?
>
> The --smtp-debug was introduced in the current patch along with maildomain().

I don't think so, at least in the submitted form.  Perhaps you originally
wrote a single combined commit, and later split it into a few commits.

The patch under discussion adds --smtp-domain, and would apply on top of a
separate patch that adds --smtp-debug.  I already said that it is a good
thing to suggest using the option in die() message, but that should be
done _not_ in this patch, but in the previous one that added --smtp-debug.
