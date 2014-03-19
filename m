From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib.sh: use printf instead of echo
Date: Wed, 19 Mar 2014 12:24:55 -0700
Message-ID: <xmqqob122dq0.fsf@gitster.dls.corp.google.com>
References: <20140314235735.GA6959@ibr.ch> <20140315001855.GK15625@google.com>
	<xmqq61nceidp.fsf@gitster.dls.corp.google.com>
	<20140318221844.GA828@google.com>
	<xmqqfvme5cql.fsf@gitster.dls.corp.google.com>
	<871txygl27.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Uwe Storbeck <uwe@ibr.ch>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Mar 19 20:25:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQM6t-00036f-1s
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 20:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbaCSTZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 15:25:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36074 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377AbaCSTY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 15:24:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA29775E0B;
	Wed, 19 Mar 2014 15:24:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ysg21eK6BM5oVlPrVNCkzNRCmiU=; b=qG75qg
	qiMYmtD5T9FxQudZOPZOggd7xkOyuSFuEf5Ca0AE0N7DCD7BcjVtanJsfcvgCkEy
	uzoFvWtGm6J5fk9lIqR1m8qBAyo2bv2R13qOOvH3xN3cfC60bKrAbAd0JBvAmD/1
	Psbhyh57BROMwzAHJMWyhrtth2ssplIaJPBRY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cpi/RA2EkSGIscKFLjC9mz9yvdRrXrna
	Wdn2My9BbWn0eydNiMj6Gc8+dWLfObzjP0xbYVVdwK4COJPyUBgLUg0eBXdBvHYE
	Tfxc2NA9i5I3PpRZn1f2FLFF/MC8oYwfqtbrh414JGT27v2cOZb2B6OtDXSOOFKq
	Dd3QVnAVAhU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D387475E09;
	Wed, 19 Mar 2014 15:24:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1CD7875E07;
	Wed, 19 Mar 2014 15:24:58 -0400 (EDT)
In-Reply-To: <871txygl27.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Wed, 19 Mar 2014 18:22:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 288CA2E0-AF9C-11E3-8330-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244482>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>>> Junio C Hamano wrote:
>>>>> Uwe Storbeck wrote:
>>>
>>>>>> +	printf '%s\n' "$@" | sed -e 's/^/#	/'
>>>>
>>>> This is wrong, isn't it?  Why do we want one line per item here?
>>>
>>> Yes, Hannes caught the same, too.  Sorry for the sloppiness.
>>>
>>> We currently use "echo" all over the place (e.g., 'echo "$path"' in
>>> git-sh-setup), and every time we fix it there is a chance of making
>>> mistakes.  I wonder if it would make sense to add a helper to make the
>>> echo calls easier to replace:
>>
>> I agree that we would benefit from having a helper to print a single
>> line, which we very often do, without having to worry about the
>> boilerplate '%s\n' of printf or the portability gotcha of echo.
>>
>> I am a bit reluctant to name the helper "sane_echo" to declare "echo
>> that interprets backslashes in the string is insane", though.
>
> raw_echo

Yeah, but the thing is, this is not even "raw" if you view it from
the direction of knowing what "echo" does.  That is why I repeated
"helper to print a single line", which is a viewpoint from the user
side.  "We do not care how it is implemented, we just want a single
line printed" is what we want to express, which "say" is perfectly
in line with.  "We use a subset semantics of 'echo' to implement it"
is of secondary concern.
