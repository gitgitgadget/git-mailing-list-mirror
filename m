From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/9] connect: document why we sometimes call get_port after get_host_and_port
Date: Mon, 23 May 2016 14:30:57 -0700
Message-ID: <xmqqwpmk797y.fsf@gitster.mtv.corp.google.com>
References: <20160521231732.4888-1-mh@glandium.org>
	<20160521231732.4888-2-mh@glandium.org>
	<399331a6-dadb-c318-b0e0-c83e0f81ecb0@web.de>
	<20160522080316.GA19790@glandium.org> <574287B9.4090307@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon May 23 23:31:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4xRN-0005Ua-AA
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 23:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbcEWVbF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2016 17:31:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63032 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752176AbcEWVbD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2016 17:31:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 96A061CB2E;
	Mon, 23 May 2016 17:31:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=B79GpbuYoAKV
	3V+nAspBehDK7ZU=; b=PKGWX1ofP2qjrUywVzxk1eY26xDPvirBTYfcw7zXZFU9
	3Uxhp8LOiqnZPcdvXMWiasmBraj6odn6/L/kkxBCQTOLvm5t/6D/mSIPqzUwh2Ot
	Xj2UTurK/CKDpKfkXv3Fim6WRAFsXhXMmCm7VdIDfq7CJ30CfG1nuTuG3ustn+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=o5ydMO
	1lC8jpCiK5df08IoyN+oS15e72hZ3tHPRZYPJyMH94H3ezOXbHjH7D4cHtL/UKiZ
	9v+LgrRsSqiuP9lq3y5qhxaRKzxgDTl02OPHlvkEeJuqsX8o3ZQ4wyw0huq33+JL
	BXhXg6fvPf5BTDaBdNqRqwuZZEll3/oydZnlA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D89D1CB2D;
	Mon, 23 May 2016 17:31:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A71AC1CB2B;
	Mon, 23 May 2016 17:31:00 -0400 (EDT)
In-Reply-To: <574287B9.4090307@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Mon, 23 May 2016 06:31:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A501F1D6-212D-11E6-B22E-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295396>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>>>>   			get_host_and_port(&ssh_host, &port);
>>>>   +			/* get_host_and_port may not return a port
>>>> even when
>>>> +			 * there is one: In the [host:port]:path case,
>>>> +			 * get_host_and_port is called with "[host:port]" and
>>>> +			 * returns "host:port" and NULL.
>>>> +			 * In that specific case, we still need to split the
>>>> +			 * port. */
>>> Is it worth to mention that this case is "still supported legacy" ?
>> If it's worth mentioning anywhere, it seems to me it would start wit=
h
>> urls.txt?
>>
>> Mike
>>
> I don't know.
> urls.txt is for Git users, and connect.c is for Git developers.
> urls.txt does not mention that Git follows any RFC when parsing the
> URLS', it doesn't claim to be 100% compliant.
> Even if it makes sense to do so, as many user simply expect Git to ac=
cept
> RFC compliant URL's, and it makes the development easier, if there is
> an already
> written specification, that describes all the details.
> The parser is not 100% RFC compliant, one example:
> - old-style usgage like "git clone [host:222]:~/path/to/repo are supp=
orted

Is it an option to fix get_host_and_port() so that it returns what
the caller expects even when it is given "[host:port]"?  When the
caller passes other forms like "host:port", it expects to get "host"
and "port" parsed out into two variables.  Why can't the caller
expect to see the same happen when feeding "[host:port]" to the
function?
