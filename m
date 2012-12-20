From: Junio C Hamano <gitster@pobox.com>
Subject: Re: $PATH pollution and t9902-completion.sh
Date: Thu, 20 Dec 2012 13:02:30 -0800
Message-ID: <7v7goc4eu1.fsf@alter.siamese.dyndns.org>
References: <20121217010538.GC3673@gmail.com>
 <20121220145519.GB27211@sigill.intra.peff.net>
 <7vk3sc606f.fsf@alter.siamese.dyndns.org>
 <7vobho4hxa.fsf@alter.siamese.dyndns.org>
 <20121220200109.GC21785@sigill.intra.peff.net> <50D37AB2.1040508@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Adam Spiers <git@adamspiers.org>,
	git mailing list <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 20 22:02:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlnGY-0003Sc-HQ
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 22:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496Ab2LTVCh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Dec 2012 16:02:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34898 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751299Ab2LTVCf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Dec 2012 16:02:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB0E8ADE5;
	Thu, 20 Dec 2012 16:02:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1/NNYsJvKT7K
	ZCNIqUZK7TYPO98=; b=LFHDKUWbIh/AhRKkCkJqN178u9bnsuM57E3fSHR/Cz1A
	AV7vBrG6yfOT2SwIngDxK49O9TUTppLe6qx1WEEy2B38Fxl2mvdT8TN5hs0CCIbM
	j3oHsOqisY7nIwqXgpZ3j2vxRcsRXuMyGAmORTr3K/eE83mldEFNZdoyvXuDKD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LQk4sa
	y59I1JCAZTSXNg0GVsygBUXTinAV/rp9mtevVS8FltM7mHYDRb3N74dZ7ZGTaWv7
	bX96iFz7uxugqgkjb3pjBiMrmk17Je/fiCMiq9iUzDDTJBXNFMExiWtC9yRl/Rz/
	RTfuis2H4elWY4WXTHRKjmkBsgHYnErIQytcw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7A4AADE4;
	Thu, 20 Dec 2012 16:02:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 300ADADE0; Thu, 20 Dec 2012
 16:02:32 -0500 (EST)
In-Reply-To: <50D37AB2.1040508@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Thu, 20 Dec 2012 21:53:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 924ED1F4-4AE8-11E2-86C1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211928>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 20.12.12 21:01, Jeff King wrote:
>> +test_fully_contains () {
>>> +	sort "$1" >expect.sorted &&
>>> +	sort "$2" >actual.sorted &&
>>> +	test $(comm -23 expect.sorted actual.sorted | wc -l) =3D 0
>>> +}
>
> (Good to learn about the comm command, thanks )
> What do we think about this:

Three points to consider.

 * Do _all_ tests that use test_completion not care about the actual
   order of choices that come out of the completion machinery?

 * Do _all_ tests that use test_completion not care about having
   extra choice, or is the command name completion the only odd
   case?

 * Is this still as easy to extend as the original to conditionally
   verify that all extra output share the same prefix?

> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 3cd53f8..82eeba7 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -62,12 +62,16 @@ test_completion ()
>  {
>  	if test $# -gt 1
>  	then
> -		printf '%s\n' "$2" >expected
> +		printf '%s\n' "$2" | sort >expected.sorted
>  	else
> -		sed -e 's/Z$//' >expected
> +		sed -e 's/Z$//' | sort >expected.sorted
>  	fi &&
>  	run_completion "$1" &&
> -	test_cmp expected out
> +	sort <out >actual.sorted &&
> +	>empty &&
> +	comm -23 expected.sorted actual.sorted >actual &&
> +	test_cmp empty actual &&
> +	rm empty actual
>  }
> =20
>  # Test __gitcomp.
