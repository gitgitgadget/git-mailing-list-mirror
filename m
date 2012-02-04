From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 03/13] parseopt: make OPT_INTEGER support hexadecimal
 as well
Date: Fri, 03 Feb 2012 21:32:14 -0800
Message-ID: <7vobtfjh9d.fsf@alter.siamese.dyndns.org>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
 <1328276078-27955-4-git-send-email-pclouds@gmail.com>
 <7vaa4zmsku.fsf@alter.siamese.dyndns.org>
 <CACsJy8Ba2qxyT4XqeRmUv63Z3rT1-FmBkZ3tB6YMh6qrXjLP1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 06:32:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtYEw-0005Of-Hc
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 06:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212Ab2BDFcR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 00:32:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64324 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751128Ab2BDFcR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2012 00:32:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 860B127B3;
	Sat,  4 Feb 2012 00:32:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=eYeawfqBi6UN
	Yee91V/moCPWCCE=; b=NhU2ugh0trPWVInUY1T/elLHbKamJudfLk/G7eqo7HrK
	nYW6IJuF4C9bHrgvgDoqk6NVY4BQ6aDd93mjb3BiEzTUfuBneoma6KVf6m36pc2o
	94tIDbp8gTZxAl+ikXo7VVPQBzH92tZhCyFuU6FcF9wASLpMMUOk+Z7cvReZXLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Gw8BF1
	mpJmkwqBRm7sRUM/UhObyzT40Fgr9YeFmLGvBJjCWny4uia3CYjiOwGHYnrNtZXO
	UBl9iLZ6rA2gLfvpH68yfqPn3tnheRH8yM6SYx5vVONZ8orcuOeb70e4ViJKJo/k
	IizXbgnr6Ml0UiRXSHaPCZFy4dOqMf727HpVI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DB9727B2;
	Sat,  4 Feb 2012 00:32:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1271F27B1; Sat,  4 Feb 2012
 00:32:15 -0500 (EST)
In-Reply-To: <CACsJy8Ba2qxyT4XqeRmUv63Z3rT1-FmBkZ3tB6YMh6qrXjLP1Q@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sat, 4 Feb 2012 11:55:30 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 991F3012-4EF1-11E1-B2E5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189845>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2012/2/4 Junio C Hamano <gitster@pobox.com>:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> =
writes:
>>
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *(int *)opt->value =3D =
strtol(arg, (char **)&s, 10);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!prefixcmp(arg, "0x=
") || !prefixcmp(arg, "0X"))
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 *(int *)opt->value =3D strtol(arg + 2, (char **)&s, 16);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 *(int *)opt->value =3D strtol(arg, (char **)&s, 10);
>>
>> Can't you just do "strtol(arg, (char **)&s, 0)" instead?
>
> I could but that means "01234" is now in base 8 and that's currently
> accepted as base 10.

Yes, but I wonder if that is a problem in practice. Who in the right mi=
nd
would give 00001000 to tell git that they want one thousand?
