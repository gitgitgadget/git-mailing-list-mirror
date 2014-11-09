From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 21/22] mingw32: add uname()
Date: Sun, 09 Nov 2014 10:47:42 -0800
Message-ID: <xmqqd28wb48h.fsf@gitster.dls.corp.google.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
	<1415439595-469-1-git-send-email-pclouds@gmail.com>
	<1415439595-469-22-git-send-email-pclouds@gmail.com>
	<CAPig+cS2FzL6kXTvoG6cTX1yUjmGUkEm5mAHNxmtU5-=ngcoFg@mail.gmail.com>
	<CACsJy8CRzngC5U3VY9Bi1uRmdRfEWQWOCokRLLWNKRNUjyJrrw@mail.gmail.com>
	<545F540D.8010207@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Nov 09 19:47:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnXWg-0006A0-Fs
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 19:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbaKISrr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Nov 2014 13:47:47 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54858 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751059AbaKISrq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Nov 2014 13:47:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 401F419980;
	Sun,  9 Nov 2014 13:47:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cZauFEt2W1/q
	e6VGNyk3gnvYjcQ=; b=SPJP7KaJ8WHNcJ4s5pVWohpxC3a1wJhLDMyDfM4wwolz
	8G6QsQTnm68pc5+fUnfHBPhnULQv9NUOl3nBXV6ZJdkhBFZ1Gj+fZN5AMF7I7ZZA
	5KdmiBPFjjmC6iYPdsdmDSdn7wPPmV+brAnEWe8DdWsf/gkdOvwFs8jvQFb83tg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yUO4K+
	83EFOs9yOXDO9blbpt1sw778T7UQ6wvdF8W346Dh+NcXTCMJ9Rfx+hdpyJZbVqvD
	vappEC0zdnCJaK9V3e3StivwrjfKIV7N99ym4jm/AAZ/qFqk2ypHCZPxlB3LpAAD
	QFALfUhSI2Eg9fGuKG5ork9anktpen0i7cGQs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 358491997F;
	Sun,  9 Nov 2014 13:47:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C075C1997D;
	Sun,  9 Nov 2014 13:47:43 -0500 (EST)
In-Reply-To: <545F540D.8010207@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sun, 09 Nov 2014 12:46:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E3DBB02E-6840-11E4-B236-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>>> strcpy() maybe?
>>=20
>> It was originally strcpy, then I wanted to get fancy and show Win3.1=
,
>> Win95... but it got complicated (couldn't just do it based on the la=
st
>> bit of 'v'). Will revert.
>>=20
> Why not use strlcpy() ?
> (This feels little like an overkill, but on the other hand it is safe=
 to use regardless
> how long the buf is, and it is a good example how to avoid "overrunni=
ng" code)

I actually think such a blind belief in strlcpy() is a disease.

Surely it will help you avoid overwriting other unrelated data after
the string buffer you are writing into, but it does not help you
very much to make sure what you wanted to place in the string buffer
all got recorded in that buffer, unless you remember to check its
return value to make sure it did not get truncated.  Otherwise, you
may be valuing other people's data, but you are not valuing your own
data sufficiently enough.

And if you (1) know how big your own buffer is, and (2) are checking
if your call to strlcpy() copied everything you wanted to copy, it
would not be more work to do it without strlcpy()---you need to know
how big a string you are copying into anyway if you care about your
own data to the same degree you care about other people's data ;-)
