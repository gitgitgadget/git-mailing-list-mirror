From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] check-non-portable-shell: Check for non portable grep usage
Date: Thu, 25 Apr 2013 13:44:28 -0700
Message-ID: <7vehdy2vdf.fsf@alter.siamese.dyndns.org>
References: <201304252048.19235.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 25 22:44:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVT1x-0004i5-K4
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 22:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759505Ab3DYUoc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Apr 2013 16:44:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49453 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759396Ab3DYUob convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Apr 2013 16:44:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 266A51997D;
	Thu, 25 Apr 2013 20:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qLoAStB1vDQI
	qfyNna/NVTsvu8I=; b=U8hLuMxoU7+GOVCOFXh6EsR5R4AQ9lF9zUAWmGCrP7/w
	qLx8b7Mz+Lu1wWmUe29f04IxqDhQLHymS/UGi7CZOCzxsrOD7Xi4m9/dQSZO/Rxi
	4WkPOLiAmFOvuV48xM2MObdvQlpB2ZoM/yPtVqnmNc9uL3kHxkkyyeQh2v+vNXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LnzxQP
	DWlz2/OpmeXJ2sptCGjRPBX9gPKxUWB0O+JNysqb/xevHwmqchIhUKBzQP4VPtyF
	BU/wAsi03pyGUfU5UUbETOHZfZTxVEduMnJQFJzaQ5ygldFkIe5EbQR32FVx4VyR
	jQl5v6FRvVEiqL01kpT1WyfrAvnxrCmXA0Wj4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C53E1997C;
	Thu, 25 Apr 2013 20:44:30 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7333919979;
	Thu, 25 Apr 2013 20:44:29 +0000 (UTC)
In-Reply-To: <201304252048.19235.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Thu, 25 Apr 2013 20:48:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED012B66-ADE8-11E2-B591-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222445>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The make test-lint could check for some common non portable
> grep usage:
>
> The + as a qualifier is not a "basic regular expression".
> Some grep understand \+, but in general egrep should be used.
>
> The \t can not be used to find an ASCII TAB, neither
> can \s be used to find a whitespace
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  t/check-non-portable-shell.pl | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-she=
ll.pl
> index ff87611..58f8e2c 100755
> --- a/t/check-non-portable-shell.pl
> +++ b/t/check-non-portable-shell.pl
> @@ -16,6 +16,8 @@ sub err {
> =20
>  while (<>) {
>  	chomp;
> +	/ e?grep\s+\"[^"]*\\([st])/ and err "grep \\$1 is not portable)";

grep -e "foo\tbar" is exempt?  Indenting with a single tab,
immediately followed by "grep" or "egrep" without SP in front, is
exempt?

> +	/ [^e]grep.*\\\+/ and err 'grep with \+ is not portable (please use=
 egrep)';

Not even checking if the it is inside the pattern of grep?

As I said number of times, I do not think it is a workable approach
to textually match patterns in a script that does not understand
even the basic shell syntax.

>  	/^\s*sed\s+-i/ and err 'sed -i is not portable';
>  	/^\s*echo\s+-(\S)\s+/ and err "echo -$1 is not portable (please use=
 printf)";
>  	/^\s*declare\s+/ and err 'arrays/declare not portable';
