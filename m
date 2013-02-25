From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Fix date checking in case if time was not
 initialized.
Date: Mon, 25 Feb 2013 11:04:57 -0800
Message-ID: <7vr4k4xlie.fsf@alter.siamese.dyndns.org>
References: <CAHXAxrOOqn6ZSVT1AFyO3a3paD1tokBtcnaX68a+ddhodOvZ6Q@mail.gmail.com>
 <7vzjysxnb1.fsf@alter.siamese.dyndns.org>
 <CAHXAxrMaQRdBxSvNO+no_9d==v0tVnkpXtguTKyfvnm-VfR_xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Gorchak <mike.gorchak.qnx@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 20:05:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA3Mc-0001Pl-Or
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 20:05:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759610Ab3BYTFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 14:05:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33068 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759185Ab3BYTFA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 14:05:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 570E3AB6E;
	Mon, 25 Feb 2013 14:04:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZcH5c+UgnSoVUN/euUzh/zQZHYM=; b=XIVSet
	4uFQM4/Fjgmfg1N6/TkvVlRSqv6qIzagZDLebTNaLN7Ku3Kes10n2VW+pEv5sU5h
	EvMbPMv0lSqbiNInj4aHBGiWy0cyBsqgfjtLq/zSoZ3ebJS6vt0H4o2jRj2bqdwt
	JfpOqPwndqHLj81LftRlu3CtF0jY3TIA2MFMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RvUKFlkAvvPiEuWlzGxvH88I4wCVjlzn
	ZPEEQKuMRfSq0rVUmpYzf9NwmiMqHOx7ruBO3IryyD4ozKzX8zlzlZi/ABpK1u2+
	59ZQA1R38lZvsb5ZQb5lUgUGaNq0c+xzmpt4hQhK/mxaBQg0nfSz4lQwh+IuJyo6
	m4G5Z/sYKJI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A3ACAB6D;
	Mon, 25 Feb 2013 14:04:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1089AB6A; Mon, 25 Feb 2013
 14:04:58 -0500 (EST)
In-Reply-To: <CAHXAxrMaQRdBxSvNO+no_9d==v0tVnkpXtguTKyfvnm-VfR_xA@mail.gmail.com> (Mike
 Gorchak's message of "Mon, 25 Feb 2013 20:43:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3FD3BD2A-7F7E-11E2-BB89-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217085>

Mike Gorchak <mike.gorchak.qnx@gmail.com> writes:

>>> Fix is_date() function failings in detection of correct date in case
>>> if time was not properly initialized.
>>
>> Please explain why this patch is needed and what problem this patch
>> is trying to fix (if any) a bit better in the proposed log message.
>> For example, on what input do we call this function with partially
>> filled *r, and is that an error in the code, or is it an indication
>> that the input has only been consumed partially?
>
> function is_date() must not fail if time fields are not set.

> Currently is_date() invokes tm_to_time_t() which perform check of
> time fields.  With these fixes t0006-date.sh test is no longer
> fail on these tests:

The thing that puzzles me is that nobody reported that the following
fail on their platforms (and they do not fail for me on platforms I
have to test in my real/virtual boxes).

> check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
> check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
> check_parse '2008-02-14 20:30:45 -0015' '2008-02-14 20:30:45 -0015'
> check_parse '2008-02-14 20:30:45 -5' '2008-02-14 20:30:45 +0000'
> check_parse '2008-02-14 20:30:45 -5:' '2008-02-14 20:30:45 +0000'
> check_parse '2008-02-14 20:30:45 -05' '2008-02-14 20:30:45 -0500'
> check_parse '2008-02-14 20:30:45 -:30' '2008-02-14 20:30:45 +0000'
> check_parse '2008-02-14 20:30:45 -05:00' '2008-02-14 20:30:45 -0500'

So there must be something _else_ going on, and I cannot tell what
that something else is from your code change nor from the log
message.  I'd like to see that explained.

Still puzzled...
