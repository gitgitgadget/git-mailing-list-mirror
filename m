From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach ignore machinery about pattern "/"
Date: Sun, 03 Jun 2012 14:49:36 -0700
Message-ID: <7vbol0xdzj.fsf@alter.siamese.dyndns.org>
References: <1337950056-26491-1-git-send-email-pclouds@gmail.com>
 <7vlikgtbcx.fsf@alter.siamese.dyndns.org>
 <CACsJy8BjUQsCVVdzZtJxA9Qu2G0izZa8dvP1EKsQQAHWXZbHdg@mail.gmail.com>
 <CACsJy8BSHFzGfsm6qY1LEX9wubKjKXXbJ_WMAiOAUhVGa631Ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 23:49:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbIgQ-0006Rk-9S
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 23:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817Ab2FCVtk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Jun 2012 17:49:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35661 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754764Ab2FCVtj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jun 2012 17:49:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98CBA88A5;
	Sun,  3 Jun 2012 17:49:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Z6FoDd1lUd5D
	54byec3r0QixvcA=; b=S29s79wtJFhpe/8otp3wDdC6SVoRc4QRXBygXbXFrEBj
	920uitTrGbFycBUq2eEdpwDxIPEXKoJlm3SZPxAkKsWivP8I5LyY3WA7vEvQM5I3
	mbR1R99/NPz1zxf8TDewYR7SAWfbWx7jEOYbeBtUj0aEytlKH8+XuMVN3l46g3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LGZKXJ
	wnx/6bdnZuKJEa+tvIDPteCwHwSiCaYFpTn/8vCRWBwpcQJq/I0xdKnDyW+lMBM2
	KP5dUOCMCb14Wxy6IstEheIJqOqwvVnspZGHpzkM2ERh5/zoyamXsT2/QaYH4Lm7
	5oO3FMbvkARK2ZEqZzlVz86ytgdcD2cAWW8to=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AA5D88A4;
	Sun,  3 Jun 2012 17:49:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A53D88A3; Sun,  3 Jun 2012
 17:49:38 -0400 (EDT)
In-Reply-To: <CACsJy8BSHFzGfsm6qY1LEX9wubKjKXXbJ_WMAiOAUhVGa631Ag@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sun, 3 Jun 2012 19:36:23 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0411322A-ADC6-11E1-B51F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199106>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Sat, May 26, 2012 at 11:30 AM, Nguyen Thai Ngoc Duy
> <pclouds@gmail.com> wrote:
>> On Sat, May 26, 2012 at 12:32 AM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com>=
 writes:
>>>
>>>> Pattern "/" is ambiguous because the slash can mean "anchor the
>>>> pattern to this location" (e.g. /path), but it can also mean
>>>> "match directories only" (e.g. path/). Currently git interprets it=
 as
>>>> the latter except that 'path' is an empty string, which makes this
>>>> pattern totally useless.
>>>
>>> Did the old version interprete it as the former?
>>
>> That calls for bit of testing, which I'll do soon.
>
> "/" is no-op since 1.4.0 (tested with refs/tags/v*),...

So historically we had three possible interpretations of "/",
i.e. "/path" that happens to have an empty path, "path/" that
happens to have an empty path, and a no-op.

That strongly suggests that we should at least warn when we see "/"
that the user is playing with fire by feeding the exclude machinery
something without clear semantics.

Doing a no-op might be a safer option than adding it new special
case semantics to it, but even then I do not think we should
silently ignore it.  Silently giving new semantics for this
particular special case is out of the question, I would have to say.

Thanks for digging.
