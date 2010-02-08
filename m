From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: git-add: correct first example
Date: Mon, 08 Feb 2010 12:08:17 -0800
Message-ID: <7v6367lccu.fsf@alter.siamese.dyndns.org>
References: <1265650551-32664-1-git-send-email-gbacon@dbresearch.net>
 <7vsk9bmt1h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg Bacon <gbacon@dbresearch.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 21:08:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeZuM-00072J-Ce
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 21:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754328Ab0BHUI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 15:08:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47030 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713Ab0BHUI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 15:08:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BDADE98335;
	Mon,  8 Feb 2010 15:08:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8JiGpD5T2PKGz2uRXFBnQt9NCds=; b=gt8HQj
	63G9/fpt73GJwNhzsFXMKvwcBsDW8JdxH+K/CIO1P27GhWAPNjVedb7BjTlLSDm1
	+45Yj+X5rrSNI5K9jw30d8pvG72OqeRObuKTamzKS+KQq1sKKK9VtcbWsVyUulhw
	SW2xklXiZWchOSuxHYJJPm18n7fcKwe5zifrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fcB7uIq2DeAZjThv4qc7to44h/AD/oC3
	po73P/waiNyvjElnzocIXSUVA7uTwkJ8NZjEtq/bcKMQRpMLpx+u2+D5mdAJoNxd
	wBGZCwRiD++MvFl+NZ7s6mIP0OQ9R/okSjcRBfuI9WZRIHbhMgDURyI8CcNsC+bm
	/ZRDWNdxK+Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 91BA99832F;
	Mon,  8 Feb 2010 15:08:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB1A49832D; Mon,  8 Feb
 2010 15:08:18 -0500 (EST)
In-Reply-To: <7vsk9bmt1h.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 08 Feb 2010 11\:22\:34 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B4AFC9A8-14ED-11DF-9CFF-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139309>

Junio C Hamano <gitster@pobox.com> writes:

>>  and its subdirectories:
>>  +
>>  ------------
>> -$ git add Documentation/\\*.txt
>
> This indeed results in double-backslash in the output.
>
>> +$ git add Documentation/\*.txt
>
> and this seems to fix it.
>
> Thanks.

To look for similar breakages, I ran

    git grep -n -e '\\\\' -- 'Documentation/*.txt'

and found this in git-rm.txt:

    EXAMPLES
    --------
    git rm Documentation/\\*.txt::
            Removes all `\*.txt` files from the index that are under the
            `Documentation` directory and any of its subdirectories.

What is intereseting is that this is rendered correctly.  Quoting rule in
AsciiDoc is mysterious...

It turns out that the breakage in "git add" documentation was a
regression; the examples were written in a similar way to the one in "git
rm" documentation.  When 921177f (Documentation: improve "add", "pull" and
"format-patch" examples, 2008-05-07) converted it to displayed text,
nobody noticed that the difference in the backslash quoting rule between
the enumeration header and displayed text.
