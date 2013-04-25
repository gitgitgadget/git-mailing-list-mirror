From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/1] templates: pre-push hook: check for missing GPG signatures
Date: Thu, 25 Apr 2013 09:50:24 -0700
Message-ID: <7vy5c64krz.fsf@alter.siamese.dyndns.org>
References: <7vppxjbt6t.fsf_-_@alter.siamese.dyndns.org>
	<51791F41.3040203@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, joel@trustly.com, git@drmicha.warpmail.net
To: Sebastian =?utf-8?Q?G=C3=B6tte?= <jaseg@physik.tu-berlin.de>
X-From: git-owner@vger.kernel.org Thu Apr 25 18:50:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVPNR-0003KB-39
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 18:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759097Ab3DYQu2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Apr 2013 12:50:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46774 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757936Ab3DYQu1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Apr 2013 12:50:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FB69198F4;
	Thu, 25 Apr 2013 16:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NlVAv20DI07K
	e4Uxociil2UOrvM=; b=OoB8RYWvX3sC3EMs3pLYE7cqios0MgFYhJZzGKkxQElS
	MitGdBYNio3R9fbWr6Sn9U+8fRZZdue5wYX0A4wm1v5pfzJ+XJ9+mLF5dZF0HaNb
	hKG7/lrcC8ef3PmXitA8rITOUIxZdj8otpipGNi7y8xbmvAIQYHatSLA0u27mmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nPiUhA
	Vg0z9no2S/v7OKHQ5yzdRsf5s0mc8AOqhlZiGBEmRZIYCSXYsmIpwU1L1p2lo/C1
	4c/Nujv3jRrmMwo62FNSOVDlxR3TBI0L8maDmTimPSnh1vAuQZBW9K65u0Y2ZjJD
	bYTUbryvcdWrqgKNR88Lc6jhasTE6PaF6R6NY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36AC8198F3;
	Thu, 25 Apr 2013 16:50:27 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F425198F0;
	Thu, 25 Apr 2013 16:50:26 +0000 (UTC)
In-Reply-To: <51791F41.3040203@physik.tu-berlin.de> ("Sebastian
 =?utf-8?Q?G=C3=B6tte=22's?=
	message of "Thu, 25 Apr 2013 14:19:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3AB6CC60-ADC8-11E2-BDCE-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222393>

Sebastian G=C3=B6tte <jaseg@physik.tu-berlin.de> writes:

> On 04/24/2013 09:54 PM, Junio C Hamano wrote:
>> None of the above is part of a proper commit log message, is it?
> Fixed (I hope)

Don't hope, instead do.  ;-)

The questions I asked were not requests to explain them to _me_ in a
response like this.  They were the examples of what the proposed
commit log message should have explained what the patch attempts to
do.

>>> -IFS=3D' '
>> Why?
> Otherwise in the for-loop below the output of the pipe chain is not c=
orrectly
> split by newlines. Also AFAIK, this is not needed: I think the defaul=
t
> '<space><tab><newline>' is just fine here.

It is not enough to make sure that IFS has SP so that existing code
works correctly; we also need to see if the existing code needs to
avoid cutting the tokens at HT or LF.  I think in this case using
the default IFS is safe, as input to pre-push are SP separated refs
and object names, none of which can have SP, HT or LF in it.

>># Check for missing good GPG signatures
>>git log --format=3D"%G? %h" "$range" |
>>(
>>                exitcode=3D0
>>                while read sign commit
>>                do
>>                                test "$sign" =3D G && continue
>>                                echo "Commit $commit does not have a =
good GPG signature"
>>                                exitcode=3D1
>>                done
>>                exit $exitcode
>>)
>>let exitcode=3Dexitcode\|$?

Don't use bash-ism "let".

The above loop is a perfectly fine and readable way to write the
logic, by the way

Except that we tend to prefer $ret over $exitcode, but I've already
said that.

Thanks.
