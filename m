From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t6023 broken under Mac OS
Date: Sat, 02 Jan 2016 11:35:26 -0800
Message-ID: <xmqqr3hzpyf5.fsf@gitster.mtv.corp.google.com>
References: <56869D10.9090105@web.de> <5686B400.7000800@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	dev+git@drbeat.li, Git Mailing List <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 20:35:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aFRxd-0007kw-C9
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jan 2016 20:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbcABTfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2016 14:35:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54820 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751199AbcABTf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2016 14:35:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7026737C14;
	Sat,  2 Jan 2016 14:35:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YXFE1tuAEZN0Q5U463cofzKNQCo=; b=IMPaEh
	E1Qtc6M2mPwfTw6m8EN92Ziyt6/tJFQBux/YkRkA6rK4z8uRqoS+rqkyioHaD/rH
	vJVpmTOe0D5OoCcXNSZv+m4qNFhAwl/CtourYfAeYMQO5ZMi/RvgmGPUP6/BOO2t
	D99Anf3Ui5bkBLk2RmAUXTOKw58Je4RS7MwD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XzcHHiMPev1EBb0QiHeI9sV2OILqs+yy
	8fTqdLlZd6fntmeh8fjxaW55jrcgw2EE59HaFtlH9zXrPS0UVzHKR7lQ7JgwjKGU
	tTYfZi1LVN7qXDEpEFnHl807a5qTcIvEGnD9TuV36pqNFj+mXU0fOhtw2iyCPLj3
	0R9y9FuvJC4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 651B637C07;
	Sat,  2 Jan 2016 14:35:28 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D596737C06;
	Sat,  2 Jan 2016 14:35:27 -0500 (EST)
In-Reply-To: <5686B400.7000800@ramsayjones.plus.com> (Ramsay Jones's message
	of "Fri, 1 Jan 2016 17:14:40 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FA129F92-B187-11E5-80E8-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283266>

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Hmm, I have never used a Mac, so I'm just guessing here, but
> you could try something like (obviously untested!):
>
> diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
> index 245359a..68b306f 100755
> --- a/t/t6023-merge-file.sh
> +++ b/t/t6023-merge-file.sh
> @@ -350,7 +350,7 @@ test_expect_success 'conflict at EOF without LF resolved by --union' \
>  test_expect_success 'conflict markers contain CRLF when core.eol=crlf' '
>  	test_must_fail git -c core.eol=crlf merge-file -p \
>  		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
> -	test $(sed -n "/\.txt\r$/p" output.txt | wc -l) = 3
> +	test $(tr "\015" Q <output.txt | sed -n "/\.txtQ$/p" | wc -l) -eq 3
>  '
>  
>  test_done
>
> [The 'wc -l' portability should only be a problem if you rely on the
> exact textual form of the output, rather than the integer count.
> 'wc -l' is used in many many tests ...]

Looks OK, thanks.

The use of the unportable '\r' with sed exists only in a stale topic
parked on 'pu', so I won't worry about it myself at this point, but
when the topic is rerolled, reviewers please be careful to spot it
and stop it from introducing this bug to our tree.

Thanks.
