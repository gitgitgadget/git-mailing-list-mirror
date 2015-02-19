From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] connect.c: Improve parsing of literal IPV6 addresses
Date: Thu, 19 Feb 2015 09:54:52 -0800
Message-ID: <xmqq386123df.fsf@gitster.dls.corp.google.com>
References: <54BD3D14.90309@web.de>
	<20150122200702.GA96498@vauxhall.crustytoothpaste.net>
	<54C17429.1090403@web.de>
	<20150122234117.GD96498@vauxhall.crustytoothpaste.net>
	<xmqqtwyj2hdk.fsf@gitster.dls.corp.google.com>
	<54E61285.5070600@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, lists@hcf.yourweb.de
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Feb 19 18:55:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOVJW-0001Na-8H
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 18:55:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbbBSRy6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Feb 2015 12:54:58 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58315 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751597AbbBSRy5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2015 12:54:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C55838198;
	Thu, 19 Feb 2015 12:54:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WEmmWcGk2YeE
	NLh2bCx/O5H/K58=; b=dmk6KduYXbZT2YmtU33tmQIx7jTXyBYIA3HKwmvfn/bb
	FWiUYGdzoMHdLg+azpB5jJ0n0NDRiGKlkGPJ3ggLsX54iI2/tX0FuucMCao4CLsQ
	Yuwz3U+KeqwOUeVBzza6WhTIdBrcVnKk461Ym8DwEQ2BCSL2fxMpoE6Y7cSKd1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oqzvnW
	48RmX0QsbuUlJt81veM+GhSzAARKh0o74qp02Sz6cRfOXNq9cL+NSZBAyUDaVazx
	tjv5LBsoGCAea6+TuStDmPTbaF2jt5yBPGcT83Vo8ysDG/ufwzcfcR8dO0jQaToP
	wxzIVLn1x9xCH5Qd7ItUVqwkQlzj11eeakq5c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9275C38196;
	Thu, 19 Feb 2015 12:54:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D0D9138195;
	Thu, 19 Feb 2015 12:54:54 -0500 (EST)
In-Reply-To: <54E61285.5070600@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Thu, 19 Feb 2015 17:42:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6929BFB8-B860-11E4-9782-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264106>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 02/18/2015 07:40 PM, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>
>>> I understand that this used to work, but it probably shouldn't have
>>> ever been accepted.  It's nonstandard, and if we accept it for ssh,
>>> people will want it to work for https, and due to libcurl, it simpl=
y
>>> won't.
>>>
>>> I prefer to see our past acceptance of this format as a bug.  This =
is
>>> the first that I've heard of anyone noticing this (since 2013), so =
it
>>> can't be in common usage.
>>>
>>> If we accept it, we should explicitly document it as being deprecat=
ed
>>> and note that it's inconsistent with the way everything else works.
>> I was reviewing my Undecided pile today, and I think your objection
>> makes sense.
>>
>> Either of you care to update documentation, please, before I drop
>> this series and forget about it?
>
> The URL RFC is much stricter regarding which characters that are allo=
wed
> in which part of the URL, as least as I read it.
> ...
> I'm somewhat unsure what to write in the documentation, I must admit.

I can see that you do not agree with the "If we accept it" part
(where "it" refers to "allowing [...] was a bug.")---past acceptance
was not a bug for you.

Brian is for that "If we accept it", and sees it as a bug.

So let's see what he comes up with as a follow-up to the "we should
explicitly document it" part.
