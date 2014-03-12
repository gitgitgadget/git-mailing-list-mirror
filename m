From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] general style: replaces memcmp() with proper starts_with()
Date: Wed, 12 Mar 2014 22:16:13 +0100
Message-ID: <87fvmni0de.fsf@fencepost.gnu.org>
References: <1394635434-44979-1-git-send-email-quintus.public@gmail.com>
	<20140312175624.GA7982@sigill.intra.peff.net>
	<xmqqiorjky0a.fsf@gitster.dls.corp.google.com>
	<5320C8CC.3010404@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Quint Guvernator <quintus.public@gmail.com>,
	git@vger.kernel.org
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 12 22:16:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNqVi-00076Q-QL
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 22:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbaCLVQR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Mar 2014 17:16:17 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:41419 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbaCLVQP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Mar 2014 17:16:15 -0400
Received: from localhost ([127.0.0.1]:40458 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WNqVa-0007Ki-9V; Wed, 12 Mar 2014 17:16:14 -0400
Received: by lola (Postfix, from userid 1000)
	id F00D9E05DC; Wed, 12 Mar 2014 22:16:13 +0100 (CET)
In-Reply-To: <5320C8CC.3010404@web.de> (=?iso-8859-1?Q?=22Ren=E9?=
 Scharfe"'s message of "Wed, 12
	Mar 2014 21:51:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243994>

Ren=E9 Scharfe <l.s.r@web.de> writes:

> Am 12.03.2014 20:39, schrieb Junio C Hamano:
>> Jeff King <peff@peff.net> writes:
>>
>>>>   static inline int standard_header_field(const char *field, size_=
t len)
>>>>   {
>>>> -	return ((len =3D=3D 4 && !memcmp(field, "tree ", 5)) ||
>>>> -		(len =3D=3D 6 && !memcmp(field, "parent ", 7)) ||
>>>> -		(len =3D=3D 6 && !memcmp(field, "author ", 7)) ||
>>>> -		(len =3D=3D 9 && !memcmp(field, "committer ", 10)) ||
>>>> -		(len =3D=3D 8 && !memcmp(field, "encoding ", 9)));
>>>> +	return ((len =3D=3D 4 && starts_with(field, "tree ")) ||
>>>> +		(len =3D=3D 6 && starts_with(field, "parent ")) ||
>>>> +		(len =3D=3D 6 && starts_with(field, "author ")) ||
>>>> +		(len =3D=3D 9 && starts_with(field, "committer ")) ||
>>>> +		(len =3D=3D 8 && starts_with(field, "encoding ")));
>>>
>>> These extra "len" checks are interesting.  They look like an attemp=
t to
>>> optimize lookup, since the caller will already have scanned forward=
 to
>>> the space.
>
> I wonder what the performance impact might be.  The length checks are
> also needed for correctness, however, to avoid running over the end o=
f
> the buffer.

Depends on whether memcmp is guaranteed to stop immediately on mismatch=
=2E
Then memcmp(field, "tree ", 5) cannot walk across a NUL byte in field.

--=20
David Kastrup
