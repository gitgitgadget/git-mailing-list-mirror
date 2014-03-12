From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] general style: replaces memcmp() with proper starts_with()
Date: Wed, 12 Mar 2014 21:51:24 +0100
Message-ID: <5320C8CC.3010404@web.de>
References: <1394635434-44979-1-git-send-email-quintus.public@gmail.com>	<20140312175624.GA7982@sigill.intra.peff.net> <xmqqiorjky0a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Quint Guvernator <quintus.public@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 12 21:53:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNq92-0001ym-Pz
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 21:52:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbaCLUww convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Mar 2014 16:52:52 -0400
Received: from mout.web.de ([212.227.15.14]:56525 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888AbaCLUwv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 16:52:51 -0400
Received: from [192.168.178.27] ([79.250.169.126]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Lvjn6-1XDNXB41L2-017XZj; Wed, 12 Mar 2014 21:52:34
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <xmqqiorjky0a.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:gwXRSQdx/eNLRcTKyMJpYKSCG5adXqKeE/yfHQZ6vGF4yjptLwr
 c0qua3rHp7YCKmEaTLxRyRNkm5vjaita6kbNqk4G98KI/HXHZXboT9o1SVeuOswJSa1tz0e
 B7AK444N5qriB80gxrufzYU0P9tmtLXezShSUzY7K9dzQ0zjm0LyCxY2UY4hDreUPJRuJGM
 L6D5735TghxkE/Qzh56EA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243991>

Am 12.03.2014 20:39, schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
>
>>>   static inline int standard_header_field(const char *field, size_t=
 len)
>>>   {
>>> -	return ((len =3D=3D 4 && !memcmp(field, "tree ", 5)) ||
>>> -		(len =3D=3D 6 && !memcmp(field, "parent ", 7)) ||
>>> -		(len =3D=3D 6 && !memcmp(field, "author ", 7)) ||
>>> -		(len =3D=3D 9 && !memcmp(field, "committer ", 10)) ||
>>> -		(len =3D=3D 8 && !memcmp(field, "encoding ", 9)));
>>> +	return ((len =3D=3D 4 && starts_with(field, "tree ")) ||
>>> +		(len =3D=3D 6 && starts_with(field, "parent ")) ||
>>> +		(len =3D=3D 6 && starts_with(field, "author ")) ||
>>> +		(len =3D=3D 9 && starts_with(field, "committer ")) ||
>>> +		(len =3D=3D 8 && starts_with(field, "encoding ")));
>>
>> These extra "len" checks are interesting.  They look like an attempt=
 to
>> optimize lookup, since the caller will already have scanned forward =
to
>> the space.

I wonder what the performance impact might be.  The length checks are=20
also needed for correctness, however, to avoid running over the end of=20
the buffer.

> If one really wants to remove the magic constants from this, then
> one must take advantage of the pattern
>
> 	len =3D=3D strlen(S) - 1 && !memcmp(field, S, strlen(S))
>
> that appears here, and come up with a simple abstraction to express
> that we are only using the string S (e.g. "tree "), length len and
> location field of the counted string.

This might be a job for kwset.

Ren=E9
