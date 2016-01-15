From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 08/21] checkout-index: there are only two possible line terminations
Date: Fri, 15 Jan 2016 15:31:02 -0800
Message-ID: <xmqq8u3qfmix.fsf@gitster.mtv.corp.google.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
	<1452815916-6447-1-git-send-email-gitster@pobox.com>
	<1452815916-6447-9-git-send-email-gitster@pobox.com>
	<20160115200856.GC11301@sigill.intra.peff.net>
	<xmqq1t9ih72f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 16 00:31:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKDpn-0001zv-C0
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jan 2016 00:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbcAOXbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 18:31:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57299 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751621AbcAOXbE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 18:31:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ECC473C61A;
	Fri, 15 Jan 2016 18:31:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OeKqgeFM9gnz96bYOZAlZJB1ya8=; b=s3mJnF
	1+tvIJ+HskcA4SQ1GF8a3yJqN604QeXrvzt2//HI/j2RsCPC0+msrd34oiLWZLJy
	Jfwws8U2AC9ybCCBAUoMdnLWb4Eek41qXTB0/A+6ZvNsGk2DxSQrO3TBU4C5vrM1
	tXcJXyvODC9DVFxweYuT52dNQH5ZQwdEJFEQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I9bQKh1tkcVgZvjwmMeCiQCfYAPKBIyN
	jjS2xdXTYJwRco5J1e0PSGugOVR9KGT4jxYK0qw2GXsDRTxzGdgI8UI8ONXCpU51
	czWe2BBdgoI3zPuRd3+rBtTMSptLOX6bs1YNUnk9EAvY+zLg5PCGwTNTyDXUl3Sr
	RY6y3EuK1s0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E325C3C619;
	Fri, 15 Jan 2016 18:31:03 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 616D43C617;
	Fri, 15 Jan 2016 18:31:03 -0500 (EST)
In-Reply-To: <xmqq1t9ih72f.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 15 Jan 2016 13:22:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0ADF3C4C-BBE0-11E5-A5AD-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284232>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Thu, Jan 14, 2016 at 03:58:23PM -0800, Junio C Hamano wrote:
>>
>>> @@ -144,10 +145,7 @@ static int option_parse_u(const struct option *opt,
>>>  static int option_parse_z(const struct option *opt,
>>>  			  const char *arg, int unset)
>>>  {
>>> -	if (unset)
>>> -		line_termination = '\n';
>>> -	else
>>> -		line_termination = 0;
>>> +	nul_term_line = !unset;
>>>  	return 0;
>>>  }
>>
>> Is it worth doing this on top?
>
> Yes.
>
> To be bluntly honest, the above callback has no right to exist.  I
> should have turned it from OPTION_CALLBACK to OPT_BOOL from the
> start.

Having said that, I'd leave this change out of my tree for now,
until the patches 1-9, which I'll split out from the rest of the
series into a separate topic, moves out of the way.

I have this suspicion that "checkout-index" inherited the peculiar
stance "update-index" took about the command line arguments and
options (e.g. "update-index A --add B" and "update-index --add A B"
do different things for path "A").

As far as I can see, there is no reason why "-u", just like "-z"
that you noticed, has to be processed immediately as it is read
before processing the remainder of the command line.  And I think
the change you suggested to stop using a callback for "-z" is better
done with the same patch as the one that fixes "-u", whose log
message would probably be:

    checkout-index: simplify option parsing

    For some reason, the command line parser for "-u" and "-z"
    options tried to make the effect of the options as they are
    processed by using OPTION_CALLBACK, but there is no reason
    to do so.  Just flip the bit to remember that we have seen
    these options while parsing the command line, and use them
    after we are done parsing, just like all other options.

or something.
