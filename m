From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Change sed i\ usage to something Solaris' sed can handle
Date: Wed, 30 Oct 2013 12:30:22 -0700
Message-ID: <xmqqeh72blpt.fsf@gitster.dls.corp.google.com>
References: <1382909208-7716-1-git-send-email-bdwalton@gmail.com>
	<877gcx1eho.fsf@igel.home>
	<CAP30j15+E4cz_kwJwaSH7-3agwC5J3jGNfaixSUg2=8xAzZoQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>, git <git@vger.kernel.org>
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 20:30:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbbTP-0007rH-6t
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 20:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612Ab3J3Ta3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 15:30:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41341 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754268Ab3J3Ta0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 15:30:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 382474CA67;
	Wed, 30 Oct 2013 15:30:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OIevcqTBJqWvaLqSAhyXvCbxtDI=; b=ioC2X4
	vYkdaC5TuWgdJDyOXFvUzAG1cIzr2cQh4Z90xQBctqmqi6szZfqoPTNLnSwhECFT
	x8HE8lpTjs62XmbJ9+abrwDcGEBDXxwtpA42lLTv715mmh+LoygGreeei/+0HZoX
	6VPel0r8QSPa57mEg/BS5x10eUO5mxXu2+yMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UlTfRqjZ6dvg7hQikoBy0DyHhqhfwaSH
	+YzdlQZtXWEgdWF6i4U3qeCl7xGDXP7+noRW766wBDt+mwnz/EdckVK00sleR3Gp
	aQY9lrKpHX4TxbclCqKb6IZUs5FFSHCrW85W1MQBJdB7zEUcTO3arOKsTmCkcPca
	bYgiB4xVyZ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B08E4CA66;
	Wed, 30 Oct 2013 15:30:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8546C4CA65;
	Wed, 30 Oct 2013 15:30:24 -0400 (EDT)
In-Reply-To: <CAP30j15+E4cz_kwJwaSH7-3agwC5J3jGNfaixSUg2=8xAzZoQg@mail.gmail.com>
	(Ben Walton's message of "Mon, 28 Oct 2013 21:10:46 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B947F404-4199-11E3-B341-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237059>

Ben Walton <bdwalton@gmail.com> writes:

> On Mon, Oct 28, 2013 at 5:39 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
>> Ben Walton <bdwalton@gmail.com> writes:
>>
>>> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
>>> index 3fb4b97..0126154 100755
>>> --- a/t/t4015-diff-whitespace.sh
>>> +++ b/t/t4015-diff-whitespace.sh
>>> @@ -145,7 +145,8 @@ test_expect_success 'another test, with --ignore-space-at-eol' 'test_cmp expect
>>>  test_expect_success 'ignore-blank-lines: only new lines' '
>>>       test_seq 5 >x &&
>>>       git update-index x &&
>>> -     test_seq 5 | sed "/3/i \\
>>> +     test_seq 5 | sed "/3/i\\
>>> +\
>>>  " >x &&
>>
>> Why do you need the \<nl>?  Since it is inside double quotes the shell
>> will remove it during expansion.
>
> It's an escape. Without it, sed throws:
>
> sed: -e expression #1, char 5: expected \ after `a', `c' or `i'

I think Andreas means the "feed blank line" part, i.e.

>> +     test_seq 5 | sed "/3/i\\
>> +\
>>  " >x &&

should be the same as

>> +     test_seq 5 | sed "/3/i\\
>>  " >x &&

because the lone \<nl> will be eaten and will not be seen by sed.

Do you see different results on Solaris between the following two?

	$ echo "/3/i\\
	\
	" | od
	$ echo "/3/i\\
        " | od
