From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] git-credential-store: support multiple credential files
Date: Sun, 15 Mar 2015 13:03:26 -0700
Message-ID: <xmqqy4myt4dt.fsf@gitster.dls.corp.google.com>
References: <1426056553-9364-1-git-send-email-pyokagan@gmail.com>
	<1426056553-9364-2-git-send-email-pyokagan@gmail.com>
	<20150313061530.GA24588@peff.net>
	<CACRoPnR9pTc2LC87Vf0bMAgTj-FnbsRBpjn+3RCxCP6yrzsCkw@mail.gmail.com>
	<xmqqfv97w7k5.fsf@gitster.dls.corp.google.com>
	<vpqbnju7aex.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Mar 15 21:03:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXEl4-0001md-Ih
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 21:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbbCOUDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 16:03:30 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50930 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752516AbbCOUD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 16:03:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E0533EF50;
	Sun, 15 Mar 2015 16:03:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bxpgGixBMcAARzHKWjn9MCzq34A=; b=cC8KMe
	EY3wbPa1FgwCGsMxGwEPPGTlKby3na7zKRJivepj8OcoKkbYcjr9DuQ5EEdbCojH
	WuBgkMMWqG+3uY9eXhiYOmNkR8R3mhsglvtDYKW6ZZRA/DEULodv2P3BVfn44D3n
	R346tqFcD9lz0MNmTzpXd1M+4/sTsz3qXE9qY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LRhePQdKjWG0dQcL3Y6VvUy0jeSoH6kl
	9PyyKczFIlPYPzvUCzsLFegutKgTdmk+Tix9RUlTe62gM1qQ8YsF4+zUP/wGrXQm
	XvveFU7eDIMiTdMcBRv6YqcjUsSRBYs8IX28yk7TCX2mTnNOOH6P2Hi1hWotJlHA
	nf08YoXh65U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 868B73EF4E;
	Sun, 15 Mar 2015 16:03:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F26153EF4D;
	Sun, 15 Mar 2015 16:03:27 -0400 (EDT)
In-Reply-To: <vpqbnju7aex.fsf@anie.imag.fr> (Matthieu Moy's message of "Sun,
	15 Mar 2015 12:44:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5877B61A-CB4E-11E4-8D3F-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265517>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Paul Tan <pyokagan@gmail.com> writes:
>>
>>>> I think you could even get away without passing default_fn here, and
>>>> just use the rule "the first file in the list is the default". Unless
>>>> you are anticipating ever passing something else, but I couldn't think
>>>> of a case where that would be useful.
>>>
>>> Even though in this case the store_credential() function is not used
>>> anywhere else, from my personal API design experience I think that
>>> cementing the rule of "the first file in the list is the default" in
>>> the behavior of the function is not a good thing. For example, in the
>>> future, we may wish to keep the precedence ordering the same, but if
>>> none of the credential files exist, we create the XDG file by default
>>> instead.
>>
>> I am not sure if this is not a premature over-engineering
>
> I would say so if having this default_fn made the code more complex,

True, or if it made caller(s) be redundant or repeat themselves
without a good reason.  Otherwise we would end up having to drop the
redundant and/or unnecessary arguments in future clean-up patches; I
had to de-conflict a series with 7ce7c760 (convert: drop arguments
other than 'path' from would_convert_to_git(), 2014-08-21) recently,
which reminded me of this point ;-).

> but
> here the code is basically
>
> +	if (default_fn)
> +		store_credential_file(default_fn, c);
>
> and
>
> -		store_credential(file, &c);
> +		store_credential(&fns, &c, fns.items[0].string);
>
> Taking the first element in the list wouldn't change much.
>
> I'm personally fine with both versions.

Turning the current code to drop the extra parameter and to use the
first element instead wouldn't be a big change, but these things
tend to add up, so unless this discussion immediately lead to a
future enhancement plan to make use of the flexibility the parameter
gives us, I'd rather see things kept simpler.

I do not terribly mind either way, either, though.
