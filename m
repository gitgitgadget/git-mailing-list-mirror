From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] CYGWIN: avoid implicit declaration warning
Date: Sun, 23 Nov 2014 10:53:53 -0800
Message-ID: <xmqqegstychq.fsf@gitster.dls.corp.google.com>
References: <5471EC26.3040705@web.de> <5472159B.4060905@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Nov 23 19:54:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XscIK-0007xo-Pt
	for gcvg-git-2@plane.gmane.org; Sun, 23 Nov 2014 19:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbaKWSx5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Nov 2014 13:53:57 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65468 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751419AbaKWSx4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Nov 2014 13:53:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ED8FB18C48;
	Sun, 23 Nov 2014 13:53:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AnAN23XPtn8i
	xT1q0FnFDsQtzug=; b=cYlpldHona8lDi1dw9NDuU6rQMTEO3nnsyr5fOfyB9Sv
	2muF7WiAeqIF5zpLAP8bwg93BKPzfoWo/LCe8Q/gzl1TSUTIjKYbMoElQFf//XAn
	fV/o5kQ1seVfC3eXtEgnP3Fa27Tw1kLIDB6l4GpFYamIXRJDE8K9wfXpzjG+hAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Af4Zd2
	kEsB5lWd+L7uDJBsbQiWoIRsTz+GFLUuHCakXwhUF1PaP3Y/ksxCao3y78dJUnVc
	bC2ZCZFj2Va2VYMytQrZIcn/Yvyl+zxEkyIXeixOZOQbkb9QT+fJhwgqJZioZXRz
	4QOp1TW2nzlC4/DyQS/UYAUz4LtAVm7AoebpM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E4F5218C47;
	Sun, 23 Nov 2014 13:53:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6621518C46;
	Sun, 23 Nov 2014 13:53:54 -0500 (EST)
In-Reply-To: <5472159B.4060905@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Sun, 23 Nov 2014 17:12:59 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 128D9534-7342-11E4-B5B8-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260096>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> On 23/11/14 14:16, Torsten B=C3=B6gershausen wrote:
>> gcc under cygwin reports several warnings like this:
>>  warning: implicit declaration of function 'memmem'
>>   [-Wimplicit-function-declaration]
>> This has been observed under CYGWIN-32 with GCC 4.7.3 as well
>> as CYGWIN-64 with gcc v4.8.3-5 x86-64
>
> Heh, thanks for looking into this. Your email came at a good time,
> since I was just about to boot my old laptop into windows XP to
> test my patch on 32-bit cygwin! (If I had not been watching the
> F1 Grand Prix on TV, I would already have done so! ;-) ).
>
> It's been a while since I updated my 32-bit cygwin installation
> (about 6 months) but I'm a little surprised you found this issue
> with gcc 4.7.3 (I'm _almost_ tempted to boot that laptop anyway
> just to see what versions of software it is running).

So you have an old installation to check how well the patched
version is accepted by the old set of header files?

>
> Just for the reccord, my patch follows.
>
> ATB,
> Ramsay Jones
>
>>=20
>> Do not #define _XOPEN_SOURCE 600 for CYGWIN.
>>=20
>> Reported-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>> ---
>> This may be a start for a patch, tested under CYGWIN-32,
>> both Windows7 and XP
>>  git-compat-util.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 400e921..cef2691 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -75,7 +75,8 @@
>>  # endif
>>  #elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__US=
LC__) && \
>>        !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly_=
_) && \
>> -      !defined(__TANDEM) && !defined(__QNX__) && !defined(__MirBSD_=
_)
>> +      !defined(__TANDEM) && !defined(__QNX__) && !defined(__MirBSD_=
_) && \
>> +      !defined(__CYGWIN__)
>>  #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD =
needs 600 for S_ISLNK() */
>>  #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
>>  #endif
>>=20
