From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5 v4] log: parse detached options like git log --grep
 foo
Date: Tue, 03 Aug 2010 10:16:34 -0700
Message-ID: <7vlj8nipl9.fsf@alter.siamese.dyndns.org>
References: <vpq7hkdml22.fsf@bauges.imag.fr>
 <1280478669-22973-4-git-send-email-Matthieu.Moy@imag.fr>
 <7vvd7tlzfu.fsf@alter.siamese.dyndns.org> <vpqtyncdeuc.fsf@bauges.imag.fr>
 <7vsk2wk8lc.fsf@alter.siamese.dyndns.org> <vpq8w4ob3yz.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 03 19:16:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgL6g-0004Ti-E8
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 19:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757225Ab0HCRQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 13:16:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757212Ab0HCRQn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 13:16:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DE62CA4F6;
	Tue,  3 Aug 2010 13:16:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c8I67y+MsH1EkACFCFFG0D7npnQ=; b=cb82ao
	sSl7NvGzzPmNi24eiURda9vKcD5GkTa4bQlQZr+1DZJ6fVt1/e5gZ0nRKDa1qxrT
	bdkWkJr0rmMHAIdy3DDQVCSJ9iCyxlB9vipRqJA9wq761MDL0ZouCcmDBRsCu7bG
	VmeoEXa+tq9eusMXmkBXwmyg6q8+pjuWobo/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aVt++tH3NRcmtwMKUBKewVkmsV9SLxT3
	V1EjTleWfaKRZS3OFEKMsf3DzWRgJmUIpUnoTuWttpgJsyg+xDfn6sXgZxleYUg6
	WWV3skF4TneL0uw60FS8Du8rG/pKns21ZU5k9YppmiOvEor1JUaux5zPzrkRsZU6
	gI97j3OfaF8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 04A66CA4F5;
	Tue,  3 Aug 2010 13:16:40 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7BC3CA4F3; Tue,  3 Aug
 2010 13:16:36 -0400 (EDT)
In-Reply-To: <vpq8w4ob3yz.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Tue\, 03 Aug 2010 08\:33\:08 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E12BCBF2-9F22-11DF-9B54-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152527>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>>> ... especially when parse-option already does this:
>>>
>>> git commit --message foo   => works
>>> git gc --prune 'last week' => doesn't
>>>
>>> Just like most GNU tools:
>>>
>>> grep --regexp foo => works
>>> grep --color auto => doesn't
>>
>> Hmm.
>>
>> Are you hinting that we should keep "you can say '-Ofoo' and '-O foo'"
>> bits but we should drop "you can also say '--opt=foo' and '--opt foo' as
>> long as --opt always takes an argument"?
>>
>> I actually think that may make sense.
>
> I'm not sure I parsed your sentence correctly, but if I did, then no,
> I don't think we should drop separate forms when --opt always takes an
> argument, just the opposite.

What I meant was somewhat different.  I agree that we _could_ take
separate "--opt <string>" form when --opt is known to always take an
argument without ambiguity (the same goes for "-O <string>").

But I thought you were suggesting to accept:

    -O<string>
    -O <string>
    --opt=<string>

but never take:

    --opt <string> (even when --opt always takes an argument)

because that would further reduce one source of potential confusion
(i.e. the user needs to remember if --opt always takes an argument or
not).  I thought you mentioned that neither parse-options nor GNU tools
take "--prune last", "--color auto" as a good supporting argument for
this---the users won't miss the "--opt <string>" feature because that is
not a common practice.

And I was agreeing to that.
