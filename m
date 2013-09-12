From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] relative_path should honor dos_drive_prefix
Date: Thu, 12 Sep 2013 08:48:15 -0700
Message-ID: <xmqqwqmmoxc0.fsf@gitster.dls.corp.google.com>
References: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com>
	<0688d5a5bd194ff5808c555e8e75132e2c687368.1378977052.git.worldhello.net@gmail.com>
	<5231CBFA.3070806@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Tvangeste <i.4m.l33t@yandex.ru>, Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 12 17:48:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK983-0003xs-0R
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 17:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130Ab3ILPsT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Sep 2013 11:48:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41111 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753070Ab3ILPsS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Sep 2013 11:48:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CCE441738;
	Thu, 12 Sep 2013 15:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9Nsqf6Re07Hb
	0gTGzedonf4nIvY=; b=SOr56x454gqybtOAzpftH9gd/G+KqM2sQ5JLRkqDZTyk
	WH7C8bYL0R2HDYzIdW6citZ014MbvvYzm93g8S/6xmKTph/6H3t89SL/9OH+a6b1
	aA1Z8uf6DShui87FOLvMAUJ4UPN8ZGPui3J8Fq0WgvZIUCwOqpIcbiuBpQHCCu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OKLabX
	pksZWwVq7oWIeStcHVWAuWGThN6ST8KdR+F8VQDdDx9OdtvVnTDasvnUEG0wZd80
	nM3ax5ZG2PoUXEKqZP0UeWRrlnp41PGOy4ZwaH5zjnWhs0XOqzv7xXlTBR4bp6E+
	IDjYPx1fo/+x6mFQV6iX1v5sAp/Vg6dLGAxDY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2243941737;
	Thu, 12 Sep 2013 15:48:18 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C7BD41730;
	Thu, 12 Sep 2013 15:48:17 +0000 (UTC)
In-Reply-To: <5231CBFA.3070806@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Thu, 12 Sep 2013 16:13:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BDEB9E54-1BC2-11E3-93B0-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234659>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> +static int have_same_root(const char *path1, const char *path2)
>> +{
>> +	int is_abs1, is_abs2;
>> +
>> +	is_abs1 =3D is_absolute_path(path1);
>> +	is_abs2 =3D is_absolute_path(path2);
>> +	return (is_abs1 && is_abs2 && !strncasecmp(path1, path2, 1)) ||
>                                        ^^^^^^^^^^^
> I wonder: should strncasecmp() be replaced with strncmp_icase() ?

True.

> See dir.c:=20
> int strncmp_icase(const char *a, const char *b, size_t count)
> {
> 	return ignore_case ? strncasecmp(a, b, count) : strncmp(a, b, count)=
;
> }
