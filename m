From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5541-http-push: make grep expression check for one line
 only
Date: Mon, 25 Jan 2010 09:52:08 -0800
Message-ID: <7v1vhe3wdz.fsf@alter.siamese.dyndns.org>
References: <1264405343-2984-1-git-send-email-rctay89@gmail.com>
 <7v7hr63wm7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 18:52:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZT6r-0007nX-FV
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 18:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228Ab0AYRwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 12:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148Ab0AYRwQ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 12:52:16 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33984 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900Ab0AYRwP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 12:52:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 61C5F94BC8;
	Mon, 25 Jan 2010 12:52:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2rlutu9s+tbOIOh2DdFXWC4tbEk=; b=F5vNQt
	PcpYy24MBMMeoi1FHqAbIQA0ARDpWi8XxhErVXxv7jjOervgZf8hLIlbb1FTV+kO
	6+SDYg7yZvbJbCI8B0tIx5+cIz5YHfk5+AwzhWfo8fapcz4nw9JOs5aJe0tfe/D2
	bWDrUBNviMi00hVdaXa9zgJ/wMegWDoyQPd+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CX5gLSLECFEwiFu3AOZB/yo6tqFdkwvj
	Q4hFwz0l0hudg/IUP3w7xk5hUMCzQn1z1JCfF2zblel0VzrUJhrpSYilaoLkMzS1
	RvivGGiqdtIXAHbdl3+et1vqnZnU94NjT4MMrGmfrVNZEi6uVgyKiKjlGB/STpqA
	c5FU8vr7CJo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 38DD294BC7;
	Mon, 25 Jan 2010 12:52:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67CC894BC6; Mon, 25 Jan
 2010 12:52:09 -0500 (EST)
In-Reply-To: <7v7hr63wm7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 25 Jan 2010 09\:47\:12 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5E2E0DE2-09DA-11DF-AE3D-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137972>

Junio C Hamano <gitster@pobox.com> writes:

> Tay Ray Chuan <rctay89@gmail.com> writes:
>
>> Simplify the grep expressions in the non-fast-forward tests to check
>> only for the first line of the non-fast-forward warning - having that
>> line should be enough assurance that the full warning is printed.
>>
>> In the first place, grep can't deal with expressions for multiple
>> lines.
>
> This shows that nobody has ever run this test since January 8th, not even
> the original author?
>
> Hmmm.

Actually, if you grep with a pattern with multiple lines, it is equivalent
to giving each of these lines as a separate pattern from the command line.
So it is understandable that the tests passed.  They were checking if
these match, but it doesn't check (and grep is not designed to) if the
first pattern matched the first line, the second to second, etc.

So I'd say something like...

    Don't feed multiple-line pattern to grep and expect them to match with
    lines in order.

    Simplify the grep expressions in the non-fast-forward tests to check
    only for the first line of the non-fast-forward warning - having that
    line should be enough assurance that the full warning is printed.

    Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

instead.
