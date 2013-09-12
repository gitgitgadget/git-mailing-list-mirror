From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] relative_path should honor dos_drive_prefix
Date: Thu, 12 Sep 2013 12:11:15 -0700
Message-ID: <xmqq8uz1q2i4.fsf@gitster.dls.corp.google.com>
References: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com>
	<0688d5a5bd194ff5808c555e8e75132e2c687368.1378977052.git.worldhello.net@gmail.com>
	<5231CBFA.3070806@web.de> <5231F839.3080208@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Tvangeste <i.4m.l33t@yandex.ru>,
	Karsten Blees <karsten.blees@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Sep 12 21:11:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKCIW-0002PR-8r
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 21:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403Ab3ILTLU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Sep 2013 15:11:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49792 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752208Ab3ILTLT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Sep 2013 15:11:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61FA141D1A;
	Thu, 12 Sep 2013 19:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cqa5U+P33hFd
	48D5VG+8E8n/kCs=; b=YhOHdLma4Xpwm8p2ce+Us95GuhQsL9KMh7MZW1KXbCc3
	ggiK64jHf0XRpL9m6vMOJpWZBYzzzGFA4vI+KYTuPVBFBZKDionr7Mp4qQ3dFO02
	Pif0juIwJWlnHScxFeIA+dQT5XqBC1+Im67RuznZTxHVvcHl+NwCUtKyV0ILSYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=H10cnl
	/+kotlQGLy2uU9A40OxcFBcJ8DY7CMZfgZfkoVyDFsuibg9ub/zIUZ3zAU3eYlc5
	7x3+No4qA3ja4B4tsY2prmzHzkOrh6AfXGjuTcNjF3HjEWtFpEsg9mebscbVPDuO
	8tUjgJXARtyP7ukNhdFKrgRNze0paKBBe6DR4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55C1F41D18;
	Thu, 12 Sep 2013 19:11:18 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6FF641D15;
	Thu, 12 Sep 2013 19:11:17 +0000 (UTC)
In-Reply-To: <5231F839.3080208@kdbg.org> (Johannes Sixt's message of "Thu, 12
	Sep 2013 19:22:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 19E91CB0-1BDF-11E3-84D8-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234674>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 12.09.2013 16:13, schrieb Torsten B=C3=B6gershausen:
>> On 2013-09-12 11.12, Jiang Xin wrote:
>>> +static int have_same_root(const char *path1, const char *path2)
>>> +{
>>> +	int is_abs1, is_abs2;
>>> +
>>> +	is_abs1 =3D is_absolute_path(path1);
>>> +	is_abs2 =3D is_absolute_path(path2);
>>> +	return (is_abs1 && is_abs2 && !strncasecmp(path1, path2, 1)) ||
>>                                        ^^^^^^^^^^^
>> I wonder: should strncasecmp() be replaced with strncmp_icase() ?
>
> I don't think so: On POSIX, it is irrelevant, because the call will o=
nly
> compare a slash to a slash. On Windows, it compares the drive letters
> (or a slash); it is *always* case-insensitive, even if the volume
> mounted is NTFS with case-sensitivity enabled and core.ignorecase is =
false.

Ah, you are right, of course.  We could even do

	tolower(path1[0]) =3D=3D tolower(path2[0])

which might be more explicit.

=46or systems that need POSIX escape hatch for Apollo Domain ;-), we
would need a bit more work.  When both path1 and path2 begin with a
double-dash, we would need to check if they match up to the next
slash, so that

 - //host1/usr/src and //host1/usr/lib share the same root and the
   former can be made to ../src relative to the latter;

 - //host1/usr/src and //host2/usr/lib are of separate roots.

or something.
