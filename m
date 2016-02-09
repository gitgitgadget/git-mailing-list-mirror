From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/7] convert: auto_crlf=false and no attributes set: same as binary
Date: Tue, 09 Feb 2016 10:06:32 -0800
Message-ID: <xmqqh9hh4v2v.fsf@gitster.mtv.corp.google.com>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
	<1454688807-20871-1-git-send-email-tboegi@web.de>
	<xmqqzivb83d1.fsf@gitster.mtv.corp.google.com>
	<56B9F90E.2030304@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 09 19:06:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTCgR-0002GL-RP
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 19:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756269AbcBISGg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2016 13:06:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61271 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756126AbcBISGf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Feb 2016 13:06:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9D41140F16;
	Tue,  9 Feb 2016 13:06:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BZDisMTQXmhl
	sWtAbeJ0URTrGG8=; b=m25KX5DivP5Wc+5aTlL+4mCwWtAI99jfqa1XHoHooUIt
	7FOQaHu9Ij1kJksmzoEQVap/ENmcRLpLS36C4QqZf+E9o1BqpXxojnxpDlR735u3
	2rgjKZdLkwMu/JBl1133Fs0voZx6G3uM/FstaXAsolDUyb9AijAmLTJJ2BOs6Fo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=brcjvD
	eAPek+jNQ0MxsMjwpe3SZA2qAfmNwqFulHJ3x7Xg1+Zo8FbJszjo0px9Ob0VyqDl
	C/yKjKWF+kjl1RCIIXS173LF42/KjdUWcyhfu3V0vcGtmcAeP79WJsWtWKx/8oYI
	jBPxUcKAiQ4xqhlyUGd44eqToeDAQKQ7Bpc5A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9566440F15;
	Tue,  9 Feb 2016 13:06:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1542C40F14;
	Tue,  9 Feb 2016 13:06:34 -0500 (EST)
In-Reply-To: <56B9F90E.2030304@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 9 Feb 2016 15:34:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DA95B828-CF57-11E5-AC9A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285845>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>>  * convert_attrs() has "If BINARY don't do anything and return".
>>    Will the patch change behaviour for the "not-autocrlf,
>>    CRLF_GUESS" case in this codepath?  I think ca->crlf_action used
>>    to be left as CRLF_GUESS here before the patch, and now by the
>>    time the control flow reaches here it is already CRLF_BINARY.
>>    Would it affect the callers, and if so how?
> Not sure if I fully understand the question:
>
> The old CRLF_GUESS could mean (a) core.autocrlf=3Dtrue,
> (b) core.autocrlf=3Dinput or (c) core.autocrlf=3Dfalse.
> The callers had to look at the core.autocrlf them self.
> This patch removes (c), the next (or over next) (a) and (b)

That part I understand and fully agree.

If a function that appears much later in the control flow depends
on seeing CRLF_GUESS to do certain things, and showing CRLF_BINARY
to the code would make it behave differently, that would make this
patch incorrect.

That is, if some function that you did not touch (hence did not
appear in the context of this patch) did this:

	if (CRLF_GUESS)
        	do the "guess thing"
	else if (CRLF_BINARY)
        	do the "binary thing"
	else
        	do other things

then depending on how 'guess thing' and 'binary thing' work
differently, this patch would change the outcome.  If the
"guess thing" had

		if (!AUTOCRLF) goto "binary thing"

upfront, then it obviously is OK, though ;-)

If the _ONLY_ way all the code that use CRLF_GUESS is

	if ((CRLF_GUESS && !AUTOCRLF) || CRLF_BINARY)
        	do the "binary thing"

then the conversion done by the patch is perfectly fine.  It was
unclear from the patch text and the proposed log message if you made
sure that is the case.  And with your response, it still isn't clear
to me.
