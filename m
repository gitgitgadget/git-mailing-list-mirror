From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Changing submodule foreach --recursive to be
 depth-first, --parent option to execute command in supermodule as well
Date: Tue, 05 Mar 2013 08:09:26 -0800
Message-ID: <7vhakpvnex.fsf@alter.siamese.dyndns.org>
References: <CA+aSAWuoxZkSnRybhefnFr9ngs3tHmt6hAH4o0ebjYKvjJ-vpw@mail.gmail.com>
 <51351CF5.7010308@web.de> <7vhakqwz1e.fsf@alter.siamese.dyndns.org>
 <20130305075901.GB4677@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Cousineau <eacousineau@gmail.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 05 17:09:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCuR9-0006EW-CS
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 17:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971Ab3CEQJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 11:09:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46893 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616Ab3CEQJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 11:09:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6814A74A;
	Tue,  5 Mar 2013 11:09:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LWCWJ21aGJ7l+AxQ4iHxgYmRrLQ=; b=OgJoP6
	98o1dMSmkzVf+7pa1FrDcrfWwXY/ru8PdXPSZmxC4GCIFtcHOElQKOhyXLFkIw09
	ifn2DeT1phVZhP4PYEKlMswET5NYtfGKe8YrcmT/ir1lIOsRBxoEz69JiKx1Xj11
	CnFBGFOFUPTSobPUufc5MZyDHyD8x4IgzCWeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xPiut5mV8qBjTAwzpCpMEX7rO9OmG6R2
	24uSnvQCn1l6i2QPQo4rYN1Z6sjFw6lHk03eEHTxvty2ynem5EyC1k3CVGlI+F7q
	fcWh7T0THXz1keJ3Dra8AfZV4RebpLMPYPU5HQk6kSEbPK5X1zriJ4o5hCz/732h
	GkrFkUAzgNU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB759A748;
	Tue,  5 Mar 2013 11:09:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 157BDA73F; Tue,  5 Mar 2013
 11:09:27 -0500 (EST)
In-Reply-To: <20130305075901.GB4677@sandbox-ub> (Heiko Voigt's message of
 "Tue, 5 Mar 2013 08:59:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E581E94-85AF-11E2-8F87-2F862E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217458>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Mon, Mar 04, 2013 at 03:00:45PM -0800, Junio C Hamano wrote:
>> So if you want a single boolean to toggle between the current
>> behaviour and the other one, it would be --post-order.  But you may
>> at least want to consider pros and cons of allowing users to give
>> two separate commands, one for the pre-order visitation (which is
>> the current "command") and the other for the post-order
>> visitation. Being able to run both might turn out to be useful.
>
> I second that. Having a --post-order=<command/script> switch will give
> us much more flexibility. For ease of use we could allow --post-order
> without command to switch the meaning of the main command.
>
> So a final solution would have these switches:
>
> git submodule foreach ... [--pre-order[=<command>]] [--post-order[=<command>]] [<command>]
>
> If only --pre-order without argument is given the command will be
> executed pre-order. If only --post-order the command will be executed
> post-order. If both are given its an error and so on...
>
> There are some combinations we would need to catch as errors but this
> design should allow a step by step implementation:
>
> 	1. just the --post-order switch
> 	2. --post-order with argument switch
> 	3. --pre-order (including argument) for symmetry of usage

Yeah, I think I can agree with that direction, and Eric's patch
could be that first step of the three-step progression, without
painting us into a corner we cannot get out of when we want to
advance to 2 and 3 later.

I was more interested in the design aspect and I didn't look at the
actual patch text, though.
